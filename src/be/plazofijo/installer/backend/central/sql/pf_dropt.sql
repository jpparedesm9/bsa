/************************************************************************/
/*                 Descripcion                                          */
/*  Script para eliminacion de tablas                                   */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  07/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

print '***********************************'
print '*****  ELIMINACION DE TABLAS ******'
print '***********************************'
print ''
print 'Inicio Ejecucion Eliminacion de Tablas Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''

print '-->Tabla: pf_npreimpreso'
if exists (select 1 from sysobjects where name = 'pf_npreimpreso' and type = 'U')
   drop table pf_npreimpreso

print '-->Tabla: pf_errores_migracion'
if exists (select 1 from sysobjects where name = 'pf_errores_migracion' and type = 'U')
   drop table pf_errores_migracion

print '-->Tabla: pf_temp_anular'
if exists (select 1 from sysobjects where name = 'pf_temp_anular' and type = 'U')
   drop table pf_temp_anular

print '-->Tabla: pf_instruccion'
if exists (select 1 from sysobjects where name = 'pf_instruccion' and type = 'U')
   drop table pf_instruccion

print '-->Tabla: pf_temp_gasto'
if exists (select 1 from sysobjects where name = 'pf_temp_gasto' and type = 'U')
   drop table pf_temp_gasto

print '-->Tabla: pf_bloqueo_legal'
if exists (select 1 from sysobjects where name = 'pf_bloqueo_legal' and type = 'U')
   drop table pf_bloqueo_legal

print '-->Tabla: pf_hist_tasa'
if exists (select 1 from sysobjects where name = 'pf_hist_tasa' and type = 'U')
   drop table pf_hist_tasa

print '-->Tabla: pf_hist_tasa_variable'
if exists (select 1 from sysobjects where name = 'pf_hist_tasa_variable' and type = 'U')
   drop table pf_hist_tasa_variable

print '-->Tabla: pf_total_acrue'
if exists (select 1 from sysobjects where name = 'pf_total_acrue' and type = 'U')
   drop table pf_total_acrue

print '-->Tabla: pf_total_acrue_his'
if exists (select 1 from sysobjects where name = 'pf_total_acrue_his' and type = 'U')
   drop table pf_total_acrue_his

print '-->Tabla: pf_aux'
if exists (select 1 from sysobjects where name = 'pf_aux' and type = 'U')
   drop table pf_aux

print '-->Tabla: pf_aut_spread'
if exists (select 1 from sysobjects where name = 'pf_aux' and type = 'U')
   drop table pf_aux

print '-->Tabla: pf_operacion_renov'
if exists (select 1 from sysobjects where name = 'pf_operacion_renov' and type = 'U')
   drop table pf_operacion_renov
 
print '-->Tabla: pf_incre_op'
if exists (select 1 from sysobjects where name = 'pf_incre_op' and type = 'U')
   drop table pf_incre_op
 
print '-->Tabla: pf_incremento'
if exists (select 1 from sysobjects where name = 'pf_incremento' and type = 'U')
   drop table pf_incremento

print '-->Tabla: pf_intereses_canc'
if exists (select 1 from sysobjects where name = 'pf_intereses_canc' and type = 'U')
   drop table pf_intereses_canc

print '-->Tabla: pf_cuotas_his'
if exists (select 1 from sysobjects where name = 'pf_cuotas_his' and type = 'U')
   drop table pf_cuotas_his
 
print '-->Tabla: sb_data_bcp'
if exists (select 1 from sysobjects where name = 'sb_data_bcp' and type = 'U')
   drop table sb_data_bcp

print '-->Tabla: pf_reporte_gmf_cdt_det'
if exists (select 1 from sysobjects where name = 'pf_reporte_gmf_cdt_det' and type = 'U')
   drop table pf_reporte_gmf_cdt_det

print '-->Tabla: pf_cambio_oper'
if exists (select 1 from sysobjects where name = 'pf_cambio_oper' and type = 'U')
   drop table pf_cambio_oper
 
