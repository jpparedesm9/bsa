----------------- <BORRANDO TABLAS> -------------------
 
use cob_conta
go
 
set nocount on
go
 
print '--> Tabla: cb_pagos_efectivos_ica'
if exists(select 1 from sysobjects where name = 'cb_pagos_efectivos_ica')
   drop table cb_pagos_efectivos_ica
 
go
print '--> Tabla: TblPrueba'
if exists(select 1 from sysobjects where name = 'TblPrueba')
   drop table TblPrueba
 
go
print '--> Tabla: tmp_siento_comp'
if exists(select 1 from sysobjects where name = 'tmp_siento_comp')
   drop table tmp_siento_comp
 
go
print '--> Tabla: cb_control_carga'
if exists(select 1 from sysobjects where name = 'cb_control_carga')
   drop table cb_control_carga
 
go
print '--> Tabla: cb_parametrizacion_grupos'
if exists(select 1 from sysobjects where name = 'cb_parametrizacion_grupos')
   drop table cb_parametrizacion_grupos
 
go
print '--> Tabla: pf_gmf_semanal'
if exists(select 1 from sysobjects where name = 'pf_gmf_semanal')
   drop table pf_gmf_semanal
 
go
print '--> Tabla: area_tcta'
if exists(select 1 from sysobjects where name = 'area_tcta')
   drop table area_tcta
 
go
print '--> Tabla: cb_concil_may_terc2'
if exists(select 1 from sysobjects where name = 'cb_concil_may_terc2')
   drop table cb_concil_may_terc2
 
go
print '--> Tabla: tmp_tran_ter'
if exists(select 1 from sysobjects where name = 'tmp_tran_ter')
   drop table tmp_tran_ter
 
go
print '--> Tabla: cb_parametro'
if exists(select 1 from sysobjects where name = 'cb_parametro')
   drop table cb_parametro
 
go
print '--> Tabla: cb_ajinpr'
if exists(select 1 from sysobjects where name = 'cb_ajinpr')
   drop table cb_ajinpr
 
go
print '--> Tabla: ts_regimen_fiscal'
if exists(select 1 from sysobjects where name = 'ts_regimen_fiscal')
   drop table ts_regimen_fiscal
 
go
print '--> Tabla: cb_paramterceros'
if exists(select 1 from sysobjects where name = 'cb_paramterceros')
   drop table cb_paramterceros
 
go
print '--> Tabla: cb_arch_convivencia'
if exists(select 1 from sysobjects where name = 'cb_arch_convivencia')
   drop table cb_arch_convivencia
 
go
print '--> Tabla: cb_perfil'
if exists(select 1 from sysobjects where name = 'cb_perfil')
   drop table cb_perfil
 
go
print '--> Tabla: cb_archivo_banco'
if exists(select 1 from sysobjects where name = 'cb_archivo_banco')
   drop table cb_archivo_banco
 
go
print '--> Tabla: cb_periodo'
if exists(select 1 from sysobjects where name = 'cb_periodo')
   drop table cb_periodo
 
go
print '--> Tabla: cb_area'
if exists(select 1 from sysobjects where name = 'cb_area')
   drop table cb_area
 
go
print '--> Tabla: cb_area_cta_saldo_tmp'
if exists(select 1 from sysobjects where name = 'cb_area_cta_saldo_tmp')
   drop table cb_area_cta_saldo_tmp
 
go
print '--> Tabla: cb_plan_general'
if exists(select 1 from sysobjects where name = 'cb_plan_general')
   drop table cb_plan_general
 
go
print '--> Tabla: cb_area_saldo_tmp'
if exists(select 1 from sysobjects where name = 'cb_area_saldo_tmp')
   drop table cb_area_saldo_tmp
 
go
print '--> Tabla: cb_ajuste_cb_log'
if exists(select 1 from sysobjects where name = 'cb_ajuste_cb_log')
   drop table cb_ajuste_cb_log
 
go
print '--> Tabla: comprobantes_work'
if exists(select 1 from sysobjects where name = 'comprobantes_work')
   drop table comprobantes_work
 
go
print '--> Tabla: cb_plan_general_presupuesto'
if exists(select 1 from sysobjects where name = 'cb_plan_general_presupuesto')
   drop table cb_plan_general_presupuesto
 
go
print '--> Tabla: cb_tempo'
if exists(select 1 from sysobjects where name = 'cb_tempo')
   drop table cb_tempo
 
go
print '--> Tabla: cb_posicion'
if exists(select 1 from sysobjects where name = 'cb_posicion')
   drop table cb_posicion
 
go
print '--> Tabla: cb_asiento_fp'
if exists(select 1 from sysobjects where name = 'cb_asiento_fp')
   drop table cb_asiento_fp
 
go
print '--> Tabla: cb_procesos_paralelo'
if exists(select 1 from sysobjects where name = 'cb_procesos_paralelo')
   drop table cb_procesos_paralelo
 
go
print '--> Tabla: cb_aso_oficonsol'
if exists(select 1 from sysobjects where name = 'cb_aso_oficonsol')
   drop table cb_aso_oficonsol
 
go
print '--> Tabla: cb_producto'
if exists(select 1 from sysobjects where name = 'cb_producto')
   drop table cb_producto
 
go
print '--> Tabla: cb_asociacion_operaciones'
if exists(select 1 from sysobjects where name = 'cb_asociacion_operaciones')
   drop table cb_asociacion_operaciones
 
go
print '--> Tabla: asientos_mov'
if exists(select 1 from sysobjects where name = 'asientos_mov')
   drop table asientos_mov
 
go
print '--> Tabla: cb_producto_procesado'
if exists(select 1 from sysobjects where name = 'cb_producto_procesado')
   drop table cb_producto_procesado
 
go
print '--> Tabla: cb_balcc_tmp'
if exists(select 1 from sysobjects where name = 'cb_balcc_tmp')
   drop table cb_balcc_tmp
 
go
print '--> Tabla: cb_regimen_fiscal'
if exists(select 1 from sysobjects where name = 'cb_regimen_fiscal')
   drop table cb_regimen_fiscal
 
go
print '--> Tabla: cb_balof_tmp'
if exists(select 1 from sysobjects where name = 'cb_balof_tmp')
   drop table cb_balof_tmp
 
go
print '--> Tabla: cb_paramdep_tmp'
if exists(select 1 from sysobjects where name = 'cb_paramdep_tmp')
   drop table cb_paramdep_tmp
 
go
print '--> Tabla: cb_relarea'
if exists(select 1 from sysobjects where name = 'cb_relarea')
   drop table cb_relarea
 
go
print '--> Tabla: cb_balsuper'
if exists(select 1 from sysobjects where name = 'cb_balsuper')
   drop table cb_balsuper
 
go
print '--> Tabla: cargue_niif_errores_tmp'
if exists(select 1 from sysobjects where name = 'cargue_niif_errores_tmp')
   drop table cargue_niif_errores_tmp
 
go
print '--> Tabla: cb_relofi'
if exists(select 1 from sysobjects where name = 'cb_relofi')
   drop table cb_relofi
 
go
print '--> Tabla: cb_banco'
if exists(select 1 from sysobjects where name = 'cb_banco')
   drop table cb_banco
 
go
print '--> Tabla: cargue_niif_berrores_tmp'
if exists(select 1 from sysobjects where name = 'cargue_niif_berrores_tmp')
   drop table cargue_niif_berrores_tmp
 
go
print '--> Tabla: cb_relparam'
if exists(select 1 from sysobjects where name = 'cb_relparam')
   drop table cb_relparam
 
go
print '--> Tabla: cb_datos_ctlr'
if exists(select 1 from sysobjects where name = 'cb_datos_ctlr')
   drop table cb_datos_ctlr
 
go
print '--> Tabla: ex_cargue_costos_niif_tmp'
if exists(select 1 from sysobjects where name = 'ex_cargue_costos_niif_tmp')
   drop table ex_cargue_costos_niif_tmp
 
