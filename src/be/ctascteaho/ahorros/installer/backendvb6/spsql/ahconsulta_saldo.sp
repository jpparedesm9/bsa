/************************************************************************/
/*  Archivo:            ahconsulta_saldo.sp                             */
/*  Stored procedure:   sp_ahconsulta_saldo                             */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 04/Mayo/2016                                    */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
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
/*  Este programa realiza la consulta de saldos                         */
/************************************************************************/
/*              MODIFICACIONES                                          */
/* FECHA         AUTOR           RAZON                                  */
/* 02/Mayo/2016  Ignacio Yupa    Migración a CEN                        */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ahconsulta_saldo')
  drop proc sp_ahconsulta_saldo
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ahconsulta_saldo
(
  @s_ssn           int,
  @s_ssn_branch    int = null,
  @s_srv           varchar(30),
  @s_user          varchar(30),
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_org           char(1),
  @s_ofi           smallint,/* Localidad origen transaccion */
  @s_rol           smallint = 1,
  @s_org_err       char(1) = null,
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           mensaje = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_trn           smallint,
  @t_corr          char(1) = 'N',
  @t_ssn_corr      int = null,
  @t_show_version  bit = 0,
  @i_cta           cuenta,
  @i_srvorg        char(8),
  @i_comision      money = 0,
  @i_num_trans     int,
  @i_cliente       int,
  @i_mon           tinyint,
  @i_tarjeta       cuenta,
  @i_cotiz_atm     float,
  @i_localidad     varchar(48) = null,
  @i_srv_org       char(8) = null,
  @i_cajero_propio char(1) = 'N',
  @i_canal         smallint = null,
  @i_stand_in      char(1) = 'N',
  @i_cau_comi      varchar(3) = null,
  @i_concepto      varchar(40) = null
)
as
  declare
    @w_return           int,
    @w_sp_name          varchar(30),
    @w_cuenta           int,
    @w_tipo_vinculacion catalogo,
    @w_num_trans        smallint,
    @w_monto_imp        money,
    @w_cau              char(3),
    @w_comision         money,
    @w_oficina          smallint,
    @w_disponible       money,
    @w_12h              money,
    @w_24h              money,
    @w_48h              money,
    @w_remesas          money,
    @w_monto_blq        money,
    @w_monto_consumos   money,
    @w_saldo_contable   money,
    @w_saldo_para_girar money,
    @w_estado           char(1),
    @w_saldo_minimo     money,
    @w_nemonico         varchar(5),
    @w_monto_emb        money,
    @w_cred_24          char(1),
    @w_linea_cr24h      money,
    @w_cred_rem         char(1),
    @w_linea_crrem      money,
    @w_monto_bloq       money,
    @w_moneda           tinyint,
    @w_fecha_sistema    datetime

  /* Captura del nombre del Store Procedure */
  select
    @w_sp_name = 'sp_ahconsulta_saldo'
  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end
  -- Captura de fecha del sistema           -- mgt
  select
    @w_fecha_sistema = getdate() -- mgt

  /* Modo de debug */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/** Store Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_ssn_branch = @s_ssn_branch,
      s_srv = @s_srv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_org = @s_org,
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
      i_srvorg = @i_srvorg,
      i_comision = @i_comision,
      i_num_trans = @i_num_trans,
      i_cliente = @i_cliente,
      i_mon = @i_mon
    exec cobis..sp_end_debug
  end

  if @t_trn not in (307, 273) ---307=tran.nacional 273 =tran internacional  
  begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201048
    return 1
  end

  /* Verificar la vigencia de la cuenta */
  exec @w_return = cob_ahorros..sp_ctah_vigente
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_cta_banco = @i_cta,
    @i_moneda    = @i_mon,
    @o_cuenta    = @w_cuenta out

  if @w_return <> 0
    return @w_return

  if @i_srvorg in ('FX11NAC', 'FX11INT')
    select
      @w_comision = @i_comision,
      @w_cau = @i_cau_comi --- '142'
  else
  begin
    /* Determinacion de si el cliente es funcionario */
    select
      @w_tipo_vinculacion = en_tipo_vinculacion
    from   cobis..cl_ente
    where  en_ente = @i_cliente

    if @@rowcount = 0
    begin
      /* No existe ente */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 701088
      return 1
    end

    /* Obtencion del numero de transacciones por cliente */

    if @w_tipo_vinculacion = 'EM' /* si es funcionario */
      select
        @w_nemonico = 'NTE'
    else
      select
        @w_nemonico = 'NTC'

    select
      @w_num_trans = pa_int
    from   cobis..cl_parametro
    where  pa_nemonico = @w_nemonico
       and pa_producto = 'ATM'

    if @@rowcount <> 1
      select
        @w_num_trans = -1

    /* Si el num de transaccion es mayor o igual que el num de 
       transacciones libres y la comision es mayor que 
       cero entonces cobrar la comision     */

    if @i_num_trans >= @w_num_trans
      select
        @w_comision = @i_comision
    else
      select
        @w_comision = $0

    select
      @w_cau = @i_cau_comi -- '141'

  end

  if @w_comision > 0
  begin
    /* Cobro de Comision */
    exec @w_return = cob_ahorros..sp_ahndc_automatica
      @s_srv           = @s_srv,
      @s_ofi           = @s_ofi,
      @s_ssn           = @s_ssn,
      @s_ssn_branch    = @s_ssn_branch,
      @s_user          = @s_user,
      @s_term          = @s_term,
      @t_trn           = 264,
      @t_corr          = @t_corr,
      @t_ssn_corr      = @t_ssn_corr,
      @i_cta           = @i_cta,
      @i_val           = @w_comision,
      @i_cau           = @w_cau,
      @i_mon           = @i_mon,
      @i_fecha         = @s_date,
      @i_imp           = 'S',
      @i_localidad     = @i_localidad,
      @i_serial        = @i_tarjeta,
      @i_atm_server    = 'S',
      @i_srvorg        = @i_srv_org,
      @i_cajero_propio = @i_cajero_propio,
      @i_canal         = @i_canal,
      @i_stand_in      = @i_stand_in,
      @i_concepto      = @i_concepto,
      @o_monto_imp     = @w_monto_imp

    if @w_return <> 0
      return @w_return
  end

  select
    @w_cuenta = ah_cuenta,
    @w_moneda = ah_moneda,
    @w_estado = ah_estado,
    @w_oficina = ah_oficina,
    @w_disponible = ah_disponible,
    @w_12h = ah_12h,
    @w_24h = ah_24h,
    @w_48h = ah_48h,
    @w_remesas = ah_remesas,
    @w_cred_24 = ah_cred_24,
    @w_cred_rem = ah_cred_rem,
    @w_monto_bloq = ah_monto_bloq,
    @w_monto_emb = ah_monto_emb,
    @w_monto_consumos = ah_monto_consumos
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = @i_cta

  /* Chequeo de existencias */
  if @@rowcount <> 1
  begin
    /* No existe cuenta_banco */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251001
    return 1
  end

  /* Validaciones */
  if @w_estado <> 'A'
  begin
    /* Cuenta no activa o cancelada */
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 251002
    return 1
  end

  /*  Determina saldo minimo para cuentas de ahorros  */
  select
    @w_saldo_minimo = pd_saldo_minimo
  from   cobis..cl_producto
  where  pd_descripcion like 'CUENTA DE AHORROS'

  if @@rowcount <> 1
  begin
    /*  Producto no existe o definicion de producto no corresponde  */
    exec cobis..sp_cerror
      @t_debug= @t_debug,
      @t_file = @t_file,
      @t_from = @w_sp_name,
      @i_num  = 101032
    return 101032
  end

  -- Calculo del saldo para girar
  if @w_cred_24 = 'S'
  begin
    select
      @w_linea_cr24h = lc_monto_aut
    from   cob_ahorros..ah_lincredito
    where  lc_cuenta    = @w_cuenta
       and lc_tipo      = 'L'
       and lc_fecha_aut <= @s_date
       and lc_fecha_ven >= @s_date
    if @@rowcount = 0
      select
        @w_linea_cr24h = 0
  end
  else
    select
      @w_linea_cr24h = 0

  if @w_cred_rem = 'S'
  begin
    select
      @w_linea_crrem = lc_monto_aut
    from   cob_ahorros..ah_lincredito
    where  lc_cuenta    = @w_cuenta
       and lc_tipo      = 'R'
       and lc_fecha_aut <= @s_date
       and lc_fecha_ven >= @s_date
    if @@rowcount = 0
      select
        @w_linea_crrem = 0
  end
  else
    select
      @w_linea_crrem = 0

  select
    @w_saldo_para_girar = @w_disponible - @w_monto_bloq - @w_monto_consumos
                                                          - @w_monto_emb
  select
    @w_saldo_contable = @w_12h + @w_24h + @w_48h

  if @w_linea_cr24h < @w_saldo_contable
    select
      @w_saldo_para_girar = @w_saldo_para_girar + @w_linea_cr24h
  else
    select
      @w_saldo_para_girar = @w_saldo_para_girar + @w_saldo_contable

  if @w_linea_crrem < @w_remesas
    select
      @w_saldo_para_girar = @w_saldo_para_girar + @w_linea_crrem
  else
    select
      @w_saldo_para_girar = @w_saldo_para_girar + @w_remesas

  select
    @w_saldo_contable = @w_saldo_contable + @w_disponible + @w_remesas,
    @w_saldo_para_girar = @w_saldo_para_girar - @w_saldo_minimo

  /* Envio de resultados a ATM */
  select
    'results_submit_rpc',
    r_cta_deb = @i_cta,
    r_ofi_cta_deb = @w_oficina,
    r_sld_disp_deb = @w_disponible,
    r_sld_cont_deb = @w_saldo_contable,
    r_sld_girar_deb = @w_saldo_para_girar,
    r_sld_12h_deb = @w_12h,
    r_sld_24h_deb = @w_24h,
    r_sld_48h_deb = @w_48h,
    r_sld_rem_deb = @w_remesas,
    r_monto_blq_deb = @w_monto_blq,
    r_monto_sob_deb = 0,
    r_estado_deb = @w_estado,
    r_ssn_host = @s_ssn,
    r_fecha_cont = @s_date,
    r_fecha_host = @w_fecha_sistema,
    r_comision_host = @w_comision,
    r_cotiz_atm = @i_cotiz_atm

  return 0

go

