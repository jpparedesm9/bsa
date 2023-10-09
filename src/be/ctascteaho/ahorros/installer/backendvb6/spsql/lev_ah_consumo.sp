/************************************************************************/
/*      Archivo:                ahtlevco.sp                             */
/*      Stored procedure:       sp_lev_ah_consumo                       */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           Veronica Molina                         */
/*      Fecha de escritura:     01-Jul-1999                             */
/************************************************************************/
/*                             IMPORTANTE                               */
/*      Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*      de COBISCorp.                                                   */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno  de sus        */
/*      usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*      Este programa esta protegido por la ley de derechos de autor    */
/*      y por las convenciones  internacionales de propiedad inte-      */
/*      lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*      obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*      penalmente a los autores de cualquier infraccion.               */
/************************************************************************/
/*                              PROPOSITO                               */
/*    Este programa realiza la transaccion de Levantamientos de consumo */
/*       306 = Levantamiento de Consumos  de Ahorros de Tarjetas        */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      01/Jul/1999     V.Molina        Emision inicial                 */
/*      18/Oct/1999     Juan F. Cadena  Inclusion de la comision en bloq*/
/*      04/May/2016     J. Salazar      Migracion COBIS CLOUD MEXICO    */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_lev_ah_consumo')
  drop proc sp_lev_ah_consumo
go

