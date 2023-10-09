USE cob_cartera
GO

IF OBJECT_ID ('dbo.ca_control_pago') IS NOT NULL
	DROP TABLE dbo.ca_control_pago
GO
IF OBJECT_ID ('dbo.ca_pago_sostenido') IS NOT NULL
	DROP TABLE dbo.ca_pago_sostenido
GO
IF OBJECT_ID ('dbo.venta_archivo') IS NOT NULL
	DROP TABLE dbo.venta_archivo
GO
IF OBJECT_ID ('dbo.universo_cca397') IS NOT NULL
	DROP TABLE dbo.universo_cca397
GO
IF OBJECT_ID ('dbo.tras_cred_ofic_tmp') IS NOT NULL
	DROP TABLE dbo.tras_cred_ofic_tmp
GO
IF OBJECT_ID ('dbo.Totales_sarlaft_tmp') IS NOT NULL
	DROP TABLE dbo.Totales_sarlaft_tmp
GO
IF OBJECT_ID ('dbo.tmp_transacciones') IS NOT NULL
	DROP TABLE dbo.tmp_transacciones
GO
IF OBJECT_ID ('dbo.tmp_totales_transaccion_ct') IS NOT NULL
	DROP TABLE dbo.tmp_totales_transaccion_ct
GO
IF OBJECT_ID ('dbo.tmp_totales_pag') IS NOT NULL
	DROP TABLE dbo.tmp_totales_pag
GO
IF OBJECT_ID ('dbo.tmp_tflexible_inttras') IS NOT NULL
	DROP TABLE dbo.tmp_tflexible_inttras
GO
IF OBJECT_ID ('dbo.tmp_temp_sus') IS NOT NULL
	DROP TABLE dbo.tmp_temp_sus
GO
IF OBJECT_ID ('dbo.tmp_tabla_amortizacion') IS NOT NULL
	DROP TABLE dbo.tmp_tabla_amortizacion
GO
IF OBJECT_ID ('dbo.tmp_rubros_op_msv') IS NOT NULL
	DROP TABLE dbo.tmp_rubros_op_msv
GO
IF OBJECT_ID ('dbo.tmp_rubros_op_i') IS NOT NULL
	DROP TABLE dbo.tmp_rubros_op_i
GO
IF OBJECT_ID ('dbo.tmp_rubros_d') IS NOT NULL
	DROP TABLE dbo.tmp_rubros_d
GO
IF OBJECT_ID ('dbo.tmp_rubros_cr') IS NOT NULL
	DROP TABLE dbo.tmp_rubros_cr
GO
IF OBJECT_ID ('dbo.tmp_resp_amortizacion_bisem') IS NOT NULL
	DROP TABLE dbo.tmp_resp_amortizacion_bisem
GO
IF OBJECT_ID ('dbo.tmp_plano_msv') IS NOT NULL
	DROP TABLE dbo.tmp_plano_msv
GO
IF OBJECT_ID ('dbo.tmp_plano_liq_msv') IS NOT NULL
	DROP TABLE dbo.tmp_plano_liq_msv
GO
IF OBJECT_ID ('dbo.tmp_plano_car') IS NOT NULL
	DROP TABLE dbo.tmp_plano_car
GO
IF OBJECT_ID ('dbo.tmp_pagos_uni') IS NOT NULL
	DROP TABLE dbo.tmp_pagos_uni
GO
IF OBJECT_ID ('dbo.tmp_Operacion_PAgos') IS NOT NULL
	DROP TABLE dbo.tmp_Operacion_PAgos
GO
IF OBJECT_ID ('dbo.tmp_operacion') IS NOT NULL
	DROP TABLE dbo.tmp_operacion
GO
IF OBJECT_ID ('dbo.tmp_mon') IS NOT NULL
	DROP TABLE dbo.tmp_mon
GO
IF OBJECT_ID ('dbo.tmp_matriz_resp') IS NOT NULL
	DROP TABLE dbo.tmp_matriz_resp
GO
IF OBJECT_ID ('dbo.tmp_interes_amortiza_tmp') IS NOT NULL
	DROP TABLE dbo.tmp_interes_amortiza_tmp
GO
IF OBJECT_ID ('dbo.tmp_interes_amortiza_msv') IS NOT NULL
	DROP TABLE dbo.tmp_interes_amortiza_msv
GO
IF OBJECT_ID ('dbo.tmp_garantias_tramite') IS NOT NULL
	DROP TABLE dbo.tmp_garantias_tramite
GO
IF OBJECT_ID ('dbo.tmp_gar_especiales') IS NOT NULL
	DROP TABLE dbo.tmp_gar_especiales
GO
IF OBJECT_ID ('dbo.tmp_gar_especial') IS NOT NULL
	DROP TABLE dbo.tmp_gar_especial
GO
IF OBJECT_ID ('dbo.tmp_fng') IS NOT NULL
	DROP TABLE dbo.tmp_fng
GO
IF OBJECT_ID ('dbo.tmp_esalalf') IS NOT NULL
	DROP TABLE dbo.tmp_esalalf
GO
IF OBJECT_ID ('dbo.tmp_en_tmp') IS NOT NULL
	DROP TABLE dbo.tmp_en_tmp
GO
IF OBJECT_ID ('dbo.tmp_dec') IS NOT NULL
	DROP TABLE dbo.tmp_dec
GO
IF OBJECT_ID ('dbo.tmp_cursor_operacion') IS NOT NULL
	DROP TABLE dbo.tmp_cursor_operacion
GO
IF OBJECT_ID ('dbo.tmp_cuota_balon') IS NOT NULL
	DROP TABLE dbo.tmp_cuota_balon
GO
IF OBJECT_ID ('dbo.tmp_colateral_msv') IS NOT NULL
	DROP TABLE dbo.tmp_colateral_msv
GO
IF OBJECT_ID ('dbo.tmp_codval') IS NOT NULL
	DROP TABLE dbo.tmp_codval
GO
IF OBJECT_ID ('dbo.tmp_causacion_pasivas_proc') IS NOT NULL
	DROP TABLE dbo.tmp_causacion_pasivas_proc
GO
IF OBJECT_ID ('dbo.tmp_causacion_pasivas_pend') IS NOT NULL
	DROP TABLE dbo.tmp_causacion_pasivas_pend
GO
IF OBJECT_ID ('dbo.tmp_causacion_pasivas_auto') IS NOT NULL
	DROP TABLE dbo.tmp_causacion_pasivas_auto
GO
IF OBJECT_ID ('dbo.tmp_calculo_pasivas') IS NOT NULL
	DROP TABLE dbo.tmp_calculo_pasivas
GO
IF OBJECT_ID ('dbo.tmp_archivo') IS NOT NULL
	DROP TABLE dbo.tmp_archivo
GO
IF OBJECT_ID ('dbo.temp_planos') IS NOT NULL
	DROP TABLE dbo.temp_planos
GO
IF OBJECT_ID ('dbo.temp_conv') IS NOT NULL
	DROP TABLE dbo.temp_conv
GO
IF OBJECT_ID ('dbo.temp_borrar_op') IS NOT NULL
	DROP TABLE dbo.temp_borrar_op
GO
IF OBJECT_ID ('dbo.temp_abonos') IS NOT NULL
	DROP TABLE dbo.temp_abonos
GO
IF OBJECT_ID ('dbo.tabla_tmp') IS NOT NULL
	DROP TABLE dbo.tabla_tmp
GO
IF OBJECT_ID ('dbo.ta_fecha_valor') IS NOT NULL
	DROP TABLE dbo.ta_fecha_valor
GO
IF OBJECT_ID ('dbo.t_tramrecha') IS NOT NULL
	DROP TABLE dbo.t_tramrecha
GO
IF OBJECT_ID ('dbo.segurovig_tmp') IS NOT NULL
	DROP TABLE dbo.segurovig_tmp
GO
IF OBJECT_ID ('dbo.seguros_det_cca397') IS NOT NULL
	DROP TABLE dbo.seguros_det_cca397
GO
IF OBJECT_ID ('dbo.sec_pago_rv') IS NOT NULL
	DROP TABLE dbo.sec_pago_rv
GO
IF OBJECT_ID ('dbo.saldos_entes') IS NOT NULL
	DROP TABLE dbo.saldos_entes
GO
IF OBJECT_ID ('dbo.rubros_tmp') IS NOT NULL
	DROP TABLE dbo.rubros_tmp
GO
IF OBJECT_ID ('dbo.rpt_n1') IS NOT NULL
	DROP TABLE dbo.rpt_n1
GO
IF OBJECT_ID ('dbo.RESPALDO_INT_VIGENTEMARZO2015') IS NOT NULL
	DROP TABLE dbo.RESPALDO_INT_VIGENTEMARZO2015
GO
IF OBJECT_ID ('dbo.RESPALDO_DIFF_INT_MARZO2015H') IS NOT NULL
	DROP TABLE dbo.RESPALDO_DIFF_INT_MARZO2015H
GO
IF OBJECT_ID ('dbo.RESPALDO_DIFF_INT_MARZO2015') IS NOT NULL
	DROP TABLE dbo.RESPALDO_DIFF_INT_MARZO2015
GO
IF OBJECT_ID ('dbo.reporte0028') IS NOT NULL
	DROP TABLE dbo.reporte0028
GO
IF OBJECT_ID ('dbo.reporte_reestruct_tmp') IS NOT NULL
	DROP TABLE dbo.reporte_reestruct_tmp
GO
IF OBJECT_ID ('dbo.reporte') IS NOT NULL
	DROP TABLE dbo.reporte
GO
IF OBJECT_ID ('dbo.rep_prorecpag') IS NOT NULL
	DROP TABLE dbo.rep_prorecpag
GO
IF OBJECT_ID ('dbo.rep_pasivas') IS NOT NULL
	DROP TABLE dbo.rep_pasivas
GO
IF OBJECT_ID ('dbo.reloj') IS NOT NULL
	DROP TABLE dbo.reloj
GO
IF OBJECT_ID ('dbo.registro_rec') IS NOT NULL
	DROP TABLE dbo.registro_rec
GO
IF OBJECT_ID ('dbo.recaudos_masivos_tmp3') IS NOT NULL
	DROP TABLE dbo.recaudos_masivos_tmp3
GO
IF OBJECT_ID ('dbo.reaj_operaciones') IS NOT NULL
	DROP TABLE dbo.reaj_operaciones
GO
IF OBJECT_ID ('dbo.prueba') IS NOT NULL
	DROP TABLE dbo.prueba
GO
IF OBJECT_ID ('dbo.pro_cast_cartera') IS NOT NULL
	DROP TABLE dbo.pro_cast_cartera
GO
IF OBJECT_ID ('dbo.prepagos_rep') IS NOT NULL
	DROP TABLE dbo.prepagos_rep
GO
IF OBJECT_ID ('dbo.Pago_Masivo') IS NOT NULL
	DROP TABLE dbo.Pago_Masivo
GO
IF OBJECT_ID ('dbo.operaciones_tmp') IS NOT NULL
	DROP TABLE dbo.operaciones_tmp
GO
IF OBJECT_ID ('dbo.operaciones_cartera') IS NOT NULL
	DROP TABLE dbo.operaciones_cartera
GO
IF OBJECT_ID ('dbo.operaciones_ca') IS NOT NULL
	DROP TABLE dbo.operaciones_ca
GO
IF OBJECT_ID ('dbo.operaciones') IS NOT NULL
	DROP TABLE dbo.operaciones
GO
IF OBJECT_ID ('dbo.operacion_tmp') IS NOT NULL
	DROP TABLE dbo.operacion_tmp
GO
IF OBJECT_ID ('dbo.operacion_sva') IS NOT NULL
	DROP TABLE dbo.operacion_sva
GO
IF OBJECT_ID ('dbo.operac') IS NOT NULL
	DROP TABLE dbo.operac
GO
IF OBJECT_ID ('dbo.opera') IS NOT NULL
	DROP TABLE dbo.opera
GO
IF OBJECT_ID ('dbo.oper_vig_cca406_his') IS NOT NULL
	DROP TABLE dbo.oper_vig_cca406_his
GO
IF OBJECT_ID ('dbo.oper_vig_cca406') IS NOT NULL
	DROP TABLE dbo.oper_vig_cca406
GO
IF OBJECT_ID ('dbo.oper_cca') IS NOT NULL
	DROP TABLE dbo.oper_cca
GO
IF OBJECT_ID ('dbo.oper_bcafe') IS NOT NULL
	DROP TABLE dbo.oper_bcafe
GO
IF OBJECT_ID ('dbo.oper') IS NOT NULL
	DROP TABLE dbo.oper
GO
IF OBJECT_ID ('dbo.ope_castigos') IS NOT NULL
	DROP TABLE dbo.ope_castigos
GO
IF OBJECT_ID ('dbo.msgprueba') IS NOT NULL
	DROP TABLE dbo.msgprueba
GO
IF OBJECT_ID ('dbo.mover_masivo_op_cliente') IS NOT NULL
	DROP TABLE dbo.mover_masivo_op_cliente
GO
IF OBJECT_ID ('dbo.mipymes') IS NOT NULL
	DROP TABLE dbo.mipymes
GO
IF OBJECT_ID ('dbo.mi_num_creditos') IS NOT NULL
	DROP TABLE dbo.mi_num_creditos
GO
IF OBJECT_ID ('dbo.info_finagro_archivo') IS NOT NULL
	DROP TABLE dbo.info_finagro_archivo
GO
IF OBJECT_ID ('dbo.info_cca') IS NOT NULL
	DROP TABLE dbo.info_cca
GO
IF OBJECT_ID ('dbo.imp_recibo_pago_masivo_pag') IS NOT NULL
	DROP TABLE dbo.imp_recibo_pago_masivo_pag
GO
IF OBJECT_ID ('dbo.imp_recibo_pago_masivo_det') IS NOT NULL
	DROP TABLE dbo.imp_recibo_pago_masivo_det
GO
IF OBJECT_ID ('dbo.imp_recibo_pago_masivo_cab') IS NOT NULL
	DROP TABLE dbo.imp_recibo_pago_masivo_cab
GO
IF OBJECT_ID ('dbo.gar_especiales') IS NOT NULL
	DROP TABLE dbo.gar_especiales
GO
IF OBJECT_ID ('dbo.entes_territoriales') IS NOT NULL
	DROP TABLE dbo.entes_territoriales
GO
IF OBJECT_ID ('dbo.dividendo_sva') IS NOT NULL
	DROP TABLE dbo.dividendo_sva
GO
IF OBJECT_ID ('dbo.diferencias_rubros') IS NOT NULL
	DROP TABLE dbo.diferencias_rubros
GO
IF OBJECT_ID ('dbo.dia92') IS NOT NULL
	DROP TABLE dbo.dia92
GO
IF OBJECT_ID ('dbo.dia62') IS NOT NULL
	DROP TABLE dbo.dia62
GO
IF OBJECT_ID ('dbo.dia32') IS NOT NULL
	DROP TABLE dbo.dia32
GO
IF OBJECT_ID ('dbo.dia182') IS NOT NULL
	DROP TABLE dbo.dia182
GO
IF OBJECT_ID ('dbo.detalle2_Comercial_tmp') IS NOT NULL
	DROP TABLE dbo.detalle2_Comercial_tmp
GO
IF OBJECT_ID ('dbo.detalle1_sarlaft_tmp') IS NOT NULL
	DROP TABLE dbo.detalle1_sarlaft_tmp
GO
IF OBJECT_ID ('dbo.detalle_cliente_tmp') IS NOT NULL
	DROP TABLE dbo.detalle_cliente_tmp
GO
IF OBJECT_ID ('dbo.det_desembolso') IS NOT NULL
	DROP TABLE dbo.det_desembolso
GO
IF OBJECT_ID ('dbo.det_condonacion') IS NOT NULL
	DROP TABLE dbo.det_condonacion
GO
IF OBJECT_ID ('dbo.datos_operacion_ren_tmp') IS NOT NULL
	DROP TABLE dbo.datos_operacion_ren_tmp
GO
IF OBJECT_ID ('dbo.cx_amortizacion') IS NOT NULL
	DROP TABLE dbo.cx_amortizacion
GO
IF OBJECT_ID ('dbo.cruce') IS NOT NULL
	DROP TABLE dbo.cruce
GO
IF OBJECT_ID ('dbo.cr_tramite_ticket_0272553') IS NOT NULL
	DROP TABLE dbo.cr_tramite_ticket_0272553
GO
IF OBJECT_ID ('dbo.cr_tramite_ticket_0267280') IS NOT NULL
	DROP TABLE dbo.cr_tramite_ticket_0267280
GO
IF OBJECT_ID ('dbo.cr_tramite_ors_1273') IS NOT NULL
	DROP TABLE dbo.cr_tramite_ors_1273
GO
IF OBJECT_ID ('dbo.cr_tramite_ors_1270') IS NOT NULL
	DROP TABLE dbo.cr_tramite_ors_1270
GO
IF OBJECT_ID ('dbo.cr_tramite_ors_1235') IS NOT NULL
	DROP TABLE dbo.cr_tramite_ors_1235
GO
IF OBJECT_ID ('dbo.cr_tmp_datooper') IS NOT NULL
	DROP TABLE dbo.cr_tmp_datooper
GO
IF OBJECT_ID ('dbo.cr_reporte_tasas_det') IS NOT NULL
	DROP TABLE dbo.cr_reporte_tasas_det
GO
IF OBJECT_ID ('dbo.cr_reporte_tasas_cab') IS NOT NULL
	DROP TABLE dbo.cr_reporte_tasas_cab
GO
IF OBJECT_ID ('dbo.cp_operacion_tmp') IS NOT NULL
	DROP TABLE dbo.cp_operacion_tmp
GO
IF OBJECT_ID ('dbo.cp_oper_canal') IS NOT NULL
	DROP TABLE dbo.cp_oper_canal
GO
IF OBJECT_ID ('dbo.CONTROL_BATCH') IS NOT NULL
	DROP TABLE dbo.CONTROL_BATCH
GO
IF OBJECT_ID ('dbo.ConceptosMORA') IS NOT NULL
	DROP TABLE dbo.ConceptosMORA
GO
IF OBJECT_ID ('dbo.compensacion_actpas_tmp') IS NOT NULL
	DROP TABLE dbo.compensacion_actpas_tmp
GO
IF OBJECT_ID ('dbo.comparar_cobis') IS NOT NULL
	DROP TABLE dbo.comparar_cobis
GO
IF OBJECT_ID ('dbo.comparar_banco') IS NOT NULL
	DROP TABLE dbo.comparar_banco
GO
IF OBJECT_ID ('dbo.casacont') IS NOT NULL
	DROP TABLE dbo.casacont
GO
IF OBJECT_ID ('dbo.capital') IS NOT NULL
	DROP TABLE dbo.capital
GO
IF OBJECT_ID ('dbo.canceladas_ca') IS NOT NULL
	DROP TABLE dbo.canceladas_ca
GO
IF OBJECT_ID ('dbo.cabecera_tmp_pag_ext') IS NOT NULL
	DROP TABLE dbo.cabecera_tmp_pag_ext
