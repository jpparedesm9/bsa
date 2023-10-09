use cob_remesas
go

/* i_area_1 */
print 'i_area_1'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'i_area_1' and o.name = 'area_tcta')
drop index area_tcta.i_area_1
go

/* cc_mensaje_estcta_Key */
print 'cc_mensaje_estcta_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'cc_mensaje_estcta_Key' and o.name = 'cc_mensaje_estcta')
drop index cc_mensaje_estcta.cc_mensaje_estcta_Key
go

/* cm_cheques_Key1 */
print 'cm_cheques_Key1'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'cm_cheques_Key1' and o.name = 'cm_cheques')
drop index cm_cheques.cm_cheques_Key1
go

/* cm_ingreso_Key1 */
print 'cm_ingreso_Key1'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'cm_ingreso_Key1' and o.name = 'cm_ingreso')
drop index cm_ingreso.cm_ingreso_Key1
go

/* cm_ingreso_Key2 */
print 'cm_ingreso_Key2'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'cm_ingreso_Key2' and o.name = 'cm_ingreso')
drop index cm_ingreso.cm_ingreso_Key2
go

/* corte_tmp_Key */
print 'corte_tmp_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'corte_tmp_Key' and o.name = 'corte_tmp')
drop index corte_tmp.corte_tmp_Key
go

/* cp_tmp_ofi_sobregiros_ind */
print 'cp_tmp_ofi_sobregiros_ind'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'cp_tmp_ofi_sobregiros_ind' and o.name = 'cp_tmp_ofi_sobregiros')
drop index cp_tmp_ofi_sobregiros.cp_tmp_ofi_sobregiros_ind
go

/* cp_tmp_saldos_sobregiros_ind */
print 'cp_tmp_saldos_sobregiros_ind'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'cp_tmp_saldos_sobregiros_ind' and o.name = 'cp_tmp_saldos_sobregiros')
drop index cp_tmp_saldos_sobregiros.cp_tmp_saldos_sobregiros_ind
go

/* ct_saldo_tercero_tmp_con_idx_1 */
print 'ct_saldo_tercero_tmp_con_idx_1'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'ct_saldo_tercero_tmp_con_idx_1' and o.name = 'ct_saldo_tercero_tmp_con')
drop index ct_saldo_tercero_tmp_con.ct_saldo_tercero_tmp_con_idx_1
go

/* ofic_tcta_index */
print 'ofic_tcta_index'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'ofic_tcta_index' and o.name = 'ofic_tcta')
drop index ofic_tcta.ofic_tcta_index
go

/* pa_bonificacion_cargos_key */
print 'pa_bonificacion_cargos_key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'pa_bonificacion_cargos_key' and o.name = 'pa_bonificacion_cargos')
drop index pa_bonificacion_cargos.pa_bonificacion_cargos_key
go

/* pa_gestion_paquete_key */
print 'pa_gestion_paquete_key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'pa_gestion_paquete_key' and o.name = 'pa_gestion_paquete')
drop index pa_gestion_paquete.pa_gestion_paquete_key
go

/* pa_integrantes_paquete_key */
print 'pa_integrantes_paquete_key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'pa_integrantes_paquete_key' and o.name = 'pa_integrantes_paquete')
drop index pa_integrantes_paquete.pa_integrantes_paquete_key
go

/* pa_negocio_paquete_key */
print 'pa_negocio_paquete_key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'pa_negocio_paquete_key' and o.name = 'pa_negocio_paquete')
drop index pa_negocio_paquete.pa_negocio_paquete_key
go

/* pa_param_paquete_key */
print 'pa_param_paquete_key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'pa_param_paquete_key' and o.name = 'pa_param_paquete')
drop index pa_param_paquete.pa_param_paquete_key
go

/* pa_solicitud_paquete_key */
print 'pa_solicitud_paquete_key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'pa_solicitud_paquete_key' and o.name = 'pa_solicitud_paquete')
drop index pa_solicitud_paquete.pa_solicitud_paquete_key
go

/* pd_locales_chq_Key */
print 'pd_locales_chq_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'pd_locales_chq_Key' and o.name = 'pd_locales')
drop index pd_locales.pd_locales_chq_Key
go