go
print '--> Tabla: cb_campos_banco'
if exists(select 1 from sysobjects where name = 'cb_campos_banco')
   drop table cb_campos_banco
 
go
print '--> Tabla: cargue_costos_errores_tmp'
if exists(select 1 from sysobjects where name = 'cargue_costos_errores_tmp')
   drop table cargue_costos_errores_tmp
 
go
print '--> Tabla: TMP_no_tercero'
if exists(select 1 from sysobjects where name = 'TMP_no_tercero')
   drop table TMP_no_tercero
 
go
print '--> Tabla: cb_retencion_fp'
if exists(select 1 from sysobjects where name = 'cb_retencion_fp')
   drop table cb_retencion_fp
 
go
print '--> Tabla: cb_categoria'
if exists(select 1 from sysobjects where name = 'cb_categoria')
   drop table cb_categoria
 
go
print '--> Tabla: cb_retencion_tipo'
if exists(select 1 from sysobjects where name = 'cb_retencion_tipo')
   drop table cb_retencion_tipo
 
go
print '--> Tabla: cb_certiva_tmp'
if exists(select 1 from sysobjects where name = 'cb_certiva_tmp')
   drop table cb_certiva_tmp
 
go
print '--> Tabla: cb_tmp_saldo'
if exists(select 1 from sysobjects where name = 'cb_tmp_saldo')
   drop table cb_tmp_saldo
 
go
print '--> Tabla: cb_revcomp'
if exists(select 1 from sysobjects where name = 'cb_revcomp')
   drop table cb_revcomp
 
go
print '--> Tabla: archivo_tmp'
if exists(select 1 from sysobjects where name = 'archivo_tmp')
   drop table archivo_tmp
 
go
print '--> Tabla: cb_codigo_valor'
if exists(select 1 from sysobjects where name = 'cb_codigo_valor')
   drop table cb_codigo_valor
 
go
print '--> Tabla: saldos_final'
if exists(select 1 from sysobjects where name = 'saldos_final')
   drop table saldos_final
 
go
print '--> Tabla: cb_sal_def_con_mes'
if exists(select 1 from sysobjects where name = 'cb_sal_def_con_mes')
   drop table cb_sal_def_con_mes
 
go
print '--> Tabla: cb_comp_tipo'
if exists(select 1 from sysobjects where name = 'cb_comp_tipo')
   drop table cb_comp_tipo
 
go
print '--> Tabla: cb_cartera_bancor_tmp'
if exists(select 1 from sysobjects where name = 'cb_cartera_bancor_tmp')
   drop table cb_cartera_bancor_tmp
 
go
print '--> Tabla: cb_comprobante_inc'
if exists(select 1 from sysobjects where name = 'cb_comprobante_inc')
   drop table cb_comprobante_inc
 
go
print '--> Tabla: cb_sal_def_con_of'
if exists(select 1 from sysobjects where name = 'cb_sal_def_con_of')
   drop table cb_sal_def_con_of
 
go
print '--> Tabla: cb_asiento_inc'
if exists(select 1 from sysobjects where name = 'cb_asiento_inc')
   drop table cb_asiento_inc
 
go
print '--> Tabla: cb_boc_cre'
if exists(select 1 from sysobjects where name = 'cb_boc_cre')
   drop table cb_boc_cre
 
go
print '--> Tabla: cb_sal_prom'
if exists(select 1 from sysobjects where name = 'cb_sal_prom')
   drop table cb_sal_prom
 
go
print '--> Tabla: cb_comprobante_fp'
if exists(select 1 from sysobjects where name = 'cb_comprobante_fp')
   drop table cb_comprobante_fp
 
go
print '--> Tabla: cb_saldo_inc'
if exists(select 1 from sysobjects where name = 'cb_saldo_inc')
   drop table cb_saldo_inc
 
go
print '--> Tabla: cb_sal_tmp_con_mes'
if exists(select 1 from sysobjects where name = 'cb_sal_tmp_con_mes')
   drop table cb_sal_tmp_con_mes
 
go
print '--> Tabla: cb_conc_retencion'
if exists(select 1 from sysobjects where name = 'cb_conc_retencion')
   drop table cb_conc_retencion
 
go
print '--> Tabla: cb_sal_tmp_con_of'
if exists(select 1 from sysobjects where name = 'cb_sal_tmp_con_of')
   drop table cb_sal_tmp_con_of
 
go
print '--> Tabla: cb_concepto_asiento'
if exists(select 1 from sysobjects where name = 'cb_concepto_asiento')
   drop table cb_concepto_asiento
 
go
print '--> Tabla: cb_saldo'
if exists(select 1 from sysobjects where name = 'cb_saldo')
   drop table cb_saldo
 
go
print '--> Tabla: cb_conceptos_conciliacion'
if exists(select 1 from sysobjects where name = 'cb_conceptos_conciliacion')
   drop table cb_conceptos_conciliacion
 
go
print '--> Tabla: cb_saldo_cltercero_tmp'
if exists(select 1 from sysobjects where name = 'cb_saldo_cltercero_tmp')
   drop table cb_saldo_cltercero_tmp
 
go
print '--> Tabla: cb_conceptos_movimientos'
if exists(select 1 from sysobjects where name = 'cb_conceptos_movimientos')
   drop table cb_conceptos_movimientos
 
go
print '--> Tabla: cb_saldo_cta_sobregiros'
if exists(select 1 from sysobjects where name = 'cb_saldo_cta_sobregiros')
   drop table cb_saldo_cta_sobregiros
 
go
print '--> Tabla: cb_saldo_fp'
if exists(select 1 from sysobjects where name = 'cb_saldo_fp')
   drop table cb_saldo_fp
 
go
print '--> Tabla: cb_conciliacion'
if exists(select 1 from sysobjects where name = 'cb_conciliacion')
   drop table cb_conciliacion
 
go
print '--> Tabla: cb_sec_perf'
if exists(select 1 from sysobjects where name = 'cb_sec_perf')
   drop table cb_sec_perf
 
go
print '--> Tabla: cb_saldo_histh1'
if exists(select 1 from sysobjects where name = 'cb_saldo_histh1')
   drop table cb_saldo_histh1
 
go
print '--> Tabla: cb_boc_cta_perfil'
if exists(select 1 from sysobjects where name = 'cb_boc_cta_perfil')
   drop table cb_boc_cta_perfil
 
go
print '--> Tabla: cb_conciliacion_mig'
if exists(select 1 from sysobjects where name = 'cb_conciliacion_mig')
   drop table cb_conciliacion_mig
 
go
print '--> Tabla: cb_cambestado_tmp'
if exists(select 1 from sysobjects where name = 'cb_cambestado_tmp')
   drop table cb_cambestado_tmp
 
go
print '--> Tabla: cb_boc_respaldo'
if exists(select 1 from sysobjects where name = 'cb_boc_respaldo')
   drop table cb_boc_respaldo
 
go
print '--> Tabla: cb_saldo_may'
if exists(select 1 from sysobjects where name = 'cb_saldo_may')
   drop table cb_saldo_may
 
go
print '--> Tabla: cb_conciliacion_operaciones'
if exists(select 1 from sysobjects where name = 'cb_conciliacion_operaciones')
   drop table cb_conciliacion_operaciones
 
go
print '--> Tabla: cb_cuentas_log'
if exists(select 1 from sysobjects where name = 'cb_cuentas_log')
   drop table cb_cuentas_log
 
go
print '--> Tabla: cb_saldo_presupuesto'
if exists(select 1 from sysobjects where name = 'cb_saldo_presupuesto')
   drop table cb_saldo_presupuesto
 
go
print '--> Tabla: cb_consecutivo'
if exists(select 1 from sysobjects where name = 'cb_consecutivo')
   drop table cb_consecutivo
 
go
print '--> Tabla: cb_cambcta_tmp'
if exists(select 1 from sysobjects where name = 'cb_cambcta_tmp')
   drop table cb_cambcta_tmp
 
