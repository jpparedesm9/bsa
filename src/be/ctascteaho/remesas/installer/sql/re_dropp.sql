use cob_remesas
go

/* cc_mensaje_estcta_Key */
print 'cc_mensaje_estcta_Key'
if exists (select * from sysindexes
	where name = 'cc_mensaje_estcta_Key')
drop index cc_mensaje_estcta.cc_mensaje_estcta_Key
go

/* cm_cheques_Key1 */
print 'cm_cheques_Key1'
if exists (select * from sysindexes
	where name = 'cm_cheques_Key1')
drop index cm_cheques.cm_cheques_Key1
go

/* cm_ingreso_Key1 */
print 'cm_ingreso_Key1'
if exists (select * from sysindexes
	where name = 'cm_ingreso_Key1')
drop index cm_ingreso.cm_ingreso_Key1
go



/* re_accion_nc_Key */
print 're_accion_nc_Key'
if exists (select * from sysindexes
	where name = 're_accion_nc_Key')
drop index re_accion_nc.re_accion_nc_Key
go

/* re_accion_nd_Key */
print 're_accion_nd_Key'
if exists (select * from sysindexes
	where name = 're_accion_nd_Key')
drop index re_accion_nd.re_accion_nd_Key
go

/* re_aprobacion_camara_Key */
print 're_aprobacion_camara_Key'
if exists (select * from sysindexes
	where name = 're_aprobacion_camara_Key')
drop index re_aprobacion_camara.re_aprobacion_camara_Key
go

/* re_autelectronicos_Key */
print 're_autelectronicos_Key'
if exists (select * from sysindexes
	where name = 're_autelectronicos_Key')
drop index re_autelectronicos.re_autelectronicos_Key
go

/* re_autoriza_ndnc_Key */
print 're_autoriza_ndnc_Key'
if exists (select * from sysindexes
	where name = 're_autoriza_ndnc_Key')
drop index re_autoriza_ndnc.re_autoriza_ndnc_Key
go

/* re_banco_Key */
print 're_banco_Key'
if exists (select * from sysindexes
	where name = 're_banco_Key')
drop index re_banco.re_banco_Key
go

/* re_caja_Key */
print 're_caja_Key'
if exists (select * from sysindexes
	where name = 're_caja_Key')
drop index re_caja.re_caja_Key
go

/* re_caja_his_Key */
print 're_caja_his_Key'
if exists (select * from sysindexes
	where name = 're_caja_his_Key')
drop index re_caja_his.re_caja_his_Key
go

/* pk_re_caja_rol */
print 'pk_re_caja_rol'
if exists (select * from sysindexes
	where name = 'pk_re_caja_rol')
drop index re_caja_rol.pk_re_caja_rol
go

/* re_cam_pendiente_Key */
print 're_cam_pendiente_Key'
if exists (select * from sysindexes
	where name = 're_cam_pendiente_Key')
drop index re_cam_pendiente.re_cam_pendiente_Key
go

/* re_camara_Key */
print 're_camara_Key'
if exists (select * from sysindexes
	where name = 're_camara_Key')
drop index re_camara.re_camara_Key
go

/* re_campo_impuesto_Key */
print 're_campo_impuesto_Key'
if exists (select * from sysindexes
	where name = 're_campo_impuesto_Key')
drop index re_campo_impuesto.re_campo_impuesto_Key
go

/* re_carta_Key */
print 're_carta_Key'
if exists (select * from sysindexes
	where name = 're_carta_Key')
drop index re_carta.re_carta_Key
go

/* PK__re_catalogo_ofi__3575474C */
print 'PK__re_catalogo_ofi__3575474C'
if exists (select * from sysindexes
	where name = 'PK__re_catalogo_ofi__3575474C')
drop index re_catalogo_ofi.PK__re_catalogo_ofi__3575474C
go

/* re_catalogo_premio_Key */
print 're_catalogo_premio_Key'
if exists (select * from sysindexes
	where name = 're_catalogo_premio_Key')
drop index re_catalogo_premio.re_catalogo_premio_Key
go

