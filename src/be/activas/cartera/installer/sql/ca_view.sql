USE cob_cartera
GO

IF OBJECT_ID ('dbo.vw_planilla_fag') IS NOT NULL
	DROP VIEW dbo.vw_planilla_fag
GO

create view vw_planilla_fag
as
select df_certificado,
       df_llave_redescuento,
       en_nomlar,
       en_ced_ruc,
       df_pagare,
       df_plazo,
       df_gracia_cap,
       convert(varchar, df_fecha_ini,101) df_fecha_ini,
       df_valor_credito,
       df_porc_cobertura,
       df_valor_garantia,
       df_porc_comision,
       df_valor_comision,
       df_valor_iva,
       df_valor_comision + df_valor_iva dt_total,
       df_oficina,
       codigo_sib
from ca_desembolso_fag_tmp, cobis..cl_ente, cob_credito..cr_corresp_sib
where en_ente = df_cliente
and   tabla = 'T21'
and   codigo = convert(varchar, df_regional)

GO

IF OBJECT_ID ('dbo.vw_maestro_operaciones') IS NOT NULL
	DROP VIEW dbo.vw_maestro_operaciones
GO

create view vw_maestro_operaciones
as
select ca_maestro_operaciones.mo_fecha_de_proceso, ca_maestro_operaciones.mo_producto, ca_maestro_operaciones.mo_tipo_de_producto, ca_maestro_operaciones.mo_moneda, ca_maestro_operaciones.mo_numero_de_operacion, ca_maestro_operaciones.mo_numero_de_banco, ca_maestro_operaciones.mo_numero_migrada, ca_maestro_operaciones.mo_cliente, ca_maestro_operaciones.mo_nombre_cliente, ca_maestro_operaciones.mo_cupo_credito, ca_maestro_operaciones.mo_oficina, ca_maestro_operaciones.mo_nombre_oficina, ca_maestro_operaciones.mo_dias_causados, ca_maestro_operaciones.mo_monto, ca_maestro_operaciones.mo_monto_desembolso, ca_maestro_operaciones.mo_tasa, ca_maestro_operaciones.mo_tasa_efectiva, ca_maestro_operaciones.mo_plazo_total, ca_maestro_operaciones.mo_modalidad_cobro_int, ca_maestro_operaciones.mo_fecha_inicio_op, ca_maestro_operaciones.mo_fecha_ven_op, ca_maestro_operaciones.mo_dias_vencido_op, ca_maestro_operaciones.mo_fecha_fin_min_div_ven, ca_maestro_operaciones.mo_reestructurada, ca_maestro_operaciones.mo_fecha_ult_reest, ca_maestro_operaciones.mo_num_reestructuraciones, ca_maestro_operaciones.mo_num_cuotas_pagadas, ca_maestro_operaciones.mo_num_cuotas_pagadas_reest, ca_maestro_operaciones.mo_destino_credito, ca_maestro_operaciones.mo_clase_cartera, ca_maestro_operaciones.mo_ciudad, ca_maestro_operaciones.mo_fecha_prox_vencimiento, ca_maestro_operaciones.mo_saldo_cuota_prox_venc, ca_maestro_operaciones.mo_saldo_capital_vigente, ca_maestro_operaciones.mo_saldo_capital_vencido, ca_maestro_operaciones.mo_saldo_interes_vigente, ca_maestro_operaciones.mo_saldo_interes_vencido, ca_maestro_operaciones.mo_saldo_interes_contingente, ca_maestro_operaciones.mo_saldo_mora_vigente, ca_maestro_operaciones.mo_saldo_mora_contingente, ca_maestro_operaciones.mo_saldo_seguro_vida_vigente, ca_maestro_operaciones.mo_saldo_seguro_vida_vencido, ca_maestro_operaciones.mo_saldo_otros_vigente, ca_maestro_operaciones.mo_saldo_otros_vencidos, ca_maestro_operaciones.mo_estado_obligacion, ca_maestro_operaciones.mo_calificacion_obligacion,
ca_maestro_operaciones.mo_frecuencia_pago_int, ca_maestro_operaciones.mo_frecuencia_pago_cap, ca_maestro_operaciones.mo_edad_vencimiento_cartera, ca_maestro_operaciones.mo_fecha_ult_pago, ca_maestro_operaciones.mo_valor_ult_pago, ca_maestro_operaciones.mo_fecha_ult_pago_cap, ca_maestro_operaciones.mo_valor_ult_pago_cap, ca_maestro_operaciones.mo_valor_cuota_tabla, ca_maestro_operaciones.mo_numero_cuotas_pactadas, ca_maestro_operaciones.mo_numero_cuotas_vencidas, ca_maestro_operaciones.mo_clase_garantia, ca_maestro_operaciones.mo_tipo_garantia, ca_maestro_operaciones.mo_descripcion_tipo_garantia, ca_maestro_operaciones.mo_fecha_castigo, ca_maestro_operaciones.mo_numero_comex, ca_maestro_operaciones.mo_numero_deuda_externa, ca_maestro_operaciones.mo_fecha_embarque, ca_maestro_operaciones.mo_fecha_dex, ca_maestro_operaciones.mo_tipo_tasa, ca_maestro_operaciones.mo_tasa_referencial, ca_maestro_operaciones.mo_signo, ca_maestro_operaciones.mo_factor, ca_maestro_operaciones.mo_tipo_identificacion, ca_maestro_operaciones.mo_numero_identificacion, ca_maestro_operaciones.mo_provision_cap, ca_maestro_operaciones.mo_provision_int, ca_maestro_operaciones.mo_provision_cxc, ca_maestro_operaciones.mo_cuenta_asociada, ca_maestro_operaciones.mo_forma_de_pago, ca_maestro_operaciones.mo_tipo_tabla, ca_maestro_operaciones.mo_periodo_gracia_cap, ca_maestro_operaciones.mo_periodo_gracia_int, ca_maestro_operaciones.mo_estado_cobranza, ca_maestro_operaciones.mo_descripcion_estado_cobranza, ca_maestro_operaciones.mo_tasa_representativa_mercado, ca_maestro_operaciones.mo_reajustable, ca_maestro_operaciones.mo_descripcion_reajustable, ca_maestro_operaciones.mo_periodo_reajuste, ca_maestro_operaciones.mo_fecha_prox_reajuste, ca_maestro_operaciones.mo_fecha_ult_proceso, ca_maestro_operaciones.mo_tipo_soc, ca_maestro_operaciones.mo_tipo_puntos, ca_maestro_operaciones.mo_cobertura_garantia, ca_maestro_operaciones.mo_des_tipo_bien, ca_maestro_operaciones.mo_tramite, ca_maestro_operaciones.mo_defecto_garantia, ca_maestro_operaciones.mo_modalidad,
ca_maestro_operaciones.mo_clausula, ca_maestro_operaciones.mo_naturaleza_linea, ca_maestro_operaciones.mo_tiene_seg_vida, ca_maestro_operaciones.mo_tiene_seg_vehiculo, ca_maestro_operaciones.mo_tiene_seg_todor_maq, ca_maestro_operaciones.mo_tiene_seg_rotura_maq, ca_maestro_operaciones.mo_tiene_seg_vivienda, ca_maestro_operaciones.mo_tiene_seg_extraprima, ca_maestro_operaciones.mo_tiene_incentivo, ca_maestro_operaciones.mo_tipo_banca, ca_maestro_operaciones.mo_nombre_codeudor, ca_maestro_operaciones.mo_ced_ruc_codeudor, ca_maestro_operaciones.mo_zona, ca_maestro_operaciones.mo_regional, ca_maestro_operaciones.mo_capitaliza, ca_maestro_operaciones.mo_tipo_productor, ca_maestro_operaciones.mo_mercado_obj, ca_maestro_operaciones.mo_aprobador, ca_maestro_operaciones.mo_llave_redescuento, ca_maestro_operaciones.mo_condonacion_intereses, ca_maestro_operaciones.mo_condonacion_capital, ca_maestro_operaciones.mo_provision_defecto, ca_maestro_operaciones.mo_margen_redescuento, ca_maestro_operaciones.mo_codigo_sector, ca_maestro_operaciones.mo_dias_base, ca_maestro_operaciones.mo_provisiona_cap, ca_maestro_operaciones.mo_provisiona_int, ca_maestro_operaciones.mo_provisiona_cxc
from ca_maestro_operaciones
where mo_fecha_de_proceso = '04/30/2004'