/* re_accion_nc_Key */
print 're_accion_nc_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_accion_nc_Key' and o.name = 're_accion_nc')
drop index re_accion_nc.re_accion_nc_Key
go

/* re_accion_nd_Key */
print 're_accion_nd_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_accion_nd_Key' and o.name = 're_accion_nd')
drop index re_accion_nd.re_accion_nd_Key
go

/* re_ahtotal_tranmonet1 */
print 're_ahtotal_tranmonet1'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_ahtotal_tranmonet1' and o.name = 're_ahtotal_tranmonet')
drop index re_ahtotal_tranmonet.re_ahtotal_tranmonet1
go

/* re_aprobacion_camara_Key */
print 're_aprobacion_camara_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_aprobacion_camara_Key' and o.name = 're_aprobacion_camara')
drop index re_aprobacion_camara.re_aprobacion_camara_Key
go

/* re_archivo_alz_Key */
print 're_archivo_alz_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_archivo_alz_Key' and o.name = 're_archivo_alianza')
drop index re_archivo_alianza.re_archivo_alz_Key
go

/* re_autelectronicos_Key */
print 're_autelectronicos_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_autelectronicos_Key' and o.name = 're_autelectronicos')
drop index re_autelectronicos.re_autelectronicos_Key
go

/* re_autoriza_ndnc_Key */
print 're_autoriza_ndnc_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_autoriza_ndnc_Key' and o.name = 're_autoriza_ndnc')
drop index re_autoriza_ndnc.re_autoriza_ndnc_Key
go

/* re_auxiliar_key */
print 're_auxiliar_key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_auxiliar_key' and o.name = 're_auxiliar')
drop index re_auxiliar.re_auxiliar_key
go

/* re_banco_Key */
print 're_banco_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_banco_Key' and o.name = 're_banco')
drop index re_banco.re_banco_Key
go

/* re_banco_cd_Key */
print 're_banco_cd_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_banco_cd_Key' and o.name = 're_bcocedente')
drop index re_bcocedente.re_banco_cd_Key
go

/* idx1 */
print 'idx1'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'idx1' and o.name = 're_boc_diario')
drop index re_boc_diario.idx1
go

/* idx2 */
print 'idx2'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'idx2' and o.name = 're_boc_diario')
drop index re_boc_diario.idx2
go

/* re_cab_cheques_pKey */
print 're_cab_cheques_pKey'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_cab_cheques_pKey' and o.name = 're_cab_cheques')
drop index re_cab_cheques.re_cab_cheques_pKey
go

/* re_cab_dataentry_key */
print 're_cab_dataentry_key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_cab_dataentry_key' and o.name = 're_cab_dataentry')
drop index re_cab_dataentry.re_cab_dataentry_key
go

/* re_cabecera_trf_Key */
print 're_cabecera_trf_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_cabecera_trf_Key' and o.name = 're_cabecera_transfer')
drop index re_cabecera_transfer.re_cabecera_trf_Key
go

/* re_caja_Key */
print 're_caja_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_caja_Key' and o.name = 're_caja')
drop index re_caja.re_caja_Key
go

/* re_caja_his_Key */
print 're_caja_his_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_caja_his_Key' and o.name = 're_caja_his')
drop index re_caja_his.re_caja_his_Key
go

/* pk_re_caja_rol */
print 'pk_re_caja_rol'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'pk_re_caja_rol' and o.name = 're_caja_rol')
drop index re_caja_rol.pk_re_caja_rol
go

/* i_cam_pendiente */
print 'i_cam_pendiente'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'i_cam_pendiente' and o.name = 're_cam_pendiente')
drop index re_cam_pendiente.i_cam_pendiente
go

/* re_cam_pendiente_Key */
print 're_cam_pendiente_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_cam_pendiente_Key' and o.name = 're_cam_pendiente')
drop index re_cam_pendiente.re_cam_pendiente_Key
go

/* re_camara_Key */
print 're_camara_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_camara_Key' and o.name = 're_camara')
drop index re_camara.re_camara_Key
go

/* re_camara_ofi_mon_Key */
print 're_camara_ofi_mon_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_camara_ofi_mon_Key' and o.name = 're_camara')
drop index re_camara.re_camara_ofi_mon_Key
go