go
print '--> Tabla: cb_saldo_tercero_fp'
if exists(select 1 from sysobjects where name = 'cb_saldo_tercero_fp')
   drop table cb_saldo_tercero_fp
 
go
print '--> Tabla: cb_consulta_perfil'
if exists(select 1 from sysobjects where name = 'cb_consulta_perfil')
   drop table cb_consulta_perfil
 
go
print '--> Tabla: cb_totales_tmp'
if exists(select 1 from sysobjects where name = 'cb_totales_tmp')
   drop table cb_totales_tmp
 
go
print '--> Tabla: cb_boc_det_respaldo'
if exists(select 1 from sysobjects where name = 'cb_boc_det_respaldo')
   drop table cb_boc_det_respaldo
 
go
print '--> Tabla: cb_saldo_tercero_rep'
if exists(select 1 from sysobjects where name = 'cb_saldo_tercero_rep')
   drop table cb_saldo_tercero_rep
 
go
print '--> Tabla: cb_control'
if exists(select 1 from sysobjects where name = 'cb_control')
   drop table cb_control
 
go
print '--> Tabla: asociada'
if exists(select 1 from sysobjects where name = 'asociada')
   drop table asociada
 
go
print '--> Tabla: cb_boc_log_respaldo'
if exists(select 1 from sysobjects where name = 'cb_boc_log_respaldo')
   drop table cb_boc_log_respaldo
 
go
print '--> Tabla: cb_paramdep'
if exists(select 1 from sysobjects where name = 'cb_paramdep')
   drop table cb_paramdep
 
go
print '--> Tabla: cb_saldo_tmp'
if exists(select 1 from sysobjects where name = 'cb_saldo_tmp')
   drop table cb_saldo_tmp
 
go
print '--> Tabla: CONTROL_BATCH'
if exists(select 1 from sysobjects where name = 'CONTROL_BATCH')
   drop table CONTROL_BATCH
 
go
print '--> Tabla: cb_concil_may_terc'
if exists(select 1 from sysobjects where name = 'cb_concil_may_terc')
   drop table cb_concil_may_terc
 
go
print '--> Tabla: cb_saldos_grupos'
if exists(select 1 from sysobjects where name = 'cb_saldos_grupos')
   drop table cb_saldos_grupos
 
go
print '--> Tabla: cb_sasiento_mig'
if exists(select 1 from sysobjects where name = 'cb_sasiento_mig')
   drop table cb_sasiento_mig
 
go
print '--> Tabla: cb_corte'
if exists(select 1 from sysobjects where name = 'cb_corte')
   drop table cb_corte
 
go
print '--> Tabla: cb_sat_def_con_mes'
if exists(select 1 from sysobjects where name = 'cb_sat_def_con_mes')
   drop table cb_sat_def_con_mes
 
go
print '--> Tabla: cb_corte_oficina'
if exists(select 1 from sysobjects where name = 'cb_corte_oficina')
   drop table cb_corte_oficina
 
go
print '--> Tabla: cb_paso_tmp'
if exists(select 1 from sysobjects where name = 'cb_paso_tmp')
   drop table cb_paso_tmp
 
go
print '--> Tabla: cb_cuentas_canc_tmp'
if exists(select 1 from sysobjects where name = 'cb_cuentas_canc_tmp')
   drop table cb_cuentas_canc_tmp
 
go
print '--> Tabla: cb_sat_def_con_of'
if exists(select 1 from sysobjects where name = 'cb_sat_def_con_of')
   drop table cb_sat_def_con_of
 
go
print '--> Tabla: cb_cotizacion'
if exists(select 1 from sysobjects where name = 'cb_cotizacion')
   drop table cb_cotizacion
 
go
print '--> Tabla: cb_libromov_dia'
if exists(select 1 from sysobjects where name = 'cb_libromov_dia')
   drop table cb_libromov_dia
 
go
print '--> Tabla: cb_sat_tmp_con_mes'
if exists(select 1 from sysobjects where name = 'cb_sat_tmp_con_mes')
   drop table cb_sat_tmp_con_mes
 
go
print '--> Tabla: cb_cta_temp'
if exists(select 1 from sysobjects where name = 'cb_cta_temp')
   drop table cb_cta_temp
 
go
print '--> Tabla: cb_libromov_mayba'
if exists(select 1 from sysobjects where name = 'cb_libromov_mayba')
   drop table cb_libromov_mayba
 
go
print '--> Tabla: cb_sat_tmp_con_of'
if exists(select 1 from sysobjects where name = 'cb_sat_tmp_con_of')
   drop table cb_sat_tmp_con_of
 
go
print '--> Tabla: cb_ctaproc_tmp'
if exists(select 1 from sysobjects where name = 'cb_ctaproc_tmp')
   drop table cb_ctaproc_tmp
 
go
print '--> Tabla: cb_scomprobante_mig'
if exists(select 1 from sysobjects where name = 'cb_scomprobante_mig')
   drop table cb_scomprobante_mig
 
go
print '--> Tabla: cb_cuenta'
if exists(select 1 from sysobjects where name = 'cb_cuenta')
   drop table cb_cuenta
 
go
print '--> Tabla: cb_rep_gmf_chq'
if exists(select 1 from sysobjects where name = 'cb_rep_gmf_chq')
   drop table cb_rep_gmf_chq
 
go
print '--> Tabla: cb_secuencerti'
if exists(select 1 from sysobjects where name = 'cb_secuencerti')
   drop table cb_secuencerti
 
go
print '--> Tabla: cb_cuenta6004'
if exists(select 1 from sysobjects where name = 'cb_cuenta6004')
   drop table cb_cuenta6004
 
go
print '--> Tabla: cb_seguridad'
if exists(select 1 from sysobjects where name = 'cb_seguridad')
   drop table cb_seguridad
 
go
print '--> Tabla: cb_cuenta_asociada'
if exists(select 1 from sysobjects where name = 'cb_cuenta_asociada')
   drop table cb_cuenta_asociada
 
go
print '--> Tabla: cb_conceptos_concilia'
if exists(select 1 from sysobjects where name = 'cb_conceptos_concilia')
   drop table cb_conceptos_concilia
 
go
print '--> Tabla: cb_seqnos'
if exists(select 1 from sysobjects where name = 'cb_seqnos')
   drop table cb_seqnos
 
go
print '--> Tabla: cb_cuenta_mig'
if exists(select 1 from sysobjects where name = 'cb_cuenta_mig')
   drop table cb_cuenta_mig
 
go
print '--> Tabla: archivo_temp'
if exists(select 1 from sysobjects where name = 'archivo_temp')
   drop table archivo_temp
 
go
print '--> Tabla: cb_seqnos_comprobante'
if exists(select 1 from sysobjects where name = 'cb_seqnos_comprobante')
   drop table cb_seqnos_comprobante
 
go
print '--> Tabla: cb_cuenta_presupuesto'
if exists(select 1 from sysobjects where name = 'cb_cuenta_presupuesto')
   drop table cb_cuenta_presupuesto
 
go
print '--> Tabla: cb_tasiento'
if exists(select 1 from sysobjects where name = 'cb_tasiento')
   drop table cb_tasiento
 
go
print '--> Tabla: cb_cuenta_proceso'
if exists(select 1 from sysobjects where name = 'cb_cuenta_proceso')
   drop table cb_cuenta_proceso
 
go
print '--> Tabla: cb_val_arch'
if exists(select 1 from sysobjects where name = 'cb_val_arch')
   drop table cb_val_arch
 
go
print '--> Tabla: cb_tasiento_2'
if exists(select 1 from sysobjects where name = 'cb_tasiento_2')
   drop table cb_tasiento_2
 
go
print '--> Tabla: cb_cuenta_producto'
if exists(select 1 from sysobjects where name = 'cb_cuenta_producto')
   drop table cb_cuenta_producto
 
go
print '--> Tabla: header'
if exists(select 1 from sysobjects where name = 'header')
   drop table header
 
go
print '--> Tabla: cb_tcomp_tipo'
if exists(select 1 from sysobjects where name = 'cb_tcomp_tipo')
   drop table cb_tcomp_tipo
 
