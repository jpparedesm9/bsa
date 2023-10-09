/************************************************
---No Bug:
---Título del Bug: creacion de indices
---Fecha:2017-06-15
--Descripción del Problema: no permite mantenimiento de algunas tablas
--Descripción de la Solución: crear los indices
--Autor:LGU

**************************************************/



use cobis
go


print '=====> rp_consolidacion_no_cli_Key'
go
CREATE CLUSTERED INDEX rp_consolidacion_no_cli_Key ON rp_consolidacion_no_cli
(
    cn_nombre ,
    cn_fecha_tra
)  ON indexgroup
go



print '=====> rp_consolidacion_Key'
go
CREATE CLUSTERED INDEX rp_consolidacion_Key ON rp_consolidacion
(
    co_fecha_tra ,
    co_codigo ,
    co_cuenta
)  ON indexgroup
go



print '=====> ico_act_codigo'
go
CREATE NONCLUSTERED INDEX ico_act_codigo ON rp_consolidacion
(
    co_act_economica ASC,
    co_codigo ASC,
    co_cuenta ASC,
    co_fecha_tra ASC
) ON indexgroup
go


print '=====> idx1'
go
CREATE CLUSTERED INDEX idx1 ON cl_ws_ente_tmp
(
    we_secuencial ASC
) ON indexgroup
go

print '=====> idx1'
go
CREATE NONCLUSTERED INDEX idx1 ON cl_ws_alerta_tmp
(
    wa_secuencial ASC,
    wa_tipo_registro ASC
) ON indexgroup
go


print '=====> cl_tran_servicio_conv_tel_1'
go
CREATE NONCLUSTERED INDEX cl_tran_servicio_conv_tel_1 ON cl_tran_servicio_conv_tel
(
    te_ente ASC,
    operacion ASC,
    fecha_upd ASC
) ON indexgroup
go

print '=====> cl_tran_servicio_conv_mer_1'
go
CREATE NONCLUSTERED INDEX cl_tran_servicio_conv_mer_1 ON cl_tran_servicio_conv_mer
(
    mo_ente ASC,
    operacion ASC,
    fecha_upd ASC
) ON indexgroup
go






print '=====> cl_tran_servicio_conv_mer_2'
go
CREATE NONCLUSTERED INDEX cl_tran_servicio_conv_mer_2 ON cl_tran_servicio_conv_mer
(
    fecha_upd ASC
) ON indexgroup
go



print '=====> cl_tran_servicio_conv_dir_1'
go
CREATE NONCLUSTERED INDEX cl_tran_servicio_conv_dir_1 ON cl_tran_servicio_conv_dir
(
    di_ente ASC,
    operacion ASC,
    fecha_upd ASC
) ON indexgroup
go



print '=====> cl_tran_servicio_conv_1'
go
CREATE NONCLUSTERED INDEX cl_tran_servicio_conv_1 ON cl_tran_servicio_conv
(
    en_ente ASC,
    operacion ASC,
    fecha_upd ASC
) ON indexgroup
go


print '=====> cl_tran_bloqueada_Key'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_tran_bloqueada_Key ON cl_tran_bloqueada
(
    tr_codproducto ,
    tr_transaccion
) ON indexgroup
go


print '=====> cl_tplan_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_tplan_Key ON cl_tplan
(
    tp_tbalance ,
    tp_cuenta
) ON indexgroup
go


print '=====> cl_tplan_tmp_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_tplan_tmp_Key ON cl_tplan_tmp
(
    tpt_usuario ,
    tpt_terminal ,
    tpt_tbalance ,
    tpt_cuenta
) ON indexgroup
go



print '=====> cl_tbalance_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_tbalance_Key ON cl_tbalance
(
    tb_tbalance
) ON indexgroup
go




print '=====> cl_soc_hecho_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_soc_hecho_Key ON cl_soc_hecho
(
    sh_ente ,
    sh_secuencial
) ON indexgroup
go



print '=====> i_sh_tipo'
go
CREATE NONCLUSTERED INDEX i_sh_tipo ON cl_soc_hecho
(
    sh_tipo ASC
) ON indexgroup
go



print '=====> i_sh_tipo'
go
CREATE NONCLUSTERED INDEX i_sh_tipo ON cl_soc_hecho
(
    sh_tipo ASC
) ON indexgroup
go