print '-->Tabla: pf_reporte_gmf_cdt'
if exists (select 1 from sysobjects where name = 'pf_reporte_gmf_cdt' and type = 'U')
   drop table pf_reporte_gmf_cdt
 
print '-->Tabla: pf_transferencias_tmp'
if exists (select 1 from sysobjects where name = 'pf_transferencias_tmp' and type = 'U')
   drop table pf_transferencias_tmp

print '-->Tabla: pf_reporte_gmf_che'
if exists (select 1 from sysobjects where name = 'pf_reporte_gmf_che' and type = 'U')
   drop table pf_reporte_gmf_che
 
print '-->Tabla: pf_prov_dia'
if exists (select 1 from sysobjects where name = 'pf_prov_dia' and type = 'U')
   drop table pf_prov_dia
 
print '-->Tabla: pf_cuadre_auxiliar'
if exists (select 1 from sysobjects where name = 'pf_cuadre_auxiliar' and type = 'U')
   drop table pf_cuadre_auxiliar
 
print '-->Tabla: pf_error_conta'
if exists (select 1 from sysobjects where name = 'pf_error_conta' and type = 'U')
   drop table pf_error_conta
 
print '-->Tabla: pf_centralizada'
if exists (select 1 from sysobjects where name = 'pf_centralizada' and type = 'U')
   drop table pf_centralizada
 
print '-->Tabla: pf_convivencia_credito'
if exists (select 1 from sysobjects where name = 'pf_convivencia_credito' and type = 'U')
   drop table pf_convivencia_credito

print '-->Tabla: pf_rubro_op'
if exists (select 1 from sysobjects where name = 'pf_rubro_op' and type = 'U')
   drop table pf_rubro_op
 
print '-->Tabla: pf_rubro_op_renov'
if exists (select 1 from sysobjects where name = 'pf_rubro_op_renov' and type = 'U')
   drop table pf_rubro_op_renov
 
print '-->Tabla: pf_rubro_op_i'
if exists (select 1 from sysobjects where name = 'pf_rubro_op_i' and type = 'U')
   drop table pf_rubro_op_i

print '-->Tabla: pf_rubro_op_tmp'
if exists (select 1 from sysobjects where name = 'pf_rubro_op_tmp' and type = 'U')
   drop table pf_rubro_op_tmp
 
print '-->Tabla: pf_his_mensual'
if exists (select 1 from sysobjects where name = 'pf_his_mensual' and type = 'U')
   drop table pf_his_mensual
 
print '-->Tabla: pf_cambio_tasa'
if exists (select 1 from sysobjects where name = 'pf_cambio_tasa' and type = 'U')
   drop table pf_cambio_tasa
 
print '-->Tabla: pf_aux_neg'
if exists (select 1 from sysobjects where name = 'pf_aux_neg' and type = 'U')
   drop table pf_aux_neg

print '-->Tabla: pf_tran_servicio'
if exists (select 1 from sysobjects where name = 'pf_tran_servicio' and type = 'U')
   drop table pf_tran_servicio
 
print '-->Tabla: pf_fraccion_cdt'
if exists (select 1 from sysobjects where name = 'pf_fraccion_cdt' and type = 'U')
   drop table pf_fraccion_cdt
 
print '-->Tabla: pf_archivo_dcv_z'
if exists (select 1 from sysobjects where name = 'pf_archivo_dcv_z' and type = 'U')
   drop table pf_archivo_dcv_z
 
print '-->Tabla: tmp_bloqueocdt'
if exists (select 1 from sysobjects where name = 'tmp_bloqueocdt' and type = 'U')
   drop table tmp_bloqueocdt
 
print '-->Tabla: pf_desbloqueo_tmp'
if exists (select 1 from sysobjects where name = 'pf_desbloqueo_tmp' and type = 'U')
   drop table pf_desbloqueo_tmp

print '-->Tabla: pf_desbloqueo_tmp2'
if exists (select 1 from sysobjects where name = 'pf_desbloqueo_tmp2' and type = 'U')
   drop table pf_desbloqueo_tmp2

print '-->Tabla: reporte_desbloqueo'
if exists (select 1 from sysobjects where name = 'reporte_desbloqueo' and type = 'U')
   drop table reporte_desbloqueo
 
print '-->Tabla: tiempo'
if exists (select 1 from sysobjects where name = 'tiempo' and type = 'U')
   drop table tiempo
 
print '-->Tabla: pf_enajenacion'
if exists (select 1 from sysobjects where name = 'pf_enajenacion' and type = 'U')
   drop table pf_enajenacion
 
print '-->Tabla: pf_envios_dcv'
if exists (select 1 from sysobjects where name = 'pf_envios_dcv' and type = 'U')
   drop table pf_envios_dcv
 
print '-->Tabla: pf_fpago'
if exists (select 1 from sysobjects where name = 'pf_fpago' and type = 'U')
   drop table pf_fpago
 
print '-->Tabla: pf_det_envios_dcv'
if exists (select 1 from sysobjects where name = 'pf_det_envios_dcv' and type = 'U')
   drop table pf_det_envios_dcv

print '-->Tabla: pf_compensa_ope'
if exists (select 1 from sysobjects where name = 'pf_compensa_ope' and type = 'U')
   drop table pf_compensa_ope

print '-->Tabla: pf_archivo_deceval'
if exists (select 1 from sysobjects where name = 'pf_archivo_deceval' and type = 'U')
   drop table pf_archivo_deceval

print '-->Tabla: pf_compensa_mov'
if exists (select 1 from sysobjects where name = 'pf_compensa_mov' and type = 'U')
   drop table pf_compensa_mov

print '-->Tabla: pf_feriados_oficina'
if exists (select 1 from sysobjects where name = 'pf_feriados_oficina' and type = 'U')
   drop table pf_feriados_oficina
 
print '-->Tabla: pf_funcionario'
if exists (select 1 from sysobjects where name = 'pf_funcionario' and type = 'U')
   drop table pf_funcionario
 
print '-->Tabla: pf_auxtip_ofi'
if exists (select 1 from sysobjects where name = 'pf_auxtip_ofi' and type = 'U')
   drop table pf_auxtip_ofi
 
print '-->Tabla: pf_transaccion'
if exists (select 1 from sysobjects where name = 'pf_transaccion' and type = 'U')
   drop table pf_transaccion
 
print '-->Tabla: pf_fusfra'
if exists (select 1 from sysobjects where name = 'pf_fusfra' and type = 'U')
   drop table pf_fusfra
 
print '-->Tabla: pf_transaccion_det'
if exists (select 1 from sysobjects where name = 'pf_transaccion_det' and type = 'U')
   drop table pf_transaccion_det
 
print '-->Tabla: pf_firmas_autorizadas_tmp'
if exists (select 1 from sysobjects where name = 'pf_firmas_autorizadas_tmp' and type = 'U')
   drop table pf_firmas_autorizadas_tmp
 
print '-->Tabla: pf_plazo_contable'
if exists (select 1 from sysobjects where name = 'pf_plazo_contable' and type = 'U')
   drop table pf_plazo_contable

print '-->Tabla: pf_firmas_autorizadas'
if exists (select 1 from sysobjects where name = 'pf_firmas_autorizadas' and type = 'U')
   drop table pf_firmas_autorizadas

print '-->Tabla: pf_secuenciales'
if exists (select 1 from sysobjects where name = 'pf_secuenciales' and type = 'U')
   drop table pf_secuenciales

print '-->Tabla: pf_condfirmas'
if exists (select 1 from sysobjects where name = 'pf_condfirmas' and type = 'U')
   drop table pf_condfirmas

print '-->Tabla: pf_equivalencias'
if exists (select 1 from sysobjects where name = 'pf_equivalencias' and type = 'U')
   drop table pf_equivalencias

print '-->Tabla: pf_condfirmas_tmp'
if exists (select 1 from sysobjects where name = 'pf_condfirmas_tmp' and type = 'U')
   drop table pf_condfirmas_tmp

print '-->Tabla: pf_det_condfirmas'
if exists (select 1 from sysobjects where name = 'pf_det_condfirmas' and type = 'U')
   drop table pf_det_condfirmas

