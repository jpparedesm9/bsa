USE cob_credito
GO

IF OBJECT_ID ('dbo.vrc_maestro_obligaciones_tmp') IS NOT NULL
	DROP TABLE dbo.vrc_maestro_obligaciones_tmp
GO

IF OBJECT_ID ('dbo.vrc_maestro_garantias_tmp') IS NOT NULL
	DROP TABLE dbo.vrc_maestro_garantias_tmp
GO

IF OBJECT_ID ('dbo.vrc_caja_agraria_tmp') IS NOT NULL
	DROP TABLE dbo.vrc_caja_agraria_tmp
GO

IF OBJECT_ID ('dbo.ts_param_especiales_norm') IS NOT NULL
	DROP TABLE dbo.ts_param_especiales_norm
GO

IF OBJECT_ID ('dbo.ts_hono_mora') IS NOT NULL
	DROP TABLE dbo.ts_hono_mora
GO

IF OBJECT_ID ('dbo.ts_hono_abogado') IS NOT NULL
	DROP TABLE dbo.ts_hono_abogado
GO

IF OBJECT_ID ('dbo.ts_codigo_cartas') IS NOT NULL
	DROP TABLE dbo.ts_codigo_cartas
GO

IF OBJECT_ID ('dbo.ts_cartas_mora') IS NOT NULL
	DROP TABLE dbo.ts_cartas_mora
GO

IF OBJECT_ID ('dbo.ts_campana_toperacion') IS NOT NULL
	DROP TABLE dbo.ts_campana_toperacion
GO

IF OBJECT_ID ('dbo.tramites_anulados_542') IS NOT NULL
	DROP TABLE dbo.tramites_anulados_542
GO

IF OBJECT_ID ('dbo.tmp11') IS NOT NULL
	DROP TABLE dbo.tmp11
GO

IF OBJECT_ID ('dbo.tmp1') IS NOT NULL
	DROP TABLE dbo.tmp1
GO

IF OBJECT_ID ('dbo.tmp_foperaciones') IS NOT NULL
	DROP TABLE dbo.tmp_foperaciones
GO

IF OBJECT_ID ('dbo.tmp_acuerdos_bcp') IS NOT NULL
	DROP TABLE dbo.tmp_acuerdos_bcp
GO

IF OBJECT_ID ('dbo.tiempo') IS NOT NULL
	DROP TABLE dbo.tiempo
GO

IF OBJECT_ID ('dbo.tabla_Adminfo_CV') IS NOT NULL
	DROP TABLE dbo.tabla_Adminfo_CV
GO

IF OBJECT_ID ('dbo.tabla_adminf_referencias') IS NOT NULL
	DROP TABLE dbo.tabla_adminf_referencias
GO

IF OBJECT_ID ('dbo.tabla_adminf_pagos') IS NOT NULL
	DROP TABLE dbo.tabla_adminf_pagos
GO

IF OBJECT_ID ('dbo.tabla_adminf_operaciones') IS NOT NULL
	DROP TABLE dbo.tabla_adminf_operaciones
GO

IF OBJECT_ID ('dbo.tabla_adminf_gestion_ejecutivo') IS NOT NULL
	DROP TABLE dbo.tabla_adminf_gestion_ejecutivo
GO

IF OBJECT_ID ('dbo.tabla_adminf_direcciones') IS NOT NULL
	DROP TABLE dbo.tabla_adminf_direcciones
GO

IF OBJECT_ID ('dbo.tabla_adminf_codeudores') IS NOT NULL
	DROP TABLE dbo.tabla_adminf_codeudores
GO

IF OBJECT_ID ('dbo.tabla_adminf_clientes') IS NOT NULL
	DROP TABLE dbo.tabla_adminf_clientes
GO

IF OBJECT_ID ('dbo.t_tramrecha') IS NOT NULL
	DROP TABLE dbo.t_tramrecha
GO

IF OBJECT_ID ('dbo.t_datosol') IS NOT NULL
	DROP TABLE dbo.t_datosol
GO

IF OBJECT_ID ('dbo.t_credesembfu') IS NOT NULL
	DROP TABLE dbo.t_credesembfu
GO

IF OBJECT_ID ('dbo.t_abogados') IS NOT NULL
	DROP TABLE dbo.t_abogados
GO

IF OBJECT_ID ('dbo.sysdiagrams') IS NOT NULL
	DROP TABLE dbo.sysdiagrams
GO

IF OBJECT_ID ('dbo.rpt_n1') IS NOT NULL
	DROP TABLE dbo.rpt_n1
GO

IF OBJECT_ID ('dbo.rp_info_financiera') IS NOT NULL
	DROP TABLE dbo.rp_info_financiera
GO

IF OBJECT_ID ('dbo.rp_costo_merca_vendida') IS NOT NULL
	DROP TABLE dbo.rp_costo_merca_vendida
GO

IF OBJECT_ID ('dbo.reporte_desmarca_tmp') IS NOT NULL
	DROP TABLE dbo.reporte_desmarca_tmp
GO

IF OBJECT_ID ('dbo.reloj_mir') IS NOT NULL
	DROP TABLE dbo.reloj_mir
GO

IF OBJECT_ID ('dbo.pivote') IS NOT NULL
	DROP TABLE dbo.pivote
GO

IF OBJECT_ID ('dbo.ORS483_cupocred') IS NOT NULL
	DROP TABLE dbo.ORS483_cupocred
GO

IF OBJECT_ID ('dbo.ex_dato_provision_adicional') IS NOT NULL
	DROP TABLE dbo.ex_dato_provision_adicional
GO

IF OBJECT_ID ('dbo.cu_transaccion') IS NOT NULL
	DROP TABLE dbo.cu_transaccion
GO

IF OBJECT_ID ('dbo.cu_tmp_garcus') IS NOT NULL
	DROP TABLE dbo.cu_tmp_garcus
GO

IF OBJECT_ID ('dbo.cu_tmp_contagar_rep') IS NOT NULL
	DROP TABLE dbo.cu_tmp_contagar_rep
GO

IF OBJECT_ID ('dbo.cu_tipo_custodia_rep') IS NOT NULL
	DROP TABLE dbo.cu_tipo_custodia_rep
GO

IF OBJECT_ID ('dbo.cu_procesos_maegar_tmp') IS NOT NULL
	DROP TABLE dbo.cu_procesos_maegar_tmp
GO

IF OBJECT_ID ('dbo.cu_item') IS NOT NULL
	DROP TABLE dbo.cu_item
GO

IF OBJECT_ID ('dbo.cu_doc_fng_tmp') IS NOT NULL
	DROP TABLE dbo.cu_doc_fng_tmp
GO

IF OBJECT_ID ('dbo.cu_distr_garantia_rep') IS NOT NULL
	DROP TABLE dbo.cu_distr_garantia_rep
GO

IF OBJECT_ID ('dbo.cu_custodia_rep') IS NOT NULL
	DROP TABLE dbo.cu_custodia_rep
GO

IF OBJECT_ID ('dbo.ct_tmp_ajuste_trc') IS NOT NULL
	DROP TABLE dbo.ct_tmp_ajuste_trc
GO

IF OBJECT_ID ('dbo.cr_variables_filtros') IS NOT NULL
	DROP TABLE dbo.cr_variables_filtros
GO

IF OBJECT_ID ('dbo.cr_var_entrada_mir') IS NOT NULL
	DROP TABLE dbo.cr_var_entrada_mir
GO

IF OBJECT_ID ('dbo.cr_valsal') IS NOT NULL
	DROP TABLE dbo.cr_valsal
GO

IF OBJECT_ID ('dbo.cr_valor_variables_filtros') IS NOT NULL
	DROP TABLE dbo.cr_valor_variables_filtros
GO

IF OBJECT_ID ('dbo.cr_valor_variables') IS NOT NULL
	DROP TABLE dbo.cr_valor_variables
GO

IF OBJECT_ID ('dbo.cr_valor_provision') IS NOT NULL
	DROP TABLE dbo.cr_valor_provision
GO

IF OBJECT_ID ('dbo.cr_valor_prov') IS NOT NULL
	DROP TABLE dbo.cr_valor_prov
GO

IF OBJECT_ID ('dbo.cr_val_prorep_tot') IS NOT NULL
	DROP TABLE dbo.cr_val_prorep_tot
GO

IF OBJECT_ID ('dbo.cr_val_prorep') IS NOT NULL
	DROP TABLE dbo.cr_val_prorep
GO

IF OBJECT_ID ('dbo.cr_val_calif') IS NOT NULL
	DROP TABLE dbo.cr_val_calif
GO

IF OBJECT_ID ('dbo.cr_utiliz') IS NOT NULL
	DROP TABLE dbo.cr_utiliz
GO

IF OBJECT_ID ('dbo.cr_update_credito') IS NOT NULL
	DROP TABLE dbo.cr_update_credito
GO

IF OBJECT_ID ('dbo.cr_universo_msv') IS NOT NULL
	DROP TABLE dbo.cr_universo_msv
GO

IF OBJECT_ID ('dbo.cr_ttram_toperacion') IS NOT NULL
	DROP TABLE dbo.cr_ttram_toperacion
GO

IF OBJECT_ID ('dbo.cr_truta') IS NOT NULL
	DROP TABLE dbo.cr_truta
GO

IF OBJECT_ID ('dbo.cr_traslados_tramites') IS NOT NULL
	DROP TABLE dbo.cr_traslados_tramites
GO

IF OBJECT_ID ('dbo.cr_transicion_provision') IS NOT NULL
	DROP TABLE dbo.cr_transicion_provision
GO

IF OBJECT_ID ('dbo.cr_transaccion') IS NOT NULL
	DROP TABLE dbo.cr_transaccion
GO

IF OBJECT_ID ('dbo.cr_tran_servicio') IS NOT NULL
	DROP TABLE dbo.cr_tran_servicio
GO

IF OBJECT_ID ('dbo.cr_tramites_rechazados_tmp') IS NOT NULL
	DROP TABLE dbo.cr_tramites_rechazados_tmp
GO

IF OBJECT_ID ('dbo.cr_tramites_rechazados_bk') IS NOT NULL
	DROP TABLE dbo.cr_tramites_rechazados_bk
GO

IF OBJECT_ID ('dbo.cr_tramites_mir') IS NOT NULL
	DROP TABLE dbo.cr_tramites_mir
GO

IF OBJECT_ID ('dbo.cr_tramites_gp') IS NOT NULL
	DROP TABLE dbo.cr_tramites_gp
GO

IF OBJECT_ID ('dbo.cr_tramites_contingencias') IS NOT NULL
	DROP TABLE dbo.cr_tramites_contingencias
GO

IF OBJECT_ID ('cr_tramite_vueloConGarUSAID_tmp') IS NOT NULL
	DROP TABLE cr_tramite_vueloConGarUSAID_tmp
GO

IF OBJECT_ID ('cr_total_op') IS NOT NULL
   DROP TABLE cr_total_op
GO

IF OBJECT_ID ('cr_toperacion_fuente') IS NOT NULL
   DROP TABLE cr_toperacion_fuente
GO

IF OBJECT_ID ('cr_toperacion') IS NOT NULL
   DROP TABLE cr_toperacion
GO

IF OBJECT_ID ('cr_tmpoficrt') IS NOT NULL
   DROP TABLE cr_tmpoficrt
GO

IF OBJECT_ID ('cr_tmpofic23') IS NOT NULL
   DROP TABLE cr_tmpofic23
GO

IF OBJECT_ID ('cr_tmpcte_tmp') IS NOT NULL
   DROP TABLE cr_tmpcte_tmp
GO

IF OBJECT_ID ('cr_tmpcooreof') IS NOT NULL
   DROP TABLE cr_tmpcooreof
GO

IF OBJECT_ID ('cr_tmpcoore08') IS NOT NULL
   DROP TABLE cr_tmpcoore08
GO

IF OBJECT_ID ('cr_tmpcoore01') IS NOT NULL
   DROP TABLE cr_tmpcoore01
GO

IF OBJECT_ID ('cr_tmpcooof08') IS NOT NULL
   DROP TABLE cr_tmpcooof08
GO

IF OBJECT_ID ('cr_tmpcooof01') IS NOT NULL
   DROP TABLE cr_tmpcooof01
GO

IF OBJECT_ID ('cr_tmpcoofc10') IS NOT NULL
   DROP TABLE cr_tmpcoofc10
GO

IF OBJECT_ID ('cr_tmpcoofc01') IS NOT NULL
   DROP TABLE cr_tmpcoofc01
GO

IF OBJECT_ID ('cr_tmpcontrgp') IS NOT NULL
   DROP TABLE cr_tmpcontrgp
GO

IF OBJECT_ID ('cr_tmp28_sp_sec') IS NOT NULL
   DROP TABLE cr_tmp28_sp_sec
GO

IF OBJECT_ID ('cr_tmp_tipo') IS NOT NULL
   DROP TABLE cr_tmp_tipo
GO

