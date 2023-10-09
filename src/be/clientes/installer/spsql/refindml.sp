/************************************************************************/
/*  Archivo:            refindml.sp                                     */
/*  Stored procedure:   sp_refinh_dml                                   */
/*  Base de datos:      cobis                                           */
/*  Producto:       Clientes                                            */
/*  Disenado por:   Octavio Hoyos F.                                    */
/*  Fecha de escritura: 27-Jun-1996                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este stored procedure procesa:                                      */
/*  Insert y Update de datos de Ref. Inhibitorias                       */
/*  Query de nombre completo de persona                                 */
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  27/Jun/96   O.Hoyos.    Emision Inicial                             */
/*  05/Ene/2010 L.Regalado  Modificar Funcionalidad de malas            */
/*                          Referencias inhibitorias                    */
/*  05/May/2016 T. Baidal   Migracion a CEN                             */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_refinh_dml')
    drop proc sp_refinh_dml
go

create proc sp_refinh_dml
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
  @i_codigo       int = null,
  @i_ced_ruc      char(13) = null,
  @i_nombre       char(37) = null,
  @i_documento    int = null,
  @i_origen       catalogo = null,
  @i_observacion  varchar(255) = null,
  @i_fechamod     datetime = null,
  @i_fecharef     datetime = null,
  @i_p_apellido   varchar(16) = null,
  @i_s_apellido   varchar(16) = null,
  @i_tipo_ced     char(2) = null,
  @i_tipo_cli     char(1) = null,
  @i_estadori     catalogo = null,
  @i_sexo         char(1) = null,
  @o_codigo_sig   int = null out
)
as
  declare
    @w_today       datetime,
    @w_sp_name     varchar(32),
    @w_return      int,
    @w_estado      char(1),
    @w_codigo      int,
    @w_ced_ruc     char(13),
    @w_catalogo    char(10),
    @w_nombre      varchar(37),
    @w_documento   int,
    @w_origen      catalogo,
    @w_estadori    catalogo,
    @w_observacion varchar(255),
    @w_fechamod    datetime,
    @w_fecharef    datetime,
    @w_p_apellido  varchar(16),
    @w_s_apellido  varchar(16),
    @w_tipo_ced    char(2),
    @w_tipo_cli    char(1),
    @v_codigo      int,
    @v_ced_ruc     char(13),
    @v_nombre      varchar(37),
    @v_documento   int,
    @v_origen      catalogo,
    @v_estadori    catalogo,
    @v_observacion char(80),
    @v_fechamod    datetime,
    @v_fecharef    datetime,
    @v_p_apellido  varchar(16),
    @v_s_apellido  varchar(16),
    @v_tipo_ced    char(2),
    @v_tipo_cli    char(1),
    @w_nomlar      char (64),
    @w_contador    int,
    @w_sexo        char(1),
    @v_sexo        char(1)

  select
    @w_sp_name = 'sp_refinh_dml'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = getdate()

  if @i_tipo_cli <> 'C'
     and @i_tipo_cli <> 'P'
     and @i_operacion = 'I'
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101114
    /* parametro invalido */
    return 1
  end

  if @i_tipo_cli = 'C'
    select
      @w_nomlar = ltrim (@i_nombre)
  else
    select
      @w_nomlar = @i_p_apellido + ' ' + @i_s_apellido + ' ' + @i_nombre

  /* Insert */
  if @i_operacion = 'I'
  begin
    begin tran
    if @t_trn = 1280
    begin
      exec sp_cseqnos
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_tabla    = 'cl_refinh',
        @o_siguiente= @o_codigo_sig out

      /* verificar el origen de la referencia */
      select
        @w_catalogo = convert(char(10), @i_origen)
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_operacion = 'E',
        @i_tabla     = 'cl_refinh',
        @i_codigo    = @w_catalogo
      if @w_return <> 0
      begin
        /* 'No existe Referencia Inhibitoria'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101131
        return 1
      end

      /* verificar el estado de la referencia */
      select
        @w_catalogo = convert(char(10), @i_estadori)
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_operacion = 'E',
        @i_tabla     = 'cl_estado_refinh',
        @i_codigo    = @w_catalogo
      if @w_return <> 0
      begin
        /* 'No existe Referencia Inhibitoria'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101131
        return 1
      end

      /* Insertar un nuevo registro */
      insert into cl_refinh
                  (in_codigo,in_ced_ruc,in_nombre,in_documento,in_origen,
                   in_observacion,in_fecha_mod,in_fecha_ref,in_subtipo,
                   in_p_p_apellido
                   ,
                   in_p_s_apellido,in_tipo_ced,in_nomlar,in_estado,
                   in_sexo)
      values      (@o_codigo_sig,@i_ced_ruc,@i_nombre,@i_documento,@i_origen,
                   @i_observacion,@w_today,@i_fecharef,@i_tipo_cli,@i_p_apellido
                   ,
                   @i_s_apellido,@i_tipo_ced,@w_nomlar,
                   @i_estadori,@i_sexo)
      /* Si no se puede insertar enviar error*/
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 143005
        return 1
      end

      select
        @w_contador = isnull(count(*),
                             0)
      from   cobis..cl_refinh
      where  in_tipo_ced = @i_tipo_ced
         and in_ced_ruc  = @i_ced_ruc

      update cl_ente
      set    en_mala_referencia = 'S',
             en_cont_malas = @w_contador
      where  en_tipo_ced = @i_tipo_ced
         and en_ced_ruc  = @i_ced_ruc

      if @@rowcount = 0
      begin
        print 'CLIENTE NO SE ENCUENTRA EN LA B.D.'
      end

      /*Transaccion de Servicio*/
      insert into ts_refinh
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ced_ruc,nombre,
                   fecha_ref,origen,observacion,codigo,documento,
                   fecha_mod,p_apellido,s_apellido,tipo_ced,ref_estado)
      values     ( @s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ced_ruc,@i_nombre,
                   @i_fecharef,@i_origen,@i_observacion,@o_codigo_sig,
                   @i_documento
                   ,
                   @w_today,@i_p_apellido,@i_s_apellido,
                   @i_tipo_ced,@i_estadori)

      /* Si no puede insertar , enviar el error*/
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 143005
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
    if @t_trn <> 1281
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
      /* verificar el origen de la referencia */
      select
        @w_catalogo = convert(char(10), @i_origen)
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_operacion = 'E',
        @i_tabla     = 'cl_refinh',
        @i_codigo    = @w_catalogo
      if @w_return <> 0
      begin
        /* 'No existe Referencia Inhibitoria'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101131
        return 1
      end
      /* verificar el estado de la referencia */
      select
        @w_catalogo = convert(char(10), @i_estadori)
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_operacion = 'E',
        @i_tabla     = 'cl_estado_refinh',
        @i_codigo    = @w_catalogo
      if @w_return <> 0
      begin
        /* 'No existe Referencia Inhibitoria'*/
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101131
        return 1
      end

      /* Seleccionar campos de la tabla */
      select
        @w_codigo = in_codigo,
        @w_ced_ruc = in_ced_ruc,
        @w_nombre = in_nombre,
        @w_documento = in_documento,
        @w_origen = in_origen,
        @w_observacion = in_observacion,
        @w_fechamod = in_fecha_mod,
        @w_fecharef = convert (char(10), in_fecha_ref, 101),
        @w_p_apellido = in_p_p_apellido,
        @w_s_apellido = in_p_s_apellido,
        @w_tipo_ced = in_tipo_ced,
        @w_tipo_cli = in_subtipo,
        @w_estadori = in_estado,
        @w_sexo = in_sexo
      from   cl_refinh
      where  in_codigo = @i_codigo

      if @@rowcount = 0
      begin
        /* No existe dato solicitado */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101130
        return 1
      end
      select
        @v_codigo = @w_codigo,
        @v_ced_ruc = @w_ced_ruc,
        @v_nombre = @w_nombre,
        @v_documento = @w_documento,
        @v_origen = @w_origen,
        @v_observacion = @w_observacion,
        @v_fechamod = @w_fechamod,
        @v_fecharef = @w_fecharef,
        @v_p_apellido = @w_p_apellido,
        @v_s_apellido = @w_s_apellido,
        @v_tipo_ced = @w_tipo_ced,
        @v_tipo_cli = @w_tipo_cli,
        @v_estadori = @w_estadori,
        @v_sexo = @w_sexo

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

      if @w_documento = @i_documento
        select
          @w_documento = null,
          @v_documento = null
      else
        select
          @w_documento = @i_documento

      if @w_origen = @i_origen
        select
          @w_origen = null,
          @v_origen = null
      else
        select
          @w_origen = @i_origen

      if @w_estadori = @i_estadori
        select
          @w_estadori = null,
          @v_estadori = null
      else
        select
          @w_estadori = @i_estadori

      if @w_observacion = @i_observacion
        select
          @w_observacion = null,
          @v_observacion = null
      else
        select
          @w_observacion = @i_observacion
      if @w_fechamod = @w_today
        select
          @w_fechamod = null,
          @v_fechamod = null
      else
        select
          @w_fechamod = @w_today
      if @w_p_apellido = @i_p_apellido
        select
          @w_p_apellido = null,
          @v_p_apellido = null
      else
        select
          @w_p_apellido = @i_p_apellido
      if @w_s_apellido = @i_s_apellido
        select
          @w_s_apellido = null,
          @v_s_apellido = null
      else
        select
          @w_s_apellido = @i_s_apellido
      if @w_tipo_ced = @i_tipo_ced
        select
          @w_tipo_ced = null,
          @v_tipo_ced = null
      else
        select
          @w_tipo_ced = @i_tipo_ced

      begin tran
      /* Actualizar el registro */
      update cl_refinh
      set    in_documento = @i_documento,
             in_ced_ruc = @i_ced_ruc,
             in_nombre = @i_nombre,
             in_origen = @i_origen,
             in_observacion = @i_observacion,
             in_fecha_mod = @w_today,
             in_fecha_ref = @i_fecharef,
             in_p_p_apellido = @i_p_apellido,
             in_p_s_apellido = @i_s_apellido,
             in_tipo_ced = @i_tipo_ced,
             in_nomlar = @w_nomlar,
             in_estado = @i_estadori,
             in_sexo = @i_sexo
      where  in_entid is null
         /*** Para las referencia de front-end este campo es nulo ****/
         and in_codigo = @i_codigo

      if @@rowcount <> 1
      begin
        /* Error en actualizacion de registro covinco*/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105067
        return 1
      end

      /*transaccion de servicios (registro previo*/
      insert into ts_refinh
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ced_ruc,nombre,
                   fecha_ref,origen,observacion,codigo,documento,
                   fecha_mod,p_apellido,s_apellido,tipo_ced,ref_estado)
      values     ( @s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@v_ced_ruc,@v_nombre,
                   null,@v_origen,@v_observacion,@i_codigo,@v_documento,
                   @v_fechamod,@v_p_apellido,@v_s_apellido,@v_tipo_ced,
                   @v_estadori
      )

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
      insert into ts_refinh
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ced_ruc,nombre,
                   fecha_ref,origen,observacion,codigo,documento,
                   fecha_mod,p_apellido,s_apellido,tipo_ced,ref_estado)
      values     ( @s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@w_ced_ruc,@w_nombre,
                   null,@w_origen,@w_observacion,@i_codigo,@w_documento,
                   @w_fechamod,@w_p_apellido,@w_s_apellido,@w_tipo_ced,
                   @w_estadori
      )

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
      commit tran
      return 0
    end
  end

  /* Delete */
  if @i_operacion = 'D'
  begin
    if @t_trn = 1282
    begin
      /* Valores para transaccion de Servicios*/
      select
        @w_codigo = in_codigo,
        @w_ced_ruc = in_ced_ruc,
        @w_nombre = in_nombre,
        @w_documento = in_documento,
        @w_origen = in_origen,
        @w_observacion = in_observacion,
        @w_fechamod = in_fecha_mod,
        @w_fecharef = in_fecha_ref,
        @w_p_apellido = in_p_p_apellido,
        @w_s_apellido = in_p_s_apellido,
        @w_tipo_ced = in_tipo_ced,
        @w_estadori = in_estado,
        @w_sexo = in_sexo
      from   cl_refinh
      where  in_entid is null
         /*** Para las referencia de front-end este campo es nulo ****/
         and in_codigo = @i_codigo

      /* Si no existe registro a borrar, error */
      if @@rowcount = 0
      begin
        /* Error no existe registro  */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101130
        return 1
      end
      begin tran
      /* Eliminar el registro */
      delete from cl_refinh
      where  in_entid is null
         and in_codigo = @i_codigo
    /*** Para las referencia de front-end este campo es nulo ****/

      /* Si no se puede eliminar enviar error*/
      if @@error <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105062
        return 1
      end

      /***desmarcar en cl_ente en_mala_referencia ****/

      select
        @w_contador = 0

      select
        @w_contador = isnull(count(*),
                             0)
      from   cobis..cl_refinh
      where  in_tipo_ced = @w_tipo_ced
         and in_ced_ruc  = @w_ced_ruc

      update cl_ente
      set    --en_mala_referencia = 'N',
      --en_cont_malas = case when en_cont_malas > 0 then en_cont_malas - 1 else 0 end
      en_cont_malas = @w_contador
      where  en_tipo_ced = @w_tipo_ced
         and en_ced_ruc  = @w_ced_ruc

      if @@rowcount = 0
      begin
        print
    'NO EXISTE REFERENCIA A TIPO Y NUMERO - NO HAY CLIENTE A DESMARCAR'
      end

      if @w_contador = 0
      begin
        update cl_ente
        set    en_mala_referencia = 'N',
               en_emala_referencia = null
        where  en_tipo_ced = @w_tipo_ced
           and en_ced_ruc  = @w_ced_ruc

      end

      /*transaccion de servicios (eliminacion )*/
      insert into ts_refinh
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ced_ruc,nombre,
                   fecha_ref,origen,observacion,codigo,documento,
                   fecha_mod,p_apellido,s_apellido,tipo_ced,ref_estado)
      values     ( @s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@w_ced_ruc,@w_nombre,
                   @w_fecharef,@w_origen,@w_observacion,@i_codigo,@w_documento,
                   @w_fechamod,@w_p_apellido,@w_s_apellido,@w_tipo_ced,
                   @w_estadori
      )

      if @@error <> 0
      begin
        /*Error en creacion de transaccion de servicios */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
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