go
print '--> Tabla: cb_cuenta_saldo_tmp'
if exists(select 1 from sysobjects where name = 'cb_cuenta_saldo_tmp')
   drop table cb_cuenta_saldo_tmp
 
go
print '--> Tabla: body'
if exists(select 1 from sysobjects where name = 'body')
   drop table body
 
go
print '--> Tabla: tmp_saldo_hist'
if exists(select 1 from sysobjects where name = 'tmp_saldo_hist')
   drop table tmp_saldo_hist
 
go
print '--> Tabla: cb_tcomprobante'
if exists(select 1 from sysobjects where name = 'cb_tcomprobante')
   drop table cb_tcomprobante
 
go
print '--> Tabla: cb_cuentas_ajuste'
if exists(select 1 from sysobjects where name = 'cb_cuentas_ajuste')
   drop table cb_cuentas_ajuste
 
go
print '--> Tabla: ca_comision_recaudo'
if exists(select 1 from sysobjects where name = 'ca_comision_recaudo')
   drop table ca_comision_recaudo
 
go
print '--> Tabla: footer'
if exists(select 1 from sysobjects where name = 'footer')
   drop table footer
 
go
print '--> Tabla: cb_tconcepto_asiento'
if exists(select 1 from sysobjects where name = 'cb_tconcepto_asiento')
   drop table cb_tconcepto_asiento
 
go
print '--> Tabla: cb_cuentas_consolidado'
if exists(select 1 from sysobjects where name = 'cb_cuentas_consolidado')
   drop table cb_cuentas_consolidado
 
go
print '--> Tabla: detail'
if exists(select 1 from sysobjects where name = 'detail')
   drop table detail
 
go
print '--> Tabla: cb_tconciliacion'
if exists(select 1 from sysobjects where name = 'cb_tconciliacion')
   drop table cb_tconciliacion
 
go
print '--> Tabla: cb_cuentas_tmp'
if exists(select 1 from sysobjects where name = 'cb_cuentas_tmp')
   drop table cb_cuentas_tmp
 
go
print '--> Tabla: tmp_comp_asientos'
if exists(select 1 from sysobjects where name = 'tmp_comp_asientos')
   drop table tmp_comp_asientos
 
go
print '--> Tabla: cuenta_saldo'
if exists(select 1 from sysobjects where name = 'cuenta_saldo')
   drop table cuenta_saldo
 
go
print '--> Tabla: cb_tconvivencia'
if exists(select 1 from sysobjects where name = 'cb_tconvivencia')
   drop table cb_tconvivencia
 
go
print '--> Tabla: cb_datos_ente_tmp'
if exists(select 1 from sysobjects where name = 'cb_datos_ente_tmp')
   drop table cb_datos_ente_tmp
 
go
print '--> Tabla: cb_tdet_comptipo'
if exists(select 1 from sysobjects where name = 'cb_tdet_comptipo')
   drop table cb_tdet_comptipo
 
go
print '--> Tabla: tmp_saldo_hist_dw'
if exists(select 1 from sysobjects where name = 'tmp_saldo_hist_dw')
   drop table tmp_saldo_hist_dw
 
go
print '--> Tabla: cb_tdet_perfil'
if exists(select 1 from sysobjects where name = 'cb_tdet_perfil')
   drop table cb_tdet_perfil
 
go
print '--> Tabla: cb_det_comptipo'
if exists(select 1 from sysobjects where name = 'cb_det_comptipo')
   drop table cb_det_comptipo
 
go
print '--> Tabla: cb_reporte_sob_total'
if exists(select 1 from sysobjects where name = 'cb_reporte_sob_total')
   drop table cb_reporte_sob_total
 
go
print '--> Tabla: cb_tdetest'
if exists(select 1 from sysobjects where name = 'cb_tdetest')
   drop table cb_tdetest
 
go
print '--> Tabla: cb_det_perfil'
if exists(select 1 from sysobjects where name = 'cb_det_perfil')
   drop table cb_det_perfil
 
go
print '--> Tabla: cb_temp_cuenta'
if exists(select 1 from sysobjects where name = 'cb_temp_cuenta')
   drop table cb_temp_cuenta
 
go
print '--> Tabla: cb_detest'
if exists(select 1 from sysobjects where name = 'cb_detest')
   drop table cb_detest
 
go
print '--> Tabla: cb_temp_cuenta2'
if exists(select 1 from sysobjects where name = 'cb_temp_cuenta2')
   drop table cb_temp_cuenta2
 
go
print '--> Tabla: cb_dian_cta_cod'
if exists(select 1 from sysobjects where name = 'cb_dian_cta_cod')
   drop table cb_dian_cta_cod
 
go
print '--> Tabla: cb_temp_mon_ex'
if exists(select 1 from sysobjects where name = 'cb_temp_mon_ex')
   drop table cb_temp_mon_ex
 
go
print '--> Tabla: cb_diferidos'
if exists(select 1 from sysobjects where name = 'cb_diferidos')
   drop table cb_diferidos
 
go
print '--> Tabla: cb_tempsaldos'
if exists(select 1 from sysobjects where name = 'cb_tempsaldos')
   drop table cb_tempsaldos
 
go
print '--> Tabla: cb_dinamica'
if exists(select 1 from sysobjects where name = 'cb_dinamica')
   drop table cb_dinamica
 
go
print '--> Tabla: cb_fechadep_boc'
if exists(select 1 from sysobjects where name = 'cb_fechadep_boc')
   drop table cb_fechadep_boc
 
go
print '--> Tabla: cb_boc'
if exists(select 1 from sysobjects where name = 'cb_boc')
   drop table cb_boc
 
go
print '--> Tabla: cb_tercero'
if exists(select 1 from sysobjects where name = 'cb_tercero')
   drop table cb_tercero
 
go
print '--> Tabla: cb_doble_cont'
if exists(select 1 from sysobjects where name = 'cb_doble_cont')
   drop table cb_doble_cont
 
go
print '--> Tabla: cuentas'
if exists(select 1 from sysobjects where name = 'cuentas')
   drop table cuentas
 
go
print '--> Tabla: cb_boc_det'
if exists(select 1 from sysobjects where name = 'cb_boc_det')
   drop table cb_boc_det
 
go
print '--> Tabla: cb_testcta'
if exists(select 1 from sysobjects where name = 'cb_testcta')
   drop table cb_testcta
 
go
print '--> Tabla: tmp_comp'
if exists(select 1 from sysobjects where name = 'tmp_comp')
   drop table tmp_comp
 
go
print '--> Tabla: cb_empresa'
if exists(select 1 from sysobjects where name = 'cb_empresa')
   drop table cb_empresa
 
go
print '--> Tabla: cb_tmp_may_ter'
if exists(select 1 from sysobjects where name = 'cb_tmp_may_ter')
   drop table cb_tmp_may_ter
 
go
print '--> Tabla: cb_boc_operaciones_desagrupadas'
if exists(select 1 from sysobjects where name = 'cb_boc_operaciones_desagrupadas')
   drop table cb_boc_operaciones_desagrupadas
 
go
print '--> Tabla: cb_error_difer'
if exists(select 1 from sysobjects where name = 'cb_error_difer')
   drop table cb_error_difer
 
go
print '--> Tabla: cb_boc_log'
if exists(select 1 from sysobjects where name = 'cb_boc_log')
   drop table cb_boc_log
 
go
print '--> Tabla: cb_tipo_area'
if exists(select 1 from sysobjects where name = 'cb_tipo_area')
   drop table cb_tipo_area
 
go
print '--> Tabla: cb_errores'
if exists(select 1 from sysobjects where name = 'cb_errores')
   drop table cb_errores
 
go
print '--> Tabla: reporte'
if exists(select 1 from sysobjects where name = 'reporte')
   drop table reporte
 
go
print '--> Tabla: cb_boc_oficina'
if exists(select 1 from sysobjects where name = 'cb_boc_oficina')
   drop table cb_boc_oficina
 