IF OBJECT_ID ('cr_tmp_supend') IS NOT NULL
   DROP TABLE cr_tmp_supend
GO

IF OBJECT_ID ('cr_tmp_sfc_rechazo') IS NOT NULL
   DROP TABLE cr_tmp_sfc_rechazo
GO

IF OBJECT_ID ('cr_tmp_sfc_microempresa') IS NOT NULL
   DROP TABLE cr_tmp_sfc_microempresa
GO

IF OBJECT_ID ('cr_tmp_sfc_materia_prima') IS NOT NULL
   DROP TABLE cr_tmp_sfc_materia_prima
GO

IF OBJECT_ID ('cr_tmp_sfc_inf_fina') IS NOT NULL
   DROP TABLE cr_tmp_sfc_inf_fina
GO

IF OBJECT_ID ('cr_tmp_sfc_det_inf_financiera') IS NOT NULL
   DROP TABLE cr_tmp_sfc_det_inf_financiera
GO

IF OBJECT_ID ('cr_tmp_sfc_dec_jurada') IS NOT NULL
   DROP TABLE cr_tmp_sfc_dec_jurada
GO

IF OBJECT_ID ('cr_tmp_sfc_costo_productor') IS NOT NULL
   DROP TABLE cr_tmp_sfc_costo_productor
GO

IF OBJECT_ID ('cr_tmp_sfc_costo_mercancia') IS NOT NULL
   DROP TABLE cr_tmp_sfc_costo_mercancia
GO

IF OBJECT_ID ('cr_tmp_sfc_cos_tip_detalle') IS NOT NULL
   DROP TABLE cr_tmp_sfc_cos_tip_detalle
GO

IF OBJECT_ID ('cr_tmp_sfc_cos_tip') IS NOT NULL
   DROP TABLE cr_tmp_sfc_cos_tip
GO

IF OBJECT_ID ('cr_tmp_resultados') IS NOT NULL
   DROP TABLE cr_tmp_resultados
GO

IF OBJECT_ID ('cr_tmp_resultado_gral2') IS NOT NULL
   DROP TABLE cr_tmp_resultado_gral2
GO

IF OBJECT_ID ('cr_tmp_provad') IS NOT NULL
   DROP TABLE cr_tmp_provad
GO

IF OBJECT_ID ('cr_tmp_previa') IS NOT NULL
   DROP TABLE cr_tmp_previa
GO

IF OBJECT_ID ('cr_tmp_papelera_3') IS NOT NULL
   DROP TABLE cr_tmp_papelera_3
GO

IF OBJECT_ID ('cr_tmp_papelera') IS NOT NULL
   DROP TABLE cr_tmp_papelera
GO

IF OBJECT_ID ('cr_tmp_opred') IS NOT NULL
   DROP TABLE cr_tmp_opred
GO

IF OBJECT_ID ('cr_tmp_oppas11') IS NOT NULL
   DROP TABLE cr_tmp_oppas11
GO

IF OBJECT_ID ('cr_tmp_operacion_cobranza') IS NOT NULL
   DROP TABLE cr_tmp_operacion_cobranza
GO

IF OBJECT_ID ('cr_tmp_op') IS NOT NULL
   DROP TABLE cr_tmp_op
GO

IF OBJECT_ID ('cr_tmp_observacion') IS NOT NULL
   DROP TABLE cr_tmp_observacion
GO

IF OBJECT_ID ('cr_tmp_lineas') IS NOT NULL
   DROP TABLE cr_tmp_lineas
GO

IF OBJECT_ID ('cr_tmp_inf_lineas') IS NOT NULL
   DROP TABLE cr_tmp_inf_lineas
GO

IF OBJECT_ID ('cr_tmp_garfag') IS NOT NULL
   DROP TABLE cr_tmp_garfag
GO

IF OBJECT_ID ('cr_tmp_finban') IS NOT NULL
   DROP TABLE cr_tmp_finban
GO

IF OBJECT_ID ('cr_tmp_fagdest') IS NOT NULL
   DROP TABLE cr_tmp_fagdest
GO

IF OBJECT_ID ('cr_tmp_fag') IS NOT NULL
   DROP TABLE cr_tmp_fag
GO

IF OBJECT_ID ('cr_tmp_excep') IS NOT NULL
   DROP TABLE cr_tmp_excep
GO

IF OBJECT_ID ('cr_tmp_elegibilidad') IS NOT NULL
   DROP TABLE cr_tmp_elegibilidad
GO

IF OBJECT_ID ('cr_tmp_distr_of') IS NOT NULL
   DROP TABLE cr_tmp_distr_of
GO

IF OBJECT_ID ('cr_tmp_desemb') IS NOT NULL
   DROP TABLE cr_tmp_desemb
GO

IF OBJECT_ID ('cr_tmp_datooper') IS NOT NULL
   DROP TABLE cr_tmp_datooper
GO

IF OBJECT_ID ('cr_tmp_datogar_otras') IS NOT NULL
   DROP TABLE cr_tmp_datogar_otras
GO

IF OBJECT_ID ('cr_tmp_datad_finagro') IS NOT NULL
   DROP TABLE cr_tmp_datad_finagro
GO

IF OBJECT_ID ('cr_tmp_conti_oo') IS NOT NULL
   DROP TABLE cr_tmp_conti_oo
GO

IF OBJECT_ID ('cr_tmp_confag') IS NOT NULL
   DROP TABLE cr_tmp_confag
GO

IF OBJECT_ID ('cr_tmp_conex') IS NOT NULL
   DROP TABLE cr_tmp_conex
GO

IF OBJECT_ID ('cr_tmp_condicion_linea') IS NOT NULL
   DROP TABLE cr_tmp_condicion_linea
GO

IF OBJECT_ID ('cr_tmp_conclusiones') IS NOT NULL
   DROP TABLE cr_tmp_conclusiones
GO

IF OBJECT_ID ('cr_tmp_concepto_dia') IS NOT NULL
   DROP TABLE cr_tmp_concepto_dia
GO

IF OBJECT_ID ('cr_tmp_concepto') IS NOT NULL
   DROP TABLE cr_tmp_concepto
GO

IF OBJECT_ID ('cr_tmp_con_lineas') IS NOT NULL
   DROP TABLE cr_tmp_con_lineas
GO

IF OBJECT_ID ('cr_tmp_comentarios') IS NOT NULL
   DROP TABLE cr_tmp_comentarios
GO

IF OBJECT_ID ('cr_tmp_cobranza') IS NOT NULL
   DROP TABLE cr_tmp_cobranza
GO

IF OBJECT_ID ('cr_tmp_carga_sus_rtm') IS NOT NULL
   DROP TABLE cr_tmp_carga_sus_rtm
GO

IF OBJECT_ID ('cr_tmp_carga_sus') IS NOT NULL
   DROP TABLE cr_tmp_carga_sus
GO

IF OBJECT_ID ('cr_tmp_carga_rtm') IS NOT NULL
   DROP TABLE cr_tmp_carga_rtm
GO

IF OBJECT_ID ('cr_tmp_carga') IS NOT NULL
   DROP TABLE cr_tmp_carga
GO

IF OBJECT_ID ('cr_tmp_calificaciones_op') IS NOT NULL
   DROP TABLE cr_tmp_calificaciones_op
GO

IF OBJECT_ID ('cr_tmp_calificacion_op') IS NOT NULL
   DROP TABLE cr_tmp_calificacion_op
GO

IF OBJECT_ID ('cr_tmp_calif_provision') IS NOT NULL
   DROP TABLE cr_tmp_calif_provision
GO

IF OBJECT_ID ('cr_tmp_asig2') IS NOT NULL
   DROP TABLE cr_tmp_asig2
GO

IF OBJECT_ID ('cr_tmp_asiento') IS NOT NULL
   DROP TABLE cr_tmp_asiento
GO

IF OBJECT_ID ('cr_tmp_arred') IS NOT NULL
   DROP TABLE cr_tmp_arred
GO

IF OBJECT_ID ('cr_tmp_accme') IS NOT NULL
   DROP TABLE cr_tmp_accme
GO

IF OBJECT_ID ('cr_tmp_acciones') IS NOT NULL
   DROP TABLE cr_tmp_acciones
GO

IF OBJECT_ID ('cr_tmp_abogado_aux') IS NOT NULL
   DROP TABLE cr_tmp_abogado_aux
GO

IF OBJECT_ID ('cr_tmp_abogado') IS NOT NULL
   DROP TABLE cr_tmp_abogado
GO

IF OBJECT_ID ('cr_tipos_fng_temp') IS NOT NULL
   DROP TABLE cr_tipos_fng_temp
GO

IF OBJECT_ID ('cr_tipos_fag_ftemp') IS NOT NULL
   DROP TABLE cr_tipos_fag_ftemp
GO

IF OBJECT_ID ('cr_tipocob_estado') IS NOT NULL
   DROP TABLE cr_tipocob_estado
GO

IF OBJECT_ID ('cr_tipo_tramite') IS NOT NULL
   DROP TABLE cr_tipo_tramite
GO

IF OBJECT_ID ('cr_tipo_seguro') IS NOT NULL
   DROP TABLE cr_tipo_seguro
GO

IF OBJECT_ID ('cr_tipo_oficina') IS NOT NULL
   DROP TABLE cr_tipo_oficina
GO

IF OBJECT_ID ('cr_tipo_empresa') IS NOT NULL
   DROP TABLE cr_tipo_empresa
GO

IF OBJECT_ID ('cr_tipo_actual_gp') IS NOT NULL
   DROP TABLE cr_tipo_actual_gp
GO

IF OBJECT_ID ('cr_tinstruccion') IS NOT NULL
   DROP TABLE cr_tinstruccion
GO

IF OBJECT_ID ('cr_texcepcion') IS NOT NULL
   DROP TABLE cr_texcepcion
GO

IF OBJECT_ID ('cr_temporalidad_det') IS NOT NULL
   DROP TABLE cr_temporalidad_det
GO

IF OBJECT_ID ('cr_temporal3') IS NOT NULL
   DROP TABLE cr_temporal3
GO

IF OBJECT_ID ('cr_temporal2') IS NOT NULL
   DROP TABLE cr_temporal2
GO

IF OBJECT_ID ('cr_temporal1') IS NOT NULL
   DROP TABLE cr_temporal1
GO

IF OBJECT_ID ('cr_temporal_C') IS NOT NULL
   DROP TABLE cr_temporal_C
GO

IF OBJECT_ID ('cr_temporal_2') IS NOT NULL
   DROP TABLE cr_temporal_2
GO

IF OBJECT_ID ('cr_temporal_1') IS NOT NULL
   DROP TABLE cr_temporal_1
GO

IF OBJECT_ID ('cr_temporal') IS NOT NULL
   DROP TABLE cr_temporal
GO

IF OBJECT_ID ('cr_tempo_02') IS NOT NULL
   DROP TABLE cr_tempo_02
GO

IF OBJECT_ID ('cr_tempo_01') IS NOT NULL
   DROP TABLE cr_tempo_01
GO

IF OBJECT_ID ('cr_temp4_tmp') IS NOT NULL
   DROP TABLE cr_temp4_tmp
GO

IF OBJECT_ID ('cr_temp24_opc_cpa') IS NOT NULL
   DROP TABLE cr_temp24_opc_cpa
GO

IF OBJECT_ID ('cr_temp1_sp_cof0') IS NOT NULL
   DROP TABLE cr_temp1_sp_cof0
GO

IF OBJECT_ID ('cr_temp1_sp_cof') IS NOT NULL
   DROP TABLE cr_temp1_sp_cof
GO

IF OBJECT_ID ('cr_temp1_bc') IS NOT NULL
   DROP TABLE cr_temp1_bc
GO

IF OBJECT_ID ('cr_temp1') IS NOT NULL
   DROP TABLE cr_temp1
GO

IF OBJECT_ID ('cr_temp_vistas_tra') IS NOT NULL
   DROP TABLE cr_temp_vistas_tra
GO

IF OBJECT_ID ('cr_temp_sp_coc0') IS NOT NULL
   DROP TABLE cr_temp_sp_coc0
GO

IF OBJECT_ID ('cr_temp_sp_coc') IS NOT NULL
   DROP TABLE cr_temp_sp_coc
GO

IF OBJECT_ID ('cr_temp_retram') IS NOT NULL
   DROP TABLE cr_temp_retram
GO

IF OBJECT_ID ('cr_temp_report_tram') IS NOT NULL
   DROP TABLE cr_temp_report_tram
GO

IF OBJECT_ID ('cr_temp_oficina') IS NOT NULL
   DROP TABLE cr_temp_oficina
GO

IF OBJECT_ID ('cr_temp_gral2') IS NOT NULL
   DROP TABLE cr_temp_gral2
GO

IF OBJECT_ID ('cr_temp_etapa') IS NOT NULL
   DROP TABLE cr_temp_etapa
GO