print '=====> cl_sectoreco_Key'
go
CREATE CLUSTERED INDEX cl_sectoreco_Key ON cl_sectoreco
(
    se_sector
)  ON indexgroup
go


print '=====> i_ente_datos'
go
CREATE NONCLUSTERED INDEX i_ente_datos ON cl_rep_faltan_datos
(
    rf_ente ASC
) ON indexgroup
go



print '=====> cl_relacion_inter_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_relacion_inter_Key ON cl_relacion_inter
(
    ri_ente ,
    ri_relacion
) ON indexgroup
go



print '=====> cl_refinh_Key'
go
CREATE NONCLUSTERED INDEX cl_refinh_Key ON cl_refinh
(
    in_nomlar,
    in_codigo
) ON indexgroup
go






print '=====> iin_entid'
go
CREATE CLUSTERED INDEX iin_entid ON cl_refinh
(
    in_entid ASC,
    in_codigo ASC
) ON indexgroup
go


print '=====> cl_refinh_idx1'
go
CREATE NONCLUSTERED INDEX cl_refinh_idx1 ON cl_refinh
(
    in_otroid
)
INCLUDE (   in_nombre,
    in_fecha_ref,
    in_origen,
    in_nomlar,
    in_estado)  ON indexgroup
go

print '=====> idx_categoria'
go
CREATE NONCLUSTERED INDEX idx_categoria ON cl_refinh
(
    in_categoria
) ON indexgroup
go

print '=====> iin_ced_ruc'
go
CREATE NONCLUSTERED INDEX iin_ced_ruc ON cl_refinh
(
    in_ced_ruc,
    in_origen DESC
)
INCLUDE (   in_fecha_ref,
    in_nomlar,
    in_estado)  ON indexgroup
go

print '=====> iin_fecha_mod'
go
CREATE NONCLUSTERED INDEX iin_fecha_mod ON cl_refinh
(
    in_fecha_mod
) ON indexgroup
go

print '=====> iin_in_ced_ruc'
go
CREATE NONCLUSTERED INDEX iin_in_ced_ruc ON cl_refinh
(
    in_ced_ruc ASC
) ON indexgroup
go

print '=====> cl_referencia_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_referencia_Key ON cl_referencia
(
    re_ente ,
    re_tipo ,
    re_referencia
) ON indexgroup
go



print '=====> i_re_treferencia'
go
CREATE NONCLUSTERED INDEX i_re_treferencia ON cl_referencia
(
    re_tipo ASC
) ON indexgroup
go


print '=====> cl_ref_personal_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_ref_personal_Key ON cl_ref_personal
(
    rp_persona ,
    rp_referencia
) ON indexgroup
go


print '=====> i_rp_parentesco'
go
CREATE NONCLUSTERED INDEX i_rp_parentesco ON cl_ref_personal
(
    rp_parentesco ASC
) ON indexgroup
go



print '=====> cl_rango_empleo_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_rango_empleo_Key ON cl_rango_empleo
(
    re_tipo_empleo ,
    re_rango_min ,
    re_rango_max
) ON indexgroup
go


print '=====> cl_rango_actividad_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_rango_actividad_Key ON cl_rango_actividad
(
    ra_tipo_actividad ,
    ra_rango_min ,
    ra_rango_max
) ON indexgroup
go


print '=====> cl_propiedad_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_propiedad_Key ON cl_propiedad
(
    pr_persona ,
    pr_propiedad
) ON indexgroup
go



print '=====> cl_plano_ente_tmp_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_plano_ente_tmp_Key ON cl_plano_ente_tmp
(
    en_tipo_ced ,
    en_ced_ruc ,
    en_ente
) ON indexgroup
go


print '=====> cl_plano_consulta_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_plano_consulta_Key ON cl_plano_consulta
(
    pc_num_doc
) ON indexgroup
go



print '=====> cl_plan_tmp_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_plan_tmp_Key ON cl_plan_tmp
(
    pl_user ,
    pl_term ,
    pl_cuenta
) ON indexgroup
go




print '=====> cl_plan_Key'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_plan_Key ON cl_plan
(
    pl_cliente ,
    pl_balance ,
    pl_cuenta
) ON indexgroup
go

