/************************************************************************/
/*  Archivo:            ah_depo2_locrem_sl.sp                           */
/*  Stored procedure:   sp_ah_depo2_locrem_sl                           */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 25-Feb-1993                                     */
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
/*  Este programa procesa las transacciones de:                         */
/*      Deposito completo tanto local como remoto.                      */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR          RAZON                                    */
/*  25/Feb/1993 J Navarrete    Emision inicial                          */
/*  19/Ene/1996 D Villafuerte  Control de Calidad (param rem)           */
/*  30/Nov/1998 J Salazar      Cobro de comision por la transac         */
/*  23/Jun/1999 J.C. Gordillo  IDB (Comision)                           */
/*  11/Nov/1999 George F.      Aumento de parametro @i_serial           */
/*                             para n. de credito c/serial.             */
/*  12/Sep/2000 Yenny Rivero   Requerimiento de los Totales de          */
/*                             cajero (optimizacion de los re--         */
/*                             portes de TOTALES DE OPERADOR            */
/*                             (ATX) y TOTALES DE OFICINA (TA)          */
/*  03/Oct/2000 X. Gellibert   Optimizaciones                           */
/*  2002/11/25  Carlos Cruz D. Branch III                               */
/*  2004/04/22  Carlos Cruz D. Manejo del modo masivo en BDF            */
/*  18/Mar/2005 L.Bernuil      Agregar campo @i_cau al llamar           */
/*                             al sp_deposito_ncredito                  */
/*  23/May/2005 Juan F. Cadena Deposito chq. conv. Visa                 */
/*  02/May/2016 Ignacio Yupa   Migración a CEN                          */
/*  06/Sep/2016 D. Fu          H83160 Parametro origen del efectivo     */
/*                             proviene de una remesa (local, exterior) */
/*  22/Sep/2016 T. Baidal      Se modifica llamada a exec sp_cerror     */
/*                             por goto ERROR                           */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_depo2_locrem_sl')
  drop proc sp_ah_depo2_locrem_sl
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_depo2_locrem_sl
(
  @s_ssn           int,
  @s_ssn_branch    int = null,/*Cambios BRANCHII */
  @s_srv           varchar(30),
  @s_user          varchar(30),
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_ofi           smallint,/* Localidad origen transaccion */
  @s_rol           smallint,
  @p_lssn          int = null,
  @t_corr          char(1) = 'N',
  @t_ssn_corr      int = null,
  @p_rssn_corr     int = null,
  @t_ejec          char(1) = 'N',/*Cambios BRANCHII */
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_show_version  bit = 0,
  @s_org           char(1),
  @t_trn           int,
  @i_cta           cuenta,
  @i_efe           money,
  @i_prop          money,
  @i_loc           money,
  @i_plaz          money,
  @i_ind           tinyint,
  @i_cau           char(3),
  @i_credit        money,
  @i_mon           tinyint,
  @i_dep           smallint,
  @i_sp            char(1),
  @i_ope           char(2),
  @i_concep        varchar(30) = null,
  @i_chqrem        int = null,
  @i_lpend         int,
  @i_ncontrol      int,
  @i_dif           char(1) = 'N',
  @i_serial        varchar(30) = null,
  @i_sld_caja      money = 0,
  @i_idcierre      int = 0,
  @i_filial        smallint = 1,
  @i_idcaja        int = 0,
  @i_turno         smallint = null,

  --CCR BRANCH III
  @i_fecha_valor_a datetime = null,
  @i_estado_masivo int = 0,        --CCR MODO MASIVO
  @i_prop_masivo   money = 0,      --CCR MODO MASIVO
  @i_val_masivo    money = 0,      --CCR MODO MASIVO
  @i_boleta        varchar(20) = null,
  @i_nombreusr1    varchar(35) = null,
  @i_nombreusr2    varchar(35) = null,
  @i_apellidousr1  varchar(35) = null,
  @i_apellidousr2  varchar(35) = null,
  @i_ActTot        char(1) = 'S',
  @i_pago_servicio char(1) = 'N',  --SI ES llamado desde PAGO DE SERVICIO o NO
  @i_canal         smallint = 4,
  @i_comision      money = 0,      --REQ 203
  @i_causal        char(3) = '',   --REQ 203
  @i_remesas       char(1) = null, --Origen de la remesa (L = Local, E = Exterior)
  @i_batch         char(1) = 'N',
  
  @o_sldcont       money out,
  @o_slddisp       money out,
  @o_nombre        varchar(60) out,
  @o_cedula        varchar(12) out,
  @o_oficina_cta   smallint out,
  @o_prod_banc     smallint out,
  @o_categoria     char(1) out,
  @o_tipocta_super char(1) = null out,
  @o_clase_clte    char(1) = null out,
  @o_cliente       int = 0 out,

  --@o_tipo_exonerado_imp char(2)  out,
  @o_alerta_cli    varchar(40) = null out,
  @o_comision      money = 0 out,
  @o_valiva        money = 0 out
)
as
  declare
    @w_return            int,
    @w_sp_name           varchar(30),
    @w_oficial_nombre    varchar(60),
    @w_cuenta            int,
    @w_filial_p          tinyint,
    @w_oficina_p         smallint,
    @w_pide_aut          char(1),
    @w_factor            int,
    @w_tipo_promedio     char(1),
    @w_oficial           smallint,
    @w_signo             char(1),
    @w_efe               money,
    @w_prop              money,
    @w_loc               money,
    @w_rem               money,
    @w_estado            char(1),
    @w_tran_especial     int,
    @w_prop_masivo       money,--CCR MODO MASIVO
    @w_val_masivo        money, --CCR MODO MASIVO
    @w_error             int,
	@w_sev               tinyint,
	@w_msg	             varchar(255)

  /*  Captura nombre de Stored Procedure  */
  select @w_sp_name = 'sp_ah_depo2_locrem_sl'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end
  
  if @i_remesas = '' select @i_remesas = null
  
  /*  Modo de correccion  */
  if @t_corr = 'N'
    select
      @w_factor = 1,
      @w_signo = 'C'
  else
    select
      @w_factor = -1,
      @w_signo = 'D'

  if @i_turno is null
    select
      @i_turno = @s_rol

  /*  Determinacion de vigencia de cuenta  */
  exec @w_return = cob_ahorros..sp_ctah_vigente
    @t_debug    = @t_debug,
    @t_file     = @t_file,
    @t_from     = @w_sp_name,
    @i_cta_banco= @i_cta,
    @i_moneda   = @i_mon,
	@i_is_batch = @i_batch,
    @o_cuenta   = @w_cuenta out,
    @o_filial   = @w_filial_p out,
    @o_oficina  = @w_oficina_p out,
    @o_tpromedio= @w_tipo_promedio out,
    @o_oficial  = @w_oficial out
  if @w_return <> 0
    return @w_return

  select @o_oficina_cta = @w_oficina_p

  /*  Deposito completo */
  if @i_batch = 'N'
  begin tran
  
  if @w_factor = -1
  begin
    if @t_trn = 252
        or @i_pago_servicio = 'S' --PCOELLO SI ES LLAMADO DESDE PAGO DE SERVICIO
      if not exists (select
                       1
                     from   cob_ahorros..ah_tran_monet
                     where  tm_oficina       = @s_ofi
                        and tm_ssn_branch    = @t_ssn_corr
                        and tm_tipo_tran     = @t_trn
                        and tm_estado is null
                        and tm_usuario       = @s_user
                        and tm_valor         = @i_efe
                        and tm_moneda        = @i_mon
                        and tm_cta_banco     = @i_cta
                        and tm_chq_propios   = @i_prop
                        and tm_chq_locales   = @i_loc
                        and tm_chq_ot_plazas = @i_plaz)
      begin
        /* Error en los datos del reverso */
		select
          @w_error = 251067
        goto ERROR
      end

    if @t_trn = 253
        or @t_trn = 2677
      if not exists (select
                       1
                     from   cob_ahorros..ah_tran_monet
                     where  tm_oficina      = @s_ofi
                        and tm_ssn_branch   = @t_ssn_corr
                        and tm_tipo_tran    = @t_trn
                        and tm_estado is null
                        and tm_usuario      = @s_user
                        and tm_moneda       = @i_mon
                        and tm_cta_banco    = @i_cta
                        and tm_valor        = @i_credit
                        and tm_indicador    = @i_ind
                        and tm_causa        = @i_cau
                        and tm_departamento = @i_dep
                        and tm_control      = @i_chqrem)
      begin
        /* Error en los datos del reverso */
          select
              @w_error = 251067
          goto ERROR
      end
  end

  exec @w_return = cob_ahorros..sp_deposito_ncredito_sl
    @s_rol           = @s_rol,
    @s_ssn           = @s_ssn,
    @s_ssn_branch    = @s_ssn_branch,/*Camb BRANCHII */
    @s_user          = @s_user,
    @s_term          = @s_term,
    @s_srv           = @s_srv,
    @s_ofi           = @s_ofi,/*Cambios BRANCHII */
    @s_date          = @s_date,/*Cambios BRANCHII */
    @t_debug         = @t_debug,
    @t_file          = @t_file,
    @t_ejec          = @t_ejec,/*Cambios BRANCHII */
    @t_from          = @w_sp_name,
    @t_trn           = @t_trn,
    @t_corr          = @t_corr,
    @t_ssn_corr      = @t_ssn_corr,
    @i_ofi           = @s_ofi,
    @i_cuenta        = @w_cuenta,
    @i_efe           = @i_efe,
    @i_prop          = @i_prop,
    @i_loc           = @i_loc,
    @i_plaz          = @i_plaz,
    @i_mon           = @i_mon,
    @i_credit        = @i_credit,
    @i_ind           = @i_ind,
    @i_factor        = @w_factor,
    @i_fecha         = @s_date,
    @i_ope           = @i_ope,
    @i_ncontrol      = @i_ncontrol,
    @i_lpend         = @i_lpend,
    @i_dif           = @i_dif,
    @i_filial        = @i_filial,
    @i_idcaja        = @i_idcaja,
    @i_idcierre      = @i_idcierre,
    @i_sld_caja      = @i_sld_caja,
    @i_turno         = @i_turno,
    @i_comision      = @i_comision,--REQ 203
    @i_causal        = @i_causal,--REQ 203
    --CCR BRANCH III
    @i_fecha_valor_a = @i_fecha_valor_a,
    @i_cau           = @i_cau,
    @i_pago_servicio = 'N',
    --SI ES PAGO DE SERVICIO SE DEBE COMPORTAR COMO DEPOSITO PERO CON DIF TRANSACCION, se cambia a N pry bancamia
    @i_canal         = @i_canal,
	@i_batch         = @i_batch,
    @o_sldcont       = @o_sldcont out,
    @o_slddisp       = @o_slddisp out,
    @o_nombre        = @o_nombre out,
    @o_alerta_cli    = @o_alerta_cli out,
    @o_cedula        = @o_cedula out,
    @o_cliente       = @o_cliente out,
    @o_prod_banc     = @o_prod_banc out,
    @o_categoria     = @o_categoria out,
    @o_tipocta_super = @o_tipocta_super out,
    @o_clase_clte    = @o_clase_clte out,
    @o_comision      = @o_comision out,
    @o_valiva        = @o_valiva out	
  if @w_return <> 0
  begin
      return @w_return
  end
   
  if @w_factor = -1
    select
      @w_estado = 'R'

  select
    @w_efe = 0,
    @w_prop = 0,
    @w_loc = 0,
    @w_rem = 0