IF OBJECT_ID ('cr_temp_cupo_bc') IS NOT NULL
   DROP TABLE cr_temp_cupo_bc
GO

IF OBJECT_ID ('cr_temp_bc') IS NOT NULL
   DROP TABLE cr_temp_bc
GO

IF OBJECT_ID ('cr_temp_archger1') IS NOT NULL
   DROP TABLE cr_temp_archger1
GO

IF OBJECT_ID ('cr_temp_archger') IS NOT NULL
   DROP TABLE cr_temp_archger
GO

IF OBJECT_ID ('cr_tel_abogado') IS NOT NULL
   DROP TABLE cr_tel_abogado
GO

IF OBJECT_ID ('cr_tcalificacion') IS NOT NULL
   DROP TABLE cr_tcalificacion
GO

IF OBJECT_ID ('cr_tbl_solicall_tmp') IS NOT NULL
   DROP TABLE cr_tbl_solicall_tmp
GO

IF OBJECT_ID ('cr_tarifa_honorarios_FAG') IS NOT NULL
   DROP TABLE cr_tarifa_honorarios_FAG
GO

IF OBJECT_ID ('cr_tarifa_honorarios') IS NOT NULL
   DROP TABLE cr_tarifa_honorarios
GO

IF OBJECT_ID ('cr_superior_gp_esp') IS NOT NULL
   DROP TABLE cr_superior_gp_esp
GO

IF OBJECT_ID ('cr_superior_gp') IS NOT NULL
   DROP TABLE cr_superior_gp
GO

IF OBJECT_ID ('cr_sol_masiva_tmp') IS NOT NULL
   DROP TABLE cr_sol_masiva_tmp
GO

IF OBJECT_ID ('cr_sol_masiva_rep') IS NOT NULL
   DROP TABLE cr_sol_masiva_rep
GO

IF OBJECT_ID ('cr_sol_masiva_cab') IS NOT NULL
   DROP TABLE cr_sol_masiva_cab
GO

IF OBJECT_ID ('cr_semaforo') IS NOT NULL
   DROP TABLE cr_semaforo
GO

IF OBJECT_ID ('cr_seguros_tramite') IS NOT NULL
   DROP TABLE cr_seguros_tramite
GO

IF OBJECT_ID ('cr_seguros_estadistica') IS NOT NULL
   DROP TABLE cr_seguros_estadistica
GO

IF OBJECT_ID ('cr_seguro_plan') IS NOT NULL
   DROP TABLE cr_seguro_plan
GO

IF OBJECT_ID ('cr_seguro_parentesco') IS NOT NULL
   DROP TABLE cr_seguro_parentesco
GO

IF OBJECT_ID ('cr_seguro_exequial') IS NOT NULL
   DROP TABLE cr_seguro_exequial
GO

IF OBJECT_ID ('cr_secuencial_cca') IS NOT NULL
   DROP TABLE cr_secuencial_cca
GO

IF OBJECT_ID ('cr_secuencia_tmp') IS NOT NULL
   DROP TABLE cr_secuencia_tmp
GO

IF OBJECT_ID ('cr_secuencia') IS NOT NULL
   DROP TABLE cr_secuencia
GO

IF OBJECT_ID ('cr_saldos_con') IS NOT NULL
   DROP TABLE cr_saldos_con
GO

IF OBJECT_ID ('cr_ruta_tramite_ORS_1318') IS NOT NULL
   DROP TABLE cr_ruta_tramite_ORS_1318
GO

IF OBJECT_ID ('cr_ruta_tramite_ORS_1263') IS NOT NULL
   DROP TABLE cr_ruta_tramite_ORS_1263
GO

IF OBJECT_ID ('cr_ruta_tramite_ORS_1236') IS NOT NULL
   DROP TABLE cr_ruta_tramite_ORS_1236
GO

IF OBJECT_ID ('cr_ruta_tramite_INC_274214') IS NOT NULL
   DROP TABLE cr_ruta_tramite_INC_274214
GO

IF OBJECT_ID ('cr_ruta_tramite_INC_272490') IS NOT NULL
   DROP TABLE cr_ruta_tramite_INC_272490
GO

IF OBJECT_ID ('cr_ruta_tramite_INC_262540') IS NOT NULL
   DROP TABLE cr_ruta_tramite_INC_262540
GO

IF OBJECT_ID ('cr_ruta_tramite_INC_253008') IS NOT NULL
   DROP TABLE cr_ruta_tramite_INC_253008
GO

IF OBJECT_ID ('cr_ruta_tramite_INC_248763') IS NOT NULL
   DROP TABLE cr_ruta_tramite_INC_248763
GO

IF OBJECT_ID ('cr_ruta_tramite_INC_245278') IS NOT NULL
   DROP TABLE cr_ruta_tramite_INC_245278
GO

IF OBJECT_ID ('cr_ruta_tramite') IS NOT NULL
   DROP TABLE cr_ruta_tramite
GO

IF OBJECT_ID ('cr_ruta_filtros') IS NOT NULL
   DROP TABLE cr_ruta_filtros
GO

IF OBJECT_ID ('cr_ruta_est_tra') IS NOT NULL
   DROP TABLE cr_ruta_est_tra
GO

IF OBJECT_ID ('cr_rub_renovar') IS NOT NULL
   DROP TABLE cr_rub_renovar
GO

IF OBJECT_ID ('cr_rub_pag_reest') IS NOT NULL
   DROP TABLE cr_rub_pag_reest
GO

IF OBJECT_ID ('cr_rssal') IS NOT NULL
   DROP TABLE cr_rssal
GO

IF OBJECT_ID ('cr_rsald') IS NOT NULL
   DROP TABLE cr_rsald
GO

IF OBJECT_ID ('cr_rpt_clican_nre') IS NOT NULL
   DROP TABLE cr_rpt_clican_nre
GO

IF OBJECT_ID ('cr_resumen_tramites') IS NOT NULL
   DROP TABLE cr_resumen_tramites
GO

IF OBJECT_ID ('cr_resumen_saldos_semestral') IS NOT NULL
   DROP TABLE cr_resumen_saldos_semestral
GO

IF OBJECT_ID ('cr_resumen_saldos') IS NOT NULL
   DROP TABLE cr_resumen_saldos
GO

IF OBJECT_ID ('cr_resumen_rango_plazo') IS NOT NULL
   DROP TABLE cr_resumen_rango_plazo
GO

IF OBJECT_ID ('cr_resumen_rango_mora') IS NOT NULL
   DROP TABLE cr_resumen_rango_mora
GO

IF OBJECT_ID ('cr_resumen_rango_monto') IS NOT NULL
   DROP TABLE cr_resumen_rango_monto
GO

IF OBJECT_ID ('cr_resumen_rango_edad') IS NOT NULL
   DROP TABLE cr_resumen_rango_edad
GO

IF OBJECT_ID ('cr_resumen_prov_tmp') IS NOT NULL
   DROP TABLE cr_resumen_prov_tmp
GO

IF OBJECT_ID ('cr_resumen_oficiales') IS NOT NULL
   DROP TABLE cr_resumen_oficiales
GO

IF OBJECT_ID ('cr_resumen_clientes') IS NOT NULL
   DROP TABLE cr_resumen_clientes
GO

IF OBJECT_ID ('cr_resultado1_temporal') IS NOT NULL
   DROP TABLE cr_resultado1_temporal
GO

IF OBJECT_ID ('cr_resultado_tmp') IS NOT NULL
   DROP TABLE cr_resultado_tmp
GO

IF OBJECT_ID ('cr_respuestas_det') IS NOT NULL
   DROP TABLE cr_respuestas_det
GO

IF OBJECT_ID ('cr_respuestas') IS NOT NULL
   DROP TABLE cr_respuestas
GO

IF OBJECT_ID ('cr_respuesta_mir_ws') IS NOT NULL
   DROP TABLE cr_respuesta_mir_ws
GO

IF OBJECT_ID ('cr_respuesta_mir') IS NOT NULL
   DROP TABLE cr_respuesta_mir
GO

IF OBJECT_ID ('cr_res_tplan_tmp') IS NOT NULL
   DROP TABLE cr_res_tplan_tmp
GO

IF OBJECT_ID ('cr_res_saldos_oficial') IS NOT NULL
   DROP TABLE cr_res_saldos_oficial
GO

IF OBJECT_ID ('cr_res_saldos_of_ac') IS NOT NULL
   DROP TABLE cr_res_saldos_of_ac
GO

IF OBJECT_ID ('cr_res_carga_rpt') IS NOT NULL
   DROP TABLE cr_res_carga_rpt
GO

IF OBJECT_ID ('cr_req_tramite') IS NOT NULL
   DROP TABLE cr_req_tramite
GO

IF OBJECT_ID ('cr_req_etapa') IS NOT NULL
   DROP TABLE cr_req_etapa
GO

IF OBJECT_ID ('cr_req_estado') IS NOT NULL
   DROP TABLE cr_req_estado
GO

IF OBJECT_ID ('cr_req_cobranza') IS NOT NULL
   DROP TABLE cr_req_cobranza
GO

IF OBJECT_ID ('cr_repuntuacion') IS NOT NULL
   DROP TABLE cr_repuntuacion
GO

IF OBJECT_ID ('cr_reprie2') IS NOT NULL
   DROP TABLE cr_reprie2
GO

IF OBJECT_ID ('cr_reprie1') IS NOT NULL
   DROP TABLE cr_reprie1
GO

IF OBJECT_ID ('cr_reprie') IS NOT NULL
   DROP TABLE cr_reprie
GO

IF OBJECT_ID ('cr_reporte064') IS NOT NULL
   DROP TABLE cr_reporte064
GO

IF OBJECT_ID ('cr_reporte041_tmp') IS NOT NULL
   DROP TABLE cr_reporte041_tmp
GO

IF OBJECT_ID ('cr_reporte041') IS NOT NULL
   DROP TABLE cr_reporte041
GO

IF OBJECT_ID ('cr_reporte_transaccion') IS NOT NULL
   DROP TABLE cr_reporte_transaccion
GO

IF OBJECT_ID ('cr_reporte_reest_nyd') IS NOT NULL
   DROP TABLE cr_reporte_reest_nyd
GO

IF OBJECT_ID ('cr_reporte_cob_juridico_tmp') IS NOT NULL
   DROP TABLE cr_reporte_cob_juridico_tmp
GO

IF OBJECT_ID ('cr_reporte_ccagrl') IS NOT NULL
   DROP TABLE cr_reporte_ccagrl
GO

IF OBJECT_ID ('cr_reporte_campana_det') IS NOT NULL
   DROP TABLE cr_reporte_campana_det
GO

IF OBJECT_ID ('cr_reporte_campana_cab') IS NOT NULL
   DROP TABLE cr_reporte_campana_cab
GO

IF OBJECT_ID ('cr_reporte_066') IS NOT NULL
   DROP TABLE cr_reporte_066
GO

IF OBJECT_ID ('cr_reporte_061') IS NOT NULL
   DROP TABLE cr_reporte_061
GO

IF OBJECT_ID ('cr_reporte_050') IS NOT NULL
   DROP TABLE cr_reporte_050
GO

IF OBJECT_ID ('cr_reportar_anuladas_err') IS NOT NULL
   DROP TABLE cr_reportar_anuladas_err
GO

IF OBJECT_ID ('cr_repcc') IS NOT NULL
   DROP TABLE cr_repcc
GO

IF OBJECT_ID ('cr_repae_ref') IS NOT NULL
   DROP TABLE cr_repae_ref
GO

IF OBJECT_ID ('cr_repae_gar') IS NOT NULL
   DROP TABLE cr_repae_gar
GO

IF OBJECT_ID ('cr_repae') IS NOT NULL
   DROP TABLE cr_repae
GO

IF OBJECT_ID ('cr_rep_tram_mir') IS NOT NULL
   DROP TABLE cr_rep_tram_mir
GO

IF OBJECT_ID ('cr_rep_tr_neg') IS NOT NULL
   DROP TABLE cr_rep_tr_neg
GO

IF OBJECT_ID ('cr_rep_set_lima') IS NOT NULL
   DROP TABLE cr_rep_set_lima
GO

IF OBJECT_ID ('cr_rep_asigab') IS NOT NULL
   DROP TABLE cr_rep_asigab
GO

IF OBJECT_ID ('cr_rep_archger') IS NOT NULL
   DROP TABLE cr_rep_archger
GO

IF OBJECT_ID ('cr_renovaciones_provision') IS NOT NULL
   DROP TABLE cr_renovaciones_provision
GO

IF OBJECT_ID ('cr_reno_provi') IS NOT NULL
   DROP TABLE cr_reno_provi
GO

IF OBJECT_ID ('cr_reico') IS NOT NULL
   DROP TABLE cr_reico
GO

IF OBJECT_ID ('cr_regla') IS NOT NULL
   DROP TABLE cr_regla
GO

IF OBJECT_ID ('cr_regct6_gpe') IS NOT NULL
   DROP TABLE cr_regct6_gpe