GO
IF OBJECT_ID ('dbo.cabecera') IS NOT NULL
	DROP TABLE dbo.cabecera
GO
IF OBJECT_ID ('dbo.cab_desembolso') IS NOT NULL
	DROP TABLE dbo.cab_desembolso
GO
IF OBJECT_ID ('dbo.cab_condonacion') IS NOT NULL
	DROP TABLE dbo.cab_condonacion
GO
IF OBJECT_ID ('dbo.ca_verificacion') IS NOT NULL
	DROP TABLE dbo.ca_verificacion
GO
IF OBJECT_ID ('dbo.ca_venta_universo_ors_1256') IS NOT NULL
	DROP TABLE dbo.ca_venta_universo_ors_1256
GO
IF OBJECT_ID ('dbo.ca_venta_universo') IS NOT NULL
	DROP TABLE dbo.ca_venta_universo
GO
IF OBJECT_ID ('dbo.ca_vencimiento_reajuste_t2') IS NOT NULL
	DROP TABLE dbo.ca_vencimiento_reajuste_t2
GO
IF OBJECT_ID ('dbo.ca_vencimiento_reajuste_t1') IS NOT NULL
	DROP TABLE dbo.ca_vencimiento_reajuste_t1
GO
IF OBJECT_ID ('dbo.ca_valores_tmp_rub') IS NOT NULL
	DROP TABLE dbo.ca_valores_tmp_rub
GO
IF OBJECT_ID ('dbo.ca_valores_tmp') IS NOT NULL
	DROP TABLE dbo.ca_valores_tmp
GO
IF OBJECT_ID ('dbo.ca_valores_pag') IS NOT NULL
	DROP TABLE dbo.ca_valores_pag
GO
IF OBJECT_ID ('dbo.ca_valores_his') IS NOT NULL
	DROP TABLE dbo.ca_valores_his
GO
IF OBJECT_ID ('dbo.ca_valores_desdir') IS NOT NULL
	DROP TABLE dbo.ca_valores_desdir
GO
IF OBJECT_ID ('dbo.ca_valores') IS NOT NULL
	DROP TABLE dbo.ca_valores
GO
IF OBJECT_ID ('dbo.ca_valor_ts') IS NOT NULL
	DROP TABLE dbo.ca_valor_ts
GO
IF OBJECT_ID ('dbo.ca_valor_referencial_ts') IS NOT NULL
	DROP TABLE dbo.ca_valor_referencial_ts
GO
IF OBJECT_ID ('dbo.ca_valor_referencial_bancamia') IS NOT NULL
	DROP TABLE dbo.ca_valor_referencial_bancamia
GO
IF OBJECT_ID ('dbo.ca_valor_det_ts') IS NOT NULL
	DROP TABLE dbo.ca_valor_det_ts
GO
IF OBJECT_ID ('dbo.ca_valor_det') IS NOT NULL
	DROP TABLE dbo.ca_valor_det
GO
IF OBJECT_ID ('dbo.ca_valor_desbloqueo') IS NOT NULL
	DROP TABLE dbo.ca_valor_desbloqueo
GO
IF OBJECT_ID ('dbo.ca_valor_axt_masiva_pr') IS NOT NULL
	DROP TABLE dbo.ca_valor_axt_masiva_pr
GO
IF OBJECT_ID ('dbo.ca_valor_atx_pr') IS NOT NULL
	DROP TABLE dbo.ca_valor_atx_pr
GO
IF OBJECT_ID ('dbo.ca_valor_atx_errada') IS NOT NULL
	DROP TABLE dbo.ca_valor_atx_errada
GO
IF OBJECT_ID ('dbo.ca_valor_atx') IS NOT NULL
	DROP TABLE dbo.ca_valor_atx
GO
IF OBJECT_ID ('dbo.ca_valor_acumulado_antant') IS NOT NULL
	DROP TABLE dbo.ca_valor_acumulado_antant
GO
IF OBJECT_ID ('dbo.ca_valor') IS NOT NULL
	DROP TABLE dbo.ca_valor
GO
IF OBJECT_ID ('dbo.ca_val_oper_finagro_tmp') IS NOT NULL
	DROP TABLE dbo.ca_val_oper_finagro_tmp
GO
IF OBJECT_ID ('dbo.ca_val_oper_finagro_log') IS NOT NULL
	DROP TABLE dbo.ca_val_oper_finagro_log
GO
IF OBJECT_ID ('dbo.ca_val_oper_finagro_1') IS NOT NULL
	DROP TABLE dbo.ca_val_oper_finagro_1
GO
IF OBJECT_ID ('dbo.ca_val_oper_finagro') IS NOT NULL
	DROP TABLE dbo.ca_val_oper_finagro
GO
IF OBJECT_ID ('dbo.ca_uvr_subir') IS NOT NULL
	DROP TABLE dbo.ca_uvr_subir
GO
IF OBJECT_ID ('dbo.ca_uvr_proyectado') IS NOT NULL
	DROP TABLE dbo.ca_uvr_proyectado
GO
IF OBJECT_ID ('dbo.ca_universo_venta') IS NOT NULL
	DROP TABLE dbo.ca_universo_venta
GO
IF OBJECT_ID ('dbo.ca_universo_ors_924_tmp') IS NOT NULL
	DROP TABLE dbo.ca_universo_ors_924_tmp
GO
IF OBJECT_ID ('dbo.ca_universo_operaciones') IS NOT NULL
	DROP TABLE dbo.ca_universo_operaciones
GO
IF OBJECT_ID ('dbo.ca_universo_conta') IS NOT NULL
	DROP TABLE dbo.ca_universo_conta
GO
IF OBJECT_ID ('dbo.ca_universo_cartera') IS NOT NULL
	DROP TABLE dbo.ca_universo_cartera
GO
IF OBJECT_ID ('dbo.ca_universo_boc') IS NOT NULL
	DROP TABLE dbo.ca_universo_boc
GO
IF OBJECT_ID ('dbo.ca_universo_batch_opt') IS NOT NULL
	DROP TABLE dbo.ca_universo_batch_opt
GO
IF OBJECT_ID ('dbo.ca_universo_batch') IS NOT NULL
	DROP TABLE dbo.ca_universo_batch
GO
IF OBJECT_ID ('dbo.ca_universo_atx') IS NOT NULL
	DROP TABLE dbo.ca_universo_atx
GO
IF OBJECT_ID ('dbo.ca_ultima_tasa_op_ticket_0260499') IS NOT NULL
	DROP TABLE dbo.ca_ultima_tasa_op_ticket_0260499
GO
IF OBJECT_ID ('dbo.ca_ultima_tasa_op_his') IS NOT NULL
	DROP TABLE dbo.ca_ultima_tasa_op_his
GO
IF OBJECT_ID ('dbo.ca_ultima_tasa_op') IS NOT NULL
	DROP TABLE dbo.ca_ultima_tasa_op
GO
IF OBJECT_ID ('dbo.ca_trn_resumen_prv_tmp') IS NOT NULL
	DROP TABLE dbo.ca_trn_resumen_prv_tmp
GO
IF OBJECT_ID ('dbo.ca_trn_resumen_prv') IS NOT NULL
	DROP TABLE dbo.ca_trn_resumen_prv
GO
IF OBJECT_ID ('dbo.ca_trn_oper_ts') IS NOT NULL
	DROP TABLE dbo.ca_trn_oper_ts
GO
IF OBJECT_ID ('dbo.ca_trn_oper_bancamia') IS NOT NULL
	DROP TABLE dbo.ca_trn_oper_bancamia
GO
IF OBJECT_ID ('dbo.ca_trn_oper') IS NOT NULL
	DROP TABLE dbo.ca_trn_oper
GO
IF OBJECT_ID ('dbo.ca_trn_diaria') IS NOT NULL
	DROP TABLE dbo.ca_trn_diaria
GO
IF OBJECT_ID ('dbo.ca_traslados_cartera') IS NOT NULL
	DROP TABLE dbo.ca_traslados_cartera
GO
IF OBJECT_ID ('dbo.ca_traslados') IS NOT NULL
	DROP TABLE dbo.ca_traslados
GO
IF OBJECT_ID ('dbo.ca_traslado_linea') IS NOT NULL
	DROP TABLE dbo.ca_traslado_linea
GO
IF OBJECT_ID ('dbo.ca_traslado_interes_ts') IS NOT NULL
	DROP TABLE dbo.ca_traslado_interes_ts
GO
IF OBJECT_ID ('dbo.ca_traslado_interes_his') IS NOT NULL
	DROP TABLE dbo.ca_traslado_interes_his
GO
IF OBJECT_ID ('dbo.ca_traslado_interes') IS NOT NULL
	DROP TABLE dbo.ca_traslado_interes
GO
IF OBJECT_ID ('dbo.ca_transaccion2') IS NOT NULL
	DROP TABLE dbo.ca_transaccion2
GO
IF OBJECT_ID ('dbo.ca_transaccion_prv_tmp') IS NOT NULL
	DROP TABLE dbo.ca_transaccion_prv_tmp
GO
IF OBJECT_ID ('dbo.ca_transaccion_prv_opt3') IS NOT NULL
	DROP TABLE dbo.ca_transaccion_prv_opt3
GO
IF OBJECT_ID ('dbo.ca_transaccion_prv_copia') IS NOT NULL
	DROP TABLE dbo.ca_transaccion_prv_copia
GO
IF OBJECT_ID ('dbo.ca_transaccion_prv') IS NOT NULL
	DROP TABLE dbo.ca_transaccion_prv
GO
IF OBJECT_ID ('dbo.ca_transaccion_opt3') IS NOT NULL
	DROP TABLE dbo.ca_transaccion_opt3
GO
IF OBJECT_ID ('dbo.ca_transaccion_imp_tmp') IS NOT NULL
	DROP TABLE dbo.ca_transaccion_imp_tmp
GO
IF OBJECT_ID ('dbo.ca_transaccion_bancamia_tmp') IS NOT NULL
	DROP TABLE dbo.ca_transaccion_bancamia_tmp
GO
IF OBJECT_ID ('dbo.ca_transaccion_bancamia') IS NOT NULL
	DROP TABLE dbo.ca_transaccion_bancamia
GO
IF OBJECT_ID ('dbo.ca_transaccion') IS NOT NULL
	DROP TABLE dbo.ca_transaccion
GO
IF OBJECT_ID ('dbo.ca_trans4_tmp') IS NOT NULL
	DROP TABLE dbo.ca_trans4_tmp
GO
IF OBJECT_ID ('dbo.ca_trans3_tmp') IS NOT NULL
	DROP TABLE dbo.ca_trans3_tmp
GO
IF OBJECT_ID ('dbo.ca_trans2_tmp') IS NOT NULL
	DROP TABLE dbo.ca_trans2_tmp
GO
IF OBJECT_ID ('dbo.ca_trans1_tmp') IS NOT NULL
	DROP TABLE dbo.ca_trans1_tmp
GO
IF OBJECT_ID ('dbo.ca_tran_no_conta') IS NOT NULL
	DROP TABLE dbo.ca_tran_no_conta
GO
IF OBJECT_ID ('dbo.ca_tran_error') IS NOT NULL
	DROP TABLE dbo.ca_tran_error
GO
IF OBJECT_ID ('dbo.ca_tran_con_vis') IS NOT NULL
	DROP TABLE dbo.ca_tran_con_vis
GO
IF OBJECT_ID ('dbo.ca_TP_tmp') IS NOT NULL
	DROP TABLE dbo.ca_TP_tmp
GO
IF OBJECT_ID ('dbo.ca_totales_trn') IS NOT NULL
	DROP TABLE dbo.ca_totales_trn
GO
IF OBJECT_ID ('dbo.ca_totales_hc_conso') IS NOT NULL
	DROP TABLE dbo.ca_totales_hc_conso
GO
IF OBJECT_ID ('dbo.ca_totales_det') IS NOT NULL
	DROP TABLE dbo.ca_totales_det
GO
IF OBJECT_ID ('dbo.ca_totales') IS NOT NULL
	DROP TABLE dbo.ca_totales
GO
IF OBJECT_ID ('dbo.ca_total_prioridad_tmp') IS NOT NULL
	DROP TABLE dbo.ca_total_prioridad_tmp
GO
IF OBJECT_ID ('dbo.ca_toperacion_mig') IS NOT NULL
	DROP TABLE dbo.ca_toperacion_mig
GO
IF OBJECT_ID ('dbo.ca_tmp_transaccion') IS NOT NULL
	DROP TABLE dbo.ca_tmp_transaccion
GO
IF OBJECT_ID ('dbo.ca_tmp_seguro') IS NOT NULL
	DROP TABLE dbo.ca_tmp_seguro
GO
IF OBJECT_ID ('dbo.ca_tmp_datooper') IS NOT NULL
	DROP TABLE dbo.ca_tmp_datooper
GO
IF OBJECT_ID ('dbo.ca_tipos_empleados_rrhh') IS NOT NULL
	DROP TABLE dbo.ca_tipos_empleados_rrhh
GO
IF OBJECT_ID ('dbo.ca_tipo_trn') IS NOT NULL
	DROP TABLE dbo.ca_tipo_trn
GO
IF OBJECT_ID ('dbo.ca_tipo_plazo') IS NOT NULL
	DROP TABLE dbo.ca_tipo_plazo
GO
IF OBJECT_ID ('dbo.ca_tipo_linea') IS NOT NULL
	DROP TABLE dbo.ca_tipo_linea
GO
IF OBJECT_ID ('dbo.ca_tipo_doc_mbs') IS NOT NULL
	DROP TABLE dbo.ca_tipo_doc_mbs
GO
IF OBJECT_ID ('dbo.ca_timbre') IS NOT NULL
	DROP TABLE dbo.ca_timbre
GO
IF OBJECT_ID ('dbo.ca_temporal') IS NOT NULL
	DROP TABLE dbo.ca_temporal
GO
IF OBJECT_ID ('dbo.ca_temp_porcentaje') IS NOT NULL
	DROP TABLE dbo.ca_temp_porcentaje
GO
IF OBJECT_ID ('dbo.ca_temp_div_total') IS NOT NULL
	DROP TABLE dbo.ca_temp_div_total
GO
IF OBJECT_ID ('dbo.ca_temp_div_parcial') IS NOT NULL
	DROP TABLE dbo.ca_temp_div_parcial
GO
IF OBJECT_ID ('dbo.ca_temp_conv_baloto') IS NOT NULL
	DROP TABLE dbo.ca_temp_conv_baloto
GO
IF OBJECT_ID ('dbo.ca_tdividendo_virtual') IS NOT NULL
	DROP TABLE dbo.ca_tdividendo_virtual
GO
IF OBJECT_ID ('dbo.ca_tdividendo') IS NOT NULL
	DROP TABLE dbo.ca_tdividendo
GO
IF OBJECT_ID ('dbo.ca_tasas_pit') IS NOT NULL
	DROP TABLE dbo.ca_tasas_pit
GO
IF OBJECT_ID ('dbo.ca_tasas') IS NOT NULL
	DROP TABLE dbo.ca_tasas
GO
IF OBJECT_ID ('dbo.ca_tasa_valor_virtual') IS NOT NULL
	DROP TABLE dbo.ca_tasa_valor_virtual
GO
IF OBJECT_ID ('dbo.ca_tasa_SEGDEUVEN_tmp') IS NOT NULL
	DROP TABLE dbo.ca_tasa_SEGDEUVEN_tmp
GO
IF OBJECT_ID ('dbo.ca_tablas_un_rango') IS NOT NULL
	DROP TABLE dbo.ca_tablas_un_rango
GO
IF OBJECT_ID ('dbo.ca_tablas_dos_rangos') IS NOT NULL
	DROP TABLE dbo.ca_tablas_dos_rangos
GO
IF OBJECT_ID ('dbo.ca_tabla_reporte') IS NOT NULL
	DROP TABLE dbo.ca_tabla_reporte
GO
IF OBJECT_ID ('dbo.ca_tabla_flexible_control_ts') IS NOT NULL
	DROP TABLE dbo.ca_tabla_flexible_control_ts
GO
IF OBJECT_ID ('dbo.ca_tabla_flexible_control') IS NOT NULL
	DROP TABLE dbo.ca_tabla_flexible_control
GO
IF OBJECT_ID ('dbo.ca_tabla_arreglo_rev_2') IS NOT NULL
	DROP TABLE dbo.ca_tabla_arreglo_rev_2
GO
IF OBJECT_ID ('dbo.ca_tabla_arreglo_rev') IS NOT NULL
	DROP TABLE dbo.ca_tabla_arreglo_rev
GO
IF OBJECT_ID ('dbo.ca_tabla_arreglo_apl_2') IS NOT NULL
	DROP TABLE dbo.ca_tabla_arreglo_apl_2
GO
IF OBJECT_ID ('dbo.ca_tabla_arreglo_apl') IS NOT NULL
	DROP TABLE dbo.ca_tabla_arreglo_apl
GO
IF OBJECT_ID ('dbo.ca_suspenso_todos') IS NOT NULL
	DROP TABLE dbo.ca_suspenso_todos
GO
IF OBJECT_ID ('dbo.ca_suspenso_previo') IS NOT NULL
	DROP TABLE dbo.ca_suspenso_previo
GO
IF OBJECT_ID ('dbo.ca_suspenso') IS NOT NULL
	DROP TABLE dbo.ca_suspenso
GO
IF OBJECT_ID ('dbo.ca_subtipo_linea') IS NOT NULL
	DROP TABLE dbo.ca_subtipo_linea
GO
IF OBJECT_ID ('dbo.ca_sobrecausacion_mex') IS NOT NULL
	DROP TABLE dbo.ca_sobrecausacion_mex
GO
IF OBJECT_ID ('dbo.ca_sin_detalle_rej') IS NOT NULL
	DROP TABLE dbo.ca_sin_detalle_rej
GO
IF OBJECT_ID ('dbo.ca_sin_abono') IS NOT NULL
	DROP TABLE dbo.ca_sin_abono
GO
IF OBJECT_ID ('dbo.ca_simula_comp_err') IS NOT NULL
	DROP TABLE dbo.ca_simula_comp_err
GO
IF OBJECT_ID ('dbo.ca_simula_comp') IS NOT NULL
	DROP TABLE dbo.ca_simula_comp
GO
IF OBJECT_ID ('dbo.ca_sihc_noconso') IS NOT NULL
	DROP TABLE dbo.ca_sihc_noconso
GO
IF OBJECT_ID ('dbo.ca_siconso_nohc') IS NOT NULL
	DROP TABLE dbo.ca_siconso_nohc
GO
IF OBJECT_ID ('dbo.ca_serlefin') IS NOT NULL
	DROP TABLE dbo.ca_serlefin
GO
IF OBJECT_ID ('dbo.ca_seguros_tmp_990') IS NOT NULL
	DROP TABLE dbo.ca_seguros_tmp_990
GO
IF OBJECT_ID ('dbo.ca_seguros_opt3') IS NOT NULL
	DROP TABLE dbo.ca_seguros_opt3
GO
IF OBJECT_ID ('dbo.ca_seguros_his') IS NOT NULL
	DROP TABLE dbo.ca_seguros_his
