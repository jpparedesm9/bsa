--cartera 
use cob_cartera 
go
	  
truncate table ca_operacion
truncate table ca_dividendo
truncate table ca_amortizacion
truncate table ca_rubro_op
truncate table ca_desembolso
truncate table ca_abono
truncate table ca_abono_det
truncate table ca_otro_cargo
truncate table ca_cuota_adicional
truncate table ca_tasas
truncate table ca_abono_rubro
truncate table ca_transaccion 
truncate table ca_det_tr
truncate table ca_transaccion_prv
truncate table ca_operacion_ts
truncate table ca_fuente_recurso_mov
truncate table ca_deu_segvida
truncate table ca_secuenciales
truncate table ca_desembolso_ts
truncate table ca_valor_atx
truncate table ca_santander_orden_deposito
truncate table ca_ultima_tasa_op
truncate table ca_universo_batch
truncate table ca_det_ciclo
truncate table ca_log_fecha_valor
truncate table ca_abono_prioridad
truncate table ca_cobranza_det_tmp
truncate table ca_santander_orden_retiro
truncate table ca_qr_amortiza_tmp
truncate table ca_operacion_his
truncate table ca_dividendo_his
truncate table ca_amortizacion_his
truncate table ca_rubro_op_his
truncate table ca_cuota_adicional_his
truncate table ca_errorlog
truncate table ca_ns_garantia_liquida
truncate table ca_en_fecha_valor
go



truncate table cob_conta_super..sb_dato_operacion
truncate table cob_conta_super..sb_dato_operacion_rubro
truncate table cob_conta_super..sb_dato_custodia
truncate table cob_conta_super..sb_dato_transaccion
truncate table cob_conta_super..sb_dato_transaccion_det

go

--contabilidad

truncate table cob_conta_tercero..ct_sasiento
truncate table cob_conta_tercero..ct_scomprobante
truncate table cob_conta_tercero..ct_sasiento_tmp
truncate table cob_conta_tercero..ct_scomprobante_tmp
truncate table cob_conta_tercero..ct_saldo_tercero
truncate table cob_conta..cb_asiento
truncate table cob_conta..cb_comprobante
truncate table cob_conta..cb_saldo
truncate table cob_conta_his..cb_hist_saldo
truncate table cob_ccontable..cco_error_conaut
truncate table ca_errorlog

go

--credito
use cob_credito
go 


truncate table cr_verifica_xml_tmp
truncate table cr_tran_servicio
truncate table cr_tramite
truncate table cr_deudores
truncate table cr_tramite_grupal
truncate table cr_estado_cta_enviado
truncate table cr_gar_propuesta
truncate table cr_documento_digitalizado
truncate table cr_interface_buro
truncate table cr_tr_sincronizar
truncate table cr_lista_negra
truncate table cr_buro_cuenta
truncate table cr_buro_resumen_reporte
truncate table cr_documento
truncate table cr_verifica_datos
truncate table cr_mov_tramite
truncate table cr_situacion_cliente
go 
--custodia
use cob_custodia
go

truncate table cu_tran_servicio
truncate table cu_det_trn
truncate table cu_transaccion
truncate table cu_cliente_garantia
truncate table cu_custodia
truncate table cu_secuenciales
go 

use cobis
GO
print 'Actualización de seqnos cob_credito'
update cl_seqnos set siguiente = (select isnull(max(ag_visita),0) + 1 from cob_credito..cr_agenda)
 where bdatos = 'cob_credito' and tabla = 'cr_agenda' 
go
update cl_seqnos set siguiente = (select isnull(max(ci_nota),0) + 1 from cob_credito..cr_califica_interna)
 where bdatos = 'cob_credito' and tabla = 'cr_califica_interna' 
go
update cl_seqnos set siguiente = (select isnull(max(co_secuencial),0) + 1 from cob_credito..cr_cobranza)
 where bdatos = 'cob_credito' and tabla = 'cr_cobranza' 
go
update cl_seqnos set siguiente = (select isnull(max(def_codigo),0) + 1 from cob_credito..cr_det_est_financiero)
 where bdatos = 'cob_credito' and tabla = 'cr_det_est_financiero' 
go
update cl_seqnos set siguiente = (select isnull(max(ef_secuencial),0) + 1 from cob_credito..cr_est_financiero)
 where bdatos = 'cob_credito' and tabla = 'cr_est_financiero' 