/* re_cheque_rec_Key */
print 're_cheque_rec_Key'
if exists (select * from sysindexes
	where name = 're_cheque_rec_Key')
drop index re_cheque_rec.re_cheque_rec_Key
go

/* re_cheque_rem_Key */
print 're_cheque_rem_Key'
if exists (select * from sysindexes
	where name = 're_cheque_rem_Key')
drop index re_cheque_rem.re_cheque_rem_Key
go

/* re_chq_remesas_Key */
print 're_chq_remesas_Key'
if exists (select * from sysindexes
	where name = 're_chq_remesas_Key')
drop index re_cheques_remesas.re_chq_remesas_Key
go

/* re_cierre_Key */
print 're_cierre_Key'
if exists (select * from sysindexes
	where name = 're_cierre_Key')
drop index re_cierre.re_cierre_Key
go

/* re_ciudad_retencion_Key */
print 're_ciudad_retencion_Key'
if exists (select * from sysindexes
	where name = 're_ciudad_retencion_Key')
drop index re_ciudad_retencion.re_ciudad_retencion_Key
go

/* re_codbar_impuesto_Key */
print 're_codbar_impuesto_Key'
if exists (select * from sysindexes
	where name = 're_codbar_impuesto_Key')
drop index re_codbar_impuesto.re_codbar_impuesto_Key
go

/* re_codigo_barras_Key */
print 're_codigo_barras_Key'
if exists (select * from sysindexes
	where name = 're_codigo_barras_Key')
drop index re_codigo_barras.re_codigo_barras_Key
go

/* pk_re_compensa_ofi */
print 'pk_re_compensa_ofi'
if exists (select * from sysindexes
	where name = 'pk_re_compensa_ofi')
drop index re_compensa_ofi.pk_re_compensa_ofi
go

/* pk_re_conversion */
print 'pk_re_conversion'
if exists (select * from sysindexes
	where name = 'pk_re_conversion')
drop index re_conversion.pk_re_conversion
go

/* re_cta_consolidada_Key */
print 're_cta_consolidada_Key'
if exists (select * from sysindexes
	where name = 're_cta_consolidada_Key')
drop index re_cta_consolidada.re_cta_consolidada_Key
go

/* re_cta_efectivizacion_esp_Key */
print 're_cta_efectivizacion_esp_Key'
if exists (select * from sysindexes
	where name = 're_cta_efectivizacion_esp_Key')
drop index re_cta_efectivizacion_esp.re_cta_efectivizacion_esp_Key
go

/* re_det_carta_Key */
print 're_det_carta_Key'
if exists (select * from sysindexes
	where name = 're_det_carta_Key')
drop index re_det_carta.re_det_carta_Key
go

/* re_det_dataentry_key */
print 're_det_dataentry_key'
if exists (select * from sysindexes
	where name = 're_det_dataentry_key')
drop index re_det_dataentry.re_det_dataentry_key
go

/* re_detalle_cbarras_Key */
print 're_detalle_cbarras_Key'
if exists (select * from sysindexes
	where name = 're_detalle_cbarras_Key')
drop index re_detalle_cbarras.re_detalle_cbarras_Key
go

/* re_dif_caja_Key */
print 're_dif_caja_Key'
if exists (select * from sysindexes
	where name = 're_dif_caja_Key')
drop index re_dif_caja.re_dif_caja_Key
go

/* re_enca_transfer_auto_Key */
print 're_enca_transfer_auto_Key'
if exists (select * from sysindexes
	where name = 're_enca_transfer_auto_Key')
drop index re_enca_transfer_automatica.re_enca_transfer_auto_Key
go

/* re_findia_bv_Key */
print 're_findia_bv_Key'
if exists (select * from sysindexes
	where name = 're_findia_bv_Key')
drop index re_findia_bv.re_findia_bv_Key
go

/* re_gcontribuyente_Key */
print 're_gcontribuyente_Key'
if exists (select * from sysindexes
	where name = 're_gcontribuyente_Key')