GO
IF OBJECT_ID ('dbo.ca_seguros_det_tmp_990') IS NOT NULL
	DROP TABLE dbo.ca_seguros_det_tmp_990
GO
IF OBJECT_ID ('dbo.ca_seguros_det_opt3') IS NOT NULL
	DROP TABLE dbo.ca_seguros_det_opt3
GO
IF OBJECT_ID ('dbo.ca_seguros_det_his_CCA_409') IS NOT NULL
	DROP TABLE dbo.ca_seguros_det_his_CCA_409
GO
IF OBJECT_ID ('dbo.ca_seguros_det_his') IS NOT NULL
	DROP TABLE dbo.ca_seguros_det_his
GO
IF OBJECT_ID ('dbo.ca_seguros_det_CCA_409') IS NOT NULL
	DROP TABLE dbo.ca_seguros_det_CCA_409
GO
IF OBJECT_ID ('dbo.ca_seguros_det') IS NOT NULL
	DROP TABLE dbo.ca_seguros_det
GO
IF OBJECT_ID ('dbo.ca_seguros_cero') IS NOT NULL
	DROP TABLE dbo.ca_seguros_cero
GO
IF OBJECT_ID ('dbo.ca_seguros_can_his') IS NOT NULL
	DROP TABLE dbo.ca_seguros_can_his
GO
IF OBJECT_ID ('dbo.ca_seguros_can') IS NOT NULL
	DROP TABLE dbo.ca_seguros_can
GO
IF OBJECT_ID ('dbo.ca_seguros_base_garantia') IS NOT NULL
	DROP TABLE dbo.ca_seguros_base_garantia
GO
IF OBJECT_ID ('dbo.ca_seguros') IS NOT NULL
	DROP TABLE dbo.ca_seguros
GO
IF OBJECT_ID ('dbo.CA_SEGURO_TOTAL_OP') IS NOT NULL
	DROP TABLE dbo.CA_SEGURO_TOTAL_OP
GO
IF OBJECT_ID ('dbo.CA_SEGURO_DATA') IS NOT NULL
	DROP TABLE dbo.CA_SEGURO_DATA
GO
IF OBJECT_ID ('dbo.ca_seg_total_b') IS NOT NULL
	DROP TABLE dbo.ca_seg_total_b
GO
IF OBJECT_ID ('dbo.ca_seg_total_a') IS NOT NULL
	DROP TABLE dbo.ca_seg_total_a
GO
IF OBJECT_ID ('dbo.ca_seg_reporte_b') IS NOT NULL
	DROP TABLE dbo.ca_seg_reporte_b
GO
IF OBJECT_ID ('dbo.ca_seg_reporte_a') IS NOT NULL
	DROP TABLE dbo.ca_seg_reporte_a
GO
IF OBJECT_ID ('dbo.ca_secuenciales') IS NOT NULL
	DROP TABLE dbo.ca_secuenciales
GO
IF OBJECT_ID ('dbo.ca_secuencial_atx') IS NOT NULL
	DROP TABLE dbo.ca_secuencial_atx
GO
IF OBJECT_ID ('dbo.ca_secasunto') IS NOT NULL
	DROP TABLE dbo.ca_secasunto
GO
IF OBJECT_ID ('dbo.ca_saldosfag') IS NOT NULL
	DROP TABLE dbo.ca_saldosfag
GO
IF OBJECT_ID ('dbo.ca_saldos_x_toperacion') IS NOT NULL
	DROP TABLE dbo.ca_saldos_x_toperacion
GO
IF OBJECT_ID ('dbo.ca_saldos_rubros_tmp') IS NOT NULL
	DROP TABLE dbo.ca_saldos_rubros_tmp
GO
IF OBJECT_ID ('dbo.ca_saldos_op_renovar_tmp') IS NOT NULL
	DROP TABLE dbo.ca_saldos_op_renovar_tmp
GO
IF OBJECT_ID ('dbo.ca_saldos_mbs_tmp') IS NOT NULL
	DROP TABLE dbo.ca_saldos_mbs_tmp
GO
IF OBJECT_ID ('dbo.ca_saldos_fin_anio') IS NOT NULL
	DROP TABLE dbo.ca_saldos_fin_anio
GO
IF OBJECT_ID ('dbo.ca_saldos_contables_tmp') IS NOT NULL
	DROP TABLE dbo.ca_saldos_contables_tmp
GO
IF OBJECT_ID ('dbo.ca_saldos_cartera_rev') IS NOT NULL
	DROP TABLE dbo.ca_saldos_cartera_rev
GO
IF OBJECT_ID ('dbo.ca_saldos_cartera_mensual') IS NOT NULL
	DROP TABLE dbo.ca_saldos_cartera_mensual
GO
IF OBJECT_ID ('dbo.ca_saldos_cartera') IS NOT NULL
	DROP TABLE dbo.ca_saldos_cartera
GO
IF OBJECT_ID ('dbo.ca_saldo_operacion_tmp') IS NOT NULL
	DROP TABLE dbo.ca_saldo_operacion_tmp
GO
IF OBJECT_ID ('dbo.ca_rubros_recalculo') IS NOT NULL
	DROP TABLE dbo.ca_rubros_recalculo
GO
IF OBJECT_ID ('dbo.ca_rubros_correccion_tmp') IS NOT NULL
	DROP TABLE dbo.ca_rubros_correccion_tmp
GO
IF OBJECT_ID ('dbo.ca_rubro_ts') IS NOT NULL
	DROP TABLE dbo.ca_rubro_ts
GO
IF OBJECT_ID ('dbo.ca_rubro_planificador_ts') IS NOT NULL
	DROP TABLE dbo.ca_rubro_planificador_ts
GO
IF OBJECT_ID ('dbo.ca_rubro_planificador') IS NOT NULL
	DROP TABLE dbo.ca_rubro_planificador
GO
IF OBJECT_ID ('dbo.ca_rubro_op_virtual') IS NOT NULL
	DROP TABLE dbo.ca_rubro_op_virtual
GO
IF OBJECT_ID ('dbo.ca_rubro_op_ts') IS NOT NULL
	DROP TABLE dbo.ca_rubro_op_ts
GO
IF OBJECT_ID ('dbo.ca_rubro_op_tmp') IS NOT NULL
	DROP TABLE dbo.ca_rubro_op_tmp
GO
IF OBJECT_ID ('dbo.ca_rubro_op_ticket_0272553') IS NOT NULL
	DROP TABLE dbo.ca_rubro_op_ticket_0272553
GO
IF OBJECT_ID ('dbo.ca_rubro_op_ticket_0260499') IS NOT NULL
	DROP TABLE dbo.ca_rubro_op_ticket_0260499
GO
IF OBJECT_ID ('dbo.ca_rubro_op_ticket_0243726') IS NOT NULL
	DROP TABLE dbo.ca_rubro_op_ticket_0243726
GO
IF OBJECT_ID ('dbo.ca_rubro_op_resp') IS NOT NULL
	DROP TABLE dbo.ca_rubro_op_resp
GO
IF OBJECT_ID ('dbo.ca_rubro_op_reest') IS NOT NULL
	DROP TABLE dbo.ca_rubro_op_reest
GO
IF OBJECT_ID ('dbo.ca_rubro_op_ors_782') IS NOT NULL
	DROP TABLE dbo.ca_rubro_op_ors_782
GO
IF OBJECT_ID ('dbo.ca_rubro_op_hst_cca406') IS NOT NULL
	DROP TABLE dbo.ca_rubro_op_hst_cca406
GO
IF OBJECT_ID ('dbo.ca_rubro_op_his_ticket_0260499') IS NOT NULL
	DROP TABLE dbo.ca_rubro_op_his_ticket_0260499
GO
IF OBJECT_ID ('dbo.ca_rubro_op_his') IS NOT NULL
	DROP TABLE dbo.ca_rubro_op_his
GO
IF OBJECT_ID ('dbo.ca_rubro_op_cca406') IS NOT NULL
	DROP TABLE dbo.ca_rubro_op_cca406
GO
IF OBJECT_ID ('dbo.ca_rubro_op') IS NOT NULL
	DROP TABLE dbo.ca_rubro_op
GO
IF OBJECT_ID ('dbo.ca_rubro_normalizacion') IS NOT NULL
	DROP TABLE dbo.ca_rubro_normalizacion
GO
IF OBJECT_ID ('dbo.ca_rubro_norm_op') IS NOT NULL
	DROP TABLE dbo.ca_rubro_norm_op
GO
IF OBJECT_ID ('dbo.ca_rubro_int_tmp') IS NOT NULL
	DROP TABLE dbo.ca_rubro_int_tmp
GO
IF OBJECT_ID ('dbo.ca_rubro_imo_tmp') IS NOT NULL
	DROP TABLE dbo.ca_rubro_imo_tmp
GO
IF OBJECT_ID ('dbo.ca_rubro_colateral') IS NOT NULL
	DROP TABLE dbo.ca_rubro_colateral
GO
IF OBJECT_ID ('dbo.ca_rubro_col_op') IS NOT NULL
	DROP TABLE dbo.ca_rubro_col_op
GO
IF OBJECT_ID ('dbo.ca_rubro_cca406') IS NOT NULL
	DROP TABLE dbo.ca_rubro_cca406
GO
IF OBJECT_ID ('dbo.ca_rubro_cca_cre') IS NOT NULL
	DROP TABLE dbo.ca_rubro_cca_cre
GO
IF OBJECT_ID ('dbo.ca_rubro_CCA_409') IS NOT NULL
	DROP TABLE dbo.ca_rubro_CCA_409
GO
IF OBJECT_ID ('dbo.ca_rubro_calculado_tmp') IS NOT NULL
	DROP TABLE dbo.ca_rubro_calculado_tmp
GO
IF OBJECT_ID ('dbo.ca_rubro_bancamia') IS NOT NULL
	DROP TABLE dbo.ca_rubro_bancamia
GO
IF OBJECT_ID ('dbo.ca_rubro') IS NOT NULL
	DROP TABLE dbo.ca_rubro
GO
IF OBJECT_ID ('dbo.ca_rol_condona_ts') IS NOT NULL
	DROP TABLE dbo.ca_rol_condona_ts
GO
IF OBJECT_ID ('dbo.ca_rol_condona') IS NOT NULL
	DROP TABLE dbo.ca_rol_condona
GO
IF OBJECT_ID ('dbo.ca_rol_autoriza_condona_ts') IS NOT NULL
	DROP TABLE dbo.ca_rol_autoriza_condona_ts
GO
IF OBJECT_ID ('dbo.ca_rol_autoriza_condona') IS NOT NULL
	DROP TABLE dbo.ca_rol_autoriza_condona
GO
IF OBJECT_ID ('dbo.ca_revision_opt_tmp_oct_2015') IS NOT NULL
	DROP TABLE dbo.ca_revision_opt_tmp_oct_2015
GO
IF OBJECT_ID ('dbo.ca_revisa_prepagos_tmp') IS NOT NULL
	DROP TABLE dbo.ca_revisa_prepagos_tmp
GO
IF OBJECT_ID ('dbo.ca_revisa_pagos_tmp') IS NOT NULL
	DROP TABLE dbo.ca_revisa_pagos_tmp
GO
IF OBJECT_ID ('dbo.ca_revisa_cuota_can') IS NOT NULL
	DROP TABLE dbo.ca_revisa_cuota_can
GO
IF OBJECT_ID ('dbo.ca_revisa_boc') IS NOT NULL
	DROP TABLE dbo.ca_revisa_boc
GO
IF OBJECT_ID ('dbo.ca_revfv_masivos') IS NOT NULL
	DROP TABLE dbo.ca_revfv_masivos
GO
IF OBJECT_ID ('dbo.ca_reverso_masivo') IS NOT NULL
	DROP TABLE dbo.ca_reverso_masivo
GO
IF OBJECT_ID ('dbo.ca_resumen_tmp') IS NOT NULL
	DROP TABLE dbo.ca_resumen_tmp
GO
IF OBJECT_ID ('dbo.ca_resumen_renovaciones_pda2') IS NOT NULL
	DROP TABLE dbo.ca_resumen_renovaciones_pda2
GO
IF OBJECT_ID ('dbo.ca_resp_cl_parametro') IS NOT NULL
	DROP TABLE dbo.ca_resp_cl_parametro
GO
IF OBJECT_ID ('dbo.ca_resp_cb_tipo_area') IS NOT NULL
	DROP TABLE dbo.ca_resp_cb_tipo_area
GO
IF OBJECT_ID ('dbo.ca_resp_cb_relparam') IS NOT NULL
	DROP TABLE dbo.ca_resp_cb_relparam
GO
IF OBJECT_ID ('dbo.ca_resp_cb_perfil') IS NOT NULL
	DROP TABLE dbo.ca_resp_cb_perfil
GO
IF OBJECT_ID ('dbo.ca_resp_cb_parametro') IS NOT NULL
	DROP TABLE dbo.ca_resp_cb_parametro
GO
IF OBJECT_ID ('dbo.ca_resp_cb_det_perfil') IS NOT NULL
	DROP TABLE dbo.ca_resp_cb_det_perfil
GO
IF OBJECT_ID ('dbo.ca_resp_cb_codigo_valor') IS NOT NULL
	DROP TABLE dbo.ca_resp_cb_codigo_valor
GO
IF OBJECT_ID ('dbo.ca_resp_catalogo_tmp') IS NOT NULL
	DROP TABLE dbo.ca_resp_catalogo_tmp
GO
IF OBJECT_ID ('dbo.ca_resp_ba_sarta_batch') IS NOT NULL
	DROP TABLE dbo.ca_resp_ba_sarta_batch
GO
IF OBJECT_ID ('dbo.ca_resp_ba_sarta') IS NOT NULL
	DROP TABLE dbo.ca_resp_ba_sarta
GO
IF OBJECT_ID ('dbo.ca_resp_ba_parametro') IS NOT NULL
	DROP TABLE dbo.ca_resp_ba_parametro
GO
IF OBJECT_ID ('dbo.ca_resp_ba_batch') IS NOT NULL
	DROP TABLE dbo.ca_resp_ba_batch
GO
IF OBJECT_ID ('dbo.ca_RES_HISTORICOS_tmp') IS NOT NULL
	DROP TABLE dbo.ca_RES_HISTORICOS_tmp
GO
IF OBJECT_ID ('dbo.ca_reproceso_seg_tmp') IS NOT NULL
	DROP TABLE dbo.ca_reproceso_seg_tmp
GO
IF OBJECT_ID ('dbo.ca_reproceso_en_fecha_valor') IS NOT NULL
	DROP TABLE dbo.ca_reproceso_en_fecha_valor
GO
IF OBJECT_ID ('dbo.ca_reproceso_asociados') IS NOT NULL
	DROP TABLE dbo.ca_reproceso_asociados
GO
IF OBJECT_ID ('dbo.ca_reporte_temporal_cifras') IS NOT NULL
	DROP TABLE dbo.ca_reporte_temporal_cifras
GO
IF OBJECT_ID ('dbo.ca_reporte_temporal') IS NOT NULL
	DROP TABLE dbo.ca_reporte_temporal
GO
IF OBJECT_ID ('dbo.ca_reporte_tasas') IS NOT NULL
	DROP TABLE dbo.ca_reporte_tasas
GO
IF OBJECT_ID ('dbo.ca_reporte_reest') IS NOT NULL
	DROP TABLE dbo.ca_reporte_reest
GO
IF OBJECT_ID ('dbo.ca_reporte_punteo') IS NOT NULL
	DROP TABLE dbo.ca_reporte_punteo
GO
IF OBJECT_ID ('dbo.ca_reporte_oper_AHO') IS NOT NULL
	DROP TABLE dbo.ca_reporte_oper_AHO
GO
IF OBJECT_ID ('dbo.ca_reporte_datpas_det') IS NOT NULL
	DROP TABLE dbo.ca_reporte_datpas_det
GO
IF OBJECT_ID ('dbo.ca_reporte_datpas_cab') IS NOT NULL
	DROP TABLE dbo.ca_reporte_datpas_cab
GO
IF OBJECT_ID ('dbo.ca_reporte_datope_det') IS NOT NULL
	DROP TABLE dbo.ca_reporte_datope_det
GO
IF OBJECT_ID ('dbo.ca_reporte_datope_cab') IS NOT NULL
	DROP TABLE dbo.ca_reporte_datope_cab
GO
IF OBJECT_ID ('dbo.ca_reporte_cobranza') IS NOT NULL
	DROP TABLE dbo.ca_reporte_cobranza
GO
IF OBJECT_ID ('dbo.ca_reportar_cliente') IS NOT NULL
	DROP TABLE dbo.ca_reportar_cliente
GO
IF OBJECT_ID ('dbo.ca_repetidos') IS NOT NULL
	DROP TABLE dbo.ca_repetidos
GO
IF OBJECT_ID ('dbo.ca_rep_usaid') IS NOT NULL
	DROP TABLE dbo.ca_rep_usaid
GO
IF OBJECT_ID ('dbo.ca_rep_planif_mensual') IS NOT NULL
	DROP TABLE dbo.ca_rep_planif_mensual
GO
IF OBJECT_ID ('dbo.ca_rep_planif_diario') IS NOT NULL
	DROP TABLE dbo.ca_rep_planif_diario
GO
IF OBJECT_ID ('dbo.ca_rep_pagos_reest') IS NOT NULL
	DROP TABLE dbo.ca_rep_pagos_reest
GO
IF OBJECT_ID ('dbo.ca_rep_coloca_fondos') IS NOT NULL
	DROP TABLE dbo.ca_rep_coloca_fondos
GO
IF OBJECT_ID ('dbo.ca_rep_70') IS NOT NULL
	DROP TABLE dbo.ca_rep_70
GO
IF OBJECT_ID ('dbo.ca_ren_autorizada') IS NOT NULL
	DROP TABLE dbo.ca_ren_autorizada
GO
IF OBJECT_ID ('dbo.ca_reloj') IS NOT NULL
	DROP TABLE dbo.ca_reloj
GO
IF OBJECT_ID ('dbo.ca_relacion_ptmo_ts') IS NOT NULL
	DROP TABLE dbo.ca_relacion_ptmo_ts
GO
IF OBJECT_ID ('dbo.ca_relacion_ptmo_tmp') IS NOT NULL
	DROP TABLE dbo.ca_relacion_ptmo_tmp
GO
IF OBJECT_ID ('dbo.ca_relacion_ptmo_pago_temp') IS NOT NULL
	DROP TABLE dbo.ca_relacion_ptmo_pago_temp
GO
IF OBJECT_ID ('dbo.ca_relacion_ptmo_his') IS NOT NULL
	DROP TABLE dbo.ca_relacion_ptmo_his
GO
IF OBJECT_ID ('dbo.ca_relacion_ptmo') IS NOT NULL
	DROP TABLE dbo.ca_relacion_ptmo
GO
IF OBJECT_ID ('dbo.ca_registros_borrados') IS NOT NULL
	DROP TABLE dbo.ca_registros_borrados
GO
IF OBJECT_ID ('dbo.ca_reg_eliminado_his') IS NOT NULL
	DROP TABLE dbo.ca_reg_eliminado_his
