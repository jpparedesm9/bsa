use cob_ahorros
go

/************************************************************************/
/*  Archivo:            tr_cons_ah.sp                                   */
/*  Stored procedure:   sp_tr_cons_ah                                   */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto: Cuentas de Ahorros                                        */
/*      Disenado por:  Mauricio Bayas/Sandra Ortiz                      */
/*  Fecha de escritura: 26-Feb-1993                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*  Este programa realiza la transaccion de consulta de datos           */
/*  generales y datos financieros de cuentas de ahorros                 */
/*  230 = Consulta de cuentas.                                          */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*  26/Feb/1993     P Mena         Emision inicial                      */
/*  15/Dic/1993     P Mena         Personalizacion para Banco de        */
/*                                 Credito                              */
/*  24/Feb/2010     R. Altamirano  Consulta de Saldo en Caja            */
/*  17/Abr/2012     L. Moreno      REQ-203:Cobro de comision por trn    */
/*  02/Mayo/2016    Walther Toledo Migración a CEN                      */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_cons_ah')
  drop proc sp_tr_cons_ah
go

create proc sp_tr_cons_ah
(
  @s_ssn           int,
  @s_ssn_branch    int = null,--ALF
  @s_srv           varchar(30)= null,
  @s_lsrv          varchar(30)= null,
  @s_user          varchar(30)= null,
  @s_sesn          int = null,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_ofi           smallint,/* Localidad origen transaccion */
  @s_rol           smallint = 1,
  @s_org_err       char(1) = null,/* Origen de ERROR: [A], [S] */
  @s_error         int = null,
  @s_sev           tinyint = null,
  @s_msg           mensaje = null,
  @s_org           char(1),
  @t_debug         char(1) = 'N',
  @t_file          varchar(14)= null,
  @t_from          varchar(32)= null,
  @t_rty           char(1) = 'N',
  @t_trn           smallint,
  @t_show_version  bit = 0,
  @i_cta           cuenta,
  @i_mon           tinyint,
  @i_formato_fecha int = 101,

  --ream 24.feb.2010 consulta de saldo en caja
  @i_caja          char(1) = 'N',
  @i_comision      money = 0,--REQ 203
  @i_causal        char(3) = '',--REQ 203
  @o_nombre        varchar(64)= '' out,
  @o_disponible    money = 0 out,
  @o_canje         money = 0 out,
  @o_remesas       money = 0 out,
  @i_escliente     char(1) = 'N',
  @o_vlrbloq       money = 0 out,
  @o_total         money = 0 out,
  @o_gmf           money = 0 out,
  @o_valiva        money = 0 out
--ream 24.feb.2010 consulta de saldo en caja

)
as
  declare
    @w_return    int,
    @w_sp_name   varchar(30),
    @w_rpc       descripcion,
    @w_filial    tinyint,
    @w_oficina   smallint,
    @w_producto  tinyint,
    @w_srv_rem   descripcion,
    @w_srv_local descripcion,
    @w_tipo      char(1)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_tr_cons_ah'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  /*  Modo de debug  */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**  Stored Procedure  **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
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
      s_ori = @s_org,
      t_from = @t_from,
      t_file = @t_file,
      t_rty = @t_rty,
      t_trn = @t_trn,
      i_cta = @i_cta,
      i_mon = @i_mon
    exec cobis..sp_end_debug
  end

  /* Valida el producto para la oficina */
  if isnull(@s_ofi,
            0) <> 0
  begin
    exec @w_return = cobis..sp_val_prodofi
      @i_modulo  = 4,
      @i_oficina = @s_ofi
    if @w_return <> 0
      return @w_return
  end

  /* Chequeo de errores generados remotamente */
  if @s_org_err is not null /* Error del Sistema */
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @s_error,
      @i_sev   = @s_sev,
      @i_msg   = @s_msg
    return 1
  end

  /*  Captura de parametros de la oficina  */
  exec @w_return = cobis..sp_parametros
    @t_debug        = @t_debug,
    @t_file         = @t_file,
    @t_from         = @w_sp_name,
    @s_lsrv         = @s_lsrv,
    @i_nom_producto = 'CUENTA%AHORROS',
    @o_oficina      = @w_oficina out,
    @o_producto     = @w_producto out
  if @w_return <> 0
    return @w_return

  /*  Determinacion de condicion de local o remoto  */
  exec @w_return = cob_ahorros..sp_cta_origen
    @t_debug    = @t_debug,
    @t_file     = @t_file,
    @t_from     = @w_sp_name,
    @i_cta      = @i_cta,
    @i_producto = @w_producto,
    @i_mon      = @i_mon,
    @i_oficina  = @w_oficina,
    @o_tipo     = @w_tipo out,
    @o_srv_local= @w_srv_local out,
    @o_srv_rem  = @w_srv_rem out

  if @w_return <> 0
    return @w_return

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      origen = @s_org,
      tipo = @w_tipo,
      srv_loc = @w_srv_local,
      srv_rem = @w_srv_rem
    exec cobis..sp_end_debug
  end

  select
    @w_srv_local = @s_lsrv

  select
    @w_rpc = 'sp_consulta_ah'
  if @w_tipo = 'L'
    select
      @w_rpc = 'cob_ahorros..' + @w_rpc
  else
    select
      @w_rpc = @w_srv_local + '.' + @w_srv_rem + '.' + 'cob_ahorros.' + @w_rpc

  begin tran
  if @w_tipo = 'L'
    exec @w_return = @w_rpc
      @s_ssn           = @s_ssn,
      @s_ssn_branch    = @s_ssn_branch,
      @s_date          = @s_date,
      @s_sesn          = @s_sesn,
      @s_org           = @s_org,
      @s_srv           = @s_srv,
      @s_user          = @s_user,
      @s_term          = @s_term,
      @s_ofi           = @s_ofi,
      @s_rol           = @s_rol,
      @s_org_err       = @s_org_err,
      @s_error         = @s_error,
      @s_sev           = @s_sev,
      @s_msg           = @s_msg,
      @t_debug         = @t_debug,
      @t_file          = @t_file,
      @t_from          = @t_from,
      @t_rty           = @t_rty,
      @t_trn           = @t_trn,
      @i_cta           = @i_cta,
      @i_mon           = @i_mon,
      @i_formato_fecha = @i_formato_fecha,
      --ream 24.feb.2010 consulta de saldo en caja
      @i_caja          = @i_caja,
      @i_escliente     = @i_escliente,
      @i_comision      = @i_comision,--REQ 203
      @i_causal        = @i_causal,--REQ 203
      @o_nombre        = @o_nombre out,
      @o_disponible    = @o_disponible out,
      @o_canje         = @o_canje out,
      @o_remesas       = @o_remesas out,
      @o_vlrbloq       = @o_vlrbloq out,
      @o_total         = @o_total out,
      @o_gmf           = @o_gmf out,
      @o_valiva        = @o_valiva out
  --ream 24.feb.2010 consulta de saldo en caja
  else
    exec @w_return = @w_rpc
      @s_srv           = @s_srv,
      @s_user          = @s_user,
      @s_term          = @s_term,
      @s_ofi           = @s_ofi,
      @s_rol           = @s_rol,
      @s_org_err       = @s_org_err,
      @s_error         = @s_error,
      @s_sev           = @s_sev,
      @s_msg           = @s_msg,
      @t_debug         = @t_debug,
      @t_file          = @t_file,
      @t_from          = @t_from,
      @t_rty           = @t_rty,
      @t_trn           = @t_trn,
      @i_cta           = @i_cta,
      @i_mon           = @i_mon,
      @i_escliente     = @i_escliente,
      @i_formato_fecha = @i_formato_fecha,
      @i_comision      = @i_comision,--REQ 203
      @i_causal        = @i_causal,--REQ 203
      --ream 24.feb.2010 consulta de saldo en caja
      @i_caja          = @i_caja,
      @o_nombre        = @o_nombre out,
      @o_disponible    = @o_disponible out,
      @o_canje         = @o_canje out,
      @o_remesas       = @o_remesas out,
      @o_vlrbloq       = @o_vlrbloq out,
      @o_total         = @o_total out,
      @o_gmf           = @o_gmf out,
      @o_valiva        = @o_valiva out
  --ream 24.feb.2010 consulta de saldo en caja

  if @w_return <> 0
  begin
    rollback tran
    /* Si se presenta error por fondos insuficientes, cuenta cancelada o cuenta inactiva se registra rechazo */
    if @i_comision <> 0
       and (@w_return in (251007, 251033, 251057, 251058))
    begin
      exec cob_remesas..sp_re_rechazos
        @s_ofi      = @s_ofi,
        @t_trn      = @t_trn,
        @i_cta      = @i_cta,
        @i_modulo   = 4,
        @i_vlr_comi = @i_comision,
        @i_vlr_iva  = 0,
        @i_causal   = @w_return
    end
    return @w_return
  end

  exec @w_return = sp_act_cont_trn
    @s_date       = @s_date,
    @t_debug      = @t_debug,
    @i_operacion  = 'I',
    @i_cta        = @i_cta,
    @i_trn_accion = @t_trn

  if @w_return <> 0
  begin
    rollback tran
    return @w_return
  end

  commit tran

go

