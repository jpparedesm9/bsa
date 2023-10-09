/************************************************************************/
/*  Archivo:            ah_retndcl_locrem.sp                            */
/*  Stored procedure:   sp_ah_retndcl_locrem                            */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 10-Feb-1993                                     */
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
/*      Retiro y Nota de Debito CON LIBRETA                             */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR              RAZON                                */
/*  10/Feb/1993 X. Gellibert    Emision Inicial                         */
/*  12/Nov/1993 J. Navarrete    Modificaciones Generales                */
/*  07/Jun/1999 J. George       Creacion de @o_monto_imp y              */
/*                              @o_tipo_exonerado_imp.                  */
/*  12/Sep/2000 G. George       Requerimiento de los Totales de         */
/*                              cajero (optimizacion de los re--        */
/*                              portes de TOTALES DE OPERADOR           */
/*                              (ATX) y TOTALES DE OFICINA (TA)         */
/*  03/Oct/2000 X Gellibert     Optimizacion                            */
/*  02/May/2016 Ignacio Yupa    Migración a CEN                         */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_retndcl_locrem')
  drop proc sp_ah_retndcl_locrem
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_retndcl_locrem
(
  @s_ssn                int,
  @s_lsrv               varchar(30),
  @s_srv                varchar(30),
  @s_user               varchar(30),
  @s_sesn               int,
  @s_term               varchar(10),
  @s_date               datetime,
  @s_ofi                smallint,/* Localidad origen transaccion */
  @s_rol                smallint,
  @s_sev                tinyint,
  @s_ssn_branch         int,
  @p_lssn               int = null,  
  @t_corr               char(1) = 'N',
  @t_ssn_corr           int = null,
  @p_rssn_corr          int = null,
  @t_debug              char(1) = 'N',
  @t_file               varchar(14) = null,
  @t_from               varchar(32) = null,
  @t_rty                char(1) = 'N',
  @t_show_version       bit = 0,
  @s_org                char(1),
  @t_trn                int,
  @i_cta                cuenta,
  @i_mon                tinyint,
  @i_sdolib             money,
  @i_val                money,
  @i_control            int,
  @i_ind                tinyint,
  @i_cau                char(3),
  @i_oficina            smallint,
  @i_dep                smallint,
  @i_concep             varchar(30) = null,
  @i_ncontrol           int,
  @i_lpend              int,
  @i_turno              smallint = null,
  @i_sld_caja           money = 0,
  @i_idcierre           int = 0,
  @i_filial             smallint = 1,
  @i_idcaja             int = 0,

  --CCR BRANCH III
  @t_ejec               char(1) = 'N',
  @i_fecha_valor_a      datetime = null,
  @i_usateller          char(1) = 'N',
  @o_control            int out,
  @o_sldcont            money out,
  @o_slddisp            money out,
  @o_nombre             varchar(30) out,
  @o_cliente            int = null out,
  @o_int_cap            money out,
  @o_lineas             int out,
  @o_usa                char(1) out,
  @o_sldlib             money out,
  @o_nctrl              smallint out,
  @o_oficina_cta        smallint out,
  @o_prod_banc          smallint = null out,
  @o_categoria          char(1) = null out,
  @o_monto_imp          money out,
  @o_tipo_exonerado_imp char(2) out,
  @o_tipocta_super      char(1) = null out,
  @o_clase_clte         char(1) = null out,
  @o_base_gmf           money = null out
)
as
  declare
    @w_return        int,
    @w_sp_name       varchar(30),
    @w_cuenta        int,
    @w_filial_p      tinyint,
    @w_oficina_p     smallint,
    @w_pide_aut      char(1),
    @w_factor        int,
    @w_tipo_promedio char(1),
    @w_signo         char(1),
    @w_efe           money,
    @w_prop          money,
    @w_loc           money,
    @w_rem           money,
    @w_estado        char(1),
    @w_monto_imp     money,
    @w_tran_especial int

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_retndcl_locrem'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
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
    @t_debug        = @t_debug,
    @t_file         = @t_file,
    @t_from         = @w_sp_name,
    @i_cta_banco    = @i_cta,
    @i_moneda       = @i_mon,
    @o_cuenta       = @w_cuenta out,
    @o_filial       = @w_filial_p out,
    @o_oficina      = @w_oficina_p out,
    @o_tipo_promedio= @w_tipo_promedio out
  if @w_return <> 0
    return @w_return

  select
    @o_oficina_cta = @w_oficina_p

  if @i_turno is null
    select
      @i_turno = @s_rol

  -- Tablas de trabajo para el manejo de lineas pendientes y actualizacion de libreta
  create table #lpendiente
  (
    fecha    smalldatetime,
    valor    money,
    saldo    money,
    control  smallint,
    nemonico char(4),
    signo    char(1),
    lp_linea int
  )

  create table #lpendiente_5ult
  (
    fecha    smalldatetime,
    valor    money,
    saldo    money,
    control  smallint,
    nemonico char(4),
    signo    char(1),
    lp_linea int
  )

  create table #lpendiente_def
  (
    fecha    smalldatetime,
    valor    money,
    saldo    money,
    control  smallint,
    nemonico char(4),
    signo    char(1)
  )

  /*  Retiro y Nota debito con libreta */
  begin tran

  select
    @w_monto_imp = $0

  if @w_factor = -1
  begin
    if @t_trn in (261, 262)
      select
        @w_monto_imp = tm_monto_imp
      from   cob_ahorros..ah_tran_monet
      where  tm_moneda       = @i_mon
         and tm_valor        = @i_val
         and tm_estado is null
         --and tm_secuencial   = @t_ssn_corr
         and tm_ssn_branch   = @t_ssn_corr
         and tm_oficina      = @s_ofi
         and tm_tipo_tran    = @t_trn
         and tm_cta_banco    = @i_cta
         and tm_saldo_lib    = @i_sdolib
         and tm_indicador    = @i_ind
         and tm_causa        = @i_cau
         and tm_departamento = @i_dep
         --and tm_concepto     = @i_concep
         and tm_usuario      = @s_user

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

  exec @w_return = cob_ahorros..sp_ah_retirond_cl
    @t_debug              = @t_debug,
    @t_file               = @t_file,
    @t_from               = @w_sp_name,
    @t_trn                = @t_trn,
    @t_corr               = @t_corr,
    @p_lssn               = @p_lssn,
    @p_rssn_corr          = @p_rssn_corr,
    @t_rty                = @t_rty,
    @s_sesn               = @s_sesn,
    @s_ssn_branch         = @s_ssn_branch,
    @s_rol                = @s_rol,
    @s_ofi                = @s_ofi,
    @s_sev                = @s_sev,
    @s_lsrv               = @s_lsrv,
    @s_srv                = @s_srv,
    @s_user               = @s_user,
    @s_term               = @s_term,
    @s_ssn                = @s_ssn,
    @s_org                = @s_org,
    @t_ssn_corr           = @t_ssn_corr,
    @i_cta                = @i_cta,
    @i_cuenta             = @w_cuenta,
    @i_mon                = @i_mon,
    @i_sdolib             = @i_sdolib,
    @i_val                = @i_val,
    @i_control            = @i_control,
    @i_ind                = @i_ind,
    @i_cau                = @i_cau,
    @i_factor             = @w_factor,
    @i_fecha              = @s_date,
    @i_ncontrol           = @i_ncontrol,
    @i_lpend              = @i_lpend,
    @i_monto_imp          = @w_monto_imp,
    @i_filial             = @i_filial,
    @i_idcaja             = @i_idcaja,
    @i_idcierre           = @i_idcierre,
    @i_sld_caja           = @i_sld_caja,
    @i_usateller          = @i_usateller,
    @o_sldcont            = @o_sldcont out,
    @o_slddisp            = @o_slddisp out,
    @o_control            = @o_control out,
    @o_nombre             = @o_nombre out,
    @o_cliente            = @o_cliente out,
    @o_int_cap            = @o_int_cap out,
    @o_lineas             = @o_lineas out,
    @o_usa                = @o_usa out,
    @o_sldlib             = @o_sldlib out,
    @o_nctrl              = @o_nctrl out,
    @o_prod_banc          = @o_prod_banc out,
    @o_categoria          = @o_categoria out,
    @o_monto_imp          = @o_monto_imp out,
    @o_tipo_exonerado_imp = @o_tipo_exonerado_imp out,
    @o_tipocta_super      = @o_tipocta_super out,
    @o_clase_clte         = @o_clase_clte out,
    @o_base_gmf           = @o_base_gmf out

  if @i_usateller = 'N'
  begin
    if @w_return = 2
    begin
      commit tran
      return @w_return
    end
  end

  if @w_return <> 0
    return @w_return

  if @w_factor = -1
    select
      @w_estado = 'R'

  select
    @w_efe = 0,
    @w_prop = 0,
    @w_loc = 0,
    @w_rem = 0

  /* Buscar si existe transaccion especial */
  select
    @w_tran_especial = te_tran_final
  from   cob_remesas..re_tran_especiales
  where  te_tran_original = @t_trn
     and te_causas        = @i_cau

  if @@rowcount = 0
    select
      @w_tran_especial = @t_trn

  if @s_org = 'S'
  begin
    if @t_trn = 261
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
        @i_saldo_caja = @i_sld_caja,
        @i_cta_banco  = @i_cta
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

    if @t_trn = 262
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
        @i_trn          = @w_tran_especial,
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
        @i_cta_banco    = @i_cta,
        @i_cau          = @i_cau
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
    insert into cob_ahorros..ah_tran_monet
                (tm_secuencial,tm_ssn_branch,tm_tipo_tran,tm_oficina,tm_usuario,
                 tm_terminal,tm_correccion,tm_sec_correccion,tm_reentry,
                 tm_origen,
                 tm_nodo,tm_fecha,tm_cta_banco,tm_valor,tm_indicador,
                 tm_causa,tm_saldo_lib,tm_interes,tm_remoto_ssn,tm_moneda,
                 tm_signo,tm_control,tm_saldo_contable,tm_saldo_disponible,
                 tm_saldo_interes,
                 tm_departamento,tm_oficina_cta,tm_concepto,tm_estado,
                 tm_prod_banc
                 ,
                 tm_categoria,tm_monto_imp,tm_tipo_exonerado_imp,
                 tm_tipocta_super,
                 tm_turno,
                 tm_hora,tm_cliente,tm_base_gmf,tm_clase_clte)
    values      (@s_ssn,@s_ssn_branch,@t_trn,@s_ofi,@s_user,
                 @s_term,@t_corr,@p_rssn_corr,@t_rty,'R',
                 @s_srv,@s_date,@i_cta,@i_val,@i_ind,
                 @i_cau,@i_sdolib,null,@p_lssn,@i_mon,
                 @w_signo,@o_nctrl,@o_sldcont,@o_slddisp,null,
                 @i_dep,@w_oficina_p,@i_concep,@w_estado,@o_prod_banc,
                 @o_categoria,@o_monto_imp,@o_tipo_exonerado_imp,
                 @o_tipocta_super,
                 @i_turno,
                 getdate(),@o_cliente,@o_base_gmf,@o_clase_clte)
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
  else if @s_org = 'U'
  begin
    if @t_trn = 261
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
        @i_saldo_caja = @i_sld_caja,
        @i_cta_banco  = @i_cta
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
    if @t_trn = 262
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
        @i_trn          = @w_tran_especial,
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
        @i_cta_banco    = @i_cta,
        @i_cau          = @i_cau
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

    insert into cob_ahorros..ah_tran_monet
                (tm_secuencial,tm_ssn_branch,tm_tipo_tran,tm_oficina,tm_usuario,
                 tm_terminal,tm_correccion,tm_sec_correccion,tm_reentry,
                 tm_origen,
                 tm_nodo,tm_fecha,tm_cta_banco,tm_valor,tm_indicador,
                 tm_causa,tm_saldo_lib,tm_interes,tm_remoto_ssn,tm_moneda,
                 tm_signo,tm_control,tm_saldo_contable,tm_saldo_disponible,
                 tm_saldo_interes,
                 tm_departamento,tm_oficina_cta,tm_concepto,tm_estado,
                 tm_prod_banc
                 ,
                 tm_categoria,tm_monto_imp,tm_tipo_exonerado_imp,
                 tm_tipocta_super,
                 tm_turno,
                 tm_hora,tm_cliente,tm_base_gmf,tm_clase_clte)
    values      (@s_ssn,@s_ssn_branch,@t_trn,@s_ofi,@s_user,
                 @s_term,@t_corr,@t_ssn_corr,@t_rty,'L',
                 @s_srv,@s_date,@i_cta,@i_val,@i_ind,
                 @i_cau,@i_sdolib,null,@p_lssn,@i_mon,
                 @w_signo,@o_nctrl,@o_sldcont,@o_slddisp,null,
                 @i_dep,@w_oficina_p,@i_concep,@w_estado,@o_prod_banc,
                 @o_categoria,@o_monto_imp,@o_tipo_exonerado_imp,
                 @o_tipocta_super,
                 @i_turno,
                 getdate(),@o_cliente,@o_base_gmf,@o_clase_clte)
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
  if @w_factor = -1
  begin
    update cob_ahorros..ah_tran_monet
    set    tm_estado = @w_estado
    where  tm_moneda       = @i_mon
       and tm_valor        = @i_val
       and tm_estado is null
       --      and tm_secuencial   = @t_ssn_corr
       and tm_ssn_branch   = @t_ssn_corr
       and tm_oficina      = @s_ofi
       and tm_cta_banco    = @i_cta
       and tm_saldo_lib    = @i_sdolib
       and tm_indicador    = @i_ind
       and tm_causa        = @i_cau
       and tm_departamento = @i_dep
       --and tm_concepto = @i_concep
       and tm_usuario      = @s_user

    if @@rowcount <> 1
    begin
      /* Los datos del reverso no coinciden con los originales */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251067
      return 251067
    end
  end

  commit tran
  return 0

go