GO
IF OBJECT_ID ('dbo.ca_recuperacion_cobranza') IS NOT NULL
	DROP TABLE dbo.ca_recuperacion_cobranza
GO
IF OBJECT_ID ('dbo.ca_recfng_mas') IS NOT NULL
	DROP TABLE dbo.ca_recfng_mas
GO
IF OBJECT_ID ('dbo.ca_recaudos_masivos_tmp2') IS NOT NULL
	DROP TABLE dbo.ca_recaudos_masivos_tmp2
GO
IF OBJECT_ID ('dbo.ca_recaudos_masivos_tmp1') IS NOT NULL
	DROP TABLE dbo.ca_recaudos_masivos_tmp1
GO
IF OBJECT_ID ('dbo.ca_recalseg_insoluto') IS NOT NULL
	DROP TABLE dbo.ca_recalseg_insoluto
GO
IF OBJECT_ID ('dbo.ca_recalculo_mipymes_datosII') IS NOT NULL
	DROP TABLE dbo.ca_recalculo_mipymes_datosII
GO
IF OBJECT_ID ('dbo.ca_recalculo_mipymes_datos_III') IS NOT NULL
	DROP TABLE dbo.ca_recalculo_mipymes_datos_III
GO
IF OBJECT_ID ('dbo.ca_recalculo_mipymes_datos_369') IS NOT NULL
	DROP TABLE dbo.ca_recalculo_mipymes_datos_369
GO
IF OBJECT_ID ('dbo.ca_recalculo_mipymes_datos') IS NOT NULL
	DROP TABLE dbo.ca_recalculo_mipymes_datos
GO
IF OBJECT_ID ('dbo.ca_recalcular_cuota_vig') IS NOT NULL
	DROP TABLE dbo.ca_recalcular_cuota_vig
GO
IF OBJECT_ID ('dbo.ca_rec_pagos_recib') IS NOT NULL
	DROP TABLE dbo.ca_rec_pagos_recib
GO
IF OBJECT_ID ('dbo.ca_reajuste_ts') IS NOT NULL
	DROP TABLE dbo.ca_reajuste_ts
GO
IF OBJECT_ID ('dbo.ca_reajuste_tmp') IS NOT NULL
	DROP TABLE dbo.ca_reajuste_tmp
GO
IF OBJECT_ID ('dbo.ca_reajuste_ticket_0272553') IS NOT NULL
	DROP TABLE dbo.ca_reajuste_ticket_0272553
GO
IF OBJECT_ID ('dbo.ca_reajuste_ticket_0267280') IS NOT NULL
	DROP TABLE dbo.ca_reajuste_ticket_0267280
GO
IF OBJECT_ID ('dbo.ca_reajuste_ticket_0260499') IS NOT NULL
	DROP TABLE dbo.ca_reajuste_ticket_0260499
GO
IF OBJECT_ID ('dbo.ca_reajuste_ors_1273') IS NOT NULL
	DROP TABLE dbo.ca_reajuste_ors_1273
GO
IF OBJECT_ID ('dbo.ca_reajuste_ors_1270') IS NOT NULL
	DROP TABLE dbo.ca_reajuste_ors_1270
GO
IF OBJECT_ID ('dbo.ca_reajuste_ors_1235') IS NOT NULL
	DROP TABLE dbo.ca_reajuste_ors_1235
GO
IF OBJECT_ID ('dbo.ca_reajuste_op7103989') IS NOT NULL
	DROP TABLE dbo.ca_reajuste_op7103989
GO
IF OBJECT_ID ('dbo.ca_reajuste_det_ts') IS NOT NULL
	DROP TABLE dbo.ca_reajuste_det_ts
GO
IF OBJECT_ID ('dbo.ca_reajuste_det_tmp') IS NOT NULL
	DROP TABLE dbo.ca_reajuste_det_tmp
GO
IF OBJECT_ID ('dbo.ca_reajuste_det_ticket_0272553') IS NOT NULL
	DROP TABLE dbo.ca_reajuste_det_ticket_0272553
GO
IF OBJECT_ID ('dbo.ca_reajuste_det_ticket_0267280') IS NOT NULL
	DROP TABLE dbo.ca_reajuste_det_ticket_0267280
GO
IF OBJECT_ID ('dbo.ca_reajuste_det_ors_1273') IS NOT NULL
	DROP TABLE dbo.ca_reajuste_det_ors_1273
GO
IF OBJECT_ID ('dbo.ca_reajuste_det_ors_1270') IS NOT NULL
	DROP TABLE dbo.ca_reajuste_det_ors_1270
GO
IF OBJECT_ID ('dbo.ca_reajuste_det_ors_1235') IS NOT NULL
	DROP TABLE dbo.ca_reajuste_det_ors_1235
GO
IF OBJECT_ID ('dbo.ca_reajuste_det') IS NOT NULL
	DROP TABLE dbo.ca_reajuste_det
GO
IF OBJECT_ID ('dbo.ca_reajuste') IS NOT NULL
	DROP TABLE dbo.ca_reajuste
GO
IF OBJECT_ID ('dbo.ca_query_clientes_Plano') IS NOT NULL
	DROP TABLE dbo.ca_query_clientes_Plano
GO
IF OBJECT_ID ('dbo.ca_prueba') IS NOT NULL
	DROP TABLE dbo.ca_prueba
GO
IF OBJECT_ID ('dbo.ca_proyeccion_recuperacion') IS NOT NULL
	DROP TABLE dbo.ca_proyeccion_recuperacion
GO
IF OBJECT_ID ('dbo.ca_proyeccion_caja') IS NOT NULL
	DROP TABLE dbo.ca_proyeccion_caja
GO
IF OBJECT_ID ('dbo.ca_prorroga_ts') IS NOT NULL
	DROP TABLE dbo.ca_prorroga_ts
GO
IF OBJECT_ID ('dbo.ca_prorroga') IS NOT NULL
	DROP TABLE dbo.ca_prorroga
GO
IF OBJECT_ID ('dbo.ca_producto_ts') IS NOT NULL
	DROP TABLE dbo.ca_producto_ts
GO
IF OBJECT_ID ('dbo.ca_producto_respaldo') IS NOT NULL
	DROP TABLE dbo.ca_producto_respaldo
GO
IF OBJECT_ID ('dbo.ca_producto_bancamia') IS NOT NULL
	DROP TABLE dbo.ca_producto_bancamia
GO
IF OBJECT_ID ('dbo.ca_producto_397') IS NOT NULL
	DROP TABLE dbo.ca_producto_397
GO
IF OBJECT_ID ('dbo.ca_producto') IS NOT NULL
	DROP TABLE dbo.ca_producto
GO
IF OBJECT_ID ('dbo.ca_procesos_pagos_tmp') IS NOT NULL
	DROP TABLE dbo.ca_procesos_pagos_tmp
GO
IF OBJECT_ID ('dbo.ca_procesos_maestro_tmp') IS NOT NULL
	DROP TABLE dbo.ca_procesos_maestro_tmp
GO
IF OBJECT_ID ('dbo.ca_procesos_contacar_tmp') IS NOT NULL
	DROP TABLE dbo.ca_procesos_contacar_tmp
GO
IF OBJECT_ID ('dbo.ca_procesos_consolidador_tmp') IS NOT NULL
	DROP TABLE dbo.ca_procesos_consolidador_tmp
GO
IF OBJECT_ID ('dbo.ca_procesos_buserror_tmp') IS NOT NULL
	DROP TABLE dbo.ca_procesos_buserror_tmp
GO
IF OBJECT_ID ('dbo.ca_procesos_batch_tmp') IS NOT NULL
	DROP TABLE dbo.ca_procesos_batch_tmp
GO
IF OBJECT_ID ('dbo.ca_procesos_atx_tmp') IS NOT NULL
	DROP TABLE dbo.ca_procesos_atx_tmp
GO
IF OBJECT_ID ('dbo.ca_procesar') IS NOT NULL
	DROP TABLE dbo.ca_procesar
GO
IF OBJECT_ID ('dbo.ca_proc_cam_linea_finagro_copy') IS NOT NULL
	DROP TABLE dbo.ca_proc_cam_linea_finagro_copy
GO
IF OBJECT_ID ('dbo.ca_proc_cam_linea_finagro') IS NOT NULL
	DROP TABLE dbo.ca_proc_cam_linea_finagro
GO
IF OBJECT_ID ('dbo.ca_prestamo_pagos_tmp') IS NOT NULL
	DROP TABLE dbo.ca_prestamo_pagos_tmp
GO
IF OBJECT_ID ('dbo.ca_prepas_dobles') IS NOT NULL
	DROP TABLE dbo.ca_prepas_dobles
GO
IF OBJECT_ID ('dbo.ca_prepagos_por_reversos') IS NOT NULL
	DROP TABLE dbo.ca_prepagos_por_reversos
GO
IF OBJECT_ID ('dbo.ca_prepagos_pasivas') IS NOT NULL
	DROP TABLE dbo.ca_prepagos_pasivas
GO
IF OBJECT_ID ('dbo.ca_pproducto_bf') IS NOT NULL
	DROP TABLE dbo.ca_pproducto_bf
GO
IF OBJECT_ID ('dbo.ca_pprepgospas_aplicados') IS NOT NULL
	DROP TABLE dbo.ca_pprepgospas_aplicados
GO
IF OBJECT_ID ('dbo.ca_porsegur_990') IS NOT NULL
	DROP TABLE dbo.ca_porsegur_990
GO
IF OBJECT_ID ('dbo.ca_planos_baloto') IS NOT NULL
	DROP TABLE dbo.ca_planos_baloto
GO
IF OBJECT_ID ('dbo.ca_planoBancoldexJustifica_33') IS NOT NULL
	DROP TABLE dbo.ca_planoBancoldexJustifica_33
GO
IF OBJECT_ID ('dbo.ca_planoBancoldexJustifica') IS NOT NULL
	DROP TABLE dbo.ca_planoBancoldexJustifica
GO
IF OBJECT_ID ('dbo.ca_planobancoldex') IS NOT NULL
	DROP TABLE dbo.ca_planobancoldex
GO
IF OBJECT_ID ('dbo.ca_plano_pagos_extras_tmp') IS NOT NULL
	DROP TABLE dbo.ca_plano_pagos_extras_tmp
GO
IF OBJECT_ID ('dbo.ca_plano_ors_959_msg_texto') IS NOT NULL
	DROP TABLE dbo.ca_plano_ors_959_msg_texto
GO
IF OBJECT_ID ('dbo.ca_plano_ors_959_cabecera') IS NOT NULL
	DROP TABLE dbo.ca_plano_ors_959_cabecera
GO
IF OBJECT_ID ('dbo.ca_plano_mensual') IS NOT NULL
	DROP TABLE dbo.ca_plano_mensual
GO
IF OBJECT_ID ('dbo.ca_plano_masivo_pagos') IS NOT NULL
	DROP TABLE dbo.ca_plano_masivo_pagos
GO
IF OBJECT_ID ('dbo.ca_plano_dia_findeter') IS NOT NULL
	DROP TABLE dbo.ca_plano_dia_findeter
GO
IF OBJECT_ID ('dbo.ca_plano_dia_bancoldex') IS NOT NULL
	DROP TABLE dbo.ca_plano_dia_bancoldex
GO
IF OBJECT_ID ('dbo.ca_plano_cancelads_x_ofi') IS NOT NULL
	DROP TABLE dbo.ca_plano_cancelads_x_ofi
GO
IF OBJECT_ID ('dbo.ca_plano_banco_segundo_piso') IS NOT NULL
	DROP TABLE dbo.ca_plano_banco_segundo_piso
GO
IF OBJECT_ID ('dbo.ca_plano_banco_2piso_his') IS NOT NULL
	DROP TABLE dbo.ca_plano_banco_2piso_his
GO
IF OBJECT_ID ('dbo.ca_peso_colaterales') IS NOT NULL
	DROP TABLE dbo.ca_peso_colaterales
GO
IF OBJECT_ID ('dbo.ca_path_adminfo') IS NOT NULL
	DROP TABLE dbo.ca_path_adminfo
GO
IF OBJECT_ID ('dbo.ca_pasivas_cobro_juridico') IS NOT NULL
	DROP TABLE dbo.ca_pasivas_cobro_juridico
GO
IF OBJECT_ID ('dbo.ca_param_hon') IS NOT NULL
	DROP TABLE dbo.ca_param_hon
GO
IF OBJECT_ID ('dbo.ca_param_condona_ts') IS NOT NULL
	DROP TABLE dbo.ca_param_condona_ts
GO
IF OBJECT_ID ('dbo.ca_param_condona_control') IS NOT NULL
	DROP TABLE dbo.ca_param_condona_control
GO
IF OBJECT_ID ('dbo.ca_param_condona') IS NOT NULL
	DROP TABLE dbo.ca_param_condona
GO
IF OBJECT_ID ('dbo.ca_paralelo_tmp') IS NOT NULL
	DROP TABLE dbo.ca_paralelo_tmp
GO
IF OBJECT_ID ('dbo.ca_pagosca_v_tmp_bcp') IS NOT NULL
	DROP TABLE dbo.ca_pagosca_v_tmp_bcp
GO
IF OBJECT_ID ('dbo.ca_pagosca_v_tmp') IS NOT NULL
	DROP TABLE dbo.ca_pagosca_v_tmp
GO
IF OBJECT_ID ('dbo.ca_pagosca_h_tmp_bcp') IS NOT NULL
	DROP TABLE dbo.ca_pagosca_h_tmp_bcp
GO
IF OBJECT_ID ('dbo.ca_pagosca_h_tmp') IS NOT NULL
	DROP TABLE dbo.ca_pagosca_h_tmp
GO
IF OBJECT_ID ('dbo.ca_pagos_valor_presente') IS NOT NULL
	DROP TABLE dbo.ca_pagos_valor_presente
GO
IF OBJECT_ID ('dbo.ca_pagos_tmp3') IS NOT NULL
	DROP TABLE dbo.ca_pagos_tmp3
GO
IF OBJECT_ID ('dbo.ca_pagos_tmp1') IS NOT NULL
	DROP TABLE dbo.ca_pagos_tmp1
GO
IF OBJECT_ID ('dbo.ca_pagos_tmp_total') IS NOT NULL
	DROP TABLE dbo.ca_pagos_tmp_total
GO
IF OBJECT_ID ('dbo.ca_pagos_tmp') IS NOT NULL
	DROP TABLE dbo.ca_pagos_tmp
GO
IF OBJECT_ID ('dbo.ca_pagos_sicredito') IS NOT NULL
	DROP TABLE dbo.ca_pagos_sicredito
GO
IF OBJECT_ID ('dbo.ca_pagos_saldos_minimos_tmp') IS NOT NULL
	DROP TABLE dbo.ca_pagos_saldos_minimos_tmp
GO
IF OBJECT_ID ('dbo.ca_pagos_reversar') IS NOT NULL
	DROP TABLE dbo.ca_pagos_reversar
GO
IF OBJECT_ID ('dbo.ca_pagos_procredito') IS NOT NULL
	DROP TABLE dbo.ca_pagos_procredito
GO
IF OBJECT_ID ('dbo.ca_pagos_mig') IS NOT NULL
	DROP TABLE dbo.ca_pagos_mig
GO
IF OBJECT_ID ('dbo.ca_pagos_ing_eventual') IS NOT NULL
	DROP TABLE dbo.ca_pagos_ing_eventual
GO
IF OBJECT_ID ('dbo.ca_pagos_fng') IS NOT NULL
	DROP TABLE dbo.ca_pagos_fng
GO
IF OBJECT_ID ('dbo.ca_pagos_defecto') IS NOT NULL
	DROP TABLE dbo.ca_pagos_defecto
GO
IF OBJECT_ID ('dbo.ca_pagos_caja_mbs') IS NOT NULL
	DROP TABLE dbo.ca_pagos_caja_mbs
GO
IF OBJECT_ID ('dbo.ca_pagos_caja') IS NOT NULL
	DROP TABLE dbo.ca_pagos_caja
GO
IF OBJECT_ID ('dbo.ca_pago_recono_INC_225717') IS NOT NULL
	DROP TABLE dbo.ca_pago_recono_INC_225717
GO
IF OBJECT_ID ('dbo.ca_pago_recono_424') IS NOT NULL
	DROP TABLE dbo.ca_pago_recono_424
GO
IF OBJECT_ID ('dbo.ca_pago_recono') IS NOT NULL
	DROP TABLE dbo.ca_pago_recono
GO
IF OBJECT_ID ('dbo.ca_pago_prioridad_tmp') IS NOT NULL
	DROP TABLE dbo.ca_pago_prioridad_tmp
GO
IF OBJECT_ID ('dbo.ca_pago_planificador_ts') IS NOT NULL
	DROP TABLE dbo.ca_pago_planificador_ts
GO
IF OBJECT_ID ('dbo.ca_pago_planificador_tmp') IS NOT NULL
	DROP TABLE dbo.ca_pago_planificador_tmp
GO
IF OBJECT_ID ('dbo.ca_pago_planificador') IS NOT NULL
	DROP TABLE dbo.ca_pago_planificador
GO
IF OBJECT_ID ('dbo.ca_paginac') IS NOT NULL
	DROP TABLE dbo.ca_paginac
GO
IF OBJECT_ID ('dbo.ca_pagapli_tmp') IS NOT NULL
	DROP TABLE dbo.ca_pagapli_tmp
GO
IF OBJECT_ID ('dbo.ca_pag_masivos_temp') IS NOT NULL
	DROP TABLE dbo.ca_pag_masivos_temp
GO
IF OBJECT_ID ('dbo.ca_otro_cargo') IS NOT NULL
	DROP TABLE dbo.ca_otro_cargo
GO
IF OBJECT_ID ('dbo.ca_otras_tasas_ts') IS NOT NULL
	DROP TABLE dbo.ca_otras_tasas_ts
GO
IF OBJECT_ID ('dbo.ca_otras_tasas') IS NOT NULL
	DROP TABLE dbo.ca_otras_tasas
GO
IF OBJECT_ID ('dbo.ca_ors_782_valores_pagar') IS NOT NULL
	DROP TABLE dbo.ca_ors_782_valores_pagar
GO
IF OBJECT_ID ('dbo.ca_ors_782_segdeuven_hst') IS NOT NULL
	DROP TABLE dbo.ca_ors_782_segdeuven_hst
GO
IF OBJECT_ID ('dbo.ca_ors_782_segdeuven') IS NOT NULL
	DROP TABLE dbo.ca_ors_782_segdeuven
GO
IF OBJECT_ID ('dbo.ca_opraciones_BLOQUE') IS NOT NULL
	DROP TABLE dbo.ca_opraciones_BLOQUE
GO
IF OBJECT_ID ('dbo.ca_opercaion_ndaut') IS NOT NULL
	DROP TABLE dbo.ca_opercaion_ndaut
GO
IF OBJECT_ID ('dbo.ca_operaciones_con_recono_tmp') IS NOT NULL
	DROP TABLE dbo.ca_operaciones_con_recono_tmp
GO
IF OBJECT_ID ('dbo.ca_operaciones_borr') IS NOT NULL
	DROP TABLE dbo.ca_operaciones_borr
