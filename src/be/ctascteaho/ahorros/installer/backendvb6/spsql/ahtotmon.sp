use cob_ahorros
go

/************************************************************************/
/*      Archivo:                ahtotmon.sp                             */
/*      Stored procedure:       sp_totaliza_tran_mon_ah                 */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           Jaime Loyo                              */
/*      Fecha de escritura:     29-Mar-2010                             */
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
/*      PROCESO:  Cursor que permite la generacion de comprobantes para */
/*              cuentas de ahorros                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      29/Mar/2010     J. Loyo         Personalizacion Bancamia la     */
/*      02/Mayo/2016    Walther Toledo  Migración a CEN                 */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_totaliza_tran_mon_ah')
  drop proc sp_totaliza_tran_mon_ah
go

create proc sp_totaliza_tran_mon_ah
(
  @i_filial       tinyint = 1,
  @i_fecha        smalldatetime= null,
  @i_param1       datetime = null,-- Fecha de proceso
  @s_srv          varchar(16) = null,
  @t_show_version bit = 0,
  @o_procesadas   int = null out
)
as
  declare
    @w_sp_name      varchar(30),
    @w_tipo_tran    int,
    @w_causa        char(12),
    @w_concepto     char(16),
    @w_concepto_imp varchar(10),
    @w_campo1       varchar(32),--Valor
    @w_campo2       varchar(32),--Base
    @w_campo3       varchar(32),--Referencia
    @w_totaliza     char(1),
    @w_tipo_imp     varchar(1),
    @w_indicador    tinyint

  select
    @w_sp_name = 'sp_totaliza_tran_mon_ah'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  create table #cotizacion
  (
    moneda tinyint,
    valor  money
  )

  print ' Inicia Totalizacion Monetaria'
  select
    ct_moneda     as uc_moneda,
    max(ct_fecha) as uc_fecha
  into   #ult_cotiz
  from   cob_conta..cb_cotizacion
  where  ct_fecha <= @i_param1
  group  by ct_moneda

  insert into #cotizacion
    select
      ct_moneda,ct_valor
    from   cob_conta..cb_cotizacion,
           #ult_cotiz
    where  ct_moneda = uc_moneda
       and ct_fecha  = uc_fecha

  if exists (select
               1
             from   cob_remesas..re_trn_contable
             where  tc_fecha  = @i_param1
                and tc_estado = 'CON'
                and tc_tipo   = 'M')
  begin
    print
