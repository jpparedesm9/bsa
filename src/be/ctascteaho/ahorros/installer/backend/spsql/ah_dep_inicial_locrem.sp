/************************************************************************/
/*  Archivo:            ah_dep_inicial_locrem.sp                        */
/*  Stored procedure:   sp_ah_dep_inicial_locrem                        */
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
/*      Deposito inicial tanto local como remoto.                       */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA             AUTOR           RAZON                             */
/*  29/Ago/1995       A Villarreal    Emision inicial                   */
/*  20/Jun/2001       R. Penarreta    Branch II                         */
/*  02/Mayo/2016      Ignacio Yupa    Migración a CEN                   */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_dep_inicial_locrem')
  drop proc sp_ah_dep_inicial_locrem
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_dep_inicial_locrem
(
  @s_ssn           int,
  @s_ssn_branch    int = null,
  @s_srv           varchar(30),
  @s_lsrv          varchar(30),
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
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @s_org           char(1),
  @t_trn           int,
  @t_ejec          char(1) = 'N',
  @t_show_version  bit = 0,
  @i_cta           cuenta,
  @i_efe           money,
  @i_prop          money,
  @i_loc           money,
  @i_plaz          money,
  @i_sldlib        money,
  @i_ind           tinyint,
  @i_cau           char(3),
  @i_credit        money,
  @i_nctrl         int,
  @i_mon           tinyint,
  @i_oficina       smallint,
  @i_sp            char(1) = 'N',
  @i_ncontrol      int,
  @i_lpend         int,
  @i_turno         smallint = null,
  @i_sld_caja      money = 0,
  @i_idcierre      int = 0,
  @i_filial        smallint = 1,
  @i_idcaja        int = 0,
  @i_val_masivo    money = 0,
  -- maneja la afectacion a la caja en el deposito con pagos de chq prop masivo
  @i_prop_masivo   money = 0,
  -- maneja la afectacion a la caja en el deposito con pagos de chq prop masivo
  @i_estado        int = 0,-- indica el modo de ejecucion masivo o normal 
  @i_canal         smallint = 4,
  @o_sldcont       money out,
  @o_slddisp       money out,
  @o_control       int out,
  @o_nombre        varchar(30) out,
  @o_int_cap       money out,
  @o_lineas        tinyint out,
  @o_usa           char(1) out,
  @o_sldlib        money out,
  @o_nctrl         smallint out,
  @o_oficina_cta   smallint out,
  @o_prod_banc     smallint out,
  @o_categoria     char(1) out,
  @o_clase_clte    char(1) out,
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
    @w_val_masivo     money,
    -- maneja la afectacion al regsitro monetario en el deposito con pagos de chq prop masivo
    @w_prop_masivo    money,
    -- maneja la afectacion al regsitro monetario en el deposito con pagos de chq prop masivo
    @w_signo          char(1)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_dep_inicial_locrem'

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
      i_sldlib = @i_sldlib,
      i_ind = @i_ind,
      i_cau = @i_cau,
      i_nctrl = @i_nctrl,
      i_credit = @i_credit,
      i_mon = @i_mon
    exec cobis..sp_end_debug
  end

  /*  Modo de correccion  */
  if @t_corr = 'N'
    select
      @w_factor = 1,
      @w_signo = 'C'
  else
    select
      @w_factor = -1,
      @w_signo = 'D'

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
  exec @w_return = cob_ahorros..sp_deposito_inicial
    @s_ssn           = @s_ssn,
    @s_ssn_branch    = @s_ssn_branch,
    @s_srv           = @s_srv,
    @s_lsrv          = @s_lsrv,
    @s_user          = @s_user,
    @s_sesn          = @s_sesn,
    @s_term          = @s_term,
    @s_ofi           = @s_ofi,
    @s_rol           = @s_rol,
    @s_org           = @s_org,
    @s_date          = @s_date,
    @t_debug         = @t_debug,
    @t_file          = @t_file,
    @t_from          = @w_sp_name,
    @t_trn           = @t_trn,
    @t_ejec          = @t_ejec,
    @i_cuenta        = @w_cuenta,
    @i_efe           = @i_efe,
    @i_prop          = @i_prop,
    @i_loc           = @i_loc,
    @i_plaz          = @i_plaz,
    @i_mon           = @i_mon,
    @i_sldlib        = @i_sldlib,
    @i_nctrl         = @i_nctrl,
    @i_credit        = @i_credit,
    @i_ind           = @i_ind,
    @i_factor        = @w_factor,
    @i_fecha         = @s_date,
    @i_ncontrol      = @i_ncontrol,
    @i_lpend         = @i_lpend,
    @i_turno         = @i_turno,
    @i_filial        = @i_filial,
    @i_idcaja        = @i_idcaja,
    @i_idcierre      = @i_idcierre,
    @i_sld_caja      = @i_sld_caja,
    @o_sldcont       = @o_sldcont out,
    @o_slddisp       = @o_slddisp out,
    @o_nombre        = @o_nombre out,
    @o_control       = @o_control out,
    @o_int_cap       = @o_int_cap out,
    @o_lineas        = @o_lineas out,
    @o_usa           = @o_usa out,
    @o_sldlib        = @o_sldlib out,
    @o_nctrl         = @o_nctrl out,
    @o_prod_banc     = @o_prod_banc out,
    @o_categoria     = @o_categoria out,
    @o_clase_clte    = @o_clase_clte out,
    @o_tipocta_super = @o_tipocta_super out
  if @w_return = 2
  begin
    commit tran
    return @w_return
  end
  else if @w_return = 1
    return @w_return
  else if @w_return <> 0
  begin
    rollback tran
    return @w_return
  end

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
      return 1
    end

    /*  Transaccion monetaria  */
    insert into cob_ahorros..ah_deposito
                (secuencial,ssn_branch,tipo_tran,oficina,usuario,
                 terminal,correccion,sec_correccion,reentry,origen,
                 nodo,fecha,cta_banco,efectivo,propios,
                 locales,ot_plazas,remoto_ssn,moneda,interes,
                 saldo_lib,control,fecha_efec,signo,saldocont,
                 saldodisp,saldoint,oficina_cta,prod_banc,categoria,
                 tipocta_super,turno,hora,canal,clase_clte)
    values      (@s_ssn,@s_ssn_branch,@t_trn,@s_ofi,@s_user,
                 @s_term,@t_corr,@p_rssn_corr,@t_rty,'R',
                 @s_srv,@s_date,@i_cta,@i_efe,@i_prop,
                 @i_loc,@i_plaz,@p_lssn,@i_mon,null,
                 @i_sldlib,@o_control,null,@w_signo,@o_sldcont,
                 @o_slddisp,null,@w_oficina_p,@o_prod_banc,@o_categoria,
                 @o_tipocta_super,@i_turno,getdate(),@i_canal,@o_clase_clte)
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 255004
      return 1
    end
  end
  else if @s_org = 'U'
  begin
    if @i_estado = 1
    -- Si es ejecucion masiva debera sumar al efectivo el valor en cheques prop del dep
    begin
      select
        @w_prop_masivo = @i_prop,
        @w_val_masivo = @i_efe

      select
        @i_prop = @i_prop_masivo,
        @i_efe = @i_val_masivo
    end

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
      return 1
    end

    if @i_estado = 1
    -- Si es ejecucion masiva debera sumar al efectivo el valor en cheques prop del dep
    begin
      select
        @i_prop = @w_prop_masivo,
        @i_efe = @w_val_masivo
    end

    /*  Transaccion monetaria  */
    insert into cob_ahorros..ah_deposito
                (secuencial,ssn_branch,tipo_tran,oficina,usuario,
                 terminal,correccion,sec_correccion,reentry,origen,
                 nodo,fecha,cta_banco,efectivo,propios,
                 locales,ot_plazas,remoto_ssn,moneda,interes,
                 saldo_lib,control,fecha_efec,signo,saldocont,
                 saldodisp,saldoint,oficina_cta,prod_banc,categoria,
                 tipocta_super,turno,hora,canal,clase_clte)
    values      (@s_ssn,@s_ssn_branch,@t_trn,@s_ofi,@s_user,
                 @s_term,@t_corr,@t_ssn_corr,@t_rty,'L',
                 @s_srv,@s_date,@i_cta,@i_efe,@i_prop,
                 @i_loc,@i_plaz,@p_lssn,@i_mon,null,
                 @i_sldlib,@o_control,null,@w_signo,@o_sldcont,
                 @o_slddisp,null,@w_oficina_p,@o_prod_banc,@o_categoria,
                 @o_tipocta_super,@i_turno,getdate(),@i_canal,@o_clase_clte)
    if @@error <> 0
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 255004
      return 1
    end
  end
  commit tran
  return 0

go

