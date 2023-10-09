/************************************************************************/
/*      Archivo:                dat_mercadeo.sp                         */
/*      Stored procedure:       sp_dat_mercadeo                         */
/*      Base de datos:          cobis                                   */
/*      Producto:               CLIENTES                                */
/*      Disenado por:           Nydia Velasco/William Hernandez         */
/*      Fecha de escritura:     14-Mar-97                               */
/************************************************************************/
/*                            IMPORTANTE                                */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                             PROPOSITO                                */
/*    Este programa procesa las transacciones del stored procedure      */
/*         Insercion de         cl_atr_tbl_inf                          */
/*         Modificacion de      cl_atr_tbl_inf                          */
/*         Borrado de           cl_atr_tbl_inf                          */
/*         Busqueda de          cl_atr_tbl_inf                          */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*    FECHA           AUTOR            RAZON                            */
/*    14-Mar-97       N.velasco        Emision Inicial                  */
/*    14-Mar-97       W.hernandez      Emision Inicial                  */
/*    09-Jul-2001     E. Laguna        Calculo porcentajes              */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN                */
/************************************************************************/

use cobis
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_dat_mercadeo')
  drop proc sp_dat_mercadeo
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_dat_mercadeo
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,

  --      @t_trn              smallint    = null,
  @t_trn          int = null,
  @t_show_version bit = 0,
  @i_ente         int = null,
  @i_operacion    char(1) = null,
  @i_grupo        catalogo = null,
  @i_codtbl       smallint = null,
  @i_codatr       tinyint = null,
  @i_descatr      descripcion = null,
  @i_manda        char(1) = null,
  @i_codvlr       smallint = null,
  @i_codvlr_nuevo smallint = null,
  @i_descvlr      descripcion = null
)
as
  declare
    @w_siguiente tinyint,
    @w_sp_name   varchar(32),
    @w_codigo    int,
    @w_fecha     datetime,
    @w_total     int

  select
    @w_sp_name = 'sp_dat_mercadeo'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*  Insercion de Datos de Mercadeo para un Cliente */
  if @i_operacion = 'I'
  begin
    if @t_trn = 1332
    begin
      /* verificar que no exista ese registro*/
      select
        dm_ente
      from   cl_dat_merc_ente
      where  dm_cod_tbl_inf   = @i_codtbl
         and dm_cod_atrib_inf = @i_codatr
         and dm_cod_vlr       = @i_codvlr
         and dm_ente          = @i_ente

      /* si  existe registro, error */
      if @@rowcount <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101186
        /* 'Ya existe registro'*/
        return 1
      end

      begin tran

      /* obtener un secuencial para el nuevo campo */
      insert into cl_dat_merc_ente
                  (dm_ente,dm_grp_inf,dm_cod_tbl_inf,dm_cod_atrib_inf,dm_cod_vlr
                   ,
                   dm_fecha)
      values      (@i_ente,@i_grupo,@i_codtbl,@i_codatr,@i_codvlr,
                   getdate())
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103089
        /*'Error en insercion de datos de mercadeo'*/
        return 1
      end

      /*  Transaccion de Servicio  */
      insert into ts_dat_merc_ente
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,grp_inf,
                   cod_tbl_inf,cod_atrib_inf,cod_vlr,fecha2)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_grupo,
                   @i_codtbl,@i_codatr,@i_codvlr,getdate())

      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end
      commit tran
      /* retorna el siguiente secuencial para el campo */
      select
        @w_codigo
      return 0
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101183
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

  /*  Actualizacion de datos de Mercadeo de un Cliente  */
  if @i_operacion = 'U'
  begin
    if @t_trn = 1333
    begin
      /* Datos para transaccion de servicio */
      select
        @w_fecha = dm_fecha
      from   cl_dat_merc_ente
      where  dm_ente          = @i_ente
         and dm_grp_inf       = @i_grupo
         and dm_cod_tbl_inf   = @i_codtbl
         and dm_cod_atrib_inf = @i_codatr
         and dm_cod_vlr       = @i_codvlr

      /*  Actualizar valores de campo */
      begin tran
      update cl_dat_merc_ente
      set    dm_cod_tbl_inf = @i_codtbl,
             dm_cod_atrib_inf = @i_codatr,
             dm_cod_vlr = @i_codvlr_nuevo
      where  dm_ente          = @i_ente
         and dm_grp_inf       = @i_grupo
         and dm_cod_tbl_inf   = @i_codtbl
         and dm_cod_atrib_inf = @i_codatr
         and dm_cod_vlr       = @i_codvlr
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105079
        /*'Error en actualizacion de datos de mercadeo'*/
        return 1
      end

      /*  Transaccion de Servicio Registro Previo */
      insert into ts_dat_merc_ente
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,grp_inf,
                   cod_tbl_inf,cod_atrib_inf,cod_vlr,fecha2)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_grupo,
                   @i_codtbl,@i_codatr,@i_codvlr,@w_fecha)

      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end

      /*  Transaccion de Servicio Registro Actual */
      insert into ts_dat_merc_ente
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,grp_inf,
                   cod_tbl_inf,cod_atrib_inf,cod_vlr,fecha2)
      values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_grupo,
                   @i_codtbl,@i_codatr,@i_codvlr_nuevo,@w_fecha)

      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end
      commit tran
      return 0
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101183
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

  /*  Borrar datos de Mercadeo de un CLiente */
  if @i_operacion = 'D'
  begin
    if @t_trn = 1334
    begin
      /*Datos para transacción de servicio*/
      select
        @w_fecha = dm_fecha
      from   cl_dat_merc_ente
      where  dm_grp_inf       = @i_grupo
         and dm_cod_tbl_inf   = @i_codtbl
         and dm_cod_atrib_inf = @i_codatr
         and dm_cod_vlr       = @i_codvlr
         and dm_ente          = @i_ente

      /*  Borrar valor unicamente   */
      delete from cl_dat_merc_ente
      where  dm_grp_inf       = @i_grupo
         and dm_cod_tbl_inf   = @i_codtbl
         and dm_cod_atrib_inf = @i_codatr
         and dm_cod_vlr       = @i_codvlr
         and dm_ente          = @i_ente

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107072
        /*'Error en eliminacion de datos de mercadeo'*/
        return 1
      end

      /*  Transaccion de Servicio  */
      insert into ts_dat_merc_ente
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,grp_inf,
                   cod_tbl_inf,cod_atrib_inf,cod_vlr,fecha2)
      values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_grupo,
                   @i_codtbl,@i_codatr,@i_codvlr,@w_fecha)

      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103005
        return 1
      end
    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101183
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

  /*  Escoger atributos de Mercadeo  */
  if @i_operacion = 'Q'
  begin
    if @t_trn = 1336
    begin
      if @i_codvlr is not null
        /* Escoger un valor de campo  */
        select
          dm_cod_tbl_inf,
          dm_cod_atrib_inf,
          dm_cod_vlr
        from   cl_dat_merc_ente
        where  dm_grp_inf       = @i_grupo
           and dm_cod_tbl_inf   = @i_codtbl
           and dm_cod_atrib_inf = @i_codatr
           and dm_cod_vlr       = @i_codvlr
      else
      begin
        create table #datos
        (
          codigo      smallint null,
          descripcion varchar(60) null,
          clientes    int null
        )

        insert into #datos
          select
            dm_cod_vlr,av_desc_vlr,count(dm_cod_vlr)
          from   cl_dat_merc_ente,
                 cl_atr_valores
          where  dm_grp_inf       = @i_grupo
             and dm_cod_tbl_inf   = @i_codtbl
             and dm_cod_atrib_inf = @i_codatr
             and av_cod_vlr       = dm_cod_vlr
          group  by dm_cod_vlr,
                    av_desc_vlr

        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101185
          /* 'No existen datos de mercadeo' */
          return 1
        end

        select
          @w_total = sum(clientes)
        from   #datos

        select
          'CODIGO      ' = codigo,
          'DESCRIPCION ' = descripcion,
          'Nro.CLIENTES' = clientes,
          'PORCENTAJES ' = round((convert(float, clientes) /
                                  convert(float, @w_total))
                           ,
                                 2)
        from   #datos

        select
          'Nro.CLIENTES' = @w_total
      end
    end
  end

  /*  Busqueda de atributos de Mercadeo  */
  if @i_operacion = 'S'
  begin
    if @t_trn = 1335
    begin
      select
        ti_cod_tbl_inf,
        TABLA=ti_desc_tbl_inf,
        ai_cod_atrib,
        CAMPO=ai_desc_atrib,
        av_cod_vlr,
        VALOR=av_desc_vlr
      from   cl_dat_merc_ente a,
             cl_tbl_inf b,
             cl_atr_tbl_inf c,
             cl_atr_valores d
      where  a.dm_grp_inf     = @i_grupo
         and a.dm_ente        = @i_ente
         and a.dm_grp_inf     = b.ti_grp_inf
         and a.dm_cod_tbl_inf = b.ti_cod_tbl_inf
         and a.dm_cod_tbl_inf = b.ti_cod_tbl_inf
         and c.ai_grp_inf     = b.ti_grp_inf
         and c.ai_cod_tbl_inf = a.dm_cod_tbl_inf
         and c.ai_cod_atrib   = a.dm_cod_atrib_inf
         and d.av_cod_vlr     = a.dm_cod_vlr
      order  by a.dm_cod_tbl_inf,
                a.dm_cod_atrib_inf

      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101185
        /* 'No existen datos de mercadeo' */
        return 1
      end

    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101183
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

go