/* re_camara_definitiva_Key */
print 're_camara_definitiva_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_camara_definitiva_Key' and o.name = 're_camara_definitiva')
drop index re_camara_definitiva.re_camara_definitiva_Key
go

/* re_campo_impuesto_Key */
print 're_campo_impuesto_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_campo_impuesto_Key' and o.name = 're_campo_impuesto')
drop index re_campo_impuesto.re_campo_impuesto_Key
go

/* re_carta_Key */
print 're_carta_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_carta_Key' and o.name = 're_carta')
drop index re_carta.re_carta_Key
go

/* re_carta_ofi_mone_Key */
print 're_carta_ofi_mone_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_carta_ofi_mone_Key' and o.name = 're_carta')
drop index re_carta.re_carta_ofi_mone_Key
go

/* PK__re_catalogo_ofi__3575474C */
print 'PK__re_catalogo_ofi__3575474C'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'PK__re_catalogo_ofi__3575474C' and o.name = 're_catalogo_ofi')
drop index re_catalogo_ofi.PK__re_catalogo_ofi__3575474C
go

/* re_catalogo_ofi_Key */
print 're_catalogo_ofi_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_catalogo_ofi_Key' and o.name = 're_catalogo_ofi')
drop index re_catalogo_ofi.re_catalogo_ofi_Key
go

/* re_catalogo_premio_Key */
print 're_catalogo_premio_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_catalogo_premio_Key' and o.name = 're_catalogo_premio')
drop index re_catalogo_premio.re_catalogo_premio_Key
go

/* re_cheque_rec_Key */
print 're_cheque_rec_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_cheque_rec_Key' and o.name = 're_cheque_rec')
drop index re_cheque_rec.re_cheque_rec_Key
go

/* re_fecha_efe_Key */
print 're_fecha_efe_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_fecha_efe_Key' and o.name = 're_cheque_rec')
drop index re_cheque_rec.re_fecha_efe_Key
go

/* re_cheque_rem_Key */
print 're_cheque_rem_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_cheque_rem_Key' and o.name = 're_cheque_rem')
drop index re_cheque_rem.re_cheque_rem_Key
go

/* re_cheque_rem_chq_Key */
print 're_cheque_rem_chq_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_cheque_rem_chq_Key' and o.name = 're_cheque_rem')
drop index re_cheque_rem.re_cheque_rem_chq_Key
go

/* re_chq_remesas_Key */
print 're_chq_remesas_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_chq_remesas_Key' and o.name = 're_cheques_remesas')
drop index re_cheques_remesas.re_chq_remesas_Key
go

/* re_cierre_Key */
print 're_cierre_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_cierre_Key' and o.name = 're_cierre')
drop index re_cierre.re_cierre_Key
go

/* re_ciudad_retencion_Key */
print 're_ciudad_retencion_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_ciudad_retencion_Key' and o.name = 're_ciudad_retencion')
drop index re_ciudad_retencion.re_ciudad_retencion_Key
go

/* re_codbar_impuesto_Key */
print 're_codbar_impuesto_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_codbar_impuesto_Key' and o.name = 're_codbar_impuesto')
drop index re_codbar_impuesto.re_codbar_impuesto_Key
go

/* re_codigo_barras_Key */
print 're_codigo_barras_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_codigo_barras_Key' and o.name = 're_codigo_barras')
drop index re_codigo_barras.re_codigo_barras_Key
go

/* re_comisiones_rem_Key */
print 're_comisiones_rem_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_comisiones_rem_Key' and o.name = 're_comisiones_rem')
drop index re_comisiones_rem.re_comisiones_rem_Key
go

/* pk_re_compensa_ofi */
print 'pk_re_compensa_ofi'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'pk_re_compensa_ofi' and o.name = 're_compensa_ofi')
drop index re_compensa_ofi.pk_re_compensa_ofi
go

/* re_concep_exen_gmf_key */
print 're_concep_exen_gmf_key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_concep_exen_gmf_key' and o.name = 're_concep_exen_gmf')
drop index re_concep_exen_gmf.re_concep_exen_gmf_key
go

/* i_concepto */
print 'i_concepto'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'i_concepto' and o.name = 're_concepto_contable')
drop index re_concepto_contable.i_concepto
go