GO

IF OBJECT_ID ('dbo.cl_tabla_cca') IS NOT NULL
	DROP VIEW dbo.cl_tabla_cca
GO

create view cl_tabla_cca as
select * 
from cobis..cl_tabla 
where tabla like 'ca_%'

GO

IF OBJECT_ID ('dbo.cl_parametro_cca') IS NOT NULL
	DROP VIEW dbo.cl_parametro_cca
GO

create view cl_parametro_cca as
select * 
from cobis..cl_parametro 
where pa_producto = 'CCA'

GO

IF OBJECT_ID ('dbo.cl_catalogo_pro_cca') IS NOT NULL
	DROP VIEW dbo.cl_catalogo_pro_cca
GO

create view cl_catalogo_pro_cca as
select c.* 
from cobis..cl_tabla t, cobis..cl_catalogo_pro c 
where t.codigo = c.cp_tabla 
and t.tabla like 'ca_%'

GO

IF OBJECT_ID ('dbo.cl_catalogo_cca') IS NOT NULL
	DROP VIEW dbo.cl_catalogo_cca
GO

create view cl_catalogo_cca as
select c.* 
from cobis..cl_tabla t, cobis..cl_catalogo c 
where t.codigo = c.tabla 
and t.tabla like 'ca_%'

GO

IF OBJECT_ID ('dbo.cb_cotiz_mon_fechamax') IS NOT NULL
	DROP VIEW dbo.cb_cotiz_mon_fechamax
GO

create view cb_cotiz_mon_fechamax (
	cv_moneda, 
	cv_fecha_max
)
as
select  ct_moneda, 
	max(ct_fecha)
from cob_conta..cb_cotizacion, cobis..ba_fecha_proceso
where ct_fecha <= fp_fecha
group by ct_moneda

GO

IF OBJECT_ID ('dbo.ca_transaccion_bc') IS NOT NULL
	DROP VIEW dbo.ca_transaccion_bc
GO

create view ca_transaccion_bc
as
select t.tr_secuencial, t.tr_fecha_mov, t.tr_toperacion, t.tr_moneda, t.tr_operacion, t.tr_tran, t.tr_en_linea, t.tr_banco, t.tr_dias_calc, t.tr_ofi_oper, t.tr_ofi_usu, t.tr_usuario, t.tr_terminal, t.tr_fecha_ref, t.tr_secuencial_ref, t.tr_estado, t.tr_observacion, t.tr_gerente, t.tr_comprobante, t.tr_fecha_cont, t.tr_gar_admisible, t.tr_reestructuracion, t.tr_calificacion
from ca_transaccion t, oper_bcafe
where tr_operacion = oper

GO

IF OBJECT_ID ('dbo.ca_tasas_bc') IS NOT NULL
	DROP VIEW dbo.ca_tasas_bc
GO

create view ca_tasas_bc
as
select t.ts_operacion, t.ts_dividendo, t.ts_fecha, t.ts_concepto, t.ts_porcentaje, t.ts_secuencial, t.ts_porcentaje_efa, t.ts_referencial, t.ts_signo, t.ts_factor
from ca_tasas t, oper_bcafe
where ts_operacion = oper

GO

IF OBJECT_ID ('dbo.ca_secuenciales_bc') IS NOT NULL
	DROP VIEW dbo.ca_secuenciales_bc
GO

create view ca_secuenciales_bc
as
select t.se_operacion, t.se_secuencial
from ca_secuenciales t, oper_bcafe
where se_operacion = oper

GO

IF OBJECT_ID ('dbo.ca_rubro_op_his_bc') IS NOT NULL
	DROP VIEW dbo.ca_rubro_op_his_bc
GO

create view ca_rubro_op_his_bc
as
select t.roh_secuencial, t.roh_operacion, t.roh_concepto, t.roh_tipo_rubro, t.roh_fpago, t.roh_prioridad, t.roh_paga_mora, t.roh_provisiona, t.roh_signo, t.roh_factor, t.roh_referencial, t.roh_signo_reajuste, t.roh_factor_reajuste, t.roh_referencial_reajuste, t.roh_valor, t.roh_porcentaje, t.roh_porcentaje_aux, t.roh_gracia, t.roh_concepto_asociado, t.roh_redescuento, t.roh_intermediacion, t.roh_principal, t.roh_porcentaje_efa, t.roh_garantia, t.roh_tipo_puntos, t.roh_saldo_op, t.roh_saldo_por_desem, t.roh_base_calculo, t.roh_num_dec, t.roh_limite, t.roh_iva_siempre, t.roh_monto_aprobado, t.roh_porcentaje_cobrar, t.roh_tipo_garantia, t.roh_nro_garantia, t.roh_porcentaje_cobertura, t.roh_valor_garantia, t.roh_tperiodo, t.roh_periodo, t.roh_tabla, t.roh_saldo_insoluto, t.roh_calcular_devolucion
from ca_rubro_op_his t, oper_bcafe
where roh_operacion = oper

GO

IF OBJECT_ID ('dbo.ca_rubro_op_bc') IS NOT NULL
	DROP VIEW dbo.ca_rubro_op_bc
GO

create view ca_rubro_op_bc
as
select t.ro_operacion, t.ro_concepto, t.ro_tipo_rubro, t.ro_fpago, t.ro_prioridad, t.ro_paga_mora, t.ro_provisiona, t.ro_signo, t.ro_factor, t.ro_referencial, t.ro_signo_reajuste, t.ro_factor_reajuste, t.ro_referencial_reajuste, t.ro_valor, t.ro_porcentaje, t.ro_porcentaje_aux, t.ro_gracia, t.ro_concepto_asociado, t.ro_redescuento, t.ro_intermediacion, t.ro_principal, t.ro_porcentaje_efa, t.ro_garantia, t.ro_tipo_puntos, t.ro_saldo_op, t.ro_saldo_por_desem, t.ro_base_calculo, t.ro_num_dec, t.ro_limite, t.ro_iva_siempre, t.ro_monto_aprobado, t.ro_porcentaje_cobrar, t.ro_tipo_garantia, t.ro_nro_garantia, t.ro_porcentaje_cobertura, t.ro_valor_garantia, t.ro_tperiodo, t.ro_periodo, t.ro_tabla, t.ro_saldo_insoluto, t.ro_calcular_devolucion
from ca_rubro_op t, oper_bcafe
where ro_operacion = oper

GO

IF OBJECT_ID ('dbo.ca_reajuste_det_bc') IS NOT NULL
	DROP VIEW dbo.ca_reajuste_det_bc
GO

create view ca_reajuste_det_bc
as
select t.red_secuencial, t.red_operacion, t.red_concepto, t.red_referencial, t.red_signo, t.red_factor, t.red_porcentaje
from ca_reajuste_det t, oper_bcafe
where red_operacion = oper

GO

IF OBJECT_ID ('dbo.ca_reajuste_bc') IS NOT NULL
	DROP VIEW dbo.ca_reajuste_bc
GO

create view ca_reajuste_bc
as
select t.re_secuencial, t.re_operacion, t.re_fecha, t.re_reajuste_especial, t.re_desagio
from ca_reajuste t, oper_bcafe
where re_operacion = oper

GO

IF OBJECT_ID ('dbo.ca_operacion_his_bc') IS NOT NULL
	DROP VIEW dbo.ca_operacion_his_bc
GO

create view ca_operacion_his_bc
as
select t.oph_secuencial, t.oph_operacion, t.oph_banco, t.oph_anterior, t.oph_migrada, t.oph_tramite, t.oph_cliente, t.oph_nombre, t.oph_sector, t.oph_toperacion, t.oph_oficina, t.oph_moneda, t.oph_comentario, t.oph_oficial, t.oph_fecha_ini, t.oph_fecha_fin, t.oph_fecha_ult_proceso, t.oph_fecha_liq, t.oph_fecha_reajuste, t.oph_monto, t.oph_monto_aprobado, t.oph_destino, t.oph_lin_credito, t.oph_ciudad, t.oph_estado, t.oph_periodo_reajuste, t.oph_reajuste_especial, t.oph_tipo, t.oph_forma_pago, t.oph_cuenta, t.oph_dias_anio, t.oph_tipo_amortizacion, t.oph_cuota_completa, t.oph_tipo_cobro, t.oph_tipo_reduccion, t.oph_aceptar_anticipos, t.oph_precancelacion, t.oph_tipo_aplicacion, t.oph_tplazo, t.oph_plazo, t.oph_tdividendo, t.oph_periodo_cap, t.oph_periodo_int, t.oph_dist_gracia, t.oph_gracia_cap, t.oph_gracia_int, t.oph_dia_fijo, t.oph_cuota, t.oph_evitar_feriados, t.oph_num_renovacion, t.oph_renovacion, t.oph_mes_gracia, t.oph_reajustable, t.oph_dias_clausula, t.oph_divcap_original, t.oph_clausula_aplicada, t.oph_traslado_ingresos, t.oph_periodo_crecimiento, t.oph_tasa_crecimiento, t.oph_direccion, t.oph_opcion_cap, t.oph_tasa_cap, t.oph_dividendo_cap, t.oph_clase, t.oph_origen_fondos, t.oph_calificacion, t.oph_estado_cobranza, t.oph_numero_reest, t.oph_edad, t.oph_tipo_crecimiento, t.oph_base_calculo, t.oph_prd_cobis, t.oph_ref_exterior, t.oph_sujeta_nego, t.oph_dia_habil, t.oph_recalcular_plazo, t.oph_usar_tequivalente, t.oph_fondos_propios, t.oph_nro_red, t.oph_tipo_redondeo, t.oph_sal_pro_pon, t.oph_tipo_empresa, t.oph_validacion, t.oph_fecha_pri_cuot, t.oph_gar_admisible, t.oph_causacion, t.oph_convierte_tasa, t.oph_grupo_fact, t.oph_tramite_ficticio, t.oph_tipo_linea, t.oph_subtipo_linea, t.oph_bvirtual, t.oph_extracto, t.oph_num_deuda_ext, t.oph_fecha_embarque, t.oph_fecha_dex, t.oph_reestructuracion, t.oph_tipo_cambio, t.oph_naturaleza, t.oph_pago_caja, t.oph_nace_vencida, t.oph_num_comex, t.oph_calcula_devolucion, t.oph_codigo_externo, t.oph_margen_redescuento, t.oph_entidad_convenio,
t.oph_pproductor, t.oph_fecha_ult_causacion, t.oph_mora_retroactiva, t.oph_calificacion_ant, t.oph_cap_susxcor, t.oph_prepago_desde_lavigente, t.oph_fecha_ult_mov, t.oph_fecha_prox_segven, t.oph_suspendio, t.oph_fecha_suspenso
from ca_operacion_his t, oper_bcafe
where oph_operacion = oper

GO

IF OBJECT_ID ('dbo.ca_operacion_bc') IS NOT NULL
	DROP VIEW dbo.ca_operacion_bc
GO

create view ca_operacion_bc
as
select t.op_operacion, t.op_banco, t.op_anterior, t.op_migrada, t.op_tramite, t.op_cliente, t.op_nombre, t.op_sector, t.op_toperacion, t.op_oficina, t.op_moneda, t.op_comentario, t.op_oficial, t.op_fecha_ini, t.op_fecha_fin, t.op_fecha_ult_proceso, t.op_fecha_liq, t.op_fecha_reajuste, t.op_monto, t.op_monto_aprobado, t.op_destino, t.op_lin_credito, t.op_ciudad, t.op_estado, t.op_periodo_reajuste, t.op_reajuste_especial, t.op_tipo, t.op_forma_pago, t.op_cuenta, t.op_dias_anio, t.op_tipo_amortizacion, t.op_cuota_completa, t.op_tipo_cobro, t.op_tipo_reduccion, t.op_aceptar_anticipos, t.op_precancelacion, t.op_tipo_aplicacion, t.op_tplazo, t.op_plazo, t.op_tdividendo, t.op_periodo_cap, t.op_periodo_int, t.op_dist_gracia, t.op_gracia_cap, t.op_gracia_int, t.op_dia_fijo, t.op_cuota, t.op_evitar_feriados, t.op_num_renovacion, t.op_renovacion, t.op_mes_gracia, t.op_reajustable, t.op_dias_clausula, t.op_divcap_original, t.op_clausula_aplicada, t.op_traslado_ingresos, t.op_periodo_crecimiento, t.op_tasa_crecimiento, t.op_direccion, t.op_opcion_cap, t.op_tasa_cap, t.op_dividendo_cap, t.op_clase, t.op_origen_fondos, t.op_calificacion, t.op_estado_cobranza, t.op_numero_reest, t.op_edad, t.op_tipo_crecimiento, t.op_base_calculo, t.op_prd_cobis, t.op_ref_exterior, t.op_sujeta_nego, t.op_dia_habil, t.op_recalcular_plazo, t.op_usar_tequivalente, t.op_fondos_propios, t.op_nro_red, t.op_tipo_redondeo, t.op_sal_pro_pon, t.op_tipo_empresa, t.op_validacion, t.op_fecha_pri_cuot, t.op_gar_admisible, t.op_causacion, t.op_convierte_tasa, t.op_grupo_fact, t.op_tramite_ficticio, t.op_tipo_linea, t.op_subtipo_linea, t.op_bvirtual, t.op_extracto, t.op_num_deuda_ext, t.op_fecha_embarque, t.op_fecha_dex, t.op_reestructuracion, t.op_tipo_cambio, t.op_naturaleza, t.op_pago_caja, t.op_nace_vencida, t.op_num_comex, t.op_calcula_devolucion, t.op_codigo_externo, t.op_margen_redescuento, t.op_entidad_convenio, t.op_pproductor, t.op_fecha_ult_causacion, t.op_mora_retroactiva, t.op_calificacion_ant, t.op_cap_susxcor, t.op_prepago_desde_lavigente,
t.op_fecha_ult_mov, t.op_fecha_prox_segven, t.op_suspendio, t.op_fecha_suspenso
from ca_operacion t, oper_bcafe
where op_operacion = oper

GO

IF OBJECT_ID ('dbo.ca_maestro_datos_dia_fmes') IS NOT NULL
	DROP VIEW dbo.ca_maestro_datos_dia_fmes
GO

create view ca_maestro_datos_dia_fmes as
select cob_cartera..ca_maestro_operaciones.mo_fecha_de_proceso, cob_cartera..ca_maestro_operaciones.mo_producto, cob_cartera..ca_maestro_operaciones.mo_tipo_de_producto, cob_cartera..ca_maestro_operaciones.mo_moneda, cob_cartera..ca_maestro_operaciones.mo_numero_de_operacion, cob_cartera..ca_maestro_operaciones.mo_numero_de_banco, cob_cartera..ca_maestro_operaciones.mo_numero_migrada, cob_cartera..ca_maestro_operaciones.mo_cliente, cob_cartera..ca_maestro_operaciones.mo_nombre_cliente, cob_cartera..ca_maestro_operaciones.mo_cupo_credito, cob_cartera..ca_maestro_operaciones.mo_oficina, cob_cartera..ca_maestro_operaciones.mo_nombre_oficina, cob_cartera..ca_maestro_operaciones.mo_dias_causados, cob_cartera..ca_maestro_operaciones.mo_monto, cob_cartera..ca_maestro_operaciones.mo_monto_desembolso, cob_cartera..ca_maestro_operaciones.mo_tasa, cob_cartera..ca_maestro_operaciones.mo_tasa_efectiva, cob_cartera..ca_maestro_operaciones.mo_plazo_total, cob_cartera..ca_maestro_operaciones.mo_modalidad_cobro_int, cob_cartera..ca_maestro_operaciones.mo_fecha_inicio_op, cob_cartera..ca_maestro_operaciones.mo_fecha_ven_op, cob_cartera..ca_maestro_operaciones.mo_dias_vencido_op, cob_cartera..ca_maestro_operaciones.mo_fecha_fin_min_div_ven, cob_cartera..ca_maestro_operaciones.mo_reestructurada, cob_cartera..ca_maestro_operaciones.mo_fecha_ult_reest, cob_cartera..ca_maestro_operaciones.mo_num_reestructuraciones, cob_cartera..ca_maestro_operaciones.mo_num_cuotas_pagadas, cob_cartera..ca_maestro_operaciones.mo_num_cuotas_pagadas_reest, cob_cartera..ca_maestro_operaciones.mo_destino_credito, cob_cartera..ca_maestro_operaciones.mo_clase_cartera, cob_cartera..ca_maestro_operaciones.mo_ciudad, cob_cartera..ca_maestro_operaciones.mo_fecha_prox_vencimiento, cob_cartera..ca_maestro_operaciones.mo_saldo_cuota_prox_venc, cob_cartera..ca_maestro_operaciones.mo_saldo_capital_vigente, cob_cartera..ca_maestro_operaciones.mo_saldo_capital_vencido, cob_cartera..ca_maestro_operaciones.mo_saldo_interes_vigente,
cob_cartera..ca_maestro_operaciones.mo_saldo_interes_vencido, cob_cartera..ca_maestro_operaciones.mo_saldo_interes_contingente, cob_cartera..ca_maestro_operaciones.mo_saldo_mora_vigente, cob_cartera..ca_maestro_operaciones.mo_saldo_mora_contingente, cob_cartera..ca_maestro_operaciones.mo_saldo_seguro_vida_vigente, cob_cartera..ca_maestro_operaciones.mo_saldo_seguro_vida_vencido, cob_cartera..ca_maestro_operaciones.mo_saldo_otros_vigente, cob_cartera..ca_maestro_operaciones.mo_saldo_otros_vencidos, cob_cartera..ca_maestro_operaciones.mo_estado_obligacion, cob_cartera..ca_maestro_operaciones.mo_calificacion_obligacion, cob_cartera..ca_maestro_operaciones.mo_frecuencia_pago_int, cob_cartera..ca_maestro_operaciones.mo_frecuencia_pago_cap, cob_cartera..ca_maestro_operaciones.mo_edad_vencimiento_cartera, cob_cartera..ca_maestro_operaciones.mo_fecha_ult_pago, cob_cartera..ca_maestro_operaciones.mo_valor_ult_pago, cob_cartera..ca_maestro_operaciones.mo_fecha_ult_pago_cap, cob_cartera..ca_maestro_operaciones.mo_valor_ult_pago_cap, cob_cartera..ca_maestro_operaciones.mo_valor_cuota_tabla, cob_cartera..ca_maestro_operaciones.mo_numero_cuotas_pactadas, cob_cartera..ca_maestro_operaciones.mo_numero_cuotas_vencidas, cob_cartera..ca_maestro_operaciones.mo_clase_garantia, cob_cartera..ca_maestro_operaciones.mo_tipo_garantia, cob_cartera..ca_maestro_operaciones.mo_descripcion_tipo_garantia, cob_cartera..ca_maestro_operaciones.mo_fecha_castigo, cob_cartera..ca_maestro_operaciones.mo_numero_comex, cob_cartera..ca_maestro_operaciones.mo_numero_deuda_externa, cob_cartera..ca_maestro_operaciones.mo_fecha_embarque, cob_cartera..ca_maestro_operaciones.mo_fecha_dex, cob_cartera..ca_maestro_operaciones.mo_tipo_tasa, cob_cartera..ca_maestro_operaciones.mo_tasa_referencial, cob_cartera..ca_maestro_operaciones.mo_signo, cob_cartera..ca_maestro_operaciones.mo_factor, cob_cartera..ca_maestro_operaciones.mo_tipo_identificacion, cob_cartera..ca_maestro_operaciones.mo_numero_identificacion, cob_cartera..ca_maestro_operaciones.mo_provision_cap,
cob_cartera..ca_maestro_operaciones.mo_provision_int, cob_cartera..ca_maestro_operaciones.mo_provision_cxc, cob_cartera..ca_maestro_operaciones.mo_cuenta_asociada, cob_cartera..ca_maestro_operaciones.mo_forma_de_pago, cob_cartera..ca_maestro_operaciones.mo_tipo_tabla, cob_cartera..ca_maestro_operaciones.mo_periodo_gracia_cap, cob_cartera..ca_maestro_operaciones.mo_periodo_gracia_int, cob_cartera..ca_maestro_operaciones.mo_estado_cobranza, cob_cartera..ca_maestro_operaciones.mo_descripcion_estado_cobranza, cob_cartera..ca_maestro_operaciones.mo_tasa_representativa_mercado, cob_cartera..ca_maestro_operaciones.mo_reajustable, cob_cartera..ca_maestro_operaciones.mo_descripcion_reajustable, cob_cartera..ca_maestro_operaciones.mo_periodo_reajuste, cob_cartera..ca_maestro_operaciones.mo_fecha_prox_reajuste, cob_cartera..ca_maestro_operaciones.mo_fecha_ult_proceso, cob_cartera..ca_maestro_operaciones.mo_tipo_soc, cob_cartera..ca_maestro_operaciones.mo_tipo_puntos, cob_cartera..ca_maestro_operaciones.mo_cobertura_garantia, cob_cartera..ca_maestro_operaciones.mo_des_tipo_bien, cob_cartera..ca_maestro_operaciones.mo_tramite, cob_cartera..ca_maestro_operaciones.mo_defecto_garantia, cob_cartera..ca_maestro_operaciones.mo_modalidad, cob_cartera..ca_maestro_operaciones.mo_clausula, cob_cartera..ca_maestro_operaciones.mo_naturaleza_linea, cob_cartera..ca_maestro_operaciones.mo_tiene_seg_vida, cob_cartera..ca_maestro_operaciones.mo_tiene_seg_vehiculo, cob_cartera..ca_maestro_operaciones.mo_tiene_seg_todor_maq, cob_cartera..ca_maestro_operaciones.mo_tiene_seg_rotura_maq, cob_cartera..ca_maestro_operaciones.mo_tiene_seg_vivienda, cob_cartera..ca_maestro_operaciones.mo_tiene_seg_extraprima, cob_cartera..ca_maestro_operaciones.mo_tiene_incentivo, cob_cartera..ca_maestro_operaciones.mo_tipo_banca, cob_cartera..ca_maestro_operaciones.mo_nombre_codeudor, cob_cartera..ca_maestro_operaciones.mo_ced_ruc_codeudor, cob_cartera..ca_maestro_operaciones.mo_zona, cob_cartera..ca_maestro_operaciones.mo_regional, cob_cartera..ca_maestro_operaciones.mo_capitaliza,
cob_cartera..ca_maestro_operaciones.mo_tipo_productor, cob_cartera..ca_maestro_operaciones.mo_mercado_obj, cob_cartera..ca_maestro_operaciones.mo_aprobador, cob_cartera..ca_maestro_operaciones.mo_llave_redescuento, cob_cartera..ca_maestro_operaciones.mo_condonacion_intereses, cob_cartera..ca_maestro_operaciones.mo_condonacion_capital, cob_cartera..ca_maestro_operaciones.mo_provision_defecto, cob_cartera..ca_maestro_operaciones.mo_margen_redescuento, cob_cartera..ca_maestro_operaciones.mo_codigo_sector, cob_cartera..ca_maestro_operaciones.mo_dias_base, cob_cartera..ca_maestro_operaciones.mo_provisiona_cap, cob_cartera..ca_maestro_operaciones.mo_provisiona_int, cob_cartera..ca_maestro_operaciones.mo_provisiona_cxc, cob_cartera..ca_maestro_operaciones.mo_norma_legal, cob_cartera..ca_maestro_operaciones.mo_ind_aprob, cob_cartera..ca_maestro_operaciones.mo_cap_diferido, cob_cartera..ca_maestro_operaciones.mo_int_imo_diferido
from cob_cartera..ca_maestro_operaciones
WHERE mo_fecha_de_proceso in (select fe_fecha from cob_cartera..ca_fecha)

GO

IF OBJECT_ID ('dbo.ca_dividendo_his_bc') IS NOT NULL
	DROP VIEW dbo.ca_dividendo_his_bc
GO

create view ca_dividendo_his_bc
as
select t.dih_secuencial, t.dih_operacion, t.dih_dividendo, t.dih_fecha_ini, t.dih_fecha_ven, t.dih_de_capital, t.dih_de_interes, t.dih_gracia, t.dih_gracia_disp, t.dih_estado, t.dih_dias_cuota, t.dih_intento, t.dih_prorroga, t.dih_fecha_can
from ca_dividendo_his t, oper_bcafe
where dih_operacion = oper

GO

IF OBJECT_ID ('dbo.ca_dividendo_bc') IS NOT NULL
	DROP VIEW dbo.ca_dividendo_bc
GO

create view ca_dividendo_bc
as
select t.di_operacion, t.di_dividendo,   t.di_fecha_ini, 
       t.di_fecha_ven, t.di_de_capital,  t.di_de_interes, 
       t.di_gracia,    t.di_gracia_disp, t.di_estado, 
       t.di_dias_cuota, t.di_intento,    t.di_prorroga, 
       t.di_fecha_can
from ca_dividendo t, oper_bcafe
where di_operacion = oper

GO

IF OBJECT_ID ('dbo.ca_det_trn_bc') IS NOT NULL
	DROP VIEW dbo.ca_det_trn_bc
GO

create view ca_det_trn_bc
as
select t.dtr_secuencial, t.dtr_operacion, t.dtr_dividendo, 
       t.dtr_concepto,   t.dtr_estado,    t.dtr_periodo, 
       t.dtr_codvalor,   t.dtr_monto,     t.dtr_monto_mn, 
       t.dtr_moneda,     t.dtr_cotizacion, t.dtr_tcotizacion, 
       t.dtr_afectacion, t.dtr_cuenta,    t.dtr_beneficiario, 
       t.dtr_monto_cont
from ca_det_trn t, oper_bcafe
where dtr_operacion = oper

GO

IF OBJECT_ID ('dbo.ca_desembolso_bc') IS NOT NULL
	DROP VIEW dbo.ca_desembolso_bc
GO

create view ca_desembolso_bc
as
select t.dm_secuencial, t.dm_operacion, t.dm_desembolso,
	   t.dm_producto,   t.dm_cuenta,    t.dm_beneficiario, 
	   t.dm_oficina_chg, t.dm_usuario,  t.dm_oficina,
	   t.dm_terminal,   t.dm_dividendo, t.dm_moneda, 
	   t.dm_monto_mds,  t.dm_monto_mop, t.dm_monto_mn, 
	   t.dm_cotizacion_mds, t.dm_cotizacion_mop, t.dm_tcotizacion_mds, 
	   t.dm_tcotizacion_mop, t.dm_estado, t.dm_cod_banco,
	   t.dm_cheque,     t.dm_fecha,     t.dm_prenotificacion,
	   t.dm_carga,      t.dm_concepto,  t.dm_valor
from   ca_desembolso t, oper_bcafe
where  dm_operacion = oper

GO

IF OBJECT_ID ('dbo.ca_codvalor_rubro') IS NOT NULL
	DROP VIEW dbo.ca_codvalor_rubro
GO

CREATE VIEW ca_codvalor_rubro 
as
select 
co_concepto, es_descripcion, cr_codvalor=co_codigo * 100 + es_codigo
from ca_concepto, ca_estado

GO

IF OBJECT_ID ('dbo.ca_amortizacion_his_bc') IS NOT NULL
	DROP VIEW dbo.ca_amortizacion_his_bc
GO

create view ca_amortizacion_his_bc
as
select t.amh_secuencial, t.amh_operacion, t.amh_dividendo, t.amh_concepto, t.amh_estado, t.amh_periodo, t.amh_cuota, t.amh_gracia, t.amh_pagado, t.amh_acumulado, t.amh_secuencia
from ca_amortizacion_his t, oper_bcafe
where amh_operacion = oper

GO

IF OBJECT_ID ('dbo.ca_amortizacion_bc') IS NOT NULL
	DROP VIEW dbo.ca_amortizacion_bc
GO

create view ca_amortizacion_bc
as
select t.am_operacion, t.am_dividendo, t.am_concepto, t.am_estado, t.am_periodo, t.am_cuota, t.am_gracia, t.am_pagado, t.am_acumulado, t.am_secuencia
from ca_amortizacion t, oper_bcafe
where am_operacion = oper

GO

IF OBJECT_ID ('dbo.ca_acciones_bc') IS NOT NULL
	DROP VIEW dbo.ca_acciones_bc
GO

-- Identifies check constraints

 create view [dbo].[ca_acciones_bc]
as
select t.ac_operacion, t.ac_div_ini, t.ac_div_fin, t.ac_rubro, t.ac_valor, t.ac_porcentaje, t.ac_divf_ini, t.ac_divf_fin, t.ac_rubrof, t.ac_secuencial
from ca_acciones t, oper_bcafe
where ac_operacion = oper

GO


IF OBJECT_ID ('dbo.ca_valor_referencial') IS NOT NULL
	DROP VIEW dbo.ca_valor_referencial
GO

create view ca_valor_referencial
as
select pi_referencia    as vr_tipo, 
       pi_valor         as vr_valor,
       pi_fecha_inicio  as vr_fecha_vig,
       pi_cod_pizarra   as vr_secuencial,
       tr_estado        AS vr_estado,
       tr_descripcion   AS vr_descripcion,
       pi_modalidad     AS vr_modalidad,
       pi_referencia    AS vr_tasa,
       pi_periodo       AS vr_periodicidad,
       'U'              AS vr_rango_unico
from   cobis..te_tpizarra, cobis..te_tasas_referenciales
where  pi_cod_pizarra > 0
and    pi_referencia = tr_tasa
and    tr_estado = 'V'



if object_id ('dbo.ca_tasa_valor') is not null
	drop view dbo.ca_tasa_valor
go

create view ca_tasa_valor
as
SELECT tr_tasa AS tv_nombre_tasa, 
       tr_descripcion      AS tv_descripcion,
       case pi_caracteristica when 'E' then 'V' else pi_modalidad end  AS tv_modalidad,
       case (select ca_periodo from cobis..te_caracteristicas_tasa  where ca_tasa = a.tr_tasa) 
                                when '1' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 360)
                                when '2' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 60)
                                when '3' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 90)
                                when '4' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 120)
                                when '5' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 150)
                                when '6' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 180)
                                when '7' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 210)
                                when '8' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 240)
                                when '9' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 270)
                                when '10' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 300)
                                when '11' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 330)
                                when '12' then (select td_tdividendo from cob_cartera..ca_tdividendo where td_factor = 30)
                                else 'A'
       end AS tv_periodicidad,
                tr_estado     AS tv_estado,
                pi_caracteristica AS tv_tipo_tasa
FROM   cobis..te_tasas_referenciales a, cobis..te_tpizarra c   -- cobis..te_caracteristicas_tasa
WHERE  tr_tasa = pi_referencia
and    tr_estado = 'V'
and    pi_cod_pizarra = (select max (pi_cod_pizarra) from cobis..te_tpizarra 
                                                  where pi_referencia = a.tr_tasa)
go

if object_id ('dbo.ca_valor_view') is not null
	drop view dbo.ca_valor_view
go
CREATE VIEW [dbo].[ca_valor_view]
as select va_tipo, va_descripcion, va_clase, 'N' as va_prime FROM cob_cartera..ca_valor
GO


if object_id ('dbo.ca_valor_referencial_view') is not null
	drop view dbo.ca_valor_referencial_view
go
CREATE VIEW [dbo].[ca_valor_referencial_view] as
select b.codigo as vr_tasa, vr_secuencial, b.valor as vr_descripcion,'R' as vr_modalidad, null as vr_periodicidad, 'U' as vr_rango_unico, b.estado as vr_estado from cobis..cl_tabla a, cobis..cl_catalogo b, cob_cartera..ca_valor_referencial c
where a.tabla like 'fp_procesos' and a.codigo = b.tabla and b.codigo = c.vr_tipo
and b.estado ='V' and vr_fecha_vig >= (select max(fp_fecha) from cobis..ba_fecha_proceso)
GO


USE cob_credito
GO

IF OBJECT_ID ('dbo.cr_periodo') IS NOT NULL
	DROP VIEW dbo.cr_periodo
GO

CREATE VIEW dbo.cr_periodo(

pe_periodo,

pe_descripcion,

pe_factor,

pe_estado) AS

SELECT td_tdividendo,

td_descripcion,

td_factor,

td_estado

FROM cob_cartera..ca_tdividendo

GO


IF OBJECT_ID ('dbo.cr_acciones_vw') IS NOT NULL
	DROP VIEW dbo.cr_acciones_vw
GO

create view cr_acciones_vw(
ac_fecha,
ac_aplicativo,
ac_banco,
ac_cliente,
ac_cobranza,
ac_taccion,
ac_numero_acc,
ac_abogado,
ac_valor,
ac_descripcion
)
as
select 
ac_fecha,
21,
oc_num_operacion,
op_cliente,
ac_cobranza,
ac_taccion,
ac_numero,
ac_abogado,
ac_monto_compr,
ac_descripcion
from cr_acciones, cr_operacion_cobranza, cob_cartera..ca_operacion
where ac_cobranza = oc_cobranza
and   op_banco    = oc_num_operacion


GO

