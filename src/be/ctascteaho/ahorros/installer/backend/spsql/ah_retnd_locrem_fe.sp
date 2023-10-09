/************************************************************************/
/*  Archivo:            ah_retnd_locrem_fe.sp                           */
/*  Stored procedure:   sp_ah_retnd_locrem_fe                           */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Julio Navarrete/Javier Bucheli                  */
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
/*      Retiro y Nota de Debito con FECHA EFECTIVA                      */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA        AUTOR               RAZON                              */
/*  10/Feb/1993  X Gellibert Coello  Emision Inicial                    */
/*  02/Mayo/2016 Ignacio Yupa        Migración a CEN                    */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_retnd_locrem_fe')
  drop proc sp_ah_retnd_locrem_fe
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_retnd_locrem_fe
(
  @s_ssn           int,
  @s_ssn_branch    int,
  @s_lsrv          varchar(30),
  @s_srv           varchar(30),
  @s_user          varchar(30),
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_ofi           smallint,/* Localidad origen transaccion */
  @s_rol           smallint,
  @s_sev           tinyint,
  @p_lssn          int = null,
  @t_corr          char(1) = 'N',
  @t_ssn_corr      int = null,  
  @p_rssn_corr     int = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(14) = null,
  @t_from          varchar(32) = null,
  @t_rty           char(1) = 'N',
  @t_ejec          char(1) = null,
  @s_org           char(1),
  @t_trn           int,
  @t_show_version  bit = 0,
  @i_cta           varchar(24),
  @i_mon           tinyint,
  @i_val           money,
  @i_ind           tinyint,
  @i_cau           char(3),
  @i_dep           smallint,
  @i_fec_efe       datetime,
  @i_oficina       smallint,
  @i_sld_caja      money = 0,--RAN: migracion COBIS Explorer
  @i_idcaja        int = 0,--RAN: migracion COBIS Explorer
  @i_idcierre      int = 0,--RAN: migracion COBIS Explorer  
  @i_fecha_valor_a datetime = null,--RAN: migracion COBIS Explorer  
  @i_filial        tinyint = 0,--RAN: migracion COBIS Explorer
  @i_canal         tinyint = 4,--4 CAJAS              
  @o_sldcont       money out,
  @o_slddisp       money out,
  @o_nombre        varchar(60) out,
  @o_cedula        varchar(20) out,
  @o_aj_int        money out,
  @o_aj_cap        money out,
  @o_aj_ret        money out,
  @o_fecha         datetime out,
  @o_ofi_cta       smallint out,
  @o_oficial       smallint out,
  @o_prod_banc     smallint out,
  @o_categoria     char(1) out,
  @o_tipocta_super char(1) out,
  @o_clase_clte    char(1) = null out,
  @o_cliente       int = null out,
  @o_val_nx1000    money = null out,
  @o_valiva        money = null out,
  @o_base_gmf      money = null out
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
    @w_oficial       smallint,
    @w_signo         char(1),
    @w_estado        char(1),
    @w_efe           money,
    @w_prod_banc     tinyint,
    @w_marca         char(1),
    @w_impuesto      money,
    @w_cliente       int,
    @w_categoria     char(1),--MVE AH00007
    @w_tipocta_super char(1)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_retnd_locrem_fe'

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
      @w_signo = 'D',
      @w_estado = null
  else
    select
      @w_factor = -1,
      @w_signo = 'C',
      @w_estado = 'R'

  /*  Determinacion de vigencia de cuenta  */
  exec @w_return = cob_ahorros..sp_ctah_vigente
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_cta_banco = @i_cta,
    @i_moneda    = @i_mon,
    @o_cuenta    = @w_cuenta out,
    @o_filial    = @w_filial_p out,
    @o_oficina   = @w_oficina_p out,
    @o_tpromedio = @w_tipo_promedio out,
    @o_oficial   = @w_oficial out

  if @w_return <> 0
    return @w_return

  /*  Retiro y Nota debito con fecha efectiva */
  begin tran
  exec @w_return = cob_ahorros..sp_retiro_ndebito_fe
    @s_ssn           = @s_ssn,
    @s_srv           = @s_srv,
    @s_lsrv          = @s_lsrv,
    @s_ofi           = @s_ofi,
    @s_user          = @s_user,
    @s_ssn_branch    = @s_ssn_branch,
    @t_debug         = @t_debug,
    @t_file          = @t_file,
    @t_from          = @w_sp_name,
    @s_term          = @s_term,
    @t_ejec          = @t_ejec,
    @t_trn           = @t_trn,
    @t_corr          = @t_corr,
    @t_ssn_corr      = @t_ssn_corr,
    @i_filial        = @w_filial_p,
    @i_cuenta        = @w_cuenta,
    @i_mon           = @i_mon,
    @i_ofi           = @s_ofi,
    @i_val           = @i_val,
    @i_ind           = @i_ind,
    @i_cau           = @i_cau,
    @i_fecha_efec    = @i_fec_efe,
    @i_factor        = @w_factor,
    @i_fecha         = @s_date,
    @i_marca         = @w_marca,
    @o_val_nx1000    = @o_val_nx1000 out,
    @o_valiva        = @o_valiva out,
    @o_sldcont       = @o_sldcont out,
    @o_slddisp       = @o_slddisp out,
    @o_aj_cap        = @o_aj_cap out,
    @o_aj_int        = @o_aj_int out,
    @o_aj_ret        = @o_aj_ret out,
    @o_nombre        = @o_nombre out,
    @o_cedula        = @o_cedula out,
    @o_fecha         = @o_fecha out,
    @o_ofi_cta       = @o_ofi_cta out,
    @o_clase_clte    = @o_clase_clte out,
    @o_prod_banc     = @w_prod_banc out,
    @o_cliente       = @w_cliente out,
    @o_categoria     = @w_categoria out,
    @o_tipocta_super = @w_tipocta_super out,--AH00007 MVE
    @o_base_gmf      = @o_base_gmf out

  if @w_return <> 0
    return @w_return

  select
    @w_efe = 0
  select
    @o_cliente = @w_cliente

  /* Actualizacion de totales de cajero */
  if @s_org = 'S'
  begin
    insert into cob_ahorros..ah_tran_monet
                (tm_secuencial,tm_ssn_branch,tm_tipo_tran,tm_oficina,tm_usuario,
                 tm_terminal,tm_correccion,tm_sec_correccion,tm_reentry,
                 tm_origen,
                 tm_nodo,tm_fecha,tm_cta_banco,tm_valor,tm_indicador,
                 tm_causa,tm_remoto_ssn,tm_moneda,tm_signo,tm_saldo_contable,
                 tm_saldo_disponible,tm_departamento,tm_saldo_interes,tm_interes
                 ,
                 tm_oficina_cta,
                 tm_efectivo,tm_clase_clte,tm_prod_banc,tm_estado,tm_oficial,
                 tm_canal,tm_monto_imp,tm_cliente,tm_categoria,tm_tipocta_super,
                 tm_valor_comision,tm_base_gmf)
    values      (@s_ssn,@s_ssn_branch,@t_trn,@s_ofi,@s_user,
                 @s_term,@t_corr,@t_ssn_corr,@t_rty,"L",
                 @s_srv,@s_date,@i_cta,@i_val,@i_ind,
                 @i_cau,@p_lssn,@i_mon,@w_signo,@o_sldcont,
                 @o_slddisp,@i_dep,@o_aj_int,@o_aj_cap,@o_ofi_cta,
                 @i_val,@o_clase_clte,@w_prod_banc,@w_estado,@w_oficial,
                 4,@o_val_nx1000,@w_cliente,@w_categoria,@w_tipocta_super,
                 @o_valiva,@o_base_gmf)
    if @@error <> 0
    begin /** Error Insertar Transaccion Monetaria **/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253000
      return 253000
    end

    if @w_factor = -1
    begin
      update cob_ahorros..ah_tran_monet
      set    tm_estado = @w_estado,
             tm_sec_correccion = @s_ssn_branch
      where  tm_ssn_branch = @t_ssn_corr
         and tm_oficina    = @s_ofi
         and tm_valor      = @i_val
         and tm_estado is null

      if @@rowcount <> 1
      begin
        /* No encontrs el registro en monetarias */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251067
        return 251067
      end
    end

    if @i_ind = 1
      select
        @w_efe = @i_val

    /* Actualizacion de Totales de cajero */
    exec @w_return = cob_remesas..sp_upd_totales
      @i_ofi        = @s_ofi,
      @i_rol        = @s_rol,
      @i_user       = @s_user,
      @i_mon        = @i_mon,
      @i_trn        = @t_trn,
      @i_nodo       = @s_srv,
      @i_tipo       = 'R',
      @i_corr       = @t_corr,
      @i_efectivo   = @w_efe,
      @i_adj_int    = @o_aj_int,
      @i_adj_cap    = @o_aj_cap,
      @i_idcaja     = @i_idcaja,
      @i_filial     = @i_filial,
      @i_saldo_caja = @i_sld_caja,
      @i_idcierre   = @i_idcierre,
      @i_causa      = @i_cau

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
  else if @s_org = 'U'
  begin
    insert into cob_ahorros..ah_tran_monet
                (tm_secuencial,tm_ssn_branch,tm_tipo_tran,tm_oficina,tm_usuario,
                 tm_terminal,tm_correccion,tm_sec_correccion,tm_reentry,
                 tm_origen,
                 tm_nodo,tm_fecha,tm_cta_banco,tm_valor,tm_indicador,
                 tm_causa,tm_remoto_ssn,tm_moneda,tm_signo,tm_saldo_contable,
                 tm_saldo_disponible,tm_departamento,tm_saldo_interes,tm_interes
                 ,
                 tm_oficina_cta,
                 tm_efectivo,tm_clase_clte,tm_prod_banc,tm_estado,tm_canal,
                 tm_monto_imp,tm_cliente,tm_categoria,tm_tipocta_super,
                 tm_valor_comision,
                 tm_base_gmf)
    values      (@s_ssn,@s_ssn_branch,@t_trn,@s_ofi,@s_user,
                 @s_term,@t_corr,@t_ssn_corr,@t_rty,"L",
                 @s_srv,@s_date,@i_cta,@i_val,@i_ind,
                 @i_cau,@p_lssn,@i_mon,@w_signo,@o_sldcont,
                 @o_slddisp,@i_dep,@o_aj_int,@o_aj_cap,@o_ofi_cta,
                 @i_val,@o_clase_clte,@w_prod_banc,@w_estado,4,
                 @o_val_nx1000,@w_cliente,@w_categoria,@w_tipocta_super,
                 @o_valiva,
                 @o_base_gmf)
    if @@error <> 0
    begin /** Error Insertar Transaccion Monetaria **/
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 253000
      return 253000
    end

    if @w_factor = -1
    begin
      update cob_ahorros..ah_tran_monet
      set    tm_estado = @w_estado,
             tm_sec_correccion = @s_ssn_branch
      where  tm_ssn_branch = @t_ssn_corr
         and tm_oficina    = @s_ofi
         and tm_valor      = @i_val
         and tm_estado is null

      if @@rowcount <> 1
      begin
        /* No encontrs el registro en monetarias */
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 251067
        return 251067
      end
    end

    if @t_trn = 316
    begin
      /* Actualizacion de Totales de cajero */
      exec @w_return = cob_remesas..sp_upd_totales
        @i_ofi        = @s_ofi,
        @i_rol        = @s_rol,
        @i_user       = @s_user,
        @i_mon        = @i_mon,
        @i_trn        = @t_trn,
        @i_nodo       = @s_srv,
        @i_tipo       = 'L',
        @i_corr       = @t_corr,
        @i_efectivo   = @i_val,
        @i_adj_int    = @o_aj_int,
        @i_adj_cap    = @o_aj_cap,
        @i_saldo_caja = @i_sld_caja,
        @i_idcaja     = @i_idcaja,
        @i_idcierre   = @i_idcierre,
        @i_filial     = @i_filial,
        @i_causa      = @i_cau

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
  end
  commit tran
  return 0

go

