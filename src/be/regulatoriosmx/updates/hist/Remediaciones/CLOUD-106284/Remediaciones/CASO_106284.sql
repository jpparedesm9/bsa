--------------
--CASO 106284
--------------
use cob_cartera
go

IF NOT EXISTS(SELECT 1 FROM ca_rubro_op WHERE ro_operacion= 79559 AND ro_concepto='IVA_CMORA')
   INSERT INTO cob_cartera..ca_rubro_op (ro_operacion, ro_concepto, ro_tipo_rubro, ro_fpago, ro_prioridad, ro_paga_mora, ro_provisiona, ro_signo, ro_factor, ro_referencial, ro_signo_reajuste, ro_factor_reajuste, ro_referencial_reajuste, ro_valor, ro_porcentaje, ro_porcentaje_aux, ro_gracia, ro_concepto_asociado, ro_redescuento, ro_intermediacion, ro_principal, ro_porcentaje_efa, ro_garantia, ro_tipo_puntos, ro_saldo_op, ro_saldo_por_desem, ro_base_calculo, ro_num_dec, ro_limite, ro_iva_siempre, ro_monto_aprobado, ro_porcentaje_cobrar, ro_tipo_garantia, ro_nro_garantia, ro_porcentaje_cobertura, ro_valor_garantia, ro_tperiodo, ro_periodo, ro_tabla, ro_saldo_insoluto, ro_calcular_devolucion)
   VALUES (79559, 'IVA_CMORA', 'O', 'P', 10, 'N', 'N', '+', 0, 'TIVA', '+', 0, NULL, 2.99, 16, 16, 0, 'COMMORA', NULL, NULL, 'N', 0, 0, NULL, 'N', 'N', 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