GO

IF OBJECT_ID ('cr_reest_gracia') IS NOT NULL
   DROP TABLE cr_reest_gracia
GO

IF OBJECT_ID ('cr_recprov') IS NOT NULL
   DROP TABLE cr_recprov
GO

IF OBJECT_ID ('cr_reconoc_icr') IS NOT NULL
   DROP TABLE cr_reconoc_icr
GO

IF OBJECT_ID ('cr_rechazos_tram_rpt') IS NOT NULL
   DROP TABLE cr_rechazos_tram_rpt
GO

IF OBJECT_ID ('cr_reasigna_ope') IS NOT NULL
   DROP TABLE cr_reasigna_ope
GO

IF OBJECT_ID ('cr_puntaje_segmento') IS NOT NULL
   DROP TABLE cr_puntaje_segmento
GO

IF OBJECT_ID ('cr_puntaje_calificacion_mrco') IS NOT NULL
   DROP TABLE cr_puntaje_calificacion_mrco
GO

IF OBJECT_ID ('cr_prueba_aanterior') IS NOT NULL
   DROP TABLE cr_prueba_aanterior
GO

IF OBJECT_ID ('cr_proyrecuperapas_tmp') IS NOT NULL
   DROP TABLE cr_proyrecuperapas_tmp
GO

IF OBJECT_ID ('cr_proyrecuperapas') IS NOT NULL
   DROP TABLE cr_proyrecuperapas
GO

IF OBJECT_ID ('cr_proyrecupera_tmp') IS NOT NULL
   DROP TABLE cr_proyrecupera_tmp
GO

IF OBJECT_ID ('cr_proyrecupera') IS NOT NULL
   DROP TABLE cr_proyrecupera
GO

IF OBJECT_ID ('cr_proyeccion_recup_rpt') IS NOT NULL
   DROP TABLE cr_proyeccion_recup_rpt
GO

IF OBJECT_ID ('cr_provisiones_hc') IS NOT NULL
   DROP TABLE cr_provisiones_hc
GO

IF OBJECT_ID ('cr_provisiones_det') IS NOT NULL
   DROP TABLE cr_provisiones_det
GO

IF OBJECT_ID ('cr_provision_periodo_anterior') IS NOT NULL
   DROP TABLE cr_provision_periodo_anterior
GO

IF OBJECT_ID ('cr_provision_old_ofi') IS NOT NULL
   DROP TABLE cr_provision_old_ofi
GO

IF OBJECT_ID ('cr_provision_ant_ofi') IS NOT NULL
   DROP TABLE cr_provision_ant_ofi
GO

IF OBJECT_ID ('cr_provad_manual') IS NOT NULL
   DROP TABLE cr_provad_manual
GO

IF OBJECT_ID ('cr_prov_recu') IS NOT NULL
   DROP TABLE cr_prov_recu
GO

IF OBJECT_ID ('cr_prov_anos_ant_dia') IS NOT NULL
   DROP TABLE cr_prov_anos_ant_dia
GO

IF OBJECT_ID ('cr_prov_anos_ant') IS NOT NULL
   DROP TABLE cr_prov_anos_ant
GO

IF OBJECT_ID ('cr_prospecto_contraoferta') IS NOT NULL
   DROP TABLE cr_prospecto_contraoferta
GO

IF OBJECT_ID ('cr_programacion_comite') IS NOT NULL
   DROP TABLE cr_programacion_comite
GO

IF OBJECT_ID ('cr_procesos_tarjeta_tmp') IS NOT NULL
   DROP TABLE cr_procesos_tarjeta_tmp
GO

IF OBJECT_ID ('cr_procesos_paralelo') IS NOT NULL
   DROP TABLE cr_procesos_paralelo
GO

IF OBJECT_ID ('cr_procesos_geren_tmp') IS NOT NULL
   DROP TABLE cr_procesos_geren_tmp
GO

IF OBJECT_ID ('cr_procesos_datooper_tmp') IS NOT NULL
   DROP TABLE cr_procesos_datooper_tmp
GO

IF OBJECT_ID ('cr_procedencia_sol_rpt') IS NOT NULL
   DROP TABLE cr_procedencia_sol_rpt
GO

IF OBJECT_ID ('cr_probabilidad_mrco') IS NOT NULL
   DROP TABLE cr_probabilidad_mrco
GO

IF OBJECT_ID ('cr_probabilidad_mrc') IS NOT NULL
   DROP TABLE cr_probabilidad_mrc
GO

IF OBJECT_ID ('cr_previa_temporal') IS NOT NULL
   DROP TABLE cr_previa_temporal
GO

IF OBJECT_ID ('cr_previa_ricl') IS NOT NULL
   DROP TABLE cr_previa_ricl
GO

IF OBJECT_ID ('cr_presup_mensual_ofi') IS NOT NULL
   DROP TABLE cr_presup_mensual_ofi
GO

IF OBJECT_ID ('cr_presup_mensual_ejc') IS NOT NULL
   DROP TABLE cr_presup_mensual_ejc
GO

IF OBJECT_ID ('cr_presup_mensual') IS NOT NULL
   DROP TABLE cr_presup_mensual
GO

IF OBJECT_ID ('cr_pregunta_formulario') IS NOT NULL
   DROP TABLE cr_pregunta_formulario
GO

IF OBJECT_ID ('cr_pregunta') IS NOT NULL
   DROP TABLE cr_pregunta
GO

IF OBJECT_ID ('cr_potenciales_tmp') IS NOT NULL
   DROP TABLE cr_potenciales_tmp
GO

IF OBJECT_ID ('cr_politicas_cupos_ts') IS NOT NULL
   DROP TABLE cr_politicas_cupos_ts
GO

IF OBJECT_ID ('cr_politicas_cupos') IS NOT NULL
   DROP TABLE cr_politicas_cupos
GO

IF OBJECT_ID ('cr_plano_cobranza_tmp') IS NOT NULL
   DROP TABLE cr_plano_cobranza_tmp
GO

IF OBJECT_ID ('cr_planes') IS NOT NULL
   DROP TABLE cr_planes
GO

IF OBJECT_ID ('cr_plan_seguros') IS NOT NULL
   DROP TABLE cr_plan_seguros
GO

IF OBJECT_ID ('cr_plan_cobertura') IS NOT NULL
   DROP TABLE cr_plan_cobertura
GO

IF OBJECT_ID ('cr_pla_vida') IS NOT NULL
   DROP TABLE cr_pla_vida
GO

IF OBJECT_ID ('cr_pla_exequias') IS NOT NULL
   DROP TABLE cr_pla_exequias
GO

IF OBJECT_ID ('cr_pla_danos') IS NOT NULL
   DROP TABLE cr_pla_danos
GO

IF OBJECT_ID ('cr_peso_rubro_rep') IS NOT NULL
   DROP TABLE cr_peso_rubro_rep
GO

IF OBJECT_ID ('cr_peso_rubro_dia') IS NOT NULL
   DROP TABLE cr_peso_rubro_dia
GO

IF OBJECT_ID ('cr_peso_rubro') IS NOT NULL
   DROP TABLE cr_peso_rubro
GO

IF OBJECT_ID ('cr_periodos_gracia_nor') IS NOT NULL
   DROP TABLE cr_periodos_gracia_nor
GO

IF OBJECT_ID ('cr_perdida_incumplimiento') IS NOT NULL
   DROP TABLE cr_perdida_incumplimiento
GO

IF OBJECT_ID ('cr_pendte_desembolso') IS NOT NULL
   DROP TABLE cr_pendte_desembolso
GO

IF OBJECT_ID ('cr_pasos_filtros') IS NOT NULL
   DROP TABLE cr_pasos_filtros
GO

IF OBJECT_ID ('cr_pasos') IS NOT NULL
   DROP TABLE cr_pasos
GO

IF OBJECT_ID ('cr_paso_historicos') IS NOT NULL
   DROP TABLE cr_paso_historicos
GO

IF OBJECT_ID ('cr_pasa_hist') IS NOT NULL
   DROP TABLE cr_pasa_hist
GO

IF OBJECT_ID ('cr_parametros_fuente') IS NOT NULL
   DROP TABLE cr_parametros_fuente
GO

IF OBJECT_ID ('cr_param_suspension') IS NOT NULL
   DROP TABLE cr_param_suspension
GO

IF OBJECT_ID ('cr_param_normalizacion') IS NOT NULL
   DROP TABLE cr_param_normalizacion
GO

IF OBJECT_ID ('cr_param_mensajes_ts') IS NOT NULL
   DROP TABLE cr_param_mensajes_ts
GO

IF OBJECT_ID ('cr_param_mensajes') IS NOT NULL
   DROP TABLE cr_param_mensajes
GO

IF OBJECT_ID ('cr_param_gar') IS NOT NULL
   DROP TABLE cr_param_gar
GO

IF OBJECT_ID ('cr_param_especiales_norm') IS NOT NULL
   DROP TABLE cr_param_especiales_norm
GO

IF OBJECT_ID ('cr_param_cont_temp') IS NOT NULL
   DROP TABLE cr_param_cont_temp
GO

IF OBJECT_ID ('cr_param_cob_gar') IS NOT NULL
   DROP TABLE cr_param_cob_gar
GO

IF OBJECT_ID ('cr_param_calif_mir') IS NOT NULL
   DROP TABLE cr_param_calif_mir
GO

IF OBJECT_ID ('cr_param_calif_aso') IS NOT NULL
   DROP TABLE cr_param_calif_aso
GO

IF OBJECT_ID ('cr_param_calif') IS NOT NULL
   DROP TABLE cr_param_calif
GO

IF OBJECT_ID ('cr_pagares') IS NOT NULL
   DROP TABLE cr_pagares
GO

IF OBJECT_ID ('cr_pa_pregunta_mir_copia') IS NOT NULL
   DROP TABLE cr_pa_pregunta_mir_copia
GO

IF OBJECT_ID ('cr_pa_pregunta_mir') IS NOT NULL
   DROP TABLE cr_pa_pregunta_mir
GO

IF OBJECT_ID ('cr_operaciones_reinciden') IS NOT NULL
   DROP TABLE cr_operaciones_reinciden
GO

IF OBJECT_ID ('cr_operacion_provision') IS NOT NULL
   DROP TABLE cr_operacion_provision
GO

IF OBJECT_ID ('cr_operacion_cobranza_tmp') IS NOT NULL
   DROP TABLE cr_operacion_cobranza_tmp
GO

IF OBJECT_ID ('cr_operacion_cobranza') IS NOT NULL
   DROP TABLE cr_operacion_cobranza
GO

IF OBJECT_ID ('cr_oper_error') IS NOT NULL
   DROP TABLE cr_oper_error
GO

IF OBJECT_ID ('cr_oper_cons') IS NOT NULL
   DROP TABLE cr_oper_cons
GO

IF OBJECT_ID ('cr_oper_codeud_tmp') IS NOT NULL
   DROP TABLE cr_oper_codeud_tmp
GO

IF OBJECT_ID ('cr_ope_tramitadas') IS NOT NULL
   DROP TABLE cr_ope_tramitadas
GO

IF OBJECT_ID ('cr_ope_tmp') IS NOT NULL
   DROP TABLE cr_ope_tmp
GO

IF OBJECT_ID ('cr_ope_temporal') IS NOT NULL
   DROP TABLE cr_ope_temporal
GO

IF OBJECT_ID ('cr_ope_ricl') IS NOT NULL
   DROP TABLE cr_ope_ricl
GO

IF OBJECT_ID ('cr_op_renovar') IS NOT NULL
   DROP TABLE cr_op_renovar
GO

IF OBJECT_ID ('cr_op_reclasif') IS NOT NULL
   DROP TABLE cr_op_reclasif
GO

IF OBJECT_ID ('cr_op_demora') IS NOT NULL
   DROP TABLE cr_op_demora
GO

IF OBJECT_ID ('cr_op_castigadas') IS NOT NULL
   DROP TABLE cr_op_castigadas
GO

IF OBJECT_ID ('cr_op_castigada_codeudores') IS NOT NULL
   DROP TABLE cr_op_castigada_codeudores
GO

IF OBJECT_ID ('cr_op_caja_cierre') IS NOT NULL
   DROP TABLE cr_op_caja_cierre
GO

IF OBJECT_ID ('cr_oficina_ab') IS NOT NULL
   DROP TABLE cr_oficina_ab
GO

IF OBJECT_ID ('cr_oficial_oficina') IS NOT NULL
   DROP TABLE cr_oficial_oficina
GO

IF OBJECT_ID ('cr_observaciones') IS NOT NULL
   DROP TABLE cr_observaciones
GO

IF OBJECT_ID ('cr_ob_lineas') IS NOT NULL
   DROP TABLE cr_ob_lineas
GO

IF OBJECT_ID ('cr_notif_concordato') IS NOT NULL
   DROP TABLE cr_notif_concordato
GO