/* re_concepto_imp_key */
print 're_concepto_imp_key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_concepto_imp_key' and o.name = 're_concepto_imp')
drop index re_concepto_imp.re_concepto_imp_key
go

/* re_producto_pit_Key */
print 're_producto_pit_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_producto_pit_Key' and o.name = 're_consignacion_pit')
drop index re_consignacion_pit.re_producto_pit_Key
go

/* pk_re_conversion */
print 'pk_re_conversion'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'pk_re_conversion' and o.name = 're_conversion')
drop index re_conversion.pk_re_conversion
go

/* re_cta_consolidada_Key */
print 're_cta_consolidada_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_cta_consolidada_Key' and o.name = 're_cta_consolidada')
drop index re_cta_consolidada.re_cta_consolidada_Key
go

/* re_cta_efectivizacion_esp_Key */
print 're_cta_efectivizacion_esp_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_cta_efectivizacion_esp_Key' and o.name = 're_cta_efectivizacion_esp')
drop index re_cta_efectivizacion_esp.re_cta_efectivizacion_esp_Key
go

/* re_cuadre_Key */
print 're_cuadre_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_cuadre_Key' and o.name = 're_cuadre_contable')
drop index re_cuadre_contable.re_cuadre_Key
go

/* idx1 */
print 'idx1'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'idx1' and o.name = 're_cuenta_contractual')
drop index re_cuenta_contractual.idx1
go

/* re_det_carta_Key */
print 're_det_carta_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_det_carta_Key' and o.name = 're_det_carta')
drop index re_det_carta.re_det_carta_Key
go

/* re_det_carta_cta_Key */
print 're_det_carta_cta_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_det_carta_cta_Key' and o.name = 're_det_carta')
drop index re_det_carta.re_det_carta_cta_Key
go

/* re_det_cheques_rem_dev_fKey */
print 're_det_cheques_rem_dev_fKey'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_det_cheques_rem_dev_fKey' and o.name = 're_det_cheques')
drop index re_det_cheques.re_det_cheques_rem_dev_fKey
go

/* re_det_dataentry_key */
print 're_det_dataentry_key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_det_dataentry_key' and o.name = 're_det_dataentry')
drop index re_det_dataentry.re_det_dataentry_key
go

/* re_detalle_cbarras_Key */
print 're_detalle_cbarras_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_detalle_cbarras_Key' and o.name = 're_detalle_cbarras')
drop index re_detalle_cbarras.re_detalle_cbarras_Key
go

/* re_detalle_trf_Key */
print 're_detalle_trf_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_detalle_trf_Key' and o.name = 're_detalle_transfer')
drop index re_detalle_transfer.re_detalle_trf_Key
go

/* re_dif_caja_Key */
print 're_dif_caja_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_dif_caja_Key' and o.name = 're_dif_caja')
drop index re_dif_caja.re_dif_caja_Key
go

/* re_enca_transfer_auto_Key */
print 're_enca_transfer_auto_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_enca_transfer_auto_Key' and o.name = 're_enca_transfer_automatica')
drop index re_enca_transfer_automatica.re_enca_transfer_auto_Key
go

/* i_idx2 */
print 'i_idx2'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'i_idx2' and o.name = 're_equivalencias')
drop index re_equivalencias.i_idx2
go

/* re_eventos_key */
print 're_eventos_key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_eventos_key' and o.name = 're_eventos')
drop index re_eventos.re_eventos_key
go

/* re_findia_bv_Key */
print 're_findia_bv_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_findia_bv_Key' and o.name = 're_findia_bv')
drop index re_findia_bv.re_findia_bv_Key
go

/* re_gcontribuyente_Key */
print 're_gcontribuyente_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_gcontribuyente_Key' and o.name = 're_gcontribuyente')
drop index re_gcontribuyente.re_gcontribuyente_Key
go

/* re_gen_monet_bv_Key */
print 're_gen_monet_bv_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_gen_monet_bv_Key' and o.name = 're_gen_monet_bv')
drop index re_gen_monet_bv.re_gen_monet_bv_Key
go