go
update cl_seqnos set siguiente = (select isnull(max(et_etapa),0) + 1 from cob_credito..cr_etapa)
 where bdatos = 'cob_credito' and tabla = 'cr_etapa' 
go
update cl_seqnos set siguiente = (select isnull(max(fi_secuencial),0) + 1 from cob_credito..cr_ficha)
 where bdatos = 'cob_credito' and tabla = 'cr_ficha' 
go
update cl_seqnos set siguiente = (select isnull(max(fr_codigo_fuente),0) + 1 from cob_credito..cr_fuente_recurso)
 where bdatos = 'cob_credito' and tabla = 'cr_fuente_recurso' 
go
update cl_seqnos set siguiente = (select isnull(max(ho_historia),0) + 1 from cob_credito..cr_hist_credito)
 where bdatos = 'cob_credito' and tabla = 'cr_hist_credito' 
go
update cl_seqnos set siguiente = (select isnull(max(id_documento),0) + 1 from cob_credito..cr_imp_documento)
 where bdatos = 'cob_credito' and tabla = 'cr_imp_documento' 
go
update cl_seqnos set siguiente = (select isnull(max(li_numero),0) + 1 from cob_credito..cr_linea)
 where bdatos = 'cob_credito' and tabla = 'cr_linea' 
go
update cl_seqnos set siguiente = (select isnull(max(ln_id),0) + 1 from cob_credito..cr_lista_negra)
 where bdatos = 'cob_credito' and tabla = 'cr_lista_negra' 
go
update cl_seqnos set siguiente = (select isnull(max(mi_codigo_mic),0) + 1 from cob_credito..cr_microempresa)
 where bdatos = 'cob_credito' and tabla = 'cr_microempresa' 
go
update cl_seqnos set siguiente = (select isnull(max(pf_codigo_par),0) + 1 from cob_credito..cr_parametros_fuente)
 where bdatos = 'cob_credito' and tabla = 'cr_parametros_fuente' 
go
update cl_seqnos set siguiente = (select isnull(max(re_regla),0) + 1 from cob_credito..cr_regla)
 where bdatos = 'cob_credito' and tabla = 'cr_regla' 
go
update cl_seqnos set siguiente = (select isnull(max(sp_codigo),0) + 1 from cob_credito..cr_seguro_parentesco)
 where bdatos = 'cob_credito' and tabla = 'cr_seguro_parentesco' 
go
update cl_seqnos set siguiente = (select isnull(max(sp_codigo),0) + 1 from cob_credito..cr_seguro_plan)
 where bdatos = 'cob_credito' and tabla = 'cr_seguro_plan' 
go
update cl_seqnos set siguiente = (select isnull(max(tr_tramite),0) + 1 from cob_credito..cr_tramite)
 where bdatos = 'cob_credito' and tabla = 'cr_tramite' 
go
update cl_seqnos set siguiente = (select isnull(max(ru_ruta),0) + 1 from cob_credito..cr_truta)
 where bdatos = 'cob_credito' and tabla = 'cr_truta' 

print 'FIN LIMPIEZA cob_credito'
go

use cob_cartera
go

