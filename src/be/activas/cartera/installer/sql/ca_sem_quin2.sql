
use cob_cartera
go


select * from ca_tdividendo
where td_tdividendo in ('W', 'Q')

delete from ca_tdividendo
where td_tdividendo in ('W', 'Q')

insert into ca_tdividendo 
(td_tdividendo, td_descripcion, td_estado, td_factor)
values('W', 'SEMANAL', 'V', 7)

insert into ca_tdividendo 
(td_tdividendo, td_descripcion, td_estado, td_factor)
values('Q', 'QUINCENAL', 'V', 15)
GO


delete from ca_default_toperacion 
where dt_toperacion in ('CRESEMW', 'CRESEMQ') 
and dt_moneda = 0

insert into ca_default_toperacion
(dt_toperacion, dt_moneda, dt_reajustable, dt_periodo_reaj, 
 dt_reajuste_especial, dt_renovacion, dt_tipo, dt_estado, 
 dt_precancelacion, dt_cuota_completa, dt_tipo_cobro, 
 dt_tipo_reduccion, dt_aceptar_anticipos, dt_tipo_aplicacion, 
 dt_tplazo, dt_plazo, dt_tdividendo, dt_periodo_cap, 
 dt_periodo_int, dt_gracia_cap, dt_gracia_int, dt_dist_gracia, 
 dt_dias_anio, dt_tipo_amortizacion, dt_fecha_fija, dt_dia_pago, 
 dt_cuota_fija, dt_dias_gracia, dt_evitar_feriados, dt_mes_gracia, 
 dt_base_calculo, dt_prd_cobis, dt_dia_habil, dt_recalcular_plazo, 
 dt_usar_tequivalente, dt_tipo_redondeo, dt_causacion, dt_convertir_tasa, 
 dt_tipo_linea, dt_subtipo_linea, dt_bvirtual, dt_extracto, 
 dt_naturaleza, dt_pago_caja, dt_nace_vencida, dt_calcula_devolucion, 
 dt_categoria, dt_entidad_convenio, dt_mora_retroactiva, 
 dt_prepago_desde_lavigente, dt_dias_anio_mora, dt_tipo_calif, dt_plazo_min, 
 dt_plazo_max, dt_monto_min, dt_monto_max, dt_clase_sector, 
 dt_clase_cartera, dt_gar_admisible, dt_afecta_cupo, dt_control_dia_pago)
select 
'CRESEMW', 0, 'N', NULL, 'N', 'S', 'N', 'V', 'S', 'N', 'A',
'N', 'S', 'D', 'W', 26, 'W', 1, 1, 0, 0, 'N', 360, 'FRANCESA',
'S', 0, 'S', 0, 'S', 0, 'R', 7, 'N', 'N', NULL, NULL, 'L', 'S', 
'999', '05', 'N', 'N', 'A', 'S', 'N', 'N', '15', NULL, 'S', 'N', 
365, NULL, 3, 15, 0.00, 1000000000.00, '1', '1', 'N', 'N', 'S'
GO


insert into ca_default_toperacion
(dt_toperacion, dt_moneda, dt_reajustable, dt_periodo_reaj, 
 dt_reajuste_especial, dt_renovacion, dt_tipo, dt_estado, 
 dt_precancelacion, dt_cuota_completa, dt_tipo_cobro, 
 dt_tipo_reduccion, dt_aceptar_anticipos, dt_tipo_aplicacion, 
 dt_tplazo, dt_plazo, dt_tdividendo, dt_periodo_cap, 
 dt_periodo_int, dt_gracia_cap, dt_gracia_int, dt_dist_gracia, 
 dt_dias_anio, dt_tipo_amortizacion, dt_fecha_fija, dt_dia_pago, 
 dt_cuota_fija, dt_dias_gracia, dt_evitar_feriados, dt_mes_gracia, 
 dt_base_calculo, dt_prd_cobis, dt_dia_habil, dt_recalcular_plazo, 
 dt_usar_tequivalente, dt_tipo_redondeo, dt_causacion, dt_convertir_tasa, 
 dt_tipo_linea, dt_subtipo_linea, dt_bvirtual, dt_extracto, 
 dt_naturaleza, dt_pago_caja, dt_nace_vencida, dt_calcula_devolucion, 
 dt_categoria, dt_entidad_convenio, dt_mora_retroactiva, 
 dt_prepago_desde_lavigente, dt_dias_anio_mora, dt_tipo_calif, dt_plazo_min, 
 dt_plazo_max, dt_monto_min, dt_monto_max, dt_clase_sector, 
 dt_clase_cartera, dt_gar_admisible, dt_afecta_cupo, dt_control_dia_pago) 
  select 
'CRESEMQ', 0, 'N', NULL, 'N', 'S', 'N', 'V', 'S', 'N', 'A',
'N', 'S', 'D', 'M', 6, 'Q', 1, 1, 0, 0, 'N', 360, 'FRANCESA',
'S', 0, 'S', 0, 'S', 0, 'R', 7, 'N', 'N', NULL, NULL, 'L', 'S', 
'999', '05', 'N', 'N', 'A', 'S', 'N', 'N', '15', NULL, 'S', 'N', 
365, NULL, 3, 15, 0.00, 1000000000.00, '1', '1', 'N', 'N', 'S'
GO

