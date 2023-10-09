USE cob_custodia
GO

IF OBJECT_ID ('dbo.tmp_errores') IS NOT NULL
	DROP TABLE dbo.tmp_errores
GO

IF OBJECT_ID ('dbo.tmp_disponible') IS NOT NULL
	DROP TABLE dbo.tmp_disponible
GO

IF OBJECT_ID ('dbo.tmp_cliente2') IS NOT NULL
	DROP TABLE dbo.tmp_cliente2
GO

IF OBJECT_ID ('dbo.tmp_cliente1') IS NOT NULL
	DROP TABLE dbo.tmp_cliente1
GO

IF OBJECT_ID ('dbo.tmp_cliente_INC_218781') IS NOT NULL
	DROP TABLE dbo.tmp_cliente_INC_218781
GO

IF OBJECT_ID ('dbo.tmp_cliente') IS NOT NULL
	DROP TABLE dbo.tmp_cliente
GO

IF OBJECT_ID ('dbo.garantias') IS NOT NULL
	DROP TABLE dbo.garantias
GO

IF OBJECT_ID ('dbo.cu_vencimiento_tmp') IS NOT NULL
	DROP TABLE dbo.cu_vencimiento_tmp
GO

IF OBJECT_ID ('dbo.cu_vencimiento_mig') IS NOT NULL
	DROP TABLE dbo.cu_vencimiento_mig
GO

IF OBJECT_ID ('dbo.cu_vencimiento') IS NOT NULL
	DROP TABLE dbo.cu_vencimiento
GO

IF OBJECT_ID ('dbo.cu_universo_pagares_col') IS NOT NULL
	DROP TABLE dbo.cu_universo_pagares_col
GO

IF OBJECT_ID ('dbo.cu_transaccion') IS NOT NULL
	DROP TABLE dbo.cu_transaccion
GO

IF OBJECT_ID ('dbo.cu_tran_servicio') IS NOT NULL
	DROP TABLE dbo.cu_tran_servicio
GO

IF OBJECT_ID ('dbo.cu_tran_cust') IS NOT NULL
	DROP TABLE dbo.cu_tran_cust
GO

IF OBJECT_ID ('dbo.cu_totgar') IS NOT NULL
	DROP TABLE dbo.cu_totgar
GO

IF OBJECT_ID ('dbo.cu_tmp_valorcart') IS NOT NULL
	DROP TABLE dbo.cu_tmp_valorcart
GO

IF OBJECT_ID ('dbo.cu_tmp_valoracion') IS NOT NULL
	DROP TABLE dbo.cu_tmp_valoracion
GO

IF OBJECT_ID ('dbo.cu_tmp_valgarv') IS NOT NULL
	DROP TABLE dbo.cu_tmp_valgarv
GO

IF OBJECT_ID ('dbo.cu_tmp_valgarnv') IS NOT NULL
	DROP TABLE dbo.cu_tmp_valgarnv
GO

IF OBJECT_ID ('dbo.cu_tmp_transaccion') IS NOT NULL
	DROP TABLE dbo.cu_tmp_transaccion
GO

IF OBJECT_ID ('dbo.cu_tmp_prenhi') IS NOT NULL
	DROP TABLE dbo.cu_tmp_prenhi
GO

IF OBJECT_ID ('dbo.cu_tmp_operaciones') IS NOT NULL
	DROP TABLE dbo.cu_tmp_operaciones
GO

IF OBJECT_ID ('dbo.cu_tmp_operacion_cerrada') IS NOT NULL
	DROP TABLE dbo.cu_tmp_operacion_cerrada
GO

IF OBJECT_ID ('dbo.cu_tmp_obs_inspecci') IS NOT NULL
	DROP TABLE dbo.cu_tmp_obs_inspecci
GO

IF OBJECT_ID ('dbo.cu_tmp_grupos') IS NOT NULL
	DROP TABLE dbo.cu_tmp_grupos
