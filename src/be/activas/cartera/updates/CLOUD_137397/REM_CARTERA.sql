
use cob_cartera
go

update ca_default_toperacion set
dt_porcen_colateral = 2,
dt_evitar_feriados  = 'S',
dt_base_calculo     = 'R'
where dt_toperacion = 'GRUPAL' 


delete ca_rubro where ru_concepto in ('INT_ESPERA','IVA_ESPERA') and ru_toperacion = 'GRUPAL'

insert into ca_rubro (ru_toperacion, ru_moneda, ru_concepto, ru_prioridad, ru_tipo_rubro, ru_paga_mora, ru_provisiona, ru_fpago, ru_crear_siempre, ru_tperiodo, ru_periodo, ru_referencial, ru_reajuste, ru_banco, ru_estado, ru_concepto_asociado, ru_redescuento, ru_intermediacion, ru_principal, ru_saldo_op, ru_saldo_por_desem, ru_pit, ru_limite, ru_mora_interes, ru_iva_siempre, ru_monto_aprobado, ru_porcentaje_cobrar, ru_tipo_garantia, ru_valor_garantia, ru_porcentaje_cobertura, ru_tabla, ru_saldo_insoluto, ru_calcular_devolucion, ru_tasa_aplicar, ru_valor_max, ru_valor_min, ru_afectacion, ru_diferir, ru_tipo_seguro, ru_tasa_efectiva)
values ('GRUPAL', 0, 'INT_ESPERA', 15, 'O', 'N', 'S', 'M', 'N', NULL, NULL, NULL, NULL, 'N', 'V', NULL, 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)

insert into ca_rubro (ru_toperacion, ru_moneda, ru_concepto, ru_prioridad, ru_tipo_rubro, ru_paga_mora, ru_provisiona, ru_fpago, ru_crear_siempre, ru_tperiodo, ru_periodo, ru_referencial, ru_reajuste, ru_banco, ru_estado, ru_concepto_asociado, ru_redescuento, ru_intermediacion, ru_principal, ru_saldo_op, ru_saldo_por_desem, ru_pit, ru_limite, ru_mora_interes, ru_iva_siempre, ru_monto_aprobado, ru_porcentaje_cobrar, ru_tipo_garantia, ru_valor_garantia, ru_porcentaje_cobertura, ru_tabla, ru_saldo_insoluto, ru_calcular_devolucion, ru_tasa_aplicar, ru_valor_max, ru_valor_min, ru_afectacion, ru_diferir, ru_tipo_seguro, ru_tasa_efectiva)
values ('GRUPAL', 0, 'IVA_ESPERA', 15, 'O', 'N', 'S', 'P', 'N', NULL, NULL, 'TIVA', NULL, 'N', 'V', 'INT_ESPERA', 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', 'S', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)

delete ca_concepto where co_concepto in ('INT_ESPERA','IVA_ESPERA')

insert into ca_concepto (co_concepto, co_descripcion, co_codigo, co_categoria)
values ('INT_ESPERA', 'INTERES ESPERA', 20, 'O')

insert into ca_concepto (co_concepto, co_descripcion, co_codigo, co_categoria)
values ('IVA_ESPERA', 'IVA INTERES ESPERA', 21, 'A')

go