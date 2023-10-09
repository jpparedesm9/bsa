/************************************************************************/
/*  Archivo:            ah_depdi_locrem_sl.sp                           */
/*  Stored procedure:   sp_ah_depdi_locrem_sl                           */
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
/*  FECHA         AUTOR           RAZON                                 */
/*  25/Feb/1993   J Navarrete     Emision inicial                       */
/*  19/Ene/1996   D Villafuerte   Control de Calidad (param rem)        */
/*  09/Feb/1999   J. Salazar      Cobro de comision por la transac      */
/*  23/Jun/1999   J.C. Gordillo   IDB (Comision)                        */
/*  2003/07/01    Carlos Cruz D.  Branch III                            */
/*  2004/04/22    Carlos Cruz D.  Manejo del modo masivo en BDF         */
/*  02/Mayo/2016  Ignacio Yupa    Migración a CEN                       */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_depdi_locrem_sl')
  drop proc sp_ah_depdi_locrem_sl
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_depdi_locrem_sl
(
  @s_ssn           int,
  @s_srv           varchar(30),
  @s_lsrv          varchar(30),
  @s_user          varchar(30),
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_ofi           smallint,/* Localidad origen transaccion */
  @s_rol           smallint,
  @s_ssn_branch    int = null,
  @p_lssn          int = null,  
  @t_corr          char(1) = 'N',
  @t_ssn_corr      int = null,
  @p_rssn_corr     int = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_ejec          char(1) = 'N',--CCR
  @s_org           char(1),
  @t_trn           int,
  @t_show_version  bit = 0,
  @i_cta           cuenta,
  @i_efe           money,
  @i_prop          money,
  @i_loc           money,
  @i_plaz          money,
  @i_oficina       smallint,
  @i_mon           tinyint,
  @i_sp            char(1),
  @i_lpend         int,
  @i_ncontrol      int,
  @i_batch         char(1) = 'N',
  @i_turno         smallint = null,
  @i_sld_caja      money = 0,
  @i_idcierre      int = 0,
  @i_filial        smallint = 1,
  @i_idcaja        int = 0,
  @i_fecha_valor_a datetime = null,--CCR
  @i_estado_masivo int = 0,--CCR MODO MASIVO
  @i_prop_masivo   money = 0,--CCR MODO MASIVO
  @i_val_masivo    money = 0,--CCR MODO MASIVO
  @i_canal         smallint = 4,
  @o_sldcont       money out,
  @o_slddisp       money out,
  @o_nombre        varchar(30) out,
  @o_oficina_cta   smallint out,
  @o_prod_banc     smallint out,
  @o_categoria     char(1) out,
  @o_clase_clte    char(1) = null out,
  @o_tipocta_super char(1) = null out
)
as
  declare
    @w_return         int,
    @w_sp_name        varchar(30),
    @w_oficial_nombre varchar(30),
    @w_cuenta         int,
    @w_filial_p       tinyint,
    @w_oficina_p      smallint,
    @w_pide_aut       char(1),
    @w_factor         int,
    @w_tipo_promedio  char(1),
    @w_oficial        smallint,
    @w_signo          char(1),
    @w_efe            money,
    @w_prop           money,
    @w_loc            money,
    @w_rem            money,
    @w_estado         char(1),
    @w_prop_masivo    money,--CCR MODO MASIVO
    @w_val_masivo     money --CCR MODO MASIVO

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_depdi_locrem_sl'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @i_turno is null
    select
      @i_turno = @s_rol

  /*  Modo de debug  */
  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file=@t_file
    select
      '/**  Stored Procedure  **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_srv = @s_srv,
      s_user = @s_user,
      s_sesn = @s_sesn,
      s_term = @s_term,
      s_date = @s_date,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      p_lssn = @p_lssn,
      t_corr = @t_corr,
      t_debug = @t_debug,
      t_from = @t_from,
      t_file = @t_file,
      t_rty = @t_rty,
      s_ori = @s_org,
      t_trn = @t_trn,
      i_cta = @i_cta,
      i_efe = @i_efe,
      i_prop = @i_prop,
      i_loc = @i_loc,
      i_plaz = @i_plaz,
      i_mon = @i_mon,
      i_filial = @i_filial
    exec cobis..sp_end_debug
  end

  /*  Modo de correccion  */
  if @t_corr = 'N'
    select
      @w_factor = 1,
      @w_signo = 'C',
      @w_estado = null
  else
    select
      @w_factor = -1,
      @w_signo = 'D',
      @w_estado = 'R'

  /*  Determinacion de vigencia de cuenta  */
  exec @w_return = cob_ahorros..sp_ctah_vigente
    @t_debug         = @t_debug,
    @t_file          = @t_file,
    @t_from          = @w_sp_name,
    @i_cta_banco     = @i_cta,
    @i_moneda        = @i_mon,
    @o_cuenta        = @w_cuenta out,
    @o_filial        = @w_filial_p out,
    @o_oficina       = @w_oficina_p out,
    @o_tipo_promedio = @w_tipo_promedio out,
    @o_oficial       = @w_oficial out
  if @w_return <> 0
    return @w_return

  select
    @o_oficina_cta = @w_oficina_p

  /*  Deposito completo */
  begin tran

  if @w_factor = -1
  begin
    if @t_trn = 246
      if not exists (select
                       1
                     from   cob_ahorros..ah_tran_monet
                     where  --tm_secuencial = @t_ssn_corr
                      tm_ssn_branch    = @t_ssn_corr
                    and tm_tipo_tran     = @t_trn
                    and tm_cta_banco     = @i_cta
                    and tm_valor         = @i_efe
                    and tm_chq_propios   = @i_prop
                    and tm_chq_locales   = @i_loc
                    and tm_chq_ot_plazas = @i_plaz
                    and tm_moneda        = @i_mon
                    and tm_usuario       = @s_user
                    and tm_estado is null)
      begin
        /* Los datos del reverso no coinciden con los originales */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251067
        return 1
      end
  end
  exec @w_return = cob_ahorros..sp_dep_ncre_dif_sl
    @s_rol           = @s_rol,
    @s_ssn           = @s_ssn,
    @s_srv           = @s_srv,
    @s_lsrv          = @s_lsrv,
    @s_user          = @s_user,
    @s_term          = @s_term,
    @s_ofi           = @s_ofi,
    @s_date          = @s_date,
    @s_ssn_branch    = @s_ssn_branch,
    @t_ssn_corr      = @t_ssn_corr,
    @t_debug         = @t_debug,
    @t_file          = @t_file,
    @t_from          = @w_sp_name,
    @t_trn           = @t_trn,
    @t_ejec          = @t_ejec,--CCR
    @i_ofi           = @s_ofi,
    @i_cuenta        = @w_cuenta,
    @i_efe           = @i_efe,
    @i_prop          = @i_prop,
    @i_loc           = @i_loc,
    @i_plaz          = @i_plaz,
    @i_mon           = @i_mon,
    @i_factor        = @w_factor,
    @i_fecha         = @s_date,
    @i_ncontrol      = @i_ncontrol,
    @i_lpend         = @i_lpend,
    @i_batch         = @i_batch,
    @i_filial        = @i_filial,
    @i_turno         = @i_turno,
    @i_filial        = @i_filial,
    @i_idcaja        = @i_idcaja,
    @i_idcierre      = @i_idcierre,
    @i_sld_caja      = @i_sld_caja,
    @i_fecha_valor_a = @i_fecha_valor_a,
    @i_canal         = @i_canal,
    @o_sldcont       = @o_sldcont out,
    @o_slddisp       = @o_slddisp out,
    @o_nombre        = @o_nombre out,
    @o_prod_banc     = @o_prod_banc out,
    @o_categoria     = @o_categoria out,
    @o_clase_clte    = @o_clase_clte out,
    @o_tipocta_super = @o_tipocta_super out

  if @w_return <> 0
    return @w_return

  if @s_org = 'S'
  begin
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
      @i_efectivo     = @i_efe,
      @i_cheque       = @i_prop,
      @i_chq_locales  = @i_loc,
      @i_chq_ot_plaza = @i_plaz,
      @i_ssn          = @s_ssn,
      @i_filial       = @i_filial,
      @i_idcaja       = @i_idcaja,
      @i_idcierre     = @i_idcierre,
      @i_saldo_caja   = @i_sld_caja,
      @i_cta_banco    = @i_cta
    if @w_return <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 205000
      return 205000
    end

    /*  Transaccion monetaria  */

    insert into cob_ahorros..ah_deposito
                (secuencial,tipo_tran,oficina,usuario,terminal,
                 correccion,sec_correccion,reentry,origen,nodo,
                 fecha,cta_banco,efectivo,propios,locales,
                 ot_plazas,remoto_ssn,moneda,saldo_lib,control,
                 fecha_efec,signo,saldocont,saldodisp,oficina_cta,
                 estado,prod_banc,categoria,ssn_branch,tipocta_super,
                 turno,hora,canal,clase_clte)
    values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                 @t_corr,@p_rssn_corr,@t_rty,'R',@s_srv,
                 @s_date,@i_cta,@i_efe,@i_prop,@i_loc,
                 @i_plaz,@p_lssn,@i_mon,null,null,
                 null,@w_signo,@o_sldcont,@o_slddisp,@w_oficina_p,
                 @w_estado,@o_prod_banc,@o_categoria,@s_ssn_branch,
                 @o_tipocta_super,
                 @i_turno,getdate(),@i_canal,@o_clase_clte)

    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 255004
      return 255004
    end
  end
  else if @s_org = 'U'
  begin
  /* Actualizacion de Totales de cajero */
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
      @i_cta_banco    = @i_cta
    if @w_return <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 205000
      return 205000
    end

  /*  Transaccion monetaria  */
    /* Inicio Cambios BRANCHII 03-jul-01*/
    if exists (select
                 1
               from   cob_ahorros..ah_tran_monet
               where  tm_ssn_branch = @s_ssn_branch
                  and tm_oficina    = @s_ofi)
    begin
      /* Error en creacion de registro en ah_tran_monet */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251079
      return 1
    end
  /* Fin Cambios BRANCHII */
    --CCR MODO MASIVO *******
    if @i_estado_masivo = 1
    begin
      select
        @i_efe = @w_val_masivo,
        @i_prop = @w_prop_masivo
    end
    --FIN CCR ***************

    insert into cob_ahorros..ah_deposito
                (secuencial,tipo_tran,oficina,usuario,terminal,
                 correccion,sec_correccion,reentry,origen,nodo,
                 fecha,cta_banco,efectivo,propios,locales,
                 ot_plazas,remoto_ssn,moneda,saldo_lib,control,
                 fecha_efec,signo,saldocont,saldodisp,oficina_cta,
                 estado,prod_banc,categoria,ssn_branch,tipocta_super,
                 turno,hora,canal,clase_clte)
    values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
                 @t_corr,@t_ssn_corr,@t_rty,'L',@s_srv,
                 @s_date,@i_cta,@i_efe,@i_prop,@i_loc,
                 @i_plaz,@p_lssn,@i_mon,null,null,
                 null,@w_signo,@o_sldcont,@o_slddisp,@w_oficina_p,
                 @w_estado,@o_prod_banc,@o_categoria,@s_ssn_branch,
                 @o_tipocta_super,
                 @i_turno,getdate(),@i_canal,@o_clase_clte)
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 255004
      return 255004
    end

    if @i_sp = 'N'
      select
        'Nombre' = @o_nombre

  end

  if @w_factor = -1
  begin
    update cob_ahorros..ah_tran_monet
    set    tm_estado = @w_estado
    where  --tm_secuencial  = @t_ssn_corr
      tm_ssn_branch    = @t_ssn_corr
    and tm_cta_banco     = @i_cta
    and tm_valor         = @i_efe
    and tm_chq_propios   = @i_prop
    and tm_chq_locales   = @i_loc
    and tm_chq_ot_plazas = @i_plaz
    and tm_moneda        = @i_mon
    and tm_usuario       = @s_user
    and tm_estado is null

    if @@rowcount <> 1
    begin
      /* Los datos del reverso no coinciden con los originales */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251067
      return 1
    end
  end

  commit tran
  return 0

go