truncate table ca_amortizacion_his
 go           
 truncate table ca_dividendo_his
 go              
 truncate table ca_correccion
 go                 
 truncate table ca_cuota_adicional_his
 go        
 truncate table ca_rubro_op_his
 go               
 truncate table ca_transaccion_prv
 go            
 truncate table ca_det_trn
 go                    
 truncate table ca_operacion_his
 go              
 truncate table ca_garantias_tramite
 go          
 truncate table ca_operacion_ts
 go               
 truncate table ca_deu_segvida
 go                
 truncate table ca_santander_orden_deposito
 go   
 truncate table ca_fuente_recurso_mov
 go         
 truncate table ca_secuenciales
 go               
 truncate table ca_valor_atx
 go                  
 truncate table ca_desembolso_ts
 go              
 truncate table ca_ultima_tasa_op
 go             
 truncate table ca_det_ciclo
 go                  
 truncate table ca_log_fecha_valor
 go            
 truncate table ca_garantia_liquida
 go           
 truncate table ca_cobranza_det_tmp
 go           
 truncate table ca_amortizacion_tmp
 go           
 truncate table ca_cuota_adicional_tmp
 go        
 truncate table ca_dividendo_tmp
 go              
 truncate table ca_qr_amortiza_tmp
 go            
 truncate table ca_RES_HISTORICOS_tmp
 go         
 truncate table ca_qr_rubro_tmp
 go               
 truncate table ca_rubro_op_tmp
 go               
 truncate table ca_reg_eliminado_his
 go          
 truncate table ca_operacion_tmp
 go              
 truncate table ca_abono_det_tmp
 go              
 truncate table ca_abono_prioridad_tmp
 go        
 truncate table ca_abonos_masivos_his
 go         
 truncate table ca_acciones_his
 go               
 truncate table ca_acciones_tmp
 go               
 truncate table ca_actpas_tmp
 go                 
 truncate table ca_actualiza_llave_tmp
 go        
 truncate table ca_alternas_tmp
 go               
 truncate table ca_amortizacion_ant_his
 go       
 truncate table ca_aprob_por_desemb_tmp
 go       
 truncate table ca_archivo_conciliacion_tmp
 go   
 truncate table ca_buscar_operaciones_tmp
 go     
 truncate table ca_canceladas_Ext_tmp
 go         
 truncate table ca_carga_finagro_tmp
 go          
 truncate table ca_carga_oper_conflicto_tmp
 go   
 truncate table ca_cdes_tmp
 go                   
 truncate table ca_cli_emproblemado_tmp
 go       
 truncate table ca_cliente_tmp
 go                
 truncate table ca_clientes_tmp
 go               
 truncate table ca_cobranza_castigada_tmp
 go     
 truncate table ca_TP_tmp
 go                     
 truncate table Totales_sarlaft_tmp
 go           
 truncate table ca_EjeRango_Listmp
 go            
 truncate table ca_Oper_RES_olaInver_tmp
 go      
 truncate table ca_correccion_his
 go             
 truncate table ca_correccion_tmp
 go             
 truncate table ca_cpagos_tmp
 go                 
 truncate table ca_cuentas_revisoria_tmp
 go      
 truncate table ca_comision_diferida_his
 go      
 truncate table ca_conceptos_tmp
 go              
 truncate table ca_conci_dia_findeter_tmp
 go     
 truncate table ca_conciliacion_diaria_his
 go    
 truncate table ca_consulta_pag_mas_tmp
 go       
 truncate table ca_consulta_rec_pago_tmp
 go      
 truncate table ca_convenios_tmp
 go              
 truncate table ca_dividendos_rot_tmp
 go         
 truncate table ca_eje_rango_tmp
 go              
 truncate table ca_eje_tmp
 go                    
 truncate table ca_eje_xmatriz_tmp
 go            
 truncate table ca_elim_cliente_COfertas_tmp
 go  
 truncate table ca_extracto_linea_tmp
 go         
 truncate table ca_facturacion_recaudos_his
 go   
 truncate table ca_facturas_his
 go               
 truncate table ca_facturas_tmp
 go               
 truncate table ca_fng_16_tmp
 go                 
 truncate table ca_cursor_dividendo_ru_tmp
 go    
 truncate table ca_dat_oper_bv_tmp
 go            
 truncate table ca_definicion_nomina_tmp
 go      
 truncate table ca_desembolso_fag_tmp
 go         
 truncate table ca_desmarca_fng_his
 go           
 truncate table ca_det_trn_bancamia_tmp
 go       
 truncate table ca_detalle_tmp
 go                
 truncate table ca_maestro_operaciones_tmp
 go    
 truncate table ca_marcarPor_ola_invernal_his
 go 
 truncate table ca_marcarPor_ola_invernal_tmp
 go 
 truncate table ca_matriz_consultaD_tmp
 go       
 truncate table ca_matriz_consulta_tmp
 go        
 truncate table ca_matriz_tmp
 go                 
 truncate table ca_matriz_valor_tmp
 go           
 truncate table ca_nomina_tmp
 go                 
 truncate table ca_oper_universo_tmp
 go          
 truncate table ca_operacion_bancamia_tmp
 go     
 truncate table ca_operacion_ext_his
 go          
 truncate table ca_operacion_ext_tmp
 go          
 truncate table ca_gar_propuesta_tmp
 go          
 truncate table ca_dividendo_original_tmp
 go     
 truncate table ca_deudores_tmp
 go               
 truncate table ca_diferencias_findeter_tmp
 go   
 truncate table ca_diferencias_tmp
 go            
 truncate table ca_diferidos_his
 go              
 truncate table ca_gestion_cobranza_palm_tmp
 go  
 truncate table ca_interes_proyectado_tmp
 go     
 truncate table ca_lavado_activos_tmp
 go         
 truncate table ca_operaciones_con_recono_tmp
 go 
 truncate table ca_pago_planificador_tmp
 go      
 truncate table ca_pago_solidario_tmp
 go         
 truncate table ca_pagos_saldos_minimos_tmp
 go   
 truncate table ca_pagosca_h_tmp
 go              
 truncate table ca_pagosca_v_tmp
 go              
 truncate table ca_paralelo_tmp
 go               
 truncate table ca_plano_banco_2piso_his
 go      
 truncate table ca_prestamo_pagos_tmp
 go         
 truncate table ca_procesos_buserror_tmp
 go      
 truncate table ca_procesos_consolidador_tmp
 go  
 truncate table ca_procesos_contacar_tmp
 go      
 truncate table ca_relacion_ptmo_his
 go          
 truncate table ca_relacion_ptmo_tmp
 go          
 truncate table ca_reproceso_seg_tmp
 go          
 truncate table ca_resumen_tmp
 go                
 truncate table ca_revisa_prepagos_tmp
 go        
 truncate table ca_rubro_calculado_tmp
 go        
 truncate table ca_rubro_imo_tmp
 go              
 truncate table ca_rubro_int_tmp
 go              
 truncate table ca_rubros_correccion_tmp
 go      
 truncate table ca_saldo_operacion_tmp
 go        
 truncate table ca_saldos_contables_tmp
 go       
 truncate table ca_saldos_mbs_tmp
 go             
 truncate table ca_saldos_op_renovar_tmp
 go      
 truncate table ca_saldos_rubros_tmp
 go          
 truncate table ca_reajuste_det_tmp
 go           
 truncate table ca_reajuste_tmp
 go               
 truncate table ca_val_oper_finagro_tmp
 go       
 truncate table ca_traslado_interes_his
 go       
 truncate table ca_seguros_can_his
 go            
 truncate table ca_seguros_det_his
 go            
 truncate table ca_seguros_his
 go                
 truncate table ca_total_prioridad_tmp
 go        
 truncate table ca_transaccion_bancamia_tmp
 go   
 truncate table ca_transaccion_imp_tmp
 go        
 truncate table ca_valores_his
 go                
 truncate table ca_valores_tmp
 go                
 truncate table detalle1_sarlaft_tmp
 go          
 truncate table detalle2_Comercial_tmp
 go        
 truncate table detalle_cliente_tmp
 go           
 truncate table operacion_tmp
 go                 
 truncate table operaciones_tmp
 go               
 truncate table reporte_reestruct_tmp
 go         
 truncate table rubros_tmp
 go                    
 truncate table tabla_tmp
 go                     
 truncate table tmp_en_tmp
 go                    
 truncate table tmp_interes_amortiza_tmp
 go      
 
 truncate table ca_ciclo
 go
--truncate table ca_santander_orden_retiro
--go
truncate table ca_gracia_seguros
go
truncate table ca_universo_batch
go
truncate table ca_grupos_vencidos
go

 update cobis..cl_seqnos set siguiente = (select max(fr_fondo_id) + 1 from cob_cartera..ca_fuente_recurso) where tabla = 'ca_fuente_recurso'and bdatos = 'cob_cartera'
 go 

use cob_credito
go
truncate table cr_resultado_xml
go
truncate table cr_tr_sincronizar
go
truncate table cr_monto_cliente_grupo
go
truncate table cr_verifica_datos
go
truncate table cr_documento_digitalizado
go

use cob_conta_super
go
 truncate table sb_reporte_buro_final
 go       
 truncate table sb_reporte_buro_cuentas
 go     
 truncate table sb_buro_cliente
 go             
 truncate table sb_buro_direccion
 go           
 truncate table sb_dato_operacion_tmp
 go       
 truncate table sb_datos_corte_anterior_tmp
 go 
 truncate table sb_datos_rubros_tmp
 go         
 truncate table sb_desmarca_fng_his
 go         
 truncate table sb_distgar_cu_tmp
 go           
 truncate table sb_distgar_ga_tmp
 go           
 truncate table sb_distgar_op_tmp
 go           
 
use cob_interfase
go

truncate table cco_error_conaut_his
go