use cob_remesas
go

print 'pro_bancario_Key on pe_pro_bancario'
CREATE UNIQUE INDEX pro_bancario_Key on pe_pro_bancario(
				pb_pro_bancario)
go

print 'mercado_Key on pe_mercado'
CREATE UNIQUE INDEX mercado_Key on pe_mercado(
				me_mercado)
go

print 'basico_Key on pe_basico'
CREATE UNIQUE INDEX basico_Key on pe_basico(
				ba_mercado,
				ba_servicio)
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

print 'servicio_dis_Key on pe_servicio_dis'
CREATE UNIQUE INDEX servicio_dis_Key on pe_servicio_dis(
				sd_servicio_dis)
go

print 'pe_cambio_costo_Key on pe_cambio_costo'
CREATE UNIQUE INDEX pe_cambio_costo_Key on pe_cambio_costo(
				cc_secuencial)
go

print 'tipo_rango_Key on pe_tipo_rango'
CREATE UNIQUE INDEX tipo_rango_Key on pe_tipo_rango(
				tr_tipo_rango)
go

print 'var_servicio_Key on pe_var_servicio'
CREATE UNIQUE INDEX var_servicio_Key on pe_var_servicio(
				vs_rubro,
				vs_servicio_dis)
go

print 'servicio_per_Key on pe_servicio_per'
CREATE UNIQUE INDEX servicio_per_Key on pe_servicio_per(
				sp_pro_final,
				sp_rubro,
				sp_servicio_dis)
go

print 'rango_Key on pe_rango'
CREATE UNIQUE INDEX rango_Key on pe_rango(
				ra_grupo_rango,
				ra_rango,
				ra_tipo_rango)
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

print 'servicio_contr_Key on pe_servicio_contr'
CREATE UNIQUE INDEX servicio_contr_Key on pe_servicio_contr(
				sc_codigo,
				sc_servicio_dis)
go

print 'limite_Key on pe_limite'
CREATE UNIQUE INDEX limite_Key on pe_limite(
				li_categoria,
				li_servicio_per)
go

print 'equiv_servtrn_Key on pe_equiv_serv_trn'
CREATE UNIQUE INDEX equiv_servtrn_Key on pe_equiv_serv_trn(
				st_causal,
				st_rubro,
				st_servicio,
				st_trn)
go

print 'pe_causales_restringidas_1 on pe_causales_restringidas'
CREATE UNIQUE INDEX pe_causales_restringidas_1 on pe_causales_restringidas(
				cr_causal,
				cr_especie,
				cr_origen,
				cr_tipo_tran)
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




print 'pe_limites_restrictivos_1 on pe_limites_restrictivos'
CREATE UNIQUE INDEX pe_limites_restrictivos_1 on pe_limites_restrictivos(
				lr_especie,
				lr_origen,
				lr_tabla,
				lr_tipo_tran)
go



print 'pe_par_comision_Key on pe_par_comision'
CREATE UNIQUE INDEX pe_par_comision_Key on pe_par_comision(
				pc_categoria,
				pc_fechavig,
				pc_profinal)
go