/* re_gmf_alianza_key */
print 're_gmf_alianza_key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_gmf_alianza_key' and o.name = 're_gmf_alianza')
drop index re_gmf_alianza.re_gmf_alianza_key
go

/* re_grupo_Key */
print 're_grupo_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_grupo_Key' and o.name = 're_grupo')
drop index re_grupo.re_grupo_Key
go

/* re_camgrupo_Key */
print 're_camgrupo_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_camgrupo_Key' and o.name = 're_grupo_camara')
drop index re_grupo_camara.re_camgrupo_Key
go

/* re_hisextra */
print 're_hisextra'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_hisextra' and o.name = 're_his_extracto')
drop index re_his_extracto.re_hisextra
go

/* re_impuesto_Key */
print 're_impuesto_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_impuesto_Key' and o.name = 're_impuesto')
drop index re_impuesto.re_impuesto_Key
go

/* re_limite_transaccion_Key */
print 're_limite_transaccion_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_limite_transaccion_Key' and o.name = 're_limite_transaccion')
drop index re_limite_transaccion.re_limite_transaccion_Key
go

/* pk_re_limites */
print 'pk_re_limites'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'pk_re_limites' and o.name = 're_limites')
drop index re_limites.pk_re_limites
go

/* re_liqsegdian */
print 're_liqsegdian'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_liqsegdian' and o.name = 're_liquidacion_intereses')
drop index re_liquidacion_intereses.re_liqsegdian
go

/* re_logtran_atm_Key */
print 're_logtran_atm_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_logtran_atm_Key' and o.name = 're_logtran_atm')
drop index re_logtran_atm.re_logtran_atm_Key
go

/* i_idx_re_mantenimiento_cb */
print 'i_idx_re_mantenimiento_cb'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'i_idx_re_mantenimiento_cb' and o.name = 're_mantenimiento_cb')
drop index re_mantenimiento_cb.i_idx_re_mantenimiento_cb
go

/* re_marcacion_cuentas_Key */
print 're_marcacion_cuentas_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_marcacion_cuentas_Key' and o.name = 're_marcacion_cuentas')
drop index re_marcacion_cuentas.re_marcacion_cuentas_Key
go

/* re_movimientos_caja_Key */
print 're_movimientos_caja_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_movimientos_caja_Key' and o.name = 're_movimientos_caja')
drop index re_movimientos_caja.re_movimientos_caja_Key
go

/* re_ndc_automatica_Key */
print 're_ndc_automatica_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_ndc_automatica_Key' and o.name = 're_ndc_automatica')
drop index re_ndc_automatica.re_ndc_automatica_Key
go

/* re_ndc_automatica_empsec */
print 're_ndc_automatica_empsec'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_ndc_automatica_empsec' and o.name = 're_ndc_automatica')
drop index re_ndc_automatica.re_ndc_automatica_empsec
go

/* re_nombre_bcogirado_Key */
print 're_nombre_bcogirado_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_nombre_bcogirado_Key' and o.name = 're_nombre_bcogirado')
drop index re_nombre_bcogirado.re_nombre_bcogirado_Key
go

/* re_numcta_extracto_key */
print 're_numcta_extracto_key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_numcta_extracto_key' and o.name = 're_numcta_extracto')
drop index re_numcta_extracto.re_numcta_extracto_key
go

/* i_ob_ofi_cobis */
print 'i_ob_ofi_cobis'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'i_ob_ofi_cobis' and o.name = 're_ofi_banco')
drop index re_ofi_banco.i_ob_ofi_cobis
go

/* re_ofi_banco_Key */
print 're_ofi_banco_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_ofi_banco_Key' and o.name = 're_ofi_banco')
drop index re_ofi_banco.re_ofi_banco_Key
go

/* re_ofi_safe_Key */
print 're_ofi_safe_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_ofi_safe_Key' and o.name = 're_ofi_safe')
drop index re_ofi_safe.re_ofi_safe_Key
go

/* re_tipocanje_Key */
print 're_tipocanje_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_tipocanje_Key' and o.name = 're_oficina_canje')
drop index re_oficina_canje.re_tipocanje_Key
go

/* icliente_pk */
print 'icliente_pk'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'icliente_pk' and o.name = 're_orden_caja')
drop index re_orden_caja.icliente_pk
go