' Existen registros Contabilizados en la re_trn_contable para esa fecha'
    exec sp_errorlog
      @i_fecha       = @i_param1,
      @i_error       = 0,
      @i_usuario     = 'batch',
      @i_tran        = 4222,-- Codigo del proceso Batch
      @i_cuenta      = null,
      @i_descripcion =
      'Existen registros Contabilizados en la re_trn_contable para esa fecha',
      @i_programa    = 'sp_totaliza_tran_mon_ah'
    return 701171
  end

  if exists(select
              1
            from   cob_remesas..re_trn_contable
            where  tc_fecha = @i_param1
               and tc_tipo  = 'M') --
  begin
    print 'Se borran los registros del dia ' + cast(@i_param1 as varchar)
          + ' de transacciones Monetarias'
    delete cob_remesas..re_trn_contable
    where  tc_fecha = @i_param1
       and tc_tipo  = 'M'

    if @@error <> 0
    begin
      print 'Error al borrar los registros en re_trn_contable '
      exec sp_errorlog
        @i_fecha       = @i_param1,
        @i_error       = 0,
        @i_usuario     = 'batch',
        @i_tran        = 4222,-- Codigo del proceso Batch
        @i_cuenta      = null,
        @i_descripcion = 'Error al borrar los registros en re_trn_contable ',
        @i_programa    = 'sp_totaliza_tran_mon_ah'
      return 357502
    end
  end

  select
    *
  into   #re_trn_contable
  from   cob_remesas..re_trn_contable
  where  1 = 2

  begin tran

  /* Cursor para re_concepto_contable */
  declare ciclo_contable cursor for
    select
      cc_tipo_tran,
      isnull(cc_causa,
             '0'),
      cc_concepto,
      cc_campo1,
      cc_campo2,
      cc_campo3,
      isnull(cc_indicador,
             0),
      cc_totaliza,
      cc_tipo_imp
    from   cob_remesas..re_concepto_contable
    where  cc_producto = 4
       and cc_tipo     = 'M' -- Transacciones Monetarias
    order  by cc_tipo_tran,
              cc_causa

  /* Abrir el cursor para validar las tansacciones contables */
  open ciclo_contable

  /* Ubicar el primer registro para el cursor */
  fetch ciclo_contable into @w_tipo_tran,
                            @w_causa,
                            @w_concepto,
                            @w_campo1,
                            @w_campo2,
                            @w_campo3,
                            @w_indicador,
                            @w_totaliza,
                            @w_tipo_imp
  if @@fetch_status = -1
  begin
    print 'Error -1'
    close ciclo_contable
    deallocate ciclo_contable
    exec cobis..sp_cerror
      @i_num = 201154
    select
      @o_procesadas = 0
    return 201154
  end
  else if @@fetch_status = -2
  begin
    print 'Error -2'
    close ciclo_contable
    deallocate ciclo_contable
    select
      @o_procesadas = 0
    return 0
  end

  /* Barrer todas las cuentas para actualizacion de saldos */
  while @@fetch_status = 0
  begin
    delete #re_trn_contable

    select
      @w_concepto_imp = null

    select
      @w_concepto_imp = ci_concepto
    from   cob_remesas..re_concepto_imp
    where  ci_producto    = 4
       and ci_tran        = @w_tipo_tran
       and ci_causal      = isnull(@w_causa,
                                   '0')
       and ci_impuesto    = @w_tipo_imp
       and ci_contabiliza = @w_campo1

    print
    'Transaccion :' + cast (@w_tipo_tran as varchar) + ' Causa :'
          + cast (isnull(@w_causa, '') as varchar) + '- Concepto : ' + isnull(
    @w_concepto
    , '')
          + 'concepto_contable :' + isnull(@w_concepto_imp, '') + ' Tipo_imp:'
          + isnull(@w_tipo_imp, '')

    if @w_causa = 0
    begin
      /**** Busqueda de las transacciones sin causal ****************/

      if @w_totaliza = 'N'
      begin
        print '........1'
        /***** Adicionalmente, Que esten agrupadas por cliente ***************/
        insert into #re_trn_contable
                    (tc_producto,tc_moneda,tc_tipo_tran,tc_causa,tc_ofic_orig,
                     tc_ofic_dest,tc_perfil,tc_concepto,tc_valor,tc_valor_me,
                     tc_numtran,tc_tipo,tc_prod_banc,tc_clase_clte,tc_tipo_cta,
                     tc_cliente,tc_base,tc_tipo_impuesto,tc_referencia,tc_fecha,
                     tc_estado,tc_estcta,tc_concepto_imp)
          select
            4,isnull(tm_moneda,
                   0),tm_tipo_tran,tm_causa,tm_oficina,
            isnull(tm_oficina_cta,
                   tm_oficina),isnull((select
                      tp_perfil
                    from   cob_remesas..re_trn_perfil
                    where  tp_producto  = 4
                       and tp_tipo_tran = tm_tipo_tran),
                   'NO DEFIDO'),@w_concepto,case tm_moneda /**** Valor ****/
              when 0 then
                case @w_campo1
                  when 'tm_valor' then sum(isnull(tm_valor,
                                                  0))
                  when 'tm_chq_propios' then sum(isnull(tm_chq_propios,
                                                        0))
                  when 'tm_chq_locales' then sum(isnull(tm_chq_locales,
                                                        0))
                  when 'tm_chq_ot_plazas' then sum(isnull(tm_chq_ot_plazas,
                                                          0))
                  when 'tm_efectivo' then sum(isnull(tm_efectivo,
                                                     0))
                  when 'tm_saldo_interes' then sum(isnull(tm_saldo_interes,
                                                          0))
                  when 'tm_interes' then sum(isnull(tm_interes,
                                                    0))
                  when 'tm_monto_imp' then sum(isnull(tm_monto_imp,
                                                      0))
                  when 'tm_valor_comision' then sum(isnull(tm_valor_comision,
                                                           0))
                  when 'tm_base_gmf' then sum(isnull(tm_base_gmf,
                                                     0))
                  else 0
                end
              else 0
            end,case tm_moneda /**** Valor_ME ****/
              when 0 then 0
              else
                case @w_campo1
                  when 'tm_valor' then sum((isnull(tm_valor,
                                                   0) * valor))
                  when 'tm_chq_propios' then sum((isnull(tm_chq_propios,
                                                         0) * valor))
                  when 'tm_chq_locales' then sum((isnull(tm_chq_locales,
                                                         0) * valor))
                  when 'tm_chq_ot_plazas' then sum((isnull(tm_chq_ot_plazas,
                                                           0) * valor))
                  when 'tm_efectivo' then sum((isnull(tm_efectivo,
                                                      0) * valor))
                  when 'tm_saldo_interes' then sum((isnull(tm_saldo_interes,
                                                           0) * valor))
                  when 'tm_interes' then sum((isnull(tm_interes,
                                                     0) * valor))
                  when 'tm_monto_imp' then sum((isnull(tm_monto_imp,
                                                       0) * valor))
                  when 'tm_valor_comision' then sum((isnull(tm_valor_comision,
                                                            0) * valor))
                  when 'tm_base_gmf' then sum((isnull(tm_base_gmf,
                                                      0) * valor))
                  else 0
                end
            end,
            count(1),'M',tm_prod_banc,isnull(tm_clase_clte,
                   'X'),tm_tipocta_super,
            isnull(tm_cliente,
                   0),case @w_campo2 /**** Base ****/
              when 'tm_valor' then sum((isnull(tm_valor,
                                               0) * valor))
              when 'tm_chq_propios' then sum((isnull(tm_chq_propios,
                                                     0) * valor))
              when 'tm_chq_locales' then sum((isnull(tm_chq_locales,
                                                     0) * valor))
              when 'tm_chq_ot_plazas' then sum((isnull(tm_chq_ot_plazas,
                                                       0) * valor))
              when 'tm_efectivo' then sum((isnull(tm_efectivo,
                                                  0) * valor))
              when 'tm_saldo_interes' then sum((isnull(tm_saldo_interes,
                                                       0) * valor))
              when 'tm_interes' then sum((isnull(tm_interes,
                                                 0) * valor))
              when 'tm_monto_imp' then sum((isnull(tm_monto_imp,
                                                   0) * valor))
              when 'tm_valor_comision' then sum((isnull(tm_valor_comision,
                                                        0) * valor))
              when 'tm_base_gmf' then sum((isnull(tm_base_gmf,
                                                  0) * valor))
              else 0
            end,@w_tipo_imp,case @w_campo3 /**** Referencia ****/
              when 'tm_valor' then sum(isnull(tm_valor,
                                              0))
              when 'tm_chq_propios' then sum(isnull(tm_chq_propios,
                                                    0))
              when 'tm_chq_locales' then sum(isnull(tm_chq_locales,
                                                    0))
              when 'tm_chq_ot_plazas' then sum(isnull(tm_chq_ot_plazas,
                                                      0))
              when 'tm_efectivo' then sum(isnull(tm_efectivo,
                                                 0))
              when 'tm_saldo_interes' then sum(isnull(tm_saldo_interes,
                                                      0))
              when 'tm_interes' then sum(isnull(tm_interes,
                                                0))
              when 'tm_monto_imp' then sum(isnull(tm_monto_imp,
                                                  0))
              when 'tm_valor_comision' then sum(isnull(tm_valor_comision,
                                                       0))
              when 'tm_base_gmf' then sum(isnull(tm_base_gmf,
                                                 0))
              else 0
            end,tm_fecha,
            'ING',case
              when tm_tipo_tran = 304
                   and exists(select
                                1
                              from   cob_remesas..re_tesoro_nacional,
                                     cob_ahorros..ah_cuenta
                              where  tn_cuenta             = tm_cta_banco
                                 and tn_estado             = 'P'
                                 and tn_cuenta             = ah_cta_banco
                                 and ah_estado             = 'I'
                                 and datepart(yy,
                                              tn_fecha) < datepart(yy,
                                                                   tm_fecha))
            then
              'T'
              when tm_tipo_tran = 304
                   and exists(select
                                1
                              from   cob_remesas..re_tesoro_nacional,
                                     cob_ahorros..ah_cuenta
                              where  tn_cuenta             = tm_cta_banco
                                 and tn_estado             = 'P'
                                 and tn_cuenta             = ah_cta_banco
                                 and ah_estado             = 'I'
                                 and datepart(yy,
                                              tn_fecha) = datepart(yy,
                                                                   tm_fecha)
                                 and datepart(mm,
                                              tn_fecha) < datepart(mm,
                                                                   tm_fecha))
            then
              'T'
              else (select
                      ah_estado
                    from   cob_ahorros..ah_cuenta
                    where  ah_cta_banco = tm_cta_banco)
            end,@w_concepto_imp
          from   cob_ahorros..ah_tran_monet_tmp t,
                 #cotizacion
          where  tm_tipo_tran           = @w_tipo_tran
                 --          and    isnull(tm_causa,'')    = @w_causa
                 and isnull(tm_indicador,
                            0) = @w_indicador
                 and tm_estado is null
                 and isnull(tm_moneda,
                            0)    = moneda
          group  by tm_tipo_tran,
                    tm_causa,
                    tm_moneda,
                    tm_oficina,
                    tm_prod_banc,
                    tm_clase_clte,
                    tm_oficina_cta,
                    tm_fecha,
                    tm_tipocta_super,
                    tm_cta_banco,
                    tm_cliente
      end
      else
      begin
        print '........2'
        /******* Busqueda sin Causal y con Agrupamiento por Cliente *************************/
        insert into #re_trn_contable
                    (tc_producto,tc_moneda,tc_tipo_tran,tc_causa,tc_ofic_orig,
                     tc_ofic_dest,tc_perfil,tc_concepto,tc_valor,tc_valor_me,
                     tc_numtran,tc_tipo,tc_prod_banc,tc_clase_clte,tc_tipo_cta,
                     tc_cliente,tc_base,tc_tipo_impuesto,tc_referencia,tc_fecha,
                     tc_estado,tc_estcta,tc_concepto_imp)
          select
            4,isnull(tm_moneda,
                   0),tm_tipo_tran,tm_causa,tm_oficina,
            isnull(tm_oficina_cta,
                   tm_oficina),isnull((select
                      tp_perfil
                    from   cob_remesas..re_trn_perfil
                    where  tp_producto  = 4
                       and tp_tipo_tran = tm_tipo_tran),
                   'NO DEFIDO'),@w_concepto,case tm_moneda /**** Valor ****/
              when 0 then
                case @w_campo1
                  when 'tm_valor' then sum(isnull(tm_valor,
                                                  0))
                  when 'tm_chq_propios' then sum(isnull(tm_chq_propios,
                                                        0))
                  when 'tm_chq_locales' then sum(isnull(tm_chq_locales,
                                                        0))
                  when 'tm_chq_ot_plazas' then sum(isnull(tm_chq_ot_plazas,
                                                          0))
                  when 'tm_efectivo' then sum(isnull(tm_efectivo,
                                                     0))
                  when 'tm_saldo_interes' then sum(isnull(tm_saldo_interes,
                                                          0))
                  when 'tm_interes' then sum(isnull(tm_interes,
                                                    0))
                  when 'tm_monto_imp' then sum(isnull(tm_monto_imp,
                                                      0))
                  when 'tm_valor_comision' then sum(isnull(tm_valor_comision,
                                                           0))
                  when 'tm_base_gmf' then sum(isnull(tm_base_gmf,
                                                     0))
                  else 0
                end
              else 0
            end,case tm_moneda /**** Valor_ME ****/
              when 0 then 0
              else
                case @w_campo1
                  when 'tm_valor' then sum((isnull(tm_valor,
                                                   0) * valor))
                  when 'tm_chq_propios' then sum((isnull(tm_chq_propios,
                                                         0) * valor))
                  when 'tm_chq_locales' then sum((isnull(tm_chq_locales,
                                                         0) * valor))
                  when 'tm_chq_ot_plazas' then sum((isnull(tm_chq_ot_plazas,
                                                           0) * valor))
                  when 'tm_efectivo' then sum((isnull(tm_efectivo,
                                                      0) * valor))
                  when 'tm_saldo_interes' then sum((isnull(tm_saldo_interes,
                                                           0) * valor))
                  when 'tm_interes' then sum((isnull(tm_interes,
                                                     0) * valor))
                  when 'tm_monto_imp' then sum((isnull(tm_monto_imp,
                                                       0) * valor))
                  when 'tm_valor_comision' then sum((isnull(tm_valor_comision,
                                                            0) * valor))
                  when 'tm_base_gmf' then sum((isnull(tm_base_gmf,
                                                      0) * valor))
                  else 0
                end
            end,
            count(1),'M',tm_prod_banc,isnull(tm_clase_clte,
                   'X'),tm_tipocta_super,
            0,case @w_campo2 /**** Base ****/
              when 'tm_valor' then sum((isnull(tm_valor,
                                               0) * valor))
              when 'tm_chq_propios' then sum((isnull(tm_chq_propios,
                                                     0) * valor))
              when 'tm_chq_locales' then sum((isnull(tm_chq_locales,
                                                     0) * valor))
              when 'tm_chq_ot_plazas' then sum((isnull(tm_chq_ot_plazas,
                                                       0) * valor))
              when 'tm_efectivo' then sum((isnull(tm_efectivo,
                                                  0) * valor))
              when 'tm_saldo_interes' then sum((isnull(tm_saldo_interes,
                                                       0) * valor))
              when 'tm_interes' then sum((isnull(tm_interes,
                                                 0) * valor))
              when 'tm_monto_imp' then sum((isnull(tm_monto_imp,
                                                   0) * valor))
              when 'tm_valor_comision' then sum((isnull(tm_valor_comision,
                                                        0) * valor))
              when 'tm_base_gmf' then sum((isnull(tm_base_gmf,
                                                  0) * valor))
              else 0
            end,@w_tipo_imp,case @w_campo3 /**** Referencia ****/
              when 'tm_valor' then sum(isnull(tm_valor,
                                              0))
              when 'tm_chq_propios' then sum(isnull(tm_chq_propios,
                                                    0))
              when 'tm_chq_locales' then sum(isnull(tm_chq_locales,
                                                    0))
              when 'tm_chq_ot_plazas' then sum(isnull(tm_chq_ot_plazas,
                                                      0))
              when 'tm_efectivo' then sum(isnull(tm_efectivo,
                                                 0))
              when 'tm_saldo_interes' then sum(isnull(tm_saldo_interes,
                                                      0))
              when 'tm_interes' then sum(isnull(tm_interes,
                                                0))
              when 'tm_monto_imp' then sum(isnull(tm_monto_imp,
                                                  0))
              when 'tm_valor_comision' then sum(isnull(tm_valor_comision,
                                                       0))
              when 'tm_base_gmf' then sum(isnull(tm_base_gmf,
                                                 0))
              else 0
            end,tm_fecha,
            'ING',null,@w_concepto_imp
          from   cob_ahorros..ah_tran_monet_tmp t,
                 #cotizacion
          where  tm_tipo_tran           = @w_tipo_tran
                 -- and   isnull(tm_causa,'')     = @w_causa
                 and isnull(tm_indicador,
                            0) = @w_indicador
                 and tm_estado is null
                 and isnull(tm_moneda,
                            0)    = moneda
          group  by tm_tipo_tran,
                    tm_causa,
                    tm_moneda,
                    tm_oficina,
                    tm_prod_banc,
                    tm_clase_clte,
                    tm_oficina_cta,
                    tm_fecha,
                    tm_tipocta_super
      end
    end
    else
    begin
      if @w_totaliza = 'S'
      begin
        print '........3'
        /****** Busqueda de las transaccion con causal y agrupadas *****************/
        insert into #re_trn_contable
                    (tc_producto,tc_moneda,tc_tipo_tran,tc_causa,tc_ofic_orig,
                     tc_ofic_dest,tc_perfil,tc_concepto,tc_valor,tc_valor_me,
                     tc_numtran,tc_tipo,tc_prod_banc,tc_clase_clte,tc_tipo_cta,
                     tc_cliente,tc_base,tc_tipo_impuesto,tc_referencia,tc_fecha,
                     tc_estado,tc_estcta,tc_concepto_imp)
          select
            4,isnull(tm_moneda,
                   0),tm_tipo_tran,tm_causa,tm_oficina,
            isnull(tm_oficina_cta,
                   tm_oficina),isnull((select
                      tp_perfil
                    from   cob_remesas..re_trn_perfil
                    where  tp_producto  = 4
                       and tp_tipo_tran = tm_tipo_tran),
                   'NO DEFIDO'),@w_concepto,case tm_moneda /**** Valor ****/
              when 0 then
                case @w_campo1
                  when 'tm_valor' then sum(isnull(tm_valor,
                                                  0))
                  when 'tm_chq_propios' then sum(isnull(tm_chq_propios,
                                                        0))
                  when 'tm_chq_locales' then sum(isnull(tm_chq_locales,
                                                        0))
                  when 'tm_chq_ot_plazas' then sum(isnull(tm_chq_ot_plazas,
                                                          0))
                  when 'tm_efectivo' then sum(isnull(tm_efectivo,
                                                     0))
                  when 'tm_saldo_interes' then sum(isnull(tm_saldo_interes,
                                                          0))
                  when 'tm_interes' then sum(isnull(tm_interes,
                                                    0))
                  when 'tm_monto_imp' then sum(isnull(tm_monto_imp,
                                                      0))
                  when 'tm_valor_comision' then sum(isnull(tm_valor_comision,
                                                           0))
                  when 'tm_base_gmf' then sum(isnull(tm_base_gmf,
                                                     0))
                  else 0
                end
              else 0
            end,case tm_moneda /**** Valor_ME ****/
              when 0 then 0
              else
                case @w_campo1
                  when 'tm_valor' then sum((isnull(tm_valor,
                                                   0) * valor))
                  when 'tm_chq_propios' then sum((isnull(tm_chq_propios,
                                                         0) * valor))
                  when 'tm_chq_locales' then sum((isnull(tm_chq_locales,
                                                         0) * valor))
                  when 'tm_chq_ot_plazas' then sum((isnull(tm_chq_ot_plazas,
                                                           0) * valor))
                  when 'tm_efectivo' then sum((isnull(tm_efectivo,
                                                      0) * valor))
                  when 'tm_saldo_interes' then sum((isnull(tm_saldo_interes,
                                                           0) * valor))
                  when 'tm_interes' then sum((isnull(tm_interes,
                                                     0) * valor))
                  when 'tm_monto_imp' then sum((isnull(tm_monto_imp,
                                                       0) * valor))
                  when 'tm_valor_comision' then sum((isnull(tm_valor_comision,
                                                            0) * valor))
                  when 'tm_base_gmf' then sum((isnull(tm_base_gmf,
                                                      0) * valor))
                  else 0
                end
            end,
            count(1),'M',tm_prod_banc,isnull(tm_clase_clte,
                   'X'),tm_tipocta_super,
            0,case @w_campo2 /**** Base ****/
              when 'tm_valor' then sum((isnull(tm_valor,
                                               0) * valor))
              when 'tm_chq_propios' then sum((isnull(tm_chq_propios,
                                                     0) * valor))
              when 'tm_chq_locales' then sum((isnull(tm_chq_locales,
                                                     0) * valor))
              when 'tm_chq_ot_plazas' then sum((isnull(tm_chq_ot_plazas,
                                                       0) * valor))
              when 'tm_efectivo' then sum((isnull(tm_efectivo,
                                                  0) * valor))
              when 'tm_saldo_interes' then sum((isnull(tm_saldo_interes,
                                                       0) * valor))
              when 'tm_interes' then sum((isnull(tm_interes,
                                                 0) * valor))
              when 'tm_monto_imp' then sum((isnull(tm_monto_imp,
                                                   0) * valor))
              when 'tm_valor_comision' then sum((isnull(tm_valor_comision,
                                                        0) * valor))
              when 'tm_base_gmf' then sum((isnull(tm_base_gmf,
                                                  0) * valor))
              else 0
            end,@w_tipo_imp,case @w_campo3 /**** Referencia ****/
              when 'tm_valor' then sum(isnull(tm_valor,
                                              0))
              when 'tm_chq_propios' then sum(isnull(tm_chq_propios,
                                                    0))
              when 'tm_chq_locales' then sum(isnull(tm_chq_locales,
                                                    0))
              when 'tm_chq_ot_plazas' then sum(isnull(tm_chq_ot_plazas,
                                                      0))
              when 'tm_efectivo' then sum(isnull(tm_efectivo,
                                                 0))
              when 'tm_saldo_interes' then sum(isnull(tm_saldo_interes,
                                                      0))
              when 'tm_interes' then sum(isnull(tm_interes,
                                                0))
              when 'tm_monto_imp' then sum(isnull(tm_monto_imp,
                                                  0))
              when 'tm_valor_comision' then sum(isnull(tm_valor_comision,
                                                       0))
              when 'tm_base_gmf' then sum(isnull(tm_base_gmf,
                                                 0))
              else 0
            end,tm_fecha,
            'ING',null,@w_concepto_imp
          from   cob_ahorros..ah_tran_monet_tmp t,
                 #cotizacion
          where  tm_tipo_tran           = @w_tipo_tran
                 -- and   tm_tipo_tran        = cc_tipo_tran
                 and isnull(tm_causa,
                            '0')   = @w_causa
                 and isnull(tm_indicador,
                            0) = @w_indicador
                 and tm_estado is null
                 and isnull(tm_moneda,
                            0)    = moneda
          group  by tm_tipo_tran,
                    tm_causa,
                    tm_moneda,
                    tm_oficina,
                    tm_prod_banc,
                    tm_clase_clte,
                    tm_oficina_cta,
                    tm_fecha,
                    tm_tipocta_super
      end
      else
      /****** Busqueda de las transaccion con causal sin totalizar  *****************/
      begin
        print '........4'
        insert into #re_trn_contable
                    (tc_producto,tc_moneda,tc_tipo_tran,tc_causa,tc_ofic_orig,
                     tc_ofic_dest,tc_perfil,tc_concepto,tc_valor,tc_valor_me,
                     tc_numtran,tc_tipo,tc_prod_banc,tc_clase_clte,tc_tipo_cta,
                     tc_cliente,tc_base,tc_tipo_impuesto,tc_referencia,tc_fecha,
                     tc_estado,tc_estcta,tc_concepto_imp)
          select
            4,isnull(tm_moneda,
                   0),tm_tipo_tran,tm_causa,tm_oficina,
            isnull(tm_oficina_cta,
                   tm_oficina),isnull((select
                      tp_perfil
                    from   cob_remesas..re_trn_perfil
                    where  tp_producto  = 4
                       and tp_tipo_tran = tm_tipo_tran),
                   'NO DEFIDO'),@w_concepto,case tm_moneda /**** Valor ****/
              when 0 then
                case @w_campo1
                  when 'tm_valor' then sum(isnull(tm_valor,
                                                  0))
                  when 'tm_chq_propios' then sum(isnull(tm_chq_propios,
                                                        0))
                  when 'tm_chq_locales' then sum(isnull(tm_chq_locales,
                                                        0))
                  when 'tm_chq_ot_plazas' then sum(isnull(tm_chq_ot_plazas,
                                                          0))
                  when 'tm_efectivo' then sum(isnull(tm_efectivo,
                                                     0))
                  when 'tm_saldo_interes' then sum(isnull(tm_saldo_interes,
                                                          0))
                  when 'tm_interes' then sum(isnull(tm_interes,
                                                    0))
                  when 'tm_monto_imp' then sum(isnull(tm_monto_imp,
                                                      0))
                  when 'tm_valor_comision' then sum(isnull(tm_valor_comision,
                                                           0))
                  when 'tm_base_gmf' then sum(isnull(tm_base_gmf,
                                                     0))
                  else 0
                end
              else 0
            end,case tm_moneda /**** Valor_ME ****/
              when 0 then 0
              else
                case @w_campo1
                  when 'tm_valor' then sum((isnull(tm_valor,
                                                   0) * valor))
                  when 'tm_chq_propios' then sum((isnull(tm_chq_propios,
                                                         0) * valor))
                  when 'tm_chq_locales' then sum((isnull(tm_chq_locales,
                                                         0) * valor))
                  when 'tm_chq_ot_plazas' then sum((isnull(tm_chq_ot_plazas,
                                                           0) * valor))
                  when 'tm_efectivo' then sum((isnull(tm_efectivo,
                                                      0) * valor))
                  when 'tm_saldo_interes' then sum((isnull(tm_saldo_interes,
                                                           0) * valor))
                  when 'tm_interes' then sum((isnull(tm_interes,
                                                     0) * valor))
                  when 'tm_monto_imp' then sum((isnull(tm_monto_imp,
                                                       0) * valor))
                  when 'tm_valor_comision' then sum((isnull(tm_valor_comision,
                                                            0) * valor))
                  when 'tm_base_gmf' then sum((isnull(tm_base_gmf,
                                                      0) * valor))
                  else 0
                end
            end,
            count(1),'M',tm_prod_banc,isnull(tm_clase_clte,
                   'X'),tm_tipocta_super,
            isnull(tm_cliente,
                   0),case @w_campo2 /**** Base ****/
              when 'tm_valor' then sum((isnull(tm_valor,
                                               0) * valor))
              when 'tm_chq_propios' then sum((isnull(tm_chq_propios,
                                                     0) * valor))
              when 'tm_chq_locales' then sum((isnull(tm_chq_locales,
                                                     0) * valor))
              when 'tm_chq_ot_plazas' then sum((isnull(tm_chq_ot_plazas,
                                                       0) * valor))
              when 'tm_efectivo' then sum((isnull(tm_efectivo,
                                                  0) * valor))
              when 'tm_saldo_interes' then sum((isnull(tm_saldo_interes,
                                                       0) * valor))
              when 'tm_interes' then sum((isnull(tm_interes,
                                                 0) * valor))
              when 'tm_monto_imp' then sum((isnull(tm_monto_imp,
                                                   0) * valor))
              when 'tm_valor_comision' then sum((isnull(tm_valor_comision,
                                                        0) * valor))
              when 'tm_base_gmf' then sum((isnull(tm_base_gmf,
                                                  0) * valor))
              else 0
            end,@w_tipo_imp,case @w_campo3 /**** Referencia ****/
              when 'tm_valor' then sum(isnull(tm_valor,
                                              0))
              when 'tm_chq_propios' then sum(isnull(tm_chq_propios,
                                                    0))
              when 'tm_chq_locales' then sum(isnull(tm_chq_locales,
                                                    0))
              when 'tm_chq_ot_plazas' then sum(isnull(tm_chq_ot_plazas,
                                                      0))
              when 'tm_efectivo' then sum(isnull(tm_efectivo,
                                                 0))
              when 'tm_saldo_interes' then sum(isnull(tm_saldo_interes,
                                                      0))
              when 'tm_interes' then sum(isnull(tm_interes,
                                                0))
              when 'tm_monto_imp' then sum(isnull(tm_monto_imp,
                                                  0))
              when 'tm_valor_comision' then sum(isnull(tm_valor_comision,
                                                       0))
              when 'tm_base_gmf' then sum(isnull(tm_base_gmf,
                                                 0))
              else 0
            end,tm_fecha,
            'ING',case
              when tm_tipo_tran = 304
                   and exists(select
                                1
                              from   cob_remesas..re_tesoro_nacional,
                                     cob_ahorros..ah_cuenta
                              where  tn_cuenta             = tm_cta_banco
                                 and tn_estado             = 'P'
                                 and tn_cuenta             = ah_cta_banco
                                 and ah_estado             = 'I'
                                 and datepart(yy,
                                              tn_fecha) < datepart(yy,
                                                                   tm_fecha))
            then
              'T'
              when tm_tipo_tran = 304
                   and exists(select
                                1
                              from   cob_remesas..re_tesoro_nacional,
                                     cob_ahorros..ah_cuenta
                              where  tn_cuenta             = tm_cta_banco
                                 and tn_estado             = 'P'
                                 and tn_cuenta             = ah_cta_banco
                                 and ah_estado             = 'I'
                                 and datepart(yy,
                                              tn_fecha) = datepart(yy,
                                                                   tm_fecha)
                                 and datepart(mm,
                                              tn_fecha) < datepart(mm,
                                                                   tm_fecha))
            then
              'T'
              else (select
                      ah_estado
                    from   cob_ahorros..ah_cuenta
                    where  ah_cta_banco = tm_cta_banco)
            end,@w_concepto_imp
          from   cob_ahorros..ah_tran_monet_tmp t,
                 #cotizacion
          where  tm_tipo_tran           = @w_tipo_tran
                 -- and   tm_tipo_tran           = cc_tipo_tran
                 and isnull(tm_causa,
                            '0')   = @w_causa
                 and isnull(tm_indicador,
                            0) = @w_indicador
                 and tm_estado is null
                 and isnull(tm_moneda,
                            0)    = moneda
          group  by tm_tipo_tran,
                    tm_causa,
                    tm_moneda,
                    tm_oficina,
                    tm_prod_banc,
                    tm_clase_clte,
                    tm_oficina_cta,
                    tm_fecha,
                    tm_tipocta_super,
                    tm_cta_banco,
                    tm_cliente
      end
    end

    insert into cob_remesas..re_trn_contable
                (tc_producto,tc_moneda,tc_tipo_tran,tc_causa,tc_ofic_orig,
                 tc_ofic_dest,tc_perfil,tc_concepto,tc_valor,tc_valor_me,
                 tc_numtran,tc_tipo,tc_prod_banc,tc_clase_clte,tc_tipo_cta,
                 tc_cliente,tc_base,tc_tipo_impuesto,tc_referencia,tc_fecha,
                 tc_estado,tc_estcta,tc_concepto_imp)
      select
        tc_producto,tc_moneda,tc_tipo_tran,tc_causa,tc_ofic_orig,
        tc_ofic_dest,tc_perfil,tc_concepto,tc_valor,tc_valor_me,
        tc_numtran,tc_tipo,tc_prod_banc,tc_clase_clte,tc_tipo_cta,
        tc_cliente,tc_base,tc_tipo_impuesto,tc_referencia,tc_fecha,
        tc_estado,tc_estcta,tc_concepto_imp
      from   #re_trn_contable
      where  tc_valor    > 0
          or tc_valor_me > 0
    print ' Insercion de Registro: ' + cast (@@rowcount as varchar)
    LEER:
    /* Localizar el siguiente registro de cuenta sobregirada ocasionalmente */
    fetch ciclo_contable into @w_tipo_tran,
                              @w_causa,
                              @w_concepto,
                              @w_campo1,
                              @w_campo2,
                              @w_campo3,
                              @w_indicador,
                              @w_totaliza,
                              @w_tipo_imp

    /* Validar el Status del Cursor */
    if @@fetch_status = -2
    begin
      print 'ERROR EN LECTURA DE TRANSACCIONES 1'
      rollback tran
      close ciclo_contable
      deallocate ciclo_contable
      return 251062
    end
    if @@fetch_status = -1
    begin
      close ciclo_contable
      deallocate ciclo_contable
      commit tran
      return 0
    end
  end
  print ' Termina la Totalizacion Monetaria'
  commit tran

  /* Cerrar y liberar cursor */
  close ciclo_contable
  deallocate ciclo_contable
  return 0

go