IF OBJECT_ID ('cr_normalizacion') IS NOT NULL
   DROP TABLE cr_normalizacion
GO

IF OBJECT_ID ('cr_norma_prod') IS NOT NULL
   DROP TABLE cr_norma_prod
GO

IF OBJECT_ID ('cr_no_cobis_cca_cred') IS NOT NULL
   DROP TABLE cr_no_cobis_cca_cred
GO

IF OBJECT_ID ('cr_msv_proc') IS NOT NULL
   DROP TABLE cr_msv_proc
GO

IF OBJECT_ID ('cr_msv_crear_u_his') IS NOT NULL
   DROP TABLE cr_msv_crear_u_his
GO

IF OBJECT_ID ('cr_msv_crear_u') IS NOT NULL
   DROP TABLE cr_msv_crear_u
GO

IF OBJECT_ID ('cr_msv_crear_orig_his') IS NOT NULL
   DROP TABLE cr_msv_crear_orig_his
GO

IF OBJECT_ID ('cr_msv_crear_orig') IS NOT NULL
   DROP TABLE cr_msv_crear_orig
GO

IF OBJECT_ID ('cr_msv_crear_cupo_his') IS NOT NULL
   DROP TABLE cr_msv_crear_cupo_his
GO

IF OBJECT_ID ('cr_msv_crear_cupo') IS NOT NULL
   DROP TABLE cr_msv_crear_cupo
GO

IF OBJECT_ID ('cr_mov_tramite') IS NOT NULL
   DROP TABLE cr_mov_tramite
GO

IF OBJECT_ID ('cr_mov_provision_rsm') IS NOT NULL
   DROP TABLE cr_mov_provision_rsm
GO

IF OBJECT_ID ('cr_mov_provision') IS NOT NULL
   DROP TABLE cr_mov_provision
GO

IF OBJECT_ID ('cr_mov_fuente_recurso') IS NOT NULL
   DROP TABLE cr_mov_fuente_recurso
GO

IF OBJECT_ID ('cr_mora_control') IS NOT NULL
   DROP TABLE cr_mora_control
GO

IF OBJECT_ID ('cr_monitoreo_sol_rpt') IS NOT NULL
   DROP TABLE cr_monitoreo_sol_rpt
GO

IF OBJECT_ID ('cr_monitor_tmp') IS NOT NULL
   DROP TABLE cr_monitor_tmp
GO

IF OBJECT_ID ('cr_modif_tramite') IS NOT NULL
   DROP TABLE cr_modif_tramite
GO

IF OBJECT_ID ('cr_miembros') IS NOT NULL
   DROP TABLE cr_miembros
GO

IF OBJECT_ID ('cr_microempresa') IS NOT NULL
   DROP TABLE cr_microempresa
GO

IF OBJECT_ID ('cr_micro_seguro_his') IS NOT NULL
   DROP TABLE cr_micro_seguro_his
GO

IF OBJECT_ID ('cr_micro_seguro') IS NOT NULL
   DROP TABLE cr_micro_seguro
GO

IF OBJECT_ID ('cr_mercado_sujeto') IS NOT NULL
   DROP TABLE cr_mercado_sujeto
GO

IF OBJECT_ID ('cr_medidas_prec_tmp') IS NOT NULL
   DROP TABLE cr_medidas_prec_tmp
GO

IF OBJECT_ID ('cr_medidas_prec') IS NOT NULL
   DROP TABLE cr_medidas_prec
GO

IF OBJECT_ID ('cr_maxcal_cliente') IS NOT NULL
   DROP TABLE cr_maxcal_cliente
GO

IF OBJECT_ID ('cr_matriz_cupos_ts') IS NOT NULL
   DROP TABLE cr_matriz_cupos_ts
GO

IF OBJECT_ID ('cr_matriz_cupos') IS NOT NULL
   DROP TABLE cr_matriz_cupos
GO

IF OBJECT_ID ('cr_materia_prima') IS NOT NULL
   DROP TABLE cr_materia_prima
GO

IF OBJECT_ID ('cr_maestro_cob') IS NOT NULL
   DROP TABLE cr_maestro_cob
GO

IF OBJECT_ID ('cr_maedir_cob') IS NOT NULL
   DROP TABLE cr_maedir_cob
GO

IF OBJECT_ID ('cr_maecli_cob') IS NOT NULL
   DROP TABLE cr_maecli_cob
GO

IF OBJECT_ID ('cr_log_reserva_error') IS NOT NULL
   DROP TABLE cr_log_reserva_error
GO

IF OBJECT_ID ('cr_log_batch') IS NOT NULL
   DROP TABLE cr_log_batch
GO

IF OBJECT_ID ('cr_linea_tmpp1') IS NOT NULL
   DROP TABLE cr_linea_tmpp1
GO

IF OBJECT_ID ('cr_linea_tmpp') IS NOT NULL
   DROP TABLE cr_linea_tmpp
GO

IF OBJECT_ID ('cr_linea_conv') IS NOT NULL
   DROP TABLE cr_linea_conv
GO

IF OBJECT_ID ('cr_linea') IS NOT NULL
   DROP TABLE cr_linea
GO

IF OBJECT_ID ('cr_lin_util_tmp') IS NOT NULL
   DROP TABLE cr_lin_util_tmp
GO

IF OBJECT_ID ('cr_lin_reservado') IS NOT NULL
   DROP TABLE cr_lin_reservado
GO

IF OBJECT_ID ('cr_lin_ope_moneda') IS NOT NULL
   DROP TABLE cr_lin_ope_moneda
GO

IF OBJECT_ID ('cr_lin_grupo') IS NOT NULL
   DROP TABLE cr_lin_grupo
GO

IF OBJECT_ID ('cr_integrantes_acta') IS NOT NULL
   DROP TABLE cr_integrantes_acta
GO

IF OBJECT_ID ('cr_instrucciones') IS NOT NULL
   DROP TABLE cr_instrucciones
GO

IF OBJECT_ID ('cr_informe') IS NOT NULL
   DROP TABLE cr_informe
GO

IF OBJECT_ID ('cr_inf_lineas') IS NOT NULL
   DROP TABLE cr_inf_lineas
GO

IF OBJECT_ID ('cr_inf_financiera_ticket_223469') IS NOT NULL
   DROP TABLE cr_inf_financiera_ticket_223469
GO

IF OBJECT_ID ('cr_inf_financiera_ticket_212958') IS NOT NULL
   DROP TABLE cr_inf_financiera_ticket_212958
GO

IF OBJECT_ID ('cr_inf_financiera') IS NOT NULL
   DROP TABLE cr_inf_financiera
GO

IF OBJECT_ID ('cr_inf_credito') IS NOT NULL
   DROP TABLE cr_inf_credito
GO

IF OBJECT_ID ('cr_indice_desercion_rpt') IS NOT NULL
   DROP TABLE cr_indice_desercion_rpt
GO

IF OBJECT_ID ('cr_indic_abog') IS NOT NULL
   DROP TABLE cr_indic_abog
GO

IF OBJECT_ID ('cr_inconsis_cca_cred') IS NOT NULL
   DROP TABLE cr_inconsis_cca_cred
GO

IF OBJECT_ID ('cr_inconsis_calfs_op') IS NOT NULL
   DROP TABLE cr_inconsis_calfs_op
GO

IF OBJECT_ID ('cr_inconsis_calf_pro') IS NOT NULL
   DROP TABLE cr_inconsis_calf_pro
GO

IF OBJECT_ID ('cr_inconsis_calf_op') IS NOT NULL
   DROP TABLE cr_inconsis_calf_op
GO

IF OBJECT_ID ('cr_inconsis_acciones') IS NOT NULL
   DROP TABLE cr_inconsis_acciones
GO

IF OBJECT_ID ('cr_impresion_cartas') IS NOT NULL
   DROP TABLE cr_impresion_cartas
GO

IF OBJECT_ID ('cr_impr_mora') IS NOT NULL
   DROP TABLE cr_impr_mora
GO

IF OBJECT_ID ('cr_imp_documento') IS NOT NULL
   DROP TABLE cr_imp_documento
GO

IF OBJECT_ID ('cr_imagen') IS NOT NULL
   DROP TABLE cr_imagen
GO

IF OBJECT_ID ('cr_hra_devolucion') IS NOT NULL
   DROP TABLE cr_hra_devolucion
GO

IF OBJECT_ID ('cr_hono_mora') IS NOT NULL
   DROP TABLE cr_hono_mora
GO

IF OBJECT_ID ('cr_hono_abogado') IS NOT NULL
   DROP TABLE cr_hono_abogado
GO

IF OBJECT_ID ('cr_historial_situacion') IS NOT NULL
   DROP TABLE cr_historial_situacion
GO

IF OBJECT_ID ('cr_historiacreditos') IS NOT NULL
   DROP TABLE cr_historiacreditos
GO

IF OBJECT_ID ('cr_hist_credito') IS NOT NULL
   DROP TABLE cr_hist_credito
GO

IF OBJECT_ID ('cr_his_calif') IS NOT NULL
   DROP TABLE cr_his_calif
GO

IF OBJECT_ID ('cr_gru_codeudor') IS NOT NULL
   DROP TABLE cr_gru_codeudor
GO

IF OBJECT_ID ('cr_gracia_normalizaciones') IS NOT NULL
   DROP TABLE cr_gracia_normalizaciones
GO

IF OBJECT_ID ('cr_gestion_prom') IS NOT NULL
   DROP TABLE cr_gestion_prom
GO

IF OBJECT_ID ('cr_gestion_microseguro') IS NOT NULL
   DROP TABLE cr_gestion_microseguro
GO

IF OBJECT_ID ('cr_gestion_mensual_tmp') IS NOT NULL
   DROP TABLE cr_gestion_mensual_tmp
GO

IF OBJECT_ID ('cr_gestion_cobro') IS NOT NULL
   DROP TABLE cr_gestion_cobro
GO

IF OBJECT_ID ('cr_gestion_campana') IS NOT NULL
   DROP TABLE cr_gestion_campana
GO

IF OBJECT_ID ('cr_gestion_call') IS NOT NULL
   DROP TABLE cr_gestion_call
GO

IF OBJECT_ID ('cr_gestion_area_tmp') IS NOT NULL
   DROP TABLE cr_gestion_area_tmp
GO

IF OBJECT_ID ('cr_gecob') IS NOT NULL
   DROP TABLE cr_gecob
GO

IF OBJECT_ID ('cr_garesp359') IS NOT NULL
   DROP TABLE cr_garesp359
GO

IF OBJECT_ID ('cr_garantias_gp') IS NOT NULL
   DROP TABLE cr_garantias_gp
GO

IF OBJECT_ID ('cr_garantia_num') IS NOT NULL
   DROP TABLE cr_garantia_num
GO

IF OBJECT_ID ('cr_garantia_gp') IS NOT NULL
   DROP TABLE cr_garantia_gp
GO

IF OBJECT_ID ('cr_garantia_dist_rep') IS NOT NULL
   DROP TABLE cr_garantia_dist_rep
GO

IF OBJECT_ID ('cr_garantia_dist_otra') IS NOT NULL
   DROP TABLE cr_garantia_dist_otra
GO

IF OBJECT_ID ('cr_garantia_dist_dia') IS NOT NULL
   DROP TABLE cr_garantia_dist_dia
GO

IF OBJECT_ID ('cr_garantia_dist') IS NOT NULL
   DROP TABLE cr_garantia_dist
GO

IF OBJECT_ID ('cr_gar_propuesta') IS NOT NULL
   DROP TABLE cr_gar_propuesta
GO

IF OBJECT_ID ('cr_gar_anteriores') IS NOT NULL
   DROP TABLE cr_gar_anteriores
GO

IF OBJECT_ID ('cr_fuente_recurso_his') IS NOT NULL
   DROP TABLE cr_fuente_recurso_his
GO

IF OBJECT_ID ('cr_fuente_recurso') IS NOT NULL
   DROP TABLE cr_fuente_recurso
GO

IF OBJECT_ID ('cr_formulario') IS NOT NULL
   DROP TABLE cr_formulario
GO

IF OBJECT_ID ('cr_formato_sib_tmp') IS NOT NULL
   DROP TABLE cr_formato_sib_tmp
GO

IF OBJECT_ID ('cr_formato_sib') IS NOT NULL
   DROP TABLE cr_formato_sib
GO

IF OBJECT_ID ('cr_formato_rfm') IS NOT NULL
   DROP TABLE cr_formato_rfm
GO

IF OBJECT_ID ('cr_formato_rf') IS NOT NULL
   DROP TABLE cr_formato_rf
GO

IF OBJECT_ID ('cr_formato_rem') IS NOT NULL
   DROP TABLE cr_formato_rem
GO

IF OBJECT_ID ('cr_formato_re') IS NOT NULL
   DROP TABLE cr_formato_re
GO

IF OBJECT_ID ('cr_formato_com') IS NOT NULL
   DROP TABLE cr_formato_com
GO