GO
IF OBJECT_ID ('dbo.ca_operacion_virtual') IS NOT NULL
	DROP TABLE dbo.ca_operacion_virtual
GO
IF OBJECT_ID ('dbo.ca_operacion_ts') IS NOT NULL
	DROP TABLE dbo.ca_operacion_ts
GO
IF OBJECT_ID ('dbo.ca_operacion_total_ifj') IS NOT NULL
	DROP TABLE dbo.ca_operacion_total_ifj
GO
IF OBJECT_ID ('dbo.ca_operacion_total') IS NOT NULL
	DROP TABLE dbo.ca_operacion_total
GO
IF OBJECT_ID ('dbo.ca_operacion_tmp') IS NOT NULL
	DROP TABLE dbo.ca_operacion_tmp
GO

IF OBJECT_ID ('dbo.ca_operacion_timbre') IS NOT NULL
	DROP TABLE dbo.ca_operacion_timbre
GO
IF OBJECT_ID ('dbo.ca_operacion_resp') IS NOT NULL
	DROP TABLE dbo.ca_operacion_resp
GO
IF OBJECT_ID ('dbo.ca_operacion_ors_1256') IS NOT NULL
	DROP TABLE dbo.ca_operacion_ors_1256
GO
IF OBJECT_ID ('dbo.ca_operacion_mig') IS NOT NULL
	DROP TABLE dbo.ca_operacion_mig
GO
IF OBJECT_ID ('dbo.ca_operacion_his_INC_274790') IS NOT NULL
	DROP TABLE dbo.ca_operacion_his_INC_274790
GO
IF OBJECT_ID ('dbo.ca_operacion_his') IS NOT NULL
	DROP TABLE dbo.ca_operacion_his
GO
IF OBJECT_ID ('dbo.ca_operacion_hc') IS NOT NULL
	DROP TABLE dbo.ca_operacion_hc
GO
IF OBJECT_ID ('dbo.ca_operacion_control') IS NOT NULL
	DROP TABLE dbo.ca_operacion_control
GO
IF OBJECT_ID ('dbo.ca_operacion_bancamia_tmp') IS NOT NULL
	DROP TABLE dbo.ca_operacion_bancamia_tmp
GO
IF OBJECT_ID ('dbo.ca_operacion_bancamia') IS NOT NULL
	DROP TABLE dbo.ca_operacion_bancamia
GO
IF OBJECT_ID ('dbo.ca_operacion_alterna_resp') IS NOT NULL
	DROP TABLE dbo.ca_operacion_alterna_resp
GO
IF OBJECT_ID ('dbo.ca_operacion_alterna') IS NOT NULL
	DROP TABLE dbo.ca_operacion_alterna
GO
IF OBJECT_ID ('dbo.ca_operacion_act') IS NOT NULL
	DROP TABLE dbo.ca_operacion_act
GO
IF OBJECT_ID ('dbo.ca_operacion') IS NOT NULL
	DROP TABLE dbo.ca_operacion
GO
IF OBJECT_ID ('dbo.ca_opera_finagro_temp') IS NOT NULL
	DROP TABLE dbo.ca_opera_finagro_temp
GO
IF OBJECT_ID ('dbo.ca_opera_finagro_INC_262565') IS NOT NULL
	DROP TABLE dbo.ca_opera_finagro_INC_262565
GO
IF OBJECT_ID ('dbo.ca_opera_finagro_inc_0267922') IS NOT NULL
	DROP TABLE dbo.ca_opera_finagro_inc_0267922
GO
IF OBJECT_ID ('dbo.ca_opera_finagro') IS NOT NULL
	DROP TABLE dbo.ca_opera_finagro
GO
IF OBJECT_ID ('dbo.ca_oper_universo_tmp') IS NOT NULL
	DROP TABLE dbo.ca_oper_universo_tmp
GO
IF OBJECT_ID ('dbo.ca_oper_resvisiones_tasa_RES') IS NOT NULL
	DROP TABLE dbo.ca_oper_resvisiones_tasa_RES
GO
IF OBJECT_ID ('dbo.ca_Oper_RES_olaInver_tmp') IS NOT NULL
	DROP TABLE dbo.ca_Oper_RES_olaInver_tmp
GO
IF OBJECT_ID ('dbo.ca_Oper_MIPYMES_log') IS NOT NULL
	DROP TABLE dbo.ca_Oper_MIPYMES_log
GO
IF OBJECT_ID ('dbo.ca_oper_cambio_linea_FINAGRO') IS NOT NULL
	DROP TABLE dbo.ca_oper_cambio_linea_FINAGRO
GO
IF OBJECT_ID ('dbo.ca_opcobis_nobancoldex') IS NOT NULL
	DROP TABLE dbo.ca_opcobis_nobancoldex
GO
IF OBJECT_ID ('dbo.ca_op_reestr_tmp') IS NOT NULL
	DROP TABLE dbo.ca_op_reestr_tmp
GO
IF OBJECT_ID ('dbo.ca_op_reest_padre_hija') IS NOT NULL
	DROP TABLE dbo.ca_op_reest_padre_hija
GO
IF OBJECT_ID ('dbo.ca_op_pasivas_ven') IS NOT NULL
	DROP TABLE dbo.ca_op_pasivas_ven
GO
IF OBJECT_ID ('dbo.ca_op_fecha') IS NOT NULL
	DROP TABLE dbo.ca_op_fecha
GO
IF OBJECT_ID ('dbo.ca_op_cobranza_jud_tmp') IS NOT NULL
	DROP TABLE dbo.ca_op_cobranza_jud_tmp
GO
IF OBJECT_ID ('dbo.ca_op_cobranza_jud') IS NOT NULL
	DROP TABLE dbo.ca_op_cobranza_jud
GO
IF OBJECT_ID ('dbo.ca_op_cobranza_cas') IS NOT NULL
	DROP TABLE dbo.ca_op_cobranza_cas
GO
IF OBJECT_ID ('dbo.ca_op_cobranza') IS NOT NULL
	DROP TABLE dbo.ca_op_cobranza
GO
IF OBJECT_ID ('dbo.ca_op_adelantadas_reversadas') IS NOT NULL
	DROP TABLE dbo.ca_op_adelantadas_reversadas
GO
IF OBJECT_ID ('dbo.ca_op_adelantadas') IS NOT NULL
	DROP TABLE dbo.ca_op_adelantadas
GO
IF OBJECT_ID ('dbo.ca_normalizacion') IS NOT NULL
	DROP TABLE dbo.ca_normalizacion
GO
IF OBJECT_ID ('dbo.ca_nomina_tmp') IS NOT NULL
	DROP TABLE dbo.ca_nomina_tmp
GO
IF OBJECT_ID ('dbo.ca_nomina') IS NOT NULL
	DROP TABLE dbo.ca_nomina
GO
IF OBJECT_ID ('dbo.ca_nexisten_finagro') IS NOT NULL
	DROP TABLE dbo.ca_nexisten_finagro
GO
IF OBJECT_ID ('dbo.ca_nexisten_cobis') IS NOT NULL
	DROP TABLE dbo.ca_nexisten_cobis
GO
IF OBJECT_ID ('dbo.ca_msv_proc') IS NOT NULL
	DROP TABLE dbo.ca_msv_proc
GO
IF OBJECT_ID ('dbo.ca_monitor_1') IS NOT NULL
	DROP TABLE dbo.ca_monitor_1
GO
IF OBJECT_ID ('dbo.ca_migra_lin_tmp') IS NOT NULL
	DROP TABLE dbo.ca_migra_lin_tmp
GO
IF OBJECT_ID ('dbo.ca_migra_dest_tmp') IS NOT NULL
	DROP TABLE dbo.ca_migra_dest_tmp
GO
IF OBJECT_ID ('dbo.ca_micro_correccion') IS NOT NULL
	DROP TABLE dbo.ca_micro_correccion
GO
IF OBJECT_ID ('dbo.ca_micro') IS NOT NULL
	DROP TABLE dbo.ca_micro
GO
IF OBJECT_ID ('dbo.ca_mesacambio_temp') IS NOT NULL
	DROP TABLE dbo.ca_mesacambio_temp
GO
IF OBJECT_ID ('dbo.ca_mensaje_facturacion') IS NOT NULL
	DROP TABLE dbo.ca_mensaje_facturacion
GO
IF OBJECT_ID ('dbo.ca_matriz_valor_ts') IS NOT NULL
	DROP TABLE dbo.ca_matriz_valor_ts
GO
IF OBJECT_ID ('dbo.ca_matriz_valor_tmp') IS NOT NULL
	DROP TABLE dbo.ca_matriz_valor_tmp
GO
IF OBJECT_ID ('dbo.ca_matriz_valor_Req499') IS NOT NULL
	DROP TABLE dbo.ca_matriz_valor_Req499
GO
IF OBJECT_ID ('dbo.ca_matriz_valor_943') IS NOT NULL
	DROP TABLE dbo.ca_matriz_valor_943
GO
IF OBJECT_ID ('dbo.ca_matriz_valor_1127') IS NOT NULL
	DROP TABLE dbo.ca_matriz_valor_1127
GO
IF OBJECT_ID ('dbo.ca_matriz_valor_1014') IS NOT NULL
	DROP TABLE dbo.ca_matriz_valor_1014
GO
IF OBJECT_ID ('dbo.ca_matriz_valor_1003') IS NOT NULL
	DROP TABLE dbo.ca_matriz_valor_1003
GO
IF OBJECT_ID ('dbo.ca_matriz_valor') IS NOT NULL
	DROP TABLE dbo.ca_matriz_valor
GO
IF OBJECT_ID ('dbo.ca_matriz_tmp') IS NOT NULL
	DROP TABLE dbo.ca_matriz_tmp
GO
IF OBJECT_ID ('dbo.ca_matriz_Req499') IS NOT NULL
	DROP TABLE dbo.ca_matriz_Req499
GO
IF OBJECT_ID ('dbo.ca_matriz_plano') IS NOT NULL
	DROP TABLE dbo.ca_matriz_plano
GO
IF OBJECT_ID ('dbo.ca_matriz_consultaD_tmp') IS NOT NULL
	DROP TABLE dbo.ca_matriz_consultaD_tmp
GO
IF OBJECT_ID ('dbo.ca_matriz_consulta_tmp') IS NOT NULL
	DROP TABLE dbo.ca_matriz_consulta_tmp
GO
IF OBJECT_ID ('dbo.ca_matriz') IS NOT NULL
	DROP TABLE dbo.ca_matriz
GO
IF OBJECT_ID ('dbo.ca_marcarPor_ola_invernal_tmp') IS NOT NULL
	DROP TABLE dbo.ca_marcarPor_ola_invernal_tmp
GO
IF OBJECT_ID ('dbo.ca_marcarPor_ola_invernal_his') IS NOT NULL
	DROP TABLE dbo.ca_marcarPor_ola_invernal_his
GO
IF OBJECT_ID ('dbo.ca_maestro_operaciones_tmp') IS NOT NULL
	DROP TABLE dbo.ca_maestro_operaciones_tmp
GO
IF OBJECT_ID ('dbo.ca_maestro_operaciones_mig') IS NOT NULL
	DROP TABLE dbo.ca_maestro_operaciones_mig
GO
IF OBJECT_ID ('dbo.ca_maestro_operaciones') IS NOT NULL
	DROP TABLE dbo.ca_maestro_operaciones
GO
IF OBJECT_ID ('dbo.ca_maestro_especial') IS NOT NULL
	DROP TABLE dbo.ca_maestro_especial
GO
IF OBJECT_ID ('dbo.ca_maestro_cartera') IS NOT NULL
	DROP TABLE dbo.ca_maestro_cartera
GO
IF OBJECT_ID ('dbo.ca_log_fecha_valor') IS NOT NULL
	DROP TABLE dbo.ca_log_fecha_valor
GO
IF OBJECT_ID ('dbo.ca_llave_redescuento') IS NOT NULL
	DROP TABLE dbo.ca_llave_redescuento
GO
IF OBJECT_ID ('dbo.ca_llave_finagro') IS NOT NULL
	DROP TABLE dbo.ca_llave_finagro
GO
IF OBJECT_ID ('dbo.ca_llave_2piso') IS NOT NULL
	DROP TABLE dbo.ca_llave_2piso
GO
IF OBJECT_ID ('dbo.ca_liquida_msv') IS NOT NULL
	DROP TABLE dbo.ca_liquida_msv
GO
IF OBJECT_ID ('dbo.ca_lavado_activos_tmp') IS NOT NULL
	DROP TABLE dbo.ca_lavado_activos_tmp
GO
IF OBJECT_ID ('dbo.ca_lavado_activos') IS NOT NULL
	DROP TABLE dbo.ca_lavado_activos
GO
IF OBJECT_ID ('dbo.ca_justificaciones_err') IS NOT NULL
	DROP TABLE dbo.ca_justificaciones_err
GO
IF OBJECT_ID ('dbo.ca_justificaciones') IS NOT NULL
	DROP TABLE dbo.ca_justificaciones
GO
IF OBJECT_ID ('dbo.ca_justifica_fina') IS NOT NULL
	DROP TABLE dbo.ca_justifica_fina
GO
IF OBJECT_ID ('dbo.ca_interfaz_ndc') IS NOT NULL
	DROP TABLE dbo.ca_interfaz_ndc
GO
IF OBJECT_ID ('dbo.ca_interfaz_mesacambio') IS NOT NULL
	DROP TABLE dbo.ca_interfaz_mesacambio
GO
IF OBJECT_ID ('dbo.ca_interfaz_mbs') IS NOT NULL
	DROP TABLE dbo.ca_interfaz_mbs
GO
IF OBJECT_ID ('dbo.ca_interes_proyectado_tmp') IS NOT NULL
	DROP TABLE dbo.ca_interes_proyectado_tmp
GO
IF OBJECT_ID ('dbo.ca_informe_anual_pagos') IS NOT NULL
	DROP TABLE dbo.ca_informe_anual_pagos
GO
IF OBJECT_ID ('dbo.ca_info_extracto') IS NOT NULL
	DROP TABLE dbo.ca_info_extracto
GO
IF OBJECT_ID ('dbo.ca_inf_general_evaluacion') IS NOT NULL
	DROP TABLE dbo.ca_inf_general_evaluacion
GO
IF OBJECT_ID ('dbo.ca_inf_codeu_evaluacion') IS NOT NULL
	DROP TABLE dbo.ca_inf_codeu_evaluacion
GO
IF OBJECT_ID ('dbo.ca_impresion_carta') IS NOT NULL
	DROP TABLE dbo.ca_impresion_carta
GO
IF OBJECT_ID ('dbo.ca_homologar') IS NOT NULL
	DROP TABLE dbo.ca_homologar
GO
IF OBJECT_ID ('dbo.ca_homologa_otros_pag') IS NOT NULL
	DROP TABLE dbo.ca_homologa_otros_pag
GO
IF OBJECT_ID ('dbo.ca_historico_mig') IS NOT NULL
	DROP TABLE dbo.ca_historico_mig
GO
IF OBJECT_ID ('dbo.ca_historia_tran') IS NOT NULL
	DROP TABLE dbo.ca_historia_tran
GO
IF OBJECT_ID ('dbo.ca_hcuadre') IS NOT NULL
	DROP TABLE dbo.ca_hcuadre
GO
IF OBJECT_ID ('dbo.ca_gracia_seguros') IS NOT NULL
	DROP TABLE dbo.ca_gracia_seguros
GO
IF OBJECT_ID ('dbo.ca_gestion_cobranza_palm_tmp') IS NOT NULL
	DROP TABLE dbo.ca_gestion_cobranza_palm_tmp
GO
IF OBJECT_ID ('dbo.ca_gen_hist_masivo') IS NOT NULL
	DROP TABLE dbo.ca_gen_hist_masivo
GO
IF OBJECT_ID ('dbo.ca_garantias_tramite') IS NOT NULL
	DROP TABLE dbo.ca_garantias_tramite
GO
IF OBJECT_ID ('dbo.ca_gar_propuesta_tmp') IS NOT NULL
	DROP TABLE dbo.ca_gar_propuesta_tmp
GO
IF OBJECT_ID ('dbo.ca_fval_masivo') IS NOT NULL
	DROP TABLE dbo.ca_fval_masivo
GO
IF OBJECT_ID ('dbo.ca_fv_cas') IS NOT NULL
	DROP TABLE dbo.ca_fv_cas
GO
IF OBJECT_ID ('dbo.ca_fv_248986') IS NOT NULL
	DROP TABLE dbo.ca_fv_248986
GO
IF OBJECT_ID ('dbo.ca_formatos_normalizacion_cca') IS NOT NULL
	DROP TABLE dbo.ca_formatos_normalizacion_cca
GO
IF OBJECT_ID ('dbo.ca_fng_devoluciones') IS NOT NULL
	DROP TABLE dbo.ca_fng_devoluciones
GO
IF OBJECT_ID ('dbo.ca_fng_16_tmp') IS NOT NULL
	DROP TABLE dbo.ca_fng_16_tmp
GO
IF OBJECT_ID ('dbo.ca_findeter') IS NOT NULL
	DROP TABLE dbo.ca_findeter
GO
IF OBJECT_ID ('dbo.ca_finagro') IS NOT NULL
	DROP TABLE dbo.ca_finagro
GO
IF OBJECT_ID ('dbo.ca_fechas_diff') IS NOT NULL
	DROP TABLE dbo.ca_fechas_diff
GO
IF OBJECT_ID ('dbo.ca_fecha_valor_masivo_sus') IS NOT NULL
	DROP TABLE dbo.ca_fecha_valor_masivo_sus
GO
IF OBJECT_ID ('dbo.ca_fecha_valor_masivo') IS NOT NULL
	DROP TABLE dbo.ca_fecha_valor_masivo
GO
IF OBJECT_ID ('dbo.ca_fecha_reest_control') IS NOT NULL
	DROP TABLE dbo.ca_fecha_reest_control
GO
IF OBJECT_ID ('dbo.ca_fecha_proceso_contable') IS NOT NULL
	DROP TABLE dbo.ca_fecha_proceso_contable
GO
IF OBJECT_ID ('dbo.ca_fecha_pago_cuotas') IS NOT NULL
	DROP TABLE dbo.ca_fecha_pago_cuotas
GO
IF OBJECT_ID ('dbo.ca_fecha') IS NOT NULL
	DROP TABLE dbo.ca_fecha
GO
IF OBJECT_ID ('dbo.ca_facturas_tmp') IS NOT NULL
	DROP TABLE dbo.ca_facturas_tmp
GO
IF OBJECT_ID ('dbo.ca_facturas_his') IS NOT NULL
	DROP TABLE dbo.ca_facturas_his
GO
IF OBJECT_ID ('dbo.ca_facturas') IS NOT NULL
	DROP TABLE dbo.ca_facturas
GO
IF OBJECT_ID ('dbo.ca_facturacion_recaudos_his') IS NOT NULL
	DROP TABLE dbo.ca_facturacion_recaudos_his
GO
IF OBJECT_ID ('dbo.ca_f127_masivo') IS NOT NULL
	DROP TABLE dbo.ca_f127_masivo
