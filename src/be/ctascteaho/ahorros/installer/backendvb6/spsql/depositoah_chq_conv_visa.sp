/********************************************************************/
/*  Archivo:                depositoah_chq_conv_visa.sp             */
/*  Stored procedure:       sp_depositoah_chq_conv_visa             */
/*  Base de datos:          cob_ahorros                             */
/*  Producto:               Cuentas de Ahorros                      */
/*  Disenado por:           Juan F. Cadena                          */
/*  Fecha de escritura:     09-May-2005                             */
/********************************************************************/
/*                         IMPORTANTE                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*  de COBISCorp.                                                   */
/*  Su uso no autorizado queda expresamente prohibido asi como      */
/*  cualquier alteracion o agregado hecho por alguno  de sus        */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*  Este programa esta protegido por la ley de derechos de autor    */
/*  y por las convenciones  internacionales de propiedad inte-      */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*  penalmente a los autores de cualquier infraccion.               */
/********************************************************************/
/*                          PROPOSITO                               */
/*  Este programa procesa la transaccion de deposito de cheque de   */
/*  conveniencia Visa                                               */
/********************************************************************/
/*                          MODIFICACIONES                          */
/*  FECHA           AUTOR            RAZON                          */
/*  09/May/2005     Juan F. Cadena   Emision inicial                */
/*  03/May/2016     J. Salazar       Migracion COBIS CLOUD MEXICO   */
/********************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_depositoah_chq_conv_visa')
  drop proc sp_depositoah_chq_conv_visa
go

/****** Object:  StoredProcedure [dbo].[sp_depositoah_chq_conv_visa]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_depositoah_chq_conv_visa
(
  @s_ssn          int,
  @s_ssn_branch   int,
  @s_srv          varchar(30),
  @s_lsrv         varchar(30),
  @s_user         varchar(30),
  @s_sesn         int = null,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_ofi          smallint,/* Localidad origen transaccion */
  @s_rol          smallint,
  @s_org_err      char(1) = null,/* Origen de ERROR: [A], [S] */
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          mensaje = null,
  @s_org          char(1),
  @t_corr         char(1) = 'N',
  @t_ssn_corr     int = null,/* Trans a ser reversada */
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @t_trn          smallint,
  @t_ejec         char(1) = 'N',
  @t_show_version bit = 0,
  @i_filial       smallint = 1,
  @i_mon          tinyint,
  @i_idcaja       int = 0,
  @i_idcierre     int = 0,
  @i_sld_caja     money = 0,
  @i_turno        smallint = null,
  @i_canal        smallint = null,
  @i_cta          cuenta,
  @i_tarjeta      varchar(16),
  @i_cheque       int,
  @i_autorizacion varchar(6),
  @i_monto        money,
  @o_nombre       varchar(30) = null out,
  @o_ssn          int = null out
)
as
  declare
    @w_return           int,
    @w_sp_name          varchar(30),
    @w_factor           int,
    @w_estado           varchar(1),
    @w_signo            char(1),
    @w_monto_maximo_deb money,
    @w_numtelefono      varchar(12),
    @w_moneda_do        tinyint,
    @w_mombre           char(64),
    @w_cod_cliente      int,
    @w_num_id           char(15),
    @w_siguiente        int,
    @w_tipo_comision    char(1),
    @w_valor_tasa       float,
    @w_saldo            money,
    @w_cta              cuenta,
    @w_val_com          money

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_depositoah_chq_conv_visa',
    @o_ssn = @s_ssn_branch

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  -- Valida si se ha aperturado caja
  if @s_org = 'U'
  begin
    if @i_idcaja = 0
    begin
      if not exists (select
                       1
                     from   cob_remesas..re_caja
                     where  cj_oficina     = @s_ofi
                        and cj_rol         = @s_rol
                        and cj_operador    = @s_user
                        and cj_moneda      = @i_mon
                        and cj_transaccion = 15)
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 201063
        return 201063
      end
    end
    else -- Version Branch Explorer
    begin
      exec @w_return = cob_remesas..sp_verifica_caja
        @t_trn    = @t_trn,
        @i_user   = @s_user,
        @i_ofi    = @s_ofi,
        @i_srv    = @s_srv,
        @i_date   = @s_date,
        @i_filial = @i_filial,
        @i_mon    = @i_mon,
        @i_idcaja = @i_idcaja
      if @w_return <> 0
        return @w_return

    end
  end

  -- Modo de correccion
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

  -- Validaciones para el reverso
  if @w_factor = -1
  begin
    if not exists (select
                     1
                   from   cob_ahorros..ah_tran_servicio
                   where  ts_ssn_branch       = @t_ssn_corr
                      and ts_oficina          = @s_ofi
                      and ts_tipo_transaccion = @t_trn
                      and ts_usuario          = @s_user
                      and ts_cta_gir          = @i_tarjeta
                      and ts_estado is null
                      and ts_cheque_rec       = @i_cheque
                      and ts_autoriz_aut      = @i_autorizacion
                      and ts_monto            = @i_monto)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251067
      return 251067
    end
  end

  begin tran
  exec @w_return = cob_ahorros..sp_ahndc_automatica
    @s_ssn        = @s_ssn,
    @s_ssn_branch = @s_ssn_branch,
    @s_srv        = @s_srv,
    @s_lsrv       = @s_lsrv,
    @s_user       = @s_user,
    @s_sesn       = @s_sesn,
    @s_term       = @s_term,
    @s_date       = @s_date,
    @s_ofi        = @s_ofi,
    @s_rol        = @s_rol,
    @s_org_err    = @s_org_err,
    @s_error      = @s_error,
    @s_sev        = @s_sev,
    @s_msg        = @s_msg,
    @s_org        = @s_org,
    @t_ejec       = @t_ejec,
    @t_corr       = @t_corr,
    @t_ssn_corr   = @t_ssn_corr,
    @t_debug      = @t_debug,
    @t_file       = @t_file,
    @t_from       = @t_from,
    @t_rty        = @t_rty,
    @t_trn        = 253,
    @i_cta        = @i_cta,
    @i_val        = @i_monto,
    @i_cau        = '147',
    @i_mon        = @i_mon,
    @i_fecha      = @s_date,
    @i_alt        = 1

  if @w_return <> 0
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 207047
    return @w_return
  end

  exec @w_return = cob_remesas..sp_upd_totales
    @i_ofi        = @s_ofi,
    @i_rol        = @s_rol,
    @i_user       = @s_user,
    @i_mon        = @i_mon,
    @i_trn        = @t_trn,
    @i_nodo       = @s_srv,
    @i_tipo       = 'L',
    @i_corr       = @t_corr,
    @i_ssn        = @s_ssn,
    @i_filial     = @i_filial,
    @i_idcaja     = @i_idcaja,
    @i_idcierre   = @i_idcierre,
    @i_saldo_caja = @i_sld_caja,
    @i_efectivo   = @i_monto
  if @w_return <> 0
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 205000
    return 205000
  end

  -- Transaccion de servicio
  insert into cob_ahorros..ah_tran_servicio
              (ts_secuencial,ts_tipo_transaccion,ts_oficina,ts_usuario,
               ts_terminal,
               ts_correccion,ts_ssn_corr,ts_sec_correccion,ts_reentry,ts_origen,
               ts_nodo,ts_tsfecha,ts_monto,ts_tipo,ts_moneda,
               ts_oficina_cta,ts_clase,ts_cod_alterno,ts_ssn_branch,ts_turno,
               ts_cta_gir,ts_cheque_rec,ts_autoriz_aut,ts_cta_banco)
  values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
               @t_corr,@t_ssn_corr,@t_ssn_corr,@t_rty,'L',
               @s_srv,@s_date,@i_monto,@w_signo,@i_mon,
               @s_ofi,'N',0,@s_ssn_branch,@i_turno,
               @i_tarjeta,@i_cheque,@i_autorizacion,@i_cta)
  if @@error <> 0
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 203000
    return 203000
  end

  -- Grabar la Transaccion en la tabla de envio de archivos de Visa
  insert into cob_remesas..tb_tran_servicio_bvatm
              (tt_secuencial,tt_tipo_transaccion,tt_oficina,tt_usuario,
               tt_terminal,
               tt_correccion,tt_ssn_corr,tt_sec_correccion,tt_reentry,tt_origen,
               tt_nodo,tt_tsfecha,tt_monto,tt_tipo,tt_moneda,
               tt_oficina_cta,tt_clase,tt_cod_alterno,tt_ssn_branch,tt_turno,
               tt_cta_gir,tt_cheque_rec,tt_autoriz_aut,tt_cta_banco)
  values      (@s_ssn,@t_trn,@s_ofi,@s_user,@s_term,
               @t_corr,@t_ssn_corr,@t_ssn_corr,@t_rty,'L',
               @s_srv,@s_date,@i_monto,@w_signo,@i_mon,
               @s_ofi,'N',0,@s_ssn_branch,@i_turno,
               @i_tarjeta,@i_cheque,@i_autorizacion,@i_cta)
  if @@error <> 0
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 203000
    return 203000
  end

  if @w_factor = -1
  begin
    update cob_ahorros..ah_tran_servicio
    set    ts_estado = 'R'
    where  ts_tipo_transaccion = @t_trn
       and ts_clase            = 'N'
       and ts_ssn_branch       = @t_ssn_corr
       and ts_oficina          = @s_ofi
       and ts_cod_alterno      = 0
    if @@rowcount <> 1
    begin
      -- No encontro el registro
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251067
      return 251067
    end

    update cob_remesas..tb_tran_servicio_bvatm
    set    tt_estado = 'R'
    where  tt_tipo_transaccion = @t_trn
       and tt_clase            = 'N'
       and tt_ssn_branch       = @t_ssn_corr
       and tt_oficina          = @s_ofi
       and tt_cod_alterno      = 0
    if @@rowcount <> 1
    begin
      -- No encontro el registro
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251067
      return 251067
    end
  end
  commit tran

  if @t_ejec = 'R'
  begin
    exec cob_remesas..sp_resultados_branch_caja
      @i_sldcaja  = @i_sld_caja,
      @i_idcierre = @i_idcierre,
      @i_ssn_host = @s_ssn
  end

  return 0

go