go
print '--> Tabla: cb_tipo_doc'
if exists(select 1 from sysobjects where name = 'cb_tipo_doc')
   drop table cb_tipo_doc
 
go
print '--> Tabla: cb_errores_consu'
if exists(select 1 from sysobjects where name = 'cb_errores_consu')
   drop table cb_errores_consu
 
go
print '--> Tabla: cb_reporte_revisoria'
if exists(select 1 from sysobjects where name = 'cb_reporte_revisoria')
   drop table cb_reporte_revisoria
 
go
print '--> Tabla: cb_comprobantes_manuales_cab'
if exists(select 1 from sysobjects where name = 'cb_comprobantes_manuales_cab')
   drop table cb_comprobantes_manuales_cab
 
go
print '--> Tabla: cb_tmp_area'
if exists(select 1 from sysobjects where name = 'cb_tmp_area')
   drop table cb_tmp_area
 
go
print '--> Tabla: cb_errores_mig'
if exists(select 1 from sysobjects where name = 'cb_errores_mig')
   drop table cb_errores_mig
 
go
print '--> Tabla: cb_comprobantes_manuales'
if exists(select 1 from sysobjects where name = 'cb_comprobantes_manuales')
   drop table cb_comprobantes_manuales
 
go
print '--> Tabla: cb_tmp_asiento'
if exists(select 1 from sysobjects where name = 'cb_tmp_asiento')
   drop table cb_tmp_asiento
 
go
print '--> Tabla: cb_errores_valplan'
if exists(select 1 from sysobjects where name = 'cb_errores_valplan')
   drop table cb_errores_valplan
 
go
print '--> Tabla: cb_cta_contables_cab'
if exists(select 1 from sysobjects where name = 'cb_cta_contables_cab')
   drop table cb_cta_contables_cab
 
go
print '--> Tabla: cb_tmp_codigo_valor'
if exists(select 1 from sysobjects where name = 'cb_tmp_codigo_valor')
   drop table cb_tmp_codigo_valor
 
go
print '--> Tabla: cb_estado_mig'
if exists(select 1 from sysobjects where name = 'cb_estado_mig')
   drop table cb_estado_mig
 
go
print '--> Tabla: cb_cta_contables'
if exists(select 1 from sysobjects where name = 'cb_cta_contables')
   drop table cb_cta_contables
 
go
print '--> Tabla: cb_tmp_cuenta'
if exists(select 1 from sysobjects where name = 'cb_tmp_cuenta')
   drop table cb_tmp_cuenta
 
go
print '--> Tabla: cb_estadocta_tmp'
if exists(select 1 from sysobjects where name = 'cb_estadocta_tmp')
   drop table cb_estadocta_tmp
 
go
print '--> Tabla: cb_tmp_cuenta_asociada'
if exists(select 1 from sysobjects where name = 'cb_tmp_cuenta_asociada')
   drop table cb_tmp_cuenta_asociada
 
go
print '--> Tabla: tmp_aux_contables'
if exists(select 1 from sysobjects where name = 'tmp_aux_contables')
   drop table tmp_aux_contables
 
go
print '--> Tabla: cb_estcta'
if exists(select 1 from sysobjects where name = 'cb_estcta')
   drop table cb_estcta
 
go
print '--> Tabla: cb_tmp_cuenta_proceso'
if exists(select 1 from sysobjects where name = 'cb_tmp_cuenta_proceso')
   drop table cb_tmp_cuenta_proceso
 
go
print '--> Tabla: cb_estructura_tabla'
if exists(select 1 from sysobjects where name = 'cb_estructura_tabla')
   drop table cb_estructura_tabla
 
go
print '--> Tabla: cb_tmp_det_perfil'
if exists(select 1 from sysobjects where name = 'cb_tmp_det_perfil')
   drop table cb_tmp_det_perfil
 
go
print '--> Tabla: cb_exencion_ciudad'
if exists(select 1 from sysobjects where name = 'cb_exencion_ciudad')
   drop table cb_exencion_ciudad
 
go
print '--> Tabla: cb_tmp_gmfaplsum'
if exists(select 1 from sysobjects where name = 'cb_tmp_gmfaplsum')
   drop table cb_tmp_gmfaplsum
 
go
print '--> Tabla: cb_exencion_producto'
if exists(select 1 from sysobjects where name = 'cb_exencion_producto')
   drop table cb_exencion_producto
 
go
print '--> Tabla: cb_tmp_gmfmov'
if exists(select 1 from sysobjects where name = 'cb_tmp_gmfmov')
   drop table cb_tmp_gmfmov
 
go
print '--> Tabla: cb_erreres_batch'
if exists(select 1 from sysobjects where name = 'cb_erreres_batch')
   drop table cb_erreres_batch
 
go
print '--> Tabla: cb_fechas_certificados'
if exists(select 1 from sysobjects where name = 'cb_fechas_certificados')
   drop table cb_fechas_certificados
 
go
print '--> Tabla: cb_tmp_gmfmovsum'
if exists(select 1 from sysobjects where name = 'cb_tmp_gmfmovsum')
   drop table cb_tmp_gmfmovsum
 
go
print '--> Tabla: cb_general_presupuesto'
if exists(select 1 from sysobjects where name = 'cb_general_presupuesto')
   drop table cb_general_presupuesto
 
go
print '--> Tabla: cb_blcom'
if exists(select 1 from sysobjects where name = 'cb_blcom')
   drop table cb_blcom
 
go
print '--> Tabla: cb_reporte_diferencias_cab'
if exists(select 1 from sysobjects where name = 'cb_reporte_diferencias_cab')
   drop table cb_reporte_diferencias_cab
 
go
print '--> Tabla: cb_tmp_ivamov'
if exists(select 1 from sysobjects where name = 'cb_tmp_ivamov')
   drop table cb_tmp_ivamov
 
go
print '--> Tabla: cb_gravamen_mf'
if exists(select 1 from sysobjects where name = 'cb_gravamen_mf')
   drop table cb_gravamen_mf
 
go
print '--> Tabla: cb_tmp_ivamovsum'
if exists(select 1 from sysobjects where name = 'cb_tmp_ivamovsum')
   drop table cb_tmp_ivamovsum
 
go
print '--> Tabla: cb_grupo_gastos'
if exists(select 1 from sysobjects where name = 'cb_grupo_gastos')
   drop table cb_grupo_gastos
 
go
print '--> Tabla: cb_perfil_nocobis'
if exists(select 1 from sysobjects where name = 'cb_perfil_nocobis')
   drop table cb_perfil_nocobis
 
go
print '--> Tabla: cb_tmp_jerararea'
if exists(select 1 from sysobjects where name = 'cb_tmp_jerararea')
   drop table cb_tmp_jerararea
 
go
print '--> Tabla: cb_hist_saldo_tmp'
if exists(select 1 from sysobjects where name = 'cb_hist_saldo_tmp')
   drop table cb_hist_saldo_tmp
 
go
print '--> Tabla: cb_tmp_jerarquia'
if exists(select 1 from sysobjects where name = 'cb_tmp_jerarquia')
   drop table cb_tmp_jerarquia
 
go
print '--> Tabla: cb_ica'
if exists(select 1 from sysobjects where name = 'cb_ica')
   drop table cb_ica
 
go
print '--> Tabla: cb_cuenperfi'
if exists(select 1 from sysobjects where name = 'cb_cuenperfi')
   drop table cb_cuenperfi
 
go
print '--> Tabla: cb_imptos_deptales'
if exists(select 1 from sysobjects where name = 'cb_imptos_deptales')
   drop table cb_imptos_deptales
 
go
print '--> Tabla: cb_impuestos'
if exists(select 1 from sysobjects where name = 'cb_impuestos')
   drop table cb_impuestos
 
go
print '--> Tabla: cb_indcom'
if exists(select 1 from sysobjects where name = 'cb_indcom')
   drop table cb_indcom
 
go
print '--> Tabla: cb_tmp_oficina'
if exists(select 1 from sysobjects where name = 'cb_tmp_oficina')
   drop table cb_tmp_oficina
 