GO

IF OBJECT_ID ('dbo.cu_tmp_garcus') IS NOT NULL
	DROP TABLE dbo.cu_tmp_garcus
GO

IF OBJECT_ID ('dbo.cu_tmp_garantia') IS NOT NULL
	DROP TABLE dbo.cu_tmp_garantia
GO

IF OBJECT_ID ('dbo.cu_tmp_gar_op') IS NOT NULL
	DROP TABLE dbo.cu_tmp_gar_op
GO

IF OBJECT_ID ('dbo.cu_tmp_gar_adm') IS NOT NULL
	DROP TABLE dbo.cu_tmp_gar_adm
GO

IF OBJECT_ID ('dbo.cu_tmp_finagro') IS NOT NULL
	DROP TABLE dbo.cu_tmp_finagro
GO

IF OBJECT_ID ('dbo.cu_tmp_documentos') IS NOT NULL
	DROP TABLE dbo.cu_tmp_documentos
GO

IF OBJECT_ID ('dbo.cu_tmp_custodia') IS NOT NULL
	DROP TABLE dbo.cu_tmp_custodia
GO

IF OBJECT_ID ('dbo.cu_tmp_cotizacion_monedaint') IS NOT NULL
	DROP TABLE dbo.cu_tmp_cotizacion_monedaint
GO

IF OBJECT_ID ('dbo.cu_tmp_cotizacion_monedagar') IS NOT NULL
	DROP TABLE dbo.cu_tmp_cotizacion_monedagar
GO

IF OBJECT_ID ('dbo.cu_tmp_cotizacion_moneda06') IS NOT NULL
	DROP TABLE dbo.cu_tmp_cotizacion_moneda06
GO

IF OBJECT_ID ('dbo.cu_tmp_cotizacion_moneda') IS NOT NULL
	DROP TABLE dbo.cu_tmp_cotizacion_moneda
GO

IF OBJECT_ID ('dbo.cu_tmp_contagar_vig') IS NOT NULL
	DROP TABLE dbo.cu_tmp_contagar_vig
GO

IF OBJECT_ID ('dbo.cu_tmp_contagar_mes') IS NOT NULL
	DROP TABLE dbo.cu_tmp_contagar_mes
GO

IF OBJECT_ID ('dbo.cu_tmp_contagar_det_mes') IS NOT NULL
	DROP TABLE dbo.cu_tmp_contagar_det_mes
GO

IF OBJECT_ID ('dbo.cu_tmp_contagar_det') IS NOT NULL
	DROP TABLE dbo.cu_tmp_contagar_det
GO

IF OBJECT_ID ('dbo.cu_tmp_contagar') IS NOT NULL
	DROP TABLE dbo.cu_tmp_contagar
GO

IF OBJECT_ID ('dbo.cu_tipo_custodia') IS NOT NULL
	DROP TABLE dbo.cu_tipo_custodia
GO

IF OBJECT_ID ('dbo.cu_solicifagw') IS NOT NULL
	DROP TABLE dbo.cu_solicifagw
GO

IF OBJECT_ID ('dbo.cu_seqnos_doctos') IS NOT NULL
	DROP TABLE dbo.cu_seqnos_doctos
GO

IF OBJECT_ID ('dbo.cu_seqnos') IS NOT NULL
	DROP TABLE dbo.cu_seqnos
GO

IF OBJECT_ID ('dbo.cu_secuenciales') IS NOT NULL
	DROP TABLE dbo.cu_secuenciales
GO

IF OBJECT_ID ('dbo.cu_sal_entidad_ext_tmp') IS NOT NULL
	DROP TABLE dbo.cu_sal_entidad_ext_tmp
GO

IF OBJECT_ID ('dbo.cu_sal_entidad_ext') IS NOT NULL
	DROP TABLE dbo.cu_sal_entidad_ext
GO

