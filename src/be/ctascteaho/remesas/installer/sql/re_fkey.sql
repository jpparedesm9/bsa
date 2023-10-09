use cob_remesas
go
print 'i_area_1 on area_tcta'
CREATE INDEX i_area_1 on area_tcta(
				sesion_ar)
go

print 'cb_balof_tmp_Key on cb_balof_tmp'
CREATE UNIQUE INDEX cb_balof_tmp_Key on cb_balof_tmp(
				bp_area,
				bp_cuenta,
				bp_oficina)
go

print 'i_mov_cb_mov_ant on cb_mov_ant'
CREATE INDEX i_mov_cb_mov_ant on cb_mov_ant(
				mv_cuenta,
				mv_oficina)
go

print 'cm_ingreso_Key2 on cm_ingreso'
CREATE INDEX cm_ingreso_Key2 on cm_ingreso(
				in_fecha)
go

print 'corte_tmp_Key on corte_tmp'
CREATE INDEX corte_tmp_Key on corte_tmp(
				tmp_fecha_fin)
go

print 'cp_tmp_ofi_sobregiros_ind on cp_tmp_ofi_sobregiros'
CREATE INDEX cp_tmp_ofi_sobregiros_ind on cp_tmp_ofi_sobregiros(
				os_oficina)
go

print 'cp_tmp_saldos_sobregiros_ind on cp_tmp_saldos_sobregiros'
CREATE INDEX cp_tmp_saldos_sobregiros_ind on cp_tmp_saldos_sobregiros(
				ss_oficina)
go

print 'ct_saldo_tercero_tmp_con_idx_1 on ct_saldo_tercero_tmp_con'
CREATE INDEX ct_saldo_tercero_tmp_con_idx_1 on ct_saldo_tercero_tmp_con(
				st_area,
				st_ente,
				st_ofi_conex,
				st_oficina,
				st_term_conex)
go

print 'ofic_tcta_index on ofic_tcta'
CREATE INDEX ofic_tcta_index on ofic_tcta(
				je_oficina)
go

print 'pa_bonificacion_cargos_key on pa_bonificacion_cargos'
CREATE INDEX pa_bonificacion_cargos_key on pa_bonificacion_cargos(
				bc_numpq,
				bc_rubro,
				bc_servicio)
go

print 'pa_gestion_paquete_key on pa_gestion_paquete'
CREATE UNIQUE INDEX pa_gestion_paquete_key on pa_gestion_paquete(
				gp_numpq)
go

print 'pa_integrantes_paquete_key on pa_integrantes_paquete'
CREATE UNIQUE INDEX pa_integrantes_paquete_key on pa_integrantes_paquete(
				ip_cliente,
				ip_numsol)
go

print 'pa_negocio_paquete_key on pa_negocio_paquete'
CREATE UNIQUE INDEX pa_negocio_paquete_key on pa_negocio_paquete(
				np_negocio,
				np_numpq,
				np_prod_banc_pr,
				np_prod_cobis_pr)
go

print 'pa_param_paquete_key on pa_param_paquete'
CREATE UNIQUE INDEX pa_param_paquete_key on pa_param_paquete(
				pa_prod_banc,
				pa_prod_cobis)
go

print 'pa_solicitud_paquete_key on pa_solicitud_paquete'
CREATE UNIQUE INDEX pa_solicitud_paquete_key on pa_solicitud_paquete(
				sp_numsol)
go

print 'pd_locales_chq_Key on pd_locales'
CREATE INDEX pd_locales_chq_Key on pd_locales(
				lc_codbanco,
				lc_cta_girada,
				lc_num_cheque)
go



print 're_ahtotal_tranmonet1 on re_ahtotal_tranmonet'
CREATE INDEX re_ahtotal_tranmonet1 on re_ahtotal_tranmonet(
				tm_oficina_cta)
go

print 're_archivo_alz_Key on re_archivo_alianza'
CREATE INDEX re_archivo_alz_Key on re_archivo_alianza(
				ar_fecha,
				ar_identificacion,
				ar_secuencial,
				ar_tipo_ident)
go

print 're_auxiliar_key on re_auxiliar'
CREATE INDEX re_auxiliar_key on re_auxiliar(
				au_secuencial)
go

print 're_banco_cd_Key on re_bcocedente'
CREATE UNIQUE INDEX re_banco_cd_Key on re_bcocedente(
				bc_banco)
go

print 'idx1 on re_boc_diario'
CREATE INDEX idx1 ON re_boc_diario(
	bd_fecha
)
go

print 'idx2 on re_boc_diario'
CREATE INDEX idx2 on re_boc_diario(
				bd_cliente,
				bd_cuenta,
				bd_oficina--,
				--tc_comprobante,
				--tc_fecha
)
go

print 're_cab_cheques_pKey on re_cab_cheques'
CREATE UNIQUE INDEX re_cab_cheques_pKey on re_cab_cheques(
				cc_sec)
go

print 're_cab_dataentry_key on re_cab_dataentry'
CREATE INDEX re_cab_dataentry_key on re_cab_dataentry(
				ce_comprobante,
				ce_fecha)
go

print 're_cabecera_trf_Key on re_cabecera_transfer'
CREATE INDEX re_cabecera_trf_Key on re_cabecera_transfer(
				ct_cliente,
				ct_estado,
				ct_fecha)
go

print 'i_cam_pendiente on re_cam_pendiente'
CREATE INDEX i_cam_pendiente on re_cam_pendiente(
				cp_fecha,
				cp_oficial)
go

print 're_camara_ofi_mon_Key on re_camara'
CREATE INDEX re_camara_ofi_mon_Key on re_camara(
				ca_banco,
				ca_cuenta,
				ca_moneda,
				ca_oficina)
go

print 're_camara_definitiva_Key on re_camara_definitiva'
CREATE INDEX re_camara_definitiva_Key on re_camara_definitiva(
				cd_estado,
				cd_sucursal,
				cd_tipo)
go

print 're_carta_ofi_mone_Key on re_carta'
CREATE INDEX re_carta_ofi_mone_Key on re_carta(
				ct_banco_c,
				ct_moneda,
				ct_oficina)
go

print 're_catalogo_ofi_Key on re_catalogo_ofi'
CREATE INDEX re_catalogo_ofi_Key on re_catalogo_ofi(
				co_codigo,
				co_oficina,
				co_tabla)
go

print 're_fecha_efe_Key on re_cheque_rec'
CREATE INDEX re_fecha_efe_Key on re_cheque_rec(
				cr_fecha_efe)
go

print 're_cheque_rem_chq_Key on re_cheque_rem'
CREATE INDEX re_cheque_rem_chq_Key on re_cheque_rem(
				cr_codbanco,
				cr_cta_girada,
				cr_num_cheque)
go

print 're_comisiones_rem_Key on re_comisiones_rem'
CREATE UNIQUE INDEX re_comisiones_rem_Key on re_comisiones_rem(
				tr_fecha,
				tr_oficina,
				tr_tipo_cliente)
go

print 're_concep_exen_gmf_key on re_concep_exen_gmf'
CREATE UNIQUE INDEX re_concep_exen_gmf_key on re_concep_exen_gmf(
				ce_concepto)
go

print 'i_concepto on re_concepto_contable'
CREATE INDEX i_concepto on re_concepto_contable(
				cc_campo1,
				cc_producto,
				cc_tipo_tran)
go

print 're_concepto_imp_key on re_concepto_imp'
CREATE UNIQUE INDEX re_concepto_imp_key on re_concepto_imp(
				ci_causal,
				ci_contabiliza,
				ci_impuesto,
				ci_tran)
go

print 're_producto_pit_Key on re_consignacion_pit'
CREATE INDEX re_producto_pit_Key on re_consignacion_pit(
				cp_estado,
				cp_producto)
go

print 're_cuadre_Key on re_cuadre_contable'
CREATE INDEX re_cuadre_Key on re_cuadre_contable(
				cu_cuenta,
				cu_fecha,
				cu_producto)
go

print 'idx1 on re_cuenta_contractual'
CREATE INDEX idx1 on re_cuenta_contractual(
				--pct_categoria,
				--pct_causa,
				--pct_estado,
				--pct_profinal,
				--pct_transaccion,
				--bd_fecha,
				cc_cta_banco,
				cc_estado--,
				--tc_estado,
				--tc_fecha,
				--tc_ofic_dest,
				--tc_ofic_orig,
				--tc_perfil,
				--tc_producto
)
go

print 're_det_carta_cta_Key on re_det_carta'
CREATE INDEX re_det_carta_cta_Key on re_det_carta(
				dc_carta,
				dc_cheque,
				dc_cta_depositada)
go

print 're_det_cheques_rem_dev_fKey on re_det_cheques'
CREATE INDEX re_det_cheques_rem_dev_fKey on re_det_cheques(
				dc_bco_ced,
				dc_fecha_reembolso)
go

print 're_detalle_trf_Key on re_detalle_transfer'
CREATE INDEX re_detalle_trf_Key on re_detalle_transfer(
				dt_codigo,
				dt_estado)
go

print 'i_idx2 on re_equivalencias'
CREATE INDEX i_idx2 on re_equivalencias(
				eq_mod_int,
				eq_modulo,
				eq_tabla,
				eq_val_num_fin,
				eq_val_num_ini)
go

print 're_eventos_key on re_eventos'
CREATE INDEX re_eventos_key on re_eventos(
				fecha,
				tipo)
go

print 're_gen_monet_bv_Key on re_gen_monet_bv'
CREATE INDEX re_gen_monet_bv_Key on re_gen_monet_bv(
				gm_fecha,
				gm_ssn_local,
				gm_ssn_local_alterno)
go

print 're_gmf_alianza_key on re_gmf_alianza'
CREATE UNIQUE INDEX re_gmf_alianza_key on re_gmf_alianza(
				gm_codigo,
				gm_estado,
				gm_fecha)
go

print 're_camgrupo_Key on re_grupo_camara'
CREATE INDEX re_camgrupo_Key on re_grupo_camara(
				ca_grupo)
go

print 're_hisextra on re_his_extracto'
CREATE INDEX re_hisextra on re_his_extracto(
				he_ano,
				he_cta_banco,
				he_mes)
go

print 're_liqsegdian on re_liquidacion_intereses'
CREATE INDEX re_liqsegdian on re_liquidacion_intereses(
				re_fecha,
				re_secuencial)
go

print 're_logtran_atm_Key on re_logtran_atm'
CREATE INDEX re_logtran_atm_Key on re_logtran_atm(
				at_nodo,
				at_secuencial)
go

print 'i_idx_re_mantenimiento_cb on re_mantenimiento_cb'
CREATE UNIQUE INDEX i_idx_re_mantenimiento_cb on re_mantenimiento_cb(
				mc_cod_cb,
				mc_cod_red,
				mc_ente)
go

print 're_ndc_automatica_empsec on re_ndc_automatica'
CREATE INDEX re_ndc_automatica_empsec on re_ndc_automatica(
				na_empresa,
				na_moneda,
				na_sec)
go

print 're_numcta_extracto_key on re_numcta_extracto'
CREATE INDEX re_numcta_extracto_key on re_numcta_extracto(
				secuencial)
go

print 'i_ob_ofi_cobis on re_ofi_banco'
CREATE INDEX i_ob_ofi_cobis on re_ofi_banco(
				ob_ofi_cobis)
go

print 'idorden_pk on re_orden_caja'
CREATE UNIQUE INDEX idorden_pk on re_orden_caja(
				oc_idorden)
go

print 're_paquete_key on re_paquete'
CREATE INDEX re_paquete_key on re_paquete(
				pa_final,
				pa_inicial)
go

print 're_paraextr1 on re_parametro_extracto'
CREATE INDEX re_paraextr1 on re_parametro_extracto(
				pe_categoria,
				pe_prodbanc,
				pe_producto)
go

print 're_procesar_pagos_bv_Key on re_procesar_pagos_bv'
CREATE UNIQUE INDEX re_procesar_pagos_bv_Key on re_procesar_pagos_bv(
				pp_pago_id)
go

print 're_producto_cliente_key2 on re_producto_cliente'
CREATE INDEX re_producto_cliente_key2 on re_producto_cliente(
				pc_producto,
				pc_tipo_relacion)
go

print 'i_idx_re_punto_red_cb on re_punto_red_cb'
CREATE UNIQUE INDEX i_idx_re_punto_red_cb on re_punto_red_cb(
				pr_codigo_cb,
				pr_codigo_punto)
go

print 're_rechazos_mon on re_rechazo_tran'
CREATE INDEX re_rechazos_mon on re_rechazo_tran(
				rh_oficina_cta,
				rh_procesado,
				rh_producto,
				rh_tipo,
				rh_transacion)
go

print 're_reintegro_key on re_reintegro_dtn'
CREATE INDEX re_reintegro_key on re_reintegro_dtn(
				ri_cta_banco)
go

print 'i_rc_cuenta_tel_celular on re_relacion_cta_canal'
CREATE INDEX i_rc_cuenta_tel_celular on re_relacion_cta_canal(
				rc_cuenta,
				rc_tel_celular)
go

print 're_rembolso_bc_fKey on re_rembolso_bcocedente'
CREATE INDEX re_rembolso_bc_fKey on re_rembolso_bcocedente(
				rb_banco,
				rb_fecha_conf--,
				--rc_banco,
				--rc_fecha_conf
)
go

print 're_rembolso_bc_fKey on re_rembolso_corresponsal'
CREATE INDEX re_rembolso_bc_fKey on re_rembolso_corresponsal(
				--rb_banco,
				--rb_fecha_conf,
				rc_banco,
				rc_fecha_conf)
go

print 'i_re_remesa_mensual on re_remesa_mensual'
CREATE INDEX i_re_remesa_mensual on re_remesa_mensual(
				rm_fecha,
				rm_oficina,
				rm_sucursal)
go

print 're_saldo_bc_Key on re_saldo_bcocedente'
CREATE UNIQUE INDEX re_saldo_bc_Key on re_saldo_bcocedente(
				sb_banco,
				sb_fecha--,
				--sc_banco,
				--sc_fecha
)
go

print 're_saldo_contable_Key on re_saldo_contable'
CREATE INDEX re_saldo_contable_Key on re_saldo_contable(
				sc_empresa,
				sc_estado,
				sc_prod_banc,
				sc_producto)
go

print 're_saldo_bc_Key on re_saldo_corresponsales'
CREATE UNIQUE INDEX re_saldo_bc_Key on re_saldo_corresponsales(
				--sb_banco,
				--sb_fecha,
				sc_banco,
				sc_fecha)
go

print 're_total_Key on re_total'
CREATE UNIQUE INDEX re_total_Key on re_total(
				to_calificacion,
				to_causa,
				to_clase_clte,
				to_clase_garantia,
				to_cliente,
				to_dias_sobregiro,
				to_fondos,
				to_hora,
				to_moneda,
				to_ofic_dest,
				to_ofic_orig,
				to_prod_banc,
				to_producto,
				to_referencia,
				to_tipo_cta,
				to_tipo_tran)
go

print 'i_re_total_bv on re_total_bv'
CREATE INDEX i_re_total_bv on re_total_bv(
				to_causa,
				to_producto,
				to_tipo_tran)
go

print 're_total_rem_Key on re_total_rem'
CREATE UNIQUE INDEX re_total_rem_Key on re_total_rem(
				tr_fecha,
				tr_oficina,
				tr_tipo_cliente)
go

print 're_totales_remesas_ofi_Key on re_totales_remesas'
CREATE INDEX re_totales_remesas_ofi_Key on re_totales_remesas(
				tr_mes,
				tr_oficina)
go

print 're_tran_contable_Key on re_tran_contable'
CREATE UNIQUE INDEX re_tran_contable_Key on re_tran_contable(
				tc_causa_dst,
				tc_causa_org,
				tc_tipo_tran)
go

print 're_tran_monet_bv_Key1 on re_tran_monet_bv'
CREATE INDEX re_tran_monet_bv_Key1 on re_tran_monet_bv(
				tm_fecha,
				tm_hora,
				tm_ssn_local,
				tm_ssn_local_alterno,
				tm_usuario)
go

print 'i_re_traslado on re_traslado'
CREATE INDEX i_re_traslado on re_traslado(
				tr_estado,
				tr_fecha,
				tr_tipo)
go

print 'idx3 on re_trn_contable'
CREATE INDEX idx3 on re_trn_contable(
				tc_secuencial)
go

print 'idx_sec on re_trn_perfil'
CREATE INDEX idx_sec on re_trn_perfil(
				tp_secuencial)
go

print 'idx_prod on re_valida_datos_offline'
CREATE INDEX idx_prod on re_valida_datos_offline(
				vd_cuenta,
				vd_producto)
go

print 'i_salter on salter_def'
CREATE INDEX i_salter on salter_def(
				st_cuenta,
				st_ente,
				st_oficina)
go

print 'tmp_cb_hist_saldo on tmp_cb_hist_saldo'
CREATE INDEX tmp_cb_hist_saldo on tmp_cb_hist_saldo(
				th_cuenta,
				th_empresa,
				th_oficina)
go

print 'tmp_cb_hist_saldo2 on tmp_cb_hist_saldo2'
CREATE INDEX tmp_cb_hist_saldo2 on tmp_cb_hist_saldo2(
				ta_cuenta,
				ta_empresa,
				ta_oficina)
go

print 'tmp_cb_saldo_promm on tmp_cb_saldo_promm'
CREATE INDEX tmp_cb_saldo_promm on tmp_cb_saldo_promm(
				sp_cuenta,
				sp_oficina)
go

print 'i_tmp_saldo_tr2 on tmp_saldo_traslado'
CREATE INDEX i_tmp_saldo_tr2 on tmp_saldo_traslado(
				ts_oficina_pag)
go

print 'tmp_sasiento_Key on tmp_sasiento'
CREATE INDEX tmp_sasiento_Key on tmp_sasiento(
				spid)
go

print 'tmp_siento_comp_Key on tmp_siento_comp'
CREATE INDEX tmp_siento_comp_Key on tmp_siento_comp(
				spid)
go

print 'ts_tran_serv_pag_decl_i1 on ts_tran_serv_pag_decl'
CREATE INDEX ts_tran_serv_pag_decl_i1 on ts_tran_serv_pag_decl(
				ts_clase,
				ts_secuencial,
				ts_tipo_tran)
go


print 'i_bco_cta_chq'
CREATE nonclustered INDEX i_bco_cta_chq on re_detalle_cheque(
                dc_co_banco,
				dc_cta_cheque,
				dc_num_cheque)
go

print 'i_ofi_fech_pro_bco_cta'
CREATE nonclustered INDEX i_ofi_fech_pro_bco_cta on re_detalle_cheque(
                dc_oficina,
				dc_fecha_efe,
				dc_producto,
				dc_cta_banco)
go

print 're_cheque_ofi_mone_Key'
CREATE INDEX re_cheque_ofi_mone_Key ON re_cheque_rec (
        cr_oficina,
        cr_moneda,
        cr_cta_depositada)
go


