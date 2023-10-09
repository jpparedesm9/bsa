use cob_remesas
go

/* CONTROL_BATCH */
print 'ELIMINA TABLA ====> CONTROL_BATCH'
go
if exists (select * from sysobjects where name = 'CONTROL_BATCH')
    drop TABLE CONTROL_BATCH
go

/* ah_tranxofi_tmp */
print 'ELIMINA TABLA ====> ah_tranxofi_tmp'
go
if exists (select * from sysobjects where name = 'ah_tranxofi_tmp')
    drop TABLE ah_tranxofi_tmp
go

/* archivo_salida */
print 'ELIMINA TABLA ====> archivo_salida'
go
if exists (select * from sysobjects where name = 'archivo_salida')
    drop TABLE archivo_salida
go

/* area_tcta */
print 'ELIMINA TABLA ====> area_tcta'
go
if exists (select * from sysobjects where name = 'area_tcta')
    drop TABLE area_tcta
go

/* cabecera */
print 'ELIMINA TABLA ====> cabecera'
go
if exists (select * from sysobjects where name = 'cabecera')
    drop TABLE cabecera
go

/* cb_balof_tmp */
print 'ELIMINA TABLA ====> cb_balof_tmp'
go
if exists (select * from sysobjects where name = 'cb_balof_tmp')
    drop TABLE cb_balof_tmp
go

/* cb_cuenta_mig */
print 'ELIMINA TABLA ====> cb_cuenta_mig'
go
if exists (select * from sysobjects where name = 'cb_cuenta_mig')
    drop TABLE cb_cuenta_mig
go

/* cb_mov_ant */
print 'ELIMINA TABLA ====> cb_mov_ant'
go
if exists (select * from sysobjects where name = 'cb_mov_ant')
    drop TABLE cb_mov_ant
go

/* cb_oficina_tmp */
print 'ELIMINA TABLA ====> cb_oficina_tmp'
go
if exists (select * from sysobjects where name = 'cb_oficina_tmp')
    drop TABLE cb_oficina_tmp
go

/* cc_archivo_cenit */
print 'ELIMINA TABLA ====> cc_archivo_cenit'
go
if exists (select * from sysobjects where name = 'cc_archivo_cenit')
    drop TABLE cc_archivo_cenit
go

/* cc_chqra_inicial */
print 'ELIMINA TABLA ====> cc_chqra_inicial'
go
if exists (select * from sysobjects where name = 'cc_chqra_inicial')
    drop TABLE cc_chqra_inicial
go

/* cc_control_archivos */
print 'ELIMINA TABLA ====> cc_control_archivos'
go
if exists (select * from sysobjects where name = 'cc_control_archivos')
    drop TABLE cc_control_archivos
go

/* cc_exenta_imp */
print 'ELIMINA TABLA ====> cc_exenta_imp'
go
if exists (select * from sysobjects where name = 'cc_exenta_imp')
    drop TABLE cc_exenta_imp
go

/* cc_mensaje_estcta */
print 'ELIMINA TABLA ====> cc_mensaje_estcta'
go
if exists (select * from sysobjects where name = 'cc_mensaje_estcta')
    drop TABLE cc_mensaje_estcta
go

/* cc_total_tranmonet */
print 'ELIMINA TABLA ====> cc_total_tranmonet'
go
if exists (select * from sysobjects where name = 'cc_total_tranmonet')
    drop TABLE cc_total_tranmonet
go

/* cl_error */
print 'ELIMINA TABLA ====> cl_error'
go
if exists (select * from sysobjects where name = 'cl_error')
    drop TABLE cl_error
go

/* cl_prueba */
print 'ELIMINA TABLA ====> cl_prueba'
go
if exists (select * from sysobjects where name = 'cl_prueba')
    drop TABLE cl_prueba
go

/* cm_cheques */
print 'ELIMINA TABLA ====> cm_cheques'
go
if exists (select * from sysobjects where name = 'cm_cheques')
    drop TABLE cm_cheques
go

/* cm_consolidadora */
print 'ELIMINA TABLA ====> cm_consolidadora'
go
if exists (select * from sysobjects where name = 'cm_consolidadora')
    drop TABLE cm_consolidadora
go

/* cm_errores_camara */
print 'ELIMINA TABLA ====> cm_errores_camara'
go
if exists (select * from sysobjects where name = 'cm_errores_camara')
    drop TABLE cm_errores_camara
go

/* cm_ingreso */
print 'ELIMINA TABLA ====> cm_ingreso'
go
if exists (select * from sysobjects where name = 'cm_ingreso')
    drop TABLE cm_ingreso
go

/* comp_temp */
print 'ELIMINA TABLA ====> comp_temp'
go
if exists (select * from sysobjects where name = 'comp_temp')
    drop TABLE comp_temp
go

/* conceptos */
print 'ELIMINA TABLA ====> conceptos'
go
if exists (select * from sysobjects where name = 'conceptos')
    drop TABLE conceptos
go

/* corte_act */
print 'ELIMINA TABLA ====> corte_act'
go
if exists (select * from sysobjects where name = 'corte_act')
    drop TABLE corte_act
go

/* corte_ant */
print 'ELIMINA TABLA ====> corte_ant'
go
if exists (select * from sysobjects where name = 'corte_ant')
    drop TABLE corte_ant
go

/* corte_aux */
print 'ELIMINA TABLA ====> corte_aux'
go
if exists (select * from sysobjects where name = 'corte_aux')
    drop TABLE corte_aux
go

/* corte_def */
print 'ELIMINA TABLA ====> corte_def'
go
if exists (select * from sysobjects where name = 'corte_def')
    drop TABLE corte_def
go

/* corte_tmp */
print 'ELIMINA TABLA ====> corte_tmp'
go
if exists (select * from sysobjects where name = 'corte_tmp')
    drop TABLE corte_tmp
go

/* cp_tmp_ofi_sobregiros */
print 'ELIMINA TABLA ====> cp_tmp_ofi_sobregiros'
go
if exists (select * from sysobjects where name = 'cp_tmp_ofi_sobregiros')
    drop TABLE cp_tmp_ofi_sobregiros
go

/* cp_tmp_saldos_sobregiros */
print 'ELIMINA TABLA ====> cp_tmp_saldos_sobregiros'
go
if exists (select * from sysobjects where name = 'cp_tmp_saldos_sobregiros')
    drop TABLE cp_tmp_saldos_sobregiros
go

/* ct_saldo_tercero_tmp_con */
print 'ELIMINA TABLA ====> ct_saldo_tercero_tmp_con'
go
if exists (select * from sysobjects where name = 'ct_saldo_tercero_tmp_con')
    drop TABLE ct_saldo_tercero_tmp_con
go

/* cuenta_producto */
print 'ELIMINA TABLA ====> cuenta_producto'
go
if exists (select * from sysobjects where name = 'cuenta_producto')
    drop TABLE cuenta_producto
go

/* det_cheques */
print 'ELIMINA TABLA ====> det_cheques'
go
if exists (select * from sysobjects where name = 'det_cheques')
    drop TABLE det_cheques
go

/* devueltos_ctacausa */
print 'ELIMINA TABLA ====> devueltos_ctacausa'
go
if exists (select * from sysobjects where name = 'devueltos_ctacausa')
    drop TABLE devueltos_ctacausa
go

/* fecha_salter */
print 'ELIMINA TABLA ====> fecha_salter'
go
if exists (select * from sysobjects where name = 'fecha_salter')
    drop TABLE fecha_salter
go

/* fechas */
print 'ELIMINA TABLA ====> fechas'
go
if exists (select * from sysobjects where name = 'fechas')
    drop TABLE fechas
go

/* mov_aux */
print 'ELIMINA TABLA ====> mov_aux'
go
if exists (select * from sysobjects where name = 'mov_aux')
    drop TABLE mov_aux
go

/* ofic_tcta */
print 'ELIMINA TABLA ====> ofic_tcta'
go
if exists (select * from sysobjects where name = 'ofic_tcta')
    drop TABLE ofic_tcta
go

/* oficina */
print 'ELIMINA TABLA ====> oficina'
go
if exists (select * from sysobjects where name = 'oficina')
    drop TABLE oficina
go

/* oficina_cta */
print 'ELIMINA TABLA ====> oficina_cta'
go
if exists (select * from sysobjects where name = 'oficina_cta')
    drop TABLE oficina_cta
go

/* pa_bonificacion_cargos */
print 'ELIMINA TABLA ====> pa_bonificacion_cargos'
go
if exists (select * from sysobjects where name = 'pa_bonificacion_cargos')
    drop TABLE pa_bonificacion_cargos
go

/* pa_gestion_paquete */
print 'ELIMINA TABLA ====> pa_gestion_paquete'
go
if exists (select * from sysobjects where name = 'pa_gestion_paquete')
    drop TABLE pa_gestion_paquete
go

/* pa_integrantes_paquete */
print 'ELIMINA TABLA ====> pa_integrantes_paquete'
go
if exists (select * from sysobjects where name = 'pa_integrantes_paquete')
    drop TABLE pa_integrantes_paquete
go

/* pa_negocio_paquete */
print 'ELIMINA TABLA ====> pa_negocio_paquete'
go
if exists (select * from sysobjects where name = 'pa_negocio_paquete')
    drop TABLE pa_negocio_paquete
go

/* pa_param_paquete */
print 'ELIMINA TABLA ====> pa_param_paquete'
go
if exists (select * from sysobjects where name = 'pa_param_paquete')
    drop TABLE pa_param_paquete
go

/* pa_param_pasivas */
print 'ELIMINA TABLA ====> pa_param_pasivas'
go
if exists (select * from sysobjects where name = 'pa_param_pasivas')
    drop TABLE pa_param_pasivas
go

/* pa_param_productos */
print 'ELIMINA TABLA ====> pa_param_productos'
go
if exists (select * from sysobjects where name = 'pa_param_productos')
    drop TABLE pa_param_productos
go

/* pa_param_tarjdeb */
print 'ELIMINA TABLA ====> pa_param_tarjdeb'
go
if exists (select * from sysobjects where name = 'pa_param_tarjdeb')
    drop TABLE pa_param_tarjdeb
go

/* pa_prod_banc */
print 'ELIMINA TABLA ====> pa_prod_banc'
go
if exists (select * from sysobjects where name = 'pa_prod_banc')
    drop TABLE pa_prod_banc
go

/* pa_relaciones */
print 'ELIMINA TABLA ====> pa_relaciones'
go
if exists (select * from sysobjects where name = 'pa_relaciones')
    drop TABLE pa_relaciones
go

/* pa_solicitud_paquete */
print 'ELIMINA TABLA ====> pa_solicitud_paquete'
go
if exists (select * from sysobjects where name = 'pa_solicitud_paquete')
    drop TABLE pa_solicitud_paquete
go

/* pd_locales */
print 'ELIMINA TABLA ====> pd_locales'
go
if exists (select * from sysobjects where name = 'pd_locales')
    drop TABLE pd_locales
go

/* pd_titulos */
print 'ELIMINA TABLA ====> pd_titulos'
go
if exists (select * from sysobjects where name = 'pd_titulos')
    drop TABLE pd_titulos
go

/* pd_transferidos */
print 'ELIMINA TABLA ====> pd_transferidos'
go
if exists (select * from sysobjects where name = 'pd_transferidos')
    drop TABLE pd_transferidos
go


/* re_accion_nc */
print 'ELIMINA TABLA ====> re_accion_nc'
go
if exists (select * from sysobjects where name = 're_accion_nc')
    drop TABLE re_accion_nc
go

/* re_accion_nd */
print 'ELIMINA TABLA ====> re_accion_nd'
go
if exists (select * from sysobjects where name = 're_accion_nd')
    drop TABLE re_accion_nd
go

/* re_accion_nd_cca523 */
print 'ELIMINA TABLA ====> re_accion_nd_cca523'
go
if exists (select * from sysobjects where name = 're_accion_nd_cca523')
    drop TABLE re_accion_nd_cca523
go

/* re_ahtotal_tranmonet */
print 'ELIMINA TABLA ====> re_ahtotal_tranmonet'
go
if exists (select * from sysobjects where name = 're_ahtotal_tranmonet')
    drop TABLE re_ahtotal_tranmonet
go

/* re_ahtotal_transerv */
print 'ELIMINA TABLA ====> re_ahtotal_transerv'
go
if exists (select * from sysobjects where name = 're_ahtotal_transerv')
    drop TABLE re_ahtotal_transerv
go

/* re_aprobacion_camara */
print 'ELIMINA TABLA ====> re_aprobacion_camara'
go
if exists (select * from sysobjects where name = 're_aprobacion_camara')
    drop TABLE re_aprobacion_camara
go

/* re_arch_in_dtn */
print 'ELIMINA TABLA ====> re_arch_in_dtn'
go
if exists (select * from sysobjects where name = 're_arch_in_dtn')
    drop TABLE re_arch_in_dtn
go

/* re_arch_out_dtn */
print 'ELIMINA TABLA ====> re_arch_out_dtn'
go
if exists (select * from sysobjects where name = 're_arch_out_dtn')
    drop TABLE re_arch_out_dtn
go

/* re_archivo_alianza */
print 'ELIMINA TABLA ====> re_archivo_alianza'
go
if exists (select * from sysobjects where name = 're_archivo_alianza')
    drop TABLE re_archivo_alianza
go

/* re_archivo_error */
print 'ELIMINA TABLA ====> re_archivo_error'
go
if exists (select * from sysobjects where name = 're_archivo_error')
    drop TABLE re_archivo_error
go

/* re_archivo_sobreg */
print 'ELIMINA TABLA ====> re_archivo_sobreg'
go
if exists (select * from sysobjects where name = 're_archivo_sobreg')
    drop TABLE re_archivo_sobreg
go

/* re_aut_tran_caja */
print 'ELIMINA TABLA ====> re_aut_tran_caja'
go
if exists (select * from sysobjects where name = 're_aut_tran_caja')
    drop TABLE re_aut_tran_caja
go

/* re_autelectronicos */
print 'ELIMINA TABLA ====> re_autelectronicos'
go
if exists (select * from sysobjects where name = 're_autelectronicos')
    drop TABLE re_autelectronicos
go

/* re_autoriza_ndnc */
print 'ELIMINA TABLA ====> re_autoriza_ndnc'
go
if exists (select * from sysobjects where name = 're_autoriza_ndnc')
    drop TABLE re_autoriza_ndnc
go

/* re_auxiliar */
print 'ELIMINA TABLA ====> re_auxiliar'
go
if exists (select * from sysobjects where name = 're_auxiliar')
    drop TABLE re_auxiliar
go

/* re_banco */
print 'ELIMINA TABLA ====> re_banco'
go
if exists (select * from sysobjects where name = 're_banco')
    drop TABLE re_banco
go

/* re_bcocedente */
print 'ELIMINA TABLA ====> re_bcocedente'
go
if exists (select * from sysobjects where name = 're_bcocedente')
    drop TABLE re_bcocedente
go

/* re_bitacora_camara */
print 'ELIMINA TABLA ====> re_bitacora_camara'
go
if exists (select * from sysobjects where name = 're_bitacora_camara')
    drop TABLE re_bitacora_camara
go

/* re_boc_diario */
print 'ELIMINA TABLA ====> re_boc_diario'
go
if exists (select * from sysobjects where name = 're_boc_diario')
    drop TABLE re_boc_diario
go

/* re_borrar_cta */
print 'ELIMINA TABLA ====> re_borrar_cta'
go
if exists (select * from sysobjects where name = 're_borrar_cta')
    drop TABLE re_borrar_cta
go

/* re_cab_cheques */
print 'ELIMINA TABLA ====> re_cab_cheques'
go
if exists (select * from sysobjects where name = 're_cab_cheques')
    drop TABLE re_cab_cheques
go

/* re_cab_dataentry */
print 'ELIMINA TABLA ====> re_cab_dataentry'
go
if exists (select * from sysobjects where name = 're_cab_dataentry')
    drop TABLE re_cab_dataentry
go

/* re_cabecera_transfer */
print 'ELIMINA TABLA ====> re_cabecera_transfer'
go
if exists (select * from sysobjects where name = 're_cabecera_transfer')
    drop TABLE re_cabecera_transfer
go

/* re_caja */
print 'ELIMINA TABLA ====> re_caja'
go
if exists (select * from sysobjects where name = 're_caja')
    drop TABLE re_caja
go

/* re_caja_his */
print 'ELIMINA TABLA ====> re_caja_his'
go
if exists (select * from sysobjects where name = 're_caja_his')
    drop TABLE re_caja_his
go

/* re_caja_rol */
print 'ELIMINA TABLA ====> re_caja_rol'
go
if exists (select * from sysobjects where name = 're_caja_rol')
    drop TABLE re_caja_rol
go

/* re_cajero */
print 'ELIMINA TABLA ====> re_cajero'
go
if exists (select * from sysobjects where name = 're_cajero')
    drop TABLE re_cajero
go

/* re_cam_pendiente */
print 'ELIMINA TABLA ====> re_cam_pendiente'
go
if exists (select * from sysobjects where name = 're_cam_pendiente')
    drop TABLE re_cam_pendiente
go

/* re_camara */
print 'ELIMINA TABLA ====> re_camara'
go
if exists (select * from sysobjects where name = 're_camara')
    drop TABLE re_camara
go

/* re_camara_definitiva */
print 'ELIMINA TABLA ====> re_camara_definitiva'
go
if exists (select * from sysobjects where name = 're_camara_definitiva')
    drop TABLE re_camara_definitiva
go

/* re_campo_impuesto */
print 'ELIMINA TABLA ====> re_campo_impuesto'
go
if exists (select * from sysobjects where name = 're_campo_impuesto')
    drop TABLE re_campo_impuesto
go

/* re_canje_anterior */
print 'ELIMINA TABLA ====> re_canje_anterior'
go
if exists (select * from sysobjects where name = 're_canje_anterior')
    drop TABLE re_canje_anterior
go

/* re_canje_env */
print 'ELIMINA TABLA ====> re_canje_env'
go
if exists (select * from sysobjects where name = 're_canje_env')
    drop TABLE re_canje_env
go

/* re_canje_tmp */
print 'ELIMINA TABLA ====> re_canje_tmp'
go
if exists (select * from sysobjects where name = 're_canje_tmp')
    drop TABLE re_canje_tmp
go

/* re_carga_archivo_ws */
print 'ELIMINA TABLA ====> re_carga_archivo_ws'
go
if exists (select * from sysobjects where name = 're_carga_archivo_ws')
    drop TABLE re_carga_archivo_ws
go

/* re_carga_punto_batch */
print 'ELIMINA TABLA ====> re_carga_punto_batch'
go
if exists (select * from sysobjects where name = 're_carga_punto_batch')
    drop TABLE re_carga_punto_batch
go

/* re_carga_tarjeta */
print 'ELIMINA TABLA ====> re_carga_tarjeta'
go
if exists (select * from sysobjects where name = 're_carga_tarjeta')
    drop TABLE re_carga_tarjeta
go

/* re_carta */
print 'ELIMINA TABLA ====> re_carta'
go
if exists (select * from sysobjects where name = 're_carta')
    drop TABLE re_carta
go

/* re_catalogo_ofi */
print 'ELIMINA TABLA ====> re_catalogo_ofi'
go
if exists (select * from sysobjects where name = 're_catalogo_ofi')
    drop TABLE re_catalogo_ofi
go

/* re_catalogo_premio */
print 'ELIMINA TABLA ====> re_catalogo_premio'
go
if exists (select * from sysobjects where name = 're_catalogo_premio')
    drop TABLE re_catalogo_premio
go

/* re_cctotal_transerv */
print 'ELIMINA TABLA ====> re_cctotal_transerv'
go
if exists (select * from sysobjects where name = 're_cctotal_transerv')
    drop TABLE re_cctotal_transerv
go

/* re_cheque_rec */
print 'ELIMINA TABLA ====> re_cheque_rec'
go
if exists (select * from sysobjects where name = 're_cheque_rec')
    drop TABLE re_cheque_rec
go

/* re_cheque_rem */
print 'ELIMINA TABLA ====> re_cheque_rem'
go
if exists (select * from sysobjects where name = 're_cheque_rem')
    drop TABLE re_cheque_rem
go

/* re_cheques_remesas */
print 'ELIMINA TABLA ====> re_cheques_remesas'
go
if exists (select * from sysobjects where name = 're_cheques_remesas')
    drop TABLE re_cheques_remesas
go

/* re_chqra_ini_ofi */
print 'ELIMINA TABLA ====> re_chqra_ini_ofi'
go
if exists (select * from sysobjects where name = 're_chqra_ini_ofi')
    drop TABLE re_chqra_ini_ofi
go

/* re_cierre */
print 'ELIMINA TABLA ====> re_cierre'
go
if exists (select * from sysobjects where name = 're_cierre')
    drop TABLE re_cierre
go

/* re_cierre_ticket_0241999 */
print 'ELIMINA TABLA ====> re_cierre_ticket_0241999'
go
if exists (select * from sysobjects where name = 're_cierre_ticket_0241999')
    drop TABLE re_cierre_ticket_0241999
go

/* re_ciudad_retencion */
print 'ELIMINA TABLA ====> re_ciudad_retencion'
go
if exists (select * from sysobjects where name = 're_ciudad_retencion')
    drop TABLE re_ciudad_retencion
go

/* re_cobro_grav */
print 'ELIMINA TABLA ====> re_cobro_grav'
go
if exists (select * from sysobjects where name = 're_cobro_grav')
    drop TABLE re_cobro_grav
go

/* re_codbar_impuesto */
print 'ELIMINA TABLA ====> re_codbar_impuesto'
go
if exists (select * from sysobjects where name = 're_codbar_impuesto')
    drop TABLE re_codbar_impuesto
go

/* re_codigo_barras */
print 'ELIMINA TABLA ====> re_codigo_barras'
go
if exists (select * from sysobjects where name = 're_codigo_barras')
    drop TABLE re_codigo_barras
go

/* re_comisiones_rem */
print 'ELIMINA TABLA ====> re_comisiones_rem'
go
if exists (select * from sysobjects where name = 're_comisiones_rem')
    drop TABLE re_comisiones_rem
go

/* re_compensa_ofi */
print 'ELIMINA TABLA ====> re_compensa_ofi'
go
if exists (select * from sysobjects where name = 're_compensa_ofi')
    drop TABLE re_compensa_ofi
go

/* re_conc_dev */
print 'ELIMINA TABLA ====> re_conc_dev'
go
if exists (select * from sysobjects where name = 're_conc_dev')
    drop TABLE re_conc_dev
go

/* re_concep_exen_gmf */
print 'ELIMINA TABLA ====> re_concep_exen_gmf'
go
if exists (select * from sysobjects where name = 're_concep_exen_gmf')
    drop TABLE re_concep_exen_gmf
go

/* re_concepto_contable */
print 'ELIMINA TABLA ====> re_concepto_contable'
go
if exists (select * from sysobjects where name = 're_concepto_contable')
    drop TABLE re_concepto_contable
go

/* re_concepto_contable_inc */
print 'ELIMINA TABLA ====> re_concepto_contable_inc'
go
if exists (select * from sysobjects where name = 're_concepto_contable_inc')
    drop TABLE re_concepto_contable_inc
go

/* re_concepto_imp */
print 'ELIMINA TABLA ====> re_concepto_imp'
go
if exists (select * from sysobjects where name = 're_concepto_imp')
    drop TABLE re_concepto_imp
go

/* re_consecutivo_paquete */
print 'ELIMINA TABLA ====> re_consecutivo_paquete'
go
if exists (select * from sysobjects where name = 're_consecutivo_paquete')
    drop TABLE re_consecutivo_paquete
go

/* re_consignacion_pit */
print 'ELIMINA TABLA ====> re_consignacion_pit'
go
if exists (select * from sysobjects where name = 're_consignacion_pit')
    drop TABLE re_consignacion_pit
go

/* re_consol_cenit */
print 'ELIMINA TABLA ====> re_consol_cenit'
go
if exists (select * from sysobjects where name = 're_consol_cenit')
    drop TABLE re_consol_cenit
go

/* re_consolidado_trn_cb */
print 'ELIMINA TABLA ====> re_consolidado_trn_cb'
go
if exists (select * from sysobjects where name = 're_consolidado_trn_cb')
    drop TABLE re_consolidado_trn_cb
go

/* re_consulta_trn_cb */
print 'ELIMINA TABLA ====> re_consulta_trn_cb'
go
if exists (select * from sysobjects where name = 're_consulta_trn_cb')
    drop TABLE re_consulta_trn_cb
go

/* re_conversion */
print 'ELIMINA TABLA ====> re_conversion'
go
if exists (select * from sysobjects where name = 're_conversion')
    drop TABLE re_conversion
go

/* re_cta_consolidada */
print 'ELIMINA TABLA ====> re_cta_consolidada'
go
if exists (select * from sysobjects where name = 're_cta_consolidada')
    drop TABLE re_cta_consolidada
go

/* re_cta_dtn */
print 'ELIMINA TABLA ====> re_cta_dtn'
go
if exists (select * from sysobjects where name = 're_cta_dtn')
    drop TABLE re_cta_dtn
go

/* re_cta_efectivizacion_esp */
print 'ELIMINA TABLA ====> re_cta_efectivizacion_esp'
go
if exists (select * from sysobjects where name = 're_cta_efectivizacion_esp')
    drop TABLE re_cta_efectivizacion_esp
go

/* re_cta_extracto */
print 'ELIMINA TABLA ====> re_cta_extracto'
go
if exists (select * from sysobjects where name = 're_cta_extracto')
    drop TABLE re_cta_extracto
go

/* re_cuadre_contable */
print 'ELIMINA TABLA ====> re_cuadre_contable'
go
if exists (select * from sysobjects where name = 're_cuadre_contable')
    drop TABLE re_cuadre_contable
go

/* re_cuenta_contractual */
print 'ELIMINA TABLA ====> re_cuenta_contractual'
go
if exists (select * from sysobjects where name = 're_cuenta_contractual')
    drop TABLE re_cuenta_contractual
go

/* re_cuentas_inactivas */
print 'ELIMINA TABLA ====> re_cuentas_inactivas'
go
if exists (select * from sysobjects where name = 're_cuentas_inactivas')
    drop TABLE re_cuentas_inactivas
go

/* re_cuentas_inactivas_cop */
print 'ELIMINA TABLA ====> re_cuentas_inactivas_cop'
go
if exists (select * from sysobjects where name = 're_cuentas_inactivas_cop')
    drop TABLE re_cuentas_inactivas_cop
go

/* re_cuota_ali */
print 'ELIMINA TABLA ====> re_cuota_ali'
go
if exists (select * from sysobjects where name = 're_cuota_ali')
    drop TABLE re_cuota_ali
go

/* re_datos_ahctasa */
print 'ELIMINA TABLA ====> re_datos_ahctasa'
go
if exists (select * from sysobjects where name = 're_datos_ahctasa')
    drop TABLE re_datos_ahctasa
go

/* re_datos_ahctasi */
print 'ELIMINA TABLA ====> re_datos_ahctasi'
go
if exists (select * from sysobjects where name = 're_datos_ahctasi')
    drop TABLE re_datos_ahctasi
go

/* re_datos_ccctasa */
print 'ELIMINA TABLA ====> re_datos_ccctasa'
go
if exists (select * from sysobjects where name = 're_datos_ccctasa')
    drop TABLE re_datos_ccctasa
go

/* re_datos_ccctasi */
print 'ELIMINA TABLA ====> re_datos_ccctasi'
go
if exists (select * from sysobjects where name = 're_datos_ccctasi')
    drop TABLE re_datos_ccctasi
go

/* re_definicion_caja */
print 'ELIMINA TABLA ====> re_definicion_caja'
go
if exists (select * from sysobjects where name = 're_definicion_caja')
    drop TABLE re_definicion_caja
go

/* re_det_ahocte */
print 'ELIMINA TABLA ====> re_det_ahocte'
go
if exists (select * from sysobjects where name = 're_det_ahocte')
    drop TABLE re_det_ahocte
go

/* re_det_canje */
print 'ELIMINA TABLA ====> re_det_canje'
go
if exists (select * from sysobjects where name = 're_det_canje')
    drop TABLE re_det_canje
go

/* re_det_carta */
print 'ELIMINA TABLA ====> re_det_carta'
go
if exists (select * from sysobjects where name = 're_det_carta')
    drop TABLE re_det_carta
go

/* re_det_cheques */
print 'ELIMINA TABLA ====> re_det_cheques'
go
if exists (select * from sysobjects where name = 're_det_cheques')
    drop TABLE re_det_cheques
go

/* re_det_dataentry */
print 'ELIMINA TABLA ====> re_det_dataentry'
go
if exists (select * from sysobjects where name = 're_det_dataentry')
    drop TABLE re_det_dataentry
go

/* re_detalle_cbarras */
print 'ELIMINA TABLA ====> re_detalle_cbarras'
go
if exists (select * from sysobjects where name = 're_detalle_cbarras')
    drop TABLE re_detalle_cbarras
go

/* re_detalle_error */
print 'ELIMINA TABLA ====> re_detalle_error'
go
if exists (select * from sysobjects where name = 're_detalle_error')
    drop TABLE re_detalle_error
go

/* re_detalle_transfer */
print 'ELIMINA TABLA ====> re_detalle_transfer'
go
if exists (select * from sysobjects where name = 're_detalle_transfer')
    drop TABLE re_detalle_transfer
go

/* re_dev_cobis */
print 'ELIMINA TABLA ====> re_dev_cobis'
go
if exists (select * from sysobjects where name = 're_dev_cobis')
    drop TABLE re_dev_cobis
go

/* re_dev_rec */
print 'ELIMINA TABLA ====> re_dev_rec'
go
if exists (select * from sysobjects where name = 're_dev_rec')
    drop TABLE re_dev_rec
go

/* re_dif_caja */
print 'ELIMINA TABLA ====> re_dif_caja'
go
if exists (select * from sysobjects where name = 're_dif_caja')
    drop TABLE re_dif_caja
go

/* re_dtn_autorizada */
print 'ELIMINA TABLA ====> re_dtn_autorizada'
go
if exists (select * from sysobjects where name = 're_dtn_autorizada')
    drop TABLE re_dtn_autorizada
go

/* re_enca_transfer_automatica */
print 'ELIMINA TABLA ====> re_enca_transfer_automatica'
go
if exists (select * from sysobjects where name = 're_enca_transfer_automatica')
    drop TABLE re_enca_transfer_automatica
go

/* re_equivalencia */
print 'ELIMINA TABLA ====> re_equivalencia'
go
if exists (select * from sysobjects where name = 're_equivalencia')
    drop TABLE re_equivalencia
go

/* re_equivalencias */
print 'ELIMINA TABLA ====> re_equivalencias'
go
if exists (select * from sysobjects where name = 're_equivalencias')
    drop TABLE re_equivalencias
go

/* re_equivalencias_CCA554 */
print 'ELIMINA TABLA ====> re_equivalencias_CCA554'
go
if exists (select * from sysobjects where name = 're_equivalencias_CCA554')
    drop TABLE re_equivalencias_CCA554
go

/* re_equivalencias_CCA557 */
print 'ELIMINA TABLA ====> re_equivalencias_CCA557'
go
if exists (select * from sysobjects where name = 're_equivalencias_CCA557')
    drop TABLE re_equivalencias_CCA557
go

/* re_equivalencias_REQ551 */
print 'ELIMINA TABLA ====> re_equivalencias_REQ551'
go
if exists (select * from sysobjects where name = 're_equivalencias_REQ551')
    drop TABLE re_equivalencias_REQ551
go

/* re_error_batch */
print 'ELIMINA TABLA ====> re_error_batch'
go
if exists (select * from sysobjects where name = 're_error_batch')
    drop TABLE re_error_batch
go

/* re_estadistica_chequera */
print 'ELIMINA TABLA ====> re_estadistica_chequera'
go
if exists (select * from sysobjects where name = 're_estadistica_chequera')
    drop TABLE re_estadistica_chequera
go

/* re_eventos */
print 'ELIMINA TABLA ====> re_eventos'
go
if exists (select * from sysobjects where name = 're_eventos')
    drop TABLE re_eventos
go

/* re_exenta_imp */
print 'ELIMINA TABLA ====> re_exenta_imp'
go
if exists (select * from sysobjects where name = 're_exenta_imp')
    drop TABLE re_exenta_imp
go

/* re_extraviadas */
print 'ELIMINA TABLA ====> re_extraviadas'
go
if exists (select * from sysobjects where name = 're_extraviadas')
    drop TABLE re_extraviadas
go

/* re_fecha_ejecucion */
print 'ELIMINA TABLA ====> re_fecha_ejecucion'
go
if exists (select * from sysobjects where name = 're_fecha_ejecucion')
    drop TABLE re_fecha_ejecucion
go

/* re_findia_bv */
print 'ELIMINA TABLA ====> re_findia_bv'
go
if exists (select * from sysobjects where name = 're_findia_bv')
    drop TABLE re_findia_bv
go

/* re_fpago_impuesto */
print 'ELIMINA TABLA ====> re_fpago_impuesto'
go
if exists (select * from sysobjects where name = 're_fpago_impuesto')
    drop TABLE re_fpago_impuesto
go

/* re_gcontribuyente */
print 'ELIMINA TABLA ====> re_gcontribuyente'
go
if exists (select * from sysobjects where name = 're_gcontribuyente')
    drop TABLE re_gcontribuyente
go

/* re_gcontribuyente_1 */
print 'ELIMINA TABLA ====> re_gcontribuyente_1'
go
if exists (select * from sysobjects where name = 're_gcontribuyente_1')
    drop TABLE re_gcontribuyente_1
go

/* re_gen_monet_bv */
print 'ELIMINA TABLA ====> re_gen_monet_bv'
go
if exists (select * from sysobjects where name = 're_gen_monet_bv')
    drop TABLE re_gen_monet_bv
go

/* re_gmf_alianza */
print 'ELIMINA TABLA ====> re_gmf_alianza'
go
if exists (select * from sysobjects where name = 're_gmf_alianza')
    drop TABLE re_gmf_alianza
go

/* re_grupo */
print 'ELIMINA TABLA ====> re_grupo'
go
if exists (select * from sysobjects where name = 're_grupo')
    drop TABLE re_grupo
go

/* re_grupo_camara */
print 'ELIMINA TABLA ====> re_grupo_camara'
go
if exists (select * from sysobjects where name = 're_grupo_camara')
    drop TABLE re_grupo_camara
go

/* re_his_extracto */
print 'ELIMINA TABLA ====> re_his_extracto'
go
if exists (select * from sysobjects where name = 're_his_extracto')
    drop TABLE re_his_extracto
go

/* re_his_total */
print 'ELIMINA TABLA ====> re_his_total'
go
if exists (select * from sysobjects where name = 're_his_total')
    drop TABLE re_his_total
go

/* re_impuesto */
print 'ELIMINA TABLA ====> re_impuesto'
go
if exists (select * from sysobjects where name = 're_impuesto')
    drop TABLE re_impuesto
go

/* re_inurbe */
print 'ELIMINA TABLA ====> re_inurbe'
go
if exists (select * from sysobjects where name = 're_inurbe')
    drop TABLE re_inurbe
go

/* re_limite_transaccion */
print 'ELIMINA TABLA ====> re_limite_transaccion'
go
if exists (select * from sysobjects where name = 're_limite_transaccion')
    drop TABLE re_limite_transaccion
go

/* re_limites */
print 'ELIMINA TABLA ====> re_limites'
go
if exists (select * from sysobjects where name = 're_limites')
    drop TABLE re_limites
go

/* re_liquidacion_intereses */
print 'ELIMINA TABLA ====> re_liquidacion_intereses'
go
if exists (select * from sysobjects where name = 're_liquidacion_intereses')
    drop TABLE re_liquidacion_intereses
go

/* re_locales */
print 'ELIMINA TABLA ====> re_locales'
go
if exists (select * from sysobjects where name = 're_locales')
    drop TABLE re_locales
go

/* re_logtran_atm */
print 'ELIMINA TABLA ====> re_logtran_atm'
go
if exists (select * from sysobjects where name = 're_logtran_atm')
    drop TABLE re_logtran_atm
go

/* re_logtran_bcp */
print 'ELIMINA TABLA ====> re_logtran_bcp'
go
if exists (select * from sysobjects where name = 're_logtran_bcp')
    drop TABLE re_logtran_bcp
go

/* re_mal_remitido */
print 'ELIMINA TABLA ====> re_mal_remitido'
go
if exists (select * from sysobjects where name = 're_mal_remitido')
    drop TABLE re_mal_remitido
go

/* re_mantenimiento_cb */
print 'ELIMINA TABLA ====> re_mantenimiento_cb'
go
if exists (select * from sysobjects where name = 're_mantenimiento_cb')
    drop TABLE re_mantenimiento_cb
go

/* re_mantenimiento_cupo_cb */
print 'ELIMINA TABLA ====> re_mantenimiento_cupo_cb'
go
if exists (select * from sysobjects where name = 're_mantenimiento_cupo_cb')
    drop TABLE re_mantenimiento_cupo_cb
go

/* re_marcacion_cuentas */
print 'ELIMINA TABLA ====> re_marcacion_cuentas'
go
if exists (select * from sysobjects where name = 're_marcacion_cuentas')
    drop TABLE re_marcacion_cuentas
go

/* re_masiva */
print 'ELIMINA TABLA ====> re_masiva'
go
if exists (select * from sysobjects where name = 're_masiva')
    drop TABLE re_masiva
go

/* re_medio_amb */
print 'ELIMINA TABLA ====> re_medio_amb'
go
if exists (select * from sysobjects where name = 're_medio_amb')
    drop TABLE re_medio_amb
go

/* re_movimientos_caja */
print 'ELIMINA TABLA ====> re_movimientos_caja'
go
if exists (select * from sysobjects where name = 're_movimientos_caja')
    drop TABLE re_movimientos_caja
go

/* re_ndc_auto_cabecera */
print 'ELIMINA TABLA ====> re_ndc_auto_cabecera'
go
if exists (select * from sysobjects where name = 're_ndc_auto_cabecera')
    drop TABLE re_ndc_auto_cabecera
go

/* re_ndc_automatica */
print 'ELIMINA TABLA ====> re_ndc_automatica'
go
if exists (select * from sysobjects where name = 're_ndc_automatica')
    drop TABLE re_ndc_automatica
go

/* re_ndc_judiciales */
print 'ELIMINA TABLA ====> re_ndc_judiciales'
go
if exists (select * from sysobjects where name = 're_ndc_judiciales')
    drop TABLE re_ndc_judiciales
go

/* re_nombre_bcogirado */
print 'ELIMINA TABLA ====> re_nombre_bcogirado'
go
if exists (select * from sysobjects where name = 're_nombre_bcogirado')
    drop TABLE re_nombre_bcogirado
go

/* re_numcta_extracto */
print 'ELIMINA TABLA ====> re_numcta_extracto'
go
if exists (select * from sysobjects where name = 're_numcta_extracto')
    drop TABLE re_numcta_extracto
go

/* re_ofi_banco */
print 'ELIMINA TABLA ====> re_ofi_banco'
go
if exists (select * from sysobjects where name = 're_ofi_banco')
    drop TABLE re_ofi_banco
go

/* re_ofi_personal */
print 'ELIMINA TABLA ====> re_ofi_personal'
go
if exists (select * from sysobjects where name = 're_ofi_personal')
    drop TABLE re_ofi_personal
go

/* re_ofi_safe */
print 'ELIMINA TABLA ====> re_ofi_safe'
go
if exists (select * from sysobjects where name = 're_ofi_safe')
    drop TABLE re_ofi_safe
go

/* re_ofibco_canjdir */
print 'ELIMINA TABLA ====> re_ofibco_canjdir'
go
if exists (select * from sysobjects where name = 're_ofibco_canjdir')
    drop TABLE re_ofibco_canjdir
go

/* re_oficina_canje */
print 'ELIMINA TABLA ====> re_oficina_canje'
go
if exists (select * from sysobjects where name = 're_oficina_canje')
    drop TABLE re_oficina_canje
go

/* re_oficina_virtual */
print 'ELIMINA TABLA ====> re_oficina_virtual'
go
if exists (select * from sysobjects where name = 're_oficina_virtual')
    drop TABLE re_oficina_virtual
go

/* re_orden_caja */
print 'ELIMINA TABLA ====> re_orden_caja'
go
if exists (select * from sysobjects where name = 're_orden_caja')
    drop TABLE re_orden_caja
go

/* re_orden_pago_cobro */
print 'ELIMINA TABLA ====> re_orden_pago_cobro'
go
if exists (select * from sysobjects where name = 're_orden_pago_cobro')
    drop TABLE re_orden_pago_cobro
go

/* re_paquete */
print 'ELIMINA TABLA ====> re_paquete'
go
if exists (select * from sysobjects where name = 're_paquete')
    drop TABLE re_paquete
go

/* re_param_ex */
print 'ELIMINA TABLA ====> re_param_ex'
go
if exists (select * from sysobjects where name = 're_param_ex')
    drop TABLE re_param_ex
go

/* re_parametro_extracto */
print 'ELIMINA TABLA ====> re_parametro_extracto'
go
if exists (select * from sysobjects where name = 're_parametro_extracto')
    drop TABLE re_parametro_extracto
go

/* re_perfil_exepcion */
print 'ELIMINA TABLA ====> re_perfil_exepcion'
go
if exists (select * from sysobjects where name = 're_perfil_exepcion')
    drop TABLE re_perfil_exepcion
go

/* re_peticiones_efectivo */
print 'ELIMINA TABLA ====> re_peticiones_efectivo'
go
if exists (select * from sysobjects where name = 're_peticiones_efectivo')
    drop TABLE re_peticiones_efectivo
go

/* re_procesa_cenit */
print 'ELIMINA TABLA ====> re_procesa_cenit'
go
if exists (select * from sysobjects where name = 're_procesa_cenit')
    drop TABLE re_procesa_cenit
go

/* re_procesar_pagos_bv */
print 'ELIMINA TABLA ====> re_procesar_pagos_bv'
go
if exists (select * from sysobjects where name = 're_procesar_pagos_bv')
    drop TABLE re_procesar_pagos_bv
go

/* re_prodbanc_rep */
print 'ELIMINA TABLA ====> re_prodbanc_rep'
go
if exists (select * from sysobjects where name = 're_prodbanc_rep')
    drop TABLE re_prodbanc_rep
go

/* re_producto_cliente */
print 'ELIMINA TABLA ====> re_producto_cliente'
go
if exists (select * from sysobjects where name = 're_producto_cliente')
    drop TABLE re_producto_cliente
go

/* re_propiedad_ndc */
print 'ELIMINA TABLA ====> re_propiedad_ndc'
go
if exists (select * from sysobjects where name = 're_propiedad_ndc')
    drop TABLE re_propiedad_ndc
go

/* re_propiedad_ndc_cca523 */
print 'ELIMINA TABLA ====> re_propiedad_ndc_cca523'
go
if exists (select * from sysobjects where name = 're_propiedad_ndc_cca523')
    drop TABLE re_propiedad_ndc_cca523
go

/* re_punto_red_cb */
print 'ELIMINA TABLA ====> re_punto_red_cb'
go
if exists (select * from sysobjects where name = 're_punto_red_cb')
    drop TABLE re_punto_red_cb
go

/* re_punto_red_cb_tmp */
print 'ELIMINA TABLA ====> re_punto_red_cb_tmp'
go
if exists (select * from sysobjects where name = 're_punto_red_cb_tmp')
    drop TABLE re_punto_red_cb_tmp
go

/* re_rechazo_tran */
print 'ELIMINA TABLA ====> re_rechazo_tran'
go
if exists (select * from sysobjects where name = 're_rechazo_tran')
    drop TABLE re_rechazo_tran
go

/* re_reclasificados */
print 'ELIMINA TABLA ====> re_reclasificados'
go
if exists (select * from sysobjects where name = 're_reclasificados')
    drop TABLE re_reclasificados
go

/* re_reg_equivalencia */
print 'ELIMINA TABLA ====> re_reg_equivalencia'
go
if exists (select * from sysobjects where name = 're_reg_equivalencia')
    drop TABLE re_reg_equivalencia
go

/* re_reintegro_dtn */
print 'ELIMINA TABLA ====> re_reintegro_dtn'
go
if exists (select * from sysobjects where name = 're_reintegro_dtn')
    drop TABLE re_reintegro_dtn
go

/* re_relacion_cta_canal */
print 'ELIMINA TABLA ====> re_relacion_cta_canal'
go
if exists (select * from sysobjects where name = 're_relacion_cta_canal')
    drop TABLE re_relacion_cta_canal
go

/* re_relacion_cta_canal_CCA557 */
print 'ELIMINA TABLA ====> re_relacion_cta_canal_CCA557'
go
if exists (select * from sysobjects where name = 're_relacion_cta_canal_CCA557')
    drop TABLE re_relacion_cta_canal_CCA557
go

/* re_relacion_cta_canal_ors_001209 */
print 'ELIMINA TABLA ====> re_relacion_cta_canal_ors_001209'
go
if exists (select * from sysobjects where name = 're_relacion_cta_canal_ors_001209')
    drop TABLE re_relacion_cta_canal_ors_001209
go

/* re_relacion_cta_canal_respaldo */
print 'ELIMINA TABLA ====> re_relacion_cta_canal_respaldo'
go
if exists (select * from sysobjects where name = 're_relacion_cta_canal_respaldo')
    drop TABLE re_relacion_cta_canal_respaldo
go

/* re_rembolso_bcocedente */
print 'ELIMINA TABLA ====> re_rembolso_bcocedente'
go
if exists (select * from sysobjects where name = 're_rembolso_bcocedente')
    drop TABLE re_rembolso_bcocedente
go

/* re_rembolso_bcocedente_tmp */
print 'ELIMINA TABLA ====> re_rembolso_bcocedente_tmp'
go
if exists (select * from sysobjects where name = 're_rembolso_bcocedente_tmp')
    drop TABLE re_rembolso_bcocedente_tmp
go

/* re_rembolso_corresponsal */
print 'ELIMINA TABLA ====> re_rembolso_corresponsal'
go
if exists (select * from sysobjects where name = 're_rembolso_corresponsal')
    drop TABLE re_rembolso_corresponsal
go

/* re_remesa_mensual */
print 'ELIMINA TABLA ====> re_remesa_mensual'
go
if exists (select * from sysobjects where name = 're_remesa_mensual')
    drop TABLE re_remesa_mensual
go

/* re_remisoria */
print 'ELIMINA TABLA ====> re_remisoria'
go
if exists (select * from sysobjects where name = 're_remisoria')
    drop TABLE re_remisoria
go

/* re_rep_int_ctas_dtn_cab */
print 'ELIMINA TABLA ====> re_rep_int_ctas_dtn_cab'
go
if exists (select * from sysobjects where name = 're_rep_int_ctas_dtn_cab')
    drop TABLE re_rep_int_ctas_dtn_cab
go

/* re_rep_int_ctas_dtn_det */
print 'ELIMINA TABLA ====> re_rep_int_ctas_dtn_det'
go
if exists (select * from sysobjects where name = 're_rep_int_ctas_dtn_det')
    drop TABLE re_rep_int_ctas_dtn_det
go

/* re_rep_reint_gmf */
print 'ELIMINA TABLA ====> re_rep_reint_gmf'
go
if exists (select * from sysobjects where name = 're_rep_reint_gmf')
    drop TABLE re_rep_reint_gmf
go

/* re_reporte_servicios_cab */
print 'ELIMINA TABLA ====> re_reporte_servicios_cab'
go
if exists (select * from sysobjects where name = 're_reporte_servicios_cab')
    drop TABLE re_reporte_servicios_cab
go

/* re_reporte_servicios_cab_vigente */
print 'ELIMINA TABLA ====> re_reporte_servicios_cab_vigente'
go
if exists (select * from sysobjects where name = 're_reporte_servicios_cab_vigente')
    drop TABLE re_reporte_servicios_cab_vigente
go

/* re_reporte_servicios_det */
print 'ELIMINA TABLA ====> re_reporte_servicios_det'
go
if exists (select * from sysobjects where name = 're_reporte_servicios_det')
    drop TABLE re_reporte_servicios_det
go

/* re_reporte_servicios_det_vigente */
print 'ELIMINA TABLA ====> re_reporte_servicios_det_vigente'
go
if exists (select * from sysobjects where name = 're_reporte_servicios_det_vigente')
    drop TABLE re_reporte_servicios_det_vigente
go

/* re_reporte_tdebito_cab */
print 'ELIMINA TABLA ====> re_reporte_tdebito_cab'
go
if exists (select * from sysobjects where name = 're_reporte_tdebito_cab')
    drop TABLE re_reporte_tdebito_cab
go

/* re_reporte_tdebito_det */
print 'ELIMINA TABLA ====> re_reporte_tdebito_det'
go
if exists (select * from sysobjects where name = 're_reporte_tdebito_det')
    drop TABLE re_reporte_tdebito_det
go

/* re_reporte_tdebito_mensual_cab */
print 'ELIMINA TABLA ====> re_reporte_tdebito_mensual_cab'
go
if exists (select * from sysobjects where name = 're_reporte_tdebito_mensual_cab')
    drop TABLE re_reporte_tdebito_mensual_cab
go

/* re_reporte_tdebito_mensual_det */
print 'ELIMINA TABLA ====> re_reporte_tdebito_mensual_det'
go
if exists (select * from sysobjects where name = 're_reporte_tdebito_mensual_det')
    drop TABLE re_reporte_tdebito_mensual_det
go

/* re_retencion */
print 'ELIMINA TABLA ====> re_retencion'
go
if exists (select * from sysobjects where name = 're_retencion')
    drop TABLE re_retencion
go

/* re_ruta */
print 'ELIMINA TABLA ====> re_ruta'
go
if exists (select * from sysobjects where name = 're_ruta')
    drop TABLE re_ruta
go

/* re_saldo_bcocedente */
print 'ELIMINA TABLA ====> re_saldo_bcocedente'
go
if exists (select * from sysobjects where name = 're_saldo_bcocedente')
    drop TABLE re_saldo_bcocedente
go

/* re_saldo_contable */
print 'ELIMINA TABLA ====> re_saldo_contable'
go
if exists (select * from sysobjects where name = 're_saldo_contable')
    drop TABLE re_saldo_contable
go

/* re_saldo_corresponsales */
print 'ELIMINA TABLA ====> re_saldo_corresponsales'
go
if exists (select * from sysobjects where name = 're_saldo_corresponsales')
    drop TABLE re_saldo_corresponsales
go

/* re_saldo_cuenta */
print 'ELIMINA TABLA ====> re_saldo_cuenta'
go
if exists (select * from sysobjects where name = 're_saldo_cuenta')
    drop TABLE re_saldo_cuenta
go

/* re_saldos_caja */
print 'ELIMINA TABLA ====> re_saldos_caja'
go
if exists (select * from sysobjects where name = 're_saldos_caja')
    drop TABLE re_saldos_caja
go

/* re_saldos_caja_ticket_0248636 */
print 'ELIMINA TABLA ====> re_saldos_caja_ticket_0248636'
go
if exists (select * from sysobjects where name = 're_saldos_caja_ticket_0248636')
    drop TABLE re_saldos_caja_ticket_0248636
go

/* re_sec_paquete */
print 'ELIMINA TABLA ====> re_sec_paquete'
go
if exists (select * from sysobjects where name = 're_sec_paquete')
    drop TABLE re_sec_paquete
go

/* re_ssn_batch */
print 'ELIMINA TABLA ====> re_ssn_batch'
go
if exists (select * from sysobjects where name = 're_ssn_batch')
    drop TABLE re_ssn_batch
go

/* re_supervisor */
print 'ELIMINA TABLA ====> re_supervisor'
go
if exists (select * from sysobjects where name = 're_supervisor')
    drop TABLE re_supervisor
go

/* re_tesoro_nacional */
print 'ELIMINA TABLA ====> re_tesoro_nacional'
go
if exists (select * from sysobjects where name = 're_tesoro_nacional')
    drop TABLE re_tesoro_nacional
go

/* re_tesoro_nacional_ors_1132_1 */
print 'ELIMINA TABLA ====> re_tesoro_nacional_ors_1132_1'
go
if exists (select * from sysobjects where name = 're_tesoro_nacional_ors_1132_1')
    drop TABLE re_tesoro_nacional_ors_1132_1
go

/* re_tesoro_nacional_ors_1132_2 */
print 'ELIMINA TABLA ====> re_tesoro_nacional_ors_1132_2'
go
if exists (select * from sysobjects where name = 're_tesoro_nacional_ors_1132_2')
    drop TABLE re_tesoro_nacional_ors_1132_2
go

/* re_tesoro_nacional_ors_1288 */
print 'ELIMINA TABLA ====> re_tesoro_nacional_ors_1288'
go
if exists (select * from sysobjects where name = 're_tesoro_nacional_ors_1288')
    drop TABLE re_tesoro_nacional_ors_1288
go

/* re_tesoro_nacional_ors_1295 */
print 'ELIMINA TABLA ====> re_tesoro_nacional_ors_1295'
go
if exists (select * from sysobjects where name = 're_tesoro_nacional_ors_1295')
    drop TABLE re_tesoro_nacional_ors_1295
go

/* re_tesoro_nacional_ors_1295_re */
print 'ELIMINA TABLA ====> re_tesoro_nacional_ors_1295_re'
go
if exists (select * from sysobjects where name = 're_tesoro_nacional_ors_1295_re')
    drop TABLE re_tesoro_nacional_ors_1295_re
go

/* re_total */
print 'ELIMINA TABLA ====> re_total'
go
if exists (select * from sysobjects where name = 're_total')
    drop TABLE re_total
go

/* re_total_auxilio */
print 'ELIMINA TABLA ====> re_total_auxilio'
go
if exists (select * from sysobjects where name = 're_total_auxilio')
    drop TABLE re_total_auxilio
go

/* re_total_bv */
print 'ELIMINA TABLA ====> re_total_bv'
go
if exists (select * from sysobjects where name = 're_total_bv')
    drop TABLE re_total_bv
go

/* re_total_rem */
print 'ELIMINA TABLA ====> re_total_rem'
go
if exists (select * from sysobjects where name = 're_total_rem')
    drop TABLE re_total_rem
go

/* re_totales_canje */
print 'ELIMINA TABLA ====> re_totales_canje'
go
if exists (select * from sysobjects where name = 're_totales_canje')
    drop TABLE re_totales_canje
go

/* re_totales_remesas */
print 'ELIMINA TABLA ====> re_totales_remesas'
go
if exists (select * from sysobjects where name = 're_totales_remesas')
    drop TABLE re_totales_remesas
go

/* re_tran_conta */
print 'ELIMINA TABLA ====> re_tran_conta'
go
if exists (select * from sysobjects where name = 're_tran_conta')
    drop TABLE re_tran_conta
go

/* re_tran_contable */
print 'ELIMINA TABLA ====> re_tran_contable'
go
if exists (select * from sysobjects where name = 're_tran_contable')
    drop TABLE re_tran_contable
go

/* re_tran_contable_bck_camara */
print 'ELIMINA TABLA ====> re_tran_contable_bck_camara'
go
if exists (select * from sysobjects where name = 're_tran_contable_bck_camara')
    drop TABLE re_tran_contable_bck_camara
go

/* re_tran_contable_tmp_ins */
print 'ELIMINA TABLA ====> re_tran_contable_tmp_ins'
go
if exists (select * from sysobjects where name = 're_tran_contable_tmp_ins')
    drop TABLE re_tran_contable_tmp_ins
go

/* re_tran_equiv_bv */
print 'ELIMINA TABLA ====> re_tran_equiv_bv'
go
if exists (select * from sysobjects where name = 're_tran_equiv_bv')
    drop TABLE re_tran_equiv_bv
go

/* re_tran_interfase */
print 'ELIMINA TABLA ====> re_tran_interfase'
go
if exists (select * from sysobjects where name = 're_tran_interfase')
    drop TABLE re_tran_interfase
go

/* re_tran_monet_atm */
print 'ELIMINA TABLA ====> re_tran_monet_atm'
go
if exists (select * from sysobjects where name = 're_tran_monet_atm')
    drop TABLE re_tran_monet_atm
go

/* re_tran_monet_bv */
print 'ELIMINA TABLA ====> re_tran_monet_bv'
go
if exists (select * from sysobjects where name = 're_tran_monet_bv')
    drop TABLE re_tran_monet_bv
go

/* re_tran_monet_tmp_atm */
print 'ELIMINA TABLA ====> re_tran_monet_tmp_atm'
go
if exists (select * from sysobjects where name = 're_tran_monet_tmp_atm')
    drop TABLE re_tran_monet_tmp_atm
go

/* re_tran_punto */
print 'ELIMINA TABLA ====> re_tran_punto'
go
if exists (select * from sysobjects where name = 're_tran_punto')
    drop TABLE re_tran_punto
go

/* re_tran_servicio */
print 'ELIMINA TABLA ====> re_tran_servicio'
go
if exists (select * from sysobjects where name = 're_tran_servicio')
    drop TABLE re_tran_servicio
go

/* re_trans_alerta */
print 'ELIMINA TABLA ====> re_trans_alerta'
go
if exists (select * from sysobjects where name = 're_trans_alerta')
    drop TABLE re_trans_alerta
go

/* re_transfer_automatica */
print 'ELIMINA TABLA ====> re_transfer_automatica'
go
if exists (select * from sysobjects where name = 're_transfer_automatica')
    drop TABLE re_transfer_automatica
go

/* re_transito */
print 'ELIMINA TABLA ====> re_transito'
go
if exists (select * from sysobjects where name = 're_transito')
    drop TABLE re_transito
go

/* re_traslado */
print 'ELIMINA TABLA ====> re_traslado'
go
if exists (select * from sysobjects where name = 're_traslado')
    drop TABLE re_traslado
go

/* re_trn_causa_atm */
print 'ELIMINA TABLA ====> re_trn_causa_atm'
go
if exists (select * from sysobjects where name = 're_trn_causa_atm')
    drop TABLE re_trn_causa_atm
go

/* re_trn_causa_bvirtual */
print 'ELIMINA TABLA ====> re_trn_causa_bvirtual'
go
if exists (select * from sysobjects where name = 're_trn_causa_bvirtual')
    drop TABLE re_trn_causa_bvirtual
go

/* re_trn_contable */
print 'ELIMINA TABLA ====> re_trn_contable'
go
if exists (select * from sysobjects where name = 're_trn_contable')
    drop TABLE re_trn_contable
go

/* re_trn_contable_inc */
print 'ELIMINA TABLA ====> re_trn_contable_inc'
go
if exists (select * from sysobjects where name = 're_trn_contable_inc')
    drop TABLE re_trn_contable_inc
go

/* re_trn_grupo */
print 'ELIMINA TABLA ====> re_trn_grupo'
go
if exists (select * from sysobjects where name = 're_trn_grupo')
    drop TABLE re_trn_grupo
go

/* re_trn_perfil */
print 'ELIMINA TABLA ====> re_trn_perfil'
go
if exists (select * from sysobjects where name = 're_trn_perfil')
    drop TABLE re_trn_perfil
go

/* re_valida_datos_offline */
print 'ELIMINA TABLA ====> re_valida_datos_offline'
go
if exists (select * from sysobjects where name = 're_valida_datos_offline')
    drop TABLE re_valida_datos_offline
go

/* re_validacion_monto */
print 'ELIMINA TABLA ====> re_validacion_monto'
go
if exists (select * from sysobjects where name = 're_validacion_monto')
    drop TABLE re_validacion_monto
go

/* reexpresion_saldo */
print 'ELIMINA TABLA ====> reexpresion_saldo'
go
if exists (select * from sysobjects where name = 'reexpresion_saldo')
    drop TABLE reexpresion_saldo
go

/* saldo */
print 'ELIMINA TABLA ====> saldo'
go
if exists (select * from sysobjects where name = 'saldo')
    drop TABLE saldo
go

/* saldo_pago_declar_ret_tmp */
print 'ELIMINA TABLA ====> saldo_pago_declar_ret_tmp'
go
if exists (select * from sysobjects where name = 'saldo_pago_declar_ret_tmp')
    drop TABLE saldo_pago_declar_ret_tmp
go

/* saldoiva */
print 'ELIMINA TABLA ====> saldoiva'
go
if exists (select * from sysobjects where name = 'saldoiva')
    drop TABLE saldoiva
go

/* saldos_aux */
print 'ELIMINA TABLA ====> saldos_aux'
go
if exists (select * from sysobjects where name = 'saldos_aux')
    drop TABLE saldos_aux
go

/* salter_def */
print 'ELIMINA TABLA ====> salter_def'
go
if exists (select * from sysobjects where name = 'salter_def')
    drop TABLE salter_def
go

/* sysdiagrams */
print 'ELIMINA TABLA ====> sysdiagrams'
go
if exists (select * from sysobjects where name = 'sysdiagrams')
    drop TABLE sysdiagrams
go

/* t_reexp */
print 'ELIMINA TABLA ====> t_reexp'
go
if exists (select * from sysobjects where name = 't_reexp')
    drop TABLE t_reexp
go

/* temporal_cb_asiento */
print 'ELIMINA TABLA ====> temporal_cb_asiento'
go
if exists (select * from sysobjects where name = 'temporal_cb_asiento')
    drop TABLE temporal_cb_asiento
go

/* tmp_cb_hist_saldo */
print 'ELIMINA TABLA ====> tmp_cb_hist_saldo'
go
if exists (select * from sysobjects where name = 'tmp_cb_hist_saldo')
    drop TABLE tmp_cb_hist_saldo
go

/* tmp_cb_hist_saldo2 */
print 'ELIMINA TABLA ====> tmp_cb_hist_saldo2'
go
if exists (select * from sysobjects where name = 'tmp_cb_hist_saldo2')
    drop TABLE tmp_cb_hist_saldo2
go

/* tmp_cb_saldo_promm */
print 'ELIMINA TABLA ====> tmp_cb_saldo_promm'
go
if exists (select * from sysobjects where name = 'tmp_cb_saldo_promm')
    drop TABLE tmp_cb_saldo_promm
go

/* tmp_cb_saldo_ter */
print 'ELIMINA TABLA ====> tmp_cb_saldo_ter'
go
if exists (select * from sysobjects where name = 'tmp_cb_saldo_ter')
    drop TABLE tmp_cb_saldo_ter
go

/* tmp_cb_saldo_ter2 */
print 'ELIMINA TABLA ====> tmp_cb_saldo_ter2'
go
if exists (select * from sysobjects where name = 'tmp_cb_saldo_ter2')
    drop TABLE tmp_cb_saldo_ter2
go

/* tmp_comp_asientos */
print 'ELIMINA TABLA ====> tmp_comp_asientos'
go
if exists (select * from sysobjects where name = 'tmp_comp_asientos')
    drop TABLE tmp_comp_asientos
go

/* tmp_cuentas */
print 'ELIMINA TABLA ====> tmp_cuentas'
go
if exists (select * from sysobjects where name = 'tmp_cuentas')
    drop TABLE tmp_cuentas
go

/* tmp_cuentas_re */
print 'ELIMINA TABLA ====> tmp_cuentas_re'
go
if exists (select * from sysobjects where name = 'tmp_cuentas_re')
    drop TABLE tmp_cuentas_re
go

/* tmp_limites_caja */
print 'ELIMINA TABLA ====> tmp_limites_caja'
go
if exists (select * from sysobjects where name = 'tmp_limites_caja')
    drop TABLE tmp_limites_caja
go

/* tmp_paralelo */
print 'ELIMINA TABLA ====> tmp_paralelo'
go
if exists (select * from sysobjects where name = 'tmp_paralelo')
    drop TABLE tmp_paralelo
go

/* tmp_re_tesoro_nacional */
print 'ELIMINA TABLA ====> tmp_re_tesoro_nacional'
go
if exists (select * from sysobjects where name = 'tmp_re_tesoro_nacional')
    drop TABLE tmp_re_tesoro_nacional
go

/* tmp_saldo_traslado */
print 'ELIMINA TABLA ====> tmp_saldo_traslado'
go
if exists (select * from sysobjects where name = 'tmp_saldo_traslado')
    drop TABLE tmp_saldo_traslado
go

/* tmp_sasiento */
print 'ELIMINA TABLA ====> tmp_sasiento'
go
if exists (select * from sysobjects where name = 'tmp_sasiento')
    drop TABLE tmp_sasiento
go

/* tmp_siento_comp */
print 'ELIMINA TABLA ====> tmp_siento_comp'
go
if exists (select * from sysobjects where name = 'tmp_siento_comp')
    drop TABLE tmp_siento_comp
go

/* tmp_tran_ter */
print 'ELIMINA TABLA ====> tmp_tran_ter'
go
if exists (select * from sysobjects where name = 'tmp_tran_ter')
    drop TABLE tmp_tran_ter
go

/* tmp_trn_mes_bk */
print 'ELIMINA TABLA ====> tmp_trn_mes_bk'
go
if exists (select * from sysobjects where name = 'tmp_trn_mes_bk')
    drop TABLE tmp_trn_mes_bk
go

/* total_res_ah */
print 'ELIMINA TABLA ====> total_res_ah'
go
if exists (select * from sysobjects where name = 'total_res_ah')
    drop TABLE total_res_ah
go

/* total_res_ahmon */
print 'ELIMINA TABLA ====> total_res_ahmon'
go
if exists (select * from sysobjects where name = 'total_res_ahmon')
    drop TABLE total_res_ahmon
go

/* total_res_ahterc */
print 'ELIMINA TABLA ====> total_res_ahterc'
go
if exists (select * from sysobjects where name = 'total_res_ahterc')
    drop TABLE total_res_ahterc
go

/* total_res_cc */
print 'ELIMINA TABLA ====> total_res_cc'
go
if exists (select * from sysobjects where name = 'total_res_cc')
    drop TABLE total_res_cc
go

/* total_res_cc_te */
print 'ELIMINA TABLA ====> total_res_cc_te'
go
if exists (select * from sysobjects where name = 'total_res_cc_te')
    drop TABLE total_res_cc_te
go

/* total_res_moncc */
print 'ELIMINA TABLA ====> total_res_moncc'
go
if exists (select * from sysobjects where name = 'total_res_moncc')
    drop TABLE total_res_moncc
go

/* ts_regimen_fiscal */
print 'ELIMINA TABLA ====> ts_regimen_fiscal'
go
if exists (select * from sysobjects where name = 'ts_regimen_fiscal')
    drop TABLE ts_regimen_fiscal
go

/* ts_tran_serv_pag_decl */
print 'ELIMINA TABLA ====> ts_tran_serv_pag_decl'
go
if exists (select * from sysobjects where name = 'ts_tran_serv_pag_decl')
    drop TABLE ts_tran_serv_pag_decl
go

/* prodiva */
print 'ELIMINA TABLA ====> prodiva'
go
if exists (select * from sysobjects where name = 'prodiva')
    drop TABLE prodiva
go

/* prueba_part */
print 'ELIMINA TABLA ====> prueba_part'
go
if exists (select * from sysobjects where name = 'prueba_part')
    drop TABLE prueba_part
go

/* re_detalle_cheque */
print 'ELIMINA TABLA ====> re_detalle_cheque'
if exists (select 1 from sysobjects where name = 're_detalle_cheque' and type = 'U')
   drop table re_detalle_cheque
go