print '-->Tabla: pf_det_condfirmas_tmp'
if exists (select 1 from sysobjects where name = 'pf_det_condfirmas_tmp' and type = 'U')
   drop table pf_det_condfirmas_tmp

print '-->Tabla: pf_nueva_renovacion'
if exists (select 1 from sysobjects where name = 'pf_nueva_renovacion' and type = 'U')
   drop table pf_nueva_renovacion

print '-->Tabla: pf_autorizacion'
if exists (select 1 from sysobjects where name = 'pf_autorizacion' and type = 'U')
   drop table pf_autorizacion
 
print '-->Tabla: pf_det_pago'
if exists (select 1 from sysobjects where name = 'pf_det_pago' and type = 'U')
   drop table pf_det_pago

print '-->Tabla: pf_beneficiario'
if exists (select 1 from sysobjects where name = 'pf_beneficiario' and type = 'U')
   drop table pf_beneficiario
 
print '-->Tabla: pf_cancelacion_tmp'
if exists (select 1 from sysobjects where name = 'pf_cancelacion_tmp' and type = 'U')
   drop table pf_cancelacion_tmp
 
print '-->Tabla: pf_cancelacion'
if exists (select 1 from sysobjects where name = 'pf_cancelacion' and type = 'U')
   drop table pf_cancelacion

print '-->Tabla: pf_cuotas'
if exists (select 1 from sysobjects where name = 'pf_cuotas' and type = 'U')
   drop table pf_cuotas

print '-->Tabla: pf_tipo_deposito'
if exists (select 1 from sysobjects where name = 'pf_tipo_deposito' and type = 'U')
   drop table pf_tipo_deposito

print '-->Tabla: pf_beneficiario_tmp'
if exists (select 1 from sysobjects where name = 'pf_beneficiario_tmp' and type = 'U')
   drop table pf_beneficiario_tmp

print '-->Tabla: pf_cliente_externo'
if exists (select 1 from sysobjects where name = 'pf_cliente_externo' and type = 'U')
   drop table pf_cliente_externo

print '-->Tabla: pf_cliente_externo_tmp'
if exists (select 1 from sysobjects where name = 'pf_cliente_externo_tmp' and type = 'U')
   drop table pf_cliente_externo_tmp

print '-->Tabla: pf_det_pago_tmp'
if exists (select 1 from sysobjects where name = 'pf_det_pago_tmp' and type = 'U')
   drop table pf_det_pago_tmp

print '-->Tabla: pf_det_cheque_tmp'
if exists (select 1 from sysobjects where name = 'pf_det_cheque_tmp' and type = 'U')
   drop table pf_det_cheque_tmp

print '-->Tabla: pf_condicion'
if exists (select 1 from sysobjects where name = 'pf_condicion' and type = 'U')
   drop table pf_condicion

print '-->Tabla: pf_condicion_tmp'
if exists (select 1 from sysobjects where name = 'pf_condicion_tmp' and type = 'U')
   drop table pf_condicion_tmp

print '-->Tabla: pf_maestro_aux'
if exists (select 1 from sysobjects where name = 'pf_maestro_aux' and type = 'U')
   drop table pf_maestro_aux

print '-->Tabla: pf_conversion'
if exists (select 1 from sysobjects where name = 'pf_conversion' and type = 'U')
   drop table pf_conversion

print '-->Tabla: pf_maestro'
if exists (select 1 from sysobjects where name = 'pf_maestro' and type = 'U')
   drop table pf_maestro

print '-->Tabla: pf_conversion_ticket'
if exists (select 1 from sysobjects where name = 'pf_conversion_ticket' and type = 'U')
   drop table pf_conversion_ticket

create table pf_conversion_ticket(
ct_oficina                               smallint           not null,
ct_secuencial                            int                not null)
go
 
print '-->Tabla: pf_maestro_plan_pagos'
if exists (select 1 from sysobjects where name = 'pf_maestro_plan_pagos' and type = 'U')
   drop table pf_maestro_plan_pagos