print '=====> cl_otros_ingresos_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_otros_ingresos_Key ON cl_otros_ingresos
(
    oi_ente ,
    oi_tipo ,
    oi_descripcion
) ON indexgroup
go

print '=====> cl_origen_fondos_Key'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_origen_fondos_Key ON cl_origen_fondos
(
    of_ente ,
    of_numero
) ON indexgroup
go


print '=====> cl_origen_fondos_Key1'
go
CREATE NONCLUSTERED INDEX cl_origen_fondos_Key1 ON cl_origen_fondos
(
    of_fecha_registro ,
    of_producto
)  ON indexgroup
go


print '=====> cl_objeto_tmp_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_objeto_tmp_Key ON cl_objeto_tmp
(
    ot_usuario ,
    ot_terminal ,
    ot_compania ,
    ot_secuencial
) ON indexgroup
go

print '=====> cl_objeto_com_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_objeto_com_Key ON cl_objeto_com
(
    ob_compania ,
    ob_secuencial
) ON indexgroup
go

print '=====> cl_notaria_ciudad_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_notaria_ciudad_Key ON cl_notaria_ciudad
(
    nc_notaria ,
    nc_ciudad
) ON indexgroup
go

print '=====> cl_nat_jur_Key'
go
CREATE CLUSTERED INDEX cl_nat_jur_Key ON cl_nat_jur
(
    nj_codigo ,
    nj_estado
)  ON indexgroup
go


print '=====> cl_mod_central_riesgo_Key1'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_mod_central_riesgo_Key1 ON cl_mod_central_riesgo
(
    cr_fec_modifi ,
    cr_secuencial ,
    cr_tipo_regis ,
    cr_estado ASC
) ON indexgroup
go

print '=====> cl_mobj_subtipo_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_mobj_subtipo_Key ON cl_mobj_subtipo
(
    ms_codigo ,
    ms_mobjetivo ,
    ms_banca
) ON indexgroup
go

print '=====> cl_mercado_objetivo_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_mercado_objetivo_Key ON cl_mercado_objetivo_cliente
(
    mo_ente
) ON indexgroup
go

print '=====> cl_mercado_Key'
go
CREATE NONCLUSTERED INDEX cl_mercado_Key ON cl_mercado
(
    me_nomlar ,
    me_codigo
) ON indexgroup
go

print '=====> ime_ced_ruc'
go
CREATE CLUSTERED INDEX ime_ced_ruc ON cl_mercado
(
    me_ced_ruc ASC
) ON indexgroup
go

print '=====> cl_mala_ref_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_mala_ref_Key ON cl_mala_ref
(
    mr_ente ,
    mr_treferencia
) ON indexgroup
go


print '=====> cl_maestro_cliente_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_maestro_cliente_Key ON cl_maestro_cliente
(
    ma_ente
) ON indexgroup
go


print '=====> cl_log_fiscal_key1'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_log_fiscal_key1 ON cl_log_fiscal
(
    lf_secuencial ASC
) ON indexgroup
go


print '=====> cl_log_fiscal_key2'
go
CREATE NONCLUSTERED INDEX cl_log_fiscal_key2 ON cl_log_fiscal
(
    lf_ente ASC,
    lf_fecha_modifica ASC
) ON indexgroup
go

print '=====> cl_instancia_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_instancia_Key ON cl_instancia
(
    in_relacion ,
    in_ente_i ,
    in_ente_d
) ON indexgroup
go


print '=====> in_ented_Key'
go
CREATE NONCLUSTERED INDEX in_ented_Key ON cl_instancia
(
    in_ente_d ,
    in_ente_i
)  ON indexgroup
go


print '=====> in_entei_Key'
go
CREATE NONCLUSTERED INDEX in_entei_Key ON cl_instancia
(
    in_ente_i ,
    in_ente_d
)  ON indexgroup
go
print '=====> cl_his_ejecutivo_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_his_ejecutivo_Key ON cl_his_ejecutivo
(
    ej_ente ,
    ej_funcionario ,
    ej_fecha_registro
) ON indexgroup
go

print '=====> cl_forma_homologa_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_forma_homologa_Key ON cl_forma_homologa
(
    fh_abreviatura ,
    fh_forma_hom ,
    fh_estado
) ON indexgroup
go