go
print '--> Tabla: cb_indicadores'
if exists(select 1 from sysobjects where name = 'cb_indicadores')
   drop table cb_indicadores
 
go
print '--> Tabla: cb_cuenta_pyg'
if exists(select 1 from sysobjects where name = 'cb_cuenta_pyg')
   drop table cb_cuenta_pyg
 
go
print '--> Tabla: cb_tmp_parametro'
if exists(select 1 from sysobjects where name = 'cb_tmp_parametro')
   drop table cb_tmp_parametro
 
go
print '--> Tabla: cb_inmovpro'
if exists(select 1 from sysobjects where name = 'cb_inmovpro')
   drop table cb_inmovpro
 
go
print '--> Tabla: cb_tmp_perfil'
if exists(select 1 from sysobjects where name = 'cb_tmp_perfil')
   drop table cb_tmp_perfil
 
go
print '--> Tabla: cb_insertar_usuarios'
if exists(select 1 from sysobjects where name = 'cb_insertar_usuarios')
   drop table cb_insertar_usuarios
 
go
print '--> Tabla: cb_tmp_plan_general'
if exists(select 1 from sysobjects where name = 'cb_tmp_plan_general')
   drop table cb_tmp_plan_general
 
go
print '--> Tabla: cb_rep_no_cont'
if exists(select 1 from sysobjects where name = 'cb_rep_no_cont')
   drop table cb_rep_no_cont
 
go
print '--> Tabla: cb_item'
if exists(select 1 from sysobjects where name = 'cb_item')
   drop table cb_item
 
go
print '--> Tabla: cb_depurar'
if exists(select 1 from sysobjects where name = 'cb_depurar')
   drop table cb_depurar
 
go
print '--> Tabla: tmp_mincorte_cli'
if exists(select 1 from sysobjects where name = 'tmp_mincorte_cli')
   drop table tmp_mincorte_cli
 
go
print '--> Tabla: cb_tmp_relparam'
if exists(select 1 from sysobjects where name = 'cb_tmp_relparam')
   drop table cb_tmp_relparam
 
go
print '--> Tabla: cb_iva'
if exists(select 1 from sysobjects where name = 'cb_iva')
   drop table cb_iva
 
go
print '--> Tabla: cb_todas_temp'
if exists(select 1 from sysobjects where name = 'cb_todas_temp')
   drop table cb_todas_temp
 
go
print '--> Tabla: cb_iva_pagado'
if exists(select 1 from sysobjects where name = 'cb_iva_pagado')
   drop table cb_iva_pagado
 
go
print '--> Tabla: asiento'
if exists(select 1 from sysobjects where name = 'asiento')
   drop table asiento
 
go
print '--> Tabla: cb_mig_area'
if exists(select 1 from sysobjects where name = 'cb_mig_area')
   drop table cb_mig_area
 
go
print '--> Tabla: cb_todas_temp1'
if exists(select 1 from sysobjects where name = 'cb_todas_temp1')
   drop table cb_todas_temp1
 
go
print '--> Tabla: cb_jerararea'
if exists(select 1 from sysobjects where name = 'cb_jerararea')
   drop table cb_jerararea
 
go
print '--> Tabla: cb_mig_campos_errados'
if exists(select 1 from sysobjects where name = 'cb_mig_campos_errados')
   drop table cb_mig_campos_errados
 
go
print '--> Tabla: cb_tperfil'
if exists(select 1 from sysobjects where name = 'cb_tperfil')
   drop table cb_tperfil
 
go
print '--> Tabla: cb_jerarquia'
if exists(select 1 from sysobjects where name = 'cb_jerarquia')
   drop table cb_jerarquia
 
go
print '--> Tabla: cb_rep_cancela_orden'
if exists(select 1 from sysobjects where name = 'cb_rep_cancela_orden')
   drop table cb_rep_cancela_orden
 
go
print '--> Tabla: cb_mig_codigo_valor'
if exists(select 1 from sysobjects where name = 'cb_mig_codigo_valor')
   drop table cb_mig_codigo_valor
 
go
print '--> Tabla: cb_tran_servicio'
if exists(select 1 from sysobjects where name = 'cb_tran_servicio')
   drop table cb_tran_servicio
 
go
print '--> Tabla: cb_log_errores_mig'
if exists(select 1 from sysobjects where name = 'cb_log_errores_mig')
   drop table cb_log_errores_mig
 
go
print '--> Tabla: cb_rep_cancela_orden_tmp'
if exists(select 1 from sysobjects where name = 'cb_rep_cancela_orden_tmp')
   drop table cb_rep_cancela_orden_tmp
 
go
print '--> Tabla: cb_mig_cuenta_asociada'
if exists(select 1 from sysobjects where name = 'cb_mig_cuenta_asociada')
   drop table cb_mig_cuenta_asociada
 
go
print '--> Tabla: cb_tretencion'
if exists(select 1 from sysobjects where name = 'cb_tretencion')
   drop table cb_tretencion
 
go
print '--> Tabla: cb_mig_cuenta_proceso'
if exists(select 1 from sysobjects where name = 'cb_mig_cuenta_proceso')
   drop table cb_mig_cuenta_proceso
 
go
print '--> Tabla: cb_tretencion_tipo'
if exists(select 1 from sysobjects where name = 'cb_tretencion_tipo')
   drop table cb_tretencion_tipo
 
go
print '--> Tabla: cb_cuenta_niif'
if exists(select 1 from sysobjects where name = 'cb_cuenta_niif')
   drop table cb_cuenta_niif
 
go
print '--> Tabla: t_reexp'
if exists(select 1 from sysobjects where name = 't_reexp')
   drop table t_reexp
 
go
print '--> Tabla: cb_mig_cuentas'
if exists(select 1 from sysobjects where name = 'cb_mig_cuentas')
   drop table cb_mig_cuentas
 
go
print '--> Tabla: cb_ts_perfil'
if exists(select 1 from sysobjects where name = 'cb_ts_perfil')
   drop table cb_ts_perfil
 
go
print '--> Tabla: cb_mig_det_perfil'
if exists(select 1 from sysobjects where name = 'cb_mig_det_perfil')
   drop table cb_mig_det_perfil
 
go
print '--> Tabla: cb_tval_item'
if exists(select 1 from sysobjects where name = 'cb_tval_item')
   drop table cb_tval_item
 
go
print '--> Tabla: cb_mig_estado'
if exists(select 1 from sysobjects where name = 'cb_mig_estado')
   drop table cb_mig_estado
 
go
print '--> Tabla: cb_tvalidacion_tipo'
if exists(select 1 from sysobjects where name = 'cb_tvalidacion_tipo')
   drop table cb_tvalidacion_tipo
 
go
print '--> Tabla: cb_mig_jerararea'
if exists(select 1 from sysobjects where name = 'cb_mig_jerararea')
   drop table cb_mig_jerararea
 
go
print '--> Tabla: cb_usu_capt_comp'
if exists(select 1 from sysobjects where name = 'cb_usu_capt_comp')
   drop table cb_usu_capt_comp
 
go
print '--> Tabla: cb_area_responsable'
if exists(select 1 from sysobjects where name = 'cb_area_responsable')
   drop table cb_area_responsable
 
go
print '--> Tabla: cb_mig_jerarquia'
if exists(select 1 from sysobjects where name = 'cb_mig_jerarquia')
   drop table cb_mig_jerarquia
 
go
print '--> Tabla: cb_val_item'
if exists(select 1 from sysobjects where name = 'cb_val_item')
   drop table cb_val_item
 
go
print '--> Tabla: cb_registro'
if exists(select 1 from sysobjects where name = 'cb_registro')
   drop table cb_registro
 
go
print '--> Tabla: cb_mig_oficina'
if exists(select 1 from sysobjects where name = 'cb_mig_oficina')
   drop table cb_mig_oficina
 