IF OBJECT_ID ('cr_formato_co') IS NOT NULL
   DROP TABLE cr_formato_co
GO

IF OBJECT_ID ('cr_fogacafe_rep') IS NOT NULL
   DROP TABLE cr_fogacafe_rep
GO

IF OBJECT_ID ('cr_fng2_tmp') IS NOT NULL
   DROP TABLE cr_fng2_tmp
GO

IF OBJECT_ID ('cr_fng1_tmp') IS NOT NULL
   DROP TABLE cr_fng1_tmp
GO

IF OBJECT_ID ('cr_fng_masivo') IS NOT NULL
   DROP TABLE cr_fng_masivo
GO

IF OBJECT_ID ('cr_fng_diario_tmp') IS NOT NULL
   DROP TABLE cr_fng_diario_tmp
GO

IF OBJECT_ID ('cr_firmas_mora') IS NOT NULL
   DROP TABLE cr_firmas_mora
GO

IF OBJECT_ID ('cr_financiamientos') IS NOT NULL
   DROP TABLE cr_financiamientos
GO

IF OBJECT_ID ('cr_fin_tplan_tmp') IS NOT NULL
   DROP TABLE cr_fin_tplan_tmp
GO

IF OBJECT_ID ('cr_filtros') IS NOT NULL
   DROP TABLE cr_filtros
GO

IF OBJECT_ID ('cr_filtro_tipo_cliente') IS NOT NULL
   DROP TABLE cr_filtro_tipo_cliente
GO

IF OBJECT_ID ('cr_ficha') IS NOT NULL
   DROP TABLE cr_ficha
GO

IF OBJECT_ID ('cr_facturas') IS NOT NULL
   DROP TABLE cr_facturas
GO

IF OBJECT_ID ('cr_fabrica_credito') IS NOT NULL
   DROP TABLE cr_fabrica_credito
GO

IF OBJECT_ID ('cr_extraccion_xml_tmp') IS NOT NULL
   DROP TABLE cr_extraccion_xml_tmp
GO

IF OBJECT_ID ('cr_extraccion_xml_det') IS NOT NULL
   DROP TABLE cr_extraccion_xml_det
GO

IF OBJECT_ID ('cr_extraccion_xml') IS NOT NULL
   DROP TABLE cr_extraccion_xml
GO

IF OBJECT_ID ('cr_excepciones') IS NOT NULL
   DROP TABLE cr_excepciones
GO

IF OBJECT_ID ('cr_etapa_estado') IS NOT NULL
   DROP TABLE cr_etapa_estado
GO

IF OBJECT_ID ('cr_etapa_estacion') IS NOT NULL
   DROP TABLE cr_etapa_estacion
GO

IF OBJECT_ID ('cr_etapa') IS NOT NULL
   DROP TABLE cr_etapa
GO

IF OBJECT_ID ('cr_estados_concordato') IS NOT NULL
   DROP TABLE cr_estados_concordato
GO

IF OBJECT_ID ('cr_estado_his') IS NOT NULL
   DROP TABLE cr_estado_his
GO

IF OBJECT_ID ('cr_estado_dias') IS NOT NULL
   DROP TABLE cr_estado_dias
GO

IF OBJECT_ID ('cr_estadistica_rec_rpt') IS NOT NULL
   DROP TABLE cr_estadistica_rec_rpt
GO

IF OBJECT_ID ('cr_estacion') IS NOT NULL
   DROP TABLE cr_estacion
GO

IF OBJECT_ID ('cr_est_financiero') IS NOT NULL
   DROP TABLE cr_est_financiero
GO

IF OBJECT_ID ('cr_especifica_tramites') IS NOT NULL
   DROP TABLE cr_especifica_tramites
GO

IF OBJECT_ID ('cr_especifica_sujcred') IS NOT NULL
   DROP TABLE cr_especifica_sujcred
GO

IF OBJECT_ID ('cr_errror_asigcobra') IS NOT NULL
   DROP TABLE cr_errror_asigcobra
GO

IF OBJECT_ID ('cr_errorlog_vrc') IS NOT NULL
   DROP TABLE cr_errorlog_vrc
GO

IF OBJECT_ID ('cr_errorlog_provad') IS NOT NULL
   DROP TABLE cr_errorlog_provad
GO

IF OBJECT_ID ('cr_errorlog_calif') IS NOT NULL
   DROP TABLE cr_errorlog_calif
GO

IF OBJECT_ID ('cr_errorlog') IS NOT NULL
   DROP TABLE cr_errorlog
GO

IF OBJECT_ID ('cr_errores_vrc') IS NOT NULL
   DROP TABLE cr_errores_vrc
GO

IF OBJECT_ID ('cr_errores_sib') IS NOT NULL
   DROP TABLE cr_errores_sib
GO

IF OBJECT_ID ('cr_error_pagare') IS NOT NULL
   DROP TABLE cr_error_pagare
GO

IF OBJECT_ID ('cr_enfermedades_his') IS NOT NULL
   DROP TABLE cr_enfermedades_his
GO

IF OBJECT_ID ('cr_enfermedades') IS NOT NULL
   DROP TABLE cr_enfermedades
GO

IF OBJECT_ID ('cr_endeudamiento') IS NOT NULL
   DROP TABLE cr_endeudamiento
GO

IF OBJECT_ID ('cr_ejecucion_tmp') IS NOT NULL
   DROP TABLE cr_ejecucion_tmp
GO

IF OBJECT_ID ('cr_documentos_tmp') IS NOT NULL
   DROP TABLE cr_documentos_tmp
GO

IF OBJECT_ID ('cr_documento') IS NOT NULL
   DROP TABLE cr_documento
GO

IF OBJECT_ID ('cr_distribucion_desembolso') IS NOT NULL
   DROP TABLE cr_distribucion_desembolso
GO

IF OBJECT_ID ('cr_dist_desembcup') IS NOT NULL
   DROP TABLE cr_dist_desembcup
GO

IF OBJECT_ID ('cr_disponibles_tramite') IS NOT NULL
   DROP TABLE cr_disponibles_tramite
GO

IF OBJECT_ID ('cr_disgad_superior_tmp') IS NOT NULL
   DROP TABLE cr_disgad_superior_tmp
GO

IF OBJECT_ID ('cr_disgad_rubros_tmp') IS NOT NULL
   DROP TABLE cr_disgad_rubros_tmp
GO

IF OBJECT_ID ('cr_disgad_pesos_tmp') IS NOT NULL
   DROP TABLE cr_disgad_pesos_tmp
GO

IF OBJECT_ID ('cr_disgad_distr_garantias_tmp') IS NOT NULL
   DROP TABLE cr_disgad_distr_garantias_tmp
GO

IF OBJECT_ID ('cr_deudores_ticket_263279') IS NOT NULL
   DROP TABLE cr_deudores_ticket_263279
GO

IF OBJECT_ID ('cr_deudores_ORS1211') IS NOT NULL
   DROP TABLE cr_deudores_ORS1211
GO

IF OBJECT_ID ('cr_deudores_INC_262919') IS NOT NULL
   DROP TABLE cr_deudores_INC_262919
GO

IF OBJECT_ID ('cr_deudores_INC_251549') IS NOT NULL
   DROP TABLE cr_deudores_INC_251549
GO

IF OBJECT_ID ('cr_deudores') IS NOT NULL
   DROP TABLE cr_deudores
GO

IF OBJECT_ID ('cr_det_trn') IS NOT NULL
   DROP TABLE cr_det_trn
GO

IF OBJECT_ID ('cr_det_producto_no_cobis') IS NOT NULL
   DROP TABLE cr_det_producto_no_cobis
GO

IF OBJECT_ID ('cr_det_inf_financiera2') IS NOT NULL
   DROP TABLE cr_det_inf_financiera2
GO

IF OBJECT_ID ('cr_det_inf_financiera_respaldo') IS NOT NULL
   DROP TABLE cr_det_inf_financiera_respaldo
GO

IF OBJECT_ID ('cr_det_inf_financiera_esp_his') IS NOT NULL
   DROP TABLE cr_det_inf_financiera_esp_his
GO

IF OBJECT_ID ('cr_det_inf_financiera_esp') IS NOT NULL
   DROP TABLE cr_det_inf_financiera_esp
GO

IF OBJECT_ID ('cr_det_inf_financiera') IS NOT NULL
   DROP TABLE cr_det_inf_financiera
GO

IF OBJECT_ID ('cr_det_est_financiero') IS NOT NULL
   DROP TABLE cr_det_est_financiero
GO

IF OBJECT_ID ('cr_destino_tramite') IS NOT NULL
   DROP TABLE cr_destino_tramite
GO

IF OBJECT_ID ('cr_destino_economico') IS NOT NULL
   DROP TABLE cr_destino_economico
GO

IF OBJECT_ID ('cr_dest_econo') IS NOT NULL
   DROP TABLE cr_dest_econo
GO

IF OBJECT_ID ('cr_desmarca_fng') IS NOT NULL
   DROP TABLE cr_desmarca_fng
GO

IF OBJECT_ID ('cr_desembolso') IS NOT NULL
   DROP TABLE cr_desembolso
GO

IF OBJECT_ID ('cr_def_variables_filtros') IS NOT NULL
   DROP TABLE cr_def_variables_filtros
GO

IF OBJECT_ID ('cr_def_variables') IS NOT NULL
   DROP TABLE cr_def_variables
GO

IF OBJECT_ID ('cr_dec_jurada') IS NOT NULL
   DROP TABLE cr_dec_jurada
GO

IF OBJECT_ID ('cr_datosfinal_tmp') IS NOT NULL
   DROP TABLE cr_datosfinal_tmp
GO

IF OBJECT_ID ('cr_datos_tramites') IS NOT NULL
   DROP TABLE cr_datos_tramites
GO

IF OBJECT_ID ('cr_datos_reestructuracion') IS NOT NULL
   DROP TABLE cr_datos_reestructuracion
GO

IF OBJECT_ID ('cr_datos_proceso') IS NOT NULL
   DROP TABLE cr_datos_proceso
GO

IF OBJECT_ID ('cr_datos_oper') IS NOT NULL
   DROP TABLE cr_datos_oper
GO

IF OBJECT_ID ('cr_datos_dividendo') IS NOT NULL
   DROP TABLE cr_datos_dividendo
GO

IF OBJECT_ID ('cr_datos_comite') IS NOT NULL
   DROP TABLE cr_datos_comite
GO

IF OBJECT_ID ('cr_datos_castigo') IS NOT NULL
   DROP TABLE cr_datos_castigo
GO

IF OBJECT_ID ('cr_datomora_temp') IS NOT NULL
   DROP TABLE cr_datomora_temp
GO

IF OBJECT_ID ('cr_dato_toperacion') IS NOT NULL
   DROP TABLE cr_dato_toperacion
GO

IF OBJECT_ID ('cr_dato_operacion_tmp') IS NOT NULL
   DROP TABLE cr_dato_operacion_tmp
GO

IF OBJECT_ID ('cr_dato_operacion_rubro_tmp') IS NOT NULL
   DROP TABLE cr_dato_operacion_rubro_tmp
GO

IF OBJECT_ID ('cr_dato_operacion_rubro') IS NOT NULL
   DROP TABLE cr_dato_operacion_rubro
GO

IF OBJECT_ID ('cr_dato_operacion') IS NOT NULL
   DROP TABLE cr_dato_operacion
GO

IF OBJECT_ID ('cr_dato_garantia_rep') IS NOT NULL
   DROP TABLE cr_dato_garantia_rep
GO

IF OBJECT_ID ('cr_dato_garantia_otras') IS NOT NULL
   DROP TABLE cr_dato_garantia_otras
GO

IF OBJECT_ID ('cr_dato_garantia_dia') IS NOT NULL
   DROP TABLE cr_dato_garantia_dia
GO

IF OBJECT_ID ('cr_dato_garantia') IS NOT NULL
   DROP TABLE cr_dato_garantia
GO

IF OBJECT_ID ('cr_dato_deudores_tmp') IS NOT NULL
   DROP TABLE cr_dato_deudores_tmp
GO

IF OBJECT_ID ('cr_dato_deudores') IS NOT NULL
   DROP TABLE cr_dato_deudores
GO

IF OBJECT_ID ('cr_dato_credvige2') IS NOT NULL
   DROP TABLE cr_dato_credvige2
GO

IF OBJECT_ID ('cr_dato_credvige') IS NOT NULL
   DROP TABLE cr_dato_credvige
GO

IF OBJECT_ID ('cr_dato_clipoten') IS NOT NULL
   DROP TABLE cr_dato_clipoten
GO

IF OBJECT_ID ('cr_dato_cliente_tmp') IS NOT NULL
   DROP TABLE cr_dato_cliente_tmp
GO

IF OBJECT_ID ('cr_dato_cliente') IS NOT NULL
   DROP TABLE cr_dato_cliente
GO

IF OBJECT_ID ('cr_cupos_mensual_fer') IS NOT NULL
   DROP TABLE cr_cupos_mensual_fer