GO
IF OBJECT_ID ('dbo.ca_extracto_linea_tmp') IS NOT NULL
	DROP TABLE dbo.ca_extracto_linea_tmp
GO
IF OBJECT_ID ('dbo.ca_extracto_linea_bat') IS NOT NULL
	DROP TABLE dbo.ca_extracto_linea_bat
GO
IF OBJECT_ID ('dbo.ca_estados_rubro_ts') IS NOT NULL
	DROP TABLE dbo.ca_estados_rubro_ts
GO
IF OBJECT_ID ('dbo.ca_estados_rubro') IS NOT NULL
	DROP TABLE dbo.ca_estados_rubro
GO
IF OBJECT_ID ('dbo.ca_estados_man_ts') IS NOT NULL
	DROP TABLE dbo.ca_estados_man_ts
GO
IF OBJECT_ID ('dbo.ca_estados_man') IS NOT NULL
	DROP TABLE dbo.ca_estados_man
GO
IF OBJECT_ID ('dbo.ca_estado_virtual') IS NOT NULL
	DROP TABLE dbo.ca_estado_virtual
GO
IF OBJECT_ID ('dbo.ca_estado_ts') IS NOT NULL
	DROP TABLE dbo.ca_estado_ts
GO
IF OBJECT_ID ('dbo.ca_estado_garantias_det') IS NOT NULL
	DROP TABLE dbo.ca_estado_garantias_det
GO
IF OBJECT_ID ('dbo.ca_estado_garantias_cab') IS NOT NULL
	DROP TABLE dbo.ca_estado_garantias_cab
GO
IF OBJECT_ID ('dbo.ca_estado') IS NOT NULL
	DROP TABLE dbo.ca_estado
GO
IF OBJECT_ID ('dbo.ca_errorlog') IS NOT NULL
	DROP TABLE dbo.ca_errorlog
GO
IF OBJECT_ID ('dbo.ca_errores_ts') IS NOT NULL
	DROP TABLE dbo.ca_errores_ts
GO
IF OBJECT_ID ('dbo.ca_errores_tmp') IS NOT NULL
	DROP TABLE dbo.ca_errores_tmp
GO
IF OBJECT_ID ('dbo.ca_errores_finales_tmp') IS NOT NULL
	DROP TABLE dbo.ca_errores_finales_tmp
GO
IF OBJECT_ID ('dbo.ca_errores_finales') IS NOT NULL
	DROP TABLE dbo.ca_errores_finales
GO
IF OBJECT_ID ('dbo.ca_err_camlinfin') IS NOT NULL
	DROP TABLE dbo.ca_err_camlinfin
GO
IF OBJECT_ID ('dbo.ca_en_temporales') IS NOT NULL
	DROP TABLE dbo.ca_en_temporales
GO
IF OBJECT_ID ('dbo.ca_en_fecha_valor') IS NOT NULL
	DROP TABLE dbo.ca_en_fecha_valor
GO
IF OBJECT_ID ('dbo.ca_elim_cliente_COfertas_tmp') IS NOT NULL
	DROP TABLE dbo.ca_elim_cliente_COfertas_tmp
GO
IF OBJECT_ID ('dbo.ca_EjeRango_Listmp') IS NOT NULL
	DROP TABLE dbo.ca_EjeRango_Listmp
GO
IF OBJECT_ID ('dbo.ca_eje_xmatriz_tmp') IS NOT NULL
	DROP TABLE dbo.ca_eje_xmatriz_tmp
GO
IF OBJECT_ID ('dbo.ca_eje_ts') IS NOT NULL
	DROP TABLE dbo.ca_eje_ts
GO
IF OBJECT_ID ('dbo.ca_eje_tmp') IS NOT NULL
	DROP TABLE dbo.ca_eje_tmp
GO
IF OBJECT_ID ('dbo.ca_eje_Req499') IS NOT NULL
	DROP TABLE dbo.ca_eje_Req499
GO
IF OBJECT_ID ('dbo.ca_eje_rango_ts') IS NOT NULL
	DROP TABLE dbo.ca_eje_rango_ts
GO
IF OBJECT_ID ('dbo.ca_eje_rango_tmp') IS NOT NULL
	DROP TABLE dbo.ca_eje_rango_tmp
GO
IF OBJECT_ID ('dbo.ca_eje_rango_Req499') IS NOT NULL
	DROP TABLE dbo.ca_eje_rango_Req499
GO
IF OBJECT_ID ('dbo.ca_eje_rango') IS NOT NULL
	DROP TABLE dbo.ca_eje_rango
GO
IF OBJECT_ID ('dbo.ca_eje') IS NOT NULL
	DROP TABLE dbo.ca_eje
GO
IF OBJECT_ID ('dbo.ca_dpagrec_tmp') IS NOT NULL
	DROP TABLE dbo.ca_dpagrec_tmp
GO
IF OBJECT_ID ('dbo.ca_dpagosa_diario') IS NOT NULL
	DROP TABLE dbo.ca_dpagosa_diario
GO
IF OBJECT_ID ('dbo.ca_dividendos_rot_tmp') IS NOT NULL
	DROP TABLE dbo.ca_dividendos_rot_tmp
GO
IF OBJECT_ID ('dbo.ca_dividendo_virtual') IS NOT NULL
	DROP TABLE dbo.ca_dividendo_virtual
GO
IF OBJECT_ID ('dbo.ca_dividendo_ts') IS NOT NULL
	DROP TABLE dbo.ca_dividendo_ts
GO
IF OBJECT_ID ('dbo.ca_dividendo_tmp') IS NOT NULL
	DROP TABLE dbo.ca_dividendo_tmp
GO
IF OBJECT_ID ('dbo.ca_dividendo_resp') IS NOT NULL
	DROP TABLE dbo.ca_dividendo_resp
GO
IF OBJECT_ID ('dbo.ca_dividendo_original_tmp') IS NOT NULL
	DROP TABLE dbo.ca_dividendo_original_tmp
GO
IF OBJECT_ID ('dbo.ca_dividendo_original') IS NOT NULL
	DROP TABLE dbo.ca_dividendo_original
GO
IF OBJECT_ID ('dbo.ca_dividendo_opt3') IS NOT NULL
	DROP TABLE dbo.ca_dividendo_opt3
GO
IF OBJECT_ID ('dbo.ca_dividendo_his_plano') IS NOT NULL
	DROP TABLE dbo.ca_dividendo_his_plano
GO
IF OBJECT_ID ('dbo.ca_dividendo_his') IS NOT NULL
	DROP TABLE dbo.ca_dividendo_his
GO
IF OBJECT_ID ('dbo.ca_dividendo') IS NOT NULL
	DROP TABLE dbo.ca_dividendo
GO
IF OBJECT_ID ('dbo.CA_DIFF_INTERES_MARZO2015') IS NOT NULL
	DROP TABLE dbo.CA_DIFF_INTERES_MARZO2015
GO
IF OBJECT_ID ('dbo.ca_diff_hc_Vs_conso') IS NOT NULL
	DROP TABLE dbo.ca_diff_hc_Vs_conso
GO
IF OBJECT_ID ('dbo.ca_diferidos_mig') IS NOT NULL
	DROP TABLE dbo.ca_diferidos_mig
GO
IF OBJECT_ID ('dbo.ca_diferidos_his') IS NOT NULL
	DROP TABLE dbo.ca_diferidos_his
GO
IF OBJECT_ID ('dbo.ca_diferidos') IS NOT NULL
	DROP TABLE dbo.ca_diferidos
GO
IF OBJECT_ID ('dbo.ca_diferencias_tmp') IS NOT NULL
	DROP TABLE dbo.ca_diferencias_tmp
GO
IF OBJECT_ID ('dbo.ca_diferencias_findeter_tmp') IS NOT NULL
	DROP TABLE dbo.ca_diferencias_findeter_tmp
GO
IF OBJECT_ID ('dbo.ca_diastablamanual') IS NOT NULL
	DROP TABLE dbo.ca_diastablamanual
GO
IF OBJECT_ID ('dbo.ca_dias_aceleratoria') IS NOT NULL
	DROP TABLE dbo.ca_dias_aceleratoria
GO
IF OBJECT_ID ('dbo.ca_devolucion_rubro') IS NOT NULL
	DROP TABLE dbo.ca_devolucion_rubro
GO
IF OBJECT_ID ('dbo.ca_deudores_tmp') IS NOT NULL
	DROP TABLE dbo.ca_deudores_tmp
GO
IF OBJECT_ID ('dbo.ca_deu_segvida') IS NOT NULL
	DROP TABLE dbo.ca_deu_segvida
GO
IF OBJECT_ID ('dbo.ca_detalles_garantia_deudor') IS NOT NULL
	DROP TABLE dbo.ca_detalles_garantia_deudor
GO
IF OBJECT_ID ('dbo.ca_detalle_tmp') IS NOT NULL
	DROP TABLE dbo.ca_detalle_tmp
GO
IF OBJECT_ID ('dbo.ca_detalle_fechas_938_tmp') IS NOT NULL
	DROP TABLE dbo.ca_detalle_fechas_938_tmp
GO
IF OBJECT_ID ('dbo.ca_detalle_ejecutivo_pda2') IS NOT NULL
	DROP TABLE dbo.ca_detalle_ejecutivo_pda2
GO
IF OBJECT_ID ('dbo.ca_detalle_amor') IS NOT NULL
	DROP TABLE dbo.ca_detalle_amor
GO
IF OBJECT_ID ('dbo.ca_detalle_938_tmp') IS NOT NULL
	DROP TABLE dbo.ca_detalle_938_tmp
GO
IF OBJECT_ID ('dbo.ca_detalle_924_tmp') IS NOT NULL
	DROP TABLE dbo.ca_detalle_924_tmp
GO
IF OBJECT_ID ('dbo.ca_detalle') IS NOT NULL
	DROP TABLE dbo.ca_detalle
GO
IF OBJECT_ID ('dbo.ca_det_trn_opt3') IS NOT NULL
	DROP TABLE dbo.ca_det_trn_opt3
GO
IF OBJECT_ID ('dbo.ca_det_trn_bancamia_tmp') IS NOT NULL
	DROP TABLE dbo.ca_det_trn_bancamia_tmp
GO
IF OBJECT_ID ('dbo.ca_det_trn_bancamia') IS NOT NULL
	DROP TABLE dbo.ca_det_trn_bancamia
GO
IF OBJECT_ID ('dbo.ca_det_trn') IS NOT NULL
	DROP TABLE dbo.ca_det_trn
GO
IF OBJECT_ID ('dbo.ca_desmarca_fng_his') IS NOT NULL
	DROP TABLE dbo.ca_desmarca_fng_his
GO
IF OBJECT_ID ('dbo.ca_desembolso_ts') IS NOT NULL
	DROP TABLE dbo.ca_desembolso_ts
GO
IF OBJECT_ID ('dbo.ca_desembolso_respaldo') IS NOT NULL
	DROP TABLE dbo.ca_desembolso_respaldo
GO
IF OBJECT_ID ('dbo.ca_desembolso_no') IS NOT NULL
	DROP TABLE dbo.ca_desembolso_no
GO
IF OBJECT_ID ('dbo.ca_desembolso_fag_tmp') IS NOT NULL
	DROP TABLE dbo.ca_desembolso_fag_tmp
GO
IF OBJECT_ID ('dbo.ca_desembolso_conv') IS NOT NULL
	DROP TABLE dbo.ca_desembolso_conv
GO
IF OBJECT_ID ('dbo.ca_desembolso') IS NOT NULL
	DROP TABLE dbo.ca_desembolso
GO
IF OBJECT_ID ('dbo.ca_definitiva') IS NOT NULL
	DROP TABLE dbo.ca_definitiva
GO
IF OBJECT_ID ('dbo.ca_definicion_nomina_tmp') IS NOT NULL
	DROP TABLE dbo.ca_definicion_nomina_tmp
GO
IF OBJECT_ID ('dbo.ca_definicion_nomina') IS NOT NULL
	DROP TABLE dbo.ca_definicion_nomina
GO
IF OBJECT_ID ('dbo.ca_default_toperacion_ts') IS NOT NULL
	DROP TABLE dbo.ca_default_toperacion_ts
GO
IF OBJECT_ID ('dbo.ca_default_toperacion') IS NOT NULL
	DROP TABLE dbo.ca_default_toperacion
GO
IF OBJECT_ID ('dbo.ca_decodificador') IS NOT NULL
	DROP TABLE dbo.ca_decodificador
GO
IF OBJECT_ID ('dbo.ca_datos_trn') IS NOT NULL
	DROP TABLE dbo.ca_datos_trn
GO
IF OBJECT_ID ('dbo.ca_datos_reestructuraciones_cca') IS NOT NULL
	DROP TABLE dbo.ca_datos_reestructuraciones_cca
GO
IF OBJECT_ID ('dbo.ca_datos_op_vencidas') IS NOT NULL
	DROP TABLE dbo.ca_datos_op_vencidas
GO
IF OBJECT_ID ('dbo.ca_datos_impresion') IS NOT NULL
	DROP TABLE dbo.ca_datos_impresion
GO
IF OBJECT_ID ('dbo.ca_datos_condonaciones') IS NOT NULL
	DROP TABLE dbo.ca_datos_condonaciones
GO
IF OBJECT_ID ('dbo.ca_datos_concil_men') IS NOT NULL
	DROP TABLE dbo.ca_datos_concil_men
GO
IF OBJECT_ID ('dbo.ca_datos_concil') IS NOT NULL
	DROP TABLE dbo.ca_datos_concil
GO
IF OBJECT_ID ('dbo.ca_datos_carta_redes') IS NOT NULL
	DROP TABLE dbo.ca_datos_carta_redes
GO
IF OBJECT_ID ('dbo.ca_datos_cabecera') IS NOT NULL
	DROP TABLE dbo.ca_datos_cabecera
GO
IF OBJECT_ID ('dbo.ca_datooperacion_cuadre') IS NOT NULL
	DROP TABLE dbo.ca_datooperacion_cuadre
GO
IF OBJECT_ID ('dbo.ca_data_temp') IS NOT NULL
	DROP TABLE dbo.ca_data_temp
GO
IF OBJECT_ID ('dbo.ca_dat_oper_bv_tmp') IS NOT NULL
	DROP TABLE dbo.ca_dat_oper_bv_tmp
GO
IF OBJECT_ID ('dbo.ca_cxc_no_cartera') IS NOT NULL
	DROP TABLE dbo.ca_cxc_no_cartera
GO
IF OBJECT_ID ('dbo.ca_cursor_dividendo_temp') IS NOT NULL
	DROP TABLE dbo.ca_cursor_dividendo_temp
GO
IF OBJECT_ID ('dbo.ca_cursor_dividendo_ru_tmp') IS NOT NULL
	DROP TABLE dbo.ca_cursor_dividendo_ru_tmp
GO
IF OBJECT_ID ('dbo.CA_CUOTA_VIGENTE_MAR15') IS NOT NULL
	DROP TABLE dbo.CA_CUOTA_VIGENTE_MAR15
GO
IF OBJECT_ID ('dbo.ca_cuota_diff1_aux') IS NOT NULL
	DROP TABLE dbo.ca_cuota_diff1_aux
GO
IF OBJECT_ID ('dbo.ca_cuota_diff_tmp') IS NOT NULL
	DROP TABLE dbo.ca_cuota_diff_tmp
GO
IF OBJECT_ID ('dbo.ca_cuota_diff_his') IS NOT NULL
	DROP TABLE dbo.ca_cuota_diff_his
GO
IF OBJECT_ID ('dbo.ca_cuota_diff_aux') IS NOT NULL
	DROP TABLE dbo.ca_cuota_diff_aux
GO
IF OBJECT_ID ('dbo.ca_cuota_diff') IS NOT NULL
	DROP TABLE dbo.ca_cuota_diff
GO
IF OBJECT_ID ('dbo.ca_cuota_adicional_tmp') IS NOT NULL
	DROP TABLE dbo.ca_cuota_adicional_tmp
GO
IF OBJECT_ID ('dbo.ca_cuota_adicional_his') IS NOT NULL
	DROP TABLE dbo.ca_cuota_adicional_his
GO
IF OBJECT_ID ('dbo.ca_cuota_adicional') IS NOT NULL
	DROP TABLE dbo.ca_cuota_adicional
GO
IF OBJECT_ID ('dbo.ca_cuerpo_carta') IS NOT NULL
	DROP TABLE dbo.ca_cuerpo_carta
GO
IF OBJECT_ID ('dbo.ca_cuentas_revisoria_tmp') IS NOT NULL
	DROP TABLE dbo.ca_cuentas_revisoria_tmp
GO
IF OBJECT_ID ('dbo.ca_cuentas_ajuste') IS NOT NULL
	DROP TABLE dbo.ca_cuentas_ajuste
GO
IF OBJECT_ID ('dbo.ca_cuadre_hc_conso_reporte') IS NOT NULL
	DROP TABLE dbo.ca_cuadre_hc_conso_reporte
GO
IF OBJECT_ID ('dbo.ca_ctas_no_relaciondas') IS NOT NULL
	DROP TABLE dbo.ca_ctas_no_relaciondas
GO
IF OBJECT_ID ('dbo.ca_cpagos_tmp') IS NOT NULL
	DROP TABLE dbo.ca_cpagos_tmp
GO
IF OBJECT_ID ('dbo.ca_cotizacion_batch') IS NOT NULL
	DROP TABLE dbo.ca_cotizacion_batch
GO
IF OBJECT_ID ('dbo.ca_correccion_tmp') IS NOT NULL
	DROP TABLE dbo.ca_correccion_tmp
GO
IF OBJECT_ID ('dbo.ca_correccion_his') IS NOT NULL
	DROP TABLE dbo.ca_correccion_his
GO
IF OBJECT_ID ('dbo.ca_correccion') IS NOT NULL
	DROP TABLE dbo.ca_correccion
GO
IF OBJECT_ID ('dbo.ca_corr_tasas_pref_NoVig') IS NOT NULL
	DROP TABLE dbo.ca_corr_tasas_pref_NoVig
GO
IF OBJECT_ID ('dbo.ca_corr_tasas_pref_II') IS NOT NULL
	DROP TABLE dbo.ca_corr_tasas_pref_II
GO
IF OBJECT_ID ('dbo.ca_corr_tasas_pref') IS NOT NULL
	DROP TABLE dbo.ca_corr_tasas_pref
GO
IF OBJECT_ID ('dbo.ca_corr_perid_bimensual') IS NOT NULL
	DROP TABLE dbo.ca_corr_perid_bimensual
GO
IF OBJECT_ID ('dbo.ca_conversion') IS NOT NULL
	DROP TABLE dbo.ca_conversion
GO
IF OBJECT_ID ('dbo.ca_convenios_tmp_cabecera') IS NOT NULL
	DROP TABLE dbo.ca_convenios_tmp_cabecera
GO
IF OBJECT_ID ('dbo.ca_convenios_tmp') IS NOT NULL
	DROP TABLE dbo.ca_convenios_tmp