go
print '--> Tabla: cb_validacion'
if exists(select 1 from sysobjects where name = 'cb_validacion')
   drop table cb_validacion
 
go
print '--> Tabla: cb_pgcom'
if exists(select 1 from sysobjects where name = 'cb_pgcom')
   drop table cb_pgcom
 
go
print '--> Tabla: tmp_cb_hist_saldo'
if exists(select 1 from sysobjects where name = 'tmp_cb_hist_saldo')
   drop table tmp_cb_hist_saldo
 
go
print '--> Tabla: cb_mig_parametro'
if exists(select 1 from sysobjects where name = 'cb_mig_parametro')
   drop table cb_mig_parametro
 
go
print '--> Tabla: cb_valplan_temp'
if exists(select 1 from sysobjects where name = 'cb_valplan_temp')
   drop table cb_valplan_temp
 
go
print '--> Tabla: tmp_cb_hist_saldo2'
if exists(select 1 from sysobjects where name = 'tmp_cb_hist_saldo2')
   drop table tmp_cb_hist_saldo2
 
go
print '--> Tabla: asiento_1'
if exists(select 1 from sysobjects where name = 'asiento_1')
   drop table asiento_1
 
go
print '--> Tabla: cb_mig_perfil'
if exists(select 1 from sysobjects where name = 'cb_mig_perfil')
   drop table cb_mig_perfil
 
go
print '--> Tabla: cl_prueba'
if exists(select 1 from sysobjects where name = 'cl_prueba')
   drop table cl_prueba
 
go
print '--> Tabla: cb_oficina_tmp'
if exists(select 1 from sysobjects where name = 'cb_oficina_tmp')
   drop table cb_oficina_tmp
 
go
print '--> Tabla: asiento_2'
if exists(select 1 from sysobjects where name = 'asiento_2')
   drop table asiento_2
 
go
print '--> Tabla: cb_mig_plan_general'
if exists(select 1 from sysobjects where name = 'cb_mig_plan_general')
   drop table cb_mig_plan_general
 
go
print '--> Tabla: comp_temp'
if exists(select 1 from sysobjects where name = 'comp_temp')
   drop table comp_temp
 
go
print '--> Tabla: reexpresion_saldo'
if exists(select 1 from sysobjects where name = 'reexpresion_saldo')
   drop table reexpresion_saldo
 
go
print '--> Tabla: cb_tmp_mayfp'
if exists(select 1 from sysobjects where name = 'cb_tmp_mayfp')
   drop table cb_tmp_mayfp
 
go
print '--> Tabla: cb_mig_relparam'
if exists(select 1 from sysobjects where name = 'cb_mig_relparam')
   drop table cb_mig_relparam
 
go
print '--> Tabla: cb_convivencia_tmp'
if exists(select 1 from sysobjects where name = 'cb_convivencia_tmp')
   drop table cb_convivencia_tmp
 
go
print '--> Tabla: tmp_cb_saldo_promm'
if exists(select 1 from sysobjects where name = 'tmp_cb_saldo_promm')
   drop table tmp_cb_saldo_promm
 
go
print '--> Tabla: cb_convivencia'
if exists(select 1 from sysobjects where name = 'cb_convivencia')
   drop table cb_convivencia
 
go
print '--> Tabla: corte_act'
if exists(select 1 from sysobjects where name = 'corte_act')
   drop table corte_act
 
go
print '--> Tabla: corte_ant'
if exists(select 1 from sysobjects where name = 'corte_ant')
   drop table corte_ant
 
go
print '--> Tabla: cb_det_perfil_406'
if exists(select 1 from sysobjects where name = 'cb_det_perfil_406')
   drop table cb_det_perfil_406
 
go
print '--> Tabla: cb_boc_tmp'
if exists(select 1 from sysobjects where name = 'cb_boc_tmp')
   drop table cb_boc_tmp
 
go
print '--> Tabla: corte_aux'
if exists(select 1 from sysobjects where name = 'corte_aux')
   drop table corte_aux
 
go
print '--> Tabla: cb_det_perfil_409'
if exists(select 1 from sysobjects where name = 'cb_det_perfil_409')
   drop table cb_det_perfil_409
 
go
print '--> Tabla: corte_def'
if exists(select 1 from sysobjects where name = 'corte_def')
   drop table corte_def
 
go
print '--> Tabla: cb_migcta'
if exists(select 1 from sysobjects where name = 'cb_migcta')
   drop table cb_migcta
 
go
print '--> Tabla: corte_tmp'
if exists(select 1 from sysobjects where name = 'corte_tmp')
   drop table corte_tmp
 
go
print '--> Tabla: cb_migsaldo_presu'
if exists(select 1 from sysobjects where name = 'cb_migsaldo_presu')
   drop table cb_migsaldo_presu
 
go
print '--> Tabla: cp_tmp_ofi_sobregiros'
if exists(select 1 from sysobjects where name = 'cp_tmp_ofi_sobregiros')
   drop table cp_tmp_ofi_sobregiros
 
go
print '--> Tabla: cb_migsaldos'
if exists(select 1 from sysobjects where name = 'cb_migsaldos')
   drop table cb_migsaldos
 
go
print '--> Tabla: cp_tmp_saldos_sobregiros'
if exists(select 1 from sysobjects where name = 'cp_tmp_saldos_sobregiros')
   drop table cp_tmp_saldos_sobregiros
 
go
print '--> Tabla: cb_migsaldos_tmp'
if exists(select 1 from sysobjects where name = 'cb_migsaldos_tmp')
   drop table cb_migsaldos_tmp
 
go
print '--> Tabla: ct_saldo_tercero_tmp_con'
if exists(select 1 from sysobjects where name = 'ct_saldo_tercero_tmp_con')
   drop table ct_saldo_tercero_tmp_con
 
go
print '--> Tabla: cb_mov_act'
if exists(select 1 from sysobjects where name = 'cb_mov_act')
   drop table cb_mov_act
 
go
print '--> Tabla: cuenta_producto'
if exists(select 1 from sysobjects where name = 'cuenta_producto')
   drop table cuenta_producto
 
go
print '--> Tabla: cb_mov_ant'
if exists(select 1 from sysobjects where name = 'cb_mov_ant')
   drop table cb_mov_ant
 
go
print '--> Tabla: cb_tinterna'
if exists(select 1 from sysobjects where name = 'cb_tinterna')
   drop table cb_tinterna
 
go
print '--> Tabla: fecha_salter'
if exists(select 1 from sysobjects where name = 'fecha_salter')
   drop table fecha_salter
 
go
print '--> Tabla: cb_mov_banco'
if exists(select 1 from sysobjects where name = 'cb_mov_banco')
   drop table cb_mov_banco
 
go
print '--> Tabla: fechas'
if exists(select 1 from sysobjects where name = 'fechas')
   drop table fechas
 
go
print '--> Tabla: cb_mov_def_con_mes'
if exists(select 1 from sysobjects where name = 'cb_mov_def_con_mes')
   drop table cb_mov_def_con_mes
 
go
print '--> Tabla: ajuste_comprobante'
if exists(select 1 from sysobjects where name = 'ajuste_comprobante')
   drop table ajuste_comprobante
 
go
print '--> Tabla: mov_aux'
if exists(select 1 from sysobjects where name = 'mov_aux')
   drop table mov_aux
 
go
print '--> Tabla: cb_mov_def_con_of'
if exists(select 1 from sysobjects where name = 'cb_mov_def_con_of')
   drop table cb_mov_def_con_of
 
go
print '--> Tabla: cb_cuentas_ord_tmp_mv'
if exists(select 1 from sysobjects where name = 'cb_cuentas_ord_tmp_mv')
   drop table cb_cuentas_ord_tmp_mv
 
go
print '--> Tabla: ofic_tcta'
if exists(select 1 from sysobjects where name = 'ofic_tcta')
   drop table ofic_tcta
 
go
print '--> Tabla: cb_mov_tmp_con_mes'
if exists(select 1 from sysobjects where name = 'cb_mov_tmp_con_mes')
   drop table cb_mov_tmp_con_mes
 