GO

IF OBJECT_ID ('cr_cupos_mensual') IS NOT NULL
   DROP TABLE cr_cupos_mensual
GO

IF OBJECT_ID ('cr_cupos_aprobados_tmp') IS NOT NULL
   DROP TABLE cr_cupos_aprobados_tmp
GO

IF OBJECT_ID ('cr_cuotas_vencidas_tmp') IS NOT NULL
   DROP TABLE cr_cuotas_vencidas_tmp
GO

IF OBJECT_ID ('cr_cumplimiento') IS NOT NULL
   DROP TABLE cr_cumplimiento
GO

IF OBJECT_ID ('cr_cuentas_provision') IS NOT NULL
   DROP TABLE cr_cuentas_provision
GO

IF OBJECT_ID ('cr_cuentas_prov_ant') IS NOT NULL
   DROP TABLE cr_cuentas_prov_ant
GO

IF OBJECT_ID ('cr_cuentas_conta') IS NOT NULL
   DROP TABLE cr_cuentas_conta
GO

IF OBJECT_ID ('cr_cuentas_ajuste') IS NOT NULL
   DROP TABLE cr_cuentas_ajuste
GO

IF OBJECT_ID ('cr_ctrl_cupo_asoc') IS NOT NULL
   DROP TABLE cr_ctrl_cupo_asoc
GO

IF OBJECT_ID ('cr_credi_cancel_tmp') IS NOT NULL
   DROP TABLE cr_credi_cancel_tmp
GO

IF OBJECT_ID ('cr_credesembfu_tmp') IS NOT NULL
   DROP TABLE cr_credesembfu_tmp
GO

IF OBJECT_ID ('cr_credcast') IS NOT NULL
   DROP TABLE cr_credcast
GO

IF OBJECT_ID ('cr_cprie') IS NOT NULL
   DROP TABLE cr_cprie
GO

IF OBJECT_ID ('cr_cotizacion_rep') IS NOT NULL
   DROP TABLE cr_cotizacion_rep
GO

IF OBJECT_ID ('cr_cotizacion') IS NOT NULL
   DROP TABLE cr_cotizacion
GO

IF OBJECT_ID ('cr_cotiz_tmp') IS NOT NULL
   DROP TABLE cr_cotiz_tmp
GO

IF OBJECT_ID ('cr_costos_tmp') IS NOT NULL
   DROP TABLE cr_costos_tmp
GO

IF OBJECT_ID ('cr_costos_produccion') IS NOT NULL
   DROP TABLE cr_costos_produccion
GO

IF OBJECT_ID ('cr_costos') IS NOT NULL
   DROP TABLE cr_costos
GO

IF OBJECT_ID ('cr_costo_tipo_detalle') IS NOT NULL
   DROP TABLE cr_costo_tipo_detalle
GO

IF OBJECT_ID ('cr_costo_tipo') IS NOT NULL
   DROP TABLE cr_costo_tipo
GO

IF OBJECT_ID ('cr_costo_productor') IS NOT NULL
   DROP TABLE cr_costo_productor
GO

IF OBJECT_ID ('cr_costo_mercancia') IS NOT NULL
   DROP TABLE cr_costo_mercancia
GO

IF OBJECT_ID ('cr_cosec') IS NOT NULL
   DROP TABLE cr_cosec
GO

IF OBJECT_ID ('cr_corresp_sib_req499') IS NOT NULL
   DROP TABLE cr_corresp_sib_req499
GO

IF OBJECT_ID ('cr_corresp_sib_cca499') IS NOT NULL
   DROP TABLE cr_corresp_sib_cca499
GO

IF OBJECT_ID ('cr_corresp_sib_bak') IS NOT NULL
   DROP TABLE cr_corresp_sib_bak
GO

IF OBJECT_ID ('cr_corresp_sib_397') IS NOT NULL
   DROP TABLE cr_corresp_sib_397
GO

IF OBJECT_ID ('cr_corresp_sib') IS NOT NULL
   DROP TABLE cr_corresp_sib
GO

IF OBJECT_ID ('cr_correcion_deudores') IS NOT NULL
   DROP TABLE cr_correcion_deudores
GO

IF OBJECT_ID ('cr_control_reestructuracion') IS NOT NULL
   DROP TABLE cr_control_reestructuracion
GO

IF OBJECT_ID ('cr_contaprov_prf') IS NOT NULL
   DROP TABLE cr_contaprov_prf
GO

IF OBJECT_ID ('cr_consolidador_tramite_tmp') IS NOT NULL
   DROP TABLE cr_consolidador_tramite_tmp
GO

IF OBJECT_ID ('cr_consolidador_tramite') IS NOT NULL
   DROP TABLE cr_consolidador_tramite
GO

IF OBJECT_ID ('cr_condonaciones_tmp') IS NOT NULL
   DROP TABLE cr_condonaciones_tmp
GO

IF OBJECT_ID ('cr_condicion_linea') IS NOT NULL
   DROP TABLE cr_condicion_linea
GO

IF OBJECT_ID ('cr_condicion') IS NOT NULL
   DROP TABLE cr_condicion
GO

IF OBJECT_ID ('cr_concordato') IS NOT NULL
   DROP TABLE cr_concordato
GO

IF OBJECT_ID ('cr_con_lineas') IS NOT NULL
   DROP TABLE cr_con_lineas
GO

IF OBJECT_ID ('cr_comision') IS NOT NULL
   DROP TABLE cr_comision
GO

IF OBJECT_ID ('cr_codigo_cartas') IS NOT NULL
   DROP TABLE cr_codigo_cartas
GO

IF OBJECT_ID ('cr_codeudores_tmp') IS NOT NULL
   DROP TABLE cr_codeudores_tmp
GO

IF OBJECT_ID ('cr_codeudor_mora') IS NOT NULL
   DROP TABLE cr_codeudor_mora
GO

IF OBJECT_ID ('cr_cobranzas_comite') IS NOT NULL
   DROP TABLE cr_cobranzas_comite
GO

IF OBJECT_ID ('cr_cobranza_ors_1306') IS NOT NULL
   DROP TABLE cr_cobranza_ors_1306
GO

IF OBJECT_ID ('cr_cobranza_ors_1290') IS NOT NULL
   DROP TABLE cr_cobranza_ors_1290
GO

IF OBJECT_ID ('cr_cobranza_ors_1277') IS NOT NULL
   DROP TABLE cr_cobranza_ors_1277
GO

IF OBJECT_ID ('cr_cobranza_ors_1269') IS NOT NULL
   DROP TABLE cr_cobranza_ors_1269
GO

IF OBJECT_ID ('cr_cobranza_ors_1249') IS NOT NULL
   DROP TABLE cr_cobranza_ors_1249
GO

IF OBJECT_ID ('cr_cobranza_ors_1242') IS NOT NULL
   DROP TABLE cr_cobranza_ors_1242
GO

IF OBJECT_ID ('cr_cobranza') IS NOT NULL
   DROP TABLE cr_cobranza
GO

IF OBJECT_ID ('cr_cobertura_planes') IS NOT NULL
   DROP TABLE cr_cobertura_planes
GO

IF OBJECT_ID ('cr_cmest_tmp') IS NOT NULL
   DROP TABLE cr_cmest_tmp
GO

IF OBJECT_ID ('cr_cliente_temporal') IS NOT NULL
   DROP TABLE cr_cliente_temporal
GO

IF OBJECT_ID ('cr_cliente_ricl') IS NOT NULL
   DROP TABLE cr_cliente_ricl
GO

IF OBJECT_ID ('cr_cliente_no_cobis') IS NOT NULL
   DROP TABLE cr_cliente_no_cobis
GO

IF OBJECT_ID ('cr_cliente_cobau') IS NOT NULL
   DROP TABLE cr_cliente_cobau
GO

IF OBJECT_ID ('cr_cliente_cob') IS NOT NULL
   DROP TABLE cr_cliente_cob
GO

IF OBJECT_ID ('cr_cliente_campana_ticket_0266285') IS NOT NULL
   DROP TABLE cr_cliente_campana_ticket_0266285
GO

IF OBJECT_ID ('cr_cliente_campana_ticket_0244421') IS NOT NULL
   DROP TABLE cr_cliente_campana_ticket_0244421
GO

IF OBJECT_ID ('cr_cliente_campana') IS NOT NULL
   DROP TABLE cr_cliente_campana
GO

IF OBJECT_ID ('cr_clien_reest_tmp') IS NOT NULL
   DROP TABLE cr_clien_reest_tmp
GO

IF OBJECT_ID ('cr_cifras_control') IS NOT NULL
   DROP TABLE cr_cifras_control
GO

IF OBJECT_ID ('cr_cifin_t51') IS NOT NULL
   DROP TABLE cr_cifin_t51
GO

IF OBJECT_ID ('cr_cifin_t41') IS NOT NULL
   DROP TABLE cr_cifin_t41
GO

IF OBJECT_ID ('cr_cifin_t31') IS NOT NULL
   DROP TABLE cr_cifin_t31
GO

IF OBJECT_ID ('cr_cifin_t20') IS NOT NULL
   DROP TABLE cr_cifin_t20
GO

IF OBJECT_ID ('cr_cifin_def_51') IS NOT NULL
   DROP TABLE cr_cifin_def_51
GO

IF OBJECT_ID ('cr_cifin_def_41') IS NOT NULL
   DROP TABLE cr_cifin_def_41
GO

IF OBJECT_ID ('cr_cifin_def_31') IS NOT NULL
   DROP TABLE cr_cifin_def_31
GO

IF OBJECT_ID ('cr_cifin_def_20') IS NOT NULL
   DROP TABLE cr_cifin_def_20
GO

IF OBJECT_ID ('cr_cau_tramite') IS NOT NULL
   DROP TABLE cr_cau_tramite
GO

IF OBJECT_ID ('cr_cau_etapa') IS NOT NULL
   DROP TABLE cr_cau_etapa
GO

IF OBJECT_ID ('cr_categoria_comentario') IS NOT NULL
   DROP TABLE cr_categoria_comentario
GO

IF OBJECT_ID ('cr_cartas') IS NOT NULL
   DROP TABLE cr_cartas
GO

IF OBJECT_ID ('cr_carga_tramites_sfc') IS NOT NULL
   DROP TABLE cr_carga_tramites_sfc
GO

IF OBJECT_ID ('cr_carga_campana_tmp') IS NOT NULL
   DROP TABLE cr_carga_campana_tmp
GO

IF OBJECT_ID ('cr_carga_campana_log') IS NOT NULL
   DROP TABLE cr_carga_campana_log
GO

IF OBJECT_ID ('cr_carga_campana_det') IS NOT NULL
   DROP TABLE cr_carga_campana_det
GO

IF OBJECT_ID ('cr_carga_campana_cab') IS NOT NULL
   DROP TABLE cr_carga_campana_cab
GO

IF OBJECT_ID ('cr_carga_adminfo_tmp') IS NOT NULL
   DROP TABLE cr_carga_adminfo_tmp
GO

IF OBJECT_ID ('cr_campana_toperacion_tmp') IS NOT NULL
   DROP TABLE cr_campana_toperacion_tmp
GO

IF OBJECT_ID ('cr_campana_toperacion') IS NOT NULL
   DROP TABLE cr_campana_toperacion
GO

IF OBJECT_ID ('cr_campana_normalizacion_log') IS NOT NULL
   DROP TABLE cr_campana_normalizacion_log
GO

IF OBJECT_ID ('cr_campana_cliente_bcp') IS NOT NULL
   DROP TABLE cr_campana_cliente_bcp
GO

IF OBJECT_ID ('cr_campana_can') IS NOT NULL
   DROP TABLE cr_campana_can
GO

IF OBJECT_ID ('cr_campana') IS NOT NULL
   DROP TABLE cr_campana
GO

IF OBJECT_ID ('cr_cambios_provision_rsm') IS NOT NULL
   DROP TABLE cr_cambios_provision_rsm
GO

IF OBJECT_ID ('cr_cambio_estados') IS NOT NULL
   DROP TABLE cr_cambio_estados
GO

IF OBJECT_ID ('cr_cambio_asistido') IS NOT NULL
   DROP TABLE cr_cambio_asistido
GO

IF OBJECT_ID ('cr_calprovtmp') IS NOT NULL
   DROP TABLE cr_calprovtmp
GO

IF OBJECT_ID ('cr_call_center') IS NOT NULL
   DROP TABLE cr_call_center
GO

IF OBJECT_ID ('cr_califs_op_je') IS NOT NULL
   DROP TABLE cr_califs_op_je
GO

IF OBJECT_ID ('cr_califs_cl_je') IS NOT NULL
   DROP TABLE cr_califs_cl_je
GO

IF OBJECT_ID ('cr_calificaciones_op_rep') IS NOT NULL
   DROP TABLE cr_calificaciones_op_rep
GO

