/************************************************************************/
/*  Archivo:        ref_eco.sp                                          */
/*  Stored procedure:   sp_ref_eco                                      */
/*  Base de datos:      cobis                                           */
/*  Producto: Clientes                                                  */
/*  Disenado por:  Carlos Rodriguez V.                                  */
/*  Fecha de escritura: 03-Abr-1994                                     */
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
/*  Insercion de referencia economica                                   */
/*  Actualizacion de referencia economica                               */
/*  Borrado de referencia economica                                     */
/*  Busqueda de referencia economica  general y especifica              */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR         RAZON                                     */
/*  06-Abr-2010 R. Altamirano Control de vigencia de datos del Ente     */
/*  05/May/2016 T. Baidal     Migracion a CEN                           */
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
           where  name = 'sp_ref_eco')
    drop proc sp_ref_eco
go

create proc sp_ref_eco
(
  @s_ssn            int = null,
  @s_user           login = null,
  @s_term           varchar(30) = null,
  @s_date           datetime = null,
  @s_srv            varchar(30) = null,
  @s_lsrv           varchar(30) = null,
  @s_ofi            smallint = null,
  @s_rol            smallint = null,
  @s_org_err        char(1) = null,
  @s_error          int = null,
  @s_sev            tinyint = null,
  @s_msg            descripcion = null,
  @s_org            char(1) = null,
  @t_debug          char(1) = 'N',
  @t_file           varchar(10) = null,
  @t_from           varchar(32) = null,
  @t_trn            smallint = null,
  @t_show_version   bit = 0,
  @i_operacion      char(1),
  @i_ente           int = null,
  @i_tipo           char(1) = null,
  @i_referencia     tinyint = null,
  @i_banco          int = null,
  @i_cuenta         varchar(30) = null,
  @i_tipo_cifras    char(2) = null,
  @i_numero_cifras  tinyint = null,
  @i_calificacion   catalogo = null,
  @i_observacion    varchar(254)= null,
  @i_verificacion   char(1) = 'N',
  @i_fecha_apertura datetime = null,
  @i_tipo_cta       catalogo = null,
  @i_moneda         tinyint = null,
  @i_monto          money = null,
  @i_nacional       char(1) = 'S',
  @i_sucursal       char(20) = null,
  @i_resultado      catalogo = null,
  @i_ciudad         int = null,
  @i_telefono       char(16) = null,
  @i_estado         catalogo = null,
  @i_fec_exp_ref    datetime = null,
  @i_Dpto           catalogo = null,-- GAL 09/FEB/2010
  @i_nit            varchar(20) = null -- GAL 09/FEB/2010
)
as
  declare
    @w_sp_name            varchar(32),
    @w_codigo             int,
    @w_return             int,
    @o_siguiente          tinyint,
    @w_banco              int,
    @w_cuenta             varchar(30),
    @w_tipo_cifras        char(2),
    @w_numero_cifras      tinyint,
    @w_fecha_registro     datetime,
    @w_fecha_modificacion datetime,
    @w_fecha_ver          datetime,
    @w_verificacion       char(1),
    @w_calificacion       char(2),
    @w_vigencia           char(1),
    @w_observacion        varchar(254),
    @w_fecha_apertura     datetime,
    @w_tipo_cta           catalogo,
    @w_moneda             tinyint,
    @w_monto              money,
    @w_ciudad             int,/*INNAC*/
    @w_sucursal           char(20),/*INNAC*/
    @w_telefono           char(16),/*INNAC*/
    @w_estado             catalogo,/*INNAC*/
    @w_nacional           char(1),/*INNAC*/
    @w_fecha_nac          datetime,
    @w_tipo               char(1),
    @w_tabla_cat          varchar(20),
    @w_des_dpto           descripcion,
    @w_des_ciudadeco      descripcion,
    @w_resultado          catalogo,
    @v_nacional           char(1),/*INNAC*/
    @v_ciudad             int,/*INNAC*/
    @v_sucursal           char(20),/*INNAC*/
    @v_telefono           char(16),/*INNAC*/
    @v_estado             catalogo,/*INNAC*/
    @w_fec_exp_ref        datetime,/*INVIEX*/
    @v_fec_exp_ref        datetime,/*INVIEX*/
    @v_banco              int,
    @v_cuenta             varchar(30),
    @v_tipo_cifras        char(2),
    @v_numero_cifras      tinyint,
    @v_fecha_registro     datetime,
    @v_fecha_modificacion datetime,
    @v_fecha_ver          datetime,
    @v_verificacion       char(1),
    @v_calificacion       char(2),
    @v_vigencia           char(1),
    @v_observacion        varchar(254),
    @v_fecha_apertura     datetime,
    @v_tipo_cta           catalogo,
    @v_moneda             tinyint,
    @v_monto              money,
    @v_resultado          catalogo,
    @o_ente               int,
    @o_cedruc             numero,
    @o_en_nombre          descripcion,
    @o_referencia         tinyint,
    @o_tipo               char(1),
    @o_desc_tipo          descripcion,
    @o_institucion        descripcion,
    @o_fecha_ingr_en_inst datetime,
    @o_banco              int,
    @o_banco_nombre       descripcion,
    @o_cuenta             varchar(30),
    @o_banco_tar          catalogo,
    @o_tarjeta_nombre     descripcion,
    @o_cuenta_tar         varchar(30),
    @o_calificacion       char(2),
    @o_desc_calif         descripcion,
    @o_tipo_cifras        char(2),
    @o_numero_cifras      tinyint,
    @o_desc_tipo_cifras   descripcion,
    @o_desc_moneda        descripcion,
    @o_verificacion       char(1),
    @o_fecha_ver          datetime,
    @o_vigencia           char(1),
    @o_fecha_modificacion datetime,
    @o_fecha_registro     datetime,
    @o_observacion        varchar(254),
    @o_funcionario        login,
    @o_bancof             int,
    @o_toperacion         char(1),
    @o_clase              descripcion,
    @o_fec_inicio         datetime,
    @o_fec_vencimiento    datetime,
    @o_estatus            char(1),
    @o_bancof_des         descripcion,
    @w_error              int,
    @o_fecha_apertura     datetime,
    @o_tipo_cta           catalogo,
    @o_moneda             tinyint,
    @o_monto              money,
    @o_fec_exp_ref        datetime,
    @o_garantia           char(1),
    @o_monto_vencido      money,
    @o_cupo_usado         money,
    @o_nacional           char(1),
    @o_ciudad             int,
    @o_sucursal           char(20),
    @o_telefono           char(16),
    @o_estado             catalogo,
    @o_desc_tipo_cta      descripcion,
    @o_desc_ciudad        descripcion,
    @o_desc_estado        descripcion,
    @o_nit                varchar(20),
    @o_dpto               catalogo,
    @o_ciudadeco          catalogo,
    @o_des_dpto           descripcion,
    @o_des_ciudadeco      descripcion

  select
    @w_sp_name = 'sp_ref_eco'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /** Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn = 1355
    begin
      /* Verificar que existe el ente */
      select
        @w_fecha_nac = case en_subtipo
                         when 'P' then p_fecha_nac
                         else c_fecha_const
                       end,
        @w_tipo = en_subtipo
      from   cl_ente
      where  en_ente = @i_ente

      /* si no existe el ente, error */
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101042
        /*  'No existe ente'*/
        return 1
      end

      if @i_fecha_apertura is not null
      begin
        if @w_fecha_nac >= @i_fecha_apertura
           and (@w_tipo = 'P')
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107075
          return 1
        end

        if (@w_fecha_nac >= @i_fecha_apertura)
           and (@w_tipo = 'C')
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107080
          return 1
        end
      end

      /*verificar que exista el tipo de referencia (B:Bancaria, F:Financiera)*/
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_rtipo',
        @i_operacion = 'E',
        @i_codigo    = @i_tipo

      /* si no existe el tipo, error */
      if @w_return <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101023
        /* 'No existe tipo de referencia economica '*/
        return 1
      end

      /* verificar que exista el tipo de Cuenta   */
      if @i_tipo_cta is not null
      begin
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_tabla     = 'cl_tipo_cuenta',
          @i_operacion = 'E',
          @i_codigo    = @i_tipo_cta

        /* si no existe el tipo, error */
        if @w_return <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101178
          /* 'No existe tipo de Cuenta '*/
          return 1
        end
      end
      /* si no existe el tipo, error */
      if @i_calificacion is not null
      begin
        /* verificar que exista el tipo de calificacion */
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_tabla     = 'cl_posicion',
          @i_operacion = 'E',
          @i_codigo    = @i_calificacion
        if @w_return <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 111111--101141
          /* 'No existe tipo de calificacion '*/
          return @w_return
        end
      end

      /* si no existe el Estado, error */
      if @i_estado is not null
      begin
        /* verificar que exista el estado */
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_tabla     = 'cl_ereferencia',
          @i_operacion = 'E',
          @i_codigo    = @i_estado
        if @w_return <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101179
          /* 'No existe tipo de estado '*/
          return @w_return
        end
      end

      /* si no existe la Ciudad, error */
      if @i_ciudad is not null
      begin
        if not exists (select
                         1
                       from   cl_ciudad
                       where  ci_ciudad = @i_ciudad)
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101024
          /* 'No existe Ciudad '*/
          return @w_return
        end
      end
      if @i_tipo_cifras is not null
      begin
        /* verificar que exista el tipo de cifras */
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_tabla     = 'cl_tcifras',
          @i_operacion = 'E',
          @i_codigo    = @i_tipo_cifras

        /* si no existe el tipo, error */
        if @w_return <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101142
          /* 'No existe tipo de cifras'*/
          return 1
        end
      end
      if not exists (select
                       1
                     from   cl_banco_rem
                     where  ba_banco = @i_banco)
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101144
        /* 'Falta nombre del banco '*/
        return 1
      end

      /* SI NO EXISTE EL DPTO, ERROR */
      if @i_Dpto is not null
      begin
        if not exists (select
                         1
                       from   cl_provincia
                       where  pv_provincia = @i_Dpto)
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101038

          return @w_return
        end
      end

      begin tran

      /* aumentar en uno el numero de referencias del ente */
      update cl_ente
      set    en_referencia = isnull(en_referencia, 0) + 1
      where  en_ente = @i_ente

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103044
        /* 'Error en creacion de referencia '*/
        return 1
      end

      /* encontrar el nuevo secuencial para la referencia */
      select
        @o_siguiente = en_referencia
      from   cl_ente
      where  en_ente = @i_ente

      /* insertar la nueva referencia */
      insert into cl_economica
                  (ente,referencia,tipo,tipo_cifras,numero_cifras,
                   fecha_registro,fecha_modificacion,calificacion,verificacion,
                   vigencia,
                   observacion,banco,cuenta,tipo_cta,moneda,
                   fec_apertura,monto,fec_exp_ref,nacional,ciudad,
                   sucursal,telefono,estado,funcionario,dpto,
                   nit)
      values     ( @i_ente,@o_siguiente,@i_tipo,@i_tipo_cifras,@i_numero_cifras,
                   getdate(),getdate(),@i_calificacion,'N','S',
                   @i_observacion,@i_banco,@i_cuenta,@i_tipo_cta,@i_moneda,
                   @i_fecha_apertura,@i_monto,@i_fec_exp_ref,@i_nacional,
                   @i_ciudad
                   ,
                   @i_sucursal,@i_telefono,@i_estado,@s_user,
                   @i_Dpto,
                   @i_nit )

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103072
        /* 'Error en creacion de referencia economica'*/
        return 1
      end

      /* Transaccion servicios - cl_referencia */
      insert into ts_referencia
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,referencia,
                   tipo,tipo_cifras,numero_cifras,calificacion,verificacion,
                   vigencia,observacion,fecha_registro,bancoint,cuenta,
                   fecha_apert,tipo_cta,moneda,monto,fec_exp_ref,
                   nacional,ciudad,sucursal,telefono,estado)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@o_siguiente,
                   @i_tipo,@i_tipo_cifras,@i_numero_cifras,@i_calificacion,'N',
                   'S',@i_observacion,@s_date,@i_banco,@i_cuenta,
                   @i_fecha_apertura,@i_tipo_cta,@i_moneda,@i_monto,
                   @i_fec_exp_ref
                   ,
                   @i_nacional,@i_ciudad,@i_sucursal,@i_telefono
                   ,@i_estado)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /*'Error en creacion de transaccion de servicios'*/
        return 1
      end
      commit tran

      /* retornar el nuevo secuencial para la referencia */
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
    if @t_trn = 1356
    begin
      /* Verificar que existe el ente */
      select
        @w_fecha_nac = case en_subtipo
                         when 'P' then p_fecha_nac
                         else c_fecha_const
                       end,
        @w_tipo = en_subtipo
      from   cl_ente
      where  en_ente = @i_ente

      /* si no existe el ente, error */
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101042
        /*  'No existe ente'*/
        return 1
      end

      /* verificar que exista el tipo de calificacion */
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_vinculo',
        @i_operacion = 'E',
        @i_codigo    = @i_calificacion

      /* si no existe el tipo, error */
      if @w_return <> 0
         and @i_calificacion is not null
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 222222--101141
        /* 'No existe tipo de calificacion '*/
        return 1
      end

      /* si no existe el Estado, error */
      if @i_estado is not null
      begin
        /* verificar que exista el estado */
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_tabla     = 'cl_ereferencia',
          @i_operacion = 'E',
          @i_codigo    = @i_estado
        if @w_return <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101179
          /* 'No existe tipo de manejo '*/
          return @w_return
        end
      end

      /* si no existe la Ciudad, error */
      if @i_ciudad is not null
      begin
        /* verificar que exista la ciudad */
        if not exists (select
                         1
                       from   cl_ciudad
                       where  ci_ciudad = @i_ciudad)
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101024
          /* 'No existe Ciudad '*/
          return @w_return
        end
      end

      if @i_tipo_cifras is not null
      begin
        /* verificar que exista el tipo de cifras */
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_tabla     = 'cl_tcifras',
          @i_operacion = 'E',
          @i_codigo    = @i_tipo_cifras

        /* si no existe el tipo, error */
        if @w_return <> 0
           and @i_tipo_cifras is not null
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101142
          /* 'No existe tipo de cifras'*/
          return @w_return
        end
      end

      if @i_fecha_apertura is not null
      begin
        if @w_fecha_nac >= @i_fecha_apertura
           and (@w_tipo = 'P')
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107075
          return 1
        end

        if (@w_fecha_nac >= @i_fecha_apertura)
           and (@w_tipo = 'C')
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 107080
          return 1
        end
      end

      /* Control de campos a actualizar */
      select
        @w_banco = banco,
        @w_cuenta = cuenta,
        @w_tipo_cifras = tipo_cifras,
        @w_numero_cifras = numero_cifras,
        @w_calificacion = calificacion,
        @w_observacion = observacion,
        @w_verificacion = verificacion,
        @w_fecha_ver = fecha_ver,
        @w_fecha_modificacion = fecha_modificacion,
        @w_vigencia = vigencia,
        @w_fecha_apertura = fec_apertura,
        @w_tipo_cta = tipo_cta,
        @w_nacional = nacional,
        @w_ciudad = ciudad,
        @w_sucursal = sucursal,
        @w_telefono = telefono,
        @w_estado = estado,
        @w_moneda = moneda,
        @w_fec_exp_ref = fec_exp_ref,
        @w_resultado = resul_verif
      from   cl_economica
      where  ente       = @i_ente
         and referencia = @i_referencia

      /* si no existe dato, error */
      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105046
        /* 'No existe referencia '*/
        return 1
      end

      select
        @v_banco = @w_banco,
        @v_cuenta = @w_cuenta,
        @v_tipo_cifras = @w_tipo_cifras,
        @v_numero_cifras = @w_numero_cifras,
        @v_calificacion = @w_calificacion,
        @v_observacion = @w_observacion,
        @v_verificacion = @w_verificacion,
        @v_fecha_ver = @w_fecha_ver,
        @v_fecha_modificacion = @w_fecha_modificacion,
        @v_vigencia = @w_vigencia,
        @v_fecha_apertura = @w_fecha_apertura,
        @v_tipo_cta = @w_tipo_cta,
        @v_nacional = @w_nacional,
        @v_ciudad = @w_ciudad,
        @v_sucursal = @w_sucursal,
        @v_telefono = @w_telefono,
        @v_estado = @w_estado,
        @v_moneda = @w_moneda,
        @v_fec_exp_ref = @w_fec_exp_ref,
        @v_resultado = @w_resultado

      if @w_banco = @i_banco
        select
          @w_banco = null,
          @v_banco = null
      else
        select
          @w_banco = @i_banco

      if @w_cuenta = @i_cuenta
        select
          @w_cuenta = null,
          @v_cuenta = null
      else
        select
          @w_cuenta = @i_cuenta

      if @w_tipo_cifras = @i_tipo_cifras
        select
          @w_tipo_cifras = null,
          @v_tipo_cifras = null
      else
        select
          @w_tipo_cifras = @i_tipo_cifras

      if @w_numero_cifras = @i_numero_cifras
        select
          @w_numero_cifras = null,
          @v_numero_cifras = null
      else
        select
          @w_numero_cifras = @i_numero_cifras

      if @w_calificacion = @i_calificacion
        select
          @w_calificacion = null,
          @v_calificacion = null
      else
        select
          @w_calificacion = @i_calificacion

      if @w_observacion = @i_observacion
        select
          @w_observacion = null,
          @v_observacion = null
      else
        select
          @w_observacion = @i_observacion

      if @w_fecha_apertura = @i_fecha_apertura
        select
          @w_fecha_apertura = null,
          @v_fecha_apertura = null
      else
        select
          @w_fecha_apertura = @i_fecha_apertura

      if @w_nacional = @i_nacional
        select
          @w_nacional = null,
          @v_nacional = null
      else
        select
          @w_nacional = @i_nacional

      if @w_tipo_cta = @i_tipo_cta
        select
          @w_tipo_cta = null,
          @v_tipo_cta = null
      else
        select
          @w_tipo_cta = @i_tipo_cta

      if @w_ciudad = @i_ciudad
        select
          @w_ciudad = null,
          @v_ciudad = null
      else
        select
          @w_ciudad = @i_ciudad

      if @w_sucursal = @i_sucursal
        select
          @w_sucursal = null,
          @v_sucursal = null
      else
        select
          @w_sucursal = @i_sucursal

      if @w_telefono = @i_telefono
        select
          @w_telefono = null,
          @v_telefono = null
      else
        select
          @w_telefono = @i_telefono

      if @w_estado = @i_estado
        select
          @w_estado = null,
          @v_estado = null
      else
        select
          @w_estado = @i_estado

      if @w_moneda = @i_moneda
        select
          @w_moneda = null,
          @v_moneda = null
      else
        select
          @w_moneda = @i_moneda

      if @w_fec_exp_ref = @i_fec_exp_ref
        select
          @w_fec_exp_ref = null,
          @v_fec_exp_ref = null
      else
        select
          @w_fec_exp_ref = @i_fec_exp_ref

      if @w_verificacion = @i_verificacion
        select
          @w_verificacion = null,
          @v_verificacion = null
      else
      begin
        select
          @w_verificacion = @i_verificacion
        if @i_verificacion = 'S'
          select
            @w_fecha_ver = getdate()
      end

      if @w_resultado = @i_resultado
        select
          @w_resultado = null,
          @v_resultado = null
      else
        select
          @w_resultado = @i_resultado

      select
        @w_vigencia = null,
        @v_vigencia = null --ream 06.abr.2010 control vigencia de datos del ente

      begin tran
      /* modificar los datos actuales */
      update cl_economica
      set    banco = @i_banco,
             tipo_cifras = @i_tipo_cifras,
             numero_cifras = @i_numero_cifras,
             calificacion = @i_calificacion,
             verificacion = 'N',
             fecha_ver = @w_fecha_ver,
             fecha_modificacion = getdate(),
             vigencia = isnull(@w_vigencia,
                               vigencia),
             --ream 06.abr.2010 control vigencia de datos del ente
             observacion = @i_observacion,
             cuenta = @i_cuenta,
             fec_apertura = @i_fecha_apertura,
             moneda = @i_moneda,
             tipo_cta = @i_tipo_cta,
             nacional = @i_nacional,
             ciudad = @i_ciudad,
             sucursal = @i_sucursal,
             telefono = @i_telefono,
             estado = @i_estado,
             monto = @i_monto,
             fec_exp_ref = @i_fec_exp_ref,
             funcionario = @s_user,
             nit = @i_nit,
             dpto = @i_Dpto,
             resul_verif = @i_resultado
      where  ente       = @i_ente
         and referencia = @i_referencia
      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105067
        /* 'Error en actualizacion de referencia economica'*/
        return 1
      end

      if @i_verificacion = 'S'
      begin
        update cl_economica
        set    verificacion = @i_verificacion,
               funcionario = @s_user
        where  ente       = @i_ente
           and referencia = @i_referencia
        /* si no se puede modificar, error */
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105067
          /* 'Error en actualizacion de referencia economica'*/
          return 1
        end
      end

      /* Transaccion servicios - cl_economica*/
      insert into ts_referencia
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,referencia,
                   tipo,tipo_cifras,numero_cifras,calificacion,verificacion,
                   vigencia,observacion,fecha_modificacion,bancoint,fecha_ver,
                   cuenta,fecha_apert,tipo_cta,moneda,monto,
                   fec_exp_ref,nacional,ciudad,sucursal,telefono,
                   estado)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_referencia,
                   @i_tipo,@v_tipo_cifras,@v_numero_cifras,@v_calificacion,
                   @v_verificacion,
                   @v_vigencia,@v_observacion,@v_fecha_modificacion,@v_banco,
                   @v_fecha_ver,
                   @v_cuenta,@v_fecha_apertura,@v_tipo_cta,@v_moneda,@v_monto,
                   @v_fec_exp_ref,@v_nacional,@v_ciudad,@v_sucursal,@v_telefono,
                   @v_estado)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicios'*/
        return 1
      end

      /* Transaccion servicios - cl_economica */
      insert into ts_referencia
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,referencia,
                   tipo,tipo_cifras,numero_cifras,calificacion,verificacion,
                   vigencia,observacion,bancoint,fecha_ver,cuenta,
                   monto,fec_exp_ref,nacional,ciudad,sucursal,
                   telefono,estado)
      values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_referencia,
                   @i_tipo,@w_tipo_cifras,@w_numero_cifras,@w_calificacion,
                   @w_verificacion,
                   @w_vigencia,
                   --ream 06.abr.2010 control vigencia de datos del ente
                   @w_observacion,@w_banco,@w_fecha_ver,@w_cuenta,
                   @w_monto,@w_fec_exp_ref,@w_nacional,@w_ciudad,@w_sucursal,
                   @w_telefono,@w_estado)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicios'*/
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
    if @t_trn = 1357
    begin
      /* Captura de campos para transaccion de servicios */
      select
        @w_banco = banco,
        @w_cuenta = cuenta,
        @w_tipo_cifras = tipo_cifras,
        @w_numero_cifras = numero_cifras,
        @w_calificacion = calificacion,
        @w_observacion = observacion,
        @w_verificacion = verificacion,
        @w_fecha_registro = fecha_registro,
        @w_fecha_ver = fecha_ver,
        @w_fecha_modificacion = fecha_modificacion,
        @w_vigencia = vigencia,
        @w_fecha_apertura = fec_apertura,
        @w_tipo_cta = tipo_cta,
        @w_nacional = nacional,
        @w_ciudad = ciudad,
        @w_sucursal = sucursal,
        @w_telefono = telefono,
        @w_estado = estado,
        @w_moneda = moneda,
        @w_monto = monto,
        @w_fec_exp_ref = fec_exp_ref
      from   cl_economica
      where  ente       = @i_ente
         and referencia = @i_referencia

      /* si no existe referencia de economica, error */
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
      /* reducir en uno las referencias del ente */
      update cl_ente
      set    en_referencia = en_referencia - 1
      where  en_ente = @i_ente

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107044
        /* 'Error en disminucion de referencia '*/
        return 1
      end

      /* borrar la referencia */
      delete from cl_economica
      where  ente       = @i_ente
         and referencia = @i_referencia

      /* si no se puede borrar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107044
        /* 'Error en eliminacion de referencia '*/
        return 1
      end

      /* modificar en uno la secuencia de referencias */
      update cl_referencia
      set    re_referencia = re_referencia - 1
      where  re_ente       = @i_ente
         and re_referencia > @i_referencia

      /* si no se puede modificar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107044
        /* 'Error en eliminacion de referencia '*/
        return 1
      end

      /* Transaccion servicios - cl_referencia */
      insert into ts_referencia
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,referencia,
                   tipo,tipo_cifras,numero_cifras,calificacion,verificacion,
                   vigencia,observacion,fecha_registro,bancoint,fecha_ver,
                   cuenta,fecha_modificacion,fecha_apert,tipo_cta,moneda,
                   monto,fec_exp_ref,nacional,ciudad,sucursal,
                   telefono,estado)
      values     (@s_ssn,@t_trn,'B',@s_date,@s_user,
                  @s_term,@s_srv,@s_lsrv,@i_ente,@i_referencia,
                  @i_tipo,@w_tipo_cifras,@w_numero_cifras,@w_calificacion,
                  @w_verificacion,
                  @w_vigencia,@w_observacion,@w_fecha_registro,@w_banco,
                  @w_fecha_ver
                  ,
                  @w_cuenta,@w_fecha_modificacion,@w_fecha_apertura,
                  @w_tipo_cta,
                  @w_moneda,
                  @w_monto,@w_fec_exp_ref,@w_nacional,@w_ciudad,@w_sucursal,
                  @w_telefono,@w_estado)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103005
        /* 'Error en creacion de transaccion de servicios'*/
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

  /* Datos completos de una referencia */
  if @i_operacion = 'Q'
  begin
    if @t_trn = 183
    begin
      select
        @o_tipo = null

      select
        @o_ente = re_ente,
        @o_cedruc = en_ced_ruc,
        @o_en_nombre = substring(rtrim(p_p_apellido) + ' ' + rtrim(p_s_apellido)
                                 +
                                 ' '
                                 +
                                 rtrim(
                                                en_nombre),
                                 1,
                                 64),
        @o_referencia = re_referencia,
        @o_tipo = re_tipo,
        @o_desc_tipo = (select
                          c3.valor
                        from   cl_catalogo c3,
                               cl_tabla t3
                        where  t3.tabla = 'cl_rtipo'
                           and c3.tabla = t3.codigo
                           and re_tipo  = c3.codigo),
        @o_institucion = substring(co_institucion,
                                   1,
                                   30),
        @o_fecha_ingr_en_inst = ec_fec_apertura,
        @o_banco = ec_banco,
        @o_banco_nombre = substring(ba_descripcion,
                                    1,
                                    30),
        @o_cuenta = ec_cuenta,
        @o_calificacion = re_calificacion,
        @o_tipo_cifras = re_tipo_cifras,
        @o_numero_cifras = re_numero_cifras,
        @o_verificacion = re_verificacion,
        @o_fecha_ver = re_fecha_ver,
        @o_vigencia = re_vigencia,
        @o_fecha_modificacion = re_fecha_modificacion,
        @o_fecha_registro = re_fecha_registro,
        @o_observacion = re_observacion,
        @o_funcionario = re_funcionario,
        @o_bancof = fi_banco,
        @o_toperacion = fi_toperacion,
        @o_clase = fi_clase,
        @o_fec_inicio = ec_fec_apertura,
        @o_fec_vencimiento = fi_fec_vencimiento,
        @o_estatus = fi_estatus,
        @o_fecha_apertura = ec_fec_apertura,
        @o_tipo_cta = ec_tipo_cta,
        @o_moneda = ec_moneda,
        @o_monto = monto,
        @o_fec_exp_ref = ec_fec_exp_ref,
        @o_garantia = fi_garantia,
        @o_cupo_usado = fi_cupo_usado,
        @o_monto_vencido = fi_monto_vencido,
        @o_nacional = re_nacional,
        @o_desc_tipo_cta = (select
                              c1.valor
                            from   cl_catalogo c1,
                                   cl_tabla t1
                            where  t1.tabla    = 'cl_tipo_cuenta'
                               and c1.tabla    = t1.codigo
                               and ec_tipo_cta = c1.codigo),
        @o_ciudad = re_ciudad,
        @o_sucursal = re_sucursal,
        @o_telefono = re_telefono,
        @o_estado = re_estado,
        @o_desc_ciudad = ci_descripcion,
        @o_desc_estado = (select
                            c2.valor
                          from   cl_catalogo c2,
                                 cl_tabla t2
                          where  t2.tabla  = 'cl_ereferencia'
                             and c2.tabla  = t2.codigo
                             and re_estado = c2.codigo),
        @o_nit = fi_clase,
        @o_dpto = ta_cuenta,
        @o_ciudadeco = ec_tipo_cta
      from   cl_ente,
             cl_referencia
             left outer join cl_banco_rem
                          on ec_banco = ba_banco
             left outer join cl_ciudad
                          on re_ciudad = ci_ciudad
      where  re_ente       = @i_ente
         and en_ente       = re_ente
         and re_referencia = @i_referencia

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101002
        /*'No existe dato solicitado'*/
        return 1
        select
          @w_error = 1
      end

      if @o_tipo = 'C'
      begin
        select
          @w_tabla_cat = 'cl_vinculo'
      --valida vinculo
      end
      else
      begin
        select
          @w_tabla_cat = 'cl_posicion'
      --valida posicion para las financieras
      end

      if @o_calificacion is not null
      begin
        select
          @o_desc_calif = valor
        from   cl_catalogo
        where  @o_calificacion = codigo
           and tabla           = (select
                                    codigo
                                  from   cl_tabla
                                  where  tabla = @w_tabla_cat)
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
          /*'No existe dato solicitado'*/
          return 1
          select
            @w_error = 1
        end
      end

      if @o_tipo_cifras is not null
      begin
        select
          @o_desc_tipo_cifras = valor
        from   cl_catalogo
        where  @o_tipo_cifras = codigo
           and tabla          = (select
                                   codigo
                                 from   cl_tabla
                                 where  tabla = 'cl_tcifras')
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
          /*'No existe dato solicitado'*/
          return 1
          select
            @w_error = 1
        end
      end

      if @o_tipo = 'F'
      begin
        select
          @o_bancof_des = substring(ba_descripcion,
                                    1,
                                    30)
        from   cl_banco_rem
        where  @o_bancof = ba_banco

        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
          /*'No existe dato solicitado'*/
          return 1
        end
      end

      if @o_tipo = 'C'
      begin
        if @o_nacional = 'N'
        begin
          select
            @o_desc_ciudad = pa_descripcion
          from   cl_pais
          where  pa_pais = @o_ciudad
        end
      end

      if @o_tipo = 'T'
      begin
        select
          @o_banco_tar = ta_banco,
          @o_tarjeta_nombre = (select
                                 substring(g.valor,
                                           1,
                                           30)
                               from   cobis..cl_tabla h,
                                      cobis..cl_catalogo g
                               where  h.tabla  = 'cl_tarjeta'
                                  and g.tabla  = h.codigo
                                  and ta_banco = g.codigo),
          @o_cuenta_tar = ta_cuenta,
          @o_desc_tipo_cta = (select
                                c.valor
                              from   cobis..cl_tabla t,
                                     cobis..cl_catalogo c
                              where  t.tabla  = 'cl_clase_tarjeta'
                                 and c.tabla  = t.codigo
                                 and ta_banco = c.codigo)
        from   cl_referencia
        where  re_ente       = @i_ente
           and re_referencia = @i_referencia
           and (ec_tipo_cta   = @o_tipo_cta
                 or @o_tipo_cta is null)

        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
          /*'No existe dato solicitado'*/
          return 1
        end
      end

      if @o_moneda is not null
      begin
        select
          @o_desc_moneda = mo_descripcion
        from   cl_moneda
        where  mo_moneda = @o_moneda
      end

      if @o_dpto is not null
         and @o_tipo in ('B', 'C')
      begin
        select
          @w_des_dpto = pv_descripcion
        from   cl_provincia
        where  pv_provincia = @o_dpto
      end
      select
        @o_des_dpto = @w_des_dpto

      if @o_ciudadeco is not null
      begin
        select
          @w_des_ciudadeco = ci_descripcion
        from   cl_ciudad
        where  ci_ciudad = @o_ciudadeco
      end
      select
        @o_des_dpto = @w_des_dpto
      select
        @o_des_ciudadeco = @w_des_ciudadeco

      select
        @o_ente,
        @o_cedruc,
        @o_en_nombre,
        @o_referencia,
        @o_tipo,
        @o_desc_tipo,
        @o_institucion,
        convert(char(10), @o_fecha_ingr_en_inst, 101),
        @o_banco,
        @o_banco_nombre,
        @o_cuenta,
        @o_banco_tar,
        @o_tarjeta_nombre,
        @o_cuenta_tar,
        @o_calificacion,
        @o_desc_calif,
        @o_tipo_cifras,
        @o_desc_tipo_cifras,
        @o_numero_cifras,
        @o_verificacion,
        convert(char(10), @o_fecha_ver, 101),
        @o_vigencia,
        convert(char(10), @o_fecha_modificacion, 101),
        convert(char(10), @o_fecha_registro, 101),
        @o_observacion,
        @o_funcionario,
        @o_bancof,
        @o_toperacion,
        @o_clase,
        convert(char(10), @o_fec_inicio, 101),
        convert(char(10), @o_fec_vencimiento, 101),
        @o_estatus,
        @o_bancof_des,
        convert(char(10), @o_fecha_apertura, 101),
        @o_tipo_cta,
        @o_moneda,
        @o_desc_moneda,
        @o_monto,
        convert(char(10), @o_fec_exp_ref, 101),
        @o_garantia,
        @o_cupo_usado,
        @o_monto_vencido,
        @o_nacional,
        @o_desc_ciudad,
        @o_desc_estado,
        @o_desc_tipo_cta,
        @o_telefono,
        @o_sucursal,
        @o_ciudad,
        @o_estado,
        @o_nit,
        @o_dpto,
        @o_ciudadeco,
        @o_des_dpto,
        @o_des_ciudadeco

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

