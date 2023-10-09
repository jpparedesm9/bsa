/************************************************************************/
/*  Archivo:            ah_consulta_estado_cuenta.sp                    */
/*  Stored procedure:   sp_ah_consulta_estado_cuenta                    */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 10-Dic-1993                                     */
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
/*  Este programa procesa la transaccion de:                            */
/*      Consulta de estado de cuenta por fechas                         */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/*  FECHA           AUTOR       RAZON                                   */
/*  10/Dic/1993     J. Navarrete    Emision inicial                     */
/*  20/Dic/1994     J. Bucheli      Personalizacion para Banco de       */
/*                                  la Produccion                       */
/*  08/Nov/1995     A. Villarreal   Correccion de errores               */
/*  26/Oct/2001     C. Vargas       Agregar param. @i_formato_fecha     */
/*  02/Mar/2005     L. Bernuil      Consultar Terminal                  */
/*  06/MaY/2006     P. COELLO       MODIFICAR ORDENAMIENTO              */
/*  18/Dic/2006     R. Ramos        Adicionar estado de la cuenta       */
/*  31/ENE/2007     P. Coello       Agregar operacion para consulta     */
/*                                  especifica de movimiento            */
/*  02/Mayo/2016    Ignacio Yupa    Migración a CEN                     */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_consulta_estado_cuenta')
  drop proc sp_ah_consulta_estado_cuenta
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_consulta_estado_cuenta
(
  @s_ssn           int,
  @s_srv           varchar(30),
  @s_user          varchar(30),
  @s_sesn          int,
  @s_term          varchar(10),
  @s_date          datetime,
  @s_ofi           smallint,/* Localidad origen transaccion */
  @s_rol           smallint,
  @s_sev           tinyint = null,
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
  @t_show_version  bit = 0,
  @i_cta           cuenta,
  @i_fchdsde       varchar(10),
  @i_fchhsta       varchar(10),
  @i_sec           int,
  @i_sec_alt       int,
  @i_mon           tinyint,
  @i_diario        tinyint,
  @i_inforcuenta   char(1),
  @i_frontn        char(1) = 'N',
  @i_formato_fecha int = null,
  @i_operacion     char(1) = 'C',
  --PCOELLO SE AÃ‘ADE LA OPERAION POR QUE SE VA A CONSULTAR EN ESTE MISMO SP EL DETALLE DE UN MOVIMIENTO ESPECIFICO
  @o_hist          tinyint out,
  @i_hora          smalldatetime = null,
  --PCOELLO MAYO 2006 MODIFICAR ORDENAMIENTO
  @i_escliente     char(1)= 'N'
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
    @w_disponible       money,
    @w_cheque           int,
    @w_sec              int,
    @w_ssn              int,
    @w_sec_alt          int,
    @w_ssn_alt          int,
    @w_contador         tinyint,
    @w_lineas           tinyint,
    @w_corr             char(1),
    @w_funcionario      char(1),
    @w_prod_banc        int,
    @w_cliente          int,
    @w_alianza          int,
    @w_desalianza       varchar(255)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ah_consulta_estado_cuenta'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

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
      i_frontn = @i_frontn,
      o_hist = @o_hist,
      i_escliente = @i_escliente
    exec cobis..sp_end_debug
  end

  /******PCOELLO CUANDO ES OPERACION M SOLO CONSULTA EL DETALLE DEL MOVIMIENTO Y LO MANDA AL FRONT END *****/
  if @i_operacion = 'M'
  begin
    if convert(varchar(10), @s_date, 101) = @i_fchdsde --SI ES DE HOY
    begin
      select
        isnull(tm_valor,
               0),
        isnull(tm_chq_propios,
               0),
        isnull(tm_chq_locales,
               0),
        isnull(tm_chq_ot_plazas,
               0)
      from   cob_ahorros..ah_tran_monet
      where  tm_cta_banco   = @i_cta
         and tm_fecha       = @s_date
         and tm_secuencial  = @i_sec
         and tm_cod_alterno = @i_sec_alt

      if @@rowcount = 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 901183
        return 1
      end
    end
    else --SI ES HISTORICO
    begin
      select
        isnull(hm_valor,
               0),
        isnull(hm_chq_propios,
               0),
        isnull(hm_chq_locales,
               0),
        isnull(hm_chq_ot_plazas,
               0)
      from   cob_ahorros_his..ah_his_movimiento
      where  hm_cta_banco   = @i_cta
         and hm_fecha       = @i_fchdsde
         and hm_secuencial  = @i_sec
         and hm_cod_alterno = @i_sec_alt

      if @@rowcount = 0
      begin
        exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 901183
        return 1
      end
    end

    return 0
  end

/******PCOELLO CUANDO ES OPERACION M SOLO CONSULTA EL DETALLE DEL MOVIMIENTO Y LO MANDA AL FRONT END *****/
  /*  Determinacion de la cuenta interna */
  select
    @w_cuenta = ah_cuenta,
    @w_cliente = ah_cliente,
    @w_funcionario = ah_cta_funcionario,
    @w_disponible = ah_disponible,
    @w_prod_banc = ah_prod_banc
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
    @o_saldo_para_girar = @w_saldo_para_girar out,
    @o_saldo_contable   = @w_saldo_contable out
  if @w_return <> 0
    return @w_return

  if @i_sec = 0
  begin
    /* Datos de la cabecera */
    select
      convert(varchar(12), ah_fecha_ult_mov, @i_formato_fecha),
      convert(varchar(12), ah_fecha_ult_corte, @i_formato_fecha),
      mo_descripcion,
      ah_descripcion_ec,
      convert (varchar(12), ah_fecha_prx_corte, @i_formato_fecha),
      ah_parroquia,
      ah_zona,
      ah_saldo_ult_corte,
      fu_nombre,
      ah_estado,
      desc_estado=(select
                     valor
                   from   cobis..cl_catalogo
                   where  tabla  = (select
                                      codigo
                                    from   cobis..cl_tabla
                                    where  tabla = 'ah_estado_cta')
                      and codigo = a.ah_estado)
    from   cob_ahorros..ah_cuenta a,
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

    select
      @w_alianza = al_alianza,
      @w_desalianza = isnull((al_nemonico + ' - ' + al_nom_alianza),
                             '  ')
    from   cobis..cl_alianza_cliente with (nolock),
           cobis..cl_alianza with (nolock)
    where  ac_ente    = @w_cliente
       and ac_alianza = al_alianza
       and al_estado  = 'V'
       and ac_estado  = 'V'

    select
      @w_alianza

    select
      @w_desalianza

    insert into cob_ahorros..ah_tran_servicio
                (ts_secuencial,ts_tipo_transaccion,ts_tsfecha,ts_usuario,
                 ts_terminal,
                 ts_oficina,ts_reentry,ts_origen,ts_cta_banco,ts_moneda,
                 ts_oficina_cta,ts_hora,ts_saldo,ts_interes,ts_valor,
                 ts_prod_banc,ts_rol_ente)
    values      ( @s_ssn,@t_trn,@s_date,@s_user,@s_term,
                  @s_ofi,@t_rty,@s_org,@i_cta,@i_mon,
                  @w_oficina,getdate(),@w_disponible,@w_saldo_contable,
                  @w_saldo_para_girar,
                  @w_prod_banc,@i_escliente)

    if @@error <> 0
    begin
      /* error en la insercion de la transaccion de servicio */
      exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 203005
      return 203005
    end
  end

  /* Datos del historico de movimientos */
  set rowcount 15

  if @i_diario = 0
  begin
    if @i_sec = 0
      select
        @i_sec = -2147483648
    select
      convert(varchar(10), hm_fecha, @i_formato_fecha),
      hm_causa,
      hm_oficina,
      hm_correccion,
      tn_descripcion + (case hm_tipo_tran
                          when 253 then ' POR: '
                                        + (select
                                             a.valor
                                           from   cobis..cl_catalogo a,
                                                  cobis..cl_tabla b
                                           where  a.tabla  = b.codigo
                                              and a.codigo = X.hm_causa
                                              and b.tabla  = 'ah_causa_nc')
                          when 255 then ' POR: '
                                        + (select
                                             a.valor
                                           from   cobis..cl_catalogo a,
                                                  cobis..cl_tabla b
                                           where  a.tabla  = b.codigo
                                              and a.codigo = X.hm_causa
                                              and b.tabla  = 'ah_causa_nc')
                          when 262 then ' POR: '
                                        + (select
                                             a.valor
                                           from   cobis..cl_catalogo a,
                                                  cobis..cl_tabla b
                                           where  a.tabla  = b.codigo
                                              and a.codigo = X.hm_causa
                                              and b.tabla  = 'ah_causa_nd')
                          when 264 then ' POR: '
                                        + (select
                                             a.valor
                                           from   cobis..cl_catalogo a,
                                                  cobis..cl_tabla b
                                           where  a.tabla  = b.codigo
                                              and a.codigo = X.hm_causa
                                              and b.tabla  = 'ah_causa_nd')
                          else ' '
                        end) + ' ' + hm_concepto,
      hm_signo,
      (hm_valor + isnull(hm_chq_propios, $0) + isnull(hm_chq_locales, $0)
       + isnull(hm_chq_ot_plazas, $0)),
      -- + isnull(hm_monto_imp,$0) + isnull(hm_valor_comision,$0)),
      hm_terminal,
      hm_saldo_contable,
      hm_saldo_disponible,
      isnull(hm_interes,
             $0),
      hm_ssn_branch,
      hm_cod_alterno,
      hm_serial,
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
                           isnull((select
                                     X.hm_ctadestino
                                   where  X.hm_tipo_tran in (237, 239, 294, 300)
                                  ),
                                  -- CUENTA DESTINO - TRANSFERENCIAS
                                  convert(varchar(20), hm_secuencial))))),-- SSN
      hm_usuario,
      hm_hora,
      hm_causa,
      hm_secuencial,
      --convert(int,hm_transaccion) --PCOELLO MODIFICA LA VARIABLE EL ORDER BY ESTA POR OTRO CAMPO
      isnull(hm_valor_comision,
             0),
      isnull(hm_monto_imp,
             0)
    /******from  cob_ahorros_his..ah_his_movimiento X,
                  cobis..cl_ttransaccion
            where hm_cta_banco     = @i_cta
            and   hm_fecha        >= @i_fchdsde
            and   hm_fecha        <= @i_fchhsta
            and   ((hm_hora = @i_hora and hm_secuencial = @i_sec and hm_cod_alterno > @i_sec_alt) or
                   (hm_hora = @i_hora and hm_secuencial > @i_sec) or
                   (hm_hora > @i_hora))
            and   hm_tipo_tran     * = tn_trn_code
            order by hm_hora, hm_secuencial, hm_cod_alterno
     ********/
    from   cob_ahorros_his..ah_his_movimiento X
           left outer join cobis..cl_ttransaccion
                        on hm_tipo_tran = tn_trn_code
    where  hm_cta_banco    = @i_cta
       and hm_fecha        >= @i_fchdsde
       and hm_fecha        <= @i_fchhsta
       and ((hm_hora         = @i_hora
             and X.hm_secuencial = @i_sec
             and hm_cod_alterno  > @i_sec_alt)
             or (hm_hora         = @i_hora
                 and X.hm_secuencial > @i_sec)
             or (hm_hora > @i_hora))
    order  by hm_hora,
              X.hm_secuencial,
              hm_cod_alterno

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
    convert(varchar(12), tm_fecha, @i_formato_fecha),
    tm_causa,
    tm_oficina,
    tm_correccion,
    tn_descripcion + (case tm_tipo_tran
                        when 253 then ' POR: '
                                      + (select
                                           a.valor
                                         from   cobis..cl_catalogo a,
                                                cobis..cl_tabla b
                                         where  a.tabla  = b.codigo
                                            and a.codigo = X.tm_causa
                                            and b.tabla  = 'ah_causa_nc')
                        when 255 then ' POR: '
                                      + (select
                                           a.valor
                                         from   cobis..cl_catalogo a,
                                                cobis..cl_tabla b
                                         where  a.tabla  = b.codigo
                                            and a.codigo = X.tm_causa
                                            and b.tabla  = 'ah_causa_nc')
                        when 262 then ' POR: '
                                      + (select
                                           a.valor
                                         from   cobis..cl_catalogo a,
                                                cobis..cl_tabla b
                                         where  a.tabla  = b.codigo
                                            and a.codigo = X.tm_causa
                                            and b.tabla  = 'ah_causa_nd')
                        when 264 then ' POR: '
                                      + (select
                                           a.valor
                                         from   cobis..cl_catalogo a,
                                                cobis..cl_tabla b
                                         where  a.tabla  = b.codigo
                                            and a.codigo = X.tm_causa
                                            and b.tabla  = 'ah_causa_nd')
                        else ' '
                      end) + ' ' + tm_concepto,
    tm_signo,
    (tm_valor + isnull(tm_chq_propios, $0) + isnull(tm_chq_locales, $0)
     + isnull(tm_chq_ot_plazas, $0)),
    -- + isnull(tm_monto_imp,$0) + isnull(tm_valor_comision,$0)),
    tm_terminal,
    tm_saldo_contable,
    tm_saldo_disponible,
    isnull(tm_interes,
           $0),
    tm_ssn_branch,
    tm_cod_alterno,
    tm_serial,
    isnull((select
              X.tm_serial
            where  X.tm_tipo_tran in (253, 264)),-- ND Y NC CON SERIAL
           isnull((select
                     '$000' + X.tm_concepto + convert(varchar(5), X.tm_banco) +
                     X.tm_causa
                   where  X.tm_tipo_tran in (240, 313, 311)),
                  -- No. CHEQUE + COD BANCO + CAUSA DEV
                  isnull((select
                            X.tm_concepto
                          where  X.tm_tipo_tran in (264)),
                         -- No. CHEQUE + COD BANCO + CAUSA DEV
                         isnull ((select
                                    X.tm_ctadestino
                                  where  X.tm_tipo_tran in (237, 239, 294, 300))
    ,
                                 -- CUENTA DESTINO - TRANSFERENCIAS
                                 convert(varchar(20), tm_secuencial))))),-- SSN
    tm_usuario,
    tm_hora,
    tm_causa,
    tm_secuencial,
    isnull(tm_valor_comision,
           0),
    isnull(tm_monto_imp,
           0)
  /******************************   
     from  cob_ahorros..ah_tran_monet X,
           cobis..cl_ttransaccion
     where tm_cta_banco  = @i_cta
     and ((tm_hora = @i_hora and tm_secuencial = @i_sec and tm_cod_alterno > @i_sec_alt) or
          (tm_hora = @i_hora and tm_secuencial > @i_sec) or
          (tm_hora > @i_hora))
     and   tm_fecha     >= @i_fchdsde
     and   tm_fecha     <= @i_fchhsta
     and   tm_tipo_tran * = tn_trn_code
     order by tm_hora, tm_secuencial, tm_cod_alterno
  ********************************/
  from   cob_ahorros..ah_tran_monet X
         left outer join cobis..cl_ttransaccion
                      on tm_tipo_tran = tn_trn_code
  where  tm_cta_banco    = @i_cta
     and ((tm_hora         = @i_hora
           and X.tm_secuencial = @i_sec
           and tm_cod_alterno  > @i_sec_alt)
           or (tm_hora         = @i_hora
               and X.tm_secuencial > @i_sec)
           or (tm_hora > @i_hora))
     and tm_fecha        >= @i_fchdsde
     and tm_fecha        <= @i_fchhsta
  order  by tm_hora,
            X.tm_secuencial,
            tm_cod_alterno

  if @@rowcount = 15
    select
      @o_hist = 2
  else
    select
      @o_hist = 3

  set rowcount 0

  return 0

go

