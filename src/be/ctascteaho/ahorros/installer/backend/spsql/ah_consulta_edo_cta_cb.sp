/************************************************************************/
/*  Archivo:            ah_consulta_edo_cta_cb.sp                       */
/*  Stored procedure:   sp_ah_consulta_edo_cta_cb                       */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Yenny Rivero                                    */
/*  Fecha de escritura: 06 Abril 2000                                   */
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
/*  Este programa procesa la transaccion de Consulta de Estado de       */
/*      Cuenta de Ahorro por fechas sin reverso para Conexion Bancaribe */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA           AUTOR            RAZON                              */
/*  06 Abril 2000   Yenny Rivero     Emision inicial                    */
/*  15 Agosto 2000  Tamelvin Angulo  Envio de la referencia             */
/*  02/Mayo/2016    Ignacio Yupa     Migración a CEN                    */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_consulta_edo_cta_cb')
  drop proc sp_ah_consulta_edo_cta_cb
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_consulta_edo_cta_cb
(
  @s_ssn          int,
  @s_srv          varchar(30),
  @s_user         varchar(30),
  @s_sesn         int,
  @s_term         varchar(10),
  @s_date         datetime,
  @s_ofi          smallint,/* Localidad origen transaccion */
  @s_rol          smallint,
  @s_sev          tinyint = null,
  @p_lssn         int = null,  
  @t_corr         char(1) = 'N',
  @t_ssn_corr     int = null,
  @p_rssn_corr    int = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_rty          char(1) = 'N',
  @s_org          char(1),
  @t_trn          int,
  @t_show_version bit = 0,
  @i_cta          cuenta,
  @i_fchdsde      varchar(10),
  @i_fchhsta      varchar(10),
  @i_sec          int,
  @i_sec_alt      int,
  @i_mon          tinyint,
  @i_diario       tinyint,
  @i_inforcuenta  char(1),
  @i_modo         char(1) = '0',
  @o_hist         tinyint out
)
as
  declare
    @w_return           int,
    @w_sp_name          varchar(30),
    @w_oficina          smallint,
    @w_ttran            smallint,
    @w_cuenta           int,
    @w_rcount           tinyint,
    @w_fchtmp           varchar(8),
    @w_fecha            datetime,
    @w_signo            char(1),
    @w_descripcion      descripcion,
    @w_ciudes           descripcion,
    @w_moneda           varchar(20),
    @w_nombre           mensaje,
    @w_direccion        mensaje,
    @w_valor            money,
    @w_saldo            money,
    @w_saldodis         money,
    @w_interes          money,
    @w_saldo_para_girar money,
    @w_saldo_contable   money,
    @w_cheque           int,
    @w_sec              int,
    @w_ssn              int,
    @w_sec_alt          int,
    @w_ssn_alt          int,
    @w_contador         tinyint,
    @w_lineas           tinyint,
    @w_corr             char(1),
    @w_funcionario      char(1)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_consulta_edo_cta_cb'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @i_modo = '0'
    if @i_diario <> 0
       and @i_sec = 0
      select
        @i_sec = -2147483648

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
      s_sev = @s_sev,
      p_lssn = @p_lssn,
      t_corr = @t_corr,
      t_debug = @t_debug,
      t_from = @t_from,
      t_file = @t_file,
      t_rty = @t_rty,
      s_ori = @s_org,
      t_trn = @t_trn,
      i_cta = @i_cta,
      i_fchdsde = @i_fchdsde,
      i_fchhsta = @i_fchhsta,
      i_sec = @i_sec,
      i_mon = @i_mon,
      i_diario = @i_diario,
      i_inforcuenta = @i_inforcuenta,
      o_hist = @o_hist
    exec cobis..sp_end_debug
  end

  /*  Determinacion de la cuenta interna */
  select
    @w_cuenta = ah_cuenta,
    @w_funcionario = ah_cta_funcionario
  from   cob_ahorros..ah_cuenta
  where  ah_cta_banco = @i_cta

  /* Verificacion de cuentas de funcionarios para oficiales autorizados */
  if @w_funcionario = 'S'
     and @i_inforcuenta = 'N'
  begin
    if not exists (select
                     1
                   from   cob_remesas..re_ofi_personal,
                          cobis..cc_oficial,
                          cobis..cl_funcionario
                   where  fu_login       = @s_user
                      and fu_funcionario = oc_funcionario
                      and op_oficial     = oc_oficial)
    begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 201123
      return 1
    end
  end

  /* Calcular el saldo */
  exec @w_return = cob_ahorros..sp_ahcalcula_saldo
    @t_debug            = @t_debug,
    @t_file             = @t_file,
    @t_from             = @w_sp_name,
    @i_cuenta           = @w_cuenta,
    @i_fecha            = @s_date,
    @i_ofi              = @s_ofi,
    @o_saldo_para_girar = @w_saldo_para_girar out,
    @o_saldo_contable   = @w_saldo_contable out
  if @w_return <> 0
    return @w_return

  if @i_modo = '0'
  begin
    if @i_sec = 0
    begin
      /* Datos de la cabecera */
      select
        convert(varchar(10), ah_fecha_ult_mov, 103),
        convert(varchar(10), ah_fecha_ult_corte, 103),
        mo_descripcion,
        ah_descripcion_ec,
        convert (varchar(10), ah_fecha_prx_corte, 103),
        ah_parroquia,
        ah_zona,
        ah_saldo_ult_corte,
        fu_nombre
      from   cob_ahorros..ah_cuenta,
             cobis..cl_moneda,
             cobis..cl_funcionario,
             cobis..cc_oficial
      where  ah_cuenta      = @w_cuenta
         and mo_moneda      = ah_moneda
         and oc_oficial     = ah_oficial
         and fu_funcionario = oc_funcionario

      select
        te_valor
      from   cob_ahorros..ah_cuenta,
             cobis..cl_direccion,
             cobis..cl_telefono
      where  ah_cuenta     = @w_cuenta
         and di_ente       = ah_cliente
         and di_direccion  = ah_direccion_ec
         and te_ente       = di_ente
         and te_direccion  = di_direccion
         and te_secuencial = di_telefono

    end

    /* Datos del historico de movimientos */
    set rowcount 15
    if @i_diario = 0
    begin
      if @i_sec = 0
        select
          @i_sec = -2147483648

      select
        convert(varchar(10), hm_fecha, 103),
        hm_causa,
        hm_oficina,
        hm_correccion,
        tn_descripcion,
        hm_signo,
        (hm_valor + isnull(hm_chq_propios, $0) + isnull(hm_chq_locales, $0)
         + isnull(hm_chq_ot_plazas, $0)),
        isnull(hm_monto_imp,
               $0),
        hm_saldo_contable,
        hm_saldo_disponible,
        isnull(hm_interes,
               $0),
        hm_transaccion,
        hm_cod_alterno,
        isnull((select
                  X.hm_serial
                where  X.hm_tipo_tran in (253, 264)),-- ND Y NC CON SERIAL
               isnull((select
                         '$000' + X.hm_concepto +
                         convert(varchar(5), X.hm_banco)
                         +
                         X.hm_causa
                       where  X.hm_tipo_tran in (240, 313, 311)),
                      -- No. CHEQUE + COD BANCO + CAUSA DEV
                      isnull((select
                                X.hm_concepto
                              where  X.hm_tipo_tran in (264)),
                             -- No. CHEQUE + COD BANCO + CAUSA DEV
                             isnull ((select
                                        X.hm_ctadestino
                                      where  X.hm_tipo_tran in (
                                             237, 239, 294, 300
                                                               ))
        ,
                                     -- CUENTA DESTINO - TRANSFERENCIAS
                                     convert(varchar(20), hm_secuencial))))),
        -- SSN    
        hm_secuencial,
        hm_tipo_tran,
        hm_estado
      /***************************************************
             from cob_ahorros_his..ah_his_movimiento X,
                  cobis..cl_ttransaccion
            where hm_cta_banco = @i_cta
              and hm_fecha >= @i_fchdsde
              and hm_fecha <= @i_fchhsta
              and hm_transaccion > @i_sec
              and hm_tipo_tran * = tn_trn_code
            order by hm_transaccion
      ****************************************************/
      from   cob_ahorros_his..ah_his_movimiento X
             left outer join cobis..cl_ttransaccion
                          on hm_tipo_tran = tn_trn_code
      where  hm_cta_banco   = @i_cta
         and hm_fecha       >= @i_fchdsde
         and hm_fecha       <= @i_fchhsta
         and hm_transaccion > @i_sec
      order  by hm_transaccion

      if @@rowcount = 15
        select
          @o_hist = 0
      else
        select
          @o_hist = 1

      return 0
    end

    /* Datos de la tabla del diario */
    select
      convert(varchar(10), tm_fecha, 103),
      tm_causa,
      tm_oficina,
      tm_correccion,
      tn_descripcion,
      tm_signo,
      (tm_valor + isnull(tm_chq_propios, $0) + isnull(tm_chq_locales, $0)
       + isnull(tm_chq_ot_plazas, $0)),
      isnull(tm_monto_imp,
             $0),
      tm_saldo_contable,
      tm_saldo_disponible,
      isnull(tm_interes,
             $0),
      convert(varchar(20), tm_secuencial),
      tm_cod_alterno,
      isnull((select
                X.tm_serial
              where  X.tm_tipo_tran in (253, 264)),-- ND Y NC CON SERIAL
             isnull((select
                       '$000' + X.tm_concepto + convert(varchar(5), X.tm_banco)
                       +
                       X.tm_causa
                     where  X.tm_tipo_tran in (240, 313, 311)),
                    -- No. CHEQUE + COD BANCO + CAUSA DEV
                    isnull((select
                              X.tm_concepto
                            where  X.tm_tipo_tran in (264)),
                           -- No. CHEQUE + COD BANCO + CAUSA DEV
                           isnull ((select
                                      X.tm_ctadestino
                                    where  X.tm_tipo_tran in (237, 239, 294, 300
                                                             ))
      ,
                                   -- CUENTA DESTINO - TRANSFERENCIAS
                                   convert(varchar(20), tm_secuencial))))),
      -- SSN
      tm_secuencial,
      tm_tipo_tran,
      tm_estado
    /***************************************************************
      from cob_ahorros..ah_tran_monet X,
           cobis..cl_ttransaccion
     where tm_cta_banco = @i_cta
       and ((tm_secuencial > @i_sec)
        or (tm_secuencial = @i_sec and tm_cod_alterno > @i_sec_alt))
       and tm_fecha >= @i_fchdsde
       and tm_fecha <= @i_fchhsta
       and tm_tipo_tran * = tn_trn_code
     order by tm_secuencial, tm_cod_alterno
     ****************************************************************/

    from   cob_ahorros..ah_tran_monet X
           left outer join cobis..cl_ttransaccion
                        on tm_tipo_tran = tn_trn_code
    where  tm_cta_banco   = @i_cta
       and ((tm_secuencial > @i_sec)
             or (tm_secuencial  = @i_sec
                 and tm_cod_alterno > @i_sec_alt))
       and tm_fecha       >= @i_fchdsde
       and tm_fecha       <= @i_fchhsta
    order  by tm_secuencial,
              tm_cod_alterno

    if @@rowcount = 15
      select
        @o_hist = 2
    else
      select
        @o_hist = 3

    set rowcount 0
    return 0

  end

  if @i_modo = '1'
  begin
    if @i_sec = 2147483647
       and @i_diario = 0
    begin
      /* Datos de la cabecera */
      select
        convert(varchar(10), ah_fecha_ult_mov, 103),
        convert(varchar(10), ah_fecha_ult_corte, 103),
        mo_descripcion,
        ah_descripcion_ec,
        convert (varchar(10), ah_fecha_prx_corte, 103),
        ah_parroquia,
        ah_zona,
        ah_saldo_ult_corte,
        fu_nombre
      from   cob_ahorros..ah_cuenta,
             cobis..cl_moneda,
             cobis..cl_funcionario,
             cobis..cc_oficial
      where  ah_cuenta      = @w_cuenta
         and mo_moneda      = ah_moneda
         and oc_oficial     = ah_oficial
         and fu_funcionario = oc_funcionario

      select
        te_valor
      from   cob_ahorros..ah_cuenta,
             cobis..cl_direccion,
             cobis..cl_telefono
      where  ah_cuenta     = @w_cuenta
         and di_ente       = ah_cliente
         and di_direccion  = ah_direccion_ec
         and te_ente       = di_ente
         and te_direccion  = di_direccion
         and te_secuencial = di_telefono

    end

    /* Datos de la tabla del diario */
    set rowcount 15
    if @i_diario = 0
    begin
      /* if @i_sec = 0 
          select @i_sec = -2147483648 */

      select
        convert(varchar(10), tm_fecha, 103),
        tm_causa,
        tm_oficina,
        tm_correccion,
        tn_descripcion,
        tm_signo,
        (tm_valor + isnull(tm_chq_propios, $0) + isnull(tm_chq_locales, $0)
         + isnull(tm_chq_ot_plazas, $0)),
        isnull(tm_monto_imp,
               $0),
        tm_saldo_contable,
        tm_saldo_disponible,
        isnull(tm_interes,
               $0),
        convert(varchar(20), tm_secuencial),
        tm_cod_alterno,
        isnull((select
                  X.tm_serial
                where  X.tm_tipo_tran in (253, 264)),-- ND Y NC CON SERIAL
               isnull((select
                         '$000' + X.tm_concepto +
                         convert(varchar(5), X.tm_banco)
                         +
                         X.tm_causa
                       where  X.tm_tipo_tran in (240, 313, 311)),
                      -- No. CHEQUE + COD BANCO + CAUSA DEV
                      isnull((select
                                X.tm_concepto
                              where  X.tm_tipo_tran in (264)),
                             -- No. CHEQUE + COD BANCO + CAUSA DEV
                             isnull ((select
                                        X.tm_ctadestino
                                      where  X.tm_tipo_tran in (
                                             237, 239, 294, 300
                                                               ))
        ,
                                     -- CUENTA DESTINO - TRANSFERENCIAS
                                     convert(varchar(20), tm_secuencial))))),
        -- SSN
        tm_secuencial,
        tm_tipo_tran,
        tm_estado
      /***         from cob_ahorros..ah_tran_monet X,
                    cobis..cl_ttransaccion
              where tm_cta_banco = @i_cta
                and ((tm_secuencial < @i_sec)
                 or (tm_secuencial = @i_sec and tm_cod_alterno < @i_sec_alt))
                and tm_fecha >= @i_fchdsde
                and tm_fecha <= @i_fchhsta
                and tm_tipo_tran * = tn_trn_code
              order by tm_secuencial DESC, tm_cod_alterno DESC   ***/
      from   cob_ahorros..ah_tran_monet X
             left outer join cobis..cl_ttransaccion
                          on tm_tipo_tran = tn_trn_code
      where  tm_cta_banco    = @i_cta
         and ((X.tm_secuencial < @i_sec)
               or (X.tm_secuencial = @i_sec
                   and tm_cod_alterno  < @i_sec_alt))
         and tm_fecha        >= @i_fchdsde
         and tm_fecha        <= @i_fchhsta
      order  by X.tm_secuencial desc,
                tm_cod_alterno desc

      if @@rowcount = 15
        select
          @o_hist = 0
      else
        select
          @o_hist = 1

      return 0
    end

    /* Datos del historico de movimientos */
    select
      convert(varchar(10), hm_fecha, 103),
      hm_causa,
      hm_oficina,
      hm_correccion,
      tn_descripcion,
      hm_signo,
      (hm_valor + isnull(hm_chq_propios, $0) + isnull(hm_chq_locales, $0)
       + isnull(hm_chq_ot_plazas, $0)),
      isnull(hm_monto_imp,
             $0),
      hm_saldo_contable,
      hm_saldo_disponible,
      isnull(hm_interes,
             $0),
      hm_transaccion,
      hm_cod_alterno,
      isnull((select
                X.hm_serial
              where  X.hm_tipo_tran in (253, 264)),-- ND Y NC CON SERIAL
             isnull((select
                       '$000' + X.hm_concepto + convert(varchar(5), X.hm_banco)
                       +
                       X.hm_causa
                     where  X.hm_tipo_tran in (240, 313, 311)),
                    -- No. CHEQUE + COD BANCO + CAUSA DEV
                    isnull((select
                              X.hm_concepto
                            where  X.hm_tipo_tran in (264)),
                           -- No. CHEQUE + COD BANCO + CAUSA DEV
                           isnull ((select
                                      X.hm_ctadestino
                                    where  X.hm_tipo_tran in (237, 239, 294, 300
                                                             ))
      ,
                                   -- CUENTA DESTINO - TRANSFERENCIAS
                                   convert(varchar(20), hm_secuencial))))),
      -- SSN
      hm_secuencial,
      hm_tipo_tran,
      hm_estado
    /**from cob_ahorros_his..ah_his_movimiento X,
         cobis..cl_ttransaccion
    where hm_cta_banco = @i_cta
     and hm_fecha >= @i_fchdsde
     and hm_fecha <= @i_fchhsta
     and hm_transaccion < @i_sec
     and hm_tipo_tran * = tn_trn_code
    order by hm_transaccion DESC ****/
    from   cob_ahorros_his..ah_his_movimiento X
           left outer join cobis..cl_ttransaccion
                        on hm_tipo_tran = tn_trn_code
    where  hm_cta_banco   = @i_cta
       and hm_fecha       >= @i_fchdsde
       and hm_fecha       <= @i_fchhsta
       and hm_transaccion < @i_sec
    order  by hm_transaccion desc

    if @@rowcount = 15
      select
        @o_hist = 2
    else
      select
        @o_hist = 3

    set rowcount 0
    return 0
  end

go