/* idorden_pk */
print 'idorden_pk'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'idorden_pk' and o.name = 're_orden_caja')
drop index re_orden_caja.idorden_pk
go

/* re_paquete_key */
print 're_paquete_key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_paquete_key' and o.name = 're_paquete')
drop index re_paquete.re_paquete_key
go

/* re_param_ex_Key */
print 're_param_ex_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_param_ex_Key' and o.name = 're_param_ex')
drop index re_param_ex.re_param_ex_Key
go

/* re_paraextr1 */
print 're_paraextr1'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_paraextr1' and o.name = 're_parametro_extracto')
drop index re_parametro_extracto.re_paraextr1
go

/* re_peticiones_efectivo_Key */
print 're_peticiones_efectivo_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_peticiones_efectivo_Key' and o.name = 're_peticiones_efectivo')
drop index re_peticiones_efectivo.re_peticiones_efectivo_Key
go

/* re_procesar_pagos_bv_Key */
print 're_procesar_pagos_bv_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_procesar_pagos_bv_Key' and o.name = 're_procesar_pagos_bv')
drop index re_procesar_pagos_bv.re_procesar_pagos_bv_Key
go

/* re_producto_cliente_key2 */
print 're_producto_cliente_key2'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_producto_cliente_key2' and o.name = 're_producto_cliente')
drop index re_producto_cliente.re_producto_cliente_key2
go

/* re_propiedad_ndc_Key */
print 're_propiedad_ndc_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_propiedad_ndc_Key' and o.name = 're_propiedad_ndc')
drop index re_propiedad_ndc.re_propiedad_ndc_Key
go

/* i_idx_re_punto_red_cb */
print 'i_idx_re_punto_red_cb'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'i_idx_re_punto_red_cb' and o.name = 're_punto_red_cb')
drop index re_punto_red_cb.i_idx_re_punto_red_cb
go

/* re_rechazos_mon */
print 're_rechazos_mon'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_rechazos_mon' and o.name = 're_rechazo_tran')
drop index re_rechazo_tran.re_rechazos_mon
go

/* re_reintegro_key */
print 're_reintegro_key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_reintegro_key' and o.name = 're_reintegro_dtn')
drop index re_reintegro_dtn.re_reintegro_key
go

/* i_rc_cuenta_tel_celular */
print 'i_rc_cuenta_tel_celular'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'i_rc_cuenta_tel_celular' and o.name = 're_relacion_cta_canal')
drop index re_relacion_cta_canal.i_rc_cuenta_tel_celular
go

/* re_rembolso_bc_fKey */
print 're_rembolso_bc_fKey'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_rembolso_bc_fKey' and o.name = 're_rembolso_bcocedente')
drop index re_rembolso_bcocedente.re_rembolso_bc_fKey
go

/* re_rembolso_bc_fKey */
print 're_rembolso_bc_fKey'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_rembolso_bc_fKey' and o.name = 're_rembolso_corresponsal')
drop index re_rembolso_corresponsal.re_rembolso_bc_fKey
go

/* i_re_remesa_mensual */
print 'i_re_remesa_mensual'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'i_re_remesa_mensual' and o.name = 're_remesa_mensual')
drop index re_remesa_mensual.i_re_remesa_mensual
go

/* re_retencion_Key */
print 're_retencion_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_retencion_Key' and o.name = 're_retencion')
drop index re_retencion.re_retencion_Key
go

/* re_saldo_bc_Key */
print 're_saldo_bc_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_saldo_bc_Key' and o.name = 're_saldo_bcocedente')
drop index re_saldo_bcocedente.re_saldo_bc_Key
go

/* re_saldo_contable_Key */
print 're_saldo_contable_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_saldo_contable_Key' and o.name = 're_saldo_contable')
drop index re_saldo_contable.re_saldo_contable_Key
go

/* re_saldo_bc_Key */
print 're_saldo_bc_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_saldo_bc_Key' and o.name = 're_saldo_corresponsales')
drop index re_saldo_corresponsales.re_saldo_bc_Key
go

/* re_saldo_cuenta_Key */
print 're_saldo_cuenta_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_saldo_cuenta_Key' and o.name = 're_saldo_cuenta')
drop index re_saldo_cuenta.re_saldo_cuenta_Key
go

