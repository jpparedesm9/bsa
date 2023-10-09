/************************************************************************/
/*  Archivo           :  hijos.sp                                       */
/*  Stored procedure  :  sp_hijos                                       */
/*  Base de datos     :  cobis                                          */
/*  Producto          :  Clientes                                       */
/*  Disenado por      :  Sara Meza                                      */
/*                       Jaime Loyo Holguin                             */
/*  Fecha de escritura: 25-Oct-1996                                     */
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
/*  Este programa procesa las transacciones del stored procedure        */
/*  Insercion de hijos de un cliente                                    */
/*      Query general y especifico de hijos                             */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR        RAZON                                      */
/*  06/Abr/2010 R.Altamirano Control de vigencia de datos del Ente      */
/*  04/May/2016 T. Baidal      Migracion a CEN                          */
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
           where  name = 'sp_hijos')
    drop proc sp_hijos
go

create proc sp_hijos
(
  @s_ssn                int = null,
  @s_user               login = null,
  @s_term               varchar(30) = null,
  @s_date               datetime = null,
  @s_srv                varchar(30) = null,
  @s_lsrv               varchar(30) = null,
  @s_ofi                smallint = null,
  @t_debug              char(1) = 'N',
  @t_file               varchar(10) = null,
  @t_from               varchar(32) = null,
  @t_trn                smallint = null,
  @t_show_version       bit = 0,
  @i_operacion          char(1) = null,
  @i_ente               int = null,
  @i_nombre             varchar(40) = null,
  @i_hijo               int = null,
  @i_sexo               sexo = null,
  @i_fecha_nac          datetime = null,
  @i_tipo               char(1) = null,
  @i_papellido          varchar(16) = null,
  @i_sapellido          varchar(16) = null,
  @i_empresa            varchar(24) = null,
  @i_telefono           varchar(16) = null,
  @i_documento          numero = null,
  @i_tipo_doc           char(2) = null,
  @i_fecha_creacion     datetime = null,
  @i_fecha_modificacion datetime = null,
  @i_verificado         char(1) = 'N',
  @i_funcionario        varchar(14) = null,
  @i_fecha_verificacion datetime = null,
  @i_vigencia           char(1) = 'S',
  @i_fecha_emision      datetime = null,
  @i_ocupacio           varchar(10) = null,
  @i_dir_empresa        varchar(50) = null,
  @i_resultado          catalogo = null
)
as
  declare
    @w_sp_name            varchar(32),
    @w_codigo             int,
    @w_return             int,
    @o_siguiente          tinyint,
    @w_hijo               tinyint,
    @w_cant_hijo          tinyint,
    @w_nombre             varchar(40),
    @w_sexo               sexo,
    @w_fecha_nac          datetime,
    @w_conyuge            int,
    @w_ente               int,
    @w_tipo               char(1),
    @w_papellido          varchar(16),
    @w_sapellido          varchar(16),
    @w_empresa            varchar(24),
    @w_telefono           varchar(16),
    @w_documento          numero,
    @w_tipo_doc           char(2),
    @w_fecha_emision      datetime,
    @w_ocupacio           varchar(10),
    @w_dir_empresa        varchar(50),
    @v_nombre             varchar(40),
    @v_sexo               sexo,
    @v_fecha_nac          datetime,
    @v_fecha_emision      datetime,
    @v_ocupacio           varchar(10),
    @v_dir_empresa        varchar(50),
    @o_ente               int,
    @o_hijo               tinyint,
    @o_des_hijo           descripcion,
    @o_nombre             varchar(40),
    @o_sexo               sexo,
    @o_fecha_nac          varchar(10),
    @v_tipo               char(1),
    @v_papellido          varchar(16),
    @v_sapellido          varchar(16),
    @v_empresa            varchar(24),
    @v_telefono           varchar(16),
    @v_documento          numero,
    @v_tipo_doc           char(2),
    @o_tipo               char(1),
    @o_papellido          varchar(16),
    @o_sapellido          varchar(16),
    @o_empresa            varchar(24),
    @o_telefono           varchar(16),
    @o_documento          numero,
    @o_tipo_doc           char(2),
    @o_fecha_emision      varchar(10),
    @o_ocupacio           varchar(10),
    @o_dir_empresa        varchar(50),
    @w_fecha_creacion     datetime,
    @w_fecha_modificacion datetime,
    @w_verificado         char(1),
    @w_funcionario        varchar(14),
    @w_fecha_verificacion datetime,
    @w_vigencia           char(1),
    @w_num_hijos          smallint,
    @v_fecha_creacion     datetime,
    @v_fecha_modificacion datetime,
    @v_verificado         char(1),
    @v_funcionario        varchar(14),
    @v_fecha_verificacion datetime,
    @v_vigencia           char(1),
    @o_fecha_creacion     datetime,
    @o_fecha_modificacion datetime,
    @o_verificado         char(1),
    @o_funcionario        varchar(14),
    @o_fecha_verificacion datetime,
    @o_vigencia           char(1),
    @o_parEC              varchar(10),
    @o_estcivil           varchar(10),
    @o_desecivil          varchar(50),
    @o_conyug             tinyint

  select
    @w_sp_name = 'sp_hijos'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  set ANSI_NULLS off ---null
  set ANSI_WARNINGS off ---comillas

  /** Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn = 1301
    begin
      /* Verificar que exista el ente */
      select
        @w_codigo = null,
        @w_cant_hijo = isnull(p_num_hijos,
                              0)
      from   cl_ente
      where  en_ente = @i_ente

      /* si no existe, error */
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101043
        /* 'No existe persona'*/
        return 1
      end

      begin tran
      /* seleccionar el nuevo secuencial para el hijo */
      select
        @o_siguiente = isnull(max(hi_hijo), 0) + 1
      from   cl_hijos
      where  hi_ente = @i_ente

      if @o_siguiente is null
        select
          @o_siguiente = 1

      select
        @w_ente = @i_ente

      select
        @i_vigencia = 'S' --ream 06.abr.2010 control vigencia de datos del ente

      /* Validacion para ingresar un solo conyuge. */
      if exists(select
                  hi_ente
                from   cl_hijos
                where  hi_tipo = 'C'
                   and hi_ente = @i_ente
                   and @i_tipo = 'C')
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107088
        /* El cliente ya tiene conyuge. */
        return 1
      end

      /* Insercion cl_hijo */
      insert into cl_hijos
                  (hi_ente,hi_hijo,hi_conyuge,hi_nombre,hi_sexo,
                   hi_fecha_nac,hi_tipo,hi_papellido,hi_sapellido,hi_empresa,
                   hi_telefono,hi_documento,hi_tipo_doc,hi_fecha_creacion,
                   hi_fecha_modificacion,
                   hi_verificado,hi_funcionario,hi_fecha_verificacion,
                   hi_vigencia,
                   hi_fecha_emision,
                   hi_ocupacio,hi_dir_empresa)
      values      (@w_ente,@o_siguiente,@w_conyuge,@i_nombre,@i_sexo,
                   @i_fecha_nac,@i_tipo,@i_papellido,@i_sapellido,@i_empresa,
                   @i_telefono,@i_documento,@i_tipo_doc,@i_fecha_creacion,
                   @i_fecha_modificacion,
                   @i_verificado,@i_funcionario,@i_fecha_verificacion,
                   @i_vigencia,
                   @i_fecha_emision,
                   @i_ocupacio,@i_dir_empresa )

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103082
        /* 'Error en creacion de hijo */
        return 1
      end

      if @i_tipo = 'H'
      begin
        if @o_siguiente > @w_cant_hijo
        begin
          update cl_ente
          set    p_num_hijos = @o_siguiente
          where  en_ente = @w_ente

          /* si no existe error en el conteo de hijos*/
          if @@error <> 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 103082
            /* 'Error en el conteo de hijos */
            return 1
          end
        end
      end

      insert ts_familia
             (secuencial,tipo_transaccion,clase,fecha,usuario,
              terminal,srv,lsrv,persona,nombre,
              p_apellido,s_apellido,sexo,fecha_nac,cedruc,
              tipo_ced,vigencia,verificado,fecha_verificacion,funcionario,
              fecha_emision,ocupacio,dir_empresa)
      values( @s_ssn,@t_trn,'I',@s_date,@s_user,
              @s_term,@s_srv,@s_lsrv,@i_ente,@i_nombre,
              @i_papellido,@w_sapellido,@w_sexo,@w_fecha_nac,@w_documento,
              @w_tipo_doc,@i_vigencia,@w_verificado,@w_fecha_verificacion,
              @w_funcionario,
              --ream 06.abr.2010 control vigencia de datos del ente
              @w_fecha_emision,@w_ocupacio,@w_dir_empresa )

      /* si no se puede borrar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107069,
          @i_msg   = 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO'
        return 1
      end

      commit tran
      /* retornar el nuevo secuencial para el hijo */
      select
        @o_siguiente
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

  /** Update **/
  if @i_operacion = 'U'
  begin
    if @t_trn = 1302
    begin
      select
        @w_nombre = hi_nombre,
        @w_sexo = hi_sexo,
        @w_ente = hi_ente,
        @w_conyuge = hi_conyuge,
        @w_fecha_nac = hi_fecha_nac,
        @w_tipo = hi_tipo,
        @w_papellido = hi_papellido,
        @w_sapellido = hi_sapellido,
        @w_empresa = hi_empresa,
        @w_telefono = hi_telefono,
        @w_documento = hi_documento,
        @w_tipo_doc = hi_tipo_doc,
        @w_fecha_creacion = hi_fecha_creacion,
        @w_fecha_modificacion = hi_fecha_modificacion,
        @w_verificado = hi_verificado,
        @w_funcionario = hi_funcionario,
        @w_fecha_verificacion = hi_fecha_verificacion,
        @w_vigencia = hi_vigencia,
        @w_fecha_emision = hi_fecha_emision,
        @w_ocupacio = hi_ocupacio,
        @w_dir_empresa = hi_dir_empresa
      from   cl_hijos
      where  (hi_ente    = @i_ente
               or hi_conyuge = @i_ente)
         and hi_hijo    = @i_hijo
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No existe dato solicitado'*/
        return 1
      end

      select
        @v_nombre = @w_nombre,
        @v_sexo = @w_sexo,
        @v_fecha_nac = @w_fecha_nac,
        @v_tipo = @w_tipo,
        @v_papellido = @w_papellido,
        @v_sapellido = @w_sapellido,
        @v_empresa = @w_empresa,
        @v_telefono = @w_telefono,
        @v_documento = @w_documento,
        @v_tipo_doc = @w_tipo_doc,
        @v_fecha_creacion = @w_fecha_creacion,
        @v_fecha_modificacion = @w_fecha_modificacion,
        @v_verificado = @w_verificado,
        @v_funcionario = @w_funcionario,
        @v_fecha_verificacion = @w_fecha_verificacion,
        @v_vigencia = @w_vigencia,
        @v_fecha_emision = @w_fecha_emision,
        @v_ocupacio = @w_ocupacio,
        @v_dir_empresa = @w_dir_empresa

      if @w_nombre = @i_nombre
        select
          @w_nombre = null,
          @v_nombre = null
      else
        select
          @w_nombre = @i_nombre

      if @w_sexo = @i_sexo
        select
          @w_sexo = null,
          @v_sexo = null
      else
        select
          @w_sexo = @i_sexo

      if @w_fecha_nac = @i_fecha_nac
        select
          @w_fecha_nac = null,
          @v_fecha_nac = null
      else
        select
          @w_fecha_nac = @i_fecha_nac

      if @w_tipo = @i_tipo
        select
          @w_tipo = null,
          @v_tipo = null
      else
        select
          @w_tipo = @i_tipo

      if @w_papellido = @i_papellido
        select
          @w_papellido = null,
          @v_papellido = null
      else
        select
          @w_papellido = @i_papellido

      if @w_sapellido = @i_sapellido
        select
          @w_sapellido = null,
          @v_sapellido = null
      else
        select
          @w_sapellido = @i_sapellido

      if @w_empresa = @i_empresa
        select
          @w_empresa = null,
          @v_empresa = null
      else
        select
          @w_empresa = @i_empresa

      if @w_telefono = @i_telefono
        select
          @w_telefono = null,
          @v_telefono = null
      else
        select
          @w_telefono = @i_telefono

      if @i_verificado = 'S'
        select
          @i_funcionario = @s_user,
          @i_fecha_verificacion = @s_date,
          @i_vigencia = 'N'
      else
        select
          @i_funcionario = @w_funcionario,
          @i_fecha_verificacion = @w_fecha_verificacion,
          @i_verificado = 'N',
          @i_vigencia = 'S'

      select
        @w_vigencia = null,
        @v_vigencia = null --ream 06.abr.2010 control vigencia de datos del ente

      begin tran

      /* modificar, los datos */
      update cl_hijos
      set    hi_nombre = isnull(@i_nombre,
                                hi_nombre),
             hi_sexo = isnull(@i_sexo,
                              hi_sexo),
             hi_fecha_nac = isnull(@i_fecha_nac,
                                   hi_fecha_nac),
             hi_tipo = isnull(@i_tipo,
                              hi_tipo),
             hi_papellido = isnull(@i_papellido,
                                   hi_papellido),
             hi_sapellido = isnull(@i_sapellido,
                                   hi_sapellido),
             hi_empresa = isnull(@i_empresa,
                                 hi_empresa),
             hi_telefono = isnull(@i_telefono,
                                  hi_telefono),
             hi_documento = isnull(@i_documento,
                                   hi_documento),
             hi_tipo_doc = isnull(@i_tipo_doc,
                                  hi_tipo_doc),
             hi_fecha_modificacion = getdate(),
             hi_verificado = @i_verificado,
             hi_funcionario = @i_funcionario,
             hi_fecha_verificacion = @i_fecha_verificacion,
             hi_vigencia = isnull(@w_vigencia,
                                  hi_vigencia),
             --ream 06.abr.2010 control vigencia de datos del ente
             hi_fecha_emision = @i_fecha_emision,
             hi_ocupacio = @i_ocupacio,
             hi_dir_empresa = @i_dir_empresa
      where  hi_ente = @i_ente
         and hi_hijo = @i_hijo

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105073
        /*'Error en actualizacion de hijo'*/
        return 1
      end
      insert ts_familia
             (secuencial,tipo_transaccion,clase,fecha,usuario,
              terminal,srv,lsrv,persona,nombre,
              p_apellido,s_apellido,sexo,fecha_nac,cedruc,
              tipo_ced,vigencia,verificado,fecha_verificacion,funcionario,
              fecha_emision,ocupacio,dir_empresa)
      values( @s_ssn,@t_trn,'A',@s_date,@s_user,
              @s_term,@s_srv,@s_lsrv,@i_ente,@v_nombre,
              @v_papellido,@v_sapellido,@v_sexo,@v_fecha_nac,@v_documento,
              @v_tipo_doc,@v_vigencia,@v_verificado,@v_fecha_verificacion,
              @v_funcionario,
              @v_fecha_emision,@v_ocupacio,@v_dir_empresa )

      /* si no se puede borrar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107069,
          @i_msg   = 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO'
        return 1
      end

      insert ts_familia
             (secuencial,tipo_transaccion,clase,fecha,usuario,
              terminal,srv,lsrv,persona,nombre,
              p_apellido,s_apellido,sexo,fecha_nac,cedruc,
              tipo_ced,vigencia,verificado,fecha_verificacion,funcionario,
              fecha_emision,ocupacio,dir_empresa)
      values( @s_ssn,@t_trn,'P',@s_date,@s_user,
              @s_term,@s_srv,@s_lsrv,@i_ente,@w_nombre,
              @w_papellido,@w_sapellido,@w_sexo,@w_fecha_nac,@w_documento,
              @w_tipo_doc,@w_vigencia,@w_verificado,@w_fecha_verificacion,
              @w_funcionario,
              @w_fecha_emision,@w_ocupacio,@w_dir_empresa )

      /* si no se puede borrar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107069,
          @i_msg   = 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO'
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

  /** Delete **/
  if @i_operacion = 'D'
  begin
    if @t_trn = 1303
    begin
      select
        @w_nombre = hi_nombre,
        @w_ente = hi_ente,
        @w_conyuge = hi_conyuge,
        @w_sexo = hi_sexo,
        @w_fecha_nac = hi_fecha_nac,
        @w_tipo = hi_tipo,
        @w_papellido = hi_papellido,
        @w_sapellido = hi_sapellido,
        @w_empresa = hi_empresa,
        @w_telefono = hi_telefono,
        @w_documento = hi_documento,
        @w_tipo_doc = hi_tipo_doc,
        @w_fecha_creacion = hi_fecha_creacion,
        @w_fecha_modificacion = hi_fecha_modificacion,
        @w_verificado = hi_verificado,
        @w_funcionario = hi_funcionario,
        @w_fecha_verificacion = hi_fecha_verificacion,
        @w_vigencia = hi_vigencia,
        @w_fecha_emision = hi_fecha_emision,
        @w_ocupacio = hi_ocupacio,
        @w_dir_empresa = hi_dir_empresa
      from   cl_hijos
      where  hi_ente = @i_ente
         and hi_hijo = @i_hijo

      /* si no existe hijo */
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No dato solicitado' */
        return 1
      end

      begin tran

    /* borrar el hijo */ /*hom*/
      delete from cl_hijos
      where  (hi_ente    = @i_ente
               or hi_conyuge = @i_ente)
         and hi_hijo    = @i_hijo

      /* si no se puede borrar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107069
        /* 'Error en eliminacion del hijo de un cliente '*/
        return 1
      end
      insert ts_familia
             (secuencial,tipo_transaccion,clase,fecha,usuario,
              terminal,srv,lsrv,persona,nombre,
              p_apellido,s_apellido,sexo,fecha_nac,cedruc,
              tipo_ced,vigencia,verificado,fecha_verificacion,funcionario,
              fecha_emision,ocupacio,dir_empresa)
      values( @s_ssn,@t_trn,'D',@s_date,@s_user,
              @s_term,@s_srv,@s_lsrv,@i_ente,@w_nombre,
              @w_papellido,@w_sapellido,@w_sexo,@w_fecha_nac,@w_documento,
              @w_tipo_doc,@w_vigencia,@w_verificado,@w_fecha_verificacion,
              @w_funcionario,
              @w_fecha_emision,@w_ocupacio,@w_dir_empresa )

      /* si no se puede borrar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107069,
          @i_msg   = 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO'
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

/** Search **/
  /* referencias  de hijos de una persona no se controla de 20 en 20
     porque no se espera mas de 20 hijos */
  if @i_operacion = 'S'
  begin
    if @t_trn = 1304
    begin
      select
        'Consecutivo' = hi_hijo,/*hom*/
        'Nombre' = hi_nombre,
        'P. Apellido' = hi_papellido,
        'S. Apellido' = hi_sapellido,
        'Tipo' = hi_tipo,
        'Tipo Doc' = hi_tipo_doc,
        'Doc. Ident' = hi_documento,
        'Sexo' = hi_sexo,
        'Fecha de Nac' = convert (char(10), hi_fecha_nac, 101),
        'Desc. Sexo' = c.valor,
        'Empresa' = hi_empresa,
        'Telefono' = hi_telefono,
        'Fecha Emision' = @i_fecha_emision,
        'Ocupacion' = @i_ocupacio,
        'Dir Empresa' = @i_dir_empresa,
        'Obs. Verificacion'= hi_obs_verificado
      from   cl_hijos,
             cl_catalogo c,
             cl_tabla t
      where  hi_ente  = @i_ente
         and t.tabla  = 'cl_sexo'
         and c.tabla  = t.codigo
         and c.codigo = hi_sexo
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