go
print '--> Tabla: cb_cuentas_ord_tmp'
if exists(select 1 from sysobjects where name = 'cb_cuentas_ord_tmp')
   drop table cb_cuentas_ord_tmp
 
go
print '--> Tabla: oficina'
if exists(select 1 from sysobjects where name = 'oficina')
   drop table oficina
 
go
print '--> Tabla: cb_mov_tmp_con_of'
if exists(select 1 from sysobjects where name = 'cb_mov_tmp_con_of')
   drop table cb_mov_tmp_con_of
 
go
print '--> Tabla: prodiva'
if exists(select 1 from sysobjects where name = 'prodiva')
   drop table prodiva
 
go
print '--> Tabla: cb_mov_tmph1'
if exists(select 1 from sysobjects where name = 'cb_mov_tmph1')
   drop table cb_mov_tmph1
 
go
print '--> Tabla: prueba_part'
if exists(select 1 from sysobjects where name = 'prueba_part')
   drop table prueba_part
 
go
print '--> Tabla: fecha_dep'
if exists(select 1 from sysobjects where name = 'fecha_dep')
   drop table fecha_dep
 
go
print '--> Tabla: cb_movant_tmph1'
if exists(select 1 from sysobjects where name = 'cb_movant_tmph1')
   drop table cb_movant_tmph1
 
go
print '--> Tabla: cb_asiento'
if exists(select 1 from sysobjects where name = 'cb_asiento')
   drop table cb_asiento
 
go
print '--> Tabla: saldo'
if exists(select 1 from sysobjects where name = 'saldo')
   drop table saldo
 
go
print '--> Tabla: cb_nivel_area'
if exists(select 1 from sysobjects where name = 'cb_nivel_area')
   drop table cb_nivel_area
 
go
print '--> Tabla: cb_comprobante'
if exists(select 1 from sysobjects where name = 'cb_comprobante')
   drop table cb_comprobante
 
go
print '--> Tabla: saldoiva'
if exists(select 1 from sysobjects where name = 'saldoiva')
   drop table saldoiva
 
go
print '--> Tabla: cb_nivel_cuenta'
if exists(select 1 from sysobjects where name = 'cb_nivel_cuenta')
   drop table cb_nivel_cuenta
 
go
print '--> Tabla: cb_retencion'
if exists(select 1 from sysobjects where name = 'cb_retencion')
   drop table cb_retencion
 
go
print '--> Tabla: saldos_aux'
if exists(select 1 from sysobjects where name = 'saldos_aux')
   drop table saldos_aux
 
go
print '--> Tabla: cb_nivel_presupuesto'
if exists(select 1 from sysobjects where name = 'cb_nivel_presupuesto')
   drop table cb_nivel_presupuesto
 
go
print '--> Tabla: salter_def'
if exists(select 1 from sysobjects where name = 'salter_def')
   drop table salter_def
 
go
print '--> Tabla: cb_ofic_cont'
if exists(select 1 from sysobjects where name = 'cb_ofic_cont')
   drop table cb_ofic_cont
 
go
print '--> Tabla: cb_oficina'
if exists(select 1 from sysobjects where name = 'cb_oficina')
   drop table cb_oficina
 
go
print '--> Tabla: cb_oficina_cta_saldo_tmp'
if exists(select 1 from sysobjects where name = 'cb_oficina_cta_saldo_tmp')
   drop table cb_oficina_cta_saldo_tmp
 
go
print '--> Tabla: temporal_cb_asiento'
if exists(select 1 from sysobjects where name = 'temporal_cb_asiento')
   drop table temporal_cb_asiento
 
go
print '--> Tabla: cb_oficina_saldo_tmp'
if exists(select 1 from sysobjects where name = 'cb_oficina_saldo_tmp')
   drop table cb_oficina_saldo_tmp
 
go
print '--> Tabla: cl_temporal_bcp'
if exists(select 1 from sysobjects where name = 'cl_temporal_bcp')
   drop table cl_temporal_bcp
 
go
print '--> Tabla: cb_reporte_diferencias_det'
if exists(select 1 from sysobjects where name = 'cb_reporte_diferencias_det')
   drop table cb_reporte_diferencias_det
 
go
print '--> Tabla: cb_oficina_temp'
if exists(select 1 from sysobjects where name = 'cb_oficina_temp')
   drop table cb_oficina_temp
 
go
print '--> Tabla: cb_oficinacl_tmp'
if exists(select 1 from sysobjects where name = 'cb_oficinacl_tmp')
   drop table cb_oficinacl_tmp
 
go
print '--> Tabla: cb_ctrl_proceso_comp_pag_decl'
if exists(select 1 from sysobjects where name = 'cb_ctrl_proceso_comp_pag_decl')
   drop table cb_ctrl_proceso_comp_pag_decl
 
go
print '--> Tabla: tmp_cb_saldo_ter'
if exists(select 1 from sysobjects where name = 'tmp_cb_saldo_ter')
   drop table tmp_cb_saldo_ter
 
go
print '--> Tabla: cb_tmp_may'
if exists(select 1 from sysobjects where name = 'cb_tmp_may')
   drop table cb_tmp_may
 
go
print '--> Tabla: cb_ofpagadora'
if exists(select 1 from sysobjects where name = 'cb_ofpagadora')
   drop table cb_ofpagadora
 
go
print '--> Tabla: cb_reporte_sob'
if exists(select 1 from sysobjects where name = 'cb_reporte_sob')
   drop table cb_reporte_sob
 
go
print '--> Tabla: cb_ofi_pag_decl_tmp'
if exists(select 1 from sysobjects where name = 'cb_ofi_pag_decl_tmp')
   drop table cb_ofi_pag_decl_tmp
 
go
print '--> Tabla: tmp_cb_saldo_ter2'
if exists(select 1 from sysobjects where name = 'tmp_cb_saldo_ter2')
   drop table tmp_cb_saldo_ter2
 
go
print '--> Tabla: cb_mayba_tmp'
if exists(select 1 from sysobjects where name = 'cb_mayba_tmp')
   drop table cb_mayba_tmp
 
go
print '--> Tabla: cb_opc_item'
if exists(select 1 from sysobjects where name = 'cb_opc_item')
   drop table cb_opc_item
 
go
print '--> Tabla: cta_sobregirada'
if exists(select 1 from sysobjects where name = 'cta_sobregirada')
   drop table cta_sobregirada
 
go
print '--> Tabla: saldo_pago_declar_ret_tmp'
if exists(select 1 from sysobjects where name = 'saldo_pago_declar_ret_tmp')
   drop table saldo_pago_declar_ret_tmp
 
go
print '--> Tabla: cb_opcion'
if exists(select 1 from sysobjects where name = 'cb_opcion')
   drop table cb_opcion
 
go
print '--> Tabla: cb_rep_cuenta'
if exists(select 1 from sysobjects where name = 'cb_rep_cuenta')
   drop table cb_rep_cuenta
 
go
print '--> Tabla: cb_nits_ofi_pag_decl'
if exists(select 1 from sysobjects where name = 'cb_nits_ofi_pag_decl')
   drop table cb_nits_ofi_pag_decl
 
go
print '--> Tabla: tmp_saldo_traslado'
if exists(select 1 from sysobjects where name = 'tmp_saldo_traslado')
   drop table tmp_saldo_traslado
 
go
print '--> Tabla: cb_organizacion'
if exists(select 1 from sysobjects where name = 'cb_organizacion')
   drop table cb_organizacion
 
go
print '--> Tabla: cb_ofi_org'
if exists(select 1 from sysobjects where name = 'cb_ofi_org')
   drop table cb_ofi_org
 
go
print '--> Tabla: tmp_sasiento'
if exists(select 1 from sysobjects where name = 'tmp_sasiento')
   drop table tmp_sasiento
 
go

print '-->Tabla: cb_cuentas_tmp'
if exists(select 1 from sysobjects where name = 'cb_cuentas_tmp')
   drop table cb_cuentas_tmp
 
go