GO
IF OBJECT_ID ('dbo.ca_convenio_recaudo') IS NOT NULL
	DROP TABLE dbo.ca_convenio_recaudo
GO
IF OBJECT_ID ('dbo.ca_convenio_39566_tmp') IS NOT NULL
	DROP TABLE dbo.ca_convenio_39566_tmp
GO
IF OBJECT_ID ('dbo.ca_control_trn_manual') IS NOT NULL
	DROP TABLE dbo.ca_control_trn_manual
GO
IF OBJECT_ID ('dbo.ca_control_intant') IS NOT NULL
	DROP TABLE dbo.ca_control_intant
GO
IF OBJECT_ID ('dbo.ca_contabiliza_operacion') IS NOT NULL
	DROP TABLE dbo.ca_contabiliza_operacion
GO
IF OBJECT_ID ('dbo.ca_consutar_transacciones_tmp2') IS NOT NULL
	DROP TABLE dbo.ca_consutar_transacciones_tmp2
GO
IF OBJECT_ID ('dbo.ca_consutar_transacciones_tmp1') IS NOT NULL
	DROP TABLE dbo.ca_consutar_transacciones_tmp1
GO
IF OBJECT_ID ('dbo.ca_consultas_prepagos') IS NOT NULL
	DROP TABLE dbo.ca_consultas_prepagos
GO
IF OBJECT_ID ('dbo.ca_consulta_rec_pago_tmp') IS NOT NULL
	DROP TABLE dbo.ca_consulta_rec_pago_tmp
GO
IF OBJECT_ID ('dbo.ca_consulta_pag_mas_tmp') IS NOT NULL
	DROP TABLE dbo.ca_consulta_pag_mas_tmp
GO
IF OBJECT_ID ('dbo.ca_consulta_his_tasa_RES') IS NOT NULL
	DROP TABLE dbo.ca_consulta_his_tasa_RES
GO
IF OBJECT_ID ('dbo.ca_conmigpas_tmp') IS NOT NULL
	DROP TABLE dbo.ca_conmigpas_tmp
GO
IF OBJECT_ID ('dbo.ca_conmigact_tmp') IS NOT NULL
	DROP TABLE dbo.ca_conmigact_tmp
GO
IF OBJECT_ID ('dbo.ca_condonacion_ts') IS NOT NULL
	DROP TABLE dbo.ca_condonacion_ts
GO
IF OBJECT_ID ('dbo.ca_condonacion_autorizacion') IS NOT NULL
	DROP TABLE dbo.ca_condonacion_autorizacion
GO
IF OBJECT_ID ('dbo.ca_condonacion') IS NOT NULL
	DROP TABLE dbo.ca_condonacion
GO
IF OBJECT_ID ('dbo.ca_conciliaciond_cabecera') IS NOT NULL
	DROP TABLE dbo.ca_conciliaciond_cabecera
GO
IF OBJECT_ID ('dbo.ca_conciliacion_mensual') IS NOT NULL
	DROP TABLE dbo.ca_conciliacion_mensual
GO
IF OBJECT_ID ('dbo.ca_conciliacion_diaria_his') IS NOT NULL
	DROP TABLE dbo.ca_conciliacion_diaria_his
GO
IF OBJECT_ID ('dbo.ca_conciliacion_diaria') IS NOT NULL
	DROP TABLE dbo.ca_conciliacion_diaria
GO
IF OBJECT_ID ('dbo.ca_conciliacion_act_pas') IS NOT NULL
	DROP TABLE dbo.ca_conciliacion_act_pas
GO
IF OBJECT_ID ('dbo.ca_conci_dia_findeter_tmp') IS NOT NULL
	DROP TABLE dbo.ca_conci_dia_findeter_tmp
GO
IF OBJECT_ID ('dbo.ca_conci_dia_findeter') IS NOT NULL
	DROP TABLE dbo.ca_conci_dia_findeter
GO
IF OBJECT_ID ('dbo.ca_conci_dia_bancoldex_his') IS NOT NULL
	DROP TABLE dbo.ca_conci_dia_bancoldex_his
GO
IF OBJECT_ID ('dbo.ca_conci_dia_bancoldex') IS NOT NULL
	DROP TABLE dbo.ca_conci_dia_bancoldex
GO
IF OBJECT_ID ('dbo.ca_conceptos_tmp') IS NOT NULL
	DROP TABLE dbo.ca_conceptos_tmp
GO
IF OBJECT_ID ('dbo.ca_concepto_ts') IS NOT NULL
	DROP TABLE dbo.ca_concepto_ts
GO
IF OBJECT_ID ('dbo.ca_concepto_respaldo') IS NOT NULL
	DROP TABLE dbo.ca_concepto_respaldo
GO
IF OBJECT_ID ('dbo.ca_concepto_bancamia') IS NOT NULL
	DROP TABLE dbo.ca_concepto_bancamia
GO
IF OBJECT_ID ('dbo.ca_concepto') IS NOT NULL
	DROP TABLE dbo.ca_concepto
GO
IF OBJECT_ID ('dbo.ca_compr4_tmp') IS NOT NULL
	DROP TABLE dbo.ca_compr4_tmp
GO
IF OBJECT_ID ('dbo.ca_compr3_tmp') IS NOT NULL
	DROP TABLE dbo.ca_compr3_tmp
GO
IF OBJECT_ID ('dbo.ca_compr2_tmp') IS NOT NULL
	DROP TABLE dbo.ca_compr2_tmp
GO
IF OBJECT_ID ('dbo.ca_compr1_tmp') IS NOT NULL
	DROP TABLE dbo.ca_compr1_tmp
GO
IF OBJECT_ID ('dbo.ca_compara_hc_consolidador') IS NOT NULL
	DROP TABLE dbo.ca_compara_hc_consolidador
GO
IF OBJECT_ID ('dbo.ca_comision_recaudo') IS NOT NULL
	DROP TABLE dbo.ca_comision_recaudo
GO
IF OBJECT_ID ('dbo.ca_colateral_det_tmp') IS NOT NULL
	DROP TABLE dbo.ca_colateral_det_tmp
GO
IF OBJECT_ID ('dbo.ca_colateral_det') IS NOT NULL
	DROP TABLE dbo.ca_colateral_det
GO
IF OBJECT_ID ('dbo.ca_colateral_dee') IS NOT NULL
	DROP TABLE dbo.ca_colateral_dee
GO
IF OBJECT_ID ('dbo.ca_colateral') IS NOT NULL
	DROP TABLE dbo.ca_colateral
GO
IF OBJECT_ID ('dbo.ca_codigos_prepago_ts') IS NOT NULL
	DROP TABLE dbo.ca_codigos_prepago_ts
GO
IF OBJECT_ID ('dbo.ca_codigos_prepago') IS NOT NULL
	DROP TABLE dbo.ca_codigos_prepago
GO
IF OBJECT_ID ('dbo.ca_cobranza_castigada_tmp') IS NOT NULL
	DROP TABLE dbo.ca_cobranza_castigada_tmp
GO
IF OBJECT_ID ('dbo.ca_cobis') IS NOT NULL
	DROP TABLE dbo.ca_cobis
GO
IF OBJECT_ID ('dbo.ca_clientes_tmp') IS NOT NULL
	DROP TABLE dbo.ca_clientes_tmp
GO
IF OBJECT_ID ('dbo.ca_clientes_actualizados') IS NOT NULL
	DROP TABLE dbo.ca_clientes_actualizados
GO
IF OBJECT_ID ('dbo.ca_cliente_tmp') IS NOT NULL
	DROP TABLE dbo.ca_cliente_tmp
GO
IF OBJECT_ID ('dbo.ca_cliente_operacion') IS NOT NULL
	DROP TABLE dbo.ca_cliente_operacion
GO
IF OBJECT_ID ('dbo.ca_cli_deudor') IS NOT NULL
	DROP TABLE dbo.ca_cli_deudor
GO
IF OBJECT_ID ('dbo.ca_central_riesgo') IS NOT NULL
	DROP TABLE dbo.ca_central_riesgo
GO
IF OBJECT_ID ('dbo.ca_cdes_tmp') IS NOT NULL
	DROP TABLE dbo.ca_cdes_tmp
GO
IF OBJECT_ID ('dbo.ca_cca_recono_act_424') IS NOT NULL
	DROP TABLE dbo.ca_cca_recono_act_424
GO
IF OBJECT_ID ('dbo.ca_cbte_alineacion') IS NOT NULL
	DROP TABLE dbo.ca_cbte_alineacion
GO
IF OBJECT_ID ('dbo.ca_categoria_rubro') IS NOT NULL
	DROP TABLE dbo.ca_categoria_rubro
GO
IF OBJECT_ID ('dbo.ca_castigos_mig') IS NOT NULL
	DROP TABLE dbo.ca_castigos_mig
GO
IF OBJECT_ID ('dbo.ca_castigo_masivo') IS NOT NULL
	DROP TABLE dbo.ca_castigo_masivo
GO
IF OBJECT_ID ('dbo.ca_castigadas_migradas') IS NOT NULL
	DROP TABLE dbo.ca_castigadas_migradas
GO
IF OBJECT_ID ('dbo.ca_carteriza_sobregiros') IS NOT NULL
	DROP TABLE dbo.ca_carteriza_sobregiros
GO
IF OBJECT_ID ('dbo.ca_cartera_trasladada_canc') IS NOT NULL
	DROP TABLE dbo.ca_cartera_trasladada_canc
GO
IF OBJECT_ID ('dbo.ca_carta') IS NOT NULL
	DROP TABLE dbo.ca_carta
GO
IF OBJECT_ID ('dbo.ca_carga_oper_conflicto_tmp') IS NOT NULL
	DROP TABLE dbo.ca_carga_oper_conflicto_tmp
GO
IF OBJECT_ID ('dbo.ca_carga_oper_conflicto') IS NOT NULL
	DROP TABLE dbo.ca_carga_oper_conflicto
GO
IF OBJECT_ID ('dbo.ca_carga_justificaciones') IS NOT NULL
	DROP TABLE dbo.ca_carga_justificaciones
GO
IF OBJECT_ID ('dbo.ca_carga_finagro_tmp') IS NOT NULL
	DROP TABLE dbo.ca_carga_finagro_tmp
GO
IF OBJECT_ID ('dbo.ca_carga_finagro') IS NOT NULL
	DROP TABLE dbo.ca_carga_finagro
GO
IF OBJECT_ID ('dbo.ca_carga_extractos_aux') IS NOT NULL
	DROP TABLE dbo.ca_carga_extractos_aux
GO
IF OBJECT_ID ('dbo.ca_carga_extractos') IS NOT NULL
	DROP TABLE dbo.ca_carga_extractos
GO
IF OBJECT_ID ('dbo.ca_carga_archivos_bcp') IS NOT NULL
	DROP TABLE dbo.ca_carga_archivos_bcp
GO
IF OBJECT_ID ('dbo.ca_capitaliza') IS NOT NULL
	DROP TABLE dbo.ca_capitaliza
GO
IF OBJECT_ID ('dbo.ca_canceladas_Ext_tmp') IS NOT NULL
	DROP TABLE dbo.ca_canceladas_Ext_tmp
GO
IF OBJECT_ID ('dbo.ca_canceladas_cca') IS NOT NULL
	DROP TABLE dbo.ca_canceladas_cca
GO
IF OBJECT_ID ('dbo.ca_campos_tablas_rubros') IS NOT NULL
	DROP TABLE dbo.ca_campos_tablas_rubros
GO
IF OBJECT_ID ('dbo.ca_campos_errados') IS NOT NULL
	DROP TABLE dbo.ca_campos_errados
GO
IF OBJECT_ID ('dbo.ca_cambioTasa_Oper_MIPYMES') IS NOT NULL
	DROP TABLE dbo.ca_cambioTasa_Oper_MIPYMES
GO
IF OBJECT_ID ('dbo.ca_cambios_treferenciales') IS NOT NULL
	DROP TABLE dbo.ca_cambios_treferenciales
GO
IF OBJECT_ID ('dbo.ca_cambio_tipo_garantia_convivencia') IS NOT NULL
	DROP TABLE dbo.ca_cambio_tipo_garantia_convivencia
GO
IF OBJECT_ID ('dbo.ca_cambio_tipo_garantia') IS NOT NULL
	DROP TABLE dbo.ca_cambio_tipo_garantia
GO
IF OBJECT_ID ('dbo.ca_cambio_tasa_fija') IS NOT NULL
	DROP TABLE dbo.ca_cambio_tasa_fija
GO
IF OBJECT_ID ('dbo.ca_cambio_masivo_tasas') IS NOT NULL
	DROP TABLE dbo.ca_cambio_masivo_tasas
GO
IF OBJECT_ID ('dbo.ca_cambio_fecha') IS NOT NULL
	DROP TABLE dbo.ca_cambio_fecha
GO
IF OBJECT_ID ('dbo.ca_cambio_calificacion_repro') IS NOT NULL
	DROP TABLE dbo.ca_cambio_calificacion_repro
GO
IF OBJECT_ID ('dbo.ca_cambio_calificacion_convivencia') IS NOT NULL
	DROP TABLE dbo.ca_cambio_calificacion_convivencia
GO
IF OBJECT_ID ('dbo.ca_cambio_calificacion') IS NOT NULL
	DROP TABLE dbo.ca_cambio_calificacion
GO
IF OBJECT_ID ('dbo.ca_cabecera_tmp') IS NOT NULL
	DROP TABLE dbo.ca_cabecera_tmp
GO
IF OBJECT_ID ('dbo.ca_cabecera_pag') IS NOT NULL
	DROP TABLE dbo.ca_cabecera_pag
GO
IF OBJECT_ID ('dbo.ca_cabecera') IS NOT NULL
	DROP TABLE dbo.ca_cabecera
GO
IF OBJECT_ID ('dbo.ca_buscar_operaciones_tmp') IS NOT NULL
	DROP TABLE dbo.ca_buscar_operaciones_tmp
GO
IF OBJECT_ID ('dbo.ca_bitacora_traslados') IS NOT NULL
	DROP TABLE dbo.ca_bitacora_traslados
GO
IF OBJECT_ID ('dbo.ca_base_rubros_p') IS NOT NULL
	DROP TABLE dbo.ca_base_rubros_p
GO
IF OBJECT_ID ('dbo.ca_base_garantia') IS NOT NULL
	DROP TABLE dbo.ca_base_garantia
GO
IF OBJECT_ID ('dbo.ca_bancoldex_nocobis') IS NOT NULL
	DROP TABLE dbo.ca_bancoldex_nocobis
GO
IF OBJECT_ID ('dbo.ca_bancoldex') IS NOT NULL
	DROP TABLE dbo.ca_bancoldex
GO
IF OBJECT_ID ('dbo.ca_banca_cliente') IS NOT NULL
	DROP TABLE dbo.ca_banca_cliente
GO
IF OBJECT_ID ('dbo.ca_aviso_cambio_tasas') IS NOT NULL
	DROP TABLE dbo.ca_aviso_cambio_tasas
GO
IF OBJECT_ID ('dbo.ca_avalistas') IS NOT NULL
	DROP TABLE dbo.ca_avalistas
GO
IF OBJECT_ID ('dbo.ca_autorizacion_condonacion') IS NOT NULL
	DROP TABLE dbo.ca_autorizacion_condonacion
GO
IF OBJECT_ID ('dbo.ca_asunto_carta') IS NOT NULL
	DROP TABLE dbo.ca_asunto_carta
GO
IF OBJECT_ID ('dbo.ca_asiento_tmp') IS NOT NULL
	DROP TABLE dbo.ca_asiento_tmp
GO
IF OBJECT_ID ('dbo.ca_asiento_contable') IS NOT NULL
	DROP TABLE dbo.ca_asiento_contable
GO
IF OBJECT_ID ('dbo.ca_aprob_por_desemb_tmp') IS NOT NULL
	DROP TABLE dbo.ca_aprob_por_desemb_tmp
GO
IF OBJECT_ID ('dbo.ca_amortizacion_virtual') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_virtual
GO
IF OBJECT_ID ('dbo.ca_amortizacion_unif') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_unif
GO
IF OBJECT_ID ('dbo.ca_amortizacion_tmp') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_tmp
GO
IF OBJECT_ID ('dbo.ca_amortizacion_ticket_260206') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_ticket_260206
GO
IF OBJECT_ID ('dbo.ca_amortizacion_ticket_238842') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_ticket_238842
GO
IF OBJECT_ID ('dbo.ca_amortizacion_ticket_0273636') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_ticket_0273636
GO
IF OBJECT_ID ('dbo.ca_amortizacion_resumen') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_resumen
GO
IF OBJECT_ID ('dbo.ca_amortizacion_resp') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_resp
GO
IF OBJECT_ID ('dbo.ca_amortizacion_proyectada') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_proyectada
GO
IF OBJECT_ID ('dbo.ca_amortizacion_ors_782') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_ors_782
GO
IF OBJECT_ID ('dbo.ca_amortizacion_opt3') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_opt3
GO
IF OBJECT_ID ('dbo.ca_amortizacion_incboc07312015') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_incboc07312015
GO
IF OBJECT_ID ('dbo.ca_amortizacion_inc_cap') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_inc_cap
GO
IF OBJECT_ID ('dbo.ca_amortizacion_inc_boc09302015') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_inc_boc09302015
GO
IF OBJECT_ID ('dbo.ca_amortizacion_inc_boc08312015') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_inc_boc08312015
GO
IF OBJECT_ID ('dbo.ca_amortizacion_inc_boc07312015_1') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_inc_boc07312015_1
GO
IF OBJECT_ID ('dbo.ca_amortizacion_inc_boc') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_inc_boc
GO
IF OBJECT_ID ('dbo.ca_amortizacion_INC_215551C') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_INC_215551C
GO
IF OBJECT_ID ('dbo.ca_amortizacion_INC_215551B') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_INC_215551B
GO
IF OBJECT_ID ('dbo.ca_amortizacion_INC_215551') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_INC_215551
GO
IF OBJECT_ID ('dbo.ca_amortizacion_hst_cca_406') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_hst_cca_406
GO
IF OBJECT_ID ('dbo.ca_amortizacion_hst_782') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_hst_782
GO
IF OBJECT_ID ('dbo.ca_amortizacion_his_plano') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_his_plano
GO
IF OBJECT_ID ('dbo.ca_amortizacion_his') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_his
GO
IF OBJECT_ID ('dbo.ca_amortizacion_copia') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_copia
GO
IF OBJECT_ID ('dbo.ca_amortizacion_cca406') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_cca406
GO
IF OBJECT_ID ('dbo.ca_amortizacion_canceladas') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_canceladas
GO
IF OBJECT_ID ('dbo.ca_amortizacion_ant_his') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_ant_his
GO
IF OBJECT_ID ('dbo.ca_amortizacion_ant') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_ant
GO
IF OBJECT_ID ('dbo.ca_amortizacion_13662454_UNO') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_13662454_UNO
GO
IF OBJECT_ID ('dbo.ca_amortizacion_13662454_DOS') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_13662454_DOS
GO
IF OBJECT_ID ('dbo.ca_amortizacion_13403293_UNO') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_13403293_UNO
GO
IF OBJECT_ID ('dbo.ca_amortizacion_13403293_DOS') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_13403293_DOS
GO
IF OBJECT_ID ('dbo.ca_amortizacion_13393646_UNO') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_13393646_UNO
GO
IF OBJECT_ID ('dbo.ca_amortizacion') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion
GO
IF OBJECT_ID ('dbo.ca_alternas_tmp') IS NOT NULL
	DROP TABLE dbo.ca_alternas_tmp
