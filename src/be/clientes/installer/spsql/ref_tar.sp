/************************************************************************/
/*  Archivo:            ref_tar.sp                                      */
/*  Stored procedure:   sp_ref_tar                                      */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Carlos Rodriguez V.                             */
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
/*  Insercion de referencia de tarjeta                                  */
/*  Actualizacion de referencia de tarjeta                              */
/*  Borrado de referencia de tarjeta                                    */
/*  Busqueda de referencia de tarjeta general y especifica              */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR           RAZON                                   */
/*  31/03/95    Bco. Prestamos  Ingreso de nuevo campo                  */
/*  02/Jul/96   E. Gomez M.     Ingreso fecha expedicion ref.           */
/*  23/Dic/96   J. Loyo H.      Ingreso nacional, ciudad, telefono, suc.*/
/*  06/Abr/2010 R.Altamirano    Control de vigencia de datos del Ente   */
/*  05/May/2016 T. Baidal       Migracion a CEN                         */
/************************************************************************/
use cobis
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_ref_tar')
    drop proc sp_ref_tar
go

create proc sp_ref_tar
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
  @i_referencia     tinyint = null,
  @i_banco          catalogo = null,
  @i_cuenta         varchar(30) = null,
  @i_tipo_cifras    char(2) = null,
  @i_numero_cifras  tinyint = null,
  @i_calificacion   catalogo = null,
  @i_observacion    varchar(254) = null,
  @i_verificacion   char(1) = 'N',
  @i_fecha_apertura datetime = null,
  @i_monto          money = null,
  @i_nacional       char(1) = 'N',
  @i_sucursal       char(20) = null,
  @i_ciudad         int = null,
  @i_telefono       char(16) = null,
  @i_estado         catalogo = null,
  @i_clase_tarjeta  catalogo = null,
  @i_fec_exp_ref    datetime = null,
  @i_resultado      catalogo = null
)
as
  declare
    @w_sp_name            varchar(32),
    @w_codigo             int,
    @w_return             int,
    @o_siguiente          tinyint,
    @w_banco              catalogo,
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
    @w_monto              money,
    @w_nacional           char(1),
    @w_sucursal           char(20),
    @w_ciudad             int,
    @w_telefono           char(16),
    @w_estado             catalogo,
    @w_clase_tarjeta      catalogo,
    @w_fec_exp_ref        datetime,
    @w_resultado          catalogo,
    @v_fec_exp_ref        datetime,
    @v_banco              catalogo,
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
    @v_monto              money,
    @v_nacional           char(1),
    @v_sucursal           char(20),
    @v_ciudad             int,
    @v_telefono           char(16),
    @v_estado             catalogo,
    @v_clase_tarjeta      catalogo,
    @v_resultado          catalogo,
    @o_ente               int,
    @o_cedruc             numero,
    @o_ennombre           descripcion,
    @o_banco              catalogo,
    @o_banco_nombre       descripcion,
    @o_cuenta             varchar(30),
    @o_tipo_cifras        char(2),
    @o_numero_cifras      tinyint,
    @o_fecha_registro     datetime,
    @o_fecha_modificacion datetime,
    @o_fecha_ver          datetime,
    @o_verificacion       char(1),
    @o_calificacion       char(2),
    @o_observacion        varchar(254),
    @o_vigencia           char(1),
    @o_fecha_apertura     datetime,
    @o_nacional           char(1),
    @o_sucursal           char(20),
    @o_ciudad             int,
    @o_telefono           char(16),
    @o_estado             catalogo,
    @o_clase_tarjeta      catalogo,
    @o_fec_exp_ref        datetime,
    @o_monto              money,
    @w_fecha_nac          datetime,
    @w_tipo               char (1)

  select
    @w_sp_name = 'sp_ref_tar'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /** Insert **/
  if @i_operacion = 'I'
  begin
    if @t_trn = 1361
    begin
      /* Verificar que existe el ente */
      select
        @w_codigo = null
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
        /* 'No existe ente'*/
        return 1
      end

      /* verificar que exista el tipo de referencia (T: de tarjeta) */
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_rtipo',
        @i_operacion = 'E',
        @i_codigo    = 'T'

      /* si no existe el tipo, error */
      if @w_return <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101023
        /* 'No existe tipo de referencia de tarjeta'*/
        return 1
      end

      /* Verificar existencia de Ciudad */
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
            @i_num   = 101124
          /* 'No existe ciudad'*/
          return 1
        end
      end

      if @i_clase_tarjeta is not null
      begin
        /* verificar que exista la clase de tarjeta  */
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_tabla     = 'cl_clase_tarjeta',
          @i_operacion = 'E',
          @i_codigo    = @i_clase_tarjeta

        /* si no existe el tipo, error */
        if @w_return <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101180
          /* 'No existe clase de tarjeta'*/
          return 101180
        end
      end
      /* verificar que exista el estado de la tarjeta */
      if @i_estado is not null
      begin
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_tabla     = 'cl_ereferencia',
          @i_operacion = 'E',
          @i_codigo    = @i_estado

        /* si no existe el estado */
        if @w_return <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101179
          /* 'No existe el estado de tarjeta'*/
          return 1
        end
      end
      /* verificar que exista el tipo de calificacion */
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_posicion',
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
          @i_num   = 101141
        /* 'No existe tipo de calificacion '*/
        return 1
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
      end

      select
        @w_tipo = en_subtipo,
        @w_fecha_nac = case en_subtipo
                         when 'P' then p_fecha_nac
                         else c_fecha_const
                       end
      from   cl_ente
      where  en_ente = @i_ente

      if @w_fecha_nac >= @i_fecha_apertura
         and (@w_tipo = 'P')
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107089
        return 107089
      end

      if (@w_fecha_nac >= @i_fecha_apertura)
         and (@w_tipo = 'C')
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107090
        return 1
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
      insert into cl_tarjeta
                  (ente,referencia,tipo,tipo_cifras,numero_cifras,
                   fecha_registro,fecha_modificacion,calificacion,verificacion,
                   vigencia,
                   observacion,banco,cuenta,fecha_apertura,monto,
                   fec_exp_ref,nacional,sucursal,ciudad,telefono,
                   estado,clase_tarjeta,funcionario)
      values      (@i_ente,@o_siguiente,'T',@i_tipo_cifras,@i_numero_cifras,
                   getdate(),getdate(),@i_calificacion,'N','S',
                   @i_observacion,@i_banco,@i_cuenta,@i_fecha_apertura,@i_monto,
                   @i_fec_exp_ref,@i_nacional,@i_sucursal,@i_ciudad,@i_telefono,
                   @i_estado,@i_clase_tarjeta,@s_user)

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 103072
        /* 'Error en creacion de referencia de tarjeta'*/
        return 1
      end

      /* Transaccion servicios - cl_referencia */
      insert into ts_referencia
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,referencia,
                   tipo,tipo_cifras,numero_cifras,calificacion,verificacion,
                   vigencia,observacion,fecha_registro,banco,cuenta,
                   fecha_apert,monto,fec_exp_ref,tipo_cta,ciudad,
                   sucursal,telefono,estado,nacional)
      values      (@s_ssn,@t_trn,'N',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@o_siguiente,
                   'T',@i_tipo_cifras,@i_numero_cifras,@i_calificacion,'N',
                   'S',@i_observacion,getdate(),@i_banco,@i_cuenta,
                   @i_fecha_apertura,@i_monto,@i_fec_exp_ref,@i_clase_tarjeta,
                   @i_ciudad,
                   @i_sucursal,@i_telefono,@i_estado,@i_nacional)

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
    if @t_trn = 1362
    begin
      /* verificar que exista el tipo de referencia */
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_rtipo',
        @i_operacion = 'E',
        @i_codigo    = 'T'

      if @w_return <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /* 'No existe tipo de referencia '*/
        return 1
      end

      /* Verificar existencia de Ciudad */
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
            @i_num   = 101124
          /* 'No existe ciudad'*/
          return 1
        end
      end

      if @i_clase_tarjeta is not null
      begin
        /* verificar que exista la clase de tarjeta  */
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_tabla     = 'cl_clase_tarjeta',
          @i_operacion = 'E',
          @i_codigo    = @i_clase_tarjeta

        /* si no existe el tipo, error */
        if @w_return <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101180
          /* 'No existe clase de tarjeta'*/
          return 1
        end
      end
      /* verificar que exista el estado de la tarjeta */
      if @i_estado is not null
      begin
        exec @w_return = cobis..sp_catalogo
          @t_debug     = @t_debug,
          @t_file      = @t_file,
          @t_from      = @w_sp_name,
          @i_tabla     = 'cl_ereferencia',
          @i_operacion = 'E',
          @i_codigo    = @i_estado

        /* si no existe el estado */
        if @w_return <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101179
          /* 'No existe el estado de tarjeta'*/
          return 1
        end
      end
      /* verificar que exista el tipo de calificacion */
      exec @w_return = cobis..sp_catalogo
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_posicion',
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
          @i_num   = 101141
        /* 'No existe tipo de calificacion '*/
        return 1
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
          return @w_return
        end
      end

      select
        @w_fecha_nac = case en_subtipo
                         when 'P' then p_fecha_nac
                         else c_fecha_const
                       end,
        @w_tipo = en_subtipo
      from   cl_ente
      where  en_ente = @i_ente

      if @w_fecha_nac >= @i_fecha_apertura
         and (@w_tipo = 'P')
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107089
        return 1
      end

      if (@w_fecha_nac >= @i_fecha_apertura)
         and (@w_tipo = 'C')
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107090
        return 1
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
        @w_fecha_apertura = fecha_apertura,
        @w_monto = monto,
        @w_clase_tarjeta = clase_tarjeta,
        @w_ciudad = ciudad,
        @w_sucursal = sucursal,
        @w_telefono = telefono,
        @w_estado = estado,
        @w_nacional = nacional,
        @w_fec_exp_ref = fec_exp_ref,
        @w_resultado = resul_verif
      from   cl_tarjeta
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
        @v_monto = @w_monto,
        @v_clase_tarjeta = @w_clase_tarjeta,
        @v_ciudad = @w_ciudad,
        @v_sucursal = @w_sucursal,
        @v_telefono = @w_telefono,
        @v_estado = @w_estado,
        @v_nacional = @w_nacional,
        @v_fec_exp_ref = @w_fec_exp_ref,
        @v_resultado = @w_resultado

      if @w_fec_exp_ref = @i_fec_exp_ref
        select
          @w_fec_exp_ref = null,
          @v_fec_exp_ref = null
      else
        select
          @w_fec_exp_ref = @i_fec_exp_ref

      if @w_clase_tarjeta = @i_clase_tarjeta
        select
          @w_clase_tarjeta = null,
          @v_clase_tarjeta = null
      else
        select
          @w_clase_tarjeta = @i_clase_tarjeta

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

      if @w_nacional = @i_nacional
        select
          @w_nacional = null,
          @v_nacional = null
      else
        select
          @w_nacional = @i_nacional

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
      if @w_fecha_apertura = @i_fecha_apertura
        select
          @w_fecha_apertura = null,
          @v_fecha_apertura = null
      else
        select
          @w_fecha_apertura = @i_fecha_apertura

      if @w_resultado = @i_resultado
        select
          @w_resultado = null,
          @v_resultado = null
      else
        select
          @w_resultado = @i_resultado

      if @w_vigencia <> (select
                           vigencia
                         from   cl_tarjeta
                         where  ente       = @i_ente
                            and referencia = @i_referencia)
      begin
        select
          @w_vigencia = null,
          @v_vigencia = null
        --ream 06.abr.2010 control vigencia de datos del ente
        select
          @w_vigencia = (select
                           vigencia
                         from   cl_tarjeta
                         where  ente       = @i_ente
                            and referencia = @i_referencia)
      end
      else
        select
          @w_vigencia = (select
                           vigencia
                         from   cl_tarjeta
                         where  ente       = @i_ente
                            and referencia = @i_referencia)

      begin tran
      /* modificar los datos actuales */
      update cl_tarjeta
      set    banco = @i_banco,
             tipo_cifras = @i_tipo_cifras,
             numero_cifras = @i_numero_cifras,
             calificacion = @i_calificacion,
             verificacion = 'N',
             fecha_ver = @w_fecha_ver,
             fecha_modificacion = getdate(),
             vigencia = isnull(@w_vigencia,
                               null),
             --ream 06.abr.2010 control vigencia de datos del ente
             observacion = @i_observacion,
             cuenta = @i_cuenta,
             fecha_apertura = @i_fecha_apertura,
             monto = @i_monto,
             clase_tarjeta = @i_clase_tarjeta,
             ciudad = @i_ciudad,
             sucursal = @i_sucursal,
             telefono = @i_telefono,
             estado = @i_estado,
             nacional = @i_nacional,
             fec_exp_ref = @i_fec_exp_ref,
             funcionario = @s_user,
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
        /* 'Error en actualizacion de referencia de tarjeta'*/
        return 1
      end
      if @i_verificacion = 'S'
      begin
        update cl_tarjeta
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
          /* 'Error en actualizacion de referencia tarjeta'*/
          return 1
        end
      end

      insert into ts_referencia
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,referencia,
                   tipo,tipo_cifras,numero_cifras,calificacion,verificacion,
                   vigencia,observacion,fecha_modificacion,banco,fecha_ver,
                   cuenta,fecha_apert,monto,fec_exp_ref,tipo_cta,
                   ciudad,sucursal,telefono,estado,nacional)
      values      (@s_ssn,@t_trn,'P',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_referencia,
                   'T',@v_tipo_cifras,@v_numero_cifras,@v_calificacion,
                   @v_verificacion
                   ,
                   @v_vigencia,@v_observacion,@v_fecha_modificacion,
                   @v_banco,@v_fecha_ver,
                   @v_cuenta,@v_fecha_apertura,@v_monto,@v_fec_exp_ref,
                   @v_clase_tarjeta,
                   @v_ciudad,@v_sucursal,@v_telefono,@v_estado,@v_nacional)

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

      /* Transaccion servicios - cl_tarjeta */
      insert into ts_referencia
                  (secuencial,tipo_transaccion,clase,fecha,usuario,
                   terminal,srv,lsrv,ente,referencia,
                   tipo,tipo_cifras,numero_cifras,calificacion,verificacion,
                   vigencia,observacion,banco,fecha_ver,cuenta,
                   fecha_apert,monto,fec_exp_ref,tipo_cta,sucursal,
                   ciudad,telefono,nacional,estado)
      values      (@s_ssn,@t_trn,'A',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_referencia,
                   'T',@w_tipo_cifras,@w_numero_cifras,@w_calificacion,
                   @w_verificacion
                   ,
                   @w_vigencia,@w_observacion,
                   --ream 06.abr.2010 control vigencia de datos del ente
                   @w_banco,@w_fecha_ver,@w_cuenta,
                   @w_fecha_apertura,@w_monto,@w_fec_exp_ref,@w_clase_tarjeta,
                   @w_sucursal,
                   @w_ciudad,@w_telefono,@w_nacional,@w_estado)

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
    if @t_trn = 1363
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
        @w_fecha_apertura = fecha_apertura,
        @w_monto = monto,
        @w_ciudad = ciudad,
        @w_sucursal = sucursal,
        @w_telefono = telefono,
        @w_estado = estado,
        @w_nacional = nacional,
        @w_fec_exp_ref = fec_exp_ref
      from   cl_tarjeta
      where  ente       = @i_ente
         and referencia = @i_referencia

      /* si no existe referencia de tarjeta, error */
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
      delete from cl_tarjeta
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
                   vigencia,observacion,fecha_registro,banco,fecha_ver,
                   cuenta,fecha_modificacion,fecha_apert,monto,nacional,
                   sucursal,ciudad,telefono,estado,fec_exp_ref)
      values      (@s_ssn,@t_trn,'B',getdate(),@s_user,
                   @s_term,@s_srv,@s_lsrv,@i_ente,@i_referencia,
                   'T',@w_tipo_cifras,@w_numero_cifras,@w_calificacion,
                   @w_verificacion
                   ,
                   @w_vigencia,@w_observacion,@w_fecha_registro,@w_banco
                   ,@w_fecha_ver,
                   @w_cuenta,@w_fecha_modificacion,@w_fecha_apertura,@w_monto,
                   @w_nacional,
                   @w_sucursal,@w_ciudad,@w_telefono,@w_estado,@i_fec_exp_ref)

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
  return 0

go

