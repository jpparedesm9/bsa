/*****************************************************************************/
/*  Archivo:            ah_retemb_locrem.sp                                  */
/*  Stored procedure:   sp_ah_retemb_locrem                                  */
/*  Base de datos:      cob_ahorros                                          */
/*  Producto:           Cuentas de Ahorros                                   */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                          */
/*  Fecha de escritura: 10-Feb-1993                                          */
/*****************************************************************************/
/*              IMPORTANTE                                                   */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad             */
/*  de COBISCorp.                                                            */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como         */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus         */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.        */
/*  Este programa esta protegido por la ley de   derechos de autor           */
/*  y por las    convenciones  internacionales   de  propiedad inte-         */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp par       */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir             */
/*  penalmente a los autores de cualquier   infraccion.                      */
/*****************************************************************************/
/*              PROPOSITO                                                    */
/*  Este programa procesa las transacciones de:                              */
/*      Retiro y Nota de Debito SIN LIBRETA                                  */
/*****************************************************************************/
/*              MODIFICACIONES                                               */
/*  FECHA           AUTOR                   RAZON                            */
/*  10/Feb/1993     X Gellibert Coello      Emision Inicial                  */
/*  23/Nov/1993     J Navarrete V.          Modificaciones Generales         */
/*  19/Ene/1996     D Villafuerte           Control Calidad (par rem)        */
/*  15/Nov/1999     George F.George         Aumento de parametro @i_serial   */
/*                                          para n. de debito c/serial.      */
/*  12/Sep/2000     Yenny Rivero            Requerimiento de los Totales de  */
/*                                          cajero (optimizacion de los re-- */
/*                                          portes de TOTALES DE OPERADOR    */
/*                                          (ATX) y TOTALES DE OFICINA (TA)  */
/*  2002/11/22      Carlos Cruz D.          Branch III                       */
/*  02/Mayo/2016    Ignacio Yupa            Migración a CEN                  */
/*****************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_retemb_locrem')
  drop proc sp_ah_retemb_locrem
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_retemb_locrem
(
  @s_ssn                int,
  @s_ssn_branch         int = null,/*Cambios BRANCHII */
  @s_lsrv               varchar(30),
  @s_srv                varchar(30),
  @s_user               varchar(30),
  @s_sesn               int,
  @s_term               varchar(10),
  @s_date               smalldatetime,
  @s_ofi                smallint,/* Localidad origen transaccion */
  @s_rol                smallint,
  @s_sev                tinyint,
  @p_lssn               int = null,
  @t_corr               char(1) = 'N',
  @t_ssn_corr           int = null,
  @p_rssn_corr          int = null,
  @t_debug              char(1) = 'N',
  @t_file               varchar(14) = null,
  @t_ejec               char(1) = 'N',/*Cambios BRANCHII */
  @t_from               varchar(32) = null,
  @t_rty                char(1) = 'N',
  @t_show_version       bit = 0,
  @s_org                char(1),
  @t_trn                int,
  @i_cod_alterno        int,
  @i_cta                cuenta,
  @i_mon                tinyint,
  @i_val                money,
  @i_valch              money = null,
  @i_ind                tinyint,
  @i_cau                char(3),
  @i_dep                smallint,
  @i_oficina            smallint,
  @i_concep             varchar(30) = null,
  @i_chqrem             int = null,
  @i_lpend              int,
  @i_ncontrol           int,
  @i_dif                char(1) = 'N',
  @i_ActTot             char(1) = 'S',
  @i_serial             varchar(30) = null,
  @i_turno              smallint = null,
  @i_sld_caja           money = 0,
  @i_idcierre           int = 0,
  @i_filial             smallint = 1,
  @i_idcaja             int = 0,

  --CCR BRANCH III
  @i_fecha_valor_a      datetime = null,
  @o_sldcont            money out,
  @o_slddisp            money out,
  @o_val_ser            money out,
  @o_val_mon            money out,
  @o_sus_flag           tinyint out,
  @o_nombre             varchar(60) out,
  @o_cedula             varchar(12) out,
  @o_cliente            int = 0 out,
  @o_prod_banc          smallint = null out,
  @o_categoria          char(1) = null out,
  @o_monto_imp          money out,
  @o_val_2x1000         money out,
  @o_comision           money out,
  @o_tipo_exonerado_imp char(2) out,
  @o_alerta_cli         varchar(40) = null out,
  @o_base_gmf           money = null out,
  @o_clase_clte         char(1) = null out
)
as
  declare
    @w_return        int,
    @w_sp_name       varchar(30),
    @w_cuenta        int,
    @w_filial_p      tinyint,
    @w_oficina_p     smallint,
    @w_factor        int,
    @w_tipo_promedio char(1),
    @w_signo         char(1),
    @w_efe           money,
    @w_prop          money,
    @w_loc           money,
    @w_rem           money,
    @w_estado        char(1),
    @w_monto_imp     money,
    @w_val_mon       money,
    @w_val           money,
    @w_ssn_tmp       int,
    @w_suspenso      char(1),
    @w_tipocta_super char(1),
    @w_valiva        money,
    @w_val_2x1000    money,
    @w_impuesto      money,
    @w_idorden       int

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_retemb_locrem'
  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
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
      s_lsrv = @s_lsrv,
      s_srv = @s_srv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_sev = @s_sev,
      p_lssn = @p_lssn,
      t_corr = @t_corr,
      t_debug = @t_debug,
      t_from = @t_from,
      t_file = @t_file,
      t_rty = @t_rty,
      s_ori = @s_org,
      t_trn = @t_trn,
      i_cuenta = @w_cuenta,
      i_cta = @i_cta,
      i_mon = @i_mon,
      i_val = @i_val,
      i_int = @i_ind,
      i_cau = @i_cau,
      i_serial = @i_serial
    exec cobis..sp_end_debug
  end

  /*  Modo de correccion  */
  if @t_corr = 'N'
    select
      @w_factor = 1,
      @w_signo = 'D'
  else
    select
      @w_factor = -1,
      @w_signo = 'C'

  /*  Determinacion de vigencia de cuenta  */
  exec @w_return = cob_ahorros..sp_ctah_vigente
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_cta_banco = @i_cta,
    @i_moneda    = @i_mon,
    @o_cuenta    = @w_cuenta out,
    @o_filial    = @w_filial_p out,
    @o_oficina   = @w_oficina_p out,
    @o_tpromedio = @w_tipo_promedio out
  if @w_return <> 0
    return @w_return

  if @i_turno is null
    select
      @i_turno = @s_rol

  /*  Retiro y Nota debito sin libreta */
  begin tran

  select
    @w_monto_imp = $0

  if @w_factor = -1
  begin
    if @t_trn = 392
    begin
      select
        @w_monto_imp = isnull(tm_monto_imp,
                              0)
      from   cob_ahorros..ah_tran_monet
      where  tm_ssn_branch  = @t_ssn_corr
         and tm_oficina     = @s_ofi -- EAL RETCALL. 
         and tm_cod_alterno = @i_cod_alterno
         and tm_tipo_tran   = @t_trn
         and tm_cta_banco   = @i_cta
         and tm_valor       = @i_val
         and tm_moneda      = @i_mon
         and tm_usuario     = @s_user
         and tm_estado is null

      if @@rowcount <> 1
      begin
        /* Error en los datos del reverso */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251067
        return 1
      end
    end
  end

  exec @w_return = cob_ahorros..sp_retiro_monto_emb
    @t_debug              = @t_debug,
    @t_file               = @t_file,
    @t_from               = @w_sp_name,
    @t_trn                = @t_trn,
    @t_corr               = @t_corr,
    @p_lssn               = @p_lssn,
    @p_rssn_corr          = @p_rssn_corr,
    @t_rty                = @t_rty,
    @t_ejec               = @t_ejec,/*Cambios BRANCHII */
    @s_ofi                = @s_ofi,
    @s_sev                = @s_sev,
    @s_lsrv               = @s_lsrv,
    @s_srv                = @s_srv,
    @s_user               = @s_user,
    @s_term               = @s_term,
    @s_ssn                = @s_ssn,
    @s_ssn_branch         = @s_ssn_branch,/*Camb BRANCHII */
    @s_org                = @s_org,
    @s_date               = @s_date,/* Branch II */
    @t_ssn_corr           = @t_ssn_corr,
    @i_cta                = @i_cta,
    @i_cuenta             = @w_cuenta,
    @i_mon                = @i_mon,
    @i_val                = @i_val,
    @i_ind                = @i_ind,
    @i_cau                = @i_cau,
    @i_factor             = @w_factor,
    @i_fecha              = @s_date,
    @i_lpend              = @i_lpend,
    @i_ncontrol           = @i_ncontrol,
    @i_dif                = @i_dif,
    @i_monto_imp          = @w_monto_imp,
    @i_filial             = @i_filial,
    @i_idcaja             = @i_idcaja,
    @i_idcierre           = @i_idcierre,
    @i_sld_caja           = @i_sld_caja,
    --CCR BRANCH III
    @i_fecha_valor_a      = @i_fecha_valor_a,
    @o_sldcont            = @o_sldcont out,
    @o_slddisp            = @o_slddisp out,
    @o_val_ser            = @o_val_ser out,
    @o_val_mon            = @o_val_mon out,
    @o_sus_flag           = @o_sus_flag out,
    @o_nombre             = @o_nombre out,
    @o_cedula             = @o_cedula out,
    @o_cliente            = @o_cliente out,
    @o_prod_banc          = @o_prod_banc out,
    @o_categoria          = @o_categoria out,
    @o_monto_imp          = @o_monto_imp out,
    @o_val_2x1000         = @w_val_2x1000 out,
    @o_tipo_exonerado_imp = @o_tipo_exonerado_imp out,
    @o_tipocta_super      = @w_tipocta_super out,
    @o_valiva             = @w_valiva out,
    @o_comision           = @o_comision out,
    @o_alerta_cli         = @o_alerta_cli out,
    @o_impuesto           = @w_impuesto out,
    @o_base_gmf           = @o_base_gmf out,
    @o_clase_clte         = @o_clase_clte out,
    @o_idorden            = @w_idorden out

  if @w_return <> 0
    return @w_return

  select
    @o_val_2x1000 = @w_val_2x1000

  select
    @w_efe = 0,
    @w_prop = 0,
    @w_loc = 0,
    @w_rem = 0
  if @w_factor = -1
    select
      @w_estado = 'R'

  /* Actualizacion de totales de cajero */
  if @s_org = 'S'
  begin
    if @t_trn = 392
       and @i_ActTot = 'S'
    begin
      /* Actualizacion de Totales de cajero */
      exec @w_return = cob_remesas..sp_upd_totales
        @i_ofi        = @i_oficina,
        @i_rol        = @i_turno,
        @i_user       = @s_srv,
        @i_mon        = @i_mon,
        @i_trn        = @t_trn,
        @i_nodo       = @s_srv,
        @i_tipo       = 'R',
        @i_corr       = @t_corr,
        @i_efectivo   = @i_val,
        @i_ssn        = @s_ssn,
        @i_filial     = @i_filial,
        @i_idcaja     = @i_idcaja,
        @i_idcierre   = @i_idcierre,
        @i_saldo_caja = @i_sld_caja
      if @w_return <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205000
        return 205000
      end
    end
    else if @i_ActTot = 'S'
    begin
      if @i_ind = 1
        select
          @w_efe = @i_val
      else if @i_ind = 2
        select
          @w_prop = @i_val
      else if @i_ind = 3
        select
          @w_loc = @i_val
      else if @i_ind = 4
        select
          @w_rem = @i_val

      /* Actualizacion de Totales de cajero */
      exec @w_return = cob_remesas..sp_upd_totales
        @i_ofi          = @i_oficina,
        @i_rol          = @i_turno,
        @i_user         = @s_srv,
        @i_mon          = @i_mon,
        @i_trn          = @t_trn,
        @i_nodo         = @s_srv,
        @i_tipo         = 'R',
        @i_corr         = @t_corr,
        @i_efectivo     = @w_efe,
        @i_cheque       = @w_prop,
        @i_chq_locales  = @w_loc,
        @i_chq_ot_plaza = @w_rem,
        @i_ssn          = @s_ssn,
        @i_filial       = @i_filial,
        @i_idcaja       = @i_idcaja,
        @i_idcierre     = @i_idcierre,
        @i_saldo_caja   = @i_sld_caja
      if @w_return <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205000
        return 205000
      end
    end

    /* Inserta transaccion monetaria */
    if @t_trn = 392
       and @o_sus_flag < 2
    begin
      insert into cob_ahorros..ah_tran_monet
                  (tm_secuencial,tm_cod_alterno,tm_tipo_tran,tm_oficina,
                   tm_usuario
                   ,
                   tm_terminal,tm_correccion,tm_sec_correccion,
                   tm_reentry,tm_origen,
                   tm_nodo,tm_fecha,tm_cta_banco,tm_valor,tm_indicador,
                   tm_causa,tm_saldo_lib,tm_remoto_ssn,tm_moneda,tm_signo,
                   tm_control,tm_saldo_contable,tm_saldo_disponible,
                   tm_departamento,
                   tm_oficina_cta,
                   tm_concepto,tm_efectivo,tm_estado,tm_prod_banc,tm_categoria,
                   tm_ssn_branch,tm_monto_imp,tm_tipo_exonerado_imp,tm_serial,
                   tm_tipocta_super,
                   tm_turno,tm_hora,tm_cliente,tm_valor_comision,tm_base_gmf,
                   tm_clase_clte,tm_cheque)
      values      (@s_ssn,@i_cod_alterno,@t_trn,@s_ofi,-- EAL RETCALL. 
                   @s_user,
                   @s_term,@t_corr,@p_rssn_corr,@t_rty,'R',
                   @s_srv,@s_date,@i_cta,@o_val_mon,@i_ind,
                   @i_cau,null,@p_lssn,@i_mon,@w_signo,
                   @i_chqrem,@o_sldcont,@o_slddisp,@i_dep,@w_oficina_p,
                   @i_concep,@i_valch,@w_estado,@o_prod_banc,@o_categoria,
                   @s_ssn_branch,@w_val_2x1000,@o_tipo_exonerado_imp,@i_serial,
                   @w_tipocta_super,
                   @i_turno,getdate(),@o_cliente,@w_impuesto,@o_base_gmf,
                   @o_clase_clte,@w_idorden)
      if @@error <> 0
      begin /** Error Insertar Transaccion Monetaria **/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 253000
        return 253000
      end
    end
  end
  else if @s_org = 'U'
  begin
    if @t_trn = 392
       and @i_ActTot = 'S'
    begin
      /* Actualizacion de Totales de cajero */
      exec @w_return = cob_remesas..sp_upd_totales
        @i_ofi        = @s_ofi,
        @i_rol        = @i_turno,
        @i_user       = @s_user,
        @i_mon        = @i_mon,
        @i_trn        = @t_trn,
        @i_nodo       = @s_srv,
        @i_tipo       = 'L',
        @i_corr       = @t_corr,
        @i_efectivo   = @i_val,
        @i_ssn        = @s_ssn,
        @i_filial     = @i_filial,
        @i_idcaja     = @i_idcaja,
        @i_idcierre   = @i_idcierre,
        @i_saldo_caja = @i_sld_caja

      if @w_return <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205000
        return 205000
      end
    end
    else if @i_ActTot = 'S'
    begin
      if @i_ind = 1
        select
          @w_efe = @i_val
      else if @i_ind = 2
        select
          @w_prop = @i_val
      else if @i_ind = 3
        select
          @w_loc = @i_val
      else if @i_ind = 4
        select
          @w_rem = @i_val

      /* Actualizacion de Totales de cajero */
      exec @w_return = cob_remesas..sp_upd_totales
        @i_ofi          = @s_ofi,
        @i_rol          = @i_turno,
        @i_user         = @s_user,
        @i_mon          = @i_mon,
        @i_trn          = @t_trn,
        @i_nodo         = @s_srv,
        @i_tipo         = 'L',
        @i_corr         = @t_corr,
        @i_efectivo     = @w_efe,
        @i_cheque       = @w_prop,
        @i_chq_locales  = @w_loc,
        @i_chq_ot_plaza = @w_rem,
        @i_ssn          = @s_ssn,
        @i_filial       = @i_filial,
        @i_idcaja       = @i_idcaja,
        @i_idcierre     = @i_idcierre,
        @i_saldo_caja   = @i_sld_caja,
        @i_causa        = @i_cau
      if @w_return <> 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 205000
        return 205000
      end
    end

    if @t_trn = 392
       and @o_sus_flag < 2
    begin
      insert into cob_ahorros..ah_tran_monet
                  (tm_secuencial,tm_cod_alterno,tm_tipo_tran,tm_oficina,
                   tm_usuario
                   ,
                   tm_terminal,tm_correccion,tm_sec_correccion,
                   tm_reentry,tm_origen,
                   tm_nodo,tm_fecha,tm_cta_banco,tm_valor,tm_indicador,
                   tm_causa,tm_saldo_lib,tm_remoto_ssn,tm_moneda,tm_signo,
                   tm_control,tm_saldo_contable,tm_saldo_disponible,
                   tm_departamento,
                   tm_oficina_cta,
                   tm_concepto,tm_estado,tm_prod_banc,tm_categoria,tm_monto_imp,
                   tm_tipo_exonerado_imp,tm_serial,tm_ssn_branch,
                   tm_tipocta_super,
                   tm_turno,
                   tm_cliente,tm_valor_comision,tm_base_gmf,tm_clase_clte,
                   tm_cheque)
      /*BRANCHII */
      values      (@s_ssn,@i_cod_alterno,@t_trn,@s_ofi,-- EAL RETCALL. 
                   @s_user,
                   @s_term,@t_corr,@t_ssn_corr,@t_rty,'L',
                   @s_srv,@s_date,@i_cta,@o_val_mon,@i_ind,
                   @i_cau,null,@p_lssn,@i_mon,@w_signo,
                   @i_chqrem,@o_sldcont,@o_slddisp,@i_dep,@w_oficina_p,
                   @i_concep,@w_estado,@o_prod_banc,@o_categoria,@w_val_2x1000,
                   @o_tipo_exonerado_imp,@i_serial,@s_ssn_branch,
                   @w_tipocta_super,
                   @i_turno,
                   @o_cliente,@w_impuesto,@o_base_gmf,@o_clase_clte,@w_idorden)
      /*BRANCHII */

      if @@error <> 0
      begin /** Error Insertar Transaccion Monetaria **/
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 253000
        return 253000
      end
    end
  end

  if @w_factor = -1
  begin
    if @t_trn = 392
    begin
      update cob_ahorros..ah_tran_monet
      set    tm_estado = @w_estado
      where  tm_ssn_branch  = @t_ssn_corr /*BRANCHII */
         and tm_oficina     = @s_ofi /*BRANCHII */
         and tm_cod_alterno = @i_cod_alterno
         and tm_cta_banco   = @i_cta
         and tm_valor       = @i_val
         and tm_moneda      = @i_mon
         and tm_usuario     = @s_user
         and tm_estado is null
      if @@rowcount <> 1
      begin
        /* Error en los datos del reverso */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251067
        return 251067
      end
    end
  end

  /* En caso de que se genere valor en suspenso*/
  select
    @w_suspenso = 'N'
  if @o_sus_flag <> 0
    select
      @w_suspenso = 'S'

  select
    'results_submit_rpc',
    r_suspenso = @w_suspenso

  commit tran
  return 0

go