print '-->Tabla: pf_det_condicion'
if exists (select 1 from sysobjects where name = 'pf_det_condicion' and type = 'U')
   drop table pf_det_condicion

print '-->Tabla: pf_maestro_plan_pagos_aux'
if exists (select 1 from sysobjects where name = 'pf_maestro_plan_pagos_aux' and type = 'U')
   drop table pf_maestro_plan_pagos_aux

print '-->Tabla: pf_det_condicion_tmp'
if exists (select 1 from sysobjects where name = 'pf_det_condicion_tmp' and type = 'U')
   drop table pf_det_condicion_tmp

print '-->Tabla: pf_emision_cheque'
if exists (select 1 from sysobjects where name = 'pf_emision_cheque' and type = 'U')
   drop table pf_emision_cheque

print '-->Tabla: pf_errorlog'
if exists (select 1 from sysobjects where name = 'pf_errorlog' and type = 'U')
   drop table pf_errorlog

print '-->Tabla: pf_historia'
if exists (select 1 from sysobjects where name = 'pf_historia' and type = 'U')
   drop table pf_historia

print '-->Tabla: pf_hist_secuen_ticket'
if exists (select 1 from sysobjects where name = 'pf_hist_secuen_ticket' and type = 'U')
   drop table pf_hist_secuen_ticket

print '-->Tabla: pf_monto'
if exists (select 1 from sysobjects where name = 'pf_monto' and type = 'U')
   drop table pf_monto

print '-->Tabla: pf_mov_monet'
if exists (select 1 from sysobjects where name = 'pf_mov_monet' and type = 'U')
   drop table pf_mov_monet

print '-->Tabla: pf_mov_monet_prob'
if exists (select 1 from sysobjects where name = 'pf_mov_monet_prob' and type = 'U')
   drop table pf_mov_monet_prob

print '-->Tabla: pf_reporte_venc_cab'
if exists (select 1 from sysobjects where name = 'pf_reporte_venc_cab' and type = 'U')
   drop table pf_reporte_venc_cab

print '-->Tabla: pf_mov_monet_tmp'
if exists (select 1 from sysobjects where name = 'pf_mov_monet_tmp' and type = 'U')
   drop table pf_mov_monet_tmp

print '-->Tabla: pf_reporte_venc_det'
if exists (select 1 from sysobjects where name = 'pf_reporte_venc_det' and type = 'U')
   drop table pf_reporte_venc_det

print '-->Tabla: pf_auxiliar_tip'
if exists (select 1 from sysobjects where name = 'pf_auxiliar_tip' and type = 'U')
   drop table pf_auxiliar_tip

print '-->Tabla: pf_limite'
if exists (select 1 from sysobjects where name = 'pf_limite' and type = 'U')
   drop table pf_limite

print '-->Tabla: pf_operacion'
if exists (select 1 from sysobjects where name = 'pf_operacion' and type = 'U')
   drop table pf_operacion

print '-->Tabla: pf_operacion_his'
if exists (select 1 from sysobjects where name = 'pf_operacion_his' and type = 'U')
   drop table pf_operacion_his

print '-->Tabla: pf_endoso_cond'
if exists (select 1 from sysobjects where name = 'pf_endoso_cond' and type = 'U')
   drop table pf_endoso_cond

print '-->Tabla: pf_endoso_prop'
if exists (select 1 from sysobjects where name = 'pf_endoso_prop' and type = 'U')
   drop table pf_endoso_prop

print '-->Tabla: pf_det_lote'
if exists (select 1 from sysobjects where name = 'pf_det_lote' and type = 'U')
   drop table pf_det_lote

print '-->Tabla: pf_det_lote_tmp'
if exists (select 1 from sysobjects where name = 'pf_det_lote_tmp' and type = 'U')
   drop table pf_det_lote_tmp

print '-->Tabla: pf_operacion_tmp'
if exists (select 1 from sysobjects where name = 'pf_operacion_tmp' and type = 'U')
   drop table pf_operacion_tmp

print '-->Tabla: pf_pignoracion'
if exists (select 1 from sysobjects where name = 'pf_pignoracion' and type = 'U')
   drop table pf_pignoracion
 