IF OBJECT_ID ('cr_calificaciones_op') IS NOT NULL
   DROP TABLE cr_calificaciones_op
GO

IF OBJECT_ID ('cr_calificaciones_cl_rep') IS NOT NULL
   DROP TABLE cr_calificaciones_cl_rep
GO

IF OBJECT_ID ('cr_calificaciones_cl') IS NOT NULL
   DROP TABLE cr_calificaciones_cl
GO

IF OBJECT_ID ('cr_calificacion_segu') IS NOT NULL
   DROP TABLE cr_calificacion_segu
GO

IF OBJECT_ID ('cr_calificacion_provision_rep2') IS NOT NULL
   DROP TABLE cr_calificacion_provision_rep2
GO

IF OBJECT_ID ('cr_calificacion_provision_rep') IS NOT NULL
   DROP TABLE cr_calificacion_provision_rep
GO

IF OBJECT_ID ('cr_calificacion_provision_dia') IS NOT NULL
   DROP TABLE cr_calificacion_provision_dia
GO

IF OBJECT_ID ('cr_calificacion_provision') IS NOT NULL
   DROP TABLE cr_calificacion_provision
GO

IF OBJECT_ID ('cr_calificacion_orig_his') IS NOT NULL
   DROP TABLE cr_calificacion_orig_his
GO

IF OBJECT_ID ('cr_calificacion_orig') IS NOT NULL
   DROP TABLE cr_calificacion_orig
GO

IF OBJECT_ID ('cr_calificacion_op_rep') IS NOT NULL
   DROP TABLE cr_calificacion_op_rep
GO

IF OBJECT_ID ('cr_calificacion_op') IS NOT NULL
   DROP TABLE cr_calificacion_op
GO

IF OBJECT_ID ('cr_calificacion_manual') IS NOT NULL
   DROP TABLE cr_calificacion_manual
GO

IF OBJECT_ID ('cr_calificacion_cl_rep') IS NOT NULL
   DROP TABLE cr_calificacion_cl_rep
GO

IF OBJECT_ID ('cr_calificacion_cl') IS NOT NULL
   DROP TABLE cr_calificacion_cl
GO

IF OBJECT_ID ('cr_califica_op_car') IS NOT NULL
   DROP TABLE cr_califica_op_car
GO

IF OBJECT_ID ('cr_califica_interna') IS NOT NULL
   DROP TABLE cr_califica_interna
GO

IF OBJECT_ID ('cr_califica_int_mod') IS NOT NULL
   DROP TABLE cr_califica_int_mod
GO

IF OBJECT_ID ('cr_califica_int_manual') IS NOT NULL
   DROP TABLE cr_califica_int_manual
GO

IF OBJECT_ID ('cr_calfs_op_respaldo') IS NOT NULL
   DROP TABLE cr_calfs_op_respaldo
GO

IF OBJECT_ID ('cr_calfs_cl_respaldo') IS NOT NULL
   DROP TABLE cr_calfs_cl_respaldo
GO

IF OBJECT_ID ('cr_calf_prov_respaldo') IS NOT NULL
   DROP TABLE cr_calf_prov_respaldo
GO

IF OBJECT_ID ('cr_calf_prov_reproceso') IS NOT NULL
   DROP TABLE cr_calf_prov_reproceso
GO

IF OBJECT_ID ('cr_calf_op_respaldo') IS NOT NULL
   DROP TABLE cr_calf_op_respaldo
GO

IF OBJECT_ID ('cr_calf_op_reproceso') IS NOT NULL
   DROP TABLE cr_calf_op_reproceso
GO

IF OBJECT_ID ('cr_calf_cl_respaldo') IS NOT NULL
   DROP TABLE cr_calf_cl_respaldo
GO

IF OBJECT_ID ('cr_cal_tplan_tmp') IS NOT NULL
   DROP TABLE cr_cal_tplan_tmp
GO

IF OBJECT_ID ('cr_bsolic_call') IS NOT NULL
   DROP TABLE cr_bsolic_call
GO

IF OBJECT_ID ('cr_bloqueos_cupos') IS NOT NULL
   DROP TABLE cr_bloqueos_cupos
GO

IF OBJECT_ID ('cr_beneficiarios_seg_exeq') IS NOT NULL
   DROP TABLE cr_beneficiarios_seg_exeq
GO

IF OBJECT_ID ('cr_beneficiarios') IS NOT NULL
   DROP TABLE cr_beneficiarios
GO

IF OBJECT_ID ('cr_benefic_micro_aseg_his') IS NOT NULL
   DROP TABLE cr_benefic_micro_aseg_his
GO

IF OBJECT_ID ('cr_benefic_micro_aseg') IS NOT NULL
   DROP TABLE cr_benefic_micro_aseg
GO

IF OBJECT_ID ('cr_ben_redes') IS NOT NULL
   DROP TABLE cr_ben_redes
GO

IF OBJECT_ID ('cr_bcp_preferencial_tmp') IS NOT NULL
   DROP TABLE cr_bcp_preferencial_tmp
GO

IF OBJECT_ID ('cr_bcp_preferencial') IS NOT NULL
   DROP TABLE cr_bcp_preferencial
GO

IF OBJECT_ID ('cr_bcp_adicmir') IS NOT NULL
   DROP TABLE cr_bcp_adicmir
GO

IF OBJECT_ID ('cr_autorizacion_cobranza') IS NOT NULL
   DROP TABLE cr_autorizacion_cobranza
GO

IF OBJECT_ID ('cr_atribucion') IS NOT NULL
   DROP TABLE cr_atribucion
GO

IF OBJECT_ID ('cr_asignacion_cob') IS NOT NULL
   DROP TABLE cr_asignacion_cob
GO

IF OBJECT_ID ('cr_asignacion_campana') IS NOT NULL
   DROP TABLE cr_asignacion_campana
GO

IF OBJECT_ID ('cr_asegurados_estadistica') IS NOT NULL
   DROP TABLE cr_asegurados_estadistica
GO

IF OBJECT_ID ('cr_asegurados') IS NOT NULL
   DROP TABLE cr_asegurados
GO

IF OBJECT_ID ('cr_asegura_tmp') IS NOT NULL
   DROP TABLE cr_asegura_tmp
GO

IF OBJECT_ID ('cr_aseg_microseguro_his') IS NOT NULL
   DROP TABLE cr_aseg_microseguro_his
GO

IF OBJECT_ID ('cr_aseg_microseguro') IS NOT NULL
   DROP TABLE cr_aseg_microseguro
GO

IF OBJECT_ID ('cr_archivo_redescuento') IS NOT NULL
   DROP TABLE cr_archivo_redescuento
GO

IF OBJECT_ID ('cr_arch_redes_tamortiz') IS NOT NULL
   DROP TABLE cr_arch_redes_tamortiz
GO

IF OBJECT_ID ('cr_arch_acc_med') IS NOT NULL
   DROP TABLE cr_arch_acc_med
GO

IF OBJECT_ID ('cr_altura_mora') IS NOT NULL
   DROP TABLE cr_altura_mora
GO

IF OBJECT_ID ('cr_agenda') IS NOT NULL
   DROP TABLE cr_agenda
GO

IF OBJECT_ID ('cr_ag_problemas') IS NOT NULL
   DROP TABLE cr_ag_problemas
GO

IF OBJECT_ID ('cr_ag_conclusiones') IS NOT NULL
   DROP TABLE cr_ag_conclusiones
GO

IF OBJECT_ID ('cr_ag_comentarios') IS NOT NULL
   DROP TABLE cr_ag_comentarios
GO

IF OBJECT_ID ('cr_adicmir_bcp71') IS NOT NULL
   DROP TABLE cr_adicmir_bcp71
GO

IF OBJECT_ID ('cr_acuti_temp') IS NOT NULL
   DROP TABLE cr_acuti_temp
GO

IF OBJECT_ID ('cr_acuti_con') IS NOT NULL
   DROP TABLE cr_acuti_con
GO

IF OBJECT_ID ('cr_acuerdos_tmp') IS NOT NULL
   DROP TABLE cr_acuerdos_tmp
GO

IF OBJECT_ID ('cr_acuerdos_pag_adminfo_his') IS NOT NULL
   DROP TABLE cr_acuerdos_pag_adminfo_his
GO

IF OBJECT_ID ('cr_acuerdos_pag_adminfo_err') IS NOT NULL
   DROP TABLE cr_acuerdos_pag_adminfo_err
GO

IF OBJECT_ID ('cr_acuerdos_pag_adminfo_control') IS NOT NULL
   DROP TABLE cr_acuerdos_pag_adminfo_control
GO

IF OBJECT_ID ('cr_acuerdos_pag_adminfo') IS NOT NULL
   DROP TABLE cr_acuerdos_pag_adminfo
GO

IF OBJECT_ID ('cr_acuerdo_vencimiento_tmp') IS NOT NULL
   DROP TABLE cr_acuerdo_vencimiento_tmp
GO

IF OBJECT_ID ('cr_acuerdo_vencimiento_his') IS NOT NULL
   DROP TABLE cr_acuerdo_vencimiento_his
GO

IF OBJECT_ID ('cr_acuerdo_vencimiento') IS NOT NULL
   DROP TABLE cr_acuerdo_vencimiento
GO

IF OBJECT_ID ('cr_acuerdo_his') IS NOT NULL
   DROP TABLE cr_acuerdo_his
GO

IF OBJECT_ID ('cr_acuerdo') IS NOT NULL
   DROP TABLE cr_acuerdo
GO

IF OBJECT_ID ('cr_actualiza_sfc') IS NOT NULL
   DROP TABLE cr_actualiza_sfc
GO

IF OBJECT_ID ('cr_actualiza_reserva') IS NOT NULL
   DROP TABLE cr_actualiza_reserva
GO

IF OBJECT_ID ('cr_actacomite') IS NOT NULL
   DROP TABLE cr_actacomite
GO

IF OBJECT_ID ('cr_act_financiar') IS NOT NULL
   DROP TABLE cr_act_financiar
GO

IF OBJECT_ID ('cr_act_comite') IS NOT NULL
   DROP TABLE cr_act_comite
GO

IF OBJECT_ID ('cr_acciones_tmp') IS NOT NULL
   DROP TABLE cr_acciones_tmp
GO

IF OBJECT_ID ('cr_acciones') IS NOT NULL
   DROP TABLE cr_acciones
GO

IF OBJECT_ID ('cr_accion_cobranza_tmp') IS NOT NULL
   DROP TABLE cr_accion_cobranza_tmp
GO

IF OBJECT_ID ('cr_abogado') IS NOT NULL
   DROP TABLE cr_abogado
GO

IF OBJECT_ID ('CONTROL_BATCH') IS NOT NULL
   DROP TABLE CONTROL_BATCH
GO

IF OBJECT_ID ('cl_val_arch') IS NOT NULL
   DROP TABLE cl_val_arch
GO

IF OBJECT_ID ('cl_orden_consulta_ext_2482015') IS NOT NULL
   DROP TABLE cl_orden_consulta_ext_2482015
GO

IF OBJECT_ID ('cl_modifica_mercado_tmp') IS NOT NULL
   DROP TABLE cl_modifica_mercado_tmp
GO

IF OBJECT_ID ('campos') IS NOT NULL
   DROP TABLE campos
GO

IF OBJECT_ID ('cabecera') IS NOT NULL
   DROP TABLE cabecera
GO

IF OBJECT_ID ('ca_vencimiento_reajuste_t1') IS NOT NULL
   DROP TABLE ca_vencimiento_reajuste_t1
GO

IF OBJECT_ID ('ca_pla_sura') IS NOT NULL
   DROP TABLE ca_pla_sura
GO

IF OBJECT_ID ('ca_pla_micro') IS NOT NULL
   DROP TABLE ca_pla_micro
GO

IF OBJECT_ID ('ca_error_log') IS NOT NULL
   DROP TABLE ca_error_log
GO

IF OBJECT_ID ('ca_destino_tramite_mig') IS NOT NULL
   DROP TABLE ca_destino_tramite_mig
GO

IF OBJECT_ID ('actualiza_SFC') IS NOT NULL
   DROP TABLE actualiza_SFC
GO

IF OBJECT_ID ('cr_desembolso_chequeo') IS NOT NULL
	DROP TABLE cr_desembolso_chequeo
GO

IF OBJECT_ID ('cr_buro_cuenta') IS NOT NULL
	DROP TABLE cr_buro_cuenta
GO

IF OBJECT_ID ('cr_buro_resumen_reporte') IS NOT NULL
	DROP TABLE cr_buro_resumen_reporte
GO

IF OBJECT_ID ('cr_interface_buro') IS NOT NULL
    DROP TABLE cr_interface_buro
GO

IF OBJECT_ID ('cr_lista_negra') IS NOT NULL
    DROP TABLE cr_lista_negra
GO

--caso#162199
if OBJECT_ID ('dbo.cr_interface_buro_tmp_consulta') is not null
	drop table dbo.cr_interface_buro_tmp_consulta
GO