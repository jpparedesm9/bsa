USE cob_cartera_his
GO

IF OBJECT_ID ('dbo.ca_abono') IS NOT NULL
   DROP TABLE dbo.ca_abono

IF OBJECT_ID ('dbo.ca_abono_det') IS NOT NULL
   DROP TABLE dbo.ca_abono_det
   
IF OBJECT_ID ('dbo.ca_abono_det_his') IS NOT NULL
   DROP TABLE dbo.ca_abono_det_his
   
IF OBJECT_ID ('dbo.ca_abono_his') IS NOT NULL
   DROP TABLE dbo.ca_abono_his
   
IF OBJECT_ID ('dbo.ca_abono_rubro') IS NOT NULL
   DROP TABLE dbo.ca_abono_rubro
   
IF OBJECT_ID ('dbo.ca_abono_rubro_his') IS NOT NULL
   DROP TABLE dbo.ca_abono_rubro_his
   
IF OBJECT_ID ('dbo.ca_abonos_masivos_his') IS NOT NULL
   DROP TABLE dbo.ca_abonos_masivos_his
   
IF OBJECT_ID ('dbo.ca_abonos_masivos_his_d') IS NOT NULL
   DROP TABLE dbo.ca_abonos_masivos_his_d
   
IF OBJECT_ID ('dbo.ca_acciones_his') IS NOT NULL
   DROP TABLE dbo.ca_acciones_his
   
IF OBJECT_ID ('dbo.ca_amortizacion') IS NOT NULL
   DROP TABLE dbo.ca_amortizacion
   
IF OBJECT_ID ('dbo.ca_amortizacion_ant_his') IS NOT NULL
   DROP TABLE dbo.ca_amortizacion_ant_his
   
IF OBJECT_ID ('dbo.ca_amortizacion_his') IS NOT NULL
   DROP TABLE dbo.ca_amortizacion_his
   
IF OBJECT_ID ('dbo.ca_conci_dia_findeter_his') IS NOT NULL
   DROP TABLE dbo.ca_conci_dia_findeter_his
   
IF OBJECT_ID ('dbo.ca_correccion') IS NOT NULL
   DROP TABLE dbo.ca_correccion
   
IF OBJECT_ID ('dbo.ca_correccion_his') IS NOT NULL
   DROP TABLE dbo.ca_correccion_his
   
IF OBJECT_ID ('dbo.ca_cuota_adicional') IS NOT NULL
   DROP TABLE dbo.ca_cuota_adicional
   
IF OBJECT_ID ('dbo.ca_cuota_adicional_his') IS NOT NULL
   DROP TABLE dbo.ca_cuota_adicional_his
   
IF OBJECT_ID ('dbo.ca_cuota_diff') IS NOT NULL
   DROP TABLE dbo.ca_cuota_diff
   
IF OBJECT_ID ('dbo.ca_cuota_diff_his') IS NOT NULL
   DROP TABLE dbo.ca_cuota_diff_his
   
IF OBJECT_ID ('dbo.ca_cuota_diff_tmp') IS NOT NULL
   DROP TABLE dbo.ca_cuota_diff_tmp
   
IF OBJECT_ID ('dbo.ca_det_trn') IS NOT NULL
   DROP TABLE dbo.ca_det_trn
   
IF OBJECT_ID ('dbo.ca_diferidos') IS NOT NULL
   DROP TABLE dbo.ca_diferidos
   
IF OBJECT_ID ('dbo.ca_diferidos_his') IS NOT NULL
   DROP TABLE dbo.ca_diferidos_his
   
IF OBJECT_ID ('dbo.ca_dividendo') IS NOT NULL
   DROP TABLE dbo.ca_dividendo
   
IF OBJECT_ID ('dbo.ca_dividendo_his') IS NOT NULL
   DROP TABLE dbo.ca_dividendo_his
   
IF OBJECT_ID ('dbo.ca_facturas') IS NOT NULL
   DROP TABLE dbo.ca_facturas
   
IF OBJECT_ID ('dbo.ca_facturas_his') IS NOT NULL
   DROP TABLE dbo.ca_facturas_his
   
IF OBJECT_ID ('dbo.ca_maestro_operaciones') IS NOT NULL
   DROP TABLE dbo.ca_maestro_operaciones
   
IF OBJECT_ID ('dbo.ca_operacion') IS NOT NULL
   DROP TABLE dbo.ca_operacion
   
IF OBJECT_ID ('dbo.ca_operacion_hc') IS NOT NULL
   DROP TABLE dbo.ca_operacion_hc
   
IF OBJECT_ID ('dbo.ca_operacion_his') IS NOT NULL
   DROP TABLE dbo.ca_operacion_his
   
IF OBJECT_ID ('dbo.ca_operacion_ts') IS NOT NULL
   DROP TABLE dbo.ca_operacion_ts
   
IF OBJECT_ID ('dbo.ca_reajuste') IS NOT NULL
   DROP TABLE dbo.ca_reajuste
   
IF OBJECT_ID ('dbo.ca_reajuste_det') IS NOT NULL
   DROP TABLE dbo.ca_reajuste_det
   
IF OBJECT_ID ('dbo.ca_relacion_ptmo_his') IS NOT NULL
   DROP TABLE dbo.ca_relacion_ptmo_his
   
IF OBJECT_ID ('dbo.ca_reportar_cliente') IS NOT NULL
   DROP TABLE dbo.ca_reportar_cliente
   
IF OBJECT_ID ('dbo.ca_reportar_cliente_his') IS NOT NULL
   DROP TABLE dbo.ca_reportar_cliente_his
   
IF OBJECT_ID ('dbo.ca_rubro_op') IS NOT NULL
   DROP TABLE dbo.ca_rubro_op
   
IF OBJECT_ID ('dbo.ca_rubro_op_his') IS NOT NULL
   DROP TABLE dbo.ca_rubro_op_his
   
IF OBJECT_ID ('dbo.ca_rubro_op_ts') IS NOT NULL
   DROP TABLE dbo.ca_rubro_op_ts
   
IF OBJECT_ID ('dbo.ca_saldos_cartera_mensual') IS NOT NULL
   DROP TABLE dbo.ca_saldos_cartera_mensual
   
IF OBJECT_ID ('dbo.ca_tasas') IS NOT NULL
   DROP TABLE dbo.ca_tasas
   
IF OBJECT_ID ('dbo.ca_transaccion') IS NOT NULL
   DROP TABLE dbo.ca_transaccion
   
IF OBJECT_ID ('dbo.ca_traslado_interes') IS NOT NULL
   DROP TABLE dbo.ca_traslado_interes
   
IF OBJECT_ID ('dbo.ca_traslado_interes_his') IS NOT NULL
   DROP TABLE dbo.ca_traslado_interes_his
   
IF OBJECT_ID ('dbo.ca_ultima_tasa_op_his') IS NOT NULL
   DROP TABLE dbo.ca_ultima_tasa_op_his
   
IF OBJECT_ID ('dbo.ca_valor_atx_his') IS NOT NULL
   DROP TABLE dbo.ca_valor_atx_his
   
IF OBJECT_ID ('dbo.ca_valores') IS NOT NULL
   DROP TABLE dbo.ca_valores
   
IF OBJECT_ID ('dbo.ca_valores_his') IS NOT NULL
   DROP TABLE dbo.ca_valores_his
   
IF OBJECT_ID ('dbo.CONTROL_BATCH') IS NOT NULL
   DROP TABLE dbo.CONTROL_BATCH
   
IF OBJECT_ID ('dbo.tmp_interes_amortiza_tmp') IS NOT NULL
   DROP TABLE dbo.tmp_interes_amortiza_tmp
 

IF OBJECT_ID ('dbo.ca_comision_diferida_his') IS NOT NULL
	DROP TABLE dbo.ca_comision_diferida_his

IF OBJECT_ID ('dbo.ca_seguros_his') IS NOT NULL
	DROP TABLE dbo.ca_seguros_his


IF OBJECT_ID ('dbo.ca_seguros_det_his') IS NOT NULL
	DROP TABLE dbo.ca_seguros_det_his


IF OBJECT_ID ('dbo.ca_seguros_can_his') IS NOT NULL
	DROP TABLE dbo.ca_seguros_can_his


IF OBJECT_ID ('dbo.ca_operacion_ext_his') IS NOT NULL
	DROP TABLE dbo.ca_operacion_ext_his


IF OBJECT_ID ('dbo.ca_diferidos_his') IS NOT NULL
	DROP TABLE dbo.ca_diferidos_his


GO