IF OBJECT_ID ('dbo.cu_revaloriza') IS NOT NULL
	DROP TABLE dbo.cu_revaloriza
GO

IF OBJECT_ID ('dbo.cu_resultado_si2') IS NOT NULL
	DROP TABLE dbo.cu_resultado_si2
GO

IF OBJECT_ID ('dbo.cu_resultado_cred4') IS NOT NULL
	DROP TABLE dbo.cu_resultado_cred4
GO

IF OBJECT_ID ('dbo.cu_resul_abg') IS NOT NULL
	DROP TABLE dbo.cu_resul_abg
GO

IF OBJECT_ID ('dbo.cu_rep_venc') IS NOT NULL
	DROP TABLE dbo.cu_rep_venc
GO

IF OBJECT_ID ('dbo.cu_recuperacion') IS NOT NULL
	DROP TABLE dbo.cu_recuperacion
GO

IF OBJECT_ID ('dbo.cu_por_inspeccionar') IS NOT NULL
	DROP TABLE dbo.cu_por_inspeccionar
GO

IF OBJECT_ID ('dbo.cu_poliza') IS NOT NULL
	DROP TABLE dbo.cu_poliza
GO

IF OBJECT_ID ('dbo.cu_plplanificador') IS NOT NULL
	DROP TABLE dbo.cu_plplanificador
GO

IF OBJECT_ID ('dbo.cu_planavaluador') IS NOT NULL
	DROP TABLE dbo.cu_planavaluador
GO

IF OBJECT_ID ('dbo.cu_pagares_sin_custodia') IS NOT NULL
	DROP TABLE dbo.cu_pagares_sin_custodia
GO

IF OBJECT_ID ('dbo.cu_pagares_salen') IS NOT NULL
	DROP TABLE dbo.cu_pagares_salen
GO

IF OBJECT_ID ('dbo.cu_pagares_resumen') IS NOT NULL
	DROP TABLE dbo.cu_pagares_resumen
GO

IF OBJECT_ID ('dbo.cu_pagares_por_entidad') IS NOT NULL
	DROP TABLE dbo.cu_pagares_por_entidad
GO

IF OBJECT_ID ('dbo.cu_pagares_entran') IS NOT NULL
	DROP TABLE dbo.cu_pagares_entran
GO

IF OBJECT_ID ('dbo.cu_pagares_certificado') IS NOT NULL
	DROP TABLE dbo.cu_pagares_certificado
GO

IF OBJECT_ID ('dbo.cu_ofi_entidad_ext') IS NOT NULL
	DROP TABLE dbo.cu_ofi_entidad_ext
GO

IF OBJECT_ID ('dbo.cu_observacion_inspecci') IS NOT NULL
	DROP TABLE dbo.cu_observacion_inspecci
GO

IF OBJECT_ID ('dbo.cu_obs_inspecci') IS NOT NULL
	DROP TABLE dbo.cu_obs_inspecci
GO

IF OBJECT_ID ('dbo.cu_maestro_error') IS NOT NULL
	DROP TABLE dbo.cu_maestro_error
GO

IF OBJECT_ID ('dbo.cu_maestro_custodia') IS NOT NULL
	DROP TABLE dbo.cu_maestro_custodia
GO

IF OBJECT_ID ('dbo.cu_maestro') IS NOT NULL
	DROP TABLE dbo.cu_maestro
GO

IF OBJECT_ID ('dbo.cu_lin_entidad_ext') IS NOT NULL
	DROP TABLE dbo.cu_lin_entidad_ext
GO

IF OBJECT_ID ('dbo.cu_item_custodia_tpm') IS NOT NULL
	DROP TABLE dbo.cu_item_custodia_tpm
GO

IF OBJECT_ID ('dbo.cu_item_custodia') IS NOT NULL
	DROP TABLE dbo.cu_item_custodia
GO

