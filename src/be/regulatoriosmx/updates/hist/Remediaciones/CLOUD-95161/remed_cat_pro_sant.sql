-- Verificacion de existencia
print 'BORRADO'
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'ad_cultura'                  )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cl_municip_seccion'          )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cl_canton'                   )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cl_tipo_ambito'              )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cl_ambito'                   )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cl_causa_bloqueo'            )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cl_rol_sup_agencia'          )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cl_estado_ambito'            )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cl_tipo_oficina'             )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'te_media_dolar'              )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cb_declaraciones'            )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cb_calbomberil'              )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cb_unidad_indicador'         )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cb_conc_movimipro'           )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cb_decl_pago_ret'            )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cb_productos_cb'             )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cl_tipo_req'                 )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cl_vigencia_req'             )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'wf_errores_proceso'          )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'wf_tipo_dist_carga'          )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cl_categoria_req'            )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'wf_tiempo_tarea'             )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'bpl_rule_type'               )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'bpl_rule_subtype'            )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'bpl_rule_status'             )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'wf_type_variable'            )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'wf_subType_variable'         )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'bpl_status'                  )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'bpl_type_dependence'         )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'bpl_bpm'                     )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'fp_fuente_valor'             )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'fp_tipo_diccionario'         )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'fp_reajuste'                 )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'fp_forma_reajuste'           )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'fp_tipo_rubro'               )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'fp_tipo_limite'              )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'fp_procesos'                 )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'fp_tipo_op_estados'          )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'fp_tipo_datos_validacion'    )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'fp_tipos_validacion'         )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'fp_aplica_validacion'        )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'fp_tipos_procesos'           )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'fp_operacion_autorizacion'   )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'fp_tipo_patalla'             )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'crm_medio_respuesta'         )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cl_ciudad_equiv'             )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cl_tipo_documento_equiv'     )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cl_mextranjera_equiv'        )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cl_tipo_punto_at_equiv'      )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'cl_calif_cliente'            )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'ca_razon_no_conciliacion'    )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'ca_tipo_pago'                )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'ca_estado_pago_corresponsal' )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'ca_corresponsales'           )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'ca_estado_conciliacion'      )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'ca_errores_santander_pagos'  )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'ca_tipo_error'               )      
delete cobis..cl_catalogo_pro where cp_tabla = (select top 1 codigo from cobis..cl_tabla where tabla = 'ec_equivalencias'            )      
go
-- Insercion 
print 'INSERCION'
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'ad_cultura'                        
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'cl_municip_seccion'                
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'cl_canton'                         
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'cl_tipo_ambito'                    
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'cl_ambito'                         
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'cl_causa_bloqueo'                  
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'cl_rol_sup_agencia'                
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'cl_estado_ambito'                  
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'cl_tipo_oficina'                   
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'te_media_dolar'                    
insert into cobis..cl_catalogo_pro select top 1  'CON',codigo from cobis..cl_tabla where tabla = 'cb_declaraciones'                  
insert into cobis..cl_catalogo_pro select top 1  'CON',codigo from cobis..cl_tabla where tabla = 'cb_calbomberil'                    
insert into cobis..cl_catalogo_pro select top 1  'CON',codigo from cobis..cl_tabla where tabla = 'cb_unidad_indicador'               
insert into cobis..cl_catalogo_pro select top 1  'CON',codigo from cobis..cl_tabla where tabla = 'cb_conc_movimipro'                 
insert into cobis..cl_catalogo_pro select top 1  'CON',codigo from cobis..cl_tabla where tabla = 'cb_decl_pago_ret'                  
insert into cobis..cl_catalogo_pro select top 1  'CON',codigo from cobis..cl_tabla where tabla = 'cb_productos_cb'                   
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'cl_tipo_req'                       
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'cl_vigencia_req'                   
insert into cobis..cl_catalogo_pro select top 1  'CWF',codigo from cobis..cl_tabla where tabla = 'wf_errores_proceso'                
insert into cobis..cl_catalogo_pro select top 1  'CWF',codigo from cobis..cl_tabla where tabla = 'wf_tipo_dist_carga'                
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'cl_categoria_req'                  
insert into cobis..cl_catalogo_pro select top 1  'CWF',codigo from cobis..cl_tabla where tabla = 'wf_tiempo_tarea'                   
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'bpl_rule_type'                     
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'bpl_rule_subtype'                  
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'bpl_rule_status'                   
insert into cobis..cl_catalogo_pro select top 1  'CWF',codigo from cobis..cl_tabla where tabla = 'wf_type_variable'                  
insert into cobis..cl_catalogo_pro select top 1  'CWF',codigo from cobis..cl_tabla where tabla = 'wf_subType_variable'               
insert into cobis..cl_catalogo_pro select top 1  'CWF',codigo from cobis..cl_tabla where tabla = 'bpl_status'                        
insert into cobis..cl_catalogo_pro select top 1  'CWF',codigo from cobis..cl_tabla where tabla = 'bpl_type_dependence'               
insert into cobis..cl_catalogo_pro select top 1  'CWF',codigo from cobis..cl_tabla where tabla = 'bpl_bpm'                           
insert into cobis..cl_catalogo_pro select top 1  'AFP',codigo from cobis..cl_tabla where tabla = 'fp_fuente_valor'                   
insert into cobis..cl_catalogo_pro select top 1  'AFP',codigo from cobis..cl_tabla where tabla = 'fp_tipo_diccionario'               
insert into cobis..cl_catalogo_pro select top 1  'AFP',codigo from cobis..cl_tabla where tabla = 'fp_reajuste'                       
insert into cobis..cl_catalogo_pro select top 1  'AFP',codigo from cobis..cl_tabla where tabla = 'fp_forma_reajuste'                 
insert into cobis..cl_catalogo_pro select top 1  'AFP',codigo from cobis..cl_tabla where tabla = 'fp_tipo_rubro'                     
insert into cobis..cl_catalogo_pro select top 1  'AFP',codigo from cobis..cl_tabla where tabla = 'fp_tipo_limite'                    
insert into cobis..cl_catalogo_pro select top 1  'AFP',codigo from cobis..cl_tabla where tabla = 'fp_procesos'                       
insert into cobis..cl_catalogo_pro select top 1  'AFP',codigo from cobis..cl_tabla where tabla = 'fp_tipo_op_estados'                
insert into cobis..cl_catalogo_pro select top 1  'AFP',codigo from cobis..cl_tabla where tabla = 'fp_tipo_datos_validacion'          
insert into cobis..cl_catalogo_pro select top 1  'AFP',codigo from cobis..cl_tabla where tabla = 'fp_tipos_validacion'               
insert into cobis..cl_catalogo_pro select top 1  'AFP',codigo from cobis..cl_tabla where tabla = 'fp_aplica_validacion'              
insert into cobis..cl_catalogo_pro select top 1  'AFP',codigo from cobis..cl_tabla where tabla = 'fp_tipos_procesos'                 
insert into cobis..cl_catalogo_pro select top 1  'AFP',codigo from cobis..cl_tabla where tabla = 'fp_operacion_autorizacion'         
insert into cobis..cl_catalogo_pro select top 1  'AFP',codigo from cobis..cl_tabla where tabla = 'fp_tipo_patalla'                   
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'crm_medio_respuesta'               
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'cl_ciudad_equiv'                   
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'cl_tipo_documento_equiv'           
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'cl_mextranjera_equiv'              
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'cl_tipo_punto_at_equiv'            
insert into cobis..cl_catalogo_pro select top 1  'CCA',codigo from cobis..cl_tabla where tabla = 'cl_calif_cliente'                  
insert into cobis..cl_catalogo_pro select top 1  'CCA',codigo from cobis..cl_tabla where tabla = 'ca_razon_no_conciliacion'          
insert into cobis..cl_catalogo_pro select top 1  'CCA',codigo from cobis..cl_tabla where tabla = 'ca_tipo_pago'                      
insert into cobis..cl_catalogo_pro select top 1  'CCA',codigo from cobis..cl_tabla where tabla = 'ca_estado_pago_corresponsal'       
insert into cobis..cl_catalogo_pro select top 1  'CCA',codigo from cobis..cl_tabla where tabla = 'ca_corresponsales'                 
insert into cobis..cl_catalogo_pro select top 1  'CCA',codigo from cobis..cl_tabla where tabla = 'ca_estado_conciliacion'            
insert into cobis..cl_catalogo_pro select top 1  'CCA',codigo from cobis..cl_tabla where tabla = 'ca_errores_santander_pagos'        
insert into cobis..cl_catalogo_pro select top 1  'CCA',codigo from cobis..cl_tabla where tabla = 'ca_tipo_error'                     
insert into cobis..cl_catalogo_pro select top 1  'ADM',codigo from cobis..cl_tabla where tabla = 'ec_equivalencias'                  

go
