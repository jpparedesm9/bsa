/************************************************************************/
/*   Archivo:          def_tablas.sp                                    */
/*   Stored procedure:   sp_def_tablas                                  */
/*   Base de datos:      cobis                                          */
/*   Producto:           Clientes                                       */
/*   Disenado por:           NVelasco/WHernandez                        */
/*   Fecha de escritura:      23-Jul-1993                               */
/************************************************************************/
/*                  IMPORTANTE                                          */
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
/*                  PROPOSITO                                           */
/*   Permite realizar operaciones DML en la tabla cl_relacion,          */
/*   que es la tabla que contiene la descripcion de las relaciones      */
/*   genericas que pueden mantener dos instancias de cl_ente.           */
/*      Consultas de relacion                                           */
/************************************************************************/
/*                  MODIFICACIONES                                      */
/*   FECHA          AUTOR          RAZON                                */
/*   11-Mar-1997    nvr-wh         Emision inicial                      */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/
use cobis
go

if exists (select
             *
           from   sysobjects
           where  name = 'sp_def_tablas')
  drop proc sp_def_tablas
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_def_tablas
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
  @t_debug        char (1) = 'N',
  @t_file         varchar (14) = null,
  @t_from         varchar (30) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char (1),
  @i_modo         tinyint = null,
  @i_tipo         char (1) = null,
  @i_grupo        catalogo = null,
  @i_codigo       smallint = null,
  @i_descripcion  varchar(90) = null
)
as
  declare
    @w_sp_name      varchar (30),
    @w_return       int,
    @w_codigo       int,
    @w_descripcion  descripcion,
    @w_izquierda    descripcion,
    @w_derecha      descripcion,
    @w_desc_tbl_inf varchar(90),
    @v_descripcion  descripcion,
    @v_izquierda    descripcion,
    @v_derecha      descripcion,
    @w_sdate        datetime

  /*  Captura nombre del Stored Procedure  */
  select
    @w_sp_name = 'sp_def_tablas'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_sdate = getdate()

  /*  Insert  */
  if @i_operacion = 'I'
  begin
    if @t_trn = 1322
    begin
      begin tran

      /* obtener un secuencial para la nueva tabla de Marketing */
      exec cobis..sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_tbl_inf',
        @o_siguiente = @w_codigo out

      /* insertar la nueva tabla mercadeo */
      insert into cl_tbl_inf
                  (ti_grp_inf,ti_cod_tbl_inf,ti_desc_tbl_inf)
      values      (@i_grupo,@w_codigo,@i_descripcion)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        /*  Error en creacion de relacion  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103086
        return 1

      end

      /*  Transaccion de Servicio  */
      insert into ts_def_tablas
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,grp_inf,cod_tbl_inf,
                   desc_tbl_inf)
      values      (@s_ssn,@t_trn,'N',@w_sdate,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_grupo,@w_codigo,
                   @i_descripcion)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        /*  Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103086
        return 1
      end
      commit tran

      /* retorna el siguiente secuencial para la relacion */
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
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

  /*  Update  */
  if @i_operacion = 'U'
  begin
    if @t_trn = 1323
    begin
      /* Verificar que exista la relacion */
      select
        @w_descripcion = ti_desc_tbl_inf
      from   cl_tbl_inf
      where  ti_cod_tbl_inf = @i_codigo

      /* si no existe la relacion, error */
      if @@rowcount = 0
      begin
        /*  No existe relacion  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 105076
        return 1
      end

      /* guardar los datos anteriores */
      select
        @v_descripcion = @w_descripcion

      if @w_descripcion = @i_descripcion
        select
          @w_descripcion = null,
          @v_descripcion = null
      else
        select
          @w_descripcion = @i_descripcion

      begin tran
      /* modificar los datos */
      update cl_tbl_inf
      set    ti_desc_tbl_inf = @i_descripcion
      where  ti_cod_tbl_inf = @i_codigo

      /* si no se puede modificar, error */
      if @@rowcount = 0
      begin
        /*  Error en actualizacion de Tabla de Mercadeo */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 105076
        return 1
      end

      /*  Transaccion de Servicio  */
      insert into ts_def_tablas
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,grp_inf,cod_tbl_inf,
                   desc_tbl_inf)
      values      (@s_ssn,@t_trn,'P',@w_sdate,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_grupo,@i_codigo,
                   @v_descripcion)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        /*   Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103086
        return 1
      end

      /*  Transaccion de Servicio  */
      insert into ts_def_tablas
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,grp_inf,cod_tbl_inf,
                   desc_tbl_inf)
      values      (@s_ssn,@t_trn,'A',@w_sdate,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_grupo,@i_codigo,
                   @w_descripcion)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        /*   Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103086
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
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

  /*  Delete  */
  if @i_operacion = 'D'
  begin
    if @t_trn = 1331
    begin
      begin tran

      if exists (select
                   *
                 from   cl_atr_tbl_inf
                 where  ai_grp_inf     = @i_grupo
                    and ai_cod_tbl_inf = @i_codigo)
        select
          0
      else
        /*Datos para transaccions de servicio*/

        select
          @w_desc_tbl_inf = ti_desc_tbl_inf
        from   cl_tbl_inf
        where  ti_grp_inf     = @i_grupo
           and ti_cod_tbl_inf = @i_codigo

      begin
        /* borrar la relacion */
        delete cl_tbl_inf
        where  ti_grp_inf     = @i_grupo
           and ti_cod_tbl_inf = @i_codigo
        select
          1
      end

      /* si no se puede borrar, error */
      if @@error <> 0
      begin
        /*  No existe relacion  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 107055
        return 1
      end

      /*  Transaccion de Servicio  */
      insert into ts_def_tablas
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,grp_inf,cod_tbl_inf,
                   desc_tbl_inf)
      values      (@s_ssn,@t_trn,'B',@w_sdate,@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_grupo,@i_codigo,
                   @w_desc_tbl_inf)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        /*   Error en creacion de transaccion de servicio  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 103086
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
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

/*  Search  */
  /* Encontrar todas las relaciones definidas */
  if @i_operacion = 'S'
  begin
    if @t_trn = 1325
    begin
      set rowcount 20
      if @i_modo = 0
        select
          'Codigo' = ti_cod_tbl_inf,
          'Descripcion' = ti_desc_tbl_inf
        from   cl_tbl_inf
        where  ti_grp_inf = @i_grupo
        order  by ti_cod_tbl_inf
      if @i_modo = 1
        select
          'Codigo' = ti_cod_tbl_inf,
          'Descripcion' = ti_desc_tbl_inf
        from   cl_tbl_inf
        where  ti_grp_inf     = @i_grupo
           and ti_cod_tbl_inf > @i_codigo
        order  by ti_cod_tbl_inf
      set rowcount 0
      return 0

    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

/*  Query  */
  /* encontrar Una Tabla de Mercadeo*/
  if @i_operacion = 'Q'
  begin
    if @t_trn = 1324
    begin
      select
        ti_cod_tbl_inf,
        ti_desc_tbl_inf
      from   cl_tbl_inf
      where  ti_grp_inf     = @i_grupo
         and ti_cod_tbl_inf = @i_codigo

      /* si no existen datos, error */
      if @@rowcount = 0
      begin
        /*  No existe relacion  */
        exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file = @t_file,
          @t_from = @w_sp_name,
          @i_num  = 101181
      end
      return 0

    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

go