/* re_saldos_caja_Key */
print 're_saldos_caja_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_saldos_caja_Key' and o.name = 're_saldos_caja')
drop index re_saldos_caja.re_saldos_caja_Key
go

/* re_supervisor_Key */
print 're_supervisor_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_supervisor_Key' and o.name = 're_supervisor')
drop index re_supervisor.re_supervisor_Key
go

/* re_tesoro_nacional_Key */
print 're_tesoro_nacional_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_tesoro_nacional_Key' and o.name = 're_tesoro_nacional')
drop index re_tesoro_nacional.re_tesoro_nacional_Key
go

/* re_total_Key */
print 're_total_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_total_Key' and o.name = 're_total')
drop index re_total.re_total_Key
go

/* i_re_total_bv */
print 'i_re_total_bv'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'i_re_total_bv' and o.name = 're_total_bv')
drop index re_total_bv.i_re_total_bv
go

/* re_total_bv_Key */
print 're_total_bv_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_total_bv_Key' and o.name = 're_total_bv')
drop index re_total_bv.re_total_bv_Key
go

/* re_total_rem_Key */
print 're_total_rem_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_total_rem_Key' and o.name = 're_total_rem')
drop index re_total_rem.re_total_rem_Key
go

/* re_totales_remesas_ofi_Key */
print 're_totales_remesas_ofi_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_totales_remesas_ofi_Key' and o.name = 're_totales_remesas')
drop index re_totales_remesas.re_totales_remesas_ofi_Key
go

/* pk_re_tran_contable */
print 'pk_re_tran_contable'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'pk_re_tran_contable' and o.name = 're_tran_contable')
drop index re_tran_contable.pk_re_tran_contable
go

/* re_tran_contable_Key */
print 're_tran_contable_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_tran_contable_Key' and o.name = 're_tran_contable')
drop index re_tran_contable.re_tran_contable_Key
go

/* re_tran_equiv_bv_Key */
print 're_tran_equiv_bv_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_tran_equiv_bv_Key' and o.name = 're_tran_equiv_bv')
drop index re_tran_equiv_bv.re_tran_equiv_bv_Key
go

/* re_tran_interfase_Key */
print 're_tran_interfase_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_tran_interfase_Key' and o.name = 're_tran_interfase')
drop index re_tran_interfase.re_tran_interfase_Key
go

/* IX_re_tran_monet_atm */
print 'IX_re_tran_monet_atm'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'IX_re_tran_monet_atm' and o.name = 're_tran_monet_atm')
drop index re_tran_monet_atm.IX_re_tran_monet_atm
go

/* re_tran_monet_bv_Key */
print 're_tran_monet_bv_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_tran_monet_bv_Key' and o.name = 're_tran_monet_bv')
drop index re_tran_monet_bv.re_tran_monet_bv_Key
go

/* re_tran_monet_bv_Key1 */
print 're_tran_monet_bv_Key1'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_tran_monet_bv_Key1' and o.name = 're_tran_monet_bv')
drop index re_tran_monet_bv.re_tran_monet_bv_Key1
go

/* IX_re_tran_monet_tmp_atm */
print 'IX_re_tran_monet_tmp_atm'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'IX_re_tran_monet_tmp_atm' and o.name = 're_tran_monet_tmp_atm')
drop index re_tran_monet_tmp_atm.IX_re_tran_monet_tmp_atm
go

/* re_trans_alerta_key */
print 're_trans_alerta_key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_trans_alerta_key' and o.name = 're_trans_alerta')
drop index re_trans_alerta.re_trans_alerta_key
go

/* re_transfer_automatica_Key */
print 're_transfer_automatica_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_transfer_automatica_Key' and o.name = 're_transfer_automatica')
drop index re_transfer_automatica.re_transfer_automatica_Key
go

/* re_transito_Key */
print 're_transito_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_transito_Key' and o.name = 're_transito')
drop index re_transito.re_transito_Key
go

/* i_re_traslado */
print 'i_re_traslado'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'i_re_traslado' and o.name = 're_traslado')
drop index re_traslado.i_re_traslado
go