/* Buscar si existe transaccion especial */
  /*select @w_tran_especial = te_tran_final
    from cob_remesas..re_tran_especiales
   where te_tran_original = @t_trn
     and te_causas        = @i_cau
  
  if @@rowcount = 0*/
  select
    @w_tran_especial = @t_trn

  if @s_org = 'S'
  begin
    if @t_trn = 252
        or @i_pago_servicio = 'S' --PCOELLO SI ES LLAMADO DESDE PAGO DE SERVICIO
    begin
      if @i_ActTot = 'S'
      begin
        -- Actualizacion de Totales de cajero
        exec @w_return = cob_remesas..sp_upd_totales
          @i_ofi          = @s_ofi,
          @i_rol          = @i_turno,
          @i_user         = @s_srv,
          @i_mon          = @i_mon,
          @i_trn          = @t_trn,
          @i_nodo         = @s_srv,
          @i_tipo         = 'R',
          @i_corr         = @t_corr,
          @i_efectivo     = @i_efe,
          @i_cheque       = @i_prop,
          @i_chq_locales  = @i_loc,
          @i_chq_ot_plaza = @i_plaz,
          @i_ssn          = @s_ssn,
          @i_filial       = @i_filial,
          @i_idcaja       = @i_idcaja,
          @i_idcierre     = @i_idcierre,
          @i_saldo_caja   = @i_sld_caja,
          @i_causa        = @i_cau
        if @w_return <> 0
        begin
		    select
              @w_error = 205000
            goto ERROR
        end
      end

      /*  Transaccion monetaria  */
      insert into cob_ahorros..ah_deposito
                  (secuencial,tipo_tran,oficina,usuario,terminal,
                   correccion,sec_correccion,reentry,origen,nodo,
                   fecha,cta_banco,efectivo,propios,locales,
                   ot_plazas,remoto_ssn,moneda,saldo_lib,control,
                   fecha_efec,signo,saldocont,saldodisp,oficina_cta,
                   estado,prod_banc,categoria,ssn_branch,tipocta_super,
                   turno,hora,canal,cliente,clase_clte,origen_efectivo)
      values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                   @t_corr,@p_rssn_corr,@t_rty,'R',@s_srv,
                   @s_date,@i_cta,@i_efe,@i_prop,@i_loc,
                   @i_plaz,@p_lssn,@i_mon,null,null,
                   null,@w_signo,@o_sldcont,@o_slddisp,@w_oficina_p,
                   @w_estado,@o_prod_banc,@o_categoria,@s_ssn_branch,
                   @o_tipocta_super,
                   @i_turno,getdate(),@i_canal,@o_cliente,@o_clase_clte, @i_remesas )
      if @@error <> 0
      begin
	      select
              @w_error = 255004
          goto ERROR
      end
    end
    else if @t_trn = 253
        or @t_trn = 229
        or @t_trn = 2677
    begin
      if @i_ind = 1
        select
          @w_efe = @i_credit
      else if @i_ind = 2
        select
          @w_prop = @i_credit
      else if @i_ind = 3
        select
          @w_loc = @i_credit
      else if @i_ind = 4
        select
          @w_rem = @i_credit

      if @i_ActTot = 'S'
      begin
        -- Actualizacion de Totales de cajero
        exec @w_return = cob_remesas..sp_upd_totales
          @i_ofi          = @s_ofi,
          @i_rol          = @i_turno,
          @i_user         = @s_srv,
          @i_mon          = @i_mon,
          @i_trn          = @w_tran_especial,--@t_trn,
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
          @i_saldo_caja   = @i_sld_caja,
          @i_causa        = @i_cau
        if @w_return <> 0
        begin
		    select
              @w_error = 205000
            goto ERROR
        end
      end

      /*  Transaccion monetaria  */
      insert into cob_ahorros..ah_notcredeb
                  (secuencial,tipo_tran,oficina,usuario,terminal,
                   correccion,sec_correccion,reentry,origen,nodo,
                   fecha,cta_banco,signo,indicador,remoto_ssn,
                   moneda,causa,fecha_efec,saldo_lib,valor,
                   control,saldocont,saldodisp,departamento,oficina_cta,
                   concepto,estado,prod_banc,categoria,serial,
                   ssn_branch,tipocta_super,turno,ctabanco_dep,hora,
                   canal,cliente,clase_clte)
      values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                   @t_corr,@p_rssn_corr,@t_rty,'R',@s_srv,
                   @s_date,@i_cta,@w_signo,@i_ind,@p_lssn,
                   @i_mon,@i_cau,null,null,@i_credit,
                   @i_chqrem,@o_sldcont,@o_slddisp,@i_dep,@w_oficina_p,
                   @i_concep,@w_estado,@o_prod_banc,@o_categoria,@i_serial,
                   @s_ssn_branch,@o_tipocta_super,@i_turno,@i_boleta,getdate(),
                   @i_canal,@o_cliente,@o_clase_clte)
      if @@error <> 0
      begin
	      select
              @w_error = 255004
          goto ERROR
      end
    end
  end
  else if @s_org = 'U'
  begin
    --print '%1! %2! %3! ', @i_ActTot, @t_trn, @i_pago_servicio
    if @t_trn = 252
        or @i_pago_servicio = 'S' --PCOELLO SI ES LLAMADO DESDE PAGO DE SERVICIO
    begin
      --CCR MODO MASIVO *******
      if @i_estado_masivo = 1
      begin
        select
          @w_prop_masivo = @i_prop,
          @w_val_masivo = @i_efe

        select
          @i_efe = @i_val_masivo,
          @i_prop = @i_prop_masivo
      end
      --FIN CCR ***************

      if @i_ActTot = 'S'
      begin
        -- Actualizacion de Totales de cajero
        exec @w_return = cob_remesas..sp_upd_totales
          @i_ofi          = @s_ofi,
          @i_rol          = @i_turno,
          @i_user         = @s_user,
          @i_mon          = @i_mon,
          @i_trn          = @t_trn,
          @i_nodo         = @s_srv,
          @i_tipo         = 'L',
          @i_corr         = @t_corr,
          @i_efectivo     = @i_efe,
          @i_cheque       = @i_prop,
          @i_chq_locales  = @i_loc,
          @i_chq_ot_plaza = @i_plaz,
          @i_ssn          = @s_ssn,
          @i_filial       = @i_filial,
          @i_idcaja       = @i_idcaja,
          @i_idcierre     = @i_idcierre,
          @i_saldo_caja   = @i_sld_caja,
          @i_causa        = @i_cau
        if @w_return <> 0
        begin
		    select
              @w_error = 205000
            goto ERROR
        end
      end

      /* Inicio cambios BRANCHII */
      if exists (select
                   1
                 from   cob_ahorros..ah_deposito
                 where  ssn_branch = @s_ssn_branch
                    and oficina    = @s_ofi)
      begin
        /*Ya existe transaccion monetaria*/
		select
              @w_error = 251079
        goto ERROR
      end
    /* Fin cambios BRANCHII */
      --CCR MODO MASIVO *******
      if @i_estado_masivo = 1
      begin
        select
          @i_efe = @w_val_masivo,
          @i_prop = @w_prop_masivo
      end
      --FIN CCR ***************

      /*  Transaccion monetaria  */
      insert into cob_ahorros..ah_deposito
                  (secuencial,tipo_tran,oficina,usuario,terminal,
                   correccion,sec_correccion,reentry,origen,nodo,
                   fecha,cta_banco,efectivo,propios,locales,
                   ot_plazas,remoto_ssn,moneda,saldo_lib,control,
                   fecha_efec,signo,saldocont,saldodisp,oficina_cta,
                   estado,prod_banc,categoria,ssn_branch,tipocta_super,
                   turno,hora,canal,cliente,clase_clte, origen_efectivo) /* BRANCHII */
      values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                   @t_corr,@t_ssn_corr,@t_rty,'L',@s_srv,
                   @s_date,@i_cta,@i_efe,@i_prop,@i_loc,
                   @i_plaz,@p_lssn,@i_mon,null,null,
                   null,@w_signo,@o_sldcont,@o_slddisp,@w_oficina_p,
                   @w_estado,@o_prod_banc,@o_categoria,@s_ssn_branch,
                   @o_tipocta_super,
                   @i_turno,getdate(),@i_canal,@o_cliente,@o_clase_clte, @i_remesas)
      /*Cambios BRANCHII */
      if @@error <> 0
      begin
	      select
              @w_error = 255004
          goto ERROR
      end
    end
    else if @t_trn = 253
        or @t_trn = 229
        or @t_trn = 2677
    begin
      if @i_ind = 1
        select
          @w_efe = @i_credit
      else if @i_ind = 2
        select
          @w_prop = @i_credit
      else if @i_ind = 3
        select
          @w_loc = @i_credit
      else if @i_ind = 4
        select
          @w_rem = @i_credit

      if @i_ActTot = 'S'
      begin
        -- Actualizacion de Totales de cajero
        exec @w_return = cob_remesas..sp_upd_totales
          @i_ofi          = @s_ofi,
          @i_rol          = @i_turno,
          @i_user         = @s_user,
          @i_mon          = @i_mon,
          @i_trn          = @w_tran_especial,--@t_trn,
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
          @i_causa        = @i_cau,
          @i_saldo_caja   = @i_sld_caja
        if @w_return <> 0
        begin
		    select
              @w_error = 205000
            goto ERROR
        end
      end

      /* Inicio cambios BRANCHII */
      if exists (select
                   1
                 from   cob_ahorros..ah_notcredeb
                 where  ssn_branch = @s_ssn_branch
                    and oficina    = @s_ofi
                    and tipo_tran  = @t_trn)
      begin
        /*Ya existe transaccion monetaria*/
		select
              @w_error = 251079
        goto ERROR
      end
    /* Fin cambios BRANCHII */
      /*  Transaccion monetaria  */
      insert into cob_ahorros..ah_notcredeb
                  (secuencial,tipo_tran,oficina,usuario,terminal,
                   correccion,sec_correccion,reentry,origen,nodo,
                   fecha,cta_banco,signo,indicador,remoto_ssn,
                   moneda,causa,saldo_lib,valor,control,
                   fecha_efec,saldocont,saldodisp,departamento,oficina_cta,
                   concepto,estado,prod_banc,categoria,serial,
                   ssn_branch,tipocta_super,turno,ctabanco_dep,hora,
                   canal,cliente,clase_clte) /*Cambios BRANCHII */
      values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                   @t_corr,@t_ssn_corr,@t_rty,'L',@s_srv,
                   @s_date,@i_cta,@w_signo,@i_ind,@p_lssn,
                   @i_mon,@i_cau,null,@i_credit,@i_chqrem,
                   null,@o_sldcont,@o_slddisp,@i_dep,@w_oficina_p,
                   @i_concep,@w_estado,@o_prod_banc,@o_categoria,@i_serial,
                   @s_ssn_branch,@o_tipocta_super,@i_turno,@i_boleta,getdate(),
                   @i_canal,@o_cliente,@o_clase_clte) /*Cambios BRANCHII */
      if @@error <> 0
      begin
	      select
              @w_error = 255004
          goto ERROR
      end
    end
  end

  if @w_factor = -1
  begin
    if @t_trn = 252
        or @i_pago_servicio = 'S' --PCOELLO SI ES LLAMADO DESDE PAGO DE SERVICIO
    begin
      update cob_ahorros..ah_tran_monet
      set    tm_estado = @w_estado
      where  tm_oficina       = @s_ofi
         and tm_ssn_branch    = @t_ssn_corr
         and tm_moneda        = @i_mon
         and tm_tipo_tran     = @t_trn
         and tm_valor         = @i_efe
         and tm_estado is null
         and tm_cta_banco     = @i_cta
         and tm_chq_propios   = @i_prop
         and tm_chq_locales   = @i_loc
         and tm_chq_ot_plazas = @i_plaz
         and tm_usuario       = @s_user

      if @@rowcount <> 1
      begin
        /* Datos del reverso no coinciden con el original */
		select
              @w_error = 251067
        goto ERROR
      end
    end

    if @t_trn = 253
        or @t_trn = 229
        or @t_trn = 2677
    begin
      update cob_ahorros..ah_tran_monet
      set    tm_estado = @w_estado
      where  tm_oficina      = @s_ofi
         and tm_ssn_branch   = @t_ssn_corr
         and tm_tipo_tran    = @t_trn
         and tm_moneda       = @i_mon
         and tm_valor        = @i_credit
         and tm_estado is null
         and tm_cta_banco    = @i_cta
         and tm_indicador    = @i_ind
         and tm_causa        = @i_cau
         and tm_departamento = @i_dep
         and tm_control      = @i_chqrem
         and tm_usuario      = @s_user

      if @@rowcount <> 1
      begin
        /* Datos del reverso no coinciden con el original */
		select
              @w_error = 251067
        goto ERROR
      end
    end

  end
  
  if @i_batch = 'N'
  commit tran
  
  return 0

ERROR:
if @i_batch = 'N'
begin
  exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = @w_error,
    @i_msg   = @w_msg,
	@i_sev   = @w_sev
end
return @w_error

go