print '=====> cl_estatuto_tmp_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_estatuto_tmp_Key ON cl_estatuto_tmp
(
    et_usuario ,
    et_terminal ,
    et_compania ,
    et_secuencial
) ON indexgroup
go

print '=====> cl_estatuto_com_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_estatuto_com_Key ON cl_estatuto_com
(
    es_compania ,
    es_secuencial
) ON indexgroup
go

print '=====> cl_errorlog_1'
go
CREATE NONCLUSTERED INDEX cl_errorlog_1 ON cl_error_log
(
    er_fecha_proc ASC
) ON indexgroup
go

print '=====> cl_ejecutivo_Key'
go
CREATE NONCLUSTERED INDEX cl_ejecutivo_Key ON cl_ejecutivo
(
    ej_ente
)  ON indexgroup
go

print '=====> cl_det_embargo_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_det_embargo_Key ON cl_det_embargo
(
    de_ente ,
    de_secuencial ,
    de_sec_interno ,
    de_num_cuenta
) ON indexgroup
go



print '=====> idg_grupo'
go
CREATE NONCLUSTERED INDEX idg_grupo ON cl_def_grupo
(
    dg_grupo ASC
) ON indexgroup
go

print '=====> cl_cuenta_Key'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_cuenta_Key ON cl_cuenta
(
    ct_cuenta
) ON indexgroup
go

print '=====> cl_covinco_Key'
go
CREATE CLUSTERED INDEX cl_covinco_Key ON cl_covinco
(
    cv_nombre ,
    cv_codigo
)  ON indexgroup
go

print '=====> cl_com_liquidacion_Key'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_com_liquidacion_Key ON cl_com_liquidacion
(
    cl_codigo
) ON indexgroup
go


print '=====> cl_cliente_grupo_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_cliente_grupo_Key ON cl_cliente_grupo
(
    cg_grupo ,
    cg_ente
) ON indexgroup
go

print '=====> cl_cliente_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_cliente_Key ON cl_cliente
(
    cl_cliente ,
    cl_det_producto
) ON indexgroup
go


print '=====> icl_det_producto'
go
CREATE NONCLUSTERED INDEX icl_det_producto ON cl_cliente
(
    cl_det_producto ASC
) ON indexgroup
go


print '=====> cl_cifin_Key'
go
CREATE NONCLUSTERED INDEX cl_cifin_Key ON cl_cifin
(
    ci_ente ,
    ci_trimestre
)  ON indexgroup
go

print '=====> cl_categoria_Key'
go
CREATE NONCLUSTERED INDEX cl_categoria_Key ON cl_categoria
(
    ct_codigo ,
    ct_estado
)  ON indexgroup
go

print '=====> cl_casilla_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_casilla_Key ON cl_casilla
(
    cs_ente ,
    cs_casilla
) ON indexgroup
go

print '=====> cl_cab_embargo_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_cab_embargo_Key ON cl_cab_embargo
(
    ca_ente ,
    ca_secuencial
) ON indexgroup
go

print '=====> i_ca_ente'
go
CREATE NONCLUSTERED INDEX i_ca_ente ON cl_cab_embargo
(
    ca_ente ASC,
    ca_fecha ASC
) ON indexgroup
go


print '=====> cl_banco_rem_Key'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_banco_rem_Key ON cl_banco_rem
(
    ba_banco
) ON indexgroup
go
go
print '=====> cl_balance_tmp_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_balance_tmp_Key ON cl_balance_tmp
(
    ba_user ,
    ba_term ,
    ba_cliente
) ON indexgroup
go

print '=====> cl_balance_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_balance_Key ON cl_balance
(
    ba_cliente ,
    ba_balance
) ON indexgroup
go
print '=====> cl_at_relacion_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_at_relacion_Key ON cl_at_relacion
(
    ar_relacion ,
    ar_atributo
) ON indexgroup
go
print '=====> cl_at_instancia_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_at_instancia_Key
	ON dbo.cl_at_instancia (ai_relacion,ai_ente_i,ai_ente_d,ai_atributo)
GO

print '=====> idx1'
go
CREATE CLUSTERED INDEX idx1 ON cl_asociacion_actividad
(
    aa_actividad ASC
) ON indexgroup
go

print '=====> i_ciudad'
go
CREATE NONCLUSTERED INDEX i_ciudad ON cl_area_influencia
(
    ari_cod_ciudad
) ON indexgroup
go

print '=====> cl_aplica_tipo_persona2_Key'
go
CREATE CLUSTERED INDEX cl_aplica_tipo_persona2_Key ON cl_aplica_tipo_persona2
(
    atp_tpersona ASC,
    atp_tipo ,
    atp_t_objeto ,
    atp_secuencia
)  ON indexgroup
go

print '=====> cl_alerta_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_alerta_Key ON cl_alerta
(
    al_codigo
) ON indexgroup
go
print '=====> cl_actualiza_Key'
go
CREATE CLUSTERED INDEX cl_actualiza_Key ON cl_actualiza
(
    ac_fecha ,
    ac_ente ,
    ac_valor_nue
)  ON indexgroup
go

print '=====> icl_ac_campo'
go
CREATE NONCLUSTERED INDEX icl_ac_campo ON cl_actualiza
(
    ac_campo ASC
) ON indexgroup
go

print '=====> cl_actlegal_conv_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_actlegal_conv_Key ON cl_actlegal_conv
(
    alc_tipo_documento ,
    alc_secuencial
) ON indexgroup
go



print '=====> cl_actente_conv_key'
go
CREATE NONCLUSTERED INDEX cl_actente_conv_key ON cl_actente_conv
(
    aac_tipo_persona ASC,
    aac_tipo_documento ASC,
    aac_numero_documento ASC,
    aac_tipo_transaccion ASC
) ON indexgroup
go

print '=====> cl_actente_conv_key2'
go
CREATE NONCLUSTERED INDEX cl_actente_conv_key2 ON cl_actente_conv
(
    aac_tipo_documento ASC,
    aac_numero_documento ASC
) ON indexgroup
go

print '=====> cl_actdirpro_conv_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_actdirpro_conv_Key ON cl_actdirpro_conv
(
    adc_dirpro_codigo_ente ,
    adc_tipo_producto
) ON indexgroup
go
print '=====> cl_actdir_conv_key'
go
CREATE UNIQUE CLUSTERED INDEX cl_actdir_conv_key ON cl_actdir_conv
(
    adc_secuencial ASC,
    adc_numero_documento ASC,
    adc_tipo_documento ASC
) ON indexgroup
go

print '=====> cl_actbalance_conv_Key'
CREATE UNIQUE CLUSTERED INDEX cl_actbalance_conv_Key ON cl_actbalance_conv
(
    abc_secuencial,
    abc_tipo_balance
) ON indexgroup
go


print '=====> cl_fecha_tipo_doc_Key'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_fecha_tipo_doc_Key ON cl_fecha_tipo_doc
(
   ct_codigo, ct_sexo, ct_signo
) ON indexgroup
go

print '=====> ix1_cl_referenciacion'
go
CREATE UNIQUE NONCLUSTERED INDEX ix1_cl_referenciacion ON cl_referenciacion
(
   re_producto, re_tipo_persona, re_grupo_info
) ON indexgroup
go

print '=====> cl_alianza_key'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_alianza_key ON cl_alianza
(
    al_alianza
) ON indexgroup
go

print '=====> cl_alianza_cliente_key'
go
CREATE UNIQUE NONCLUSTERED INDEX cl_alianza_cliente_key ON cl_alianza_cliente
(
    ac_alianza,
    ac_ente
) ON indexgroup
go

print '=====> id1_as'
go
CREATE NONCLUSTERED INDEX id1_as ON cl_autoriza_sarlaft_lista
(
    as_nro_id,
    as_valida_total,
    as_origen_refinh
) ON indexgroup
go



print '=====> id1_asl'
go
CREATE NONCLUSTERED INDEX id1_asl ON cl_autoriza_sarlaft_lista
(
    as_sec_refinh
) ON indexgroup
go

print '=====> ix_negocio_cliente'
go
create nonclustered index ix_negocio_cliente on cl_negocio_cliente
(
    nc_codigo,
    nc_ente
) on indexgroup
go

print '=====> ix_ts_negocio_cliente'
go
create nonclustered index ix_ts_negocio_cliente on ts_negocio_cliente
(
    ts_codigo,
    ts_ente,
    ts_usuario
) on indexgroup
go
