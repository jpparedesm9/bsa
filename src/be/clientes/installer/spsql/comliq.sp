/************************************************************************/
/*  Archivo:            comliq.sp                                       */
/*  Stored procedure:   sp_liquidacion_dml                              */
/*  Base de datos:      cobis                                           */
/*  Producto:       Clientes                                            */
/*  Disenado por:   Sandra Ortiz M.                                     */
/*  Fecha de escritura: 12-May-1995                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*  Este stored procedure procesa:                                      */
/*  Insert y Update de datos de companias en liquidacion                */
/*  Query de nombre completo de persona                                 */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  12-May-95  S.Ortiz       Emision Inicial                            */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/
use cobis
go

if exists (select
             *
           from   sysobjects
           where  name = 'sp_liquidacion_dml')
  drop proc sp_liquidacion_dml
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_liquidacion_dml
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
  @i_operacion    char(1),
  @i_modo         tinyint = null,
  @i_codigo       int = null,
  @i_nombre       descripcion = null,
  @i_tipo         char(1) = 'N',
  @i_problema     catalogo = null,
  @i_referencia   descripcion = null,
  @i_ced_ruc      numero = null,
  @i_fecha        datetime = null
)
as
  declare
    @w_sp_name    varchar(32),
    @w_return     int,
    @w_codigo     int,
    @w_nombre     descripcion,
    @w_tipo       catalogo,
    @w_problema   catalogo,
    @w_referencia catalogo,
    @w_ced_ruc    numero,
    @w_fecha      datetime,
    @w_siguiente  int,
    @v_codigo     int,
    @v_nombre     descripcion,
    @v_tipo       catalogo,
    @v_problema   catalogo,
    @v_referencia catalogo,
    @v_ced_ruc    numero,
    @v_fecha      datetime

  select
    @w_sp_name = 'sp_liquidacion_dml'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      '/** Stored Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_user = @s_user,
      s_term = @s_term,
      s_date = @s_date,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      s_org = @s_org,
      t_trn = @t_trn,
      t_file = @t_file,
      t_from = @t_from,
      i_operacion = @i_operacion,
      i_modo = @i_modo,
      i_codigo = @i_codigo,
      i_nombre = @i_nombre,
      i_tipo = @i_tipo,
      i_problema = @i_problema,
      i_referencia = @i_referencia,
      i_ced_ruc = @i_ced_ruc,
      i_fecha = @i_fecha
    exec cobis..sp_end_debug
  end

  /* Insert */
  if @i_operacion = 'I'
  begin
    begin tran
    if @t_trn = 1270
    begin
      select
        @w_siguiente = siguiente + 1
      from   cl_seqnos
      where  tabla = 'cl_com_liquidacion'

      /* Insertar un nuevo registro */
      insert into cl_com_liquidacion
                  (cl_codigo,cl_nombre,cl_tipo,cl_problema,cl_referencia,
                   cl_ced_ruc,cl_fecha)
      values      (@w_siguiente,@i_nombre,@i_tipo,@i_problema,@i_referencia,
                   @i_ced_ruc,@i_fecha)
      /* Si no se puede insertar enviar error*/
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 903001
        return 1
      end

      /*  Actualiza contador actual en seqnos  */
      update cl_seqnos
      set    siguiente = @w_siguiente
      where  tabla = 'cl_com_liquidacion'

      /*Transaccion de Servicio*/
      insert into ts_cia_liquidacion
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,codigo,nombre,
                   tipo,problema,referencia,ced_ruc,fecha_reg)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_codigo,@i_nombre,
                   @i_tipo,@i_problema,@i_referencia,@i_ced_ruc,@i_fecha)

      /* Si no puede insertar , enviar el error*/
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        return 1
      end
      commit tran
      select
        @w_siguiente
    end
    else
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

  /* Update */
  if @i_operacion = 'U'
  begin
    if @t_trn <> 1271
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

    /* Seleccionar campos de la tabla */
    select
      @w_codigo = cl_codigo,
      @w_nombre = cl_nombre,
      @w_tipo = cl_tipo,
      @w_problema = cl_problema,
      @w_referencia = cl_referencia,
      @w_ced_ruc = cl_ced_ruc,
      @w_fecha = cl_fecha
    from   cl_com_liquidacion
    where  cl_codigo = @i_codigo

    if @@rowcount = 0
    begin
      /* No existe dato solicitado */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 901001
      return 1
    end

    select
      @v_codigo = @w_codigo,
      @v_ced_ruc = @w_ced_ruc,
      @v_nombre = @w_nombre,
      @v_tipo = @w_tipo,
      @v_problema = @w_problema,
      @v_referencia = @w_referencia,
      @v_fecha = @w_fecha

    if @w_codigo = @i_codigo
      select
        @w_codigo = null,
        @v_codigo = null
    else
      select
        @w_codigo = @i_codigo

    if @w_ced_ruc = @i_ced_ruc
      select
        @w_ced_ruc = null,
        @v_ced_ruc = null
    else
      select
        @w_ced_ruc = @i_ced_ruc

    if @w_nombre = @i_nombre
      select
        @w_nombre = null,
        @v_nombre = null
    else
      select
        @w_nombre = @i_nombre

    if @w_tipo = @i_tipo
      select
        @w_tipo = null,
        @v_tipo = null
    else
      select
        @w_tipo = @i_tipo

    if @w_problema = @i_problema
      select
        @w_problema = null,
        @v_problema = null
    else
      select
        @w_problema = @i_problema

    if @w_referencia = @i_referencia
      select
        @w_referencia = null,
        @v_referencia = null
    else
      select
        @w_referencia = @i_referencia

    if @w_fecha = @i_fecha
      select
        @w_fecha = null,
        @v_fecha = null
    else
      select
        @w_fecha = @i_fecha

    begin tran
    /* Actualizar el registro */
    update cl_com_liquidacion
    set    cl_codigo = @i_codigo,
           cl_nombre = @i_nombre,
           cl_tipo = @i_tipo,
           cl_problema = @i_problema,
           cl_referencia = @i_referencia,
           cl_ced_ruc = @i_ced_ruc,
           cl_fecha = @i_fecha
    where  cl_codigo = @i_codigo
    if @@rowcount <> 1
    begin
      /* Error en actualizacion de registro covinco*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105071
      return 1
    end

    /*transaccion de servicios (registro previo)*/
    insert into ts_cia_liquidacion
                (secuencial,tipo_transaccion,clase,fecha,usuario,
                 terminal,srv,lsrv,codigo,nombre,
                 tipo,problema,referencia,ced_ruc,fecha_reg)
    values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                 @s_term,@s_srv,@s_lsrv,@v_codigo,@v_nombre,
                 @v_tipo,@v_problema,@v_referencia,@v_ced_ruc,@v_fecha)
    if @@error <> 0
    begin
      /* Error en creacion de transaccion de servicios  covinco*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103005
      return 1
    end

    /*transaccion de servicios (registro actual)*/
    insert into ts_cia_liquidacion
                (secuencial,tipo_transaccion,clase,fecha,usuario,
                 terminal,srv,lsrv,codigo,nombre,
                 tipo,problema,referencia,ced_ruc,fecha_reg)
    values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                 @s_term,@s_srv,@s_lsrv,@w_codigo,@w_nombre,
                 @w_tipo,@w_problema,@w_referencia,@w_ced_ruc,@w_fecha)
    if @@error <> 0
    begin
      /* Error en creacion de transaccion de servicios  covinco*/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 903002
      return 1
    end
    commit tran
    return 0
  end

  /* Delete */
  if @i_operacion = 'D'
  begin
    if @t_trn = 1272
    begin
      select
        @w_codigo = cl_codigo,
        @w_nombre = cl_nombre,
        @w_tipo = cl_tipo,
        @w_problema = cl_problema,
        @w_referencia = cl_referencia,
        @w_ced_ruc = cl_ced_ruc,
        @w_fecha = cl_fecha
      from   cl_com_liquidacion
      where  cl_codigo = @i_codigo

      if @@rowcount = 0
      begin
        /* No existe dato solicitado */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        return 1
      end

      begin tran
      /* Eliminar el registro */
      delete from cl_com_liquidacion
      where  cl_codigo = @i_codigo

      /* Si no se puede eliminar enviar error*/
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107067
        return 1
      end

      /*transaccion de servicios (eliminacion )*/
      insert into ts_cia_liquidacion
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,codigo,nombre,
                   tipo,problema,referencia,ced_ruc,fecha_reg)
      values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@w_codigo,@w_nombre,
                   @w_tipo,@w_problema,@w_referencia,@w_ced_ruc,@w_fecha)
      if @@error <> 0
      begin
        /*Error en creacion de transaccion de servicios */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 903002
        return 1
      end
      commit tran
    end
    else
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
  end

go

