use cob_remesas
go
print 'cc_mensaje_estcta_Key on cc_mensaje_estcta'
CREATE UNIQUE INDEX cc_mensaje_estcta_Key on cc_mensaje_estcta(
				me_fecha,
				me_fecha_fin,
				me_oficina,
				me_prodban)
go

print 'cm_cheques_Key1 on cm_cheques'
CREATE UNIQUE INDEX cm_cheques_Key1 on cm_cheques(
				cq_banco,
				cq_contador,
				cq_fecha,
				cq_moneda,
				cq_tipo_compensa,
				cq_usuario)
go

print 'cm_ingreso_Key1 on cm_ingreso'
CREATE UNIQUE INDEX cm_ingreso_Key1 on cm_ingreso(
				in_banco,
				in_fecha,
				in_moneda,
				in_tipo_compensa,
				in_usuario)
go

print 'basico_Key on pe_basico'
CREATE UNIQUE INDEX basico_Key on pe_basico(
				ba_mercado,
				ba_servicio)
go

print 'pe_cambio_costo_Key on pe_cambio_costo'
CREATE UNIQUE INDEX pe_cambio_costo_Key on pe_cambio_costo(
				cc_secuencial)
go

print 'pe_causales_restringidas_1 on pe_causales_restringidas'
CREATE UNIQUE INDEX pe_causales_restringidas_1 on pe_causales_restringidas(
				cr_causal,
				cr_especie,
				cr_origen,
				cr_tipo_tran)
go

print 'costo_Key on pe_costo'
CREATE UNIQUE INDEX costo_Key on pe_costo(
				co_categoria,
				co_fecha_vigencia,
				co_grupo_rango,
				co_rango,
				co_secuencial,
				co_servicio_per,
				co_tipo_rango)
go

print 'costo_especial_Key on pe_costo_especial'
CREATE UNIQUE INDEX costo_especial_Key on pe_costo_especial(
				ce_en_linea,
				ce_grupo_rango,
				ce_rango,
				ce_rubro,
				ce_servicio_dis,
				ce_tipo_rango)
go

print 'costo_especial_per_Key on pe_costo_especial_per'
CREATE UNIQUE INDEX costo_especial_per_Key on pe_costo_especial_per(
				cp_cliente,
				cp_cuenta,
				cp_grupo_rango,
				cp_oficina,
				cp_rango,
				cp_rubro,
				cp_secuencial,
				cp_servicio_dis,
				cp_tipo_rango)
go

print 'equiv_servtrn_Key on pe_equiv_serv_trn'
CREATE UNIQUE INDEX equiv_servtrn_Key on pe_equiv_serv_trn(
				st_causal,
				st_rubro,
				st_servicio,
				st_trn)
go

print 'limite_Key on pe_limite'
CREATE UNIQUE INDEX limite_Key on pe_limite(
				li_categoria,
				li_servicio_per)
go

print 'pe_limites_restrictivos_1 on pe_limites_restrictivos'
CREATE UNIQUE INDEX pe_limites_restrictivos_1 on pe_limites_restrictivos(
				lr_especie,
				lr_origen,
				lr_tabla,
				lr_tipo_tran)
go

print 'mercado_Key on pe_mercado'
CREATE UNIQUE INDEX mercado_Key on pe_mercado(
				me_mercado)
go

print 'pe_par_comision_Key on pe_par_comision'
CREATE UNIQUE INDEX pe_par_comision_Key on pe_par_comision(
				pc_categoria,
				pc_fechavig,
				pc_profinal)
go

print 'pro_bancario_Key on pe_pro_bancario'
CREATE UNIQUE INDEX pro_bancario_Key on pe_pro_bancario(
				pb_pro_bancario)
go

print 'pro_final_Key on pe_pro_final'
CREATE UNIQUE INDEX pro_final_Key on pe_pro_final(
				pf_filial,
				pf_mercado,
				pf_moneda,
				pf_producto,
				pf_sucursal,
				pf_tipo)
go

print 'rango_Key on pe_rango'
CREATE UNIQUE INDEX rango_Key on pe_rango(
				ra_grupo_rango,
				ra_rango,
				ra_tipo_rango)
go

print 'servicio_contr_Key on pe_servicio_contr'
CREATE UNIQUE INDEX servicio_contr_Key on pe_servicio_contr(
				sc_codigo,
				sc_servicio_dis)
go

print 'servicio_dis_Key on pe_servicio_dis'
CREATE UNIQUE INDEX servicio_dis_Key on pe_servicio_dis(
				sd_servicio_dis)
go

print 'servicio_per_Key on pe_servicio_per'
CREATE UNIQUE INDEX servicio_per_Key on pe_servicio_per(
				sp_pro_final,
				sp_rubro,
				sp_servicio_dis)
go

print 'tipo_rango_Key on pe_tipo_rango'
CREATE UNIQUE INDEX tipo_rango_Key on pe_tipo_rango(
				tr_tipo_rango)
go

print 'val_contratado_Key on pe_val_contratado'
CREATE UNIQUE INDEX val_contratado_Key on pe_val_contratado(
				vc_categoria,
				vc_codigo,
				vc_fecha,
				vc_grupo_rango,
				vc_producto,
				vc_rango,
				vc_rol,
				vc_secuencial,
				vc_servicio_per,
				vc_tipo_default,
				vc_tipo_rango)
go

print 'var_servicio_Key on pe_var_servicio'
CREATE UNIQUE INDEX var_servicio_Key on pe_var_servicio(
				vs_rubro,
				vs_servicio_dis)
go

print 're_accion_nc_Key on re_accion_nc'
CREATE UNIQUE INDEX re_accion_nc_Key on re_accion_nc(
				an_causa,
				an_producto)
go

print 're_accion_nd_Key on re_accion_nd'
CREATE UNIQUE INDEX re_accion_nd_Key on re_accion_nd(
				an_causa,
				an_comision,
				an_modo,
				an_producto)
go

print 're_aprobacion_camara_Key on re_aprobacion_camara'
CREATE UNIQUE INDEX re_aprobacion_camara_Key on re_aprobacion_camara(
				ac_id,
				ac_oficial)
go

print 're_autelectronicos_Key on re_autelectronicos'
CREATE UNIQUE INDEX re_autelectronicos_Key on re_autelectronicos(
				at_nit)
go

print 're_autoriza_ndnc_Key on re_autoriza_ndnc'
CREATE UNIQUE INDEX re_autoriza_ndnc_Key on re_autoriza_ndnc(
				an_cuenta,
				an_moneda,
				an_ofi,
				an_producto,
				an_ssn_branch,
				an_trn,
				an_user)
go

print 're_banco_Key on re_banco'
CREATE UNIQUE INDEX re_banco_Key on re_banco(
				ba_banco)
go

print 're_caja_Key on re_caja'
CREATE INDEX re_caja_Key on re_caja(
				cj_filial,
				cj_id_caja,
				cj_id_cierre,
				cj_moneda,
				cj_oficina,
				cj_operador,
				cj_rol,
				cj_transaccion)
go

print 're_caja_his_Key on re_caja_his'
CREATE INDEX re_caja_his_Key on re_caja_his(
				ch_filial,
				ch_id_caja,
				ch_id_cierre,
				ch_moneda,
				ch_oficina,
				ch_operador,
				ch_rol,
				ch_transaccion)
go

print 'pk_re_caja_rol on re_caja_rol'
CREATE UNIQUE INDEX pk_re_caja_rol on re_caja_rol(
				cr_filial,
				cr_rol,
				cr_tipo_caja)
go

print 're_cam_pendiente_Key on re_cam_pendiente'
CREATE UNIQUE INDEX re_cam_pendiente_Key on re_cam_pendiente(
				cp_clase,
				cp_id,
				cp_moneda,
				cp_oficial)
go

print 're_camara_Key on re_camara'
CREATE UNIQUE INDEX re_camara_Key on re_camara(
				ca_fecha,
				ca_secuencial)
go

print 're_campo_impuesto_Key on re_campo_impuesto'
CREATE UNIQUE INDEX re_campo_impuesto_Key on re_campo_impuesto(
				ci_campo,
				ci_clase,
				ci_tipo)
go

print 're_carta_Key on re_carta'
CREATE UNIQUE INDEX re_carta_Key on re_carta(
				ct_banco_e,
				ct_banco_p,
				ct_carta,
				ct_ciudad_e,
				ct_ciudad_p,
				ct_fecha_emi,
				ct_moneda,
				ct_oficina_e,
				ct_oficina_p)
go

print 'PK__re_catalogo_ofi__3575474C on re_catalogo_ofi'
CREATE UNIQUE INDEX PK__re_catalogo_ofi__3575474C on re_catalogo_ofi(
				co_index)
go

print 're_catalogo_premio_Key on re_catalogo_premio'
CREATE UNIQUE INDEX re_catalogo_premio_Key on re_catalogo_premio(
				pr_categoria,
				pr_codigo)
go

print 're_cheque_rec_Key on re_cheque_rec'
CREATE UNIQUE INDEX re_cheque_rec_Key on re_cheque_rec(
				cr_banco_p,
				cr_cheque_rec,
				cr_cta_depositada,
				cr_fecha_ing)
go

print 're_cheque_rem_Key on re_cheque_rem'
CREATE UNIQUE INDEX re_cheque_rem_Key on re_cheque_rem(
				cr_secuencial)
go

print 're_chq_remesas_Key on re_cheques_remesas'
CREATE UNIQUE INDEX re_chq_remesas_Key on re_cheques_remesas(
				cr_cta_dep,
				cr_estado,
				cr_fecha_emi,
				cr_secuencial)
go

print 're_cierre_Key on re_cierre'
CREATE UNIQUE INDEX re_cierre_Key on re_cierre(
				ci_fecha,
				ci_filial,
				ci_id_caja,
				ci_id_cierre,
				ci_moneda,
				ci_oficina)
go

print 're_ciudad_retencion_Key on re_ciudad_retencion'
CREATE UNIQUE INDEX re_ciudad_retencion_Key on re_ciudad_retencion(
				cr_ciudad)
go

print 're_codbar_impuesto_Key on re_codbar_impuesto'
CREATE UNIQUE INDEX re_codbar_impuesto_Key on re_codbar_impuesto(
				rc_clase,
				rc_moneda,
				rc_tipo,
				rc_tipo_cod)
go

print 're_codigo_barras_Key on re_codigo_barras'
CREATE UNIQUE INDEX re_codigo_barras_Key on re_codigo_barras(
				cb_moneda,
				cb_tipo_cod)
go

print 'pk_re_compensa_ofi on re_compensa_ofi'
CREATE UNIQUE INDEX pk_re_compensa_ofi on re_compensa_ofi(
				co_oficina)
go

print 'pk_re_conversion on re_conversion'
CREATE UNIQUE INDEX pk_re_conversion on re_conversion(
				cv_filial,
				cv_moneda,
				cv_oficina,
				cv_producto,
				cv_tipo,
				cv_tipo_cta)
go

print 're_cta_consolidada_Key on re_cta_consolidada'
CREATE INDEX re_cta_consolidada_Key on re_cta_consolidada(
				cc_cta_principal)
go

print 're_cta_efectivizacion_esp_Key on re_cta_efectivizacion_esp'
CREATE UNIQUE INDEX re_cta_efectivizacion_esp_Key on re_cta_efectivizacion_esp(
				ce_cuenta,
				ce_producto)
go

print 're_det_carta_Key on re_det_carta'
CREATE UNIQUE INDEX re_det_carta_Key on re_det_carta(
				dc_banco_e,
				dc_banco_p,
				dc_carta,
				dc_cheque,
				dc_ciudad_e,
				dc_ciudad_p,
				dc_fecha_emi,
				dc_moneda,
				dc_oficina_e,
				dc_oficina_p)
go

print 're_det_dataentry_key on re_det_dataentry'
CREATE UNIQUE INDEX re_det_dataentry_key on re_det_dataentry(
				de_comprobante,
				de_fecha,
				de_secuencial)
go

print 're_detalle_cbarras_Key on re_detalle_cbarras'
CREATE UNIQUE INDEX re_detalle_cbarras_Key on re_detalle_cbarras(
				rd_posicion,
				rd_tipo_cod)
go

print 're_dif_caja_Key on re_dif_caja'
CREATE UNIQUE INDEX re_dif_caja_Key on re_dif_caja(
				dc_fecha,
				dc_filial,
				dc_id_caja,
				dc_oficina)
go

print 're_enca_transfer_auto_Key on re_enca_transfer_automatica'
CREATE UNIQUE INDEX re_enca_transfer_auto_Key on re_enca_transfer_automatica(
				ta_cuenta_dst,
				ta_tipo)
go

print 're_findia_bv_Key on re_findia_bv'
CREATE UNIQUE INDEX re_findia_bv_Key on re_findia_bv(
				fd_accion,
				fd_fecha)
go

print 're_gcontribuyente_Key on re_gcontribuyente'
CREATE UNIQUE INDEX re_gcontribuyente_Key on re_gcontribuyente(
				gc_nit)
go

print 're_grupo_Key on re_grupo'
CREATE UNIQUE INDEX re_grupo_Key on re_grupo(
				gr_grupo,
				gr_nivel)
go

print 're_impuesto_Key on re_impuesto'
CREATE UNIQUE INDEX re_impuesto_Key on re_impuesto(
				im_administracion,
				im_clase,
				im_oficina,
				im_tipo)
go

print 're_limite_transaccion_Key on re_limite_transaccion'
CREATE UNIQUE INDEX re_limite_transaccion_Key on re_limite_transaccion(
				lt_ofi_cta,
				lt_tipo,
				lt_transaccion)
go

print 'pk_re_limites on re_limites'
CREATE UNIQUE INDEX pk_re_limites on re_limites(
				li_id)
go

print 're_marcacion_cuentas_Key on re_marcacion_cuentas'
CREATE UNIQUE INDEX re_marcacion_cuentas_Key on re_marcacion_cuentas(
				mc_cuenta,
				mc_servicio)
go

print 're_movimientos_caja_Key on re_movimientos_caja'
CREATE UNIQUE INDEX re_movimientos_caja_Key on re_movimientos_caja(
				mc_filial,
				mc_id)
go

print 're_ndc_automatica_Key on re_ndc_automatica'
CREATE UNIQUE INDEX re_ndc_automatica_Key on re_ndc_automatica(
				na_empresa,
				na_fecha,
				na_sec)
go

print 're_nombre_bcogirado_Key on re_nombre_bcogirado'
CREATE UNIQUE INDEX re_nombre_bcogirado_Key on re_nombre_bcogirado(
				nb_codigo)
go

print 're_ofi_banco_Key on re_ofi_banco'
CREATE UNIQUE INDEX re_ofi_banco_Key on re_ofi_banco(
				ob_banco,
				ob_ciudad,
				ob_oficina)
go

print 're_ofi_safe_Key on re_ofi_safe'
CREATE UNIQUE INDEX re_ofi_safe_Key on re_ofi_safe(
				co_oficina)
go

print 're_tipocanje_Key on re_oficina_canje'
CREATE UNIQUE INDEX re_tipocanje_Key on re_oficina_canje(
				oc_oficina)
go

print 'icliente_pk on re_orden_caja'
CREATE INDEX icliente_pk on re_orden_caja(
				oc_cliente)
go

print 're_param_ex_Key on re_param_ex'
CREATE UNIQUE INDEX re_param_ex_Key on re_param_ex(
				pe_prod_banc,
				pe_tipo_per)
go

print 're_peticiones_efectivo_Key on re_peticiones_efectivo'
CREATE UNIQUE INDEX re_peticiones_efectivo_Key on re_peticiones_efectivo(
				pe_filial,
				pe_id,
				pe_oficina)
go

print 're_propiedad_ndc_Key on re_propiedad_ndc'
CREATE UNIQUE INDEX re_propiedad_ndc_Key on re_propiedad_ndc(
				pr_causa,
				pr_producto,
				pr_signo)
go

print 're_retencion_Key on re_retencion'
CREATE UNIQUE INDEX re_retencion_Key on re_retencion(
				re_cuenta,
				re_fecha,
				re_producto)
go

print 're_saldo_cuenta_Key on re_saldo_cuenta'
CREATE UNIQUE INDEX re_saldo_cuenta_Key on re_saldo_cuenta(
				sc_cuenta,
				sc_producto)
go

print 're_saldos_caja_Key on re_saldos_caja'
CREATE UNIQUE INDEX re_saldos_caja_Key on re_saldos_caja(
				sc_filial,
				sc_id,
				sc_moneda,
				sc_oficina)
go

print 're_supervisor_Key on re_supervisor'
CREATE UNIQUE INDEX re_supervisor_Key on re_supervisor(
				su_funcionario,
				su_oficina)
go

print 're_tesoro_nacional_Key on re_tesoro_nacional'
CREATE UNIQUE INDEX re_tesoro_nacional_Key on re_tesoro_nacional(
				tn_ced_ruc,
				tn_cuenta,
				tn_fecha)
go

print 're_total_bv_Key on re_total_bv'
CREATE INDEX re_total_bv_Key on re_total_bv(
				to_causa,
				to_clase_clte,
				to_cliente,
				to_moneda,
				to_ofic_dest,
				to_ofic_orig,
				to_oficial,
				to_prod_banc,
				to_producto,
				to_tipo_tran)
go

print 'pk_re_tran_contable on re_tran_contable'
CREATE UNIQUE INDEX pk_re_tran_contable on re_tran_contable(
				tc_secuencial)
go

print 're_tran_equiv_bv_Key on re_tran_equiv_bv'
CREATE UNIQUE INDEX re_tran_equiv_bv_Key on re_tran_equiv_bv(
				te_canal,
				te_prd_dst,
				te_prd_org,
				te_signo_org,
				te_srv_local,
				te_trn_bvi)
go

print 're_tran_interfase_Key on re_tran_interfase'
CREATE UNIQUE INDEX re_tran_interfase_Key on re_tran_interfase(
				ti_causa,
				ti_empresa,
				ti_moneda,
				ti_producto,
				ti_tipo_tran)
go

print 'IX_re_tran_monet_atm on re_tran_monet_atm'
CREATE UNIQUE INDEX IX_re_tran_monet_atm on re_tran_monet_atm(
				tm_cta_banco,
				tm_filial,
				tm_ssn_local,
				tm_ssn_local_alterno)
go

print 're_tran_monet_bv_Key on re_tran_monet_bv'
CREATE INDEX re_tran_monet_bv_Key on re_tran_monet_bv(
				tm_oficina,
				tm_ssn_local,
				tm_ssn_local_alterno)
go

print 'IX_re_tran_monet_tmp_atm on re_tran_monet_tmp_atm'
CREATE UNIQUE INDEX IX_re_tran_monet_tmp_atm on re_tran_monet_tmp_atm(
				tm_cta_banco,
				tm_filial,
				tm_ssn_local,
				tm_ssn_local_alterno)
go

print 're_trans_alerta_key on re_trans_alerta'
CREATE UNIQUE INDEX re_trans_alerta_key on re_trans_alerta(
				ta_transaccion)
go

print 're_transfer_automatica_Key on re_transfer_automatica'
CREATE UNIQUE INDEX re_transfer_automatica_Key on re_transfer_automatica(
				ta_cuenta_dst,
				ta_cuenta_org,
				ta_tipo)
go

print 're_transito_Key on re_transito'
CREATE UNIQUE INDEX re_transito_Key on re_transito(
				tn_banco_p,
				tn_ciudad_p,
				tn_nombre,
				tn_oficina_p)
go

print 're_traslado_Key on re_traslado'
CREATE UNIQUE INDEX re_traslado_Key on re_traslado(
				tr_secuencial)
go

print 're_trn_causa_atm_Key on re_trn_causa_atm'
CREATE UNIQUE INDEX re_trn_causa_atm_Key on re_trn_causa_atm(
				tc_correccion,
				tc_red,
				tc_signo,
				tc_trn_atm)
go

print 're_trn_causa_bvirtual_Key on re_trn_causa_bvirtual'
CREATE UNIQUE INDEX re_trn_causa_bvirtual_Key on re_trn_causa_bvirtual(
				cb_prod,
				cb_servicio,
				cb_signo,
				cb_trn_bv)
go

print 're_trn_grupo_Key on re_trn_grupo'
CREATE UNIQUE INDEX re_trn_grupo_Key on re_trn_grupo(
				tg_grupo,
				tg_indicador,
				tg_nivel,
				tg_transaccion)
go

print 'pk_re_validacion_monto on re_validacion_monto'
CREATE UNIQUE INDEX pk_re_validacion_monto on re_validacion_monto(
				va_moneda,
				va_online,
				va_tipo,
				va_transaccion)
go

