/************************************************************************/
/*      Archivo:                def_campos.sp                           */
/*      Stored procedure:       sp_def_campos                           */
/*      Base de datos:          cobis                                   */
/*      Producto:               CLIENTES                                */
/*      Disenado por:           Nydia Velasco/William Hernandez         */
/*      Fecha de escritura:     12-Mar-97                               */
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
/*    12-Mar-97       N.velasco        Emision Inicial                  */
/*    12-Mar-97       W.hernandez      Emision Inicial                  */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN                */
/************************************************************************/

use cobis
go

if exists (select
             *
           from   sysobjects
           where  name = 'sp_def_campos')
  drop proc sp_def_campos
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_def_campos
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
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1) = null,
  @i_grupo        catalogo = null,
  @i_codtbl       smallint = null,
  @i_codatr       tinyint = null,
  @i_descatr      descripcion = null,
  @i_manda        char(1) = null,
  @i_codvlr       smallint = null,
  @i_descvlr      descripcion = null
)
as
  declare
    @w_siguiente tinyint,
    @w_sp_name   varchar(32),
    @w_codigo    int,
    @o_siguiente int

  select
    @w_sp_name = 'sp_def_campos'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*  Insercion de atributo de Mercadeo  */
  if @i_operacion = 'I'
  begin
    if @t_trn = 1326
    begin
      if @i_manda is not null
      begin
        /* obtener un secuencial para el nuevo campo */
        exec cobis..sp_cseqnos
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_tabla     = 'cl_atr_tbl_inf',
          @o_siguiente = @w_codigo out

        insert into cl_atr_tbl_inf
                    (ai_grp_inf,ai_cod_tbl_inf,ai_cod_atrib,ai_desc_atrib,
                     ai_mandat_atrib)
        values      (@i_grupo,@i_codtbl,@w_codigo,@i_descatr,@i_manda)
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103087
          /*'Error en insercion de campo'*/
          return 1
        end
        /* retorna el siguiente secuencial para el campo */
        select
          @w_codigo
        return 0
      end
      else
      begin
        /* obtener un secuencial para el nuevo valor del  campo */
        exec cobis..sp_cseqnos
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_tabla     = 'cl_atr_valores',
          @o_siguiente = @w_codigo out

        insert into cl_atr_valores
                    (av_grp_inf,av_cod_tbl_inf,av_cod_atrib,av_cod_vlr,
                     av_desc_vlr
        )
        values      (@i_grupo,@i_codtbl,@i_codatr,@w_codigo,@i_descvlr)
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103088
          /*'Error en insercion de valores'*/
          return 1
        end
        select
          @w_codigo
        return 0
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

  /*  Borrar atributo de Mercadeo  */
  if @i_operacion = 'D'
  begin
    if @t_trn = 1330
    begin
      if @i_manda <> '1'
          or @i_manda is null
      begin
        begin tran
        delete from cl_atr_tbl_inf
        where  ai_grp_inf     = @i_grupo
           and ai_cod_tbl_inf = @i_codtbl
           and ai_cod_atrib   = @i_codatr

        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107072
          /*'Error en actualizacion de atributo'*/
          return 1
        end
        delete from cl_atr_valores
        where  av_grp_inf     = @i_grupo
           and av_cod_tbl_inf = @i_codtbl
           and av_cod_atrib   = @i_codatr
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107072
          /*'Error en actualizacion de campo'*/
          return 1
        end
        commit tran
        return 0
      end
      else
      begin
        /*  Borrar valor unicamente   */
        delete from cl_atr_valores
        where  av_grp_inf     = @i_grupo
           and av_cod_tbl_inf = @i_codtbl
           and av_cod_atrib   = @i_codatr
           and av_cod_vlr     = @i_codvlr
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107073
          /*'Error en actualizacion de valores'*/
          return 1
        end
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

  /*  Actualizacion de atributo de Mercadeo  */
  if @i_operacion = 'U'
  begin
    if @t_trn = 1327
    begin
      if @i_manda <> '1'
          or @i_manda is null
      begin
        update cl_atr_tbl_inf
        set    ai_desc_atrib = @i_descatr,
               ai_mandat_atrib = @i_manda
        where  ai_grp_inf     = @i_grupo
           and ai_cod_tbl_inf = @i_codtbl
           and ai_cod_atrib   = @i_codatr
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105077
          /*'Error en actualizacion de campos'*/
          return 1
        end
        return 0
      end
      else
      begin
        /*  Actualizar valores de campo */
        update cl_atr_valores
        set    av_desc_vlr = @i_descvlr
        where  av_grp_inf     = @i_grupo
           and av_cod_tbl_inf = @i_codtbl
           and av_cod_atrib   = @i_codatr
           and av_cod_vlr     = @i_codvlr
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105078
          /*'Error en actualizacion de valores'*/
          return 1
        end
        return 0
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
    if @i_manda <> '1'
        or @i_manda is null
    begin
      if @t_trn = 1329
      begin
        select
          ai_desc_atrib,
          ai_mandat_atrib
        from   cl_atr_tbl_inf
        where  ai_grp_inf     = @i_grupo
           and ai_cod_tbl_inf = @i_codtbl
           and ai_cod_atrib   = @i_codatr
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101182
          /* 'No existen campos de mercadeo' */
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
    else
    begin
      /* Escoger un valor de campo  */
      select
        av_desc_vlr,
        av_cod_vlr
      from   cl_atr_valores
      where  av_grp_inf     = @i_grupo
         and av_cod_tbl_inf = @i_codtbl
         and av_cod_atrib   = @i_codatr
         and av_cod_vlr     = @i_codvlr
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101184
        /* 'No existen valores de mercadeo' */
        return 1
      end
    end
  end

  /*  Busqueda de atributos de Mercadeo  */
  if @i_operacion = 'S'
  begin
    if @t_trn = 1328
    begin
      if @i_manda <> '1'
          or @i_manda is null
      /* para buscar Posibles Vlr de Un Campo y no de Tabla*/
      begin
        select
          'Codigo' = ai_cod_atrib,
          'Nombre' = ai_desc_atrib
        from   cl_atr_tbl_inf
        where  ai_grp_inf     = @i_grupo
           and ai_cod_tbl_inf = @i_codtbl
        order  by ai_cod_atrib
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101059
          /* 'No existen datos de perfil' */
          return 1
        end
      end
      else
      begin
        select
          'Codigo' = av_cod_vlr,
          'Nombre' = av_desc_vlr
        from   cl_atr_valores
        where  av_grp_inf     = @i_grupo
           and av_cod_tbl_inf = @i_codtbl
           and av_cod_atrib   = @i_codatr
        order  by av_cod_vlr
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101059
          /* 'No existen datos de perfil' */
          return 1
        end
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
  return 0

go