drop index re_gcontribuyente.re_gcontribuyente_Key
go

/* re_grupo_Key */
print 're_grupo_Key'
if exists (select * from sysindexes
	where name = 're_grupo_Key')
drop index re_grupo.re_grupo_Key
go

/* re_impuesto_Key */
print 're_impuesto_Key'
if exists (select * from sysindexes
	where name = 're_impuesto_Key')
drop index re_impuesto.re_impuesto_Key
go

/* re_limite_transaccion_Key */
print 're_limite_transaccion_Key'
if exists (select * from sysindexes
	where name = 're_limite_transaccion_Key')
drop index re_limite_transaccion.re_limite_transaccion_Key
go

/* pk_re_limites */
print 'pk_re_limites'
if exists (select * from sysindexes
	where name = 'pk_re_limites')
drop index re_limites.pk_re_limites
go

/* re_marcacion_cuentas_Key */
print 're_marcacion_cuentas_Key'
if exists (select * from sysindexes
	where name = 're_marcacion_cuentas_Key')
drop index re_marcacion_cuentas.re_marcacion_cuentas_Key
go

/* re_movimientos_caja_Key */
print 're_movimientos_caja_Key'
if exists (select * from sysindexes
	where name = 're_movimientos_caja_Key')
drop index re_movimientos_caja.re_movimientos_caja_Key
go

/* re_ndc_automatica_Key */
print 're_ndc_automatica_Key'
if exists (select * from sysindexes
	where name = 're_ndc_automatica_Key')
drop index re_ndc_automatica.re_ndc_automatica_Key
go

/* re_nombre_bcogirado_Key */
print 're_nombre_bcogirado_Key'
if exists (select * from sysindexes
	where name = 're_nombre_bcogirado_Key')
drop index re_nombre_bcogirado.re_nombre_bcogirado_Key
go

/* re_ofi_banco_Key */
print 're_ofi_banco_Key'
if exists (select * from sysindexes
	where name = 're_ofi_banco_Key')
drop index re_ofi_banco.re_ofi_banco_Key
go

/* re_ofi_safe_Key */
print 're_ofi_safe_Key'
if exists (select * from sysindexes
	where name = 're_ofi_safe_Key')
drop index re_ofi_safe.re_ofi_safe_Key
go

/* re_tipocanje_Key */
print 're_tipocanje_Key'
if exists (select * from sysindexes
	where name = 're_tipocanje_Key')
drop index re_oficina_canje.re_tipocanje_Key
go

/* icliente_pk */
print 'icliente_pk'
if exists (select * from sysindexes
	where name = 'icliente_pk')
drop index re_orden_caja.icliente_pk
go

/* re_param_ex_Key */
print 're_param_ex_Key'
if exists (select * from sysindexes
	where name = 're_param_ex_Key')
drop index re_param_ex.re_param_ex_Key
go

/* re_peticiones_efectivo_Key */
print 're_peticiones_efectivo_Key'
if exists (select * from sysindexes
	where name = 're_peticiones_efectivo_Key')
drop index re_peticiones_efectivo.re_peticiones_efectivo_Key
go

/* re_propiedad_ndc_Key */
print 're_propiedad_ndc_Key'
if exists (select * from sysindexes
	where name = 're_propiedad_ndc_Key')
drop index re_propiedad_ndc.re_propiedad_ndc_Key
go

/* re_retencion_Key */
print 're_retencion_Key'
if exists (select * from sysindexes
	where name = 're_retencion_Key')
drop index re_retencion.re_retencion_Key
go

/* re_saldo_cuenta_Key */
print 're_saldo_cuenta_Key'
if exists (select * from sysindexes
	where name = 're_saldo_cuenta_Key')
drop index re_saldo_cuenta.re_saldo_cuenta_Key
go

/* re_saldos_caja_Key */
print 're_saldos_caja_Key'
if exists (select * from sysindexes
	where name = 're_saldos_caja_Key')
drop index re_saldos_caja.re_saldos_caja_Key
go