GO
IF OBJECT_ID ('dbo.ca_alfabeto') IS NOT NULL
	DROP TABLE dbo.ca_alfabeto
GO
IF OBJECT_ID ('dbo.ca_ajuste_finagro') IS NOT NULL
	DROP TABLE dbo.ca_ajuste_finagro
GO
IF OBJECT_ID ('dbo.ca_ahndc_automatica') IS NOT NULL
	DROP TABLE dbo.ca_ahndc_automatica
GO
IF OBJECT_ID ('dbo.ca_actualiza_prepagos') IS NOT NULL
	DROP TABLE dbo.ca_actualiza_prepagos
GO
IF OBJECT_ID ('dbo.ca_actualiza_llave_tmp') IS NOT NULL
	DROP TABLE dbo.ca_actualiza_llave_tmp
GO
IF OBJECT_ID ('dbo.ca_actpas_tmp') IS NOT NULL
	DROP TABLE dbo.ca_actpas_tmp
GO
IF OBJECT_ID ('dbo.ca_activas_canceladas') IS NOT NULL
	DROP TABLE dbo.ca_activas_canceladas
GO
IF OBJECT_ID ('dbo.ca_act_tipo_cobro') IS NOT NULL
	DROP TABLE dbo.ca_act_tipo_cobro
GO
IF OBJECT_ID ('dbo.ca_act_cod_reserva') IS NOT NULL
	DROP TABLE dbo.ca_act_cod_reserva
GO
IF OBJECT_ID ('dbo.ca_acciones_ts') IS NOT NULL
	DROP TABLE dbo.ca_acciones_ts
GO
IF OBJECT_ID ('dbo.ca_acciones_tmp') IS NOT NULL
	DROP TABLE dbo.ca_acciones_tmp
GO
IF OBJECT_ID ('dbo.ca_acciones_his') IS NOT NULL
	DROP TABLE dbo.ca_acciones_his
GO
IF OBJECT_ID ('dbo.ca_acciones') IS NOT NULL
	DROP TABLE dbo.ca_acciones
GO
IF OBJECT_ID ('dbo.ca_abonos_voluntarios') IS NOT NULL
	DROP TABLE dbo.ca_abonos_voluntarios
GO
IF OBJECT_ID ('dbo.ca_abonos_masivos_his_d') IS NOT NULL
	DROP TABLE dbo.ca_abonos_masivos_his_d
GO
IF OBJECT_ID ('dbo.ca_abonos_masivos_his') IS NOT NULL
	DROP TABLE dbo.ca_abonos_masivos_his
GO
IF OBJECT_ID ('dbo.ca_abonos_masivos_generales') IS NOT NULL
	DROP TABLE dbo.ca_abonos_masivos_generales
GO
IF OBJECT_ID ('dbo.ca_abonos_masivos_cabecera') IS NOT NULL
	DROP TABLE dbo.ca_abonos_masivos_cabecera
GO
IF OBJECT_ID ('dbo.ca_abono_rubro_resp') IS NOT NULL
	DROP TABLE dbo.ca_abono_rubro_resp
GO
IF OBJECT_ID ('dbo.ca_abono_rubro') IS NOT NULL
	DROP TABLE dbo.ca_abono_rubro
GO
IF OBJECT_ID ('dbo.ca_abono_rev_pag') IS NOT NULL
	DROP TABLE dbo.ca_abono_rev_pag
GO
IF OBJECT_ID ('dbo.ca_abono_respaldo') IS NOT NULL
	DROP TABLE dbo.ca_abono_respaldo
GO
IF OBJECT_ID ('dbo.ca_abono_renovacion') IS NOT NULL
	DROP TABLE dbo.ca_abono_renovacion
GO
IF OBJECT_ID ('dbo.ca_abono_prioridad_tmp') IS NOT NULL
	DROP TABLE dbo.ca_abono_prioridad_tmp
GO
IF OBJECT_ID ('dbo.ca_abono_prioridad') IS NOT NULL
	DROP TABLE dbo.ca_abono_prioridad
GO
IF OBJECT_ID ('dbo.ca_abono_pr_nue') IS NOT NULL
	DROP TABLE dbo.ca_abono_pr_nue
GO
IF OBJECT_ID ('dbo.ca_abono_NA_RV') IS NOT NULL
	DROP TABLE dbo.ca_abono_NA_RV
GO
IF OBJECT_ID ('dbo.ca_abono_masivo_prioridad') IS NOT NULL
	DROP TABLE dbo.ca_abono_masivo_prioridad
GO
IF OBJECT_ID ('dbo.ca_abono_masivo_errores') IS NOT NULL
	DROP TABLE dbo.ca_abono_masivo_errores
GO
IF OBJECT_ID ('dbo.ca_abono_masivo_det') IS NOT NULL
	DROP TABLE dbo.ca_abono_masivo_det
GO
IF OBJECT_ID ('dbo.ca_abono_masivo') IS NOT NULL
	DROP TABLE dbo.ca_abono_masivo
GO
IF OBJECT_ID ('dbo.ca_abono_INC_251045') IS NOT NULL
	DROP TABLE dbo.ca_abono_INC_251045
GO
IF OBJECT_ID ('dbo.ca_abono_fng') IS NOT NULL
	DROP TABLE dbo.ca_abono_fng
GO
IF OBJECT_ID ('dbo.ca_abono_det_tmp') IS NOT NULL
	DROP TABLE dbo.ca_abono_det_tmp
GO
IF OBJECT_ID ('dbo.ca_abono_det_INC_251045') IS NOT NULL
	DROP TABLE dbo.ca_abono_det_INC_251045
GO
IF OBJECT_ID ('dbo.ca_abono_det') IS NOT NULL
	DROP TABLE dbo.ca_abono_det
GO
IF OBJECT_ID ('dbo.ca_abono') IS NOT NULL
	DROP TABLE dbo.ca_abono
GO
IF OBJECT_ID ('dbo.ca_990_gracia') IS NOT NULL
	DROP TABLE dbo.ca_990_gracia
GO
IF OBJECT_ID ('dbo.bcp_condonaciones_def') IS NOT NULL
	DROP TABLE dbo.bcp_condonaciones_def
GO
IF OBJECT_ID ('dbo.bcp_25_reest') IS NOT NULL
	DROP TABLE dbo.bcp_25_reest
GO
IF OBJECT_ID ('dbo.asiento') IS NOT NULL
	DROP TABLE dbo.asiento
GO
IF OBJECT_ID ('dbo.am_saldos') IS NOT NULL
	DROP TABLE dbo.am_saldos
GO
IF OBJECT_ID ('dbo.ca_oper_cambio_linea_x_mora') IS NOT NULL
	DROP TABLE dbo.ca_oper_cambio_linea_x_mora
GO
IF OBJECT_ID ('dbo.rpt_cr_opcns') IS NOT NULL
	DROP TABLE dbo.rpt_cr_opcns
GO
IF OBJECT_ID ('dbo.rpt_cr_cabc1') IS NOT NULL
	DROP TABLE dbo.rpt_cr_cabc1
GO
IF OBJECT_ID ('dbo.rpt_cr_cabc2') IS NOT NULL
	DROP TABLE dbo.rpt_cr_cabc2
GO
IF OBJECT_ID ('dbo.rpt_cr_cabc3') IS NOT NULL
	DROP TABLE dbo.rpt_cr_cabc3
GO
IF OBJECT_ID ('dbo.rpt_cr_cabc4') IS NOT NULL
	DROP TABLE dbo.rpt_cr_cabc4
GO
IF OBJECT_ID ('dbo.rpt_ca_seg_reporte_a') IS NOT NULL
	DROP TABLE dbo.rpt_ca_seg_reporte_a
GO
IF OBJECT_ID ('dbo.rpt_ca_seg_reporte_b') IS NOT NULL
	DROP TABLE dbo.rpt_ca_seg_reporte_b
GO
IF OBJECT_ID ('dbo.rpt_ca_seg_total_a') IS NOT NULL
	DROP TABLE dbo.rpt_ca_seg_total_a
GO
IF OBJECT_ID ('dbo.rpt_Seleccion_total_b') IS NOT NULL
	DROP TABLE dbo.rpt_Seleccion_total_b
GO
IF OBJECT_ID ('dbo.ca_santander_resultado_desembolso') IS NOT NULL
	DROP TABLE dbo.ca_santander_resultado_desembolso
GO
IF OBJECT_ID ('dbo.ca_gen_ref_cuota_vigente') IS NOT NULL
	DROP TABLE ca_gen_ref_cuota_vigente
GO

USE cob_cartera_his
GO

IF OBJECT_ID ('dbo.ca_abono') IS NOT NULL
	DROP TABLE dbo.ca_abono
GO
IF OBJECT_ID ('dbo.ca_abono_det') IS NOT NULL
	DROP TABLE dbo.ca_abono_det
GO
IF OBJECT_ID ('dbo.ca_abono_det_his') IS NOT NULL
	DROP TABLE dbo.ca_abono_det_his
GO
IF OBJECT_ID ('dbo.ca_abono_his') IS NOT NULL
	DROP TABLE dbo.ca_abono_his
GO
IF OBJECT_ID ('dbo.ca_abono_rubro') IS NOT NULL
	DROP TABLE dbo.ca_abono_rubro
GO
IF OBJECT_ID ('dbo.ca_abono_rubro_his') IS NOT NULL
	DROP TABLE dbo.ca_abono_rubro_his
GO
IF OBJECT_ID ('dbo.ca_abonos_masivos_his') IS NOT NULL
	DROP TABLE dbo.ca_abonos_masivos_his
GO
IF OBJECT_ID ('dbo.ca_abonos_masivos_his_d') IS NOT NULL
	DROP TABLE dbo.ca_abonos_masivos_his_d
GO
IF OBJECT_ID ('dbo.ca_acciones_his') IS NOT NULL
	DROP TABLE dbo.ca_acciones_his
GO
IF OBJECT_ID ('dbo.ca_amortizacion') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion
GO
IF OBJECT_ID ('dbo.ca_amortizacion_ant_his') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_ant_his
GO
IF OBJECT_ID ('dbo.ca_amortizacion_his') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_his
GO
IF OBJECT_ID ('dbo.ca_conci_dia_findeter_his') IS NOT NULL
	DROP TABLE dbo.ca_conci_dia_findeter_his
GO
IF OBJECT_ID ('dbo.ca_correccion') IS NOT NULL
	DROP TABLE dbo.ca_correccion
GO
IF OBJECT_ID ('dbo.ca_correccion_his') IS NOT NULL
	DROP TABLE dbo.ca_correccion_his
GO
IF OBJECT_ID ('dbo.ca_cuota_adicional') IS NOT NULL
	DROP TABLE dbo.ca_cuota_adicional
GO
IF OBJECT_ID ('dbo.ca_cuota_adicional_his') IS NOT NULL
	DROP TABLE dbo.ca_cuota_adicional_his
GO
IF OBJECT_ID ('dbo.ca_cuota_diff') IS NOT NULL
	DROP TABLE dbo.ca_cuota_diff
GO
IF OBJECT_ID ('dbo.ca_cuota_diff_his') IS NOT NULL
	DROP TABLE dbo.ca_cuota_diff_his
GO
IF OBJECT_ID ('dbo.ca_cuota_diff_tmp') IS NOT NULL
	DROP TABLE dbo.ca_cuota_diff_tmp
GO
IF OBJECT_ID ('dbo.ca_det_trn') IS NOT NULL
	DROP TABLE dbo.ca_det_trn
GO
IF OBJECT_ID ('dbo.ca_diferidos') IS NOT NULL
	DROP TABLE dbo.ca_diferidos
GO
IF OBJECT_ID ('dbo.ca_diferidos_his') IS NOT NULL
	DROP TABLE dbo.ca_diferidos_his
GO
IF OBJECT_ID ('dbo.ca_dividendo') IS NOT NULL
	DROP TABLE dbo.ca_dividendo
GO
IF OBJECT_ID ('dbo.ca_dividendo_his') IS NOT NULL
	DROP TABLE dbo.ca_dividendo_his
GO
IF OBJECT_ID ('dbo.ca_facturas') IS NOT NULL
	DROP TABLE dbo.ca_facturas
GO
IF OBJECT_ID ('dbo.ca_facturas_his') IS NOT NULL
	DROP TABLE dbo.ca_facturas_his
GO
IF OBJECT_ID ('dbo.ca_maestro_operaciones') IS NOT NULL
	DROP TABLE dbo.ca_maestro_operaciones
GO
IF OBJECT_ID ('dbo.ca_operacion') IS NOT NULL
	DROP TABLE dbo.ca_operacion
GO
IF OBJECT_ID ('dbo.ca_operacion_hc') IS NOT NULL
	DROP TABLE dbo.ca_operacion_hc
GO
IF OBJECT_ID ('dbo.ca_operacion_his') IS NOT NULL
	DROP TABLE dbo.ca_operacion_his
GO
IF OBJECT_ID ('dbo.ca_operacion_ts') IS NOT NULL
	DROP TABLE dbo.ca_operacion_ts
GO
IF OBJECT_ID ('dbo.ca_reajuste') IS NOT NULL
	DROP TABLE dbo.ca_reajuste
GO
IF OBJECT_ID ('dbo.ca_reajuste_det') IS NOT NULL
	DROP TABLE dbo.ca_reajuste_det
GO
IF OBJECT_ID ('dbo.ca_relacion_ptmo_his') IS NOT NULL
	DROP TABLE dbo.ca_relacion_ptmo_his
GO
IF OBJECT_ID ('dbo.ca_reportar_cliente') IS NOT NULL
	DROP TABLE dbo.ca_reportar_cliente
GO
IF OBJECT_ID ('dbo.ca_reportar_cliente_his') IS NOT NULL
	DROP TABLE dbo.ca_reportar_cliente_his
GO
IF OBJECT_ID ('dbo.ca_rubro_op') IS NOT NULL
	DROP TABLE dbo.ca_rubro_op
GO
IF OBJECT_ID ('dbo.ca_rubro_op_his') IS NOT NULL
	DROP TABLE dbo.ca_rubro_op_his
GO
IF OBJECT_ID ('dbo.ca_rubro_op_ts') IS NOT NULL
	DROP TABLE dbo.ca_rubro_op_ts
GO
IF OBJECT_ID ('dbo.ca_saldos_cartera_mensual') IS NOT NULL
	DROP TABLE dbo.ca_saldos_cartera_mensual
GO
IF OBJECT_ID ('dbo.ca_tasas') IS NOT NULL
	DROP TABLE dbo.ca_tasas
GO
IF OBJECT_ID ('dbo.ca_transaccion') IS NOT NULL
	DROP TABLE dbo.ca_transaccion
GO
IF OBJECT_ID ('dbo.ca_traslado_interes') IS NOT NULL
	DROP TABLE dbo.ca_traslado_interes
GO
IF OBJECT_ID ('dbo.ca_traslado_interes_his') IS NOT NULL
	DROP TABLE dbo.ca_traslado_interes_his
GO
IF OBJECT_ID ('dbo.ca_ultima_tasa_op_his') IS NOT NULL
	DROP TABLE dbo.ca_ultima_tasa_op_his
GO
IF OBJECT_ID ('dbo.ca_valor_atx_his') IS NOT NULL
	DROP TABLE dbo.ca_valor_atx_his
GO
IF OBJECT_ID ('dbo.ca_valores') IS NOT NULL
	DROP TABLE dbo.ca_valores
GO
IF OBJECT_ID ('dbo.ca_valores_his') IS NOT NULL
	DROP TABLE dbo.ca_valores_his
GO
IF OBJECT_ID ('dbo.CONTROL_BATCH') IS NOT NULL
	DROP TABLE dbo.CONTROL_BATCH
GO
IF OBJECT_ID ('dbo.tmp_interes_amortiza_tmp') IS NOT NULL
	DROP TABLE dbo.tmp_interes_amortiza_tmp
GO
if OBJECT_ID ('dbo.ca_cli_emproblemado_tmp') IS NOT NULL
	drop table dbo.ca_cli_emproblemado_tmp
go

if OBJECT_ID ('dbo.ca_cli_emproblemado') IS NOT NULL
	drop table dbo.ca_cli_emproblemado
go

if OBJECT_ID ('dbo.ca_arch_cli_emproblemado') IS NOT NULL
	drop table dbo.ca_arch_cli_emproblemado
go

IF OBJECT_ID ('dbo.ca_comision_diferida') IS NOT NULL
	DROP TABLE dbo.ca_comision_diferida
go

IF OBJECT_ID ('dbo.ca_comision_diferida_his') IS NOT NULL
	DROP TABLE dbo.ca_comision_diferida_his
go

IF OBJECT_ID ('dbo.ca_operacion_ext') IS NOT NULL
	DROP TABLE dbo.ca_operacion_ext
GO

/*LRE 06/ENE/2016 CREACION DE LA TABLA HISTORICA DE PARAMETROS DE CARTERA */
IF OBJECT_ID ('dbo.ca_operacion_ext_his') IS NOT NULL
	DROP TABLE dbo.ca_operacion_ext_his
GO

/*LRE 06/ENE/2016 CREACION DE LA TABLA TEMPORAL DE PARAMETROS DE CARTERA */
IF OBJECT_ID ('dbo.ca_operacion_ext_tmp') IS NOT NULL
	DROP TABLE dbo.ca_operacion_ext_tmp
GO

IF OBJECT_ID ('dbo.ca_pago_en_corresponsal') IS NOT NULL
	DROP TABLE dbo.ca_pago_en_corresponsal
GO

IF OBJECT_ID ('dbo.ca_pago_en_corresponsal') IS NOT NULL
	DROP TABLE dbo.ca_grupos_vencidos
go

IF OBJECT_ID ('dbo.ca_pago_en_corresponsal') IS NOT NULL
	DROP TABLE dbo.gerentesxml
go

IF OBJECT_ID ('dbo.ca_pago_en_corresponsal') IS NOT NULL
	DROP TABLE dbo.coordinadoresxml
go

IF OBJECT_ID ('dbo.ca_pago_en_corresponsal') IS NOT NULL
	DROP TABLE dbo.asesoresxml
go

IF OBJECT_ID ('dbo.ca_pago_en_corresponsal') IS NOT NULL
	DROP TABLE dbo.ca_incumplimiento_aval
go

if OBJECT_ID ('dbo.ca_corresponsal_trn') IS NOT NULL
	drop table dbo.ca_corresponsal_trn
go

if OBJECT_ID ('dbo.ca_corresponsal_det') IS NOT NULL
	drop table dbo.ca_corresponsal_det
go

use cob_conta_super
go

if OBJECT_ID ('dbo.sb_reporte_A_0411') IS NOT NULL
	drop table sb_reporte_A_0411
go