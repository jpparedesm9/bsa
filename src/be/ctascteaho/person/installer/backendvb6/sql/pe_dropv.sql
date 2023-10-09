use cob_remesas
go

if exists (select * from sysobjects 
			where name = 'ts_organizacion')
	drop view ts_organizacion
go

if exists (select * from sysobjects 
			where name = 'ts_parametrizacion_grupos')
	drop view ts_parametrizacion_grupos
go

if exists (select * from sysobjects 
			where name = 'ts_parametro')
	drop view ts_parametro
go

if exists (select * from sysobjects 
			where name = 'ts_perfil')
	drop view ts_perfil
go

if exists (select * from sysobjects 
			where name = 'ts_periodo')
	drop view ts_periodo
go

if exists (select * from sysobjects 
			where name = 'ts_plan_general')
	drop view ts_plan_general
go

if exists (select * from sysobjects 
			where name = 'ts_plan_general_presupuesto')
	drop view ts_plan_general_presupuesto
go

if exists (select * from sysobjects 
			where name = 'ts_relarea')
	drop view ts_relarea
go

if exists (select * from sysobjects 
			where name = 'ts_relofi')
	drop view ts_relofi
go

if exists (select * from sysobjects 
			where name = 'ts_relparam')
	drop view ts_relparam
go

if exists (select * from sysobjects 
			where name = 'ts_retencion')
	drop view ts_retencion
go

if exists (select * from sysobjects 
			where name = 'ts_saldo_presupuesto')
	drop view ts_saldo_presupuesto
go

if exists (select * from sysobjects 
			where name = 'ts_seguridad')
	drop view ts_seguridad
go

if exists (select * from sysobjects 
			where name = 'ts_tipo_area')
	drop view ts_tipo_area
go

if exists (select * from sysobjects 
			where name = 'pe_ts_cambio_costo')
	drop view pe_ts_cambio_costo
go

if exists (select * from sysobjects 
			where name = 'ts_tipo_documento')
	drop view ts_tipo_documento
go

if exists (select * from sysobjects 
			where name = 'pe_ts_costo')
	drop view pe_ts_costo
go

if exists (select * from sysobjects 
			where name = 'ts_tran_interfase')
	drop view ts_tran_interfase
go

if exists (select * from sysobjects 
			where name = 'pe_ts_val_contratado')
	drop view pe_ts_val_contratado
go

if exists (select * from sysobjects 
			where name = 'v_cb_inmovpro')
	drop view v_cb_inmovpro
go

if exists (select * from sysobjects 
			where name = 'ts_causales_restringidas')
	drop view ts_causales_restringidas
go

if exists (select * from sysobjects 
			where name = 'pe_ts_personaliza')
	drop view pe_ts_personaliza
go

if exists (select * from sysobjects 
			where name = 'v_reexp')
	drop view v_reexp
go

if exists (select * from sysobjects 
			where name = 'ts_limites_restrictivos')
	drop view ts_limites_restrictivos
go

if exists (select * from sysobjects 
			where name = 'cb_ult_fecha_cotiz_mon')
	drop view cb_ult_fecha_cotiz_mon
go

if exists (select * from sysobjects 
			where name = 'ts_tope_oficina')
	drop view ts_tope_oficina
go

if exists (select * from sysobjects 
			where name = 'asi_auxiliar')
	drop view asi_auxiliar
go

if exists (select * from sysobjects 
			where name = 'asientos')
	drop view asientos
go

if exists (select * from sysobjects 
			where name = 'cb_cotiz_mon_fechamax')
	drop view cb_cotiz_mon_fechamax
go

if exists (select * from sysobjects 
			where name = 'cb_mig_codigo_valor_view')
	drop view cb_mig_codigo_valor_view
go

if exists (select * from sysobjects 
			where name = 'cb_mig_cuenta_asociada_view')
	drop view cb_mig_cuenta_asociada_view
go

if exists (select * from sysobjects 
			where name = 'cb_mig_cuenta_proceso_view')
	drop view cb_mig_cuenta_proceso_view
go

if exists (select * from sysobjects 
			where name = 'cb_mig_cuentas_view')
	drop view cb_mig_cuentas_view
go

if exists (select * from sysobjects 
			where name = 'cb_mig_det_perfil_view')
	drop view cb_mig_det_perfil_view
go

if exists (select * from sysobjects 
			where name = 'cb_mig_jerararea_view')
	drop view cb_mig_jerararea_view
go

if exists (select * from sysobjects 
			where name = 'cb_mig_jerarquia_view')
	drop view cb_mig_jerarquia_view
go

if exists (select * from sysobjects 
			where name = 'cb_mig_oficina_view')
	drop view cb_mig_oficina_view
go

if exists (select * from sysobjects 
			where name = 'cb_mig_parametro_view')
	drop view cb_mig_parametro_view
go

if exists (select * from sysobjects 
			where name = 'cb_mig_perfil_view')
	drop view cb_mig_perfil_view
go

if exists (select * from sysobjects 
			where name = 'cb_mig_plan_general_view')
	drop view cb_mig_plan_general_view
go

if exists (select * from sysobjects 
			where name = 'cb_mig_relparam_view')
	drop view cb_mig_relparam_view
go

if exists (select * from sysobjects 
			where name = 'cb_mov_comp')
	drop view cb_mov_comp
go

if exists (select * from sysobjects 
			where name = 'cb_saldo_hist')
	drop view cb_saldo_hist
go

if exists (select * from sysobjects 
			where name = 'cb_vcorte_mensual')
	drop view cb_vcorte_mensual
go

if exists (select * from sysobjects 
			where name = 'cb_vcotizacion')
	drop view cb_vcotizacion
go

if exists (select * from sysobjects 
			where name = 'co_auxiliar')
	drop view co_auxiliar
go

if exists (select * from sysobjects 
			where name = 'comprobantes')
	drop view comprobantes
go

if exists (select * from sysobjects 
			where name = 'd_salter')
	drop view d_salter
go

if exists (select * from sysobjects 
			where name = 'movimientos')
	drop view movimientos
go

if exists (select * from sysobjects 
			where name = 'retencion')
	drop view retencion
go

if exists (select * from sysobjects 
			where name = 'saldo_ant')
	drop view saldo_ant
go

if exists (select * from sysobjects 
			where name = 'saldos')
	drop view saldos
go

if exists (select * from sysobjects 
			where name = 'ts_area')
	drop view ts_area
go

if exists (select * from sysobjects 
			where name = 'ts_asoc_operaciones')
	drop view ts_asoc_operaciones
go

if exists (select * from sysobjects 
			where name = 'ts_asoemp')
	drop view ts_asoemp
go

if exists (select * from sysobjects 
			where name = 'ts_banco')
	drop view ts_banco
go

if exists (select * from sysobjects 
			where name = 'ts_banco_conci')
	drop view ts_banco_conci
go

if exists (select * from sysobjects 
			where name = 'ts_categoria')
	drop view ts_categoria
go

if exists (select * from sysobjects 
			where name = 'ts_cbproduc')
	drop view ts_cbproduc
go

if exists (select * from sysobjects 
			where name = 'ts_codigo_valor')
	drop view ts_codigo_valor
go

if exists (select * from sysobjects 
			where name = 'ts_comp_tipo')
	drop view ts_comp_tipo
go

if exists (select * from sysobjects 
			where name = 'ts_comprobante')
	drop view ts_comprobante
go

if exists (select * from sysobjects 
			where name = 'ts_conc_retencion')
	drop view ts_conc_retencion
go

if exists (select * from sysobjects 
			where name = 'ts_concepto_conci')
	drop view ts_concepto_conci
go

if exists (select * from sysobjects 
			where name = 'ts_concica')
	drop view ts_concica
go

if exists (select * from sysobjects 
			where name = 'ts_concil_operaciones')
	drop view ts_concil_operaciones
go

if exists (select * from sysobjects 
			where name = 'ts_conciva')
	drop view ts_conciva
go

if exists (select * from sysobjects 
			where name = 'ts_concivapagado')
	drop view ts_concivapagado
go

if exists (select * from sysobjects 
			where name = 'ts_consolid')
	drop view ts_consolid
go

if exists (select * from sysobjects 
			where name = 'ts_control')
	drop view ts_control
go

if exists (select * from sysobjects 
			where name = 'ts_corte')
	drop view ts_corte
go

if exists (select * from sysobjects 
			where name = 'ts_cotizacion')
	drop view ts_cotizacion
go

if exists (select * from sysobjects 
			where name = 'ts_cuenta')
	drop view ts_cuenta
go

if exists (select * from sysobjects 
			where name = 'ts_cuenta_asociada')
	drop view ts_cuenta_asociada
go

if exists (select * from sysobjects 
			where name = 'ts_cuenta_departamento')
	drop view ts_cuenta_departamento
go

if exists (select * from sysobjects 
			where name = 'ts_cuenta_presupuesto')
	drop view ts_cuenta_presupuesto
go

if exists (select * from sysobjects 
			where name = 'ts_cuenta_proceso')
	drop view ts_cuenta_proceso
go

if exists (select * from sysobjects 
			where name = 're_ts_causales_impuestos')
	drop view re_ts_causales_impuestos
go

if exists (select * from sysobjects 
			where name = 'ts_departamento')
	drop view ts_departamento
go

if exists (select * from sysobjects 
			where name = 'ts_par_perfil')
	drop view ts_par_perfil
go

if exists (select * from sysobjects 
			where name = 'ts_det_perfil')
	drop view ts_det_perfil
go

if exists (select * from sysobjects 
			where name = 'ts_diferido')
	drop view ts_diferido
go

if exists (select * from sysobjects 
			where name = 'ts_diferidos')
	drop view ts_diferidos
go

if exists (select * from sysobjects 
			where name = 'ts_dinamica')
	drop view ts_dinamica
go

if exists (select * from sysobjects 
			where name = 'ts_documento_empresa')
	drop view ts_documento_empresa
go

if exists (select * from sysobjects 
			where name = 'ts_empresa')
	drop view ts_empresa
go

if exists (select * from sysobjects 
			where name = 'ts_estcta')
	drop view ts_estcta
go

if exists (select * from sysobjects 
			where name = 'ts_exenciu')
	drop view ts_exenciu
go

if exists (select * from sysobjects 
			where name = 'ts_exenpro')
	drop view ts_exenpro
go

if exists (select * from sysobjects 
			where name = 'ts_grupo_gastos')
	drop view ts_grupo_gastos
go

if exists (select * from sysobjects 
			where name = 'ts_impdept')
	drop view ts_impdept
go

if exists (select * from sysobjects 
			where name = 'ts_impuestos')
	drop view ts_impuestos
go

if exists (select * from sysobjects 
			where name = 'ts_item')
	drop view ts_item
go

if exists (select * from sysobjects 
			where name = 'ts_nivel_area')
	drop view ts_nivel_area
go

if exists (select * from sysobjects 
			where name = 'ts_nivel_cuenta')
	drop view ts_nivel_cuenta
go

if exists (select * from sysobjects 
			where name = 'ts_nivel_presupuesto')
	drop view ts_nivel_presupuesto
go

if exists (select * from sysobjects 
			where name = 'ts_oficina')
	drop view ts_oficina
go

if exists (select * from sysobjects 
			where name = 'ts_oficina_departamento')
	drop view ts_oficina_departamento
go

if exists (select * from sysobjects 
			where name = 'ts_opc_item')
	drop view ts_opc_item
go

if exists (select * from sysobjects 
			where name = 'ts_opcion')
	drop view ts_opcion
go