IF OBJECT_ID ('dbo.cu_item') IS NOT NULL
	DROP TABLE dbo.cu_item
GO

IF OBJECT_ID ('dbo.cu_inspector') IS NOT NULL
	DROP TABLE dbo.cu_inspector
GO

IF OBJECT_ID ('dbo.cu_inspeccion') IS NOT NULL
	DROP TABLE dbo.cu_inspeccion
GO

IF OBJECT_ID ('dbo.cu_imp_garcus') IS NOT NULL
	DROP TABLE dbo.cu_imp_garcus
GO

IF OBJECT_ID ('dbo.cu_historial_custodia') IS NOT NULL
	DROP TABLE dbo.cu_historial_custodia
GO

IF OBJECT_ID ('dbo.cu_grupos_doctos') IS NOT NULL
	DROP TABLE dbo.cu_grupos_doctos
GO

IF OBJECT_ID ('dbo.cu_gastos') IS NOT NULL
	DROP TABLE dbo.cu_gastos
GO

IF OBJECT_ID ('dbo.cu_garantias_custodia') IS NOT NULL
	DROP TABLE dbo.cu_garantias_custodia
GO

IF OBJECT_ID ('dbo.cu_garantia_operacion') IS NOT NULL
	DROP TABLE dbo.cu_garantia_operacion
GO

IF OBJECT_ID ('dbo.cu_gar_si2') IS NOT NULL
	DROP TABLE dbo.cu_gar_si2
GO

IF OBJECT_ID ('dbo.cu_gar_propuesta') IS NOT NULL
	DROP TABLE dbo.cu_gar_propuesta
GO

IF OBJECT_ID ('dbo.cu_gar_municipio') IS NOT NULL
	DROP TABLE dbo.cu_gar_municipio
GO

IF OBJECT_ID ('dbo.cu_gar_cred4') IS NOT NULL
	DROP TABLE dbo.cu_gar_cred4
GO

IF OBJECT_ID ('dbo.cu_gar_actividad_tmp') IS NOT NULL
	DROP TABLE dbo.cu_gar_actividad_tmp
GO

IF OBJECT_ID ('dbo.cu_gar_actividad') IS NOT NULL
	DROP TABLE dbo.cu_gar_actividad
GO

IF OBJECT_ID ('dbo.cu_gar_abogado') IS NOT NULL
	DROP TABLE dbo.cu_gar_abogado
GO

IF OBJECT_ID ('dbo.cu_finagro_tmpw_def') IS NOT NULL
	DROP TABLE dbo.cu_finagro_tmpw_def
GO

IF OBJECT_ID ('dbo.cu_finagro_tmpw') IS NOT NULL
	DROP TABLE dbo.cu_finagro_tmpw
GO

IF OBJECT_ID ('dbo.cu_finagro_tmp') IS NOT NULL
	DROP TABLE dbo.cu_finagro_tmp
GO

IF OBJECT_ID ('dbo.cu_estce') IS NOT NULL
	DROP TABLE dbo.cu_estce
GO

IF OBJECT_ID ('dbo.cu_estados_garantia') IS NOT NULL
	DROP TABLE dbo.cu_estados_garantia
GO

IF OBJECT_ID ('dbo.cu_errorpag_cus') IS NOT NULL
	DROP TABLE dbo.cu_errorpag_cus
GO

IF OBJECT_ID ('dbo.cu_errorlog') IS NOT NULL
	DROP TABLE dbo.cu_errorlog
GO

IF OBJECT_ID ('dbo.cu_error_valvn') IS NOT NULL
	DROP TABLE dbo.cu_error_valvn
GO

IF OBJECT_ID ('dbo.cu_error_valv') IS NOT NULL
	DROP TABLE dbo.cu_error_valv
GO

IF OBJECT_ID ('dbo.cu_error_mig') IS NOT NULL
	DROP TABLE dbo.cu_error_mig
GO

IF OBJECT_ID ('dbo.cu_error_futuros') IS NOT NULL
	DROP TABLE dbo.cu_error_futuros
GO

IF OBJECT_ID ('dbo.cu_error_contagar_det') IS NOT NULL
	DROP TABLE dbo.cu_error_contagar_det
GO

IF OBJECT_ID ('dbo.cu_error_contagar') IS NOT NULL
	DROP TABLE dbo.cu_error_contagar
GO

IF OBJECT_ID ('dbo.cu_error_carga') IS NOT NULL
	DROP TABLE dbo.cu_error_carga
GO

IF OBJECT_ID ('dbo.cu_ecarcontrag') IS NOT NULL
	DROP TABLE dbo.cu_ecarcontrag
GO

IF OBJECT_ID ('dbo.cu_documentos') IS NOT NULL
	DROP TABLE dbo.cu_documentos
GO

IF OBJECT_ID ('dbo.cu_doc_garantia') IS NOT NULL
	DROP TABLE dbo.cu_doc_garantia
GO

IF OBJECT_ID ('dbo.cu_distr_garantia') IS NOT NULL
	DROP TABLE dbo.cu_distr_garantia
GO

IF OBJECT_ID ('dbo.cu_dias_periodicidad') IS NOT NULL
	DROP TABLE dbo.cu_dias_periodicidad
GO

IF OBJECT_ID ('dbo.cu_det_trn') IS NOT NULL
	DROP TABLE dbo.cu_det_trn
GO

IF OBJECT_ID ('dbo.cu_dependencias') IS NOT NULL
	DROP TABLE dbo.cu_dependencias
GO

IF OBJECT_ID ('dbo.cu_dep_usuario') IS NOT NULL
	DROP TABLE dbo.cu_dep_usuario
GO

IF OBJECT_ID ('dbo.cu_custodia_ticket_205149') IS NOT NULL
	DROP TABLE dbo.cu_custodia_ticket_205149
GO

IF OBJECT_ID ('dbo.cu_custodia_resp_vig') IS NOT NULL
	DROP TABLE dbo.cu_custodia_resp_vig
GO

IF OBJECT_ID ('dbo.cu_custodia_resp') IS NOT NULL
	DROP TABLE dbo.cu_custodia_resp
GO

IF OBJECT_ID ('dbo.cu_custodia_mig') IS NOT NULL
	DROP TABLE dbo.cu_custodia_mig
GO

IF OBJECT_ID ('dbo.cu_custodia_INC244443') IS NOT NULL
	DROP TABLE dbo.cu_custodia_INC244443
GO

IF OBJECT_ID ('dbo.cu_custodia_INC_218781') IS NOT NULL
	DROP TABLE dbo.cu_custodia_INC_218781
GO

IF OBJECT_ID ('dbo.cu_custodia_inc_212538') IS NOT NULL
	DROP TABLE dbo.cu_custodia_inc_212538
GO

IF OBJECT_ID ('dbo.cu_custodia') IS NOT NULL
	DROP TABLE dbo.cu_custodia
GO

IF OBJECT_ID ('dbo.cu_cuentas_conta') IS NOT NULL
	DROP TABLE dbo.cu_cuentas_conta
GO

IF OBJECT_ID ('dbo.cu_cuentas_ajuste') IS NOT NULL
	DROP TABLE dbo.cu_cuentas_ajuste
GO

IF OBJECT_ID ('dbo.cu_cotizacion_moneda_si2') IS NOT NULL
	DROP TABLE dbo.cu_cotizacion_moneda_si2
GO

IF OBJECT_ID ('dbo.cu_cotizacion_moneda') IS NOT NULL
	DROP TABLE dbo.cu_cotizacion_moneda
GO

IF OBJECT_ID ('dbo.cu_cotiz_custo') IS NOT NULL
	DROP TABLE dbo.cu_cotiz_custo
GO

IF OBJECT_ID ('dbo.cu_cot_mon_cred4') IS NOT NULL
	DROP TABLE dbo.cu_cot_mon_cred4
GO

IF OBJECT_ID ('dbo.cu_convenios_garantia') IS NOT NULL
	DROP TABLE dbo.cu_convenios_garantia
GO

IF OBJECT_ID ('dbo.cu_control_inspector') IS NOT NULL
	DROP TABLE dbo.cu_control_inspector
GO

IF OBJECT_ID ('dbo.cu_control_abogado') IS NOT NULL
	DROP TABLE dbo.cu_control_abogado
GO

IF OBJECT_ID ('dbo.cu_concilia_cert') IS NOT NULL
	DROP TABLE dbo.cu_concilia_cert
GO

IF OBJECT_ID ('dbo.cu_concepto_avaluo') IS NOT NULL
	DROP TABLE dbo.cu_concepto_avaluo
GO

IF OBJECT_ID ('dbo.cu_compartida') IS NOT NULL
	DROP TABLE dbo.cu_compartida
GO

IF OBJECT_ID ('dbo.cu_colateral_det_tmp') IS NOT NULL
	DROP TABLE dbo.cu_colateral_det_tmp
GO

IF OBJECT_ID ('dbo.cu_colateral_det') IS NOT NULL
	DROP TABLE dbo.cu_colateral_det
GO

IF OBJECT_ID ('dbo.cu_colat_adic') IS NOT NULL
	DROP TABLE dbo.cu_colat_adic
GO

IF OBJECT_ID ('dbo.cu_codigo_valor') IS NOT NULL
	DROP TABLE dbo.cu_codigo_valor
GO

IF OBJECT_ID ('dbo.cu_cliente_si2') IS NOT NULL
	DROP TABLE dbo.cu_cliente_si2
GO

IF OBJECT_ID ('dbo.cu_cliente_garantia_ticket_205149') IS NOT NULL
	DROP TABLE dbo.cu_cliente_garantia_ticket_205149
GO

IF OBJECT_ID ('dbo.cu_cliente_garantia_mig') IS NOT NULL
	DROP TABLE dbo.cu_cliente_garantia_mig
GO

IF OBJECT_ID ('dbo.cu_cliente_garantia') IS NOT NULL
	DROP TABLE dbo.cu_cliente_garantia
GO

IF OBJECT_ID ('dbo.cu_cliente_cred4') IS NOT NULL
	DROP TABLE dbo.cu_cliente_cred4
GO

IF OBJECT_ID ('dbo.cu_clase_vehiculo') IS NOT NULL
	DROP TABLE dbo.cu_clase_vehiculo
GO

IF OBJECT_ID ('dbo.cu_ciudad_porcentaje') IS NOT NULL
	DROP TABLE dbo.cu_ciudad_porcentaje
GO

IF OBJECT_ID ('dbo.cu_ciu_porcest') IS NOT NULL
	DROP TABLE dbo.cu_ciu_porcest
GO

IF OBJECT_ID ('dbo.cu_cifagm') IS NOT NULL
	DROP TABLE dbo.cu_cifagm
GO

IF OBJECT_ID ('dbo.cu_cifagd') IS NOT NULL
	DROP TABLE dbo.cu_cifagd
GO

IF OBJECT_ID ('dbo.cu_certfag') IS NOT NULL
	DROP TABLE dbo.cu_certfag
GO

IF OBJECT_ID ('dbo.cu_carga_contgar58') IS NOT NULL
	DROP TABLE dbo.cu_carga_contgar58
GO

IF OBJECT_ID ('dbo.cu_carga_contgar3') IS NOT NULL
	DROP TABLE dbo.cu_carga_contgar3
GO

IF OBJECT_ID ('dbo.cu_cambios_garantias') IS NOT NULL
	DROP TABLE dbo.cu_cambios_garantias
GO