print '-->Tabla: pf_plazo'
if exists (select 1 from sysobjects where name = 'pf_plazo' and type = 'U')
   drop table pf_plazo

print '-->Tabla: pf_ppago'
if exists (select 1 from sysobjects where name = 'pf_ppago' and type = 'U')
   drop table pf_ppago

print '-->Tabla: pf_prorroga_aut'
if exists (select 1 from sysobjects where name = 'pf_prorroga_aut' and type = 'U')
   drop table pf_prorroga_aut
 
print '-->Tabla: pf_reg_control'
if exists (select 1 from sysobjects where name = 'pf_reg_control' and type = 'U')
   drop table pf_reg_control

print '-->Tabla: tmp_plano'
if exists (select 1 from sysobjects where name = 'tmp_plano' and type = 'U')
   drop table tmp_plano

print '-->Tabla: pf_renovacion'
if exists (select 1 from sysobjects where name = 'pf_renovacion' and type = 'U')
   drop table pf_renovacion

print '-->Tabla: tmp_transacciones'
if exists (select 1 from sysobjects where name = 'tmp_transacciones' and type = 'U')
   drop table tmp_transacciones

print '-->Tabla: pf_retencion'
if exists (select 1 from sysobjects where name = 'pf_retencion' and type = 'U')
   drop table pf_retencion

print '-->Tabla: pf_retencion_tmp'
if exists (select 1 from sysobjects where name = 'pf_retencion_tmp' and type = 'U')
   drop table pf_retencion_tmp

print '-->Tabla: pf_custodia_tmp'
if exists (select 1 from sysobjects where name = 'pf_custodia_tmp' and type = 'U')
   drop table pf_custodia_tmp

print '-->Tabla: pf_tasa'
if exists (select 1 from sysobjects where name = 'pf_tasa' and type = 'U')
   drop table pf_tasa

print '-->Tabla: pf_tasa_variable'
if exists (select 1 from sysobjects where name = 'pf_tasa_variable' and type = 'U')
   drop table pf_tasa_variable

print '-->Tabla: pf_estadistica'
if exists (select 1 from sysobjects where name = 'pf_estadistica' and type = 'U')
   drop table pf_estadistica

print '-->Tabla: pf_tranperfil'
if exists (select 1 from sysobjects where name = 'pf_tranperfil' and type = 'U')
   drop table pf_tranperfil

print '-->Tabla: pf_tran_provision'
if exists (select 1 from sysobjects where name = 'pf_tran_provision' and type = 'U')
   drop table pf_tran_provision

print '-->Tabla: pf_sasiento'
if exists (select 1 from sysobjects where name = 'pf_sasiento' and type = 'U')
   drop table pf_sasiento

print '-->Tabla: pf_scomprobante'
if exists (select 1 from sysobjects where name = 'pf_scomprobante' and type = 'U')
   drop table pf_scomprobante
 
print '-->Tabla: pf_sasiento_his'
if exists (select 1 from sysobjects where name = 'pf_sasiento_his' and type = 'U')
   drop table pf_sasiento_his

print '-->Tabla: pf_scomprobante_his'
if exists (select 1 from sysobjects where name = 'pf_scomprobante_his' and type = 'U')
   drop table pf_scomprobante_his
 
print '-->Tabla: pf_secuen_ticket'
if exists (select 1 from sysobjects where name = 'pf_secuen_ticket' and type = 'U')
   drop table pf_secuen_ticket
 
print '-->Tabla: pf_temp'
if exists (select 1 from sysobjects where name = 'pf_temp' and type = 'U')
   drop table pf_temp

print '-->Tabla: pf_relacion_comp'
if exists (select 1 from sysobjects where name = 'pf_relacion_comp' and type = 'U')
   drop table pf_relacion_comp

print '-->Tabla: pf_tasa_var_p'
if exists (select 1 from sysobjects where name = 'pf_tasa_var_p' and type = 'U')
   drop table pf_tasa_var_p

print ''
print 'Fin Ejecucion Eliminacion de Tablas Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''