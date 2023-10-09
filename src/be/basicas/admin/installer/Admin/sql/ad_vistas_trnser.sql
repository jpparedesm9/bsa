/************************************************************************/
/*                   MODIFICACIONES                                     */
/*      FECHA          AUTOR              RAZON                         */
/*      12/ABR/2016     BBO             Migracion SYBASE-SQLServer FAL  */
/************************************************************************/

/****************************************************************************/
/*                         create table  ad_vistas_trnser            */
/****************************************************************************/
set nocount on
go

use cobis
go

truncate table ad_vistas_trnser 
go

print '---> Insertando los datos de las vistas en tabla ad_vistas_trnser'
insert into ad_vistas_trnser values (4, 'cob_ahorros', 'ah_tsanulalib', 'ANULACIÓN DE LIBRETA DE AHORROS', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'saldo', 'moneda', null) 
go
insert into ad_vistas_trnser values (4, 'cob_ahorros', 'ah_tsapertura', 'APERTURA DE CUENTA DE AHORROS', 'V', 'tsfecha', 'secuencial', 'clase', 'N', 'P', 'A',  null, 'usuario', 'terminal', 'monto', 'moneda', null) 
go
insert into ad_vistas_trnser values (4, 'cob_ahorros', 'ah_tsbloqueo', 'CONTROL DE BLOQUEOS DE CUENTA DE AHORROS', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 
go
insert into ad_vistas_trnser values (4, 'cob_ahorros', 'ah_tscalcul_inter', 'ACUMULACION DE INTERES AHORROS', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 
go
insert into ad_vistas_trnser values (4, 'cob_ahorros', 'ah_tscambia_estado', 'CAMBIO DE ESTADO AHORROS', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 
go
insert into ad_vistas_trnser values (4, 'cob_ahorros', 'ah_tscierre_cta', 'CIERRE DE CUENTAS AHORROS', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'saldo', 'moneda', null) 
go
insert into ad_vistas_trnser values (4, 'cob_ahorros', 'ah_tscliente_ctahorro', 'MANTENIMIENTO CLIENTES EN CUENTAS DE AHORROS', 'V', 'tsfecha', 'secuencial', 'clase', 'N',  null,  null, 'B', 'usuario', 'terminal',  null, 'moneda', null) 
go
insert into ad_vistas_trnser values (4, 'cob_ahorros', 'ah_tsconsumo', 'BLOQUEOS POR CONSUMOS AHORROS', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 
go
insert into ad_vistas_trnser values (4, 'cob_ahorros', 'ah_tsgerencia', 'CONTROL DE EMISION DE CHEQUES DE GERENCIA', 'V', 'fecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 
go
insert into ad_vistas_trnser values (4, 'cob_ahorros', 'ah_tspag_otrobanco', 'TRANSF ENTRE CTAS OTROS BANCOS', 'V', 'fecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 
go
insert into ad_vistas_trnser values (4, 'cob_ahorros', 'ah_tsrem_chequeconf', 'CONFIRMACION DE CHEQUES DE REMESAS', 'V', 'fecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 
go
insert into ad_vistas_trnser values (4, 'cob_ahorros', 'ah_tsrem_chequedev', 'CONTROL CHQ DEV REMESAS AHORROS', 'V', 'fecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 
go
insert into ad_vistas_trnser values (4, 'cob_ahorros', 'ah_tsrem_ingresochq', 'INGRESO DE CHEQUES EN CARTA REMESA', 'V', 'fecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 
go
insert into ad_vistas_trnser values (4, 'cob_ahorros', 'ah_tssobregiro', 'CONTROL DEPOSITO CHQ LOCALES AHORROS', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'monto_aut', 'moneda', null) 
go
insert into ad_vistas_trnser values (4, 'cob_ahorros', 'ah_tssolape', 'SOLICITUD APERTURA AHORROS', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal',  null, 'moneda', null) 
go
insert into ad_vistas_trnser values (4, 'cob_ahorros', 'ah_tssolicita_ec', 'COBRO SOLICITUD ESTADO CTA AHORROS', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal',  null, 'moneda', null) 
go
insert into ad_vistas_trnser values (4, 'cob_ahorros', 'ah_tsval_suspenso', 'VALORES EN SUSPENSO POR SERVICIO O EFECTO', 'V', 'fecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 
go
insert into ad_vistas_trnser values (7, 'cob_cartera', 'ca_default_toperacion_ts', 'CONTROL DEFAULT TIPO OPER CARTERA', 'U', 'dts_fecha_proceso_ts', 'dts_plazo',  null,  null,  null,  null,  null, 'dts_usuario_ts', 'dts_terminal_ts',  null, 'dts_moneda', null)
go
insert into ad_vistas_trnser values (7, 'cob_cartera', 'ca_dividendo_ts', 'MANTENIMIENTO DE DIVIDENDOS CARTERA', 'U', 'dis_fecha_proceso_ts', 'dis_operacion',  null,  null,  null,  null,  null, 'dis_usuario_ts', 'dis_terminal_ts',  null,  null, null) 
go
insert into ad_vistas_trnser values (7, 'cob_cartera', 'ca_estados_man_ts', 'MANTENIMIENTO DE ESTADOS CARTERA', 'U', 'ems_fecha_proceso_ts', 'ems_estado_ini',  null,  null,  null,  null,  null, 'ems_usuario_ts', 'ems_terminal_ts',  null,  null, null) 
go
insert into ad_vistas_trnser values (7, 'cob_cartera', 'ca_estados_rubro_ts', 'MANTENIMIENTO DE ESTADOS DE RUBROS CARTERA', 'U', 'ers_fecha_proceso_ts', 'ers_dias_cont',  null,  null,  null,  null,  null, 'ers_usuario_ts', 'ers_terminal_ts',  null,  null, null) 
go
insert into ad_vistas_trnser values (7, 'cob_cartera', 'ca_operacion_ts', 'MANTENIMIENTO OPERACIONES CARTERA', 'U', 'ops_fecha_proceso_ts', 'ops_operacion',  null,  null,  null,  null,  null, 'ops_usuario_ts', 'ops_terminal_ts', 'ops_monto', 'ops_moneda', null)
go
insert into ad_vistas_trnser values (7, 'cob_cartera', 'ca_rango_referencial_ts', 'MANTENIMIENTO RANGOS REFERENCIALES CARTERA', 'U', 'rrs_fecha_proceso_ts', 'rrs_secuencial',  null,  null,  null,  null,  null, 'rrs_usuario_ts', 'rrs_terminal_ts', 'rrs_valor', 'rrs_moneda', null)
go
insert into ad_vistas_trnser values (7, 'cob_cartera', 'ca_reajuste_det_ts', 'MANTENIMIENTO DETALLES DE REAJUSTES CARTERA', 'U', 'reds_fecha_proceso_ts', 'reds_operacion',  null,  null,  null,  null,  null, 'reds_usuario_ts', 'reds_terminal_ts',  null,  null, null) 
go
insert into ad_vistas_trnser values (7, 'cob_cartera', 'ca_reajuste_ts', 'MANTENIMIENTO DE REAJUSTES CARTERA', 'U', 'res_fecha_proceso_ts', 'res_operacion',  null,  null,  null,  null,  null, 'res_usuario_ts', 'res_terminal_ts',  null,  null, null) 
go
insert into ad_vistas_trnser values (7, 'cob_cartera', 'ca_rubro_op_ts', 'MANTENIMIENTO DE RUBROS POR OPERACION CARTERA', 'U', 'ros_fecha_proceso_ts', 'ros_operacion',  null,  null,  null,  null,  null, 'ros_usuario_ts', 'ros_terminal_ts', 'ros_valor',  null, null) 
go
insert into ad_vistas_trnser values (7, 'cob_cartera', 'ca_rubro_ts', 'MANTENIMIENTO DE RUBROS CARTERA', 'U', 'rus_fecha_proceso_ts', 'rus_oficina_ts',  null,  null,  null,  null,  null, 'rus_usuario_ts', 'rus_terminal_ts',  null, 'rus_moneda', null)
go
insert into ad_vistas_trnser values (7, 'cob_cartera', 'ca_transaccion_ts', 'CONTROL DE TRANSACCIONES CARTERA', 'U', 'trs_fecha_proceso_ts', 'trs_operacion',  null,  null,  null,  null,  null, 'trs_usuario_ts', 'trs_terminal_ts',  null, 'trs_moneda', null)
go
insert into ad_vistas_trnser values (7, 'cob_cartera', 'ca_valor_det_ts', 'CONTROL DE DETALLE DE VALORES CARTERA', 'U', 'vds_fecha_proceso_ts', 'vds_oficina_ts',  null,  null,  null,  null,  null, 'vds_usuario_ts', 'vds_terminal_ts',  null,  null, null) 
go
insert into ad_vistas_trnser values (7, 'cob_cartera', 'ca_valor_referencial_ts', 'CONTROL DE VALORES REFERENCIALES CARTERA', 'U', 'vrs_fecha_proceso_ts', 'vrs_oficina_ts',  null,  null,  null,  null,  null, 'vrs_usuario_ts', 'vrs_terminal_ts',  null,  null, null) 
go
insert into ad_vistas_trnser values (7, 'cob_cartera', 'ca_valor_ts', 'CONTROL DE VALORES  CARTERA', 'U', 'vas_fecha_proceso_ts', 'vas_oficina_ts',  null,  null,  null,  null,  null, 'vas_usuario_ts', 'vas_terminal_ts',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_abono', 'MANTENIMIENTO DE ABONOS COMEXT', 'V', 'v_ta_fecha', 'v_ta_secuencial', 'v_ta_clase', 'N', 'P', 'A', 'B', 'v_ta_usuario', 'v_ta_terminal', 'v_ta_valor', 'v_ta_moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_banco', 'MANTENIMIENTO BANCOS CORRESPONSALES COMEXT', 'V', 'v_tb_fecha', 'v_tb_secuencial', 'v_tb_clase', 'N', 'P', 'A',  null, 'v_tb_usuario', 'v_tb_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_cobro_pendientes', 'MANTENIMIENTO COSTOS PENDIENTES COMEXT', 'V', 'v_cp_fecha', 'v_cp_secuencial', 'v_cp_clase', 'N', 'P', 'A', 'B', 'v_cp_usuario',  null,  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_codigo', 'MANTENIMIENTO CODIGOS SWIFT COMEXT', 'V', 'v_tc_fecha', 'v_tc_secuencial', 'v_tc_clase', 'N', 'P', 'A', 'B', 'v_tc_usuario', 'v_tc_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_contacto', 'CONTACTOS EN OFICINA DE BCO CORRESPONSAL COMEXT', 'V', 'v_tc_fecha', 'v_tc_secuencial', 'v_tc_clase', 'N', 'P', 'A', 'B', 'v_tc_usuario', 'v_tc_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_costo', 'MANTENIMIENTO DE COSTOS BCOS CORRESPONSALES COMEXT', 'V', 'v_to_fecha', 'v_to_secuencial', 'v_to_clase', 'N', 'P', 'A', 'B', 'v_to_usuario', 'v_to_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_cuenta_asiento', 'RELACIÓN DE CUENTAS A ASIENTOS COMEXT', 'V', 'v_tu_fecha', 'v_tu_secuencial', 'v_tu_clase', 'N', 'P', 'A', 'B', 'v_tu_usuario', 'v_tu_terminal',  null, 'v_tu_moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_cuenta_bancaria', 'CUENTAS EN BCO CORRESPONSAL COMEXT', 'V', 'v_tc_fecha', 'v_tc_secuencial', 'v_tc_clase', 'N', 'P', 'A', 'B', 'v_tc_usuario', 'v_tc_terminal',  null, 'v_tc_moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_dato_enmendado', 'MANTENIMIENTO DE DATOS ENMENDADOS COMEXT', 'V', 'v_td_fecha', 'v_td_secuencial', 'v_td_clase', 'N', 'P', 'A', 'B', 'v_td_usuario', 'v_td_terminal', 'v_td_valor', 'v_td_moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_det_saldos', 'MANTENIMIENTO DETALLE SALDOS POR CUENTA COMEXT', 'V', 'v_ds_fecha', 'v_ds_secuencial', 'v_ds_clase', 'N', 'P', 'A', 'B', 'v_ds_usuario', 'v_ds_terminal', 'v_ds_saldo', 'v_ds_moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_detalle_linea_credito', 'DETALLE DE LINEAS DE CREDITO COMEXT', 'V', 'v_td_fecha', 'v_td_secuencial', 'v_td_clase', 'N',  null,  null, 'B', 'v_td_usuario', 'v_td_terminal', 'v_td_valor', 'v_td_moneda_valor', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_detalle_pgo', 'MANTENIMIENTO DETALLES DE PAGO COMEXT', 'V', 'v_td_fecha', 'v_td_secuencial', 'v_td_clase', 'N', 'P', 'A', 'B', 'v_td_usuario', 'v_td_terminal', 'v_td_valor', 'v_td_moneda_valor', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_detalle_trn', 'MANTENIMIENTO TRANSACCIONES FINANCIERAS COMEXT', 'V', 'v_td_fecha', 'v_td_secuencial', 'v_td_clase', 'N', 'P', 'A', 'B', 'v_td_usuario', 'v_td_terminal', 'v_td_valor', 'v_td_moneda_valor', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_doc_embarque', 'MANTENIMIENTO DE DOCUMENTOS COMEXT', 'V', 'v_td_fecha', 'v_td_secuencial', 'v_td_clase', 'N',  null,  null, 'B', 'v_td_usuario', 'v_td_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_documentacion', 'MANTENIMIENTO DOCUMENTOS COMEXT', 'V', 'v_td_fecha', 'v_td_secuencial', 'v_td_clase', 'N', 'P', 'A', 'B', 'v_td_usuario', 'v_td_terminal', 'v_td_valor',  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_embarque', 'MANTENIMIENTO DE EMBARQUES COMEXT', 'V', 'v_tq_fecha', 'v_tq_secuencial', 'v_tq_clase', 'N', 'P', 'A', 'B', 'v_tq_usuario', 'v_tq_terminal', 'v_tq_valor',  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_enmienda', 'MANTENIMIENTO DE ENMIENDAS COMEXT', 'V', 'v_te_fecha', 'v_te_secuencial', 'v_te_clase', 'N', 'P', 'A', 'B', 'v_te_usuario', 'v_te_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_equivalencia', 'EQUIVALENCIAS EN MONEDA LOCAL COMEXT', 'V', 'v_te_fecha', 'v_te_secuencial', 'v_te_clase', 'N', 'P', 'A', 'B', 'v_te_usuario', 'v_te_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_financiada', 'FINANCIACION DE NEGOCIACIONES COMEXT', 'V', 'v_tf_fecha', 'v_tf_secuencial', 'v_tf_clase', 'N', 'P', 'A', 'B', 'v_tf_usuario', 'v_tf_terminal', 'v_tf_valor', 'v_tf_moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_forma_pago', 'MANENIMIENTO DE FORMAS DE PAGO COMEXT', 'V', 'v_tg_fecha', 'v_tg_secuencial', 'v_tg_clase', 'N', 'P', 'A', 'B', 'v_tg_usuario', 'v_tg_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_formulario', 'MANTENIMIENTO FORMULARIOS POR TIPO OPER COMEXT', 'V', 'v_ti_fecha', 'v_ti_secuencial', 'v_ti_clase', 'N', 'P', 'A', 'B', 'v_ti_usuario', 'v_ti_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_fp_negociacion', 'FORMAS DE PAGO DE NEGOCIACION COMEXT', 'V', 'v_tn_fecha', 'v_tn_secuencial', 'v_tn_clase', 'N', 'P', 'A', 'B', 'v_tn_usuario', 'v_tn_terminal', 'v_tn_valor', 'v_tn_moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_imp_formulario', 'IMPRESIÓN DE FORMULARIOS COMEXT', 'V', 'v_tw_fecha', 'v_tw_secuencial', 'v_tw_clase', 'N', 'P', 'A', 'B', 'v_tw_usuario', 'v_tw_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_instruccion', 'MANTENIMIENTO INSTRUCCIONES DE OPERACION COMEXT', 'V', 'v_tr_fecha', 'v_tr_secuencial', 'v_tr_clase', 'N', 'P', 'A', 'B', 'v_tr_usuario', 'v_tr_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_letra', 'MANTENIMIENTO DE LETRAS DE CAMBIO COMEXT', 'V', 'v_tl_fecha', 'v_tl_secuencial', 'v_tl_clase', 'N', 'P', 'A', 'B', 'v_tl_usuario', 'v_tl_terminal', 'v_tl_valor_letra', 'v_tl_moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_linea_credito', 'MANTENIMIENTO LIN. CREDITO BCOS CORRESPONSALES COMEXT', 'V', 'v_tt_oficina', 'v_tt_secuencial', 'v_tt_clase', 'N', 'P', 'A', 'B', 'v_tt_usuario', 'v_tt_terminal',  null, 'v_tt_moneda_lc', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_linea_credito_mov', 'MANTENIMIENTO DE MOVIMIENTOS A LIN.CRED. COMEXT', 'V', 'v_tm_fecha', 'v_tm_secuencial', 'v_tm_clase', 'N', 'P', 'A', 'B', 'v_tm_usuario', 'v_tm_terminal', 'v_tm_valor', 'v_tm_moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_mensaje_codigo', 'CÓDIGOS EN SWIFT PARA MENSAJES COMEXT', 'V', 'v_tj_fecha', 'v_tj_secuencial', 'v_tj_clase', 'N', 'P', 'A', 'B', 'v_tj_usuario', 'v_tj_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_mercancia', 'MANTENIMIENTO DE MERCADERIAS COMEXT', 'V', 'v_ti_fecha', 'v_ti_secuencial', 'v_ti_clase', 'N', 'P', 'A', 'B', 'v_ti_usuario', 'v_ti_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_motivo_cond', 'MANTENIMIENTO MOTIVOS CONDONACION COMEXT', 'V', 'v_tt_fecha', 'v_tt_secuencial', 'v_tt_clase', 'N', 'P', 'A', 'B', 'v_tt_usuario', 'v_tt_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_msg_libre', 'MANTENIMIENTO MENSAJES SWIFT LIBRE COMEXT', 'V', 'v_tx_fecha', 'v_tx_secuencial', 'v_tx_clase', 'N', 'P', 'A', 'B', 'v_tx_usuario', 'v_tx_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_negociacion', 'PRESENTACION DE DOCUMENTOS DE NEGOCIACION COMEXT', 'V', 'v_tn_fecha', 'v_tn_secuencial', 'v_tn_clase', 'N', 'P', 'A', 'B', 'v_tn_usuario', 'v_tn_terminal', 'v_tn_valor', 'v_tn_moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_nota_emision', 'DETALLE DE PAGO AL BCO. CENTRAL NOT.EMI. COMEXT', 'V', 'v_tn_fecha', 'v_tn_secuencial', 'v_tn_clase', 'N', 'P', 'A', 'B', 'v_tn_usuario', 'v_tn_terminal', 'v_tn_valor',  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_oficina', 'MANTENIMIENTO DE BANCOS CORRESPONSALES COMEXT', 'V', 'v_tf_fecha', 'v_tf_secuencial', 'v_tf_clase', 'N', 'P', 'A',  null, 'v_tf_usuario', 'v_tf_terminal',  null, 'v_tf_moneda_costos', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_oficina_moneda', 'MANTENIMIENTO DE MONEDAS BCOS CORRESPONSALES COMEXT', 'V', 'v_tm_fecha', 'v_tm_secuencial', 'v_tm_clase', 'N',  null,  null, 'B', 'v_tm_usuario', 'v_tm_terminal',  null, 'v_tm_moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_oficina_rol', 'MANTENIMIENTO DE ROL A BCO CORRESPONSAL COMEXT', 'V', 'v_tl_fecha', 'v_tl_secuencial', 'v_tl_clase', 'N',  null,  null, 'B', 'v_tl_usuario', 'v_tl_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_oper_financiada', 'OPERACIONES ASOCIADAS A UN FINANCIEMIENTO COMEXT', 'V', 'v_pf_fecha', 'v_pf_secuencial', 'v_pf_clase', 'N', 'P', 'A', 'B', 'v_pf_usuario', 'v_pf_terminal', 'v_pf_valor', 'v_pf_moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_operacion', 'MANTENIMIENTO DE OPERACIONES COMEXT', 'V', 'v_to_fecha', 'v_to_secuencial', 'v_to_clase', 'N', 'P', 'A', 'B', 'v_to_usuario', 'v_to_terminal', 'v_to_saldo', 'v_to_moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_operacion_inst', 'MANTENIMIENTO TIPOS DE INSTRUCCIÓN COMEXT', 'V', 'v_oi_fecha', 'v_oi_secuencial', 'v_oi_clase', 'N', 'P', 'A', 'B', 'v_oi_usuario', 'v_oi_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_operacion_prm', 'PARAMETROS POR TRANSACCION COMEXT', 'V', 'v_to_fecha', 'v_to_secuencial', 'v_to_clase', 'N', 'P', 'A', 'B', 'v_to_usuario', 'v_to_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_operacion_producto', 'PARAMETROS PERSONALIZADOS POR RANGO COMEXT', 'V', 'v_tv_fecha', 'v_tv_secuencial', 'v_tv_clase', 'N', 'P', 'A', 'B', 'v_tv_usuario', 'v_tv_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_operacion_rol', 'ASOCIACION DE BANCOS A ROLES DADA UNA CCI COMEXT', 'V', 'v_tr_fecha', 'v_tr_secuencial', 'v_tr_clase', 'N',  null,  null, 'B', 'v_tr_usuario', 'v_tr_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_operacion_trn', 'TIPOS DE TRANSACCION A TIPOS OPERACIÓN COMEXT', 'V', 'v_tc_fecha', 'v_tc_secuencial', 'v_tc_clase', 'N', 'P', 'A', 'B', 'v_tc_usuario', 'v_tc_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_pago', 'PAGOS COMEXT', 'V', 'v_go_fecha', 'v_go_secuencial', 'v_go_clase', 'N', 'P', 'A', 'B', 'v_go_usuario', 'v_go_terminal', 'v_go_valor', 'v_go_moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_pago_exterior', 'CANCELACIONES AL EXTERIOR COMEXT', 'V', 'v_tn_fecha', 'v_tn_secuencial', 'v_tn_clase', 'N',  null,  null, 'B', 'v_tn_usuario', 'v_tn_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_parametro', 'MANTENIMIENTO DE PARAMETROS A UNA LINEA COMEXT', 'V', 'v_tp_fecha', 'v_tp_secuencial', 'v_tp_clase', 'N', 'P', 'A',  null, 'v_tp_usuario', 'v_tp_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_parametro_contable', 'MANTENIMIENTO PARAMETROS CONTABLES COMEXT', 'V', 'v_tr_fecha', 'v_tr_secuencial', 'v_tr_clase', 'N', 'P', 'A', 'B', 'v_tr_usuario', 'v_tr_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_personalizado', 'MANTENIMIENTO PARAMETROS PERSONALIZADOS COMEXT', 'V', 'v_tp_fecha', 'v_tp_secuencial', 'v_tp_clase', 'N', 'P', 'A', 'B', 'v_tp_usuario', 'v_tp_terminal', 'v_tp_valor', 'v_tp_moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_personalizado_rango', 'COMPROBANTES CONTABILIZACION LIN.CREDITO COMEXT', 'V', 'v_pr_fecha', 'v_pr_secuencial', 'v_pr_clase', 'N', 'P', 'A', 'B', 'v_pr_usuario', 'v_pr_terminal', 'v_pr_valor', 'v_pr_moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_plazo', 'MANTENIMIENTO TIPOS DE PLAZO COMEXT', 'V', 'v_tr_fecha', 'v_tr_secuencial', 'v_tr_clase', 'N', 'P', 'A', 'B', 'v_tr_usuario', 'v_tr_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_poliza', 'MANTENIMIENTO DE POLIZAS COMEXT', 'V', 'v_tp_fecha', 'v_tp_secuencial', 'v_tp_clase', 'N', 'P', 'A', 'B', 'v_tp_usuario', 'v_tp_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_reserva_lc', 'RESERVACION CUPO LINEA CREDITO COMEXT', 'V', 'v_tr_fecha', 'v_tr_secuencial', 'v_tr_clase', 'N', 'P', 'A', 'B', 'v_tr_usuario', 'v_tr_terminal', 'v_tr_valor', 'v_tr_moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_responsable_oper', 'MANTENIMIENTO RESPONSABLE DE OPERACIÓN COMEXT', 'V', 'r_tt_fecha', 'r_tt_secuencial', 'r_tt_clase', 'N', 'P', 'A',  null, 'r_tt_usuario', 'r_tt_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_saldo_cta', 'MANTENIMIENTO SALDOS CUENTA BANCARIA COMEXT', 'V', 'v_ts_fecha', 'v_ts_secuencial', 'v_ts_clase', 'N', 'P', 'A', 'B', 'v_ts_usuario', 'v_ts_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_secuencia_etapa', 'MANTENIMIENTO SECUENCIAS DE ESTADO COMEXT', 'V', 'v_tr_fecha', 'v_tr_secuencial', 'v_tr_clase', 'N',  null,  null, 'B', 'v_tr_usuario', 'v_tr_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_subrutina', 'MANTENIMIENTO DE SUBRUTINAS COMEXT', 'V', 'v_ts_fecha', 'v_ts_secuencial', 'v_ts_clase', 'N', 'P', 'A', 'B', 'v_ts_usuario', 'v_ts_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_tdato', 'TIPOS DE DATO PARA ENMIENDA COMEXT', 'V', 'v_td_fecha', 'v_td_secuencial', 'v_td_clase', 'N', 'P', 'A', 'B', 'v_td_usuario', 'v_td_terminal', 'v_td_valor', 'v_td_moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_tdocumento', 'MANTENIMIENTO DE TIPOS DE DOCUMENTO COMEXT', 'V', 'v_tk_fecha', 'v_tk_secuencial', 'v_tk_clase', 'N', 'P', 'A', 'B', 'v_tk_usuario', 'v_tk_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_telefono', 'MANTENIMIENTO TELEFONOS BCO CORRESPONSAL COMEXT', 'V', 'v_te_fecha', 'v_te_secuencial', 'v_te_clase', 'N', 'P', 'A', 'B', 'v_te_usuario', 'v_te_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_tipo_cambio', 'TIPOS DE CAMBIO EN MONEDA LOCAL COMEXT', 'V', 'v_tt_fecha', 'v_tt_secuencial', 'v_tt_clase', 'N', 'P', 'A', 'B', 'v_tt_usuario', 'v_tt_terminal',  null, 'v_tt_moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_tmotivo_cond', 'MOTIVOS DE CONDONACION COMEXT', 'V', 'v_tt_fecha', 'v_tt_secuencial', 'v_tt_clase', 'N', 'P', 'A', 'B', 'v_tt_usuario', 'v_tt_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_toperacion_etapa', 'MANTENIMIENTO DE ESTADO A TIPOS DE OPERACIÓN COMEXT', 'V', 'v_tv_fecha', 'v_tv_secuencial', 'v_tv_clase', 'N', 'P', 'A', 'B', 'v_tv_usuario', 'v_tv_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_tpago', 'MANTENIMIENTO TIPOS DE PAGO COMEXT', 'V', 'v_tt_fecha', 'v_tt_secuencial', 'v_tt_clase', 'N', 'P', 'A', 'B', 'v_tt_usuario', 'v_tt_terminal',  null, 'v_tt_moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_traduccion', 'TRADUCCIONES PARA CODIGO SWIFT COMEXT', 'V', 'v_tt_fecha', 'v_tt_secuencial', 'v_tt_clase', 'N', 'P', 'A', 'B', 'v_tt_usuario', 'v_tt_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_transaccion', 'VALOR PARAMETRO PARA OPERACIÓN COMEXT', 'V', 'v_tt_fecha', 'v_tt_secuencial', 'v_tt_clase', 'N', 'P', 'A', 'B', 'v_tt_usuario', 'v_tt_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_uso_lc', 'MANTENIMIENTO USO LINEAS DE CREDITO COMEXT', 'V', 'v_tx_fecha', 'v_tx_secuencial', 'v_tx_clase', 'N', 'P', 'A', 'B', 'v_tx_usuario', 'v_tx_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (9, 'cob_comext', 'ce_ts_valor', 'VALOR PARAMETRO PARA OPERACIÓN COMEXT', 'V', 'v_tv_fecha', 'v_tv_secuencial', 'v_tv_clase', 'N', 'P', 'A', 'B', 'v_tv_usuario', 'v_tv_terminal', 'v_tv_valor', 'v_tv_moneda', null)
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_area', 'MANTENIMIENTO CATALOGO DE AREAS', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A', 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_asiento', 'MANTENIMIENTO DE ASIENTOS CONTABLES', 'V', 'fecha_tran', 'secuencial', 'clase', 'N', 'P', 'A',  null, 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_asoemp', 'TABLAS ASOCIADAS A CATALOGO DE EMPRESAS', 'V', 'fecha', 'secuencial', 'clase', 'N',  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_autor_trn_oper', 'AUTORIZACION DE TRANSACCIONES OPERATIVAS', 'V', 'ts_fecha', 'ts_secuencial', 'ts_clase', 'N', 'P', 'A',  null, 'ts_usuario', 'ts_terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_banco', 'MANTENIMIENTO CATALOGO DE BANCOS', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A', 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_codigo_valor', 'MANTENIMIENTO DE CODIGOS VALOR', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'N', 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_comp_elim', 'MANTENIMIENTO DE COMPROBANTES DE ELIMINACION', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A',  null, 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_comp_tipo', 'MANTENIMIENTO DE COMPROBANTES TIPO', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A', 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_comprobante', 'MANTENIMIENTO DE COMPROBANTES', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A',  null, 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_control', 'CONTROL DE INGRESO DE COMPROBANTES', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A', 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_corte', 'MANTENIMIENTO DE CORTES CONTABLES', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A',  null, 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_cotizacion', 'MANTENIMIENTO TIPOS DE CAMBIO', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A', 'B', 'usuario', 'terminal',  null, 'moneda', null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_cuenta', 'MANTENIMIENTO CATALOGO DE CUENTAS', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A', 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_cuenta_asociada', 'MANTENIMIENTO DE CUENTAS CONTABLES ASOCIADAS', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'N', 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_cuenta_presupuesto', 'MANTENIMIENTO CATALOGO DE CUENTAS PRESUPUESTO', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A', 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_cuenta_proceso', 'MANTENIMIENTO DE CUENTAS RELACIONADAS A PROCESOS', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'N', 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_diferido', 'MANTENIMIENTO DE DIFERIDOS', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A',  null, 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_dinamica', 'MANTENIMIENTO DE DINAMICA DE CUENTAS', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A', 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_empresa', 'MANTENIMIENTO CATALOGO DE EMPRESAS', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A', 'B', 'usuario', 'terminal',  null, 'moneda', null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_estcta', 'MANTENIMIENTO ESTADO DE CUENTA', 'V', 'fecha', 'secuencial', 'clase', 'N',  null,  null, 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_nivel_area', 'MANTENIMIENTO NIVELES DE AREAS', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A', 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_nivel_cuenta', 'MANTENIMIENTO NIVELES DE CUENTAS', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'N', 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_nivel_presupuesto', 'MANTENIMIENTO NIVELES DE CUENTAS PRESUPUESTO', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'N', 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_oficina', 'MANTENIMIENTO DE CATALOGO DE OFICINAS', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A', 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_organizacion', 'MANTENIMIENTO CATALOGO ORGANIZACIÓN', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A', 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_parametro', 'MANTENIMIENTO DE PARAMETROS CONTABLES', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P',  null, 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_perfil', 'MANTENIMIENTO DE PERFILES CONTABLES', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A', 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_periodo', 'MANTENIMIENTO DE PERIODOS CONTABLES', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A', 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_plan_general', 'MANTENIMIENTO PLAN GENERAL', 'V', 'fecha', 'secuencial', 'clase', 'N',  null,  null, 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_plan_general_presupuesto', 'MANTENIMIENTO PLAN GENERAL PRESUPUESTO', 'V', 'fecha', 'secuencial', 'clase', 'N',  null,  null, 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_relofi', 'MANTENIMIENTO DE RELACIONES ENTRE OFICINAS', 'V', 'fecha', 'secuencial', 'clase', 'N',  null,  null, 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_relparam', 'RELACION DE PARAMETROS CON STRING CONTABLE', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P',  null, 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (6, 'cob_conta', 'ts_saldo_presupuesto', 'MANTENIMIENTO DE SALDOS DE PRESUPUESTO', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A', 'B', 'usuario', 'terminal',  null,  null, null) 
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsapertura', 'APERTURA DE CUENTA CORRIENTE', 'V', 'tsfecha', 'secuencial', 'clase', 'N', 'P', 'A',  null, 'usuario', 'terminal', 'valor', 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tscliente_ctacte', 'MANTENIMIENTO CLIENTES EN CUENTAS CORRIENTES', 'V', 'tsfecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null, 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsbloqueo_valor', 'CONTROL DE BLOQUEOS DE CUENTA CORRIENTES DE UN VALOR', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tssolicita_ec', 'SOLICITUD APERTURA CORRIENTE', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal',  null, 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsbloqueo', 'CONTROL DE BLOQUEOS DE CUENTA CORRIENTES', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal',  null, 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tscierre_cta', 'CIERRE DE CUENTAS CORRIENTES', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal',  null, 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tssobregiro', 'CONTROL DEPOSITO CHQ LOCALES CORRIENTES', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'monto_aut', 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsnopago', 'ANULACIÓN DE CHEQUE', 'V', 'tsfecha', 'secuencial', 'clase_np',  null,  null,  null,  null, 'usuario', 'terminal',  null, 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsjustifica_cheques', 'COB_CUENTAS - CC_TSJUSTIFICA_CHEQUES', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal',  null, 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tschequera', 'COB_CUENTAS - CC_TSCHEQUERA', 'V', 'tsfecha', 'secuencial', 'clase', 'N', 'P', 'A', 'E', 'usuario', 'terminal',  null, 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsval_suspenso', 'VALORES EN SUSPENSO POR SERVICIO O EFECTO', 'V', 'fecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsot_ingegre', 'COB_CUENTAS - CC_TSOT_INGEGRE', 'V', 'fecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'efectivo', 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsgerencia', 'CONTROL DE EMISION DE CHEQUES DE GERENCIA', 'V', 'fecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tspag_otrobanco', 'TRANSF ENTRE CTAS OTROS BANCOS', 'V', 'fecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsrevocatoria', 'COB_CUENTAS - CC_TSREVOCATORIA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'val_cheque', 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsrem_ingresochq', 'INGRESO DE CHEQUES EN CARTA REMESA', 'V', 'fecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsrem_chequedev', 'CONTROL CHQ DEV REMESAS AHORROS', 'V', 'fecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tspago_cheque', 'COB_CUENTAS - CC_TSPAGO_CHEQUE', 'V', 'fecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsrem_chequeconf', 'CONFIRMACION DE CHEQUES DE REMESAS', 'V', 'fecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsrescate', 'COB_CUENTAS - CC_TSRESCATE', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tscambia_estado', 'CAMBIO DE ESTADO CTAS CORRIENTES', 'V', 'tsfecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsprotesto', 'COB_CUENTAS - CC_TSPROTESTO', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsvarios', 'COB_CUENTAS - CC_TSVARIOS', 'V', 'tsfecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsautorizacion', 'COB_CUENTAS - CC_TSAUTORIZACION', 'V', 'tsfecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tscupo', 'COB_CUENTAS - CC_TSCUPO', 'V', 'tsfecha', 'secuencial', 'clase', 'N',  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsasociada', 'COB_CUENTAS - CC_TSASOCIADA', 'V', 'tsfecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tstipochequera', 'COB_CUENTAS - CC_TSTIPOCHEQUERA', 'V', 'tsfecha', 'secuencial', 'clase', 'N',  null,  null,  null, 'usuario', 'terminal',  null, 'moneda', null)
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tssolape', 'SOLICITUD APERTURA CTAS CTES', 'V', 'tsfecha', 'secuencial', 'clase', 'N', 'P', 'A',  null, 'usuario', 'terminal',  null, 'moneda', null)
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tscalcul_inter', 'ACUMULACION DE INTERES CTAS CTES', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null)	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_ts_re_apertura', 'COB_CUENTAS - CC_TS_RE_APERTURA', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null)
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_ndc_empresa', 'COB_CUENTAS - CC_NDC_EMPRESA', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null)
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsconcentradora', 'COB_CUENTAS - CC_TSCONCENTRADORA', 'V', 'tsfecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'minimo',  null, null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsafiliacion', 'COB_CUENTAS - CC_TSAFILIACION', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsconformacion', 'COB_CUENTAS - CC_TSCONFORMACION', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor_actual', 'moneda', null)
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsdevolucionff', 'COB_CUENTAS - CC_TSDEVOLUCIONFF', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null)
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsefectivo_caja', 'COB_CUENTAS - CC_TSEFECTIVO_CAJA', 'V', 'fecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'efectivo', 'moneda', null)
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsconsumo', 'BLOQUEOS POR CONSUMOS CTAS CTES', 'V', 'tsfecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null)
go
insert into ad_vistas_trnser values (3, 'cob_cuentas', 'cc_tsdeclaracion_efectivo', 'COB_CUENTAS - CC_TSDECLARACION_EFECTIVO', 'V', 'fecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_destino_economico', 'COB_CREDITO - TS_DESTINO_ECONOMICO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_atribucion', 'COB_CREDITO - TS_ATRIBUCION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_condicion', 'COB_CREDITO - TS_CONDICION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_variables', 'COB_CREDITO - TS_VARIABLES', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor',  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_def_variables', 'COB_CREDITO - TS_DEF_VARIABLES', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_regla', 'COB_CREDITO - TS_REGLA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_etapa', 'COB_CREDITO - TS_ETAPA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_nivel_ap', 'COB_CREDITO - TS_NIVEL_AP', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'monto_min',  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_estacion', 'COB_CREDITO - TS_ESTACION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_etapa_estacion', 'COB_CREDITO - TS_ETAPA_ESTACION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_truta', 'COB_CREDITO - TS_TRUTA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_pasos', 'COB_CREDITO - TS_PASOS', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_ruta_tramite', 'COB_CREDITO - TS_RUTA_TRAMITE', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_texcepcion', 'COB_CREDITO - TS_TEXCEPCION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_tinstruccion', 'COB_CREDITO - TS_TINSTRUCCION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_req_etapa', 'COB_CREDITO - TS_REQ_ETAPA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_toperacion', 'COB_CREDITO - TS_TOPERACION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_deudores', 'COB_CREDITO - TS_DEUDORES', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_instrucciones', 'COB_CREDITO - TS_INSTRUCCIONES', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor_ins',  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_excepciones', 'COB_CREDITO - TS_EXCEPCIONES', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_observaciones', 'COB_CREDITO - TS_OBSERVACIONES', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_periodo', 'COB_CREDITO - TS_PERIODO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_calificacion', 'COB_CREDITO - TS_CALIFICACION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_confirmacion', 'COB_CREDITO - TS_CONFIRMACION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_segmento', 'COB_CREDITO - TS_SEGMENTO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_tramite', 'COB_CREDITO - TS_TRAMITE', 'V', 'fecha', 'secuencial', 'clase', 'N',  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_lin_moneda', 'COB_CREDITO - TS_LIN_MONEDA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'monto', 'moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_lin_ope', 'COB_CREDITO - TS_LIN_OPE', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_lin_ope_moneda', 'COB_CREDITO - TS_LIN_OPE_MONEDA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'monto', 'moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_linea', 'COB_CREDITO - TS_LINEA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'monto', 'moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_gar_propuesta', 'COB_CREDITO - TS_GAR_PROPUESTA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'saldo_cap_op',  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_lin_grupo', 'COB_CREDITO - TS_LIN_GRUPO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'monto',  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_gar_anteriores', 'COB_CREDITO - TS_GAR_ANTERIORES', 'V', 'fecha', 'secuencial',  null,  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_op_renovar', 'COB_CREDITO - TS_OP_RENOVAR', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'monto_original', 'moneda_original', null)
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_dato_toperacion', 'COB_CREDITO - TS_DATO_TOPERACION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_datos_tramites', 'COB_CREDITO - TS_DATOS_TRAMITES', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor',  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_imp_documento', 'COB_CREDITO - TS_IMP_DOCUMENTO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null, 'moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_documento', 'COB_CREDITO - TS_DOCUMENTO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_agenda', 'COB_CREDITO - TS_AGENDA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_problemas', 'COB_CREDITO - TS_PROBLEMAS', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_comentarios', 'COB_CREDITO - TS_COMENTARIOS', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_conclusiones', 'COB_CREDITO - TS_CONCLUSIONES', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_regula', 'COB_CREDITO - TS_REGULA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_req_tramite', 'COB_CREDITO - TS_REQ_TRAMITE', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_cobranza', 'COB_CREDITO - TS_COBRANZA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_operacion_cobranza', 'COB_CREDITO - TS_OPERACION_COBRANZA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_abogado', 'COB_CREDITO - TS_ABOGADO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_req_cobranza', 'COB_CREDITO - TS_REQ_COBRANZA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_req_estado', 'COB_CREDITO - TS_REQ_ESTADO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_costos', 'COB_CREDITO - TS_COSTOS', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_medidas_prec', 'COB_CREDITO - TS_MEDIDAS_PREC', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_acciones', 'COB_CREDITO - TS_ACCIONES', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_tel_abogado', 'COB_CREDITO - TS_TEL_ABOGADO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_cotizacion', 'COB_CREDITO - TS_COTIZACION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null)
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_tcomite', 'COB_CREDITO - TS_TCOMITE', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_miembros', 'COB_CREDITO - TS_MIEMBROS', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_param_calif', 'COB_CREDITO - TS_PARAM_CALIF', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_estado_dias', 'COB_CREDITO - TS_ESTADO_DIAS', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_gar_nueva', 'COB_CREDITO - TS_GAR_NUEVA', 'V', 'fecha', 'secuencial', 'accion',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (9, 'cob_credito', 'ts_secuencia_aprobacion', 'COB_CREDITO - TS_SECUENCIA_APROBACION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (8, 'cobis', 'ts_batch', 'PROCESOS BATCH', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (8, 'cobis', 'ts_sarta', 'SARTAS DE LOS PROCESOS BATCH', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (8, 'cobis', 'ts_sarta_batch', 'RELACION ENTRE LA SARTA Y EL BATCH', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (8, 'cobis', 'ts_batch_param', 'COBIS - TS_BATCH_PARAM', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (8, 'cobis', 'ts_lectura', 'COBIS - TS_LECTURA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (10, 'cob_remesas', 're_ts_tran_contable', 'COB_REMESAS - RE_TS_TRAN_CONTABLE', 'V', 'fecha_proc', 'secuencial', 'clase',  null,  null,  null,  null, 'operador', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (10, 'cob_remesas', 're_ts_cuentas_cbns_habituales', 'COB_REMESAS - RE_TS_CUENTAS_CBNS_HABITUALES', 'V', 'fecha_proc', 'secuencial', 'clase',  null,  null,  null,  null, 'operador', 'terminal', 'monto',  null, null) 	
go
insert into ad_vistas_trnser values (10, 'cob_remesas', 're_tscertifica_trn', 'COB_REMESAS - RE_TSCERTIFICA_TRN', 'V', 'fecha_emi', 'ssn', 'clase',  'N',  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (10, 'firmas', 'fi_firma_sello', 'FIRMAS - FI_FIRMA_SELLO', 'V', 'tsfecha', 'secuencial', 'clase',  null,  null,  null,  null, 'operador', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (10, 'firmas', 'fi_tcandidata', 'FIRMAS - FI_TCANDIDATA', 'V', 'tsfecha', 'secuencial', 'clase',  null,  null,  null,  null, 'operador', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (10, 'firmas', 'fi_comb', 'FIRMAS - FI_COMB', 'V', 'tsfecha', 'secuencial', 'clase',  null,  null,  null,  null, 'operador', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (10, 'firmas', 'fi_cond', 'FIRMAS - FI_COND', 'V', 'tsfecha', 'secuencial', 'clase',  null,  null,  null,  null, 'operador', 'terminal', 'monto_desde',  null, null) 	
go
insert into ad_vistas_trnser values (10, 'firmas', 'fi_autorizadas', 'FIRMAS - FI_AUTORIZADAS', 'V', 'tsfecha', 'secuencial', 'clase',  null,  null,  null,  null, 'operador', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (10, 'firmas', 'fi_tfirmantes', 'FIRMAS - FI_TFIRMANTES', 'V', 'tsfecha', 'secuencial', 'clase',  null,  null,  null,  null, 'operador', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_auxiliar_tip', 'COB_PFIJO - TS_AUXILIAR_TIP', 'V', 'fecha', 'secuencial', 'clase', 'N',  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_det_pago', 'COB_PFIJO - TS_DET_PAGO', 'V', 'fecha', 'secuencial', 'clase', 'N',  null,  null,  null, 'usuario', 'terminal', 'monto', 'moneda_pago', null)
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_historia', 'COB_PFIJO - TS_HISTORIA', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A',  null, 'usuario', 'terminal', 'valor',  null, null) 	
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_mov_monet', 'COB_PFIJO - TS_MOV_MONET', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A',  null, 'usuario', 'terminal', 'valor', 'moneda', null)
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_mov_monet_prob', 'COB_PFIJO - TS_MOV_MONET_PROB', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor',  null, null) 	
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_cancelacion', 'COB_PFIJO - TS_CANCELACION', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A',  null, 'usuario', 'terminal', 'valor',  null, null) 	
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_fpago', 'COB_PFIJO - TS_FPAGO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_funcionario', 'COB_PFIJO - TS_FUNCIONARIO', 'V', 'fecha', 'secuencial', 'clase', 'N',  null,  null, 'B', 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_limite', 'COB_PFIJO - TS_LIMITE', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null, 'moneda', null)
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_tipo_deposito', 'COB_PFIJO - TS_TIPO_DEPOSITO', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A', 'B', 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_beneficiario', 'COB_PFIJO - TS_BENEFICIARIO', 'V', 'fecha', 'secuencial', 'clase', 'N',  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_condicion', 'COB_PFIJO - TS_CONDICION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_det_condicion', 'COB_PFIJO - TS_DET_CONDICION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_emision_cheque', 'COB_PFIJO - TS_EMISION_CHEQUE', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null)
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_monto', 'COB_PFIJO - TS_MONTO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'monto_max',  null, null) 	
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_operacion', 'COB_PFIJO - TS_OPERACION', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P',  null,  null, 'usuario', 'terminal', 'monto', 'moneda', null)
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_pignoracion', 'COB_PFIJO - TS_PIGNORACION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor',  null, null) 	
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_plazo', 'COB_PFIJO - TS_PLAZO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_ppago', 'COB_PFIJO - TS_PPAGO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_renovacion', 'COB_PFIJO - TS_RENOVACION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_retencion', 'COB_PFIJO - TS_RETENCION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor',  null, null) 	
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_tasa', 'COB_PFIJO - TS_TASA', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A', 'B', 'usuario', 'terminal',  null, 'moneda', null)
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_cotizacion', 'COB_PFIJO - TS_COTIZACION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null)
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_cuotas', 'COB_PFIJO - TS_CUOTAS', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null, 'B', 'usuario', 'terminal', 'valor_cuota', 'moneda', null)
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_instruccion', 'COB_PFIJO - TS_INSTRUCCION', 'V', 'fecha', 'secuencial', 'clase', 'N',  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_bloqueo_legal', 'COB_PFIJO - TS_BLOQUEO_LEGAL', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor_bancos',  null, null) 	
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_hist_tasa', 'COB_PFIJO - TS_HIST_TASA', 'V', 'fecha', 'secuencial', 'clase', 'N',  null,  null, 'B', 'usuario', 'terminal',  null, 'moneda', null)
go
insert into ad_vistas_trnser values (14, 'cob_pfijo', 'ts_hist_tasa_variable', 'COB_PFIJO - TS_HIST_TASA_VARIABLE', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null, 'moneda', null)
go
insert into ad_vistas_trnser values (19, 'cob_custodia', 'ts_almacenera', 'COB_CUSTODIA - TS_ALMACENERA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (19, 'cob_custodia', 'ts_control_inspector', 'COB_CUSTODIA - TS_CONTROL_INSPECTOR', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (19, 'cob_custodia', 'ts_custodia', 'COB_CUSTODIA - TS_CUSTODIA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor_inicial', 'moneda', null)	
go
insert into ad_vistas_trnser values (19, 'cob_custodia', 'ts_cliente_garantia', 'COB_CUSTODIA - TS_CLIENTE_GARANTIA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (19, 'cob_custodia', 'ts_inspeccion', 'COB_CUSTODIA - TS_INSPECCION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor_fact',  null, null) 	
go
insert into ad_vistas_trnser values (19, 'cob_custodia', 'ts_inspector', 'COB_CUSTODIA - TS_INSPECTOR', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (19, 'cob_custodia', 'ts_item', 'COB_CUSTODIA - TS_ITEM', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (19, 'cob_custodia', 'ts_item_custodia', 'COB_CUSTODIA - TS_ITEM_CUSTODIA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (19, 'cob_custodia', 'ts_poliza', 'COB_CUSTODIA - TS_POLIZA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'monto_poliza', 'moneda', null)
go
insert into ad_vistas_trnser values (19, 'cob_custodia', 'ts_bonos_otros', 'COB_CUSTODIA - TS_BONOS_OTROS', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (19, 'cob_custodia', 'ts_recuperacion', 'COB_CUSTODIA - TS_RECUPERACION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor',  null, null) 	
go
insert into ad_vistas_trnser values (19, 'cob_custodia', 'ts_tipo_custodia', 'COB_CUSTODIA - TS_TIPO_CUSTODIA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (19, 'cob_custodia', 'ts_transaccion', 'COB_CUSTODIA - TS_TRANSACCION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor',  null, null) 	
go
insert into ad_vistas_trnser values (19, 'cob_custodia', 'ts_vencimiento', 'COB_CUSTODIA - TS_VENCIMIENTO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor',  null, null) 	
go
insert into ad_vistas_trnser values (19, 'cob_custodia', 'ts_por_inspeccionar', 'COB_CUSTODIA - TS_POR_INSPECCIONAR', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (19, 'cob_custodia', 'ts_doctos', 'COB_CUSTODIA - TS_DOCTOS', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor_neto', 'moneda', null)
go
insert into ad_vistas_trnser values (19, 'cob_custodia', 'ts_grupos_doctos', 'COB_CUSTODIA - TS_GRUPOS_DOCTOS', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor_neg',  null, null) 	
go
insert into ad_vistas_trnser values (19, 'cob_custodia', 'ts_resul_abg', 'COB_CUSTODIA - TS_RESUL_ABG', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor_fact',  null, null) 	
go
insert into ad_vistas_trnser values (19, 'cob_custodia', 'ts_control_abogado', 'COB_CUSTODIA - TS_CONTROL_ABOGADO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor_facturado',  null, null) 	
go
insert into ad_vistas_trnser values (19, 'cob_custodia', 'ts_gar_abogado', 'COB_CUSTODIA - TS_GAR_ABOGADO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (19, 'cob_custodia', 'ts_tipo_seguro', 'COB_CUSTODIA - TS_TIPO_SEGURO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_productos', 'COB_SBANCARIOS - TS_PRODUCTOS', 'V', 'fecha', 'secuencial', 'clase',  null, 'P', 'A',  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_instrumentos', 'COB_SBANCARIOS - TS_INSTRUMENTOS', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A',  null, 'usuario', 'terminal',  null, 'moneda', null)
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_subtipos_ins', 'COB_SBANCARIOS - TS_SUBTIPOS_INS', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A',  null, 'usuario', 'terminal', 'valor',  null, null) 	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_cotizaciones', 'COB_SBANCARIOS - TS_COTIZACIONES', 'V', 'fecha', 'secuencial', 'clase', 'N',  null,  null,  null, 'usuario', 'terminal',  null, 'moneda', null)	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_autorizantes_exc', 'COB_SBANCARIOS - TS_AUTORIZANTES_EXC', 'V', 'fecha', 'secuencial', 'clase', 'N',  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_autorizantes_cot', 'COB_SBANCARIOS - TS_AUTORIZANTES_COT', 'V', 'fecha', 'secuencial', 'clase', 'N',  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_formas_pagcob', 'COB_SBANCARIOS - TS_FORMAS_PAGCOB', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_bloqueos', 'COB_SBANCARIOS - TS_BLOQUEOS', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null, 'moneda', null)
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_rangos', 'COB_SBANCARIOS - TS_RANGOS', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A',  null, 'usuario', 'terminal',  null, 'moneda', null)
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_rubros', 'COB_SBANCARIOS - TS_RUBROS', 'V', 'fecha', 'secuencial', 'clase',  null, 'P', 'A',  null, 'usuario', 'terminal',  null, 'moneda', null)	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_rangos_rubros', 'COB_SBANCARIOS - TS_RANGOS_RUBROS', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor', 'moneda', null)	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_inventario_ins', 'COB_SBANCARIOS - TS_INVENTARIO_INS', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A', 'E', 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_puntos_reorden', 'COB_SBANCARIOS - TS_PUNTOS_REORDEN', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A', 'E', 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_impresion_lotes', 'COB_SBANCARIOS - TS_IMPRESION_LOTES', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A',  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_ins_suspendidos', 'COB_SBANCARIOS - TS_INS_SUSPENDIDOS', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A',  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_pagopostal_pend', 'COB_SBANCARIOS - TS_PAGOPOSTAL_PEND', 'V', 'fecha', 'secuencial', 'clase', 'N',  'P',  'A',  'B', 'usuario', 'terminal', null, null, null)	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_chequegc_pend', 'COB_SBANCARIOS - TS_CHEQUEGC_PEND', 'V', 'fecha', 'secuencial', 'clase', 'N',  'P',  'A',  'B', 'usuario', 'terminal', null, null, null)	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_envios_ach', 'COB_SBANCARIOS - TS_ENVIOS_ACH', 'V', 'fecha', 'secuencial', 'clase', 'N',  'P',  'A',  'B', 'usuario', 'terminal', null, 'moneda', null)	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_bancos_subtipo', 'COB_SBANCARIOS - TS_BANCOS_SUBTIPO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null, 'moneda', null)
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_docs_entrega', 'COB_SBANCARIOS - TS_DOCS_ENTREGA', 'V', 'fecha', 'secuencial', 'clase', 'N',  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_rel_fpago', 'COB_SBANCARIOS - TS_REL_FPAGO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null, 'moneda', null)
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_area_funcionarios', 'COB_SBANCARIOS - TS_AREA_FUNCIONARIOS', 'V', 'fecha', 'secuencial', 'clase', 'N',  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_area_func_implot', 'COB_SBANCARIOS - TS_AREA_FUNC_IMPLOT', 'V', 'fecha', 'secuencial', 'clase', 'N',  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_formapagcob_prod', 'COB_SBANCARIOS - FORMAS PAG/COB POR PROD', 'V', 'fecha', 'secuencial', 'clase', 'N',  null,  null,  'B', 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_impuestos', 'COB_SBANCARIOS - RELACION DE IMPUESTO', 'V', 'fecha', 'secuencial', 'clase', 'N', 'P', 'A',  'B', 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_impuestos_rubros', 'COB_SBANCARIOS - TS_IMPUESTOS_RUBROS', 'V', 'fecha', 'secuencial', 'clase', 'N',  'P',  'A',  'B', 'usuario', 'terminal', null, 'moneda', null)	
go
insert into ad_vistas_trnser values (42, 'cob_sbancarios', 'ts_plantillas_ach', 'COB_SBANCARIOS - TS_PLANTILLAS_ACH', 'V', 'fecha', 'secuencial', 'clase', 'N',  'P',  'A',  'E', 'usuario', 'terminal', null, null, null)	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_refinh', 'COBIS - TS_REFINH', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_mercado', 'COBIS - TS_MERCADO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_sector', 'COBIS - TS_SECTOR', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_mala_ref', 'MALA REFERENCIA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_estatuto', 'COBIS - TS_ESTATUTO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_objeto', 'COBIS - TS_OBJETO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go

insert into ad_vistas_trnser values (2, 'cobis', 'ts_compania', 'DATOS DE LA COMPAÑIA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_soc_hecho', 'SOCIEDAD DE HECHO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_grupo', 'GRUPOS', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_direccion', 'REGISTRO DE DIRECCIONES', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_telefono', 'TELEFONOS DEL CLIENTE', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_propiedad', 'PROPIEDADES DEL CLIENTE', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null, 'moneda', null)
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_casilla', 'CASILLA RELACIONADA CON EL CLIENTE', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_ref_personal', 'REFERENCIAS PERSONALES DEL CLIENTE', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_referencia', 'REFERENCIAS DEL CLIENTE', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'monto', 'moneda', null)	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_trabajo', 'DATOS TRABAJO CLIENTE', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'sueldo', 'moneda', null)
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_relacion', 'COBIS - TS_RELACION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_balance', 'COBIS - TS_BALANCE', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_plan', 'COBIS - TS_PLAN', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor',  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_cuenta', 'CUENTAS DEL CLIENTE', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_tbalance', 'COBIS - TS_TBALANCE', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_tplan', 'COBIS - TS_TPLAN', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_estatuto_com', 'COBIS - TS_ESTATUTO_COM', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_objeto_com', 'COBIS - TS_OBJETO_COM', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_banco_rem', 'COBIS - TS_BANCO_REM', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_covinco', 'COBIS - TS_COVINCO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_narcos', 'COBIS - TS_NARCOS', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_cia_liquidacion', 'COBIS - TS_CIA_LIQUIDACION', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_otros_ingresos', 'OTROS INGRESOS', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'valor',  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_def_tablas', 'DEFINICION DE LAS TABLAS', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_def_campos', 'CAMPOS DE MERCADEO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_historico_vinculos', 'LOG DE HISTORICO DE VINCULOS', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_cliente_grupo', 'GRUPO DEL CLIENTE', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_patrimonio_tecnico', 'COBIS - TS_PATRIMONIO_TECNICO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal', 'patrimonio_tec',  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_sectoreco', 'COBIS - TS_SECTORECO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_infocta', 'COBIS - TS_INFOCTA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null, 'in_moneda', null)	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_autoriza', 'COBIS - TS_AUTORIZA', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (2, 'cobis', 'ts_informacion_riesgo', 'COBIS - TS_INFORMACION_RIESGO', 'V', 'fecha', 'secuencial', 'clase',  null,  null,  null,  null, 'usuario', 'terminal',  null,  null, null) 	
go
insert into ad_vistas_trnser values (1, 'cobis', 'ts_desbloqueo_func', 'COBIS - TS_DESBLOQUEO_FUNC', 'V', 'fecha', 'secuencia', 'clase',  null, 'P', 'A',  null, 'usuario', 'terminal_s',  null,  null, null) 	
go
insert into ad_vistas_trnser values (1, 'cobis', 'ts_acceso_func_cen', 'ACCESO DE USUARIOS A PANTALLAS DE CEN', 'V', 'fecha', 'secuencia', 'clase',  'N', null, null,  null, 'usuario', 'terminal_s',  null,  null, null) 	
go
insert into ad_vistas_trnser values (1, 'cobis', 'ts_barrio', 'MANTENIMIENTO DE BARRIOS', 'V', 'fecha', 'secuencia', 'clase',  'N', 'P', 'A',  null, 'usuario', 'terminal_s',  null,  null, null) 	
go
insert into ad_vistas_trnser values (1, 'cobis', 'ts_oficina', 'MANTENIMIENTO DE OFICINAS', 'V', 'fecha', 'secuencia', 'clase',  'N', 'P', 'A',  null, 'usuario', 'terminal_s',  null,  null, null) 	
go
insert into ad_vistas_trnser values (1, 'cobis', 'ts_oficina_geo', 'MANTENIMIENTO DE DATOS GEOREFERENCIALES DE OFICINAS', 'V', 'fecha', 'secuencia', 'clase',  'N', 'P', 'A',  null, 'usuario', 'terminal_s',  null,  null, null)
go
insert into ad_vistas_trnser values (1, 'cobis', 'ts_ofic_func', 'MANTENIMIENTO DE SUPERVISORES DE OFICINAS', 'V', 'fecha', 'secuencia', 'clase',  'N', 'P', 'A',  null, 'usuario', 'terminal_s',  null,  null, null)
go
insert into ad_vistas_trnser values (1, 'cobis', 'ts_telefono_of', 'MANTENIMIENTO DE TELEFONOS DE OFICINAS', 'V', 'fecha', 'secuencial', 'clase',  'N', 'P', 'A',  null, 'usuario', 'terminal_s',  null,  null, null)
go
insert into ad_vistas_trnser values (1, 'cobis', 'ts_depart_pais', 'MANTENIMIENTO DE DEPARTAMENTOS POR PAIS', 'V', 'fecha', 'secuencia', 'clase',  'N', 'P', 'A',  null, 'usuario', 'terminal_s',  null,  null, null)
go
insert into ad_vistas_trnser values (1, 'cobis', 'ts_provincia', 'MANTENIMIENTO DE PROVINCIAS', 'V', 'fecha', 'secuencia', 'clase',  'N', 'P', 'A',  null, 'usuario', 'terminal_s',  null,  null, null)
go
insert into ad_vistas_trnser values (1, 'cobis', 'ts_municipio', 'MANTENIMIENTO DE MUNICIPIOS', 'V', 'fecha', 'secuencia', 'clase',  'N', 'P', 'A',  null, 'usuario', 'terminal_s',  null,  null, null)
go
insert into ad_vistas_trnser values (1, 'cobis', 'ts_canton', 'MANTENIMIENTO DE CANTONES', 'V', 'fecha', 'secuencia', 'clase',  'N', 'P', 'A',  null, 'usuario', 'terminal_s',  null,  null, null)
go
insert into ad_vistas_trnser values (1, 'cobis', 'ts_ciudad', 'MANTENIMIENTO DE CIUDADES', 'V', 'fecha', 'secuencia', 'clase',  'N', 'P', 'A',  null, 'usuario', 'terminal_s',  null,  null, null)
go
insert into ad_vistas_trnser values (1, 'cobis', 'ts_adm_seguridades', 'MANTENIMIENTO DE AUTORIZACION DE FUNCIONALIDADES', 'V', 'fecha', 'secuencia', 'clase',  'N', 'P', 'A',  null, 'usuario', 'terminal_s',  null,  null, 'rol_autorizado')
go
insert into ad_vistas_trnser values (17,'cob_remesas', 'pe_ts_cuenta_prodbanc', 'MANTENIMIENTO DE CUENTAS POR PRODUCTO BANCARIO', 'V', 'fecha', 'secuencial', 'tipo_variacion',  'N', 'P', 'A',  'B', 'usuario', 'terminal',  null,  'moneda', null)
go
insert into ad_vistas_trnser values (17,'cob_remesas', 'pe_ts_maduracion_prod', 'MANTENIMIENTO DE MADURACIÓN DE PRODUCTOS BANCARIOS', 'V', 'fecha', 'secuencial', 'tipo_variacion',  'N', 'P', 'A',  'B', 'usuario', 'terminal',  null,  'moneda', null)
go
insert into ad_vistas_trnser values (1, 'cobis', 'ts_parametro', 'PARAMETROS GENERALES', 'V', 'fecha', 'secuencia', 'clase',  'N', 'P', 'A', 'B', 'usuario', 'terminal_s',  null,  null, null)
go
insert into ad_vistas_trnser values (10, 'cob_remesas', 'ts_remesas_rec', 'MOVIMIENTOS DE REMESAS Y RECAUDOS', 'V', 'tsfecha', 'num_envio', 'clase', 'N', 'P', 'A', 'B', 'usuario', 'terminal', null, null, null)
go

insert into ad_vistas_trnser  values (1, 'cobis', 'ts_oficfunc_rol', 'MANT. OFICINA SUPERVISOR ROL', 'V', 'fecha', 'secuencia', 'clase',  'N', 'P', 'A',  'B', 'usuario', 'terminal_s',null,null,null)
go

insert into ad_vistas_trnser  values (1, 'cobis', 'ts_ambito', 'MANTENIMIENTO DE AMBITOS', 'V', 'fecha', 'secuencia', 'clase',  'N', 'P', 'A',  null, 'usuario', 'terminal_s',null,null,null)
go


--PRMR CTA-S14437
insert into ad_vistas_trnser (vt_producto, vt_base_datos, vt_tabla, vt_descripcion, vt_tipo, vt_campo_fecha, vt_campo_secuencial, vt_campo_clase, vt_clase_ins, 
									 vt_clase_upd_previo, vt_clase_upd_actual, vt_clase_del, vt_campo_login, vt_campo_terminal, vt_campo_monto, vt_campo_moneda, vt_campo_rol) 
							values (17, 'cob_remesas', 'pe_ts_pers_mas_cab', 'PERSONALIZACION MASIVA CABECERA', 'V', 'fecha', 'secuencial', 'tipo_variacion',  'N', 
									'P', 'A', 'B', 'usuario', 'terminal',  null,  null, null)
			
insert into ad_vistas_trnser (vt_producto, vt_base_datos, vt_tabla, vt_descripcion, vt_tipo, vt_campo_fecha, vt_campo_secuencial, vt_campo_clase, vt_clase_ins, 
									 vt_clase_upd_previo, vt_clase_upd_actual, vt_clase_del, vt_campo_login, vt_campo_terminal, vt_campo_monto, vt_campo_moneda, vt_campo_rol) 
							values (17, 'cob_remesas', 'pe_ts_pers_mas_det', 'PERSONALIZACION MASIVA DETALLE', 'V', 'fecha', 'secuencial', 'tipo_variacion',  'N', 
									'P', 'A', 'B', 'usuario', 'terminal',  null,  null, null)

--PRMR CTA-S15214 
insert into ad_vistas_trnser 
			(vt_producto, vt_base_datos, vt_tabla, vt_descripcion, vt_tipo, vt_campo_fecha, vt_campo_secuencial, vt_campo_clase, vt_clase_ins, 
			 vt_clase_upd_previo, vt_clase_upd_actual, vt_clase_del, vt_campo_login, vt_campo_terminal, vt_campo_monto, vt_campo_moneda, vt_campo_rol) 
	values (17, 'cob_remesas', 'pe_ts_def_prodbanc', 'DEFINICION PRODUCTO BANCARIO', 'V', 'fecha', 'secuencial', 'tipo_variacion',  'N', 
			'P', 'A', 'B', 'usuario', 'terminal',  null,  null, null)
go


--ADM-S0006-CC
insert into ad_vistas_trnser 
			(vt_producto, vt_base_datos, vt_tabla, vt_descripcion, vt_tipo, vt_campo_fecha, vt_campo_secuencial, vt_campo_clase, vt_clase_ins, 
			 vt_clase_upd_previo, vt_clase_upd_actual, vt_clase_del, vt_campo_login, vt_campo_terminal, vt_campo_monto, vt_campo_moneda, vt_campo_rol) 
	values (1, 'cobis', 'ts_conexion_login', 'CONEXIONES FALLIDAS', 'V', 'fecha', 'secuencia', 'clase',  'N', 
			'P', 'A', 'B', 'usuario', 'terminal',  null,  null, null)
go