IF OBJECT_ID ('dbo.cu_cambios_estado') IS NOT NULL
	DROP TABLE dbo.cu_cambios_estado
GO

IF OBJECT_ID ('dbo.cu_cabecera_custodia') IS NOT NULL
	DROP TABLE dbo.cu_cabecera_custodia
GO

IF OBJECT_ID ('dbo.cu_avaluos') IS NOT NULL
	DROP TABLE dbo.cu_avaluos
GO

IF OBJECT_ID ('dbo.cu_archivos_cargados_mig') IS NOT NULL
	DROP TABLE dbo.cu_archivos_cargados_mig
GO

IF OBJECT_ID ('dbo.cu_almacenera') IS NOT NULL
	DROP TABLE dbo.cu_almacenera
GO

IF OBJECT_ID ('dbo.cr_mig_campos_errados') IS NOT NULL
	DROP TABLE dbo.cr_mig_campos_errados
GO

IF OBJECT_ID ('dbo.cr_gar_propuesta_ticket_205149') IS NOT NULL
	DROP TABLE dbo.cr_gar_propuesta_ticket_205149
GO

IF OBJECT_ID ('dbo.cr_gar_propuesta_mig') IS NOT NULL
	DROP TABLE dbo.cr_gar_propuesta_mig
GO

IF OBJECT_ID ('dbo.cr_gar_propuesta_INC244443') IS NOT NULL
	DROP TABLE dbo.cr_gar_propuesta_INC244443
GO

IF OBJECT_ID ('dbo.cr_gar_propuesta_INC_218781') IS NOT NULL
	DROP TABLE dbo.cr_gar_propuesta_INC_218781
GO

IF OBJECT_ID ('dbo.cr_gar_propuesta_inc_212538') IS NOT NULL
	DROP TABLE dbo.cr_gar_propuesta_inc_212538
GO

IF OBJECT_ID ('dbo.CONTROL_BATCH') IS NOT NULL
	DROP TABLE dbo.CONTROL_BATCH
GO

IF OBJECT_ID ('dbo.cm_seqnos') IS NOT NULL
	DROP TABLE dbo.cm_seqnos
GO

IF OBJECT_ID ('dbo.cm_migracion_garantia') IS NOT NULL
	DROP TABLE dbo.cm_migracion_garantia
GO

IF OBJECT_ID ('dbo.cm_item_custodia') IS NOT NULL
	DROP TABLE dbo.cm_item_custodia
GO

IF OBJECT_ID ('dbo.cm_garpropuesta_mig') IS NOT NULL
	DROP TABLE dbo.cm_garpropuesta_mig
GO

IF OBJECT_ID ('dbo.cm_errores_migracion') IS NOT NULL
	DROP TABLE dbo.cm_errores_migracion
GO

IF OBJECT_ID ('dbo.cm_errores_mig_propuesta') IS NOT NULL
	DROP TABLE dbo.cm_errores_mig_propuesta
GO

IF OBJECT_ID ('dbo.cm_errores_distr_garantia') IS NOT NULL
	DROP TABLE dbo.cm_errores_distr_garantia
GO

IF OBJECT_ID ('dbo.cm_custodia_mig') IS NOT NULL
	DROP TABLE dbo.cm_custodia_mig
GO

IF OBJECT_ID ('dbo.cm_clientegar_mig') IS NOT NULL
	DROP TABLE dbo.cm_clientegar_mig
GO

IF OBJECT_ID ('dbo.cm_aseguradoras_mig') IS NOT NULL
	DROP TABLE dbo.cm_aseguradoras_mig
GO

IF OBJECT_ID ('dbo.cl_tabla_tmp') IS NOT NULL
	DROP TABLE dbo.cl_tabla_tmp
GO

IF OBJECT_ID ('dbo.cl_catalogo_tmp') IS NOT NULL
	DROP TABLE dbo.cl_catalogo_tmp
GO