/* re_supervisor_Key */
print 're_supervisor_Key'
if exists (select * from sysindexes
	where name = 're_supervisor_Key')
drop index re_supervisor.re_supervisor_Key
go

/* re_tesoro_nacional_Key */
print 're_tesoro_nacional_Key'
if exists (select * from sysindexes
	where name = 're_tesoro_nacional_Key')
drop index re_tesoro_nacional.re_tesoro_nacional_Key
go

/* re_total_bv_Key */
print 're_total_bv_Key'
if exists (select * from sysindexes
	where name = 're_total_bv_Key')
drop index re_total_bv.re_total_bv_Key
go

/* pk_re_tran_contable */
print 'pk_re_tran_contable'
if exists (select * from sysindexes
	where name = 'pk_re_tran_contable')
drop index re_tran_contable.pk_re_tran_contable
go

/* re_tran_equiv_bv_Key */
print 're_tran_equiv_bv_Key'
if exists (select * from sysindexes
	where name = 're_tran_equiv_bv_Key')
drop index re_tran_equiv_bv.re_tran_equiv_bv_Key
go

/* re_tran_interfase_Key */
print 're_tran_interfase_Key'
if exists (select * from sysindexes
	where name = 're_tran_interfase_Key')
drop index re_tran_interfase.re_tran_interfase_Key
go

/* IX_re_tran_monet_atm */
print 'IX_re_tran_monet_atm'
if exists (select * from sysindexes
	where name = 'IX_re_tran_monet_atm')
drop index re_tran_monet_atm.IX_re_tran_monet_atm
go

/* re_tran_monet_bv_Key */
print 're_tran_monet_bv_Key'
if exists (select * from sysindexes
	where name = 're_tran_monet_bv_Key')
drop index re_tran_monet_bv.re_tran_monet_bv_Key
go

/* IX_re_tran_monet_tmp_atm */
print 'IX_re_tran_monet_tmp_atm'
if exists (select * from sysindexes
	where name = 'IX_re_tran_monet_tmp_atm')
drop index re_tran_monet_tmp_atm.IX_re_tran_monet_tmp_atm
go

/* re_trans_alerta_key */
print 're_trans_alerta_key'
if exists (select * from sysindexes
	where name = 're_trans_alerta_key')
drop index re_trans_alerta.re_trans_alerta_key
go

/* re_transfer_automatica_Key */
print 're_transfer_automatica_Key'
if exists (select * from sysindexes
	where name = 're_transfer_automatica_Key')
drop index re_transfer_automatica.re_transfer_automatica_Key
go

/* re_transito_Key */
print 're_transito_Key'
if exists (select * from sysindexes
	where name = 're_transito_Key')
drop index re_transito.re_transito_Key
go

/* re_traslado_Key */
print 're_traslado_Key'
if exists (select * from sysindexes
	where name = 're_traslado_Key')
drop index re_traslado.re_traslado_Key
go

/* re_trn_causa_atm_Key */
print 're_trn_causa_atm_Key'
if exists (select * from sysindexes
	where name = 're_trn_causa_atm_Key')
drop index re_trn_causa_atm.re_trn_causa_atm_Key
go

/* re_trn_causa_bvirtual_Key */
print 're_trn_causa_bvirtual_Key'
if exists (select * from sysindexes
	where name = 're_trn_causa_bvirtual_Key')
drop index re_trn_causa_bvirtual.re_trn_causa_bvirtual_Key
go

/* re_trn_grupo_Key */
print 're_trn_grupo_Key'
if exists (select * from sysindexes
	where name = 're_trn_grupo_Key')
drop index re_trn_grupo.re_trn_grupo_Key
go

/* pk_re_validacion_monto */
print 'pk_re_validacion_monto'
if exists (select * from sysindexes
	where name = 'pk_re_validacion_monto')
drop index re_validacion_monto.pk_re_validacion_monto
go

/* re_cheque_rec_Key */
print 're_cheque_rec_Key'
if exists (select * from sysindexes 
	where name = 're_cheque_rec_Key')
drop index re_cheque_rec.re_cheque_rec_Key
go