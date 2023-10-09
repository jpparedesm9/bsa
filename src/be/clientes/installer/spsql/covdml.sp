/************************************************************************/
/*  Archivo:            covinco.sp                                      */
/*  Stored procedure:   sp_covinco_dml                                  */
/*  Base de datos:      cobis                                           */
/*  Producto: 		Clientes                                            */
/*  Disenado por:  	Sandra Ortiz                                        */
/*  Fecha de escritura: 22-Mar-1995                                     */
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
/*  Insert y Update de datos de covinco                                 */
/*  Query de nombre completo de persona                                 */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/
use cobis
go

if exists (select
             *
           from   sysobjects
           where  name = 'sp_covinco_dml')
  drop proc sp_covinco_dml
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_covinco_dml
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
  @i_tipo         char(1) = 'N',
  @i_estado       char(1) = null,
  @i_ced_ruc      char(13) = null,
  @i_nombre       varchar(37) = null,
  @i_af           char(2) =null,
  @i_jz           char(2) = null,
  @i_sb           char(2) = null,
  @i_fecha        char(10) = null,
  @i_codigo       int = null
)
as
  declare
    @w_today   datetime,
    @w_sp_name varchar(32),
    @w_return  int,
    @w_estado  char(1),
    @w_ced_ruc char(13),
    @w_nombre  varchar(37),
    @w_af      char(2),
    @w_jz      char(2),
    @w_sb      char(2),
    @w_fecha   char(10),
    @w_codigo  int,
    @v_estado  char(1),
    @v_ced_ruc char(13),
    @v_nombre  varchar(37),
    @v_af      char(2),
    @v_jz      char(2),
    @v_sb      char(2),
    @v_fecha   char(10),
    @v_codigo  int

  select
    @w_today = getdate()
  select
    @w_sp_name = 'sp_covinco_dml'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Insert */
  if @i_operacion = 'I'
  begin
    begin tran
    if @t_trn = 1258
    begin
      /* Insertar un nuevo registro */
      insert into cl_covinco
                  (cv_estado,cv_ced_ruc,cv_nombre,cv_af,cv_jz,
                   cv_sb,cv_fecha,cv_codigo)
      values      (@i_estado,@i_ced_ruc,@i_nombre,@i_af,@i_jz,
                   @i_sb,@i_fecha,@i_codigo)

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
      /*Transaccion de Servicio*/
      insert into ts_covinco
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,estado,ced_ruc,
                   nombre,af,jz,sb,fecha_cov,
                   codigo)
      values      ( @s_ssn,@t_trn,'N',getdate(),@s_user,
                    @s_term,@s_srv,@s_lsrv,@i_estado,@i_ced_ruc,
                    @i_nombre,@i_af,@i_jz,@i_sb,@i_fecha,
                    @i_codigo)

      /* Si no puede insertar , enviar el error*/
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 903002
        return 1
      end
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
    commit tran
  end
  /* Update */
  if @i_operacion = 'U'
  begin
    if @t_trn <> 1259
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
    else
    begin
      /* Seleccionar campos de la tabla */
      select
        @w_estado = cv_estado,
        @w_ced_ruc = cv_ced_ruc,
        @w_nombre = cv_nombre,
        @w_af = cv_af,
        @w_jz = cv_jz,
        @w_sb = cv_sb,
        @w_fecha = cv_fecha,
        @w_codigo = cv_codigo
      from   cl_covinco
      where  cv_codigo = @i_codigo

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
        @v_estado = @w_estado,
        @v_ced_ruc = @w_ced_ruc,
        @v_nombre = @w_nombre,
        @v_af = @w_af,
        @v_jz = @w_jz,
        @v_sb = @w_sb,
        @v_fecha = @w_fecha,
        @v_codigo = @w_codigo

      if @w_estado = @i_estado
        select
          @w_estado = null,
          @v_estado = null
      else
        select
          @w_estado = @i_estado

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

      if @w_af = @i_af
        select
          @w_af = null,
          @v_af = null
      else
        select
          @w_af = @i_af

      if @w_jz = @i_jz
        select
          @w_jz = null,
          @v_jz = null
      else
        select
          @w_jz = @i_jz

      if @w_sb = @i_sb
        select
          @w_sb = null,
          @v_sb = null
      else
        select
          @w_sb = @i_sb

      if @w_fecha = @i_fecha
        select
          @w_fecha = null,
          @v_fecha = null
      else
        select
          @w_fecha = @i_fecha

      if @w_codigo = @i_codigo
        select
          @w_codigo = null,
          @v_codigo = null
      else
        select
          @w_codigo = @i_codigo

      begin tran
      /* Actualizar el registro */
      update cl_covinco
      set    cv_estado = @i_estado,
             cv_ced_ruc = @i_ced_ruc,
             cv_nombre = @i_nombre,
             cv_af = @i_af,
             cv_jz = @i_jz,
             cv_sb = @i_sb,
             cv_fecha = @i_fecha,
             cv_codigo = @i_codigo
      where  cv_codigo = @i_codigo
      if @@rowcount <> 1
      begin
        /* Error en actualizacion de registro covinco*/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 905001
        return 1
      end

      /*transaccion de servicios (registro previo*/
      insert into ts_covinco
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,estado,ced_ruc,
                   nombre,af,jz,sb,fecha_cov,
                   codigo)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@v_estado,@v_ced_ruc,
                   @v_nombre,@v_af,@v_jz,@v_sb,@v_fecha,
                   @i_codigo)

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

      /*transaccion de servicios (registro actual)*/
      insert into ts_covinco
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,estado,ced_ruc,
                   nombre,af,jz,sb,fecha_cov,
                   codigo)
      values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@w_estado,@w_ced_ruc,
                   @w_nombre,@w_af,@w_jz,@w_sb,@w_fecha,
                   @i_codigo)

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
  end

  /* Delete */
  if @i_operacion = 'D'
  begin
    if @t_trn = 1260
    begin
      /* Valores para transaccion de Servicios*/
      select
        @w_estado = cv_estado,
        @w_ced_ruc = cv_ced_ruc,
        @w_nombre = cv_nombre,
        @w_af = cv_af,
        @w_jz = cv_jz,
        @w_sb = cv_sb,
        @w_fecha = cv_fecha,
        @w_codigo = cv_codigo
      from   cl_covinco
      where  cv_codigo = @i_codigo

      /* Si no existe registro a borrar, error */
      if @@rowcount = 0
      begin
        /* Error no existe registro  */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 901001
        return 1
      end
      begin tran
      /* Eliminar el registro */
      delete from cl_covinco
      where  cv_codigo = @i_codigo

      /* Si no se puede eliminar enviar error*/
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 907001
        return 1
      end

      /*transaccion de servicios (eliminacion )*/
      insert into ts_covinco
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,estado,ced_ruc,
                   nombre,af,jz,sb,fecha_cov,
                   codigo)
      values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@w_estado,@w_ced_ruc,
                   @w_nombre,@w_af,@w_jz,@w_sb,@w_fecha,
                   @i_codigo)
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