/****** Object:  StoredProcedure [dbo].[sp_lev_ah_consumo]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_lev_ah_consumo
(
  @s_ssn           int,
  @s_ssn_branch    int,
  @s_srv           varchar(30),
  @s_lsrv          varchar(30),
  @s_user          varchar(30),
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_org           char(1),
  @s_ofi           smallint,/* Localidad origen transaccion */
  @s_rol           smallint = 1,
  @s_org_err       char(1) = null,/* Origen de error:[A], [S] */
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           mensaje = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_trn           smallint,
  @t_show_version  bit = 0,
  @i_cta           cuenta,
  @i_clave         int,
  @i_mon           tinyint,
  @i_valor         money,
  @i_fecha         datetime,
  @i_turno         smallint = null,
  @o_tarjeta       cuenta out,
  @o_valor_imp     money out,
  @o_oficina_cta   smallint out,
  @o_prod_banc     tinyint out,
  @o_categoria     char(1) out,
  @o_tipocta_super char(1) out
)
as
  declare
    @w_return         int,
    @w_sp_name        varchar(30),
    @w_cuenta         int,
    @w_oficina        smallint,
    @w_ofi            smallint,
    @w_est            char(1),
    @w_estado         char(1),
    @w_clave          varchar(5),
    @w_filial         tinyint,
    @w_producto       tinyint,
    @w_fecha_ven      smalldatetime,
    @w_tipo_bloqueo   char(1),
    @w_monto_consumos money,
    @w_fecha          datetime,
    @w_valor          money,
    @w_valor_imp      money,
    @w_sec            int,
    @w_numdeci        tinyint,
    @w_usadeci        char(1),
    @w_mensaje        varchar(24),
    @w_comision       money,
    @w_comision_imp   money

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_lev_ah_consumo'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  if @i_turno is null
    select
      @i_turno = @s_rol

  /* Modo de debug */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/** Store Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      t_debug = @t_debug,
      t_file = @t_file,
      t_from = @t_from,
      t_rty = @t_rty,
      t_trn = @t_trn,
      i_cta = @i_cta,
      i_clave = @i_clave,
      i_mon = @i_mon,
      i_valor = @i_valor,
      i_fecha = @i_fecha
    exec cobis..sp_end_debug
  end

  if @t_trn <> 306
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end

  select
    @w_cuenta = ah_cuenta,
    @w_est = ah_estado,
    @w_filial = ah_filial,
    @o_oficina_cta = ah_oficina,
    @w_producto = ah_producto,
    @w_monto_consumos = ah_monto_consumos,
    @o_prod_banc = ah_prod_banc,
    @o_categoria = ah_categoria,
    @o_tipocta_super = ah_tipocta_super
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = @i_cta
     and ah_moneda    = @i_mon

  if @@rowcount = 0
  begin
    /* No existe cuenta_banco */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201004
    return 1
  end

  /*  Determinacion de bloqueo de cuenta  */
  select
    @w_tipo_bloqueo = cb_tipo_bloqueo
  from   cob_ahorros..ah_ctabloqueada
  where  cb_cuenta = @w_cuenta
     and cb_estado = 'V'
     and cb_tipo_bloqueo in ('3', '2')
  if @@rowcount <> 0
  begin
    select
      @w_mensaje = rtrim (valor)
    from   cobis..cl_catalogo
    where  tabla  = (select
                       codigo
                     from   cobis..cl_tabla
                     where  tabla = 'ah_tbloqueo')
       and codigo = @w_tipo_bloqueo
    select
      @w_mensaje = 'Cuenta bloqueada: ' + @w_mensaje
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201008,
      @i_sev   = 1,
      @i_msg   = @w_mensaje
    return 1
  end

  /* Validaciones */
  if @w_est <> 'A'
  begin
    /* Cuenta no activa o cancelada */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251002
    return 1
  end

  /* Verifico la existencia del consumo */

  if not exists (select
                   1
                 from   cob_remesas..re_his_consumo
                 where  hc_producto = @w_producto
                    and hc_cuenta   = @i_cta
                    and hc_clave    = @i_clave)
  begin
    /*  No Existe consumo para la Cuenta */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201237
    return 1
  end

  select
    @w_fecha = hc_fecha,
    @w_valor = hc_valor,
    @o_valor_imp = hc_valor_imp,
    @o_tarjeta = hc_tarjeta,
    @w_estado = hc_estado,
    @w_comision = hc_comision,
    @w_comision_imp = hc_comision_imp
  from   cob_remesas..re_his_consumo
  where  hc_producto = @w_producto
     and hc_cuenta   = @i_cta
     and hc_clave    = @i_clave

  if @i_fecha <> @w_fecha
  begin
    /*  LA FECHA DEL CONSUMO NO COINCIDE */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201238
    return 1
  end

  if @i_valor <> @w_valor
  begin
    /*  El valor el consumo no coincide */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201239
    return 1
  end

  if @w_estado = 'L'
  begin
    /*  El consumo ya fue levantado */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201240
    return 1
  end

  if @w_estado = 'F'
  begin
    /*  El consumo ya fue ejecutado */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201243
    return 1
  end

  if @w_estado in ('R', 'P')
  begin
    /*  El consumo ya fue rechazado o perdido */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201245
    return 1
  end

  if @w_estado = 'E'
  begin
    /*  El consumo ya fue rechazado o perdido */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201244
    return 1
  end

  begin tran

  /* Actualizar los campos del consumo en la tabla ah_cuenta */

  update cob_ahorros..ah_cuenta
  set    ah_monto_consumos = @w_monto_consumos - (@w_valor + @o_valor_imp +
                                                  @w_comision +
                                                         @w_comision_imp)
  where  ah_cuenta = @w_cuenta

  if @@rowcount <> 1
  begin
    /* Error en actualizacion de registro en ah_cuenta */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 205001
    return 1
  end

  /* Actualizar los datos de la tabla re_his_consumo */

  update cob_remesas..re_his_consumo
  set    hc_estado = 'L',
         hc_levantado = 'S',
         hc_fecha_fin = @s_date
  where  hc_producto = @w_producto
     and hc_cuenta   = @i_cta
     and hc_clave    = @i_clave

  if @@rowcount <> 1
  begin
    /* Error en actualizacion de registro en re_his_consumo */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 355028
    return 1
  end

  /* Creacion de transaccion de servicio */
  insert into cob_ahorros..ah_tsconsumo
              (secuencial,ssn_branch,tipo_transaccion,tsfecha,usuario,
               terminal,oficina,reentry,origen,cta_banco,
               fecha,valor,moneda,hora,tarjeta,
               estado,estado_consumo,clave,oficina_cta,monto_imp,
               prod_banc,categoria,tipocta_super,turno)
  values      (@s_ssn,@s_ssn_branch,@t_trn,@s_date,@s_user,
               @s_term,@s_ofi,@t_rty,@s_org,@i_cta,
               @i_fecha,@i_valor,@i_mon,getdate(),@o_tarjeta,
               null,'L',@i_clave,@o_oficina_cta,@o_valor_imp,
               @o_prod_banc,@o_categoria,@o_tipocta_super,@i_turno)

  if @@error <> 0
  begin
    /* Error en creacion de transaccion de servicio */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 203005
    return 1
  end

  commit tran
  return 0

go