/** Query **/
  /* Datos especificos de los hijos del cliente */
  if @i_operacion = 'Q'
  begin
    if @t_trn = 1305
    begin
      select
        @o_hijo = hi_hijo,
        @o_nombre = rtrim(hi_nombre),
        @o_sexo = hi_sexo,
        @o_fecha_nac = convert(char(10), hi_fecha_nac, 101),
        @o_des_hijo = c.valor,
        @o_papellido = rtrim(hi_papellido),
        @o_sapellido = rtrim(hi_sapellido),
        @o_tipo = hi_tipo,
        @o_empresa = hi_empresa,
        @o_telefono = hi_telefono,
        @o_documento = hi_documento,
        @o_tipo_doc = hi_tipo_doc,
        @o_fecha_creacion = hi_fecha_creacion,
        @o_fecha_modificacion = hi_fecha_modificacion,
        @o_verificado = hi_verificado,
        @o_funcionario = hi_funcionario,
        @o_fecha_verificacion = hi_fecha_verificacion,
        @o_vigencia = hi_vigencia,
        @o_fecha_emision = convert(char(10), hi_fecha_emision, 101),
        @o_ocupacio = hi_ocupacio,
        @o_dir_empresa = hi_dir_empresa
      from   cl_hijos,
             cl_catalogo c,
             cl_tabla t
      where  hi_ente  = @i_ente
         and hi_hijo  = @i_hijo
         and t.tabla  = 'cl_sexo'
         and c.tabla  = t.codigo
         and c.codigo = hi_sexo

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No existe dato solicitado'*/
        return 1
      end

      select
        @o_hijo,
        @o_nombre,
        @o_sexo,
        @o_fecha_nac,
        @o_des_hijo,
        @o_tipo,
        @o_papellido,
        @o_sapellido,
        @o_empresa,
        @o_telefono,
        @o_documento,
        @o_tipo_doc,
        @o_fecha_creacion,
        @o_fecha_modificacion,
        @o_verificado,
        @o_funcionario,
        @o_fecha_verificacion,
        @o_vigencia,
        @o_fecha_emision,
        @o_ocupacio,
        @o_dir_empresa

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
  if @i_operacion = 'V'
  begin
    update cl_hijos
    set    hi_verificado = @i_verificado,
           hi_funcionario = @s_user,
           hi_fecha_verificacion = @s_date,
           hi_vigencia = @i_verificado,--ream por verificar...
           hi_fecha_emision = @i_fecha_emision,
           hi_ocupacio = @i_ocupacio,
           hi_dir_empresa = @i_dir_empresa,
           hi_obs_verificado = @i_resultado
    where  hi_ente = @i_ente
       and hi_hijo = @i_hijo

    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105073
      /*'Error en actualizacion de hijo'*/
      return 105073
    end
  end

  if @i_operacion = 'X'
  begin
    if @t_trn = 1304
    begin
      select
        @o_parEC = pa_char
      from   cobis..cl_parametro
      where  pa_producto = 'MIS'
         and pa_nemonico = 'ECC'

      if @@rowcount <> 1
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001,
          @i_msg   = 'NO EXISTE PARAMETRO DE MONTO '
        return 101001
      end

      select
        @o_estcivil = p_estado_civil
      from   cobis..cl_ente
      where  en_ente = @i_ente

      /*if @@rowcount = 0
      begin
         exec sp_cerror
              @t_debug    = @t_debug,
              @t_file     = @t_file,
              @t_from     = @w_sp_name,
              @i_num      = 101001
              /* 'No existe dato solicitado'*/
         return 1
      end*/

      select
        @o_conyug = count(0)
      from   cobis..cl_hijos
      where  hi_ente = @i_ente
         and hi_tipo = 'C'

      select
        'parametro ' = @o_parEC,
        'estado civ' = @o_estcivil,
        'conyug' = @o_conyug

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
  return 0

go

