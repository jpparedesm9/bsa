use cob_credito_his
go

truncate table cr_empleo_buro_his
truncate table cr_direccion_buro_his
truncate table cr_buro_encabezado_his
truncate table cr_buro_cuenta_his
truncate table cr_consultas_buro_his
truncate table cr_buro_resumen_reporte_his
truncate table cr_score_buro_his
delete cr_interface_buro_his


IF EXISTS (SELECT * FROM sys.identity_columns WHERE OBJECT_NAME(OBJECT_ID) = 'cr_interface_buro_his' AND last_value IS NOT NULL) 
   DBCC CHECKIDENT (cr_interface_buro_his, RESEED, 0)

insert into cr_interface_buro_his (ibh_cliente, ibh_fecha, ibh_riesgo, ibh_folio, ibh_fecha_paso_his)
select ib_cliente, ib_fecha, ib_riesgo, ib_folio, getdate()
from cob_credito..cr_interface_buro
order by ib_cliente asc


insert into cr_buro_cuenta_his(
bch_ib_secuencial,
bch_fecha_actualizacion,
bch_registro_impugnado,
bch_clave_otorgante,
bch_nombre_otorgante,
bch_numero_telefono_otorgante,
bch_identificador_sociedad_crediticia,
bch_numero_cuenta_actual,
bch_indicador_tipo_responsabilidad,
bch_tipo_cuenta,
bch_tipo_contrato,
bch_clave_unidad_monetaria,
bch_valor_activo_valuacion,
bch_numero_pagos,
bch_frecuencia_pagos,
bch_monto_pagar,
bch_fecha_apertura_cuenta,
bch_fecha_ultimo_pago,
bch_fecha_ultima_compra,
bch_fecha_cierre_cuenta,
bch_fecha_reporte,
bch_modo_reportar,
bch_ultima_fecha_saldo_cero,
bch_garantia,
bch_credito_maximo,
bch_saldo_actual,
bch_limite_credito,
bch_saldo_vencido,
bch_numero_pagos_vencidos,
bch_forma_pago_actual,
bch_historico_pagos,
bch_fecha_mas_reciente_pago_historicos,
bch_fecha_mas_antigua_pago_historicos,
bch_clave_observacion,
bch_total_pagos_reportados,
bch_total_pagos_calificados_mop2,
bch_total_pagos_calificados_mop3,
bch_total_pagos_calificados_mop4,
bch_total_pagos_calificados_mop5,
bch_importe_saldo_morosidad_hist_mas_grave,
bch_fecha_historica_morosidad_mas_grave,
bch_mop_historico_morosidad_mas_grave,
bch_monto_ultimo_pago,
bch_fecha_inicio_reestructura)
select 
ibh_secuencial,
bc_fecha_actualizacion,
bc_registro_impugnado,
bc_clave_otorgante,
bc_nombre_otorgante,
bc_numero_telefono_otorgante,
bc_identificador_sociedad_crediticia,
bc_numero_cuenta_actual,
bc_indicador_tipo_responsabilidad,
bc_tipo_cuenta,
bc_tipo_contrato,
bc_clave_unidad_monetaria,
bc_valor_activo_valuacion,
bc_numero_pagos,
bc_frecuencia_pagos,
bc_monto_pagar,
bc_fecha_apertura_cuenta,
bc_fecha_ultimo_pago,
bc_fecha_ultima_compra,
bc_fecha_cierre_cuenta,
bc_fecha_reporte,
bc_modo_reportar,
bc_ultima_fecha_saldo_cero,
bc_garantia,
bc_credito_maximo,
bc_saldo_actual,
bc_limite_credito,
bc_saldo_vencido,
bc_numero_pagos_vencidos,
bc_forma_pago_actual,
bc_historico_pagos,
bc_fecha_mas_reciente_pago_historicos,
bc_fecha_mas_antigua_pago_historicos,
bc_clave_observacion,
bc_total_pagos_reportados,
bc_total_pagos_calificados_mop2,
bc_total_pagos_calificados_mop3,
bc_total_pagos_calificados_mop4,
bc_total_pagos_calificados_mop5,
bc_importe_saldo_morosidad_hist_mas_grave,
bc_fecha_historica_morosidad_mas_grave,
bc_mop_historico_morosidad_mas_grave,
bc_monto_ultimo_pago,
bc_fecha_inicio_reestructura
from cob_credito..cr_buro_cuenta, cob_credito..cr_interface_buro, cr_interface_buro_his
where bc_id_cliente = ib_cliente
and   ib_cliente = ibh_cliente


insert into cr_direccion_buro_his(
dbh_ib_secuencial,
dbh_direccion_uno,
dbh_direccion_dos,
dbh_colonia,
dbh_delegacion,
dbh_ciudad,
dbh_estado,
dbh_codigo_postal,
dbh_numero_telefono,
dbh_tipo_domicilio,
dbh_indicador_especial,
dbh_codigo_pais,
dbh_fecha_reporte)
select 
ibh_secuencial,
db_direccion_uno,
db_direccion_dos,
db_colonia,
db_delegacion,
db_ciudad,
db_estado,
db_codigo_postal,
db_numero_telefono,
db_tipo_domicilio,
db_indicador_especial,
db_codigo_pais,
db_fecha_reporte
from cob_credito..cr_direccion_buro, cob_credito..cr_interface_buro, cr_interface_buro_his
where db_cliente = ib_cliente
and   ib_cliente = ibh_cliente


insert into cr_empleo_buro_his(
ebh_ib_secuencial,
ebh_nombre_empresa,
ebh_direccion_uno,
ebh_direccion_dos,
ebh_colonia,
ebh_delegacion,
ebh_ciudad,
ebh_estado,
ebh_codigo_postal,
ebh_numero_telefono,
ebh_extension,
ebh_fax,
ebh_cargo,
ebh_fecha_contratacion,
ebh_clave_moneda,
ebh_salario,
ebh_base_salarial,
ebh_num_empleado,
ebh_fecha_ult_dia,
ebh_codigo_pais,
ebh_fecha_rept_empleo,
ebh_fecha_verificacion,
ebh_modo_verificacion)
select
ibh_secuencial,
eb_nombre_empresa,
eb_direccion_uno,
eb_direccion_dos,
eb_colonia,
eb_delegacion,
eb_ciudad,
eb_estado,
eb_codigo_postal,
eb_numero_telefono,
eb_extension,
eb_fax,
eb_cargo,
eb_fecha_contratacion,
eb_clave_moneda,
eb_salario,
eb_base_salarial,
eb_num_empleado,
eb_fecha_ult_dia,
eb_codigo_pais,
eb_fecha_rept_empleo,
eb_fecha_verificacion,
eb_modo_verificiacion
from cob_credito..cr_empleo_buro, cob_credito..cr_interface_buro, cr_interface_buro_his
where eb_cliente = ib_cliente
and   ib_cliente = ibh_cliente



insert into cr_consultas_buro_his(
cbh_ib_secuencial,
cbh_fecha_consulta,     
cbh_identificacion_buro, 
cbh_clave_otorgante,     
cbh_nombre_otorgante,    
cbh_telefono_otorgante,  
cbh_tipo_contrato,       
cbh_clave_monetaria,     
cbh_importe_contrato,    
cbh_ind_tipo_responsa,   
cbh_consumidor_nuevo,    
cbh_resultado_final,     
cbh_identificador_cons)
select 
ibh_secuencial,
ce_fecha_consulta,     
ce_identificacion_buro, 
ce_clave_otorgante,     
ce_nombre_otorgante,    
ce_telefono_otorgante,  
ce_tipo_contrato,       
ce_clave_monetaria,     
ce_importe_contrato,    
ce_ind_tipo_responsa,   
ce_consumidor_nuevo,    
ce_resultado_final,     
ce_identificador_cons
from cob_credito..cr_consultas_buro, cob_credito..cr_interface_buro, cr_interface_buro_his
where ce_cliente = ib_cliente
and   ib_cliente = ibh_cliente

insert into cr_score_buro_his(
sbh_ib_secuencial, 
sbh_nombre,       
sbh_codigo,       
sbh_valor,        
sbh_codigo_razon, 
sbh_codigo_error)
select 
ibh_secuencial,
sb_nombre,     
sb_codigo,     
sb_valor,      
sb_codigo_razon,
sb_codigo_error
from cob_credito..cr_score_buro, cob_credito..cr_interface_buro, cr_interface_buro_his
where sb_cliente = ib_cliente
and   ib_cliente = ibh_cliente

insert into cr_buro_resumen_reporte_his(
brh_ib_secuencial,
brh_fecha_ingreso_bd,
brh_numero_mop7,
brh_numero_mop6,
brh_numero_mop5,
brh_numero_mop4,
brh_numero_mop3,
brh_numero_mop2,
brh_numero_mop1,
brh_numero_mop0,
brh_numero_mop_ur,
brh_numero_cuentas,
brh_cuentas_pagos_fijos_hipotecas,
brh_cuentas_revolventes_abiertas,
brh_cuentas_cerradas,
brh_cuentas_negativas_actuales,
brh_cuentas_claves_historia_negativa,
brh_cuentas_disputa,
brh_numero_solicitudes_ultimos_6_meses,
brh_nueva_direccion_reportada_ultimos_60_dias,
brh_mensajes_alerta,
brh_existencia_declaraciones_consumidor,
brh_tipo_moneda,
brh_total_creditos_maximos_revolventes,
brh_total_limites_credito_revolventes,
brh_total_saldos_actuales_revolventes,
brh_total_saldos_vencidos_revolventes,
brh_total_pagos_revolventes,
brh_pct_limite_credito_utilizado_revolventes,
brh_total_creditos_maximos_pagos_fijos,
brh_total_saldos_actuales_pagos_fijos,
brh_total_saldos_vencidos_pagos_fijos,
brh_total_pagos_pagos_fijos,
brh_numero_mop96,
brh_numero_mop97,
brh_numero_mop99,
brh_fecha_apertura_cuenta_mas_antigua,
brh_fecha_apertura_cuenta_mas_reciente,
brh_total_solicitudes_reporte,
brh_fecha_solicitud_reporte_mas_reciente,
brh_numero_total_cuentas_despacho_cobranza,
brh_fecha_apertura_cuenta_mas_reciente_despacho_cobranza,
brh_numero_total_solicitudes_despachos_cobranza,
brh_fecha_solicitud_mas_reciente_despacho_cobranza)
select
ibh_secuencial, 
br_fecha_ingreso_bd,
br_numero_mop7,
br_numero_mop6, 
br_numero_mop5,
br_numero_mop4,
br_numero_mop3,
br_numero_mop2,
br_numero_mop1,
br_numero_mop0,
br_numero_mop_ur,
br_numero_cuentas,
br_cuentas_pagos_fijos_hipotecas,
br_cuentas_revolventes_abiertas,
br_cuentas_cerradas,
br_cuentas_negativas_actuales,
br_cuentas_claves_historia_negativa,
br_cuentas_disputa,
br_numero_solicitudes_ultimos_6_meses,
br_nueva_direccion_reportada_ultimos_60_dias,
br_mensajes_alerta,
br_existencia_declaraciones_consumidor,
br_tipo_moneda,
br_total_creditos_maximos_revolventes,
br_total_limites_credito_revolventes,
br_total_saldos_actuales_revolventes,
br_total_saldos_vencidos_revolventes,
br_total_pagos_revolventes,
br_pct_limite_credito_utilizado_revolventes,
br_total_creditos_maximos_pagos_fijos,
br_total_saldos_actuales_pagos_fijos,
br_total_saldos_vencidos_pagos_fijos,
br_total_pagos_pagos_fijos,
br_numero_mop96,
br_numero_mop97,
br_numero_mop99,
br_fecha_apertura_cuenta_mas_antigua,
br_fecha_apertura_cuenta_mas_reciente,
br_total_solicitudes_reporte,
br_fecha_solicitud_reporte_mas_reciente,
br_numero_total_cuentas_despacho_cobranza,
br_fecha_apertura_cuenta_mas_reciente_despacho_cobranza,
br_numero_total_solicitudes_despachos_cobranza,
br_fecha_solicitud_mas_reciente_despacho_cobranza
from cob_credito..cr_buro_resumen_reporte, cob_credito..cr_interface_buro, cr_interface_buro_his
where br_id_cliente = ib_cliente
and   ib_cliente    = ibh_cliente

go