/* re_traslado_Key */
print 're_traslado_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_traslado_Key' and o.name = 're_traslado')
drop index re_traslado.re_traslado_Key
go

/* re_trn_causa_atm_Key */
print 're_trn_causa_atm_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_trn_causa_atm_Key' and o.name = 're_trn_causa_atm')
drop index re_trn_causa_atm.re_trn_causa_atm_Key
go

/* re_trn_causa_bvirtual_Key */
print 're_trn_causa_bvirtual_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_trn_causa_bvirtual_Key' and o.name = 're_trn_causa_bvirtual')
drop index re_trn_causa_bvirtual.re_trn_causa_bvirtual_Key
go

/* idx3 */
print 'idx3'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'idx3' and o.name = 're_trn_contable')
drop index re_trn_contable.idx3
go

/* re_trn_grupo_Key */
print 're_trn_grupo_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 're_trn_grupo_Key' and o.name = 're_trn_grupo')
drop index re_trn_grupo.re_trn_grupo_Key
go

/* idx_sec */
print 'idx_sec'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'idx_sec' and o.name = 're_trn_perfil')
drop index re_trn_perfil.idx_sec
go

/* idx_prod */
print 'idx_prod'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'idx_prod' and o.name = 're_valida_datos_offline')
drop index re_valida_datos_offline.idx_prod
go

/* pk_re_validacion_monto */
print 'pk_re_validacion_monto'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'pk_re_validacion_monto' and o.name = 're_validacion_monto')
drop index re_validacion_monto.pk_re_validacion_monto
go

/* i_salter */
print 'i_salter'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'i_salter' and o.name = 'salter_def')
drop index salter_def.i_salter
go

/* tmp_cb_hist_saldo */
print 'tmp_cb_hist_saldo'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'tmp_cb_hist_saldo' and o.name = 'tmp_cb_hist_saldo')
drop index tmp_cb_hist_saldo.tmp_cb_hist_saldo
go

/* tmp_cb_hist_saldo2 */
print 'tmp_cb_hist_saldo2'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'tmp_cb_hist_saldo2' and o.name = 'tmp_cb_hist_saldo2')
drop index tmp_cb_hist_saldo2.tmp_cb_hist_saldo2
go

/* tmp_cb_saldo_promm */
print 'tmp_cb_saldo_promm'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'tmp_cb_saldo_promm' and o.name = 'tmp_cb_saldo_promm')
drop index tmp_cb_saldo_promm.tmp_cb_saldo_promm
go

/* i_tmp_saldo_tr2 */
print 'i_tmp_saldo_tr2'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'i_tmp_saldo_tr2' and o.name = 'tmp_saldo_traslado')
drop index tmp_saldo_traslado.i_tmp_saldo_tr2
go

/* tmp_sasiento_Key */
print 'tmp_sasiento_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'tmp_sasiento_Key' and o.name = 'tmp_sasiento')
drop index tmp_sasiento.tmp_sasiento_Key
go

/* tmp_siento_comp_Key */
print 'tmp_siento_comp_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'tmp_siento_comp_Key' and o.name = 'tmp_siento_comp')
drop index tmp_siento_comp.tmp_siento_comp_Key
go

/* ts_tran_serv_pag_decl_i1 */
print 'ts_tran_serv_pag_decl_i1'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'ts_tran_serv_pag_decl_i1' and o.name = 'ts_tran_serv_pag_decl')
drop index ts_tran_serv_pag_decl.ts_tran_serv_pag_decl_i1
go

/* i_bco_cta_chq */
print 'i_bco_cta_chq'
if exists (select 1 from sysindexes where name = 'i_bco_cta_chq')
   drop index re_detalle_cheque.i_bco_cta_chq
go

/* i_ofi_fech_pro_bco_cta */
print 'i_ofi_fech_pro_bco_cta'
if exists (select 1 from sysindexes where name = 'i_ofi_fech_pro_bco_cta')
   drop index re_detalle_cheque.i_ofi_fech_pro_bco_cta
go

/* re_cheque_ofi_mone_Key */
print 're_cheque_ofi_mone_Key'
if exists (select * from sysindexes where name = 're_cheque_ofi_mone_Key')
   drop index re_cheque_rec.re_cheque_ofi_mone_Key
go