/************************************************************************/
/*   Archivo:              sp_copficticia.sp                            */
/*   Stored procedure:     sp_copia_ficticia                            */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Credito y Cartera                            */
/*   Disenado por:         D. Cumbal                                    */
/*   Fecha de escritura:   Julio. 2022                                  */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                PROPOSITO                             */
/*   Guarda historicos para reversas                                    */
/*                               MODIFICACIONES                         */
/*   FECHA        AUTOR          RAZON                                  */
/*   27/Jul/2022  D. Cumbal    Sacar copia operacion para proyeccion    */
/*   25/Ene/2023  ACH          ERR#200870 Lote 12 Cartera - Operaciones */
/*                             a futuro. Se agrega print                */
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_copia_ficticia')
   drop proc sp_copia_ficticia
go

create proc sp_copia_ficticia
   @i_operacion             char(1),
   @i_operacionca           int,
   @o_operacion_ficticia    int out
as
declare 
   @w_operacion_ficticia int,
   @w_banco_ficticia cuenta

if @i_operacion = 'I'    
begin
 
   select @w_operacion_ficticia = -1000 --por default
   
   while exists(select 1 from ca_operacion_proy where op_ficticia = @w_operacion_ficticia)
   begin
        select @w_operacion_ficticia = @w_operacion_ficticia - 1
   end
   
   insert into ca_operacion_proy (
          op_operacion_real, op_ficticia)
   values(@i_operacionca   , @w_operacion_ficticia)
   
   select @w_banco_ficticia = convert(varchar(12),@w_operacion_ficticia)
   select @o_operacion_ficticia = @w_operacion_ficticia
   
   insert into ca_operacion(
      op_operacion              , op_banco              , op_anterior         , op_migrada           , op_tramite          , 
      op_cliente                , op_nombre             , op_sector           , op_toperacion        , op_oficina          , 
      op_moneda                 , op_comentario         , op_oficial          , op_fecha_ini         , op_fecha_fin        , 
      op_fecha_ult_proceso      , op_fecha_liq          , op_fecha_reajuste   , op_monto             , op_monto_aprobado   , 
      op_destino                , op_lin_credito        , op_ciudad           , op_estado            , op_periodo_reajuste , 
      op_reajuste_especial      , op_tipo               , op_forma_pago       , op_cuenta            , op_dias_anio        , 
      op_tipo_amortizacion      , op_cuota_completa     , op_tipo_cobro       , op_tipo_reduccion    , op_aceptar_anticipos, 
      op_precancelacion         , op_tipo_aplicacion    , op_tplazo           , op_plazo             , op_tdividendo       , 
      op_periodo_cap            , op_periodo_int        , op_dist_gracia      , op_gracia_cap        , op_gracia_int       , 
      op_dia_fijo               , op_cuota              , op_evitar_feriados  , op_num_renovacion    , op_renovacion       , 
      op_mes_gracia             , op_reajustable        , op_dias_clausula    , op_divcap_original   , op_clausula_aplicada, 
      op_traslado_ingresos      , op_periodo_crecimiento, op_tasa_crecimiento , op_direccion         , op_opcion_cap       , 
      op_tasa_cap               , op_dividendo_cap      , op_clase            , op_origen_fondos     , op_calificacion     , 
      op_estado_cobranza        , op_numero_reest       , op_edad             , op_tipo_crecimiento  , op_base_calculo     , 
      op_prd_cobis              , op_ref_exterior       , op_sujeta_nego      , op_dia_habil         , op_recalcular_plazo , 
      op_usar_tequivalente      , op_fondos_propios     , op_nro_red          , op_tipo_redondeo     , op_sal_pro_pon      , 
      op_tipo_empresa           , op_validacion         , op_fecha_pri_cuot   , op_gar_admisible     , op_causacion        , 
      op_convierte_tasa         , op_grupo_fact         , op_tramite_ficticio , op_tipo_linea        , op_subtipo_linea    , 
      op_bvirtual               , op_extracto           , op_num_deuda_ext    , op_fecha_embarque    , op_fecha_dex        , 
      op_reestructuracion       , op_tipo_cambio        , op_naturaleza       , op_pago_caja         , op_nace_vencida     , 
      op_num_comex              , op_calcula_devolucion , op_codigo_externo   , op_margen_redescuento, op_entidad_convenio , 
      op_pproductor             , op_fecha_ult_causacion, op_mora_retroactiva , op_calificacion_ant  , op_cap_susxcor      , 
      op_prepago_desde_lavigente, op_fecha_ult_mov      , op_fecha_prox_segven, op_suspendio         , op_fecha_suspenso   , 
      op_honorarios_cobranza    , op_banca              , op_promocion        , op_acepta_ren        , op_no_acepta        , 
      op_emprendimiento         , op_valor_cat          , op_desplazamiento)
   select 
      @w_operacion_ficticia     , @w_banco_ficticia     , op_anterior         , op_migrada           , op_tramite          , 
      op_cliente                , op_nombre             , op_sector           , op_toperacion        , op_oficina          , 
      op_moneda                 , op_comentario         , op_oficial          , op_fecha_ini         , op_fecha_fin        , 
      op_fecha_ult_proceso      , op_fecha_liq          , op_fecha_reajuste   , op_monto             , op_monto_aprobado   , 
      op_destino                , op_lin_credito        , op_ciudad           , op_estado            , op_periodo_reajuste , 
      op_reajuste_especial      , op_tipo               , op_forma_pago       , op_cuenta            , op_dias_anio        , 
      op_tipo_amortizacion      , op_cuota_completa     , op_tipo_cobro       , op_tipo_reduccion    , op_aceptar_anticipos, 
      op_precancelacion         , op_tipo_aplicacion    , op_tplazo           , op_plazo             , op_tdividendo       , 
      op_periodo_cap            , op_periodo_int        , op_dist_gracia      , op_gracia_cap        , op_gracia_int       , 
      op_dia_fijo               , op_cuota              , op_evitar_feriados  , op_num_renovacion    , op_renovacion       , 
      op_mes_gracia             , op_reajustable        , op_dias_clausula    , op_divcap_original   , op_clausula_aplicada, 
      op_traslado_ingresos      , op_periodo_crecimiento, op_tasa_crecimiento , op_direccion         , op_opcion_cap       , 
      op_tasa_cap               , op_dividendo_cap      , op_clase            , op_origen_fondos     , op_calificacion     , 
      op_estado_cobranza        , op_numero_reest       , op_edad             , op_tipo_crecimiento  , op_base_calculo     , 
      op_prd_cobis              , op_ref_exterior       , op_sujeta_nego      , op_dia_habil         , op_recalcular_plazo , 
      op_usar_tequivalente      , op_fondos_propios     , op_nro_red          , op_tipo_redondeo     , op_sal_pro_pon      , 
      op_tipo_empresa           , op_validacion         , op_fecha_pri_cuot   , op_gar_admisible     , op_causacion        , 
      op_convierte_tasa         , op_grupo_fact         , op_tramite_ficticio , op_tipo_linea        , op_subtipo_linea    , 
      op_bvirtual               , op_extracto           , op_num_deuda_ext    , op_fecha_embarque    , op_fecha_dex        , 
      op_reestructuracion       , op_tipo_cambio        , op_naturaleza       , op_pago_caja         , op_nace_vencida     , 
      op_num_comex              , op_calcula_devolucion , op_codigo_externo   , op_margen_redescuento, op_entidad_convenio , 
      op_pproductor             , op_fecha_ult_causacion, op_mora_retroactiva , op_calificacion_ant  , op_cap_susxcor      , 
      op_prepago_desde_lavigente, op_fecha_ult_mov      , op_fecha_prox_segven, op_suspendio         , op_fecha_suspenso   , 
      op_honorarios_cobranza    , op_banca              , op_promocion        , op_acepta_ren        , op_no_acepta        , 
      op_emprendimiento         , op_valor_cat          , op_desplazamiento
   from   ca_operacion 
   where  op_operacion = @i_operacionca
   
   
   if @@error <> 0
      return 710261
   
   insert into ca_rubro_op (
      ro_operacion           , ro_concepto         , ro_tipo_rubro          , ro_fpago, 
      ro_prioridad           , ro_paga_mora        , ro_provisiona          , ro_signo, 
      ro_factor              , ro_referencial      , ro_signo_reajuste      , ro_factor_reajuste, 
      ro_referencial_reajuste, ro_valor            , ro_porcentaje          , ro_porcentaje_aux, 
      ro_gracia              , ro_concepto_asociado, ro_redescuento         , ro_intermediacion, 
      ro_principal           , ro_porcentaje_efa   , ro_garantia            , ro_tipo_puntos, 
      ro_saldo_op            , ro_saldo_por_desem  , ro_base_calculo        , ro_num_dec, 
      ro_limite              , ro_iva_siempre      , ro_monto_aprobado      , ro_porcentaje_cobrar, 
      ro_tipo_garantia       , ro_nro_garantia     , ro_porcentaje_cobertura, ro_valor_garantia, 
      ro_tperiodo            , ro_periodo          , ro_tabla               , ro_saldo_insoluto, 
      ro_calcular_devolucion)
   select 
      @w_operacion_ficticia  , ro_concepto         , ro_tipo_rubro          , ro_fpago, 
      ro_prioridad           , ro_paga_mora        , ro_provisiona          , ro_signo, 
      ro_factor              , ro_referencial      , ro_signo_reajuste      , ro_factor_reajuste, 
      ro_referencial_reajuste, ro_valor            , ro_porcentaje          , ro_porcentaje_aux, 
      ro_gracia              , ro_concepto_asociado, ro_redescuento         , ro_intermediacion, 
      ro_principal           , ro_porcentaje_efa   , ro_garantia            , ro_tipo_puntos, 
      ro_saldo_op            , ro_saldo_por_desem  , ro_base_calculo        , ro_num_dec, 
      ro_limite              , ro_iva_siempre      , ro_monto_aprobado      , ro_porcentaje_cobrar, 
      ro_tipo_garantia       , ro_nro_garantia     , ro_porcentaje_cobertura, ro_valor_garantia, 
      ro_tperiodo            , ro_periodo          , ro_tabla               , ro_saldo_insoluto, 
      ro_calcular_devolucion
   from   ca_rubro_op 
   where  ro_operacion  = @i_operacionca
   
   if @@error <> 0
      return 710272
   
   insert into ca_dividendo(
      di_operacion         , di_dividendo , di_fecha_ini, di_fecha_ven  , 
      di_de_capital        , di_de_interes, di_gracia   , di_gracia_disp, 
      di_estado            , di_dias_cuota, di_intento  , di_prorroga   , 
      di_fecha_can         )
   select   
      @w_operacion_ficticia, di_dividendo , di_fecha_ini, di_fecha_ven  , 
      di_de_capital        , di_de_interes, di_gracia   , di_gracia_disp, 
      di_estado            , di_dias_cuota, di_intento  , di_prorroga   , 
      di_fecha_can
   from   ca_dividendo
   where  di_operacion   = @i_operacionca
   
   if @@error <> 0
      return 710263
   
   insert ca_amortizacion (
      am_operacion         , am_dividendo, am_concepto, am_estado, 
      am_periodo           , am_cuota    , am_gracia  , am_pagado, 
      am_acumulado         , am_secuencia)
   select 
      @w_operacion_ficticia, am_dividendo, am_concepto, am_estado, 
      am_periodo           , am_cuota    , am_gracia  , am_pagado, 
      am_acumulado         , am_secuencia
   from   ca_amortizacion 
   where  am_operacion  = @i_operacionca
   
          
   if @@error <> 0
      return 710264
   
   insert ca_cuota_adicional (
      ca_operacion         , ca_dividendo, ca_cuota)
   select 
      @w_operacion_ficticia, ca_dividendo, ca_cuota
   from   ca_cuota_adicional
   where  ca_operacion  = @i_operacionca
   
   if @@error <> 0
      return 710265
   
   insert ca_valores(
      va_operacion         , va_dividendo, va_rubro, va_valor)
   select
      @w_operacion_ficticia, va_dividendo, va_rubro, va_valor
   from   ca_valores
   where  va_operacion  = @i_operacionca
   
   if @@error <> 0
      return 710267
   
   insert ca_amortizacion_ant(
      an_secuencial  , an_operacion         , an_dividendo       , an_estado, 
      an_dias_pagados, an_valor_pagado      , an_dias_amortizados, an_valor_amortizado, 
      an_fecha_pago  , an_tasa_dia          , an_secuencia)
   select
      an_secuencial  , @w_operacion_ficticia, an_dividendo       , an_estado, 
      an_dias_pagados, an_valor_pagado      , an_dias_amortizados, an_valor_amortizado, 
      an_fecha_pago  , an_tasa_dia          , an_secuencia
   from   ca_amortizacion_ant
   where  an_operacion  = @i_operacionca
   
   if @@error <> 0
      return 710259
   
   insert into ca_diferidos (
      dif_operacion        , dif_valor_total, dif_valor_pagado, dif_concepto)
   select 
      @w_operacion_ficticia, dif_valor_total, dif_valor_pagado, dif_concepto
   from   ca_diferidos
   where  dif_operacion  = @i_operacionca
   
   if @@error <> 0
      return 710580
   
   insert ca_facturas (
      fac_operacion      , fac_nro_factura, fac_nro_dividendo, fac_fecha_vencimiento, 
      fac_valor_negociado, fac_pagado     , fac_intant       , fac_intant_amo       , 
      fac_estado_factura , fac_dias_factura)
   select
      @w_operacion_ficticia, fac_nro_factura, fac_nro_dividendo, fac_fecha_vencimiento, 
      fac_valor_negociado  , fac_pagado     , fac_intant       , fac_intant_amo       , 
      fac_estado_factura   , fac_dias_factura
   from   ca_facturas
   where  fac_operacion  = @i_operacionca
   
   if @@error <> 0
      return 708154   
    
   insert ca_traslado_interes (
      ti_operacion         , ti_cuota_orig, ti_cuota_dest, ti_usuario, 
      ti_fecha_ingreso     , ti_terminal  , ti_estado    , ti_monto)
   select                   
      @w_operacion_ficticia, ti_cuota_orig, ti_cuota_dest, ti_usuario, 
      ti_fecha_ingreso     , ti_terminal  , ti_estado    , ti_monto
   from   ca_traslado_interes
   where  ti_operacion  = @i_operacionca
   
   if @@error <> 0
      return 711006
      
   insert ca_comision_diferida(
      cd_operacion         ,    cd_concepto,   cd_cuota, cd_acumulado, cd_estado, cd_cod_valor)
   select
      @w_operacion_ficticia,    cd_concepto,   cd_cuota, cd_acumulado, cd_estado, cd_cod_valor
   from   ca_comision_diferida
   where  cd_operacion  = @i_operacionca
   
   if @@error <> 0   return 724588 
   --Fin de apropiación   
      
      
   -- ca_seguros
   insert ca_seguros (
      se_sec_seguro        , se_tipo_seguro   , se_sec_renovacion, se_tramite, 
      se_operacion         , se_fec_devolucion, se_mto_devolucion, se_estado)
   select 
      se_sec_seguro        , se_tipo_seguro   , se_sec_renovacion, se_tramite, 
      @w_operacion_ficticia, se_fec_devolucion, se_mto_devolucion, se_estado
   from   ca_seguros (nolock)
   where  se_operacion  = @i_operacionca
   
   if @@error <> 0
      return 708231
      
   -- ca_seguros_det
   insert ca_seguros_det (
      sed_operacion        , sed_sec_seguro, sed_tipo_seguro, sed_sec_renovacion, 
      sed_tipo_asegurado   , sed_estado    , sed_dividendo  , sed_cuota_cap     , 
      sed_pago_cap         , sed_cuota_int , sed_pago_int   , sed_cuota_mora    , 
      sed_pago_mora        , sed_sec_asegurado)
   select                    
      @w_operacion_ficticia, sed_sec_seguro, sed_tipo_seguro, sed_sec_renovacion, 
      sed_tipo_asegurado   , sed_estado    , sed_dividendo  , sed_cuota_cap     , 
      sed_pago_cap         , sed_cuota_int , sed_pago_int   , sed_cuota_mora    , 
      sed_pago_mora        , sed_sec_asegurado
   from   ca_seguros_det 
   where  sed_operacion  = @i_operacionca
   
   if @@error <> 0
      return 708232      
   
   
   insert ca_seguros_can (
      sec_sec_seguro       , sec_tipo_seguro, sec_sec_renovacion, sec_tramite, 
      sec_operacion        , sec_fec_can    , sec_sec_pag)
   select                    
      sec_sec_seguro       , sec_tipo_seguro, sec_sec_renovacion, sec_tramite, 
      @w_operacion_ficticia, sec_fec_can    , sec_sec_pag
   from   ca_seguros_can
   where  sec_operacion  = @i_operacionca
   
   if @@error <> 0 
   begin
      print 'historia.sp: NO FUE POSIBLE GUARDAR HISTORICOS DE SEGUROS CANCELADOS'   
      return 708232      
   end
   
   insert into ca_operacion_ext (
      oe_operacion         , oe_columna    , oe_char        , oe_tinyint , 
      oe_smallint          , oe_int        , oe_money       , oe_datetime, 
      oe_estado            , oe_tinyInteger, oe_smallInteger, oe_integer , 
      oe_float)
   select
      @w_operacion_ficticia, oe_columna    , oe_char        , oe_tinyint , 
      oe_smallint          , oe_int        , oe_money       , oe_datetime, 
      oe_estado            , oe_tinyInteger, oe_smallInteger, oe_integer , 
      oe_float
   from   ca_operacion_ext
   where  oe_operacion  = @i_operacionca
   
   if @@error <> 0 
   begin
      print 'historia.sp: NO FUE POSIBLE GUARDAR HISTORICOS DE DIAS MORA'   
      return 724596
   end
   
   insert into ca_secuenciales (se_operacion, se_secuencial)
   select @w_operacion_ficticia, se_secuencial
   from ca_secuenciales
   where se_operacion = @i_operacionca
   
   
   insert into ca_transaccion (
      tr_secuencial        , tr_fecha_mov       , tr_toperacion    , tr_moneda, 
      tr_operacion         , tr_tran            , tr_en_linea      , tr_banco , 
      tr_dias_calc         , tr_ofi_oper        , tr_ofi_usu       , tr_usuario, 
      tr_terminal          , tr_fecha_ref       , tr_secuencial_ref, tr_estado, 
      tr_observacion       , tr_gerente         , tr_comprobante   , tr_fecha_cont, 
      tr_gar_admisible     , tr_reestructuracion, tr_calificacion  , tr_fecha_real)
   select 
      tr_secuencial        , tr_fecha_mov       , tr_toperacion    , tr_moneda, 
      @w_operacion_ficticia, tr_tran            , tr_en_linea      , tr_banco , 
      tr_dias_calc         , tr_ofi_oper        , tr_ofi_usu       , tr_usuario, 
      tr_terminal          , tr_fecha_ref       , tr_secuencial_ref, tr_estado, 
      tr_observacion       , tr_gerente         , tr_comprobante   , tr_fecha_cont, 
      tr_gar_admisible     , tr_reestructuracion, tr_calificacion  , tr_fecha_real
   from ca_transaccion
   where  tr_operacion  = @i_operacionca
   
   if @@error <> 0
      return 710261
   
   insert into ca_det_trn (
      dtr_secuencial, dtr_operacion        , dtr_dividendo   , dtr_concepto, 
      dtr_estado    , dtr_periodo          , dtr_codvalor    , dtr_monto   , 
      dtr_monto_mn  , dtr_moneda           , dtr_cotizacion  , dtr_tcotizacion, 
      dtr_afectacion, dtr_cuenta           , dtr_beneficiario, dtr_monto_cont)
   select 
      dtr_secuencial, @w_operacion_ficticia, dtr_dividendo   , dtr_concepto, 
      dtr_estado    , dtr_periodo          , dtr_codvalor    , dtr_monto   , 
      dtr_monto_mn  , dtr_moneda           , dtr_cotizacion  , dtr_tcotizacion, 
      dtr_afectacion, dtr_cuenta           , dtr_beneficiario, dtr_monto_cont
   from ca_det_trn
   where  dtr_operacion  = @i_operacionca
   
   if @@error <> 0
      return 710261
   
   insert into ca_desembolso (
      dm_secuencial       , dm_operacion      , dm_desembolso     , dm_producto, 
      dm_cuenta           , dm_beneficiario   , dm_oficina_chg    , dm_usuario , 
      dm_oficina          , dm_terminal       , dm_dividendo      , dm_moneda  , 
      dm_monto_mds        , dm_monto_mop      , dm_monto_mn       , dm_cotizacion_mds, 
      dm_cotizacion_mop   , dm_tcotizacion_mds, dm_tcotizacion_mop, dm_estado, 
      dm_cod_banco        , dm_cheque         , dm_fecha          , dm_prenotificacion, 
      dm_carga            , dm_concepto       , dm_valor          , dm_ente_benef, 
      dm_idlote           , dm_pagado         , dm_orden_caja     , dm_cruce_restrictivo, 
      dm_destino_economico, dm_carta_autorizacion)
   select 
      dm_secuencial       , @w_operacion_ficticia, dm_desembolso     , dm_producto, 
      dm_cuenta           , dm_beneficiario      , dm_oficina_chg    , dm_usuario , 
      dm_oficina          , dm_terminal          , dm_dividendo      , dm_moneda  , 
      dm_monto_mds        , dm_monto_mop         , dm_monto_mn       , dm_cotizacion_mds, 
      dm_cotizacion_mop   , dm_tcotizacion_mds   , dm_tcotizacion_mop, dm_estado, 
      dm_cod_banco        , dm_cheque            , dm_fecha          , dm_prenotificacion, 
      dm_carga            , dm_concepto          , dm_valor          , dm_ente_benef, 
      dm_idlote           , dm_pagado            , dm_orden_caja     , dm_cruce_restrictivo, 
      dm_destino_economico, dm_carta_autorizacion
   from ca_desembolso
   where  dm_operacion  = @i_operacionca
   
   if @@error <> 0
      return 710261
   
   insert into ca_abono (
      ab_secuencial_ing, ab_secuencial_rpa    , ab_secuencial_pag         , ab_operacion        , 
      ab_fecha_ing     , ab_fecha_pag         , ab_cuota_completa         , ab_aceptar_anticipos, 
      ab_tipo_reduccion, ab_tipo_cobro        , ab_dias_retencion_ini     , ab_dias_retencion   , 
      ab_estado        , ab_usuario           , ab_oficina                , ab_terminal         , 
      ab_tipo          , ab_tipo_aplicacion   , ab_nro_recibo             , ab_tasa_prepago     , 
      ab_dividendo     , ab_calcula_devolucion, ab_prepago_desde_lavigente, ab_extraordinario)
   select
      ab_secuencial_ing, ab_secuencial_rpa    , ab_secuencial_pag         , @w_operacion_ficticia, 
      ab_fecha_ing     , ab_fecha_pag         , ab_cuota_completa         , ab_aceptar_anticipos, 
      ab_tipo_reduccion, ab_tipo_cobro        , ab_dias_retencion_ini     , ab_dias_retencion   , 
      ab_estado        , ab_usuario           , ab_oficina                , ab_terminal         , 
      ab_tipo          , ab_tipo_aplicacion   , ab_nro_recibo             , ab_tasa_prepago     , 
      ab_dividendo     , ab_calcula_devolucion, ab_prepago_desde_lavigente, ab_extraordinario
   from ca_abono
   where ab_operacion = @i_operacionca
   
   if @@error <> 0
      return 710261
	  
   insert into ca_abono_det (
      abd_secuencial_ing , abd_operacion        , abd_tipo          , abd_concepto, 
      abd_cuenta         , abd_beneficiario     , abd_moneda        , abd_monto_mpg, 
      abd_monto_mop      , abd_monto_mn         , abd_cotizacion_mpg, abd_cotizacion_mop, 
      abd_tcotizacion_mpg, abd_tcotizacion_mop  , abd_cheque        , abd_cod_banco, 
      abd_inscripcion    , abd_carga            , abd_porcentaje_con)
   select
      abd_secuencial_ing , @w_operacion_ficticia, abd_tipo          , abd_concepto, 
      abd_cuenta         , abd_beneficiario     , abd_moneda        , abd_monto_mpg, 
      abd_monto_mop      , abd_monto_mn         , abd_cotizacion_mpg, abd_cotizacion_mop, 
      abd_tcotizacion_mpg, abd_tcotizacion_mop  , abd_cheque        , abd_cod_banco, 
      abd_inscripcion    , abd_carga            , abd_porcentaje_con 
   from ca_abono_det
   where abd_operacion = @i_operacionca
   
   if @@error <> 0
      return 710261
	  
end 


if @i_operacion = 'D' 
begin
   print 'Ingreso a la opciOn D del sp_copia_ficticia, la operaciOn: ' + convert(varchar, @i_operacionca)
   select @w_operacion_ficticia = op_ficticia
   from ca_operacion_proy 
   where op_operacion_real = @i_operacionca
   
   if @w_operacion_ficticia > 0 
        return 0

    delete cob_cartera..ca_transaccion_prv
    where tp_operacion <0
    and tp_estado = 'ING'

   delete ca_operacion 
   where  op_operacion = @w_operacion_ficticia
   
   delete ca_rubro_op 
   where  ro_operacion  = @w_operacion_ficticia

   delete   ca_dividendo
   where  di_operacion   = @w_operacion_ficticia
   
   delete ca_amortizacion 
   where  am_operacion  = @w_operacion_ficticia
   

   delete ca_cuota_adicional
   where  ca_operacion  = @w_operacion_ficticia
   
   delete   ca_valores
   where  va_operacion  = @w_operacion_ficticia
      
   delete   ca_amortizacion_ant
   where  an_operacion  = @w_operacion_ficticia
   
   delete   ca_diferidos
   where  dif_operacion  = @w_operacion_ficticia
   
   delete ca_facturas
   where  fac_operacion  = @w_operacion_ficticia
   
   delete   ca_traslado_interes
   where  ti_operacion  = @w_operacion_ficticia 
      
   delete ca_comision_diferida
   where  cd_operacion   = @w_operacion_ficticia   
      
   delete  ca_seguros
   where  se_operacion  = @w_operacion_ficticia
   
   delete  ca_seguros_det 
   where  sed_operacion  = @w_operacion_ficticia
   
   delete ca_seguros_can
   where  sec_operacion  = @w_operacion_ficticia
   
   delete   ca_operacion_ext
   where  oe_operacion  = @w_operacion_ficticia
   
   delete ca_secuenciales
   where se_operacion = @w_operacion_ficticia
   
   delete ca_transaccion
   where  tr_operacion  = @w_operacion_ficticia
   
   delete ca_det_trn
   where  dtr_operacion  = @w_operacion_ficticia
   
   delete ca_desembolso
   where  dm_operacion  = @w_operacion_ficticia
   
   delete ca_abono
   where ab_operacion = @w_operacion_ficticia
      
   delete ca_abono_det
   where abd_operacion = @w_operacion_ficticia
   
   -- Historial
   delete ca_correccion_his    
   where  coh_operacion = @w_operacion_ficticia
   
   delete ca_operacion_his 
   where  oph_operacion = @w_operacion_ficticia
   
   delete ca_rubro_op_his
   where  roh_operacion = @w_operacion_ficticia
   
   delete ca_dividendo_his 
   where  dih_dividendo = @w_operacion_ficticia
   
   delete ca_amortizacion_his 
   where  amh_operacion = @w_operacion_ficticia
   
   delete ca_cuota_adicional_his 
   where  cah_operacion = @w_operacion_ficticia
   
   delete ca_valores_his 
   where  vah_operacion = @w_operacion_ficticia
   
   delete ca_amortizacion_ant_his 
   where  anh_operacion = @w_operacion_ficticia

   delete ca_diferidos_his 
   where  difh_operacion = @w_operacion_ficticia
   
   delete ca_facturas_his 
   where  fach_operacion = @w_operacion_ficticia
   
   delete ca_traslado_interes_his 
   where  tih_operacion = @w_operacion_ficticia
   
   delete ca_comision_diferida_his 
   where  cdh_operacion = @w_operacion_ficticia
   
   delete ca_seguros_his 
   where  seh_operacion = @w_operacion_ficticia
   
   delete ca_seguros_det_his 
   where  sedh_operacion = @w_operacion_ficticia
   
   delete ca_seguros_can_his 
   where  sech_operacion = @w_operacion_ficticia
   
   delete ca_operacion_ext_his 
   where  oeh_operacion = @w_operacion_ficticia
     
   delete ca_operacion_proy
   where op_operacion_real = @i_operacionca   
           
end  


return 0
go
