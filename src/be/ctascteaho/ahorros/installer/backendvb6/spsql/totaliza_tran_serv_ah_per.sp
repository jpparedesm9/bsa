use cob_ahorros
go
/************************************************************************/
/*  Archivo:            totaliza_tran_serv_ah_per.sp                    */
/*  Stored procedure:   sp_totaliza_tran_serv_ah_per                    */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/*  Disenado por:       N/N                                             */
/*  Fecha de escritura: N/D                                             */
/************************************************************************/
/*                          IMPORTANTE                                  */
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
/*                               PROPOSITO                              */
/*  Totalizacion de transaccion de servicios de ahorros personales      */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*   FECHA           AUTOR           RAZON                              */
/*  02/Mayo/2016    Walther Toledo  Migración a CEN                     */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_totaliza_tran_serv_ah_per')
  drop proc sp_totaliza_tran_serv_ah_per
go

create proc sp_totaliza_tran_serv_ah_per
(
  @t_show_version bit = 0,
  @i_param1       datetime = null -- Fecha de proceso
)
as
  set ansi_warnings off

  declare
    @w_sp_name      varchar(32),
    @w_return       int,
    @w_descripcion  varchar(60),
    @w_fecha_ini    datetime,
    @w_fecha_fin    datetime,
    @w_tipo_tran    int,
    @w_causa        char(12),
    @w_concepto     char(16),
    @w_concepto_imp varchar(10),
    @w_campo1       varchar(32),--Valor
    @w_campo2       varchar(32),--Base
    @w_campo3       varchar(32),--Referencia
    @w_totaliza     char(1),
    @w_tipo_imp     varchar(1),
    @w_indicador    tinyint,
    @w_matriz       int,
    @w_DiaNumero    tinyint,
    @w_DiaEjecucion tinyint,
    @w_finmes       char(1),
    @w_ffinmes      datetime,
    @w_fsiguiente   datetime,
    @w_perfilCau    char(10)

  select
    @w_sp_name = 'sp_totaliza_tran_serv_ah_per'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  --Validacion fechas del proceso
  select
    @w_fecha_fin = @i_param1
  select
    @w_fsiguiente = dateadd(day,
                            1,
                            @w_fecha_fin)
  select
    @w_DiaNumero = datediff(day,
                            0,
                            @w_fecha_fin)%7 + 1
  --Dia de la semana (5-> Viernes, 6->Sabado)

  --Determinacion de fin de mes
  select
    @w_matriz = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
     and pa_nemonico = 'CMA'

  if @@rowcount <> 1
  begin
    select
      @w_return = 201196,
      @w_descripcion = 'Error en lectura de parametro de ciudad matriz'
    goto FIN
  end

  select
    @w_DiaEjecucion = pa_tinyint
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'DCP'

  if @@rowcount <> 1
  begin
    select
      @w_return = 201196,
      @w_descripcion =
      'Error en lectura de parametro de dia ejecucion conta semanal'
    goto FIN
  end

  select
    @w_perfilCau = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'PCAU'

  if @@rowcount <> 1
  begin
    select
      @w_return = 201196,
      @w_descripcion = 'Error en lectura de parametro de perfil de causacion'
    goto FIN
  end

  --Dias feriados del mes en curso
  select
    *
  into   #feriados
  from   cobis..cl_dias_feriados
  where  df_ciudad             = @w_matriz
     and datepart(mm,
                  df_fecha) = datepart(mm,
                                       @w_fecha_fin)
     and datepart(yy,
                  df_fecha) = datepart(yy,
                                       @w_fecha_fin)

  select
    @w_ffinmes = max(dl_fecha)
  from   cob_ahorros..ah_dias_laborables
  where  dl_ciudad             = @w_matriz
     and datepart(mm,
                  dl_fecha) = datepart(mm,
                                       @w_fecha_fin)
     and dl_fecha not in (select
                            df_fecha
                          from   #feriados)

  if @w_ffinmes is null
  begin
    select
      @w_return = 201196,
      @w_descripcion = 'No pudo determinarse fecha de fin de mes'
    goto ERRORFIN
  end

  if @w_ffinmes = @w_fecha_fin
    select
      @w_finmes = 'S'
  else
    select
      @w_finmes = 'N'

  if @w_finmes = 'N'
  begin
    while 1 = 1
      if exists(select
                  1
                from   #feriados
                where  df_fecha = @w_fsiguiente)
      begin
        if datediff(day,
                    0,
                    @w_fsiguiente)%7 + 1 = @w_DiaEjecucion
          select
            @w_finmes = 'S'

        select
          @w_fsiguiente = dateadd(day,
                                  1,
                                  @w_fsiguiente)
      end
      else
        break
  end

  --Si no es sabado ni fin de mes
  if @w_finmes = 'N'
     and @w_DiaNumero <> @w_DiaEjecucion
    goto FIN --Solo ejecuta en fin de mes o dia definido de la semana

  select
    c.*
  into   #trx_periodica
  from   cob_remesas..re_concepto_contable c,
         cob_remesas..re_trn_perfil
  where  cc_tipo_tran = tp_tipo_tran
     and cc_producto  = 4
     and cc_tipo      = 'S' --Transacciones de servicio
     and tp_perfil    = @w_perfilCau

  --Determina fecha inicial a contabilizar a  partir de la maxima contabilizada
  select
    @w_fecha_ini = dateadd(dd,
                           1,
                           max(tc_fecha))
  from   cob_remesas..re_trn_contable,
         #trx_periodica
  where  tc_tipo      = 'S'
     and tc_tipo_tran = cc_tipo_tran
     and tc_estado    = 'CON'

  if @w_fecha_ini > @w_fecha_fin
  begin
    select
      @w_return = 201196,
      @w_descripcion = 'Periodo solicitado procesado parcial o totalmente'
    goto ERRORFIN
  end

  create table #cotizacion
  (
    moneda tinyint,
    valor  money
  )

  print ' Inicia Totalizacion Servicio - Periodica'

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
             from   cob_remesas..re_trn_contable,
                    #trx_periodica
             where  tc_fecha between @w_fecha_ini and @w_fecha_fin
                and tc_estado    = 'CON'
                and tc_tipo      = 'S'
                and tc_tipo_tran = cc_tipo_tran)
  begin
    select
      @w_return = 701171,
      @w_descripcion =
'Existen registros de causacion contabilizados en la re_trn_contable para este periodo'
  goto ERRORFIN
end

  if exists(select
              1
            from   cob_remesas..re_trn_contable,
                   #trx_periodica
            where  tc_fecha between @w_fecha_ini and @w_fecha_fin
               and tc_tipo      = 'S'
               and tc_tipo_tran = cc_tipo_tran)
  begin
    print 'Se borran los registros del periodo ' + cast(@w_fecha_ini as varchar)
          +
          ' '
          + cast(@w_fecha_fin as varchar) + ' de transacciones de Servicio'
    delete cob_remesas..re_trn_contable
    from   #trx_periodica
    where  tc_fecha between @w_fecha_ini and @w_fecha_fin
       and tc_tipo      = 'S'
       and tc_tipo_tran = cc_tipo_tran

    if @@error <> 0
    begin
      select
        @w_return = 357502,
        @w_descripcion = 'Error al borrar los registros en re_trn_contable'
      goto ERRORFIN
    end
  end

  select
    ts_cta_banco = hs_cta_banco,
    ts_moneda = isnull(hs_moneda,
                       0),
    ts_tipo_transaccion = hs_tipo_transaccion,
    ts_causa = hs_causa,
    ts_indicador = isnull(hs_indicador,
                          0),
    ts_oficina = hs_oficina,
    ts_oficina_cta = isnull(hs_oficina_cta,
                            hs_oficina),
    ts_valor = isnull(hs_valor,
                      0),
    ts_saldo = isnull(hs_saldo,
                      0),
    ts_interes = isnull(hs_interes,
                        0),
    ts_monto = isnull(hs_monto,
                      0),
    ts_prod_banc = hs_prod_banc,
    ts_clase_clte = isnull(hs_clase_clte,
                           'X'),
    ts_tipocta_super = hs_tipocta_super,
    ts_cliente = isnull(hs_cliente,
                        0),
    ts_tsfecha = hs_tsfecha,
    ts_estado = hs_estado
  into   #ah_tran_servicio_per
  from   cob_ahorros_his..ah_his_servicio with(nolock),
         #trx_periodica
  where  hs_tsfecha between @w_fecha_ini and @w_fecha_fin
     and hs_tipo_transaccion = cc_tipo_tran

  if @@rowcount = 0
  begin
    print 'No existen registros para procesar en este periodo '
          + cast(@w_fecha_ini as varchar) + '-' + cast(@w_fecha_fin as varchar)
    goto FIN
  end

  /* CREA ESTRUCTURA DE TRABAJO */

  select
    *
  into   #re_trn_contable
  from   cob_remesas..re_trn_contable
  where  1 = 2

  /* CARGA LOS CODIGOS DE LAS TRANSACCIONES QUE CONTABILIZAN */
  select distinct
    cc_tipo_tran
  into   #trn_serv
  from   cob_remesas..re_concepto_contable
  where  cc_tipo = 'S'
     and cc_causa is null

  print 'Periodo a totalizar ' + convert(varchar(10), @w_fecha_ini, 101) + ' - '
        + convert(varchar(10), @w_fecha_fin, 101)

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
    from   #trx_periodica
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
    close ciclo_contable
    deallocate ciclo_contable

    select
      @w_return = 201157,
      @w_descripcion = 'Error -1 CURSOR ciclo_contable NO PUDO SER ABIERTO'
    goto ERRORFIN
  end
  else if @@fetch_status = -2
  begin
    print 'Error -2'
    close ciclo_contable
    deallocate ciclo_contable
    goto FIN
  end

  /* Barrer todas las cuentas para actualizacion de saldos */
  while @@fetch_status = 0
  begin
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
    print 'Concepto_contable : ' + cast (isnull(@w_concepto_imp, '') as varchar)
          +
                  ' Tipo_imp :'
          + cast (isnull(@w_tipo_imp, '') as varchar)
    delete #re_trn_contable

    if @w_causa = '0'
        or @w_causa is null
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
            4,isnull(ts_moneda,
                   0),ts_tipo_transaccion,ts_causa,ts_oficina,
            isnull(ts_oficina_cta,
                   ts_oficina),isnull((select
                      tp_perfil
                    from   cob_remesas..re_trn_perfil
                    where  tp_producto  = 4
                       and tp_tipo_tran = @w_tipo_tran),
                   'NO DEFIN'),@w_concepto,case ts_moneda /**** Valor ****/
              when 0 then
                case @w_campo1
                  when 'ts_valor' then sum(isnull(ts_valor,
                                                  0))
                  when 'ts_saldo' then sum(isnull(ts_saldo,
                                                  0))
                  when 'ts_interes' then sum(isnull(ts_interes,
                                                    0))
                  when 'ts_monto' then sum(isnull(ts_monto,
                                                  0))
                  else 0
                end
              else 0
            end,case ts_moneda /**** Valor_ME ****/
              when 0 then 0
              else
                case @w_campo1
                  when 'ts_valor' then sum(isnull(ts_valor,
                                                  0) * valor)
                  when 'ts_saldo' then sum(isnull(ts_saldo,
                                                  0) * valor)
                  when 'ts_interes' then sum(isnull(ts_interes,
                                                    0) * valor)
                  when 'ts_monto' then sum(isnull(ts_monto,
                                                  0) * valor)
                  else 0
                end
            end,
            count(1),'S',ts_prod_banc,isnull(ts_clase_clte,
                   'X'),ts_tipocta_super,
            isnull(ts_cliente,
                   0),case @w_campo2 /**** Base ****/
              when 'ts_valor' then sum(isnull(ts_valor,
                                              0) * valor)
              when 'ts_saldo' then sum(isnull(ts_saldo,
                                              0) * valor)
              when 'ts_interes' then sum(isnull(ts_interes,
                                                0) * valor)
              when 'ts_monto' then sum(isnull(ts_monto,
                                              0) * valor)
              else 0
            end,@w_tipo_imp,case @w_campo3 /**** Referencia ****/
              when 'ts_valor' then sum(isnull(ts_valor,
                                              0) * valor)
              when 'ts_saldo' then sum(isnull(ts_saldo,
                                              0) * valor)
              when 'ts_interes' then sum(isnull(ts_interes,
                                                0) * valor)
              when 'ts_monto' then sum(isnull(ts_monto,
                                              0) * valor)
              else 0
            end,@w_fecha_fin,
            'ING',case
              when ts_tipo_transaccion = 271
                   and exists(select
                                1
                              from   cob_remesas..re_tesoro_nacional,
                                     cob_ahorros..ah_cuenta
                              where  tn_cuenta = ts_cta_banco
                                 and tn_estado = 'P'
                                 and tn_cuenta = ah_cta_banco
                                 and ah_estado = 'I') then 'T'
              when ts_tipo_transaccion = 367
                   and exists (select
                                 1
                               from   cob_remesas..re_tesoro_nacional,
                                      cob_ahorros..ah_cuenta
                               where  tn_cuenta = ts_cta_banco
                                  and tn_estado = 'P'
                                  and tn_cuenta = ah_cta_banco
                                  and ah_estado = 'I') then 'T'
              when exists(select
                            1
                          from   #trn_serv
                          where  cc_tipo_tran = ts_tipo_transaccion) then
              isnull (ts_causa,
              (select
                                  ah_estado
                                from   cob_ahorros..ah_cuenta
                                where  ah_cta_banco = ts_cta_banco))
              else (select
                      ah_estado
                    from   cob_ahorros..ah_cuenta
                    where  ah_cta_banco = ts_cta_banco)
            end,@w_concepto_imp
          from   #ah_tran_servicio_per t,
                 #cotizacion
          where  ts_tipo_transaccion    = @w_tipo_tran
             and isnull(ts_indicador,
                        0) = @w_indicador
             and ts_estado is null
             and isnull(ts_moneda,
                        0)    = moneda
          group  by ts_tipo_transaccion,
                    ts_causa,
                    ts_moneda,
                    ts_oficina,
                    ts_prod_banc,
                    ts_clase_clte,
                    ts_oficina_cta,
                    ts_tipocta_super,
                    ts_estado,
                    ts_cta_banco,
                    ts_cliente
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
            4,isnull(ts_moneda,
                   0),ts_tipo_transaccion,ts_causa,ts_oficina,
            isnull(ts_oficina_cta,
                   ts_oficina),isnull((select
                      tp_perfil
                    from   cob_remesas..re_trn_perfil
                    where  tp_producto  = 4
                       and tp_tipo_tran = @w_tipo_tran),
                   'NO DEFIN'),@w_concepto,case ts_moneda /**** Valor ****/
              when 0 then
                case @w_campo1
                  when 'ts_valor' then sum(isnull(ts_valor,
                                                  0))
                  when 'ts_saldo' then sum(isnull(ts_saldo,
                                                  0))
                  when 'ts_interes' then sum(isnull(ts_interes,
                                                    0))
                  when 'ts_monto' then sum(isnull(ts_monto,
                                                  0))
                  else 0
                end
              else 0
            end,case ts_moneda /**** Valor_ME ****/
              when 0 then 0
              else
                case @w_campo1
                  when 'ts_valor' then sum(isnull(ts_valor,
                                                  0) * valor)
                  when 'ts_saldo' then sum(isnull(ts_saldo,
                                                  0) * valor)
                  when 'ts_interes' then sum(isnull(ts_interes,
                                                    0) * valor)
                  when 'ts_monto' then sum(isnull(ts_monto,
                                                  0) * valor)
                  else 0
                end
            end,
            count(1),'S',ts_prod_banc,isnull(ts_clase_clte,
                   'X'),isnull(ts_tipocta_super,
                   0),
            0,case @w_campo2 /**** Base ****/
              when 'ts_valor' then sum(isnull(ts_valor,
                                              0) * valor)
              when 'ts_saldo' then sum(isnull(ts_saldo,
                                              0) * valor)
              when 'ts_interes' then sum(isnull(ts_interes,
                                                0) * valor)
              when 'ts_monto' then sum(isnull(ts_monto,
                                              0) * valor)
              else 0
            end,@w_tipo_imp,case @w_campo3 /**** Referencia ****/
              when 'ts_valor' then sum(isnull(ts_valor,
                                              0))
              when 'ts_saldo' then sum(isnull(ts_saldo,
                                              0))
              when 'ts_interes' then sum(isnull(ts_interes,
                                                0))
              when 'ts_monto' then sum(isnull(ts_monto,
                                              0))
              else 0
            end,@w_fecha_fin,
            'ING',null,@w_concepto_imp
          from   #ah_tran_servicio_per t,
                 #cotizacion
          where  ts_tipo_transaccion = @w_tipo_tran
             and ts_estado is null
             and isnull(ts_moneda,
                        0) = moneda
          group  by ts_tipo_transaccion,
                    ts_causa,
                    ts_moneda,
                    ts_oficina,
                    ts_prod_banc,
                    ts_clase_clte,
                    ts_oficina_cta,
                    ts_tipocta_super
        if @@rowcount = 0
          print '...............0 ' + cast (@w_indicador as varchar)
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
            4,isnull(ts_moneda,
                   0),ts_tipo_transaccion,ts_causa,ts_oficina,
            isnull(ts_oficina_cta,
                   ts_oficina),isnull((select
                      tp_perfil
                    from   cob_remesas..re_trn_perfil
                    where  tp_producto  = 4
                       and tp_tipo_tran = @w_tipo_tran),
                   'NO DEFIN'),@w_concepto,case ts_moneda /**** Valor ****/
              when 0 then
                case @w_campo1
                  when 'ts_valor' then sum(isnull(ts_valor,
                                                  0))
                  when 'ts_saldo' then sum(isnull(ts_saldo,
                                                  0))
                  when 'ts_interes' then sum(isnull(ts_interes,
                                                    0))
                  when 'ts_monto' then sum(isnull(ts_monto,
                                                  0))
                  else 0
                end
              else 0
            end,case ts_moneda /**** Valor_ME ****/
              when 0 then 0
              else
                case @w_campo1
                  when 'ts_valor' then sum(isnull(ts_valor,
                                                  0) * valor)
                  when 'ts_saldo' then sum(isnull(ts_saldo,
                                                  0) * valor)
                  when 'ts_interes' then sum(isnull(ts_interes,
                                                    0) * valor)
                  when 'ts_monto' then sum(isnull(ts_monto,
                                                  0) * valor)
                  else 0
                end
            end,
            count(1),'S',ts_prod_banc,isnull(ts_clase_clte,
                   'X'),ts_tipocta_super,
            0,case @w_campo2 /**** Base ****/
              when 'ts_valor' then sum(isnull(ts_valor,
                                              0) * valor)
              when 'ts_saldo' then sum(isnull(ts_saldo,
                                              0) * valor)
              when 'ts_interes' then sum(isnull(ts_interes,
                                                0) * valor)
              when 'ts_monto' then sum(isnull(ts_monto,
                                              0) * valor)
              else 0
            end,@w_tipo_imp,case @w_campo3 /**** Referencia ****/
              when 'ts_valor' then sum(isnull(ts_valor,
                                              0))
              when 'ts_saldo' then sum(isnull(ts_saldo,
                                              0))
              when 'ts_interes' then sum(isnull(ts_interes,
                                                0))
              when 'ts_monto' then sum(isnull(ts_monto,
                                              0))
              else 0
            end,@w_fecha_fin,
            'ING',null,@w_concepto_imp
          from   #ah_tran_servicio_per t,
                 #cotizacion
          where  ts_tipo_transaccion    = @w_tipo_tran
             and isnull(ts_causa,
                        '0')   = @w_causa
             and isnull(ts_indicador,
                        0) = @w_indicador
             and ts_estado is null
             and isnull(ts_moneda,
                        0)    = moneda
          group  by ts_tipo_transaccion,
                    ts_causa,
                    ts_moneda,
                    ts_oficina,
                    ts_prod_banc,
                    ts_clase_clte,
                    ts_oficina_cta,
                    ts_tipocta_super
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
            4,isnull(ts_moneda,
                   0),ts_tipo_transaccion,ts_causa,ts_oficina,
            isnull(ts_oficina_cta,
                   ts_oficina),isnull((select
                      tp_perfil
                    from   cob_remesas..re_trn_perfil
                    where  tp_producto  = 4
                       and tp_tipo_tran = @w_tipo_tran),
                   'NO DEFIN'),@w_concepto,case ts_moneda /**** Valor ****/
              when 0 then
                case @w_campo1
                  when 'ts_valor' then sum(isnull(ts_valor,
                                                  0))
                  when 'ts_saldo' then sum(isnull(ts_saldo,
                                                  0))
                  when 'ts_interes' then sum(isnull(ts_interes,
                                                    0))
                  when 'ts_monto' then sum(isnull(ts_monto,
                                                  0))
                  else 0
                end
              else 0
            end,case ts_moneda /**** Valor_ME ****/
              when 0 then 0
              else
                case @w_campo1
                  when 'ts_valor' then sum(isnull(ts_valor,
                                                  0) * valor)
                  when 'ts_saldo' then sum(isnull(ts_saldo,
                                                  0) * valor)
                  when 'ts_interes' then sum(isnull(ts_interes,
                                                    0) * valor)
                  when 'ts_monto' then sum(isnull(ts_monto,
                                                  0) * valor)
                  else 0
                end
            end,
            count(1),'S',ts_prod_banc,isnull(ts_clase_clte,
                   'X'),ts_tipocta_super,
            isnull(ts_cliente,
                   0),case @w_campo2 /**** Base ****/
              when 'ts_valor' then sum(isnull(ts_valor,
                                              0) * valor)
              when 'ts_saldo' then sum(isnull(ts_saldo,
                                              0) * valor)
              when 'ts_interes' then sum(isnull(ts_interes,
                                                0) * valor)
              when 'ts_monto' then sum(isnull(ts_monto,
                                              0) * valor)
              else 0
            end,@w_tipo_imp,case @w_campo3 /**** Referencia ****/
              when 'ts_valor' then sum(isnull(ts_valor,
                                              0))
              when 'ts_saldo' then sum(isnull(ts_saldo,
                                              0))
              when 'ts_interes' then sum(isnull(ts_interes,
                                                0))
              when 'ts_monto' then sum(isnull(ts_monto,
                                              0))
              else 0
            end,@w_fecha_fin,
            'ING',case
              when ts_tipo_transaccion = 271
                   and exists(select
                                1
                              from   cob_remesas..re_tesoro_nacional,
                                     cob_ahorros..ah_cuenta
                              where  tn_cuenta = ts_cta_banco
                                 and tn_estado = 'P'
                                 and tn_cuenta = ah_cta_banco
                                 and ah_estado = 'I') then 'T'
              when ts_tipo_transaccion = 367
                   and exists (select
                                 1
                               from   cob_remesas..re_tesoro_nacional,
                                      cob_ahorros..ah_cuenta
                               where  tn_cuenta = ts_cta_banco
                                  and tn_estado = 'P'
                                  and tn_cuenta = ah_cta_banco
                                  and ah_estado = 'I') then 'T'
              when exists(select
                            1
                          from   #trn_serv
                          where  cc_tipo_tran = ts_tipo_transaccion) then
              isnull (ts_causa,
              (select
                                  ah_estado
                                from   cob_ahorros..ah_cuenta
                                where  ah_cta_banco = ts_cta_banco))
              else (select
                      ah_estado
                    from   cob_ahorros..ah_cuenta
                    where  ah_cta_banco = ts_cta_banco)
            end,@w_concepto_imp
          from   #ah_tran_servicio_per t,
                 #cotizacion
          where  ts_tipo_transaccion    = @w_tipo_tran
             and isnull(ts_causa,
                        '0')   = @w_causa
             and isnull(ts_indicador,
                        0) = @w_indicador
             and ts_estado is null
             and isnull(ts_moneda,
                        0)    = moneda
          group  by ts_tipo_transaccion,
                    ts_causa,
                    ts_moneda,
                    ts_oficina,
                    ts_prod_banc,
                    ts_clase_clte,
                    ts_oficina_cta,
                    ts_tipocta_super,
                    ts_estado,
                    ts_cta_banco,
                    ts_cliente
      end
    end
    update #re_trn_contable
    set    tc_estcta = tc_causa
    where  tc_tipo_tran in (203, 367, 374, 375, 376)

    if @@rowcount > 0
      print ' Se modificaron los estados de ' + cast (@@rowcount as varchar) +
            ' registros '

    print ' insert --->'
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
      where  tc_valor    <> 0
          or tc_valor_me <> 0

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
      close ciclo_contable
      deallocate ciclo_contable

      select
        @w_return = 201157,
        @w_descripcion = 'ERROR EN LECTURA DE TRANSACCIONES 1'
      goto ERRORFIN
    end
    if @@fetch_status = -1
    begin
      close ciclo_contable
      deallocate ciclo_contable
      commit tran
      goto FIN
    end
  end

  print ' Termina la Totalizacion de Servicios'
  commit tran

  /* Cerrar y liberar cursor */
  close ciclo_contable
  deallocate ciclo_contable

  goto FIN

  ERRORFIN:

  while @@trancount > 0
    rollback tran

  exec sp_errorlog
    @i_fecha       = @i_param1,
    @i_error       = @w_return,
    @i_usuario     = 'batch',
    @i_tran        = 4234,-- Codigo del proceso Batch
    @i_cuenta      = null,
    @i_descripcion = @w_descripcion,
    @i_programa    = @w_sp_name
  return @w_return

  FIN:
  return 0

go

