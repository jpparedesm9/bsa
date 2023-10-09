	use cobis
go
delete cl_catalogo_pro
from cl_tabla
where tabla in ('cr_juzgado','ah_est_ahpro','cr_aprob_garantia',
'cr_calificacion','cr_cat_observacion','cr_causales_devolucion','cr_ccosto',
'cr_clase_abogado','cr_clase_cartera','cr_clase_abogado_externo','cr_codificacion_medidas',
'cr_comite','cr_concepto','cr_concepto_credito','cr_concepto_rubro',
'cr_matriz_mrc','cr_enfermedades','cr_tipo_empresa_mrc','cr_tipo_cliente_mrc','cr_calificacion_mrc',
'cr_obg_pers','cr_unidades','cr_tipo_carne','cr_tipos_seguro','cr_coberturas','cr_excepciones',
'cr_criterio_rutero','cr_estado_mic','cr_tipo_asegurado','cr_concepto_recuperabilidad','cr_tipo_cobro',
'cr_tipo_contacto','cr_tipo_carta','cr_tipo_observ','cr_destino_carta','cr_efecto','cr_est_concordato',
'cr_estado_cobranza','cr_estado_cupo','cr_estado_desembolso_parcial','cr_estado_garantia','cr_estado_ins',
'cr_estado_tramite','cr_etapa','cr_linea_carta','cr_novedades','cr_problemas','cr_proceso','cr_producto_consolidador',
'cr_proposito','cr_razon','cr_razon_visita','cr_relaciones','cr_renovacion','cr_requisitos','cr_rol_deudor',
'cr_sib','cr_subtipo_tramite','cr_taccion','cr_tcarta','cr_tipo_cobrador','cr_tipo_cupo','cr_tipo_garantia',
'cr_tipo_rechazo','cr_especialidad','cr_calif_ab','cr_causal_situacion','cr_indicador_abog','sb_ctas_tesoreria',
'cr_man_un_rec_bac','cr_sujeto_cred','cr_primer_nivel','cr_segundo_nivel','cr_tercer_nivel','cr_cuarto_nivel',
'cr_parametros_fuente','cr_tipo_oblig','cr_concepto_ef','cr_meses','cr_dias_semana','cr_tipo_local','cr_tipo_emp',
'cr_tipo_cond','cr_tipo_contr','cr_tipo_bien','cr_tipo_activo','cr_gasto_otros','cr_gasto_trans','cr_ingresos_adic',
'cr_gastos_famili','cr_destino','cr_seguro_plan','cr_fuente_recurso','cr_tipo_cotr','cr_med_ext','cr_viene_otros_bancos','cr_causa_victima',
'cr_credito_solicitado','cr_seguro_parentesco','cr_sol_exp','cr_parentesco_micro','cr_parentesco_segexe','cu_concepto_avaluo',
'cr_estado_activo', 'cr_motivo_reestruct','cr_act_prodrur', 'cr_tipo_gestor','cr_tipo_calif','cr_motivo_rechazo','cr_frecuencia','cr_redes_sociales',
'cr_tipo_telefono','cr_tipo_pago_telefono','cr_plazo_ind','cr_tplazo_ind', 'cr_flujo_grp','cr_doc_digitalizado','cr_doc_digitalizado_ind',
'cr_resultado_cobro', 'cr_resultado_desembolso_format', 'cr_resultado_desembolso_detall','cr_dividendo_report','cr_doc_digitalizado_flujo_ind','cr_doc_prospecto','cr_tipo_negocio',
'cr_tipo_contrato','cr_tipo_responsabilidad','cr_tipo_cuenta','cr_forma_pago','cr_clave_observacion','cr_correo_rfc_Global','cr_etapa_genera_tabla',
'cr_hab_upload_por_rol','cr_activ_desp_gar_liq','cr_txt_documento','cr_act_cuestionario')
  and codigo = cp_tabla
go
delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cr_juzgado','ah_est_ahpro','cr_aprob_garantia',
'cr_calificacion','cr_cat_observacion','cr_causales_devolucion','cr_ccosto',
'cr_clase_abogado','cr_clase_cartera','cr_clase_abogado_externo','cr_codificacion_medidas',
'cr_comite','cr_concepto','cr_concepto_credito','cr_concepto_rubro',
'cr_matriz_mrc','cr_enfermedades','cr_tipo_empresa_mrc','cr_tipo_cliente_mrc','cr_calificacion_mrc',
'cr_obg_pers','cr_unidades','cr_tipo_carne','cr_tipos_seguro','cr_coberturas','cr_excepciones',
'cr_criterio_rutero','cr_estado_mic','cr_tipo_asegurado','cr_concepto_recuperabilidad','cr_tipo_cobro',
'cr_tipo_contacto','cr_tipo_carta','cr_tipo_observ','cr_destino_carta','cr_efecto','cr_est_concordato',
'cr_estado_cobranza','cr_estado_cupo','cr_estado_desembolso_parcial','cr_estado_garantia','cr_estado_ins',
'cr_estado_tramite','cr_etapa','cr_linea_carta','cr_novedades','cr_problemas','cr_proceso','cr_producto_consolidador',
'cr_proposito','cr_razon','cr_razon_visita','cr_relaciones','cr_renovacion','cr_requisitos','cr_rol_deudor',
'cr_sib','cr_subtipo_tramite','cr_taccion','cr_tcarta','cr_tipo_cobrador','cr_tipo_cupo','cr_tipo_garantia',
'cr_tipo_rechazo','cr_especialidad','cr_calif_ab','cr_causal_situacion','cr_indicador_abog','sb_ctas_tesoreria',
'cr_man_un_rec_bac','cr_sujeto_cred','cr_primer_nivel','cr_segundo_nivel','cr_tercer_nivel','cr_cuarto_nivel',
'cr_parametros_fuente','cr_tipo_oblig','cr_concepto_ef','cr_meses','cr_dias_semana','cr_tipo_local','cr_tipo_emp',
'cr_tipo_cond','cr_tipo_contr','cr_tipo_bien','cr_tipo_activo','cr_gasto_otros','cr_gasto_trans','cr_ingresos_adic',
'cr_gastos_famili','cr_destino','cr_seguro_plan','cr_fuente_recurso','cr_tipo_cotr','cr_med_ext','cr_viene_otros_bancos','cr_causa_victima',
'cr_credito_solicitado','cr_seguro_parentesco','cr_sol_exp','cr_parentesco_micro','cr_parentesco_segexe','cu_concepto_avaluo',
'cr_estado_activo', 'cr_motivo_reestruct','cr_act_prodrur','cr_tipo_gestor','cr_tipo_calif','cr_motivo_rechazo','cr_frecuencia','cr_redes_sociales',
'cr_tipo_telefono','cr_tipo_pago_telefono','cr_plazo_ind','cr_tplazo_ind', 'cr_flujo_grp','cr_doc_digitalizado','cr_doc_digitalizado_ind',
'cr_resultado_cobro', 'cr_resultado_desembolso_format', 'cr_resultado_desembolso_detall','cr_dividendo_report','cr_doc_digitalizado_flujo_ind','cr_doc_prospecto','cr_tipo_negocio',
'cr_tipo_contrato','cr_tipo_responsabilidad','cr_tipo_cuenta','cr_forma_pago','cr_clave_observacion','cr_correo_rfc_Global','cr_etapa_genera_tabla',
'cr_hab_upload_por_rol','cr_activ_desp_gar_liq','cr_txt_documento','cr_act_cuestionario')
  and cl_tabla.codigo = cl_catalogo.tabla
go
delete cl_tabla
where cl_tabla.tabla in ('cr_juzgado','ah_est_ahpro','cr_aprob_garantia',
'cr_calificacion','cr_cat_observacion','cr_causales_devolucion','cr_ccosto',
'cr_clase_abogado','cr_clase_cartera','cr_clase_abogado_externo','cr_codificacion_medidas',
'cr_comite','cr_concepto','cr_concepto_credito','cr_concepto_rubro',
'cr_matriz_mrc','cr_enfermedades','cr_tipo_empresa_mrc','cr_tipo_cliente_mrc','cr_calificacion_mrc',
'cr_obg_pers','cr_unidades','cr_tipo_carne','cr_tipos_seguro','cr_coberturas','cr_excepciones',
'cr_criterio_rutero','cr_estado_mic','cr_tipo_asegurado','cr_concepto_recuperabilidad','cr_tipo_cobro',
'cr_tipo_contacto','cr_tipo_carta','cr_tipo_observ','cr_destino_carta','cr_efecto','cr_est_concordato',
'cr_estado_cobranza','cr_estado_cupo','cr_estado_desembolso_parcial','cr_estado_garantia','cr_estado_ins',
'cr_estado_tramite','cr_etapa','cr_linea_carta','cr_novedades','cr_problemas','cr_proceso','cr_producto_consolidador',
'cr_proposito','cr_razon','cr_razon_visita','cr_relaciones','cr_renovacion','cr_requisitos','cr_rol_deudor',
'cr_sib','cr_subtipo_tramite','cr_taccion','cr_tcarta','cr_tipo_cobrador','cr_tipo_cupo','cr_tipo_garantia',
'cr_tipo_rechazo','cr_especialidad','cr_calif_ab','cr_causal_situacion','cr_indicador_abog','sb_ctas_tesoreria',
'cr_man_un_rec_bac','cr_sujeto_cred','cr_primer_nivel','cr_segundo_nivel','cr_tercer_nivel','cr_cuarto_nivel',
'cr_parametros_fuente','cr_tipo_oblig','cr_concepto_ef','cr_meses','cr_dias_semana','cr_tipo_local','cr_tipo_emp',
'cr_tipo_cond','cr_tipo_contr','cr_tipo_bien','cr_tipo_activo','cr_gasto_otros','cr_gasto_trans','cr_ingresos_adic',
'cr_gastos_famili','cr_destino','cr_seguro_plan','cr_fuente_recurso','cr_tipo_cotr','cr_med_ext','cr_viene_otros_bancos','cr_causa_victima',
'cr_credito_solicitado','cr_seguro_parentesco','cr_sol_exp','cr_parentesco_micro','cr_parentesco_segexe','cu_concepto_avaluo',
'cr_estado_activo', 'cr_motivo_reestruct','cr_act_prodrur','cr_tipo_gestor','cr_tipo_calif','cr_motivo_rechazo','cr_frecuencia','cr_redes_sociales',
'cr_tipo_telefono','cr_tipo_pago_telefono','cr_plazo_ind','cr_tplazo_ind', 'cr_flujo_grp','cr_doc_digitalizado','cr_doc_digitalizado_ind',
'cr_resultado_cobro', 'cr_resultado_desembolso_format', 'cr_resultado_desembolso_detall','cr_dividendo_report','cr_doc_digitalizado_flujo_ind','cr_doc_prospecto','cr_tipo_negocio',
'cr_tipo_contrato','cr_tipo_responsabilidad','cr_tipo_cuenta','cr_forma_pago','cr_clave_observacion','cr_correo_rfc_Global','cr_etapa_genera_tabla',
'cr_hab_upload_por_rol','cr_activ_desp_gar_liq','cr_txt_documento','cr_act_cuestionario')
go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_juzgado                     ', ' JUZGADOS                                                      ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10001', '(CHO) ACANDI 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10002', '(CHO) BAGADO 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10003', '(CHO) BAHIA SOLANO 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10004', '(CHO) BAHIA SOLANO 01 JUZGADO PROMISCUO CIRCUITO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10005', '(CHO) BAJO BAUDO 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10006', '(CHO) BOJAYA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10007', '(CHO) CONDOTO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10008', '(CHO) EL CARMEN 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10009', '(CHO) EL LITORAL DEL SAN JUAN 01 JUZGADO MUNICIPAL PROMISCUO     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1001', '(ANT) ABEJORRAL 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10010', '(CHO) ITSMINA 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10011', '(CHO) ITSMINA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10012', '(CHO) JURADO 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10013', '(CHO) LLORO 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10014', '(CHO) MEDIO BAUDO 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10015', '(CHO) NOVITA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10016', '(CHO) NUQUI 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10017', '(CHO) QUIBDO 01 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10018', '(CHO) QUIBDO 01 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10019', '(CHO) QUIBDO 02 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1002', '(ANT) ABEJORRAL 01 JUZGADO PROMISCUO CIRCUITO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10020', '(CHO) RIOSUCIO 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10021', '(CHO) RIOSUCIO 01 JUZGADO PROMISCUO CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10022', '(CHO) SAN JOSE DEL PALMAR 01 JUZGADO MUNICIPAL PROMISCUO         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10023', '(CHO) SIPI 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10024', '(CHO) TADO 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10025', '(CHO) UNGUIA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1003', '(ANT) ABRIAQUI 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1004', '(ANT) ALEJANDRIA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1005', '(ANT) AMAGA 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1006', '(ANT) AMAGA 02 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1007', '(ANT) AMALFI 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1008', '(ANT) AMALFI 01 JUZGADO PROMISCUO CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1009', '(ANT) ANDES 01 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1010', '(ANT) ANDES 01 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1011', '(ANT) ANGELOPOLIS 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1012', '(ANT) ANGOSTURA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1013', '(ANT) ANORI 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1014', '(ANT) ANZA 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1015', '(ANT) APARTADO 01 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1016', '(ANT) APARTADO 01 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1017', '(ANT) ARBOLETES 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1018', '(ANT) ARGELIA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1019', '(ANT) ARMENIA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1020', '(ANT) BARBOSA 01 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1021', '(ANT) BELLO 01 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1022', '(ANT) BELLO 01 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1023', '(ANT) BELLO 02 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1024', '(ANT) BELLO 02 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1025', '(ANT) BELMIRA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1026', '(ANT) BETANIA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1027', '(ANT) BETULIA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1028', '(ANT) BRICE�O 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1029', '(ANT) BURITICA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1030', '(ANT) CACERES 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1031', '(ANT) CAICEDO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1032', '(ANT) CALDAS 01 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1033', '(ANT) CAMPAMENTO 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1034', '(ANT) CARACOLI 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1035', '(ANT) CAREPA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1036', '(ANT) CARMEN DE VIBORAL 01 JUZGADO CIVIL MUNICIPAL               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1037', '(ANT) CAROLINA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1038', '(ANT) CAUCASIA 01 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1039', '(ANT) CAUCASIA 01 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1040', '(ANT) CA�ASGORDAS 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1041', '(ANT) CHIGORODO 01 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1042', '(ANT) CISNEROS 01 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1043', '(ANT) CISNEROS 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1044', '(ANT) CIUDAD BOLIVAR 01 JUZGADO CIVIL CIRCUITO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1045', '(ANT) CIUDAD BOLIVAR 01 JUZGADO CIVIL MUNICIPAL                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1046', '(ANT) COCORNA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1047', '(ANT) CONCEPCION 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1048', '(ANT) CONCORDIA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1049', '(ANT) COPACABANA 01 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1050', '(ANT) DABEIBA 01 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1051', '(ANT) DABEIBA 01 JUZGADO PROMISCUO CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1052', '(ANT) DON MATIAS 01 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1053', '(ANT) EBEJICO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1054', '(ANT) EL BAGRE 01 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1055', '(ANT) EL BAGRE 01 JUZGADO PROMISCUO CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1056', '(ANT) ENTRERRIOS 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1057', '(ANT) ENVIGADO 01 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1058', '(ANT) ENVIGADO 01 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1059', '(ANT) ENVIGADO 02 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1060', '(ANT) ENVIGADO 02 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1061', '(ANT) FREDONIA 01 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1062', '(ANT) FREDONIA 01 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1063', '(ANT) FRONTINO 01 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1064', '(ANT) GIRALDO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1065', '(ANT) GIRARDOTA 01 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1066', '(ANT) GIRARDOTA 01 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1067', '(ANT) GOMEZ PLATA 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1068', '(ANT) GRANADA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1069', '(ANT) GUADALUPE 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1070', '(ANT) GUARNE 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1071', '(ANT) GUARNE 02 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1072', '(ANT) GUATAPE 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1073', '(ANT) HELICONIA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1074', '(ANT) HISPANIA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1075', '(ANT) ITAGUI 01 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1076', '(ANT) ITAGUI 01 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1077', '(ANT) ITAGUI 02 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1078', '(ANT) ITAGUI 02 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1079', '(ANT) ITAGUI 03 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1080', '(ANT) ITUANGO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1081', '(ANT) ITUANGO 01 JUZGADO PROMISCUO CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1082', '(ANT) JARDIN 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1083', '(ANT) JERICO 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1084', '(ANT) JERICO 01 JUZGADO PROMISCUO CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1085', '(ANT) LA CEJA 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1086', '(ANT) LA CEJA 01 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1087', '(ANT) LA ESTRELLA 01 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1088', '(ANT) LA UNION 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1089', '(ANT) LIBORINA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1090', '(ANT) MARINILLA 01 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1091', '(ANT) MARINILLA 01 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1092', '(ANT) MEDELLIN 01 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1093', '(ANT) MEDELLIN 01 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1094', '(ANT) MEDELLIN 02 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1095', '(ANT) MEDELLIN 02 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1096', '(ANT) MEDELLIN 03 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1097', '(ANT) MEDELLIN 03 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1098', '(ANT) MEDELLIN 04 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1099', '(ANT) MEDELLIN 04 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1100', '(ANT) MEDELLIN 06 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11001', '(COR) AYAPEL 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11002', '(COR) AYAPEL 01 JUZGADO PROMISCUO CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11003', '(COR) BUENAVISTA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11004', '(COR) CANALETE 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11005', '(COR) CERETE 01 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11006', '(COR) CERETE 01 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11007', '(COR) CERETE 02 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11008', '(COR) CHIMA 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11009', '(COR) CHINU 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1101', '(ANT) MEDELLIN 06 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11010', '(COR) CHINU 01 JUZGADO PROMISCUO CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11011', '(COR) CIENAGA DE ORO 01 JUZGADO MUNICIPAL PROMISCUO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11012', '(COR) LORICA 01 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11013', '(COR) LORICA 01 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11014', '(COR) LOS CORDOBAS 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11015', '(COR) MOMIL 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11016', '(COR) MONTELIBANO 01 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11017', '(COR) MONTELIBANO 01 JUZGADO PROMISCUO CIRCUITO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11018', '(COR) MONTERIA 01 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11019', '(COR) MONTERIA 01 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1102', '(ANT) MEDELLIN 07 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11020', '(COR) MONTERIA 02 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11021', '(COR) MONTERIA 02 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11022', '(COR) MONTERIA 03 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11023', '(COR) MONTERIA 03 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11024', '(COR) MONTERIA 04 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11025', '(COR) MONTERIA 04 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11026', '(COR) MONTERIA 05 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11027', '(COR) MO�ITOS 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11028', '(COR) PLANETA RICA 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11029', '(COR) PLANETA RICA 01 JUZGADO PROMISCUO CIRCUITO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1103', '(ANT) MEDELLIN 07 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11030', '(COR) PUEBLO NUEVO 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11031', '(COR) PUERTO ESCONDIDO 01 JUZGADO MUNICIPAL PROMISCUO            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11032', '(COR) PUERTO LIBERTADOR 01 JUZGADO MUNICIPAL PROMISCUO           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11033', '(COR) PURISIMA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11034', '(COR) SAHAGUN 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11035', '(COR) SAHAGUN 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11036', '(COR) SAN ANDRES DE SOTAVENTO 01 JUZGADO MUNICIPAL PROMISCUO     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11037', '(COR) SAN ANTERO 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11038', '(COR) SAN BERNARDO DEL VIENTO 01 JUZGADO MUNICIPAL PROMISCUO     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11039', '(COR) SAN CARLOS 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1104', '(ANT) MEDELLIN 08 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11040', '(COR) SAN PELAYO 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11041', '(COR) TIERRALTA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11042', '(COR) TIERRALTA 02 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11043', '(COR) VALENCIA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1105', '(ANT) MEDELLIN 08 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1106', '(ANT) MEDELLIN 09 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1107', '(ANT) MEDELLIN 09 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1108', '(ANT) MEDELLIN 10 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1109', '(ANT) MEDELLIN 10 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1110', '(ANT) MEDELLIN 100 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1111', '(ANT) MEDELLIN 11 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1112', '(ANT) MEDELLIN 11 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1113', '(ANT) MEDELLIN 12 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1114', '(ANT) MEDELLIN 12 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1115', '(ANT) MEDELLIN 13 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1116', '(ANT) MEDELLIN 13 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1117', '(ANT) MEDELLIN 14 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1118', '(ANT) MEDELLIN 14 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1119', '(ANT) MEDELLIN 15 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1120', '(ANT) MEDELLIN 15 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1121', '(ANT) MEDELLIN 16 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1122', '(ANT) MEDELLIN 16 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1123', '(ANT) MEDELLIN 17 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1124', '(ANT) MEDELLIN 17 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1125', '(ANT) MEDELLIN 18 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1126', '(ANT) MEDELLIN 19 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1127', '(ANT) MEDELLIN 20 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1128', '(ANT) MEDELLIN 200 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1129', '(ANT) MEDELLIN 21 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1130', '(ANT) MEDELLIN 22 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1131', '(ANT) MEDELLIN 23 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1132', '(ANT) MEDELLIN 300 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1133', '(ANT) MEDELLIN 400 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1134', '(ANT) MEDELLIN 500 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1135', '(ANT) MEDELLIN 600 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1136', '(ANT) PUERTO BERRIO 01 JUZGADO CIVIL CIRCUITO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1137', '(ANT) PUERTO BERRIO 01 JUZGADO CIVIL MUNICIPAL                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1138', '(ANT) RIONEGRO 01 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1139', '(ANT) RIONEGRO 01 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1140', '(ANT) RIONEGRO 02 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1141', '(ANT) RIONEGRO 02 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1142', '(ANT) SABANETA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1143', '(ANT) SABANETA 02 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1144', '(ANT) SALGAR 01 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1145', '(ANT) SAN PEDRO 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1146', '(ANT) SANTA BARBARA 01 JUZGADO CIVIL MUNICIPAL                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1147', '(ANT) SANTA BARBARA 01 JUZGADO PROMISCUO CIRCUITO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1148', '(ANT) SANTA BARBARA 02 JUZGADO PROMISCUO CIRCUITO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1149', '(ANT) SANTA FE DE ANTIOQUIA 01 JUZGADO MUNICIPAL PROMISCUO       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1150', '(ANT) SANTA ROSA DE OSOS 01 JUZGADO PROMISCUO CIRCUITO           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1151', '(ANT) SANTA ROSA DE OSOS 02 JUZGADO PROMISCUO CIRCUITO           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1152', '(ANT) SANTUARIO 01 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1153', '(ANT) SEGOVIA 01 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1154', '(ANT) SEGOVIA 01 JUZGADO PROMISCUO CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1155', '(ANT) SONSON 01 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1156', '(ANT) SONSON 01 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1157', '(ANT) SOPETRAN 01 JUZGADO PROMISCUO CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1158', '(ANT) TAMESIS 01 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1159', '(ANT) TAMESIS 01 JUZGADO PROMISCUO CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1160', '(ANT) TITIRIBI 01 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1161', '(ANT) TURBO 01 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1162', '(ANT) TURBO 01 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1163', '(ANT) URRAO 01 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1164', '(ANT) URRAO 01 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1165', '(ANT) YARUMAL 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1166', '(ANT) YARUMAL 01 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1167', '(ANT) YOLOMBO 01 JUZGADO PROMISCUO CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12001', '(CUN) ANAPOIMA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12002', '(CUN) ANOLAIMA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12003', '(CUN) ARBELAEZ 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12004', '(CUN) BOGOTA D.C 01 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12005', '(CUN) BOGOTA D.C 01 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12006', '(CUN) BOGOTA D.C 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12007', '(CUN) BOGOTA D.C 02 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12008', '(CUN) BOGOTA D.C 02 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12009', '(CUN) BOGOTA D.C 03 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12010', '(CUN) BOGOTA D.C 03 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12011', '(CUN) BOGOTA D.C 04 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12012', '(CUN) BOGOTA D.C 04 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12013', '(CUN) BOGOTA D.C 05 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12014', '(CUN) BOGOTA D.C 05 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12015', '(CUN) BOGOTA D.C 06 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12016', '(CUN) BOGOTA D.C 06 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12017', '(CUN) BOGOTA D.C 07 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12018', '(CUN) BOGOTA D.C 07 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12019', '(CUN) BOGOTA D.C 08 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12020', '(CUN) BOGOTA D.C 08 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12021', '(CUN) BOGOTA D.C 09 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12022', '(CUN) BOGOTA D.C 09 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12023', '(CUN) BOGOTA D.C 10 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12024', '(CUN) BOGOTA D.C 10 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12025', '(CUN) BOGOTA D.C 11 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12026', '(CUN) BOGOTA D.C 11 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12027', '(CUN) BOGOTA D.C 12 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12028', '(CUN) BOGOTA D.C 12 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12029', '(CUN) BOGOTA D.C 13 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12030', '(CUN) BOGOTA D.C 13 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12031', '(CUN) BOGOTA D.C 14 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12032', '(CUN) BOGOTA D.C 14 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12033', '(CUN) BOGOTA D.C 15 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12034', '(CUN) BOGOTA D.C 15 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12035', '(CUN) BOGOTA D.C 16 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12036', '(CUN) BOGOTA D.C 16 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12037', '(CUN) BOGOTA D.C 17 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12038', '(CUN) BOGOTA D.C 17 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12039', '(CUN) BOGOTA D.C 18 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12040', '(CUN) BOGOTA D.C 18 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12041', '(CUN) BOGOTA D.C 19 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12042', '(CUN) BOGOTA D.C 19 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12043', '(CUN) BOGOTA D.C 20 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12044', '(CUN) BOGOTA D.C 20 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12045', '(CUN) BOGOTA D.C 21 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12046', '(CUN) BOGOTA D.C 21 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12047', '(CUN) BOGOTA D.C 22 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12048', '(CUN) BOGOTA D.C 22 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12049', '(CUN) BOGOTA D.C 23 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12050', '(CUN) BOGOTA D.C 23 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12051', '(CUN) BOGOTA D.C 24 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12052', '(CUN) BOGOTA D.C 24 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12053', '(CUN) BOGOTA D.C 25 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12054', '(CUN) BOGOTA D.C 25 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12055', '(CUN) BOGOTA D.C 26 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12056', '(CUN) BOGOTA D.C 26 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12057', '(CUN) BOGOTA D.C 27 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12058', '(CUN) BOGOTA D.C 27 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12059', '(CUN) BOGOTA D.C 28 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12060', '(CUN) BOGOTA D.C 28 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12061', '(CUN) BOGOTA D.C 29 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12062', '(CUN) BOGOTA D.C 29 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12063', '(CUN) BOGOTA D.C 30 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12064', '(CUN) BOGOTA D.C 30 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12065', '(CUN) BOGOTA D.C 31 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12066', '(CUN) BOGOTA D.C 31 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12067', '(CUN) BOGOTA D.C 32 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12068', '(CUN) BOGOTA D.C 32 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12069', '(CUN) BOGOTA D.C 33 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12070', '(CUN) BOGOTA D.C 33 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12071', '(CUN) BOGOTA D.C 34 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12072', '(CUN) BOGOTA D.C 34 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12073', '(CUN) BOGOTA D.C 35 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12074', '(CUN) BOGOTA D.C 35 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12075', '(CUN) BOGOTA D.C 36 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12076', '(CUN) BOGOTA D.C 36 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12077', '(CUN) BOGOTA D.C 37 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12078', '(CUN) BOGOTA D.C 37 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12079', '(CUN) BOGOTA D.C 38 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12080', '(CUN) BOGOTA D.C 38 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12081', '(CUN) BOGOTA D.C 39 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12082', '(CUN) BOGOTA D.C 39 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12083', '(CUN) BOGOTA D.C 40 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12084', '(CUN) BOGOTA D.C 40 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12085', '(CUN) BOGOTA D.C 41 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12086', '(CUN) BOGOTA D.C 41 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12087', '(CUN) BOGOTA D.C 42 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12088', '(CUN) BOGOTA D.C 42 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12089', '(CUN) BOGOTA D.C 43 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12090', '(CUN) BOGOTA D.C 43 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12091', '(CUN) BOGOTA D.C 44 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12092', '(CUN) BOGOTA D.C 45 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12093', '(CUN) BOGOTA D.C 46 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12094', '(CUN) BOGOTA D.C 47 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12095', '(CUN) BOGOTA D.C 48 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12096', '(CUN) BOGOTA D.C 49 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12097', '(CUN) BOGOTA D.C 50 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12098', '(CUN) BOGOTA D.C 51 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12099', '(CUN) BOGOTA D.C 52 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12100', '(CUN) BOGOTA D.C 53 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12101', '(CUN) BOGOTA D.C 54 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12102', '(CUN) BOGOTA D.C 55 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12103', '(CUN) BOGOTA D.C 56 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12104', '(CUN) BOGOTA D.C 57 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12105', '(CUN) BOGOTA D.C 58 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12106', '(CUN) BOJACA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12107', '(CUN) CABRERA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12108', '(CUN) CACHIPAY 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12109', '(CUN) CAJICA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12110', '(CUN) CAJICA 02 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12111', '(CUN) CAPARRAPI 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12112', '(CUN) CAQUEZA 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12113', '(CUN) CAQUEZA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12114', '(CUN) CARMEN DE CARUPA 01 JUZGADO MUNICIPAL PROMISCUO            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12115', '(CUN) CHIA 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12116', '(CUN) CHIA 02 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12117', '(CUN) CHIA 03 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12118', '(CUN) CHIPAQUE 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12119', '(CUN) CHOACHI 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12120', '(CUN) CHOCONTA 01 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12121', '(CUN) COTA 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12122', '(CUN) CUCUNUBA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12123', '(CUN) EL COLEGIO 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12124', '(CUN) EL PE�ON 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12125', '(CUN) FACATATIVA 01 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12126', '(CUN) FACATATIVA 02 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12127', '(CUN) FUNZA 01 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12128', '(CUN) FUSAGASUGA 01 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12129', '(CUN) FUSAGASUGA 02 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12130', '(CUN) GACHETA 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12131', '(CUN) GIRARDOT 01 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12132', '(CUN) GIRARDOT 02 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12133', '(CUN) GUADUAS 01 JUZGADO PROMISCUO CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12134', '(CUN) GUAYABETAL 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12135', '(CUN) LA MESA 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12136', '(CUN) LA PALMA 01 JUZGADO PROMISCUO CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12137', '(CUN) MEDINA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12138', '(CUN) PACHO 01 JUZGADO PROMISCUO CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12139', '(CUN) PARATEBUENO 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12140', '(CUN) SOACHA 01 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12141', '(CUN) SOACHA 02 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12142', '(CUN) UBATE 01 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12143', '(CUN) VILLETA 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12144', '(CUN) ZIPAQUIRA 01 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12145', '(CUN) ZIPAQUIRA 02 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '13001', '(GUAI) BARRANCO MINA 01 JUZGADO MUNICIPAL PROMISCUO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '13002', '(GUAI) INIRIDA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '13003', '(GUAI) SAN FELIPE 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14001', '(GUAJ) BARRANCAS 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14002', '(GUAJ) EL MOLINO 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14003', '(GUAJ) FONSECA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14004', '(GUAJ) MAICAO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14005', '(GUAJ) MAICAO 01 JUZGADO PROMISCUO CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14006', '(GUAJ) MAICAO 02 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14007', '(GUAJ) MAICAO 02 JUZGADO PROMISCUO CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14008', '(GUAJ) MANAURE 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14009', '(GUAJ) RIOHACHA 01 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14010', '(GUAJ) RIOHACHA 01 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14011', '(GUAJ) RIOHACHA 02 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14012', '(GUAJ) RIOHACHA 02 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14013', '(GUAJ) RIOHACHA 03 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14014', '(GUAJ) SAN JUAN DEL CESAR 01 JUZGADO CIVIL MUNICIPAL             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14015', '(GUAJ) SAN JUAN DEL CESAR 01 JUZGADO PROMISCUO CIRCUITO          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14016', '(GUAJ) URIBIA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14017', '(GUAJ) URUMITA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14018', '(GUAJ) VILLANUEVA 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14019', '(GUAJ) VILLANUEVA 01 JUZGADO PROMISCUO CIRCUITO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '15001', '(GUAV) MIRAFLORES 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '15002', '(GUAV) SAN JOSE DEL GUAVIARE 01 JUZGADO MUNICIPAL PROMISCUO      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16001', '(HUI) ACEVEDO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16002', '(HUI) AGRADO 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16003', '(HUI) AIPE 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16004', '(HUI) ALGECIRAS 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16005', '(HUI) ALGECIRAS 02 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16006', '(HUI) ALTAMIRA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16007', '(HUI) BARAYA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16008', '(HUI) CAMPOALEGRE 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16009', '(HUI) CAMPOALEGRE 02 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16010', '(HUI) COLOMBIA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16011', '(HUI) GARZON 01 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16012', '(HUI) GARZON 01 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16013', '(HUI) GARZON 02 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16014', '(HUI) GARZON 02 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16015', '(HUI) GIGANTE 01 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16016', '(HUI) GUADALUPE 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16017', '(HUI) HOBO 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16018', '(HUI) IQUIRA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16019', '(HUI) ISNOS 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16020', '(HUI) ISNOS 02 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16021', '(HUI) LA ARGENTINA 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16022', '(HUI) LA PLATA 01 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16023', '(HUI) LA PLATA 01 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16024', '(HUI) NATAGA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16025', '(HUI) NEIVA 01 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16026', '(HUI) NEIVA 01 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16027', '(HUI) NEIVA 02 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16028', '(HUI) NEIVA 02 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16029', '(HUI) NEIVA 03 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16030', '(HUI) NEIVA 03 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16031', '(HUI) NEIVA 04 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16032', '(HUI) NEIVA 04 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16033', '(HUI) NEIVA 05 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16034', '(HUI) NEIVA 05 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16035', '(HUI) NEIVA 06 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16036', '(HUI) NEIVA 07 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16037', '(HUI) NEIVA 08 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16038', '(HUI) NEIVA 09 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16039', '(HUI) NEIVA 10 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16040', '(HUI) OPORAPA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16041', '(HUI) PAICOL 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16042', '(HUI) PALERMO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16043', '(HUI) PALERMO 02 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16044', '(HUI) PALESTINA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16045', '(HUI) PITAL 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16046', '(HUI) PITALITO 01 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16047', '(HUI) PITALITO 01 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16048', '(HUI) PITALITO 02 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16049', '(HUI) PITALITO 02 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16050', '(HUI) PITALITO 03 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16051', '(HUI) PITALITO 03 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16052', '(HUI) RIVERA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16053', '(HUI) SALADOBLANCO 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16054', '(HUI) SAN AGUSTIN 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16055', '(HUI) SAN AGUSTIN 02 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16056', '(HUI) SANTA MARIA 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16057', '(HUI) SUAZA 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16058', '(HUI) TARQUI 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16059', '(HUI) TELLO 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16060', '(HUI) TERUEL 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16061', '(HUI) TESALIA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16062', '(HUI) TIMANA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16063', '(HUI) VILLAVIEJA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16064', '(HUI) YAGUARA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17001', '(MAG) ARACATACA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17002', '(MAG) ARIGUANI 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17003', '(MAG) CERRO DE SAN ANTONIO 01 JUZGADO MUNICIPAL PROMISCUO        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17004', '(MAG) CHIVOLO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17005', '(MAG) CIENAGA 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17006', '(MAG) CIENAGA 02 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17007', '(MAG) EL BANCO 01 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17008', '(MAG) EL PI�ON 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17009', '(MAG) FUNDACION 01 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17010', '(MAG) GUAMAL 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17011', '(MAG) PEDRAZA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17012', '(MAG) PIVIJAY 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17013', '(MAG) REMOLINO 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17014', '(MAG) SALAMINA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17015', '(MAG) SAN SEBASTIAN DE BUENAVISTA 01 JUZGADO MUNICIPAL           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17016', '(MAG) SAN ZENON 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17017', '(MAG) SANTA ANA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17018', '(MAG) SANTA ANA 02 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17019', '(MAG) SANTA MARTA 01 JUZGADO CIVIL CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17020', '(MAG) SANTA MARTA 01 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17021', '(MAG) SANTA MARTA 02 JUZGADO CIVIL CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17022', '(MAG) SANTA MARTA 02 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17023', '(MAG) SANTA MARTA 03 JUZGADO CIVIL CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17024', '(MAG) SANTA MARTA 03 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17025', '(MAG) SANTA MARTA 04 JUZGADO CIVIL CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17026', '(MAG) SANTA MARTA 04 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17027', '(MAG) SANTA MARTA 05 JUZGADO CIVIL CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17028', '(MAG) SANTA MARTA 05 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17029', '(MAG) SANTA MARTA 06 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17030', '(MAG) SANTA MARTA 07 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17031', '(MAG) SITIONUEVO 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17032', '(MAG) TENERIFE 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18001', '(MET) ACACIAS 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18002', '(MET) ACACIAS 02 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18003', '(MET) CABUYARO 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18004', '(MET) CUBARRAL 02 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18005', '(MET) CUMARAL 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18006', '(MET) EL CALVARIO 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18007', '(MET) EL CASTILLO 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18008', '(MET) FUENTE DE ORO 01 JUZGADO MUNICIPAL PROMISCUO               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18009', '(MET) GUAMAL 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18010', '(MET) MAPIRIPAN 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18011', '(MET) PUERTO LLERAS 01 JUZGADO MUNICIPAL PROMISCUO               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18012', '(MET) PUERTO LOPEZ 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18013', '(MET) PUERTO LOPEZ 01 JUZGADO PROMISCUO CIRCUITO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18014', '(MET) PUERTO RICO 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18015', '(MET) RESTREPO 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18016', '(MET) SAN JUANITO 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18017', '(MET) SAN MARTIN 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18018', '(MET) SAN MARTIN 01 JUZGADO PROMISCUO CIRCUITO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18019', '(MET) VILLAVICENCIO 01 JUZGADO CIVIL CIRCUITO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18020', '(MET) VILLAVICENCIO 01 JUZGADO CIVIL MUNICIPAL                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18021', '(MET) VILLAVICENCIO 02 JUZGADO CIVIL CIRCUITO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18022', '(MET) VILLAVICENCIO 02 JUZGADO CIVIL MUNICIPAL                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18023', '(MET) VILLAVICENCIO 03 JUZGADO CIVIL CIRCUITO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18024', '(MET) VILLAVICENCIO 03 JUZGADO CIVIL MUNICIPAL                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18025', '(MET) VILLAVICENCIO 04 JUZGADO CIVIL CIRCUITO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18026', '(MET) VILLAVICENCIO 04 JUZGADO CIVIL MUNICIPAL                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18027', '(MET) VILLAVICENCIO 05 JUZGADO CIVIL MUNICIPAL                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18028', '(MET) VILLAVICENCIO 06 JUZGADO CIVIL MUNICIPAL                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18029', '(MET) VILLAVICENCIO 07 JUZGADO CIVIL MUNICIPAL                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19001', '(NAR) ACACIAS 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19002', '(NAR) ALBAN 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19003', '(NAR) ALDANA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19004', '(NAR) ANCUYA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19005', '(NAR) ARBOLEDA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19006', '(NAR) BARBACOAS 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19007', '(NAR) BARBACOAS 01 JUZGADO PROMISCUO CIRCUITO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19008', '(NAR) BELEN 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19009', '(NAR) BUESACO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19010', '(NAR) COLON 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19011', '(NAR) CONSACA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19012', '(NAR) CONTADERO 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19013', '(NAR) CORDOBA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19014', '(NAR) CUASPUD 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19015', '(NAR) CUMBAL 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19016', '(NAR) CUMBITARA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19017', '(NAR) EL CHARCO 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19018', '(NAR) EL ROSARIO 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19019', '(NAR) EL TABLON 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19020', '(NAR) EL TAMBO 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19021', '(NAR) FRANCISCO PIZARRO 01 JUZGADO MUNICIPAL PROMISCUO           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19022', '(NAR) FUNES 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19023', '(NAR) GUACHUCAL 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19024', '(NAR) GUAITARILLA 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19025', '(NAR) GUALMATAN 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19026', '(NAR) ILES 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19027', '(NAR) IMUES 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19028', '(NAR) IPIALES 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19029', '(NAR) IPIALES 01 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19030', '(NAR) IPIALES 02 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19031', '(NAR) IPIALES 02 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19032', '(NAR) LA CRUZ 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19033', '(NAR) LA CRUZ 01 JUZGADO PROMISCUO CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19034', '(NAR) LA FLORIDA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19035', '(NAR) LA UNION 01 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19036', '(NAR) LA UNION 01 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19037', '(NAR) LEIVA 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19038', '(NAR) LINARES 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19039', '(NAR) LOS ANDES 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19040', '(NAR) MAGUI 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19041', '(NAR) MALLAMA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19042', '(NAR) MOSQUERA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19043', '(NAR) OLAYA HERRERA 01 JUZGADO MUNICIPAL PROMISCUO               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19044', '(NAR) OSPINA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19045', '(NAR) PASTO 01 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19046', '(NAR) PASTO 01 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19047', '(NAR) PASTO 02 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19048', '(NAR) PASTO 02 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19049', '(NAR) PASTO 03 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19050', '(NAR) PASTO 03 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19051', '(NAR) PASTO 04 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19052', '(NAR) PASTO 04 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19053', '(NAR) PASTO 05 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19054', '(NAR) PASTO 06 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19055', '(NAR) POLICARPA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19056', '(NAR) POTOSI 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19057', '(NAR) PUERRES 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19058', '(NAR) PUPIALES 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19059', '(NAR) RICAURTE 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19060', '(NAR) SAMANIEGO 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19061', '(NAR) SAMANIEGO 01 JUZGADO PROMISCUO CIRCUITO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19062', '(NAR) SAMANIEGO 02 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19063', '(NAR) SAN LORENZO 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19064', '(NAR) SAN PABLO 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19065', '(NAR) SAN PEDRO DE CARTAGO 01 JUZGADO MUNICIPAL PROMISCUO        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19066', '(NAR) SANDONA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19067', '(NAR) SANDONA 02 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19068', '(NAR) SANTA CRUZ 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19069', '(NAR) SAPUYES 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19070', '(NAR) TANGUA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19071', '(NAR) TUMACO 01 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19072', '(NAR) TUMACO 01 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19073', '(NAR) TUMACO 02 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19074', '(NAR) TUMACO 02 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19075', '(NAR) TUQUERRES 01 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19076', '(NAR) TUQUERRES 01 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19077', '(NAR) TUQUERRES 02 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19078', '(NAR) YACUANQUER 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20001', '(NSTD) ABREGO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20002', '(NSTD) ARBOLEDAS 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20003', '(NSTD) BUCARASICA 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20004', '(NSTD) CHINACOTA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20005', '(NSTD) CHITAGA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20006', '(NSTD) CONVENCION 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20007', '(NSTD) CONVENCION 02 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20008', '(NSTD) CUCUTA 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20009', '(NSTD) CUCUTA 01 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2001', '(ATL) BARANOA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20010', '(NSTD) CUCUTA 02 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20011', '(NSTD) CUCUTA 02 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20012', '(NSTD) CUCUTA 03 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20013', '(NSTD) CUCUTA 03 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20014', '(NSTD) CUCUTA 04 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20015', '(NSTD) CUCUTA 04 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20016', '(NSTD) CUCUTA 05 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20017', '(NSTD) CUCUTA 05 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20018', '(NSTD) CUCUTA 06 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20019', '(NSTD) CUCUTA 06 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2002', '(ATL) BARANOA 02 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20020', '(NSTD) CUCUTA 07 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20021', '(NSTD) CUCUTA 07 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20022', '(NSTD) CUCUTA 08 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20023', '(NSTD) CUCUTA 09 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20024', '(NSTD) CUCUTA 10 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20025', '(NSTD) CUCUTILLA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20026', '(NSTD) DURANIA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20027', '(NSTD) EL CARMEN 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20028', '(NSTD) EL ZULIA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20029', '(NSTD) GRAMALOTE 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2003', '(ATL) BARRANQUILLA 01 JUZGADO CIVIL CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20030', '(NSTD) HACARI 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20031', '(NSTD) LA PLAYA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20032', '(NSTD) LABATECA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20033', '(NSTD) LOS PATIOS 01 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20034', '(NSTD) LOS PATIOS 01 JUZGADO PROMISCUO CIRCUITO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20035', '(NSTD) LOURDES 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20036', '(NSTD) MUTISCUA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20037', '(NSTD) OCA�A 01 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20038', '(NSTD) OCA�A 01 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20039', '(NSTD) OCA�A 02 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2004', '(ATL) BARRANQUILLA 01 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20040', '(NSTD) OCA�A 02 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20041', '(NSTD) OCA�A 03 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20042', '(NSTD) PAMPLONA 01 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20043', '(NSTD) PAMPLONA 01 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20044', '(NSTD) PAMPLONA 02 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20045', '(NSTD) PAMPLONA 02 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20046', '(NSTD) PAMPLONITA 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20047', '(NSTD) RAGONVALIA 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20048', '(NSTD) SALAZAR 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20049', '(NSTD) SAN CALIXTO 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2005', '(ATL) BARRANQUILLA 02 JUZGADO CIVIL CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20050', '(NSTD) SANTIAGO 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20051', '(NSTD) SARDINATA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20052', '(NSTD) SILOS 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20053', '(NSTD) TIBU 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20054', '(NSTD) TIBU 02 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20055', '(NSTD) TOLEDO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20056', '(NSTD) VILLA CARO 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20057', '(NSTD) VILLA DEL ROSARIO 01 JUZGADO MUNICIPAL PROMISCUO          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20058', '(NSTD) VILLA DEL ROSARIO 02 JUZGADO MUNICIPAL PROMISCUO          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2006', '(ATL) BARRANQUILLA 02 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2007', '(ATL) BARRANQUILLA 03 JUZGADO CIVIL CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2008', '(ATL) BARRANQUILLA 03 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2009', '(ATL) BARRANQUILLA 04 JUZGADO CIVIL CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2010', '(ATL) BARRANQUILLA 04 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2011', '(ATL) BARRANQUILLA 05 JUZGADO CIVIL CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2012', '(ATL) BARRANQUILLA 05 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2013', '(ATL) BARRANQUILLA 06 JUZGADO CIVIL CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2014', '(ATL) BARRANQUILLA 06 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2015', '(ATL) BARRANQUILLA 07 JUZGADO CIVIL CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2016', '(ATL) BARRANQUILLA 07 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2017', '(ATL) BARRANQUILLA 08 JUZGADO CIVIL CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2018', '(ATL) BARRANQUILLA 08 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2019', '(ATL) BARRANQUILLA 09 JUZGADO CIVIL CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2020', '(ATL) BARRANQUILLA 09 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2021', '(ATL) BARRANQUILLA 10 JUZGADO CIVIL CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2022', '(ATL) BARRANQUILLA 10 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2023', '(ATL) BARRANQUILLA 11 JUZGADO CIVIL CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2024', '(ATL) BARRANQUILLA 11 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2025', '(ATL) BARRANQUILLA 12 JUZGADO CIVIL CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2026', '(ATL) BARRANQUILLA 12 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2027', '(ATL) BARRANQUILLA 13 JUZGADO CIVIL CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2028', '(ATL) BARRANQUILLA 13 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2029', '(ATL) BARRANQUILLA 14 JUZGADO CIVIL CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2030', '(ATL) BARRANQUILLA 14 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2031', '(ATL) BARRANQUILLA 15 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2032', '(ATL) BARRANQUILLA 16 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2033', '(ATL) BARRANQUILLA 17 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2034', '(ATL) BARRANQUILLA 18 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2035', '(ATL) BARRANQUILLA 19 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2036', '(ATL) BARRANQUILLA 20 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2037', '(ATL) BARRANQUILLA 21 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2038', '(ATL) BARRANQUILLA 22 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2039', '(ATL) CAMPO DE LA CRUZ 01 JUZGADO MUNICIPAL PROMISCUO            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2040', '(ATL) GALAPA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2041', '(ATL) JUAN DE ACOSTA 01 JUZGADO MUNICIPAL PROMISCUO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2042', '(ATL) LURUACO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2043', '(ATL) MALAMBO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2044', '(ATL) MALAMBO 02 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2045', '(ATL) MANATI 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2046', '(ATL) PALMAR DE VARELA 01 JUZGADO MUNICIPAL PROMISCUO            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2047', '(ATL) PIOJO 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2048', '(ATL) POLONUEVO 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2049', '(ATL) PUERTO COLOMBIA 01 JUZGADO MUNICIPAL PROMISCUO             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2050', '(ATL) REPELON 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2051', '(ATL) SABANAGRANDE 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2052', '(ATL) SABANALARGA 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2053', '(ATL) SABANALARGA 01 JUZGADO PROMISCUO CIRCUITO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2054', '(ATL) SABANALARGA 02 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2055', '(ATL) SABANALARGA 02 JUZGADO PROMISCUO CIRCUITO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2056', '(ATL) SANTA LUCIA 03 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2057', '(ATL) SANTO TOMAS 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2058', '(ATL) SOLEDAD 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2059', '(ATL) SOLEDAD 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2060', '(ATL) SUAN 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21001', '(PUT) COLON 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21002', '(PUT) MOCOA 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21003', '(PUT) MOCOA 02 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21004', '(PUT) MOCOA 03 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21005', '(PUT) ORITO 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21006', '(PUT) PUERTO ASIS 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21007', '(PUT) PUERTO ASIS 01 JUZGADO PROMISCUO CIRCUITO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21008', '(PUT) PUERTO ASIS 02 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21009', '(PUT) PUERTO ASIS 02 JUZGADO PROMISCUO CIRCUITO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21010', '(PUT) PUERTO LEGUIZAMO 01 JUZGADO MUNICIPAL PROMISCUO            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21011', '(PUT) SAN FRANCISCO 01 JUZGADO MUNICIPAL PROMISCUO               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21012', '(PUT) SANTIAGO 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21013', '(PUT) SIBUNDOY 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21014', '(PUT) SIBUNDOY 01 JUZGADO PROMISCUO CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21015', '(PUT) VALLE DEL GUAMUEZ 01 JUZGADO MUNICIPAL PROMISCUO           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21016', '(PUT) VILLAGARZON 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22001', '(QUI) ARMENIA 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22002', '(QUI) ARMENIA 02 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22003', '(QUI) ARMENIA 03 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22004', '(QUI) ARMENIA 04 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22005', '(QUI) BUENAVISTA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22006', '(QUI) CALARCA 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22007', '(QUI) CIRCASIA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22008', '(QUI) CIRCASIA 02 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22009', '(QUI) CORDOBA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22010', '(QUI) FILANDIA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22011', '(QUI) GENOVA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22012', '(QUI) LA TEBAIDA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22013', '(QUI) LA TEBAIDA 02 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22014', '(QUI) MONTENEGRO 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22015', '(QUI) MONTENEGRO 02 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22016', '(QUI) PIJAO 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22017', '(QUI) QUIMBAYA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22018', '(QUI) QUIMBAYA 02 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22019', '(QUI) SALENTO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23001', '(RIS) APIA 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23002', '(RIS) APIA 01 JUZGADO PROMISCUO CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23003', '(RIS) BALBOA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23004', '(RIS) BELEN DE UMBRIA 01 JUZGADO MUNICIPAL PROMISCUO             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23005', '(RIS) BELEN DE UMBRIA 01 JUZGADO PROMISCUO CIRCUITO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23006', '(RIS) BELEN DE UMBRIA 02 JUZGADO MUNICIPAL PROMISCUO             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23007', '(RIS) DOSQUEBRADAS 01 JUZGADO CIVIL CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23008', '(RIS) DOSQUEBRADAS 01 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23009', '(RIS) DOSQUEBRADAS 02 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23010', '(RIS) DOSQUEBRADAS 03 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23011', '(RIS) GUATICA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23012', '(RIS) LA CELIA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23013', '(RIS) LA VIRGINIA 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23014', '(RIS) LA VIRGINIA 01 JUZGADO PROMISCUO CIRCUITO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23015', '(RIS) MARSELLA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23016', '(RIS) MISTRATO 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23017', '(RIS) PEREIRA 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23018', '(RIS) PEREIRA 01 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23019', '(RIS) PEREIRA 02 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23020', '(RIS) PEREIRA 02 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23021', '(RIS) PEREIRA 03 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23022', '(RIS) PEREIRA 03 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23023', '(RIS) PEREIRA 04 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23024', '(RIS) PEREIRA 04 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23025', '(RIS) PEREIRA 05 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23026', '(RIS) PEREIRA 05 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23027', '(RIS) PEREIRA 06 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23028', '(RIS) PEREIRA 07 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23029', '(RIS) PEREIRA 08 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23030', '(RIS) PUEBLO RICO 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23031', '(RIS) QUINCHIA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23032', '(RIS) QUINCHIA 01 JUZGADO PROMISCUO CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23033', '(RIS) SANTA ROSA DE CABAL 01 JUZGADO CIVIL CIRCUITO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23034', '(RIS) SANTA ROSA DE CABAL 01 JUZGADO CIVIL MUNICIPAL             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23035', '(RIS) SANTA ROSA DE CABAL 02 JUZGADO CIVIL MUNICIPAL             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23036', '(RIS) SANTUARIO 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24001', '(STD) AGUADA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24002', '(STD) ALBANIA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24003', '(STD) ARATOCA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24004', '(STD) BARBOSA 01 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24005', '(STD) BARBOSA 02 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24006', '(STD) BARICHARA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24007', '(STD) BARRANCABERMEJA 01 JUZGADO CIVIL CIRCUITO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24008', '(STD) BARRANCABERMEJA 01 JUZGADO CIVIL MUNICIPAL                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24009', '(STD) BARRANCABERMEJA 02 JUZGADO CIVIL CIRCUITO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24010', '(STD) BARRANCABERMEJA 02 JUZGADO CIVIL MUNICIPAL                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24011', '(STD) BARRANCABERMEJA 03 JUZGADO CIVIL CIRCUITO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24012', '(STD) BARRANCABERMEJA 03 JUZGADO CIVIL MUNICIPAL                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24013', '(STD) BOLIVAR 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24014', '(STD) BOLIVAR 02 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24015', '(STD) BUCARAMANGA 01 JUZGADO CIVIL CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24016', '(STD) BUCARAMANGA 01 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24017', '(STD) BUCARAMANGA 02 JUZGADO CIVIL CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24018', '(STD) BUCARAMANGA 02 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24019', '(STD) BUCARAMANGA 03 JUZGADO CIVIL CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24020', '(STD) BUCARAMANGA 03 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24021', '(STD) BUCARAMANGA 04 JUZGADO CIVIL CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24022', '(STD) BUCARAMANGA 04 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24023', '(STD) BUCARAMANGA 05 JUZGADO CIVIL CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24024', '(STD) BUCARAMANGA 05 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24025', '(STD) BUCARAMANGA 06 JUZGADO CIVIL CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24026', '(STD) BUCARAMANGA 06 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24027', '(STD) BUCARAMANGA 07 JUZGADO CIVIL CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24028', '(STD) BUCARAMANGA 07 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24029', '(STD) BUCARAMANGA 08 JUZGADO CIVIL CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24030', '(STD) BUCARAMANGA 08 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24031', '(STD) BUCARAMANGA 09 JUZGADO CIVIL CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24032', '(STD) BUCARAMANGA 09 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24033', '(STD) BUCARAMANGA 10 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24034', '(STD) BUCARAMANGA 11 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24035', '(STD) BUCARAMANGA 12 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24036', '(STD) CABRERA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24037', '(STD) CHARALA 01 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24038', '(STD) CHARALA 01 JUZGADO PROMISCUO CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24039', '(STD) CHARALA 02 JUZGADO PROMISCUO CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24040', '(STD) CHIMA 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24041', '(STD) CHIPATA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24042', '(STD) CIMITARRA 01 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24043', '(STD) CONFINES 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24044', '(STD) CONTRATACION 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24045', '(STD) COROMORO 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24046', '(STD) CURITI 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24047', '(STD) EL GUACAMAYO 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24048', '(STD) ENCINO 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24049', '(STD) FLORIAN 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24050', '(STD) GALAN 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24051', '(STD) GAMBITA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24052', '(STD) GUADALUPE 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24053', '(STD) GUAPOTA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24054', '(STD) GUAVATA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24055', '(STD) GUEPSA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24056', '(STD) HATO 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24057', '(STD) JESUS MARIA 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24058', '(STD) JORDAN 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24059', '(STD) LA BELLEZA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24060', '(STD) LA PAZ 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24061', '(STD) LANDAZURI 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24062', '(STD) MALAGA 01 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24063', '(STD) MALAGA 01 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24064', '(STD) MOGOTES 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24065', '(STD) OCAMONTE 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24066', '(STD) OIBA 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24067', '(STD) ONZAGA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24068', '(STD) PALMAR 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24069', '(STD) PALMAS DEL SOCORRO 01 JUZGADO MUNICIPAL PROMISCUO          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24070', '(STD) PARAMO 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24071', '(STD) PINCHOTE 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24072', '(STD) PUENTE NACIONAL 01 JUZGADO CIVIL CIRCUITO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24073', '(STD) PUENTE NACIONAL 01 JUZGADO CIVIL MUNICIPAL                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24074', '(STD) SAN BENITO 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24075', '(STD) SAN GIL 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24076', '(STD) SAN GIL 01 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24077', '(STD) SAN GIL 02 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24078', '(STD) SAN GIL 02 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24079', '(STD) SAN JOAQUIN 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24080', '(STD) SAN VICENTE DE CHUCURI 01 JUZGADO CIVIL MUNICIPAL          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24081', '(STD) SANTA HELENA DEL OPON 01 JUZGADO MUNICIPAL PROMISCUO       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24082', '(STD) SIMACOTA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24083', '(STD) SOCORRO 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24084', '(STD) SOCORRO 02 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24085', '(STD) SUCRE 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24086', '(STD) VALLE DE SAN JOSE 01 JUZGADO MUNICIPAL PROMISCUO           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24087', '(STD) VELEZ 01 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24088', '(STD) VELEZ 02 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24089', '(STD) VILLANUEVA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25001', '(SUC) CAIMITO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25002', '(SUC) COROZAL 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25003', '(SUC) COROZAL 01 JUZGADO PROMISCUO CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25004', '(SUC) COROZAL 02 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25005', '(SUC) COROZAL 02 JUZGADO PROMISCUO CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25006', '(SUC) GALERAS 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25007', '(SUC) GUARANDA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25008', '(SUC) LA UNION 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25009', '(SUC) LOS PALMITOS 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25010', '(SUC) MAJAGUAL 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25011', '(SUC) OVEJAS 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25012', '(SUC) PALMITO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25013', '(SUC) SAMPUES 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25014', '(SUC) SAN BENITO ABAD 01 JUZGADO MUNICIPAL PROMISCUO             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25015', '(SUC) SAN JUAN DE BETULIA 01 JUZGADO MUNICIPAL PROMISCUO         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25016', '(SUC) SAN MARCOS 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25017', '(SUC) SAN MARCOS 01 JUZGADO PROMISCUO CIRCUITO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25018', '(SUC) SAN ONOFRE 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25019', '(SUC) SAN PEDRO 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25020', '(SUC) SINCE 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25021', '(SUC) SINCE 01 JUZGADO PROMISCUO CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25022', '(SUC) SINCELEJO 01 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25023', '(SUC) SINCELEJO 01 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25024', '(SUC) SINCELEJO 02 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25025', '(SUC) SINCELEJO 02 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25026', '(SUC) SINCELEJO 03 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25027', '(SUC) SINCELEJO 03 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25028', '(SUC) SINCELEJO 04 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25029', '(SUC) SINCELEJO 05 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25030', '(SUC) SINCELEJO 06 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25031', '(SUC) SUCRE 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25032', '(SUC) SUCRE 01 JUZGADO PROMISCUO CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25033', '(SUC) TOLU 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25034', '(SUC) TOLU 02 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25035', '(SUC) TOLUVIEJO 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26001', '(TOL) ALPUJARRA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26002', '(TOL) ALVARADO 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26003', '(TOL) AMBALEMA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26004', '(TOL) ANZOATEGUI 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26005', '(TOL) ARMERO 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26006', '(TOL) ARMERO 02 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26007', '(TOL) ATACO 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26008', '(TOL) ATACO 02 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26009', '(TOL) CAJAMARCA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26010', '(TOL) CAJAMARCA 02 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26011', '(TOL) CASABIANCA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26012', '(TOL) CHAPARRAL 01 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26013', '(TOL) CHAPARRAL 01 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26014', '(TOL) CHAPARRAL 02 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26015', '(TOL) CHAPARRAL 02 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26016', '(TOL) COELLO 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26017', '(TOL) COYAIMA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26018', '(TOL) COYAIMA 02 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26019', '(TOL) CUNDAY 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26020', '(TOL) CUNDAY 02 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26021', '(TOL) DOLORES 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26022', '(TOL) ESPINAL 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26023', '(TOL) ESPINAL 01 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26024', '(TOL) ESPINAL 02 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26025', '(TOL) ESPINAL 02 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26026', '(TOL) ESPINAL 03 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26027', '(TOL) ESPINAL 04 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26028', '(TOL) FALAN 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26029', '(TOL) FLANDES 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26030', '(TOL) FLANDES 02 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26031', '(TOL) FRESNO 01 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26032', '(TOL) FRESNO 01 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26033', '(TOL) FRESNO 02 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26034', '(TOL) GUAMO 01 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26035', '(TOL) GUAMO 01 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26036', '(TOL) GUAMO 02 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26037', '(TOL) GUAMO 02 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26038', '(TOL) HERVEO 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26039', '(TOL) HONDA 01 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26040', '(TOL) HONDA 01 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26041', '(TOL) HONDA 02 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26042', '(TOL) HONDA 02 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26043', '(TOL) IBAGUE 01 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26044', '(TOL) IBAGUE 01 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26045', '(TOL) IBAGUE 02 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26046', '(TOL) IBAGUE 02 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26047', '(TOL) IBAGUE 03 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26048', '(TOL) IBAGUE 03 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26049', '(TOL) IBAGUE 04 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26050', '(TOL) IBAGUE 04 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26051', '(TOL) IBAGUE 05 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26052', '(TOL) IBAGUE 05 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26053', '(TOL) IBAGUE 06 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26054', '(TOL) IBAGUE 06 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26055', '(TOL) IBAGUE 07 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26056', '(TOL) IBAGUE 08 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26057', '(TOL) IBAGUE 09 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26058', '(TOL) IBAGUE 10 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26059', '(TOL) IBAGUE 11 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26060', '(TOL) IBAGUE 12 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26061', '(TOL) IBAGUE 13 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26062', '(TOL) ICONONZO 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26063', '(TOL) LERIDA 01 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26064', '(TOL) LERIDA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26065', '(TOL) LERIDA 02 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26066', '(TOL) LIBANO 01 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26067', '(TOL) LIBANO 01 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26068', '(TOL) LIBANO 02 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26069', '(TOL) MARIQUITA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26070', '(TOL) MARIQUITA 02 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26071', '(TOL) MELGAR 01 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26072', '(TOL) MELGAR 01 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26073', '(TOL) MELGAR 02 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26074', '(TOL) MURILLO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26075', '(TOL) NATAGAIMA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26076', '(TOL) NATAGAIMA 02 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26077', '(TOL) ORTEGA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26078', '(TOL) ORTEGA 02 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26079', '(TOL) PLANADAS 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26080', '(TOL) PRADO 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26081', '(TOL) PURIFICACION 01 JUZGADO CIVIL CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26082', '(TOL) PURIFICACION 01 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26083', '(TOL) PURIFICACION 02 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26084', '(TOL) RIOBLANCO 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26085', '(TOL) RONCESVALLES 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26086', '(TOL) ROVIRA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26087', '(TOL) ROVIRA 02 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26088', '(TOL) SALDA�A 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26089', '(TOL) SALDA�A 02 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26090', '(TOL) SAN ANTONIO 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26091', '(TOL) SAN LUIS 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26092', '(TOL) SANTA ISABEL 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26093', '(TOL) SUAREZ 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26094', '(TOL) VALLE DE SAN JUAN 01 JUZGADO MUNICIPAL PROMISCUO           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26095', '(TOL) VENADILLO 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26096', '(TOL) VENADILLO 02 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26097', '(TOL) VILLAHERMOSA 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26098', '(TOL) VILLARRICA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27001', '(VALLE) ALCALA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27002', '(VALLE) ANDALUCIA 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27003', '(VALLE) ANSERMANUEVO 01 JUZGADO MUNICIPAL PROMISCUO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27004', '(VALLE) ARGELIA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27005', '(VALLE) BOLIVAR 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27006', '(VALLE) BUENAVENTURA 01 JUZGADO CIVIL CIRCUITO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27007', '(VALLE) BUENAVENTURA 01 JUZGADO CIVIL MUNICIPAL                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27008', '(VALLE) BUENAVENTURA 02 JUZGADO CIVIL CIRCUITO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27009', '(VALLE) BUENAVENTURA 02 JUZGADO CIVIL MUNICIPAL                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27010', '(VALLE) BUENAVENTURA 03 JUZGADO CIVIL CIRCUITO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27011', '(VALLE) BUENAVENTURA 03 JUZGADO CIVIL MUNICIPAL                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27012', '(VALLE) BUENAVENTURA 04 JUZGADO CIVIL MUNICIPAL                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27013', '(VALLE) BUENAVENTURA 05 JUZGADO CIVIL MUNICIPAL                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27014', '(VALLE) BUENAVENTURA 06 JUZGADO CIVIL MUNICIPAL                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27015', '(VALLE) BUENAVENTURA 07 JUZGADO CIVIL MUNICIPAL                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27016', '(VALLE) BUENAVENTURA 08 JUZGADO CIVIL MUNICIPAL                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27017', '(VALLE) BUGA 01 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27018', '(VALLE) BUGA 01 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27019', '(VALLE) BUGA 02 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27020', '(VALLE) BUGA 02 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27021', '(VALLE) BUGA 03 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27022', '(VALLE) BUGA 03 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27023', '(VALLE) BUGALAGRANDE 01 JUZGADO MUNICIPAL PROMISCUO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27024', '(VALLE) CAICEDONIA 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27025', '(VALLE) CAICEDONIA 02 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27026', '(VALLE) CALI 01 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27027', '(VALLE) CALI 01 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27028', '(VALLE) CALI 02 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27029', '(VALLE) CALI 02 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27030', '(VALLE) CALI 03 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27031', '(VALLE) CALI 03 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27032', '(VALLE) CALI 04 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27033', '(VALLE) CALI 04 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27034', '(VALLE) CALI 05 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27035', '(VALLE) CALI 05 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27036', '(VALLE) CALI 06 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27037', '(VALLE) CALI 06 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27038', '(VALLE) CALI 07 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27039', '(VALLE) CALI 07 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27040', '(VALLE) CALI 08 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27041', '(VALLE) CALI 08 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27042', '(VALLE) CALI 09 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27043', '(VALLE) CALI 09 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27044', '(VALLE) CALI 10 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27045', '(VALLE) CALI 10 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27046', '(VALLE) CALI 11 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27047', '(VALLE) CALI 11 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27048', '(VALLE) CALI 12 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27049', '(VALLE) CALI 12 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27050', '(VALLE) CALI 13 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27051', '(VALLE) CALI 13 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27052', '(VALLE) CALI 14 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27053', '(VALLE) CALI 14 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27054', '(VALLE) CALI 15 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27055', '(VALLE) CALI 15 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27056', '(VALLE) CALI 16 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27057', '(VALLE) CALI 17 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27058', '(VALLE) CALI 18 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27059', '(VALLE) CALI 19 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27060', '(VALLE) CALI 20 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27061', '(VALLE) CALI 21 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27062', '(VALLE) CALI 22 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27063', '(VALLE) CALI 23 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27064', '(VALLE) CALI 24 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27065', '(VALLE) CALI 25 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27066', '(VALLE) CALI 26 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27067', '(VALLE) CALI 27 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27068', '(VALLE) CALI 28 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27069', '(VALLE) CALI 29 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27070', '(VALLE) CALI 30 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27071', '(VALLE) CALI 31 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27072', '(VALLE) CALI 32 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27073', '(VALLE) CALI 33 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27074', '(VALLE) CALI 34 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27075', '(VALLE) CALI 35 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27076', '(VALLE) CALIMA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27077', '(VALLE) CANDELARIA 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27078', '(VALLE) CANDELARIA 02 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27079', '(VALLE) CARTAGO 01 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27080', '(VALLE) CARTAGO 01 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27081', '(VALLE) CARTAGO 02 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27082', '(VALLE) CARTAGO 02 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27083', '(VALLE) CARTAGO 03 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27084', '(VALLE) CARTAGO 04 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27085', '(VALLE) DAGUA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27086', '(VALLE) EL AGUILA 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27087', '(VALLE) EL CAIRO 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27088', '(VALLE) EL CERRITO 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27089', '(VALLE) EL CERRITO 02 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27090', '(VALLE) EL DOVIO 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27091', '(VALLE) FLORIDA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27092', '(VALLE) FLORIDA 02 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27093', '(VALLE) GINEBRA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27094', '(VALLE) GUACARI 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27095', '(VALLE) JAMUNDI 01 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27096', '(VALLE) JAMUNDI 02 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27097', '(VALLE) LA CUMBRE 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27098', '(VALLE) LA UNION 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27099', '(VALLE) LA VICTORIA 01 JUZGADO MUNICIPAL PROMISCUO               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27100', '(VALLE) OBANDO 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27101', '(VALLE) PALMIRA 01 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27102', '(VALLE) PALMIRA 01 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27103', '(VALLE) PALMIRA 02 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27104', '(VALLE) PALMIRA 02 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27105', '(VALLE) PALMIRA 03 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27106', '(VALLE) PALMIRA 04 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27107', '(VALLE) PALMIRA 05 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27108', '(VALLE) PALMIRA 06 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27109', '(VALLE) PALMIRA 07 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27110', '(VALLE) PALMIRA 08 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27111', '(VALLE) PRADERA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27112', '(VALLE) PRADERA 02 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27113', '(VALLE) RESTREPO 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27114', '(VALLE) RIOFRIO 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27115', '(VALLE) ROLDANILLO 01 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27116', '(VALLE) ROLDANILLO 02 JUZGADO CIVIL MUNICIPAL                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27117', '(VALLE) SAN PEDRO 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27118', '(VALLE) SEVILLA 01 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27119', '(VALLE) SEVILLA 02 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27120', '(VALLE) TORO 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27121', '(VALLE) TRUJILLO 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27122', '(VALLE) TULUA 01 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27123', '(VALLE) TULUA 02 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27124', '(VALLE) TULUA 03 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27125', '(VALLE) TULUA 04 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27126', '(VALLE) TULUA 05 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27127', '(VALLE) TULUA 06 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27128', '(VALLE) ULLOA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27129', '(VALLE) VERSALLES 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27130', '(VALLE) VIJES 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27131', '(VALLE) YOTOCO 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27132', '(VALLE) YUMBO 01 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27133', '(VALLE) YUMBO 02 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27134', '(VALLE) ZARZAL 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27135', '(VALLE) ZARZAL 02 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '28001', '(VICH) CUMARIBO 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '28002', '(VICH) PUERTO CARRE�O 01 JUZGADO MUNICIPAL PROMISCUO             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3001', '(BOL) ACHI 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3002', '(BOL) ARJONA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3003', '(BOL) BARRANCO DE LOBA 01 JUZGADO MUNICIPAL PROMISCUO            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3004', '(BOL) CALAMAR 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3005', '(BOL) CARTAGENA DE INDIAS 01 JUZGADO CIVIL CIRCUITO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3006', '(BOL) CARTAGENA DE INDIAS 01 JUZGADO CIVIL MUNICIPAL             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3007', '(BOL) CARTAGENA DE INDIAS 02 JUZGADO CIVIL CIRCUITO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3008', '(BOL) CARTAGENA DE INDIAS 02 JUZGADO CIVIL MUNICIPAL             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3009', '(BOL) CARTAGENA DE INDIAS 03 JUZGADO CIVIL CIRCUITO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3010', '(BOL) CARTAGENA DE INDIAS 03 JUZGADO CIVIL MUNICIPAL             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3011', '(BOL) CARTAGENA DE INDIAS 04 JUZGADO CIVIL CIRCUITO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3012', '(BOL) CARTAGENA DE INDIAS 04 JUZGADO CIVIL MUNICIPAL             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3013', '(BOL) CARTAGENA DE INDIAS 05 JUZGADO CIVIL CIRCUITO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3014', '(BOL) CARTAGENA DE INDIAS 05 JUZGADO CIVIL MUNICIPAL             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3015', '(BOL) CARTAGENA DE INDIAS 06 JUZGADO CIVIL CIRCUITO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3016', '(BOL) CARTAGENA DE INDIAS 06 JUZGADO CIVIL MUNICIPAL             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3017', '(BOL) CARTAGENA DE INDIAS 07 JUZGADO CIVIL CIRCUITO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3018', '(BOL) CARTAGENA DE INDIAS 07 JUZGADO CIVIL MUNICIPAL             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3019', '(BOL) CARTAGENA DE INDIAS 08 JUZGADO CIVIL CIRCUITO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3020', '(BOL) CARTAGENA DE INDIAS 08 JUZGADO CIVIL MUNICIPAL             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3021', '(BOL) CARTAGENA DE INDIAS 09 JUZGADO CIVIL MUNICIPAL             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3022', '(BOL) CARTAGENA DE INDIAS 10 JUZGADO CIVIL MUNICIPAL             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3023', '(BOL) CARTAGENA DE INDIAS 11 JUZGADO CIVIL MUNICIPAL             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3024', '(BOL) CARTAGENA DE INDIAS 12 JUZGADO CIVIL MUNICIPAL             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3025', '(BOL) CARTAGENA DE INDIAS 13 JUZGADO CIVIL MUNICIPAL             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3026', '(BOL) CORDOBA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3027', '(BOL) EL CARMEN DE BOLIVAR 01 JUZGADO MUNICIPAL PROMISCUO        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3028', '(BOL) EL CARMEN DE BOLIVAR 01 JUZGADO PROMISCUO CIRCUITO         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3029', '(BOL) EL CARMEN DE BOLIVAR 02 JUZGADO MUNICIPAL PROMISCUO        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3030', '(BOL) EL GUAMO 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3031', '(BOL) MAGANGUE 01 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3032', '(BOL) MAGANGUE 01 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3033', '(BOL) MAGANGUE 02 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3034', '(BOL) MAGANGUE 02 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3035', '(BOL) MAHATES 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3036', '(BOL) MARGARITA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3037', '(BOL) MARIA LA BAJA 01 JUZGADO MUNICIPAL PROMISCUO               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3038', '(BOL) MOMPOS 01 JUZGADO CIVIL CIRCUITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3039', '(BOL) MOMPOS 01 JUZGADO CIVIL MUNICIPAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3040', '(BOL) MORALES 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3041', '(BOL) PINILLOS 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3042', '(BOL) RIOVIEJO 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3043', '(BOL) SAN ESTANISLAO 01 JUZGADO MUNICIPAL PROMISCUO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3044', '(BOL) SAN FERNANDO 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3045', '(BOL) SAN JACINTO 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3046', '(BOL) SAN JUAN NEPOMUCENO 01 JUZGADO MUNICIPAL PROMISCUO         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3047', '(BOL) SAN MARTIN DE LOBA 01 JUZGADO MUNICIPAL PROMISCUO          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3048', '(BOL) SAN PABLO 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3049', '(BOL) SANTA CATALINA 01 JUZGADO MUNICIPAL PROMISCUO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3050', '(BOL) SANTA ROSA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3051', '(BOL) SANTA ROSA DEL SUR 01 JUZGADO MUNICIPAL PROMISCUO          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3052', '(BOL) SIMITI 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3053', '(BOL) SIMITI 01 JUZGADO PROMISCUO CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3054', '(BOL) SOPLAVIENTO 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3055', '(BOL) TALAIGUA NUEVO 01 JUZGADO MUNICIPAL PROMISCUO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3056', '(BOL) TURBACO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3057', '(BOL) TURBACO 01 JUZGADO PROMISCUO CIRCUITO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3058', '(BOL) TURBANA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3059', '(BOL) VILLANUEVA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3060', '(BOL) ZAMBRANO 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4001', '(BOY) ALMEIDA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4002', '(BOY) ARCABUCO 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4003', '(BOY) BELEN 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4004', '(BOY) BETEITIVA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4005', '(BOY) BOAVITA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4006', '(BOY) BOYACA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4007', '(BOY) BRICE�O 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4008', '(BOY) BUENAVISTA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4009', '(BOY) CALDAS 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4010', '(BOY) CAMPOHERMOSO 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4011', '(BOY) CERINZA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4012', '(BOY) CHINAVITA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4013', '(BOY) CHIQUINQUIRA 01 JUZGADO CIVIL CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4014', '(BOY) CHIQUINQUIRA 02 JUZGADO CIVIL CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4015', '(BOY) CHIQUIZA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4016', '(BOY) CHISCAS 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4017', '(BOY) CHITA 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4018', '(BOY) CHITARAQUE 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4019', '(BOY) CHIVATA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4020', '(BOY) CHIVOR 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4021', '(BOY) CIENEGA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4022', '(BOY) COMBITA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4023', '(BOY) COPER 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4024', '(BOY) CORRALES 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4025', '(BOY) COVARACHIA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4026', '(BOY) CUCAITA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4027', '(BOY) CUITIVA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4028', '(BOY) DUITAMA 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4029', '(BOY) DUITAMA 01 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4030', '(BOY) DUITAMA 02 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4031', '(BOY) DUITAMA 02 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4032', '(BOY) DUITAMA 03 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4033', '(BOY) DUITAMA 03 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4034', '(BOY) DUITAMA 04 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4035', '(BOY) EL COCUY 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4036', '(BOY) EL COCUY 01 JUZGADO PROMISCUO CIRCUITO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4037', '(BOY) EL ESPINO 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4038', '(BOY) FIRAVITOBA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4039', '(BOY) FLORESTA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4040', '(BOY) GACHANTIVA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4041', '(BOY) GAMEZA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4042', '(BOY) GARAGOA 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4043', '(BOY) GUACAMAYAS 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4044', '(BOY) GUATEQUE 01 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4045', '(BOY) GUAYATA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4046', '(BOY) GUICAN 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4047', '(BOY) IZA 01 JUZGADO MUNICIPAL PROMISCUO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4048', '(BOY) JENESANO 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4049', '(BOY) JERICO 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4050', '(BOY) LA UVITA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4051', '(BOY) LABRANZAGRANDE 01 JUZGADO MUNICIPAL PROMISCUO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4052', '(BOY) MACANAL 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4053', '(BOY) MARIPI 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4054', '(BOY) MIRAFLORES 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4055', '(BOY) MIRAFLORES 01 JUZGADO PROMISCUO CIRCUITO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4056', '(BOY) MONGUA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4057', '(BOY) MONGUI 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4058', '(BOY) MONIQUIRA 01 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4059', '(BOY) MOTAVITA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4060', '(BOY) MUZO 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4061', '(BOY) NOBSA 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4062', '(BOY) NOBSA 02 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4063', '(BOY) NUEVO COLON 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4064', '(BOY) OTANCHE 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4065', '(BOY) PACHAVITA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4066', '(BOY) PAEZ 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4067', '(BOY) PAIPA 01 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4068', '(BOY) PAJARITO 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4069', '(BOY) PANQUEBA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4070', '(BOY) PAUNA 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4071', '(BOY) PAYA 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4072', '(BOY) PAZ DE RIO 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4073', '(BOY) PAZ DE RIO 01 JUZGADO PROMISCUO CIRCUITO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4074', '(BOY) PESCA 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4075', '(BOY) PUERTO BOYACA 01 JUZGADO CIVIL MUNICIPAL                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4076', '(BOY) PUERTO BOYACA 01 JUZGADO CIVIL MUNICIPAL                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4077', '(BOY) PUERTO BOYACA 01 JUZGADO PROMISCUO CIRCUITO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4078', '(BOY) PUERTO BOYACA 02 JUZGADO CIVIL MUNICIPAL                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4079', '(BOY) PUERTO BOYACA 02 JUZGADO CIVIL MUNICIPAL                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4080', '(BOY) QUIPAMA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4081', '(BOY) RAMIRIQUI 01 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4082', '(BOY) RAMIRIQUI 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4083', '(BOY) RAMIRIQUI 02 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4084', '(BOY) RAQUIRA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4085', '(BOY) RONDON 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4086', '(BOY) SABOYA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4087', '(BOY) SACHICA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4088', '(BOY) SAMACA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4089', '(BOY) SAN EDUARDO 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4090', '(BOY) SAN JOSE DE PARE 01 JUZGADO MUNICIPAL PROMISCUO            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4091', '(BOY) SAN LUIS DE GACENO 01 JUZGADO MUNICIPAL PROMISCUO          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4092', '(BOY) SAN MATEO 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4093', '(BOY) SAN MIGUEL DE SEMA 01 JUZGADO MUNICIPAL PROMISCUO          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4094', '(BOY) SAN PABLO DE BORBUR 01 JUZGADO MUNICIPAL PROMISCUO         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4095', '(BOY) SANTA MARIA 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4096', '(BOY) SANTA ROSA DE VITERBO 01 JUZGADO MUNICIPAL PROMISCUO       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4097', '(BOY) SANTA ROSA DE VITERBO 01 JUZGADO PROMISCUO CIRCUITO        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4098', '(BOY) SANTA SOFIA 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4099', '(BOY) SANTANA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4100', '(BOY) SATIVANORTE 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4101', '(BOY) SATIVASUR 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4102', '(BOY) SIACHOQUE 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4103', '(BOY) SOATA 01 JUZGADO PROMISCUO CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4104', '(BOY) SOCHA 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4105', '(BOY) SOCHA 01 JUZGADO PROMISCUO CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4106', '(BOY) SOCOTA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4107', '(BOY) SOGAMOSO 01 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4108', '(BOY) SOGAMOSO 01 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4109', '(BOY) SOGAMOSO 02 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4110', '(BOY) SOGAMOSO 02 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4111', '(BOY) SOGAMOSO 03 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4112', '(BOY) SOGAMOSO 03 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4113', '(BOY) SOGAMOSO 04 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4114', '(BOY) SOMONDOCO 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4115', '(BOY) SORA 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4116', '(BOY) SORACA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4117', '(BOY) SOTAQUIRA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4118', '(BOY) SUSACON 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4119', '(BOY) SUTAMARCHAN 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4120', '(BOY) SUTATENZA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4121', '(BOY) TASCO 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4122', '(BOY) TENZA 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4123', '(BOY) TIBANA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4124', '(BOY) TIBASOSA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4125', '(BOY) TINJACA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4126', '(BOY) TIPACOQUE 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4127', '(BOY) TOCA 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4128', '(BOY) TOGUI 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4129', '(BOY) TOPAGA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4130', '(BOY) TOTA 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4131', '(BOY) TUNJA 01 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4132', '(BOY) TUNJA 01 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4133', '(BOY) TUNJA 02 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4134', '(BOY) TUNJA 02 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4135', '(BOY) TUNJA 03 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4136', '(BOY) TUNJA 03 JUZGADO CIVIL MUNICIPAL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4137', '(BOY) TUNJA 04 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4138', '(BOY) TURMEQUE 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4139', '(BOY) TUTA 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4140', '(BOY) TUTAZA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4141', '(BOY) UMBITA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4142', '(BOY) VENTAQUEMADA 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4143', '(BOY) VILLA DE LEIVA 01 JUZGADO MUNICIPAL PROMISCUO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4144', '(BOY) VIRACACHA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4145', '(BOY) ZETAQUIRA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5001', '(CAL) AGUADAS 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5002', '(CAL) AGUADAS 01 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5003', '(CAL) ANSERMA 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5004', '(CAL) ANSERMA 01 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5005', '(CAL) ANSERMA 02 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5006', '(CAL) ARANZAZU 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5007', '(CAL) ARANZAZU 02 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5008', '(CAL) BELALCAZAR 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5009', '(CAL) CHINCHINA 01 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5010', '(CAL) CHINCHINA 01 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5011', '(CAL) CHINCHINA 02 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5012', '(CAL) CHINCHINA 03 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5013', '(CAL) FILADELFIA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5014', '(CAL) LA DORADA 01 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5015', '(CAL) LA DORADA 01 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5016', '(CAL) LA DORADA 02 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5017', '(CAL) LA DORADA 02 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5018', '(CAL) LA DORADA 03 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5019', '(CAL) LA MERCED 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5020', '(CAL) MANIZALES 01 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5021', '(CAL) MANIZALES 01 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5022', '(CAL) MANIZALES 02 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5023', '(CAL) MANIZALES 02 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5024', '(CAL) MANIZALES 03 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5025', '(CAL) MANIZALES 03 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5026', '(CAL) MANIZALES 04 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5027', '(CAL) MANIZALES 04 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5028', '(CAL) MANIZALES 05 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5029', '(CAL) MANIZALES 05 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5030', '(CAL) MANIZALES 06 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5031', '(CAL) MANIZALES 06 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5032', '(CAL) MANIZALES 07 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5033', '(CAL) MANIZALES 08 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5034', '(CAL) MANIZALES 09 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5035', '(CAL) MANIZALES 10 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5036', '(CAL) MANIZALES 11 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5037', '(CAL) MANZANARES 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5038', '(CAL) MANZANARES 01 JUZGADO PROMISCUO CIRCUITO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5039', '(CAL) MARMATO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5040', '(CAL) MARQUETALIA 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5041', '(CAL) MARULANDA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5042', '(CAL) NEIRA 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5043', '(CAL) NEIRA 02 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5044', '(CAL) PACORA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5045', '(CAL) PACORA 02 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5046', '(CAL) PALESTINA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5047', '(CAL) PALESTINA 02 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5048', '(CAL) PENSILVANIA 01 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5049', '(CAL) PENSILVANIA 01 JUZGADO PROMISCUO CIRCUITO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5050', '(CAL) RIOSUCIO 01 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5051', '(CAL) RIOSUCIO 01 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5052', '(CAL) RIOSUCIO 02 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5053', '(CAL) RISARALDA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5054', '(CAL) SALAMINA 01 JUZGADO CIVIL CIRCUITO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5055', '(CAL) SALAMINA 01 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5056', '(CAL) SALAMINA 02 JUZGADO CIVIL MUNICIPAL                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5057', '(CAL) SAMANA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5058', '(CAL) SUPIA 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5059', '(CAL) SUPIA 02 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5060', '(CAL) VICTORIA 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5061', '(CAL) VITERBO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6001', '(CAQ) ALBANIA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6002', '(CAQ) BELEN DE LOS ANDAQUIES 01 JUZGADO MUNICIPAL PROMISCUO      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6003', '(CAQ) BELEN DE LOS ANDAQUIES 01 JUZGADO PROMISCUO CIRCUITO       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6004', '(CAQ) CARTAGENA DEL CHAIRA 01 JUZGADO MUNICIPAL PROMISCUO        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6005', '(CAQ) CURILLO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6006', '(CAQ) EL DONCELLO 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6007', '(CAQ) EL DONCELLO 02 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6008', '(CAQ) EL PAUJIL 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6009', '(CAQ) FLORENCIA 01 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6010', '(CAQ) FLORENCIA 01 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6011', '(CAQ) FLORENCIA 02 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6012', '(CAQ) FLORENCIA 02 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6013', '(CAQ) FLORENCIA 03 JUZGADO CIVIL CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6014', '(CAQ) FLORENCIA 03 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6015', '(CAQ) FLORENCIA 04 JUZGADO CIVIL MUNICIPAL                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6016', '(CAQ) MILAN 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6017', '(CAQ) MONTA�ITA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6018', '(CAQ) MORELIA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6019', '(CAQ) PUERTO RICO 01 JUZGADO CIVIL MUNICIPAL                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6020', '(CAQ) PUERTO RICO 01 JUZGADO PROMISCUO CIRCUITO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6021', '(CAQ) SAN JOSE DEL FRAGUA 01 JUZGADO MUNICIPAL PROMISCUO         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6022', '(CAQ) SAN VICENTE DEL CAGUAN 01 JUZGADO MUNICIPAL PROMISCUO      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6023', '(CAQ) SAN VICENTE DEL CAGUAN 02 JUZGADO MUNICIPAL PROMISCUO      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6024', '(CAQ) VALPARAISO 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7001', '(CAS) AGUAZUL 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7002', '(CAS) CHAMEZA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7003', '(CAS) HATO COROZAL 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7004', '(CAS) LA SALINA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7005', '(CAS) MANI 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7006', '(CAS) MONTERREY 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7007', '(CAS) MONTERREY 01 JUZGADO PROMISCUO CIRCUITO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7008', '(CAS) NUNCHIA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7009', '(CAS) OROCUE 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7010', '(CAS) OROCUE 01 JUZGADO PROMISCUO CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7011', '(CAS) PAZ DE ARIPORO 01 JUZGADO MUNICIPAL PROMISCUO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7012', '(CAS) PAZ DE ARIPORO 01 JUZGADO PROMISCUO CIRCUITO               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7013', '(CAS) PORE 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7014', '(CAS) RECETOR 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7015', '(CAS) SABANALARGA 01 JUZGADO MUNICIPAL PROMISCUO                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7016', '(CAS) SACAMA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7017', '(CAS) SAN LUIS DE PALENQUE 01 JUZGADO MUNICIPAL PROMISCUO        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7018', '(CAS) TAMARA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7019', '(CAS) TAURAMENA 01 JUZGADO MUNICIPAL PROMISCUO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7020', '(CAS) TRINIDAD 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7021', '(CAS) VILLANUEVA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7022', '(CAS) YOPAL 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7023', '(CAS) YOPAL 01 JUZGADO PROMISCUO CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7024', '(CAS) YOPAL 02 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8001', '(CAU) ALMAGUER 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8002', '(CAU) ARGELIA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8003', '(CAU) BALBOA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8004', '(CAU) BOLIVAR 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8005', '(CAU) BOLIVAR 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8006', '(CAU) BUENOS AIRES 01 JUZGADO MUNICIPAL PROMISCUO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8007', '(CAU) CAJIBIO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8008', '(CAU) CAJIBIO 02 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8009', '(CAU) CALDONO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8010', '(CAU) CALOTO 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8011', '(CAU) CALOTO 01 JUZGADO PROMISCUO CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8012', '(CAU) CORINTO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8013', '(CAU) CORINTO 02 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8014', '(CAU) EL TAMBO 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8015', '(CAU) EL TAMBO 02 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8016', '(CAU) GUAPI 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8017', '(CAU) GUAPI 01 JUZGADO PROMISCUO CIRCUITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8018', '(CAU) INZA 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8019', '(CAU) JAMBALO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8020', '(CAU) LA VEGA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8021', '(CAU) LOPEZ 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8022', '(CAU) MERCADERES 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8023', '(CAU) MERCADERES 02 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8024', '(CAU) MIRANDA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8025', '(CAU) MIRANDA 02 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8026', '(CAU) MORALES 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8027', '(CAU) PADILLA 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8028', '(CAU) PAEZ 01 JUZGADO MUNICIPAL PROMISCUO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8029', '(CAU) PATIA 01 JUZGADO CIVIL CIRCUITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8030', '(CAU) PATIA 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8031', '(CAU) PATIA 02 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8032', '(CAU) PIENDAMO 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8033', '(CAU) PIENDAMO 02 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8034', '(CAU) POPAYAN 01 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8035', '(CAU) POPAYAN 01 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8036', '(CAU) POPAYAN 02 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8037', '(CAU) POPAYAN 02 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8038', '(CAU) POPAYAN 03 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8039', '(CAU) POPAYAN 03 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8040', '(CAU) POPAYAN 04 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8041', '(CAU) POPAYAN 04 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8042', '(CAU) POPAYAN 05 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8043', '(CAU) POPAYAN 05 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8044', '(CAU) POPAYAN 06 JUZGADO CIVIL CIRCUITO                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8045', '(CAU) POPAYAN 06 JUZGADO CIVIL MUNICIPAL                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8046', '(CAU) PUERTO TEJADA 01 JUZGADO CIVIL CIRCUITO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8047', '(CAU) PUERTO TEJADA 01 JUZGADO CIVIL MUNICIPAL                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8048', '(CAU) PUERTO TEJADA 02 JUZGADO CIVIL MUNICIPAL                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8049', '(CAU) PURACE 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8050', '(CAU) ROSAS 01 JUZGADO MUNICIPAL PROMISCUO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8051', '(CAU) SAN SEBASTIAN 01 JUZGADO MUNICIPAL PROMISCUO               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8052', '(CAU) SANTA ROSA 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8053', '(CAU) SANTANDER DE QUILICHAO 01 JUZGADO CIVIL CIRCUITO           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8054', '(CAU) SANTANDER DE QUILICHAO 01 JUZGADO CIVIL MUNICIPAL          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8055', '(CAU) SANTANDER DE QUILICHAO 02 JUZGADO CIVIL CIRCUITO           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8056', '(CAU) SANTANDER DE QUILICHAO 02 JUZGADO CIVIL MUNICIPAL          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8057', '(CAU) SILVIA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8058', '(CAU) SILVIA 01 JUZGADO PROMISCUO CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8059', '(CAU) SILVIA 02 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8060', '(CAU) SOTARA 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8061', '(CAU) SUAREZ 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8062', '(CAU) TIMBIO 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8063', '(CAU) TIMBIO 02 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8064', '(CAU) TIMBIQUI 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8065', '(CAU) TORIBIO 01 JUZGADO MUNICIPAL PROMISCUO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8066', '(CAU) TOTORO 01 JUZGADO MUNICIPAL PROMISCUO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9001', '(CES) CHIRIGUANA 01 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9002', '(CES) GONZALEZ 01 JUZGADO MUNICIPAL PROMISCUO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9003', '(CES) RIO DE ORO 01 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9004', '(CES) RIO DE ORO 02 JUZGADO MUNICIPAL PROMISCUO                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9005', '(CES) VALLEDUPAR 01 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9006', '(CES) VALLEDUPAR 01 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9007', '(CES) VALLEDUPAR 02 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9008', '(CES) VALLEDUPAR 02 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9009', '(CES) VALLEDUPAR 03 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9010', '(CES) VALLEDUPAR 03 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9011', '(CES) VALLEDUPAR 04 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9012', '(CES) VALLEDUPAR 04 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9013', '(CES) VALLEDUPAR 05 JUZGADO CIVIL CIRCUITO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9014', '(CES) VALLEDUPAR 05 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9015', '(CES) VALLEDUPAR 06 JUZGADO CIVIL MUNICIPAL                      ', 'V') 
go

       
declare @w_tabla smallint

select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'ah_est_ahpro', ' Estados de un Ahorro Programado                                  ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', ' UND FISCALIA DE CONTROL ADUANERO M\LLIN (050015092010)           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'EC', ' ENTREGADO CONSTRUCTOR                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'MI', ' MIGRADO                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NO', ' COMPROMISO INCUMPLIDO                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'OK', ' CUMPLE COMPROMISO                                                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PO', ' POSTULADO                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'RE', ' REPROGRAMADO                                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'TR', ' TRASLADADO                                                       ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_aprob_garantia', ' APROBACION DE GARANTIAS                                          ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '01', ' CON GARANTIA                                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '02', ' SIN GARANTIA                                                     ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_calificacion', ' CALIFICACION DE RIESGOS DE CLIENTES                              ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'A', ' RIESGO NORMAL                                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'B', ' RIESGO ACEPTABLE                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'C', ' RIESGO APRECIABLE                                                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'D', ' RIESGO SIGNIFICATIVO                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'E', ' RIESGO DE INCOBRABILIDAD                                         ', 'V') 
go
       
declare @w_tabla smallint

select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_cat_observacion             ', ' CATEGORIA DE COMENTARIOS DE CREDITO                              ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'CONCEPTO DEL DIRECTOR DE OFICINA', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'CONCEPTO CENTRALES DE RIESGO', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'VIENE DE OTROS BANCOS', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'NIVEL DE ENDEUDAMIENTO', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'CONCEPTO DIRECTOR REGIONAL', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', 'CONCEPTO GERENTE COMERCIAL', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7', 'CONCEPTO VICEPRESIDENTE COMERCIAL', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_causales_devolucion         ', ' CAUSAS DE DEVOLUCION DE TRAMITES                                 ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', ' ACTIVIDAD DEL CLIENTE NO CORRESPONDE A LA REGISTRADA             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', ' ACTIVIDAD DEL CLIENTE NO SUJETA A CREDITO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', ' CLIENTE NO TIENE CODEUDOR                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', ' CLIENTE DESISTIO DEL CREDITO                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', ' CLIENTE ES CODEUDOR DE UN CLIENTE EN MORA                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', ' CLIENTE MAL REPORTADO EN CENTRALES DE RIESGO                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7', ' CLIENTE CON MALAS REFERENCIAS FINANCIERAS                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8', ' CLIENTE NO ACEPTA CONDICIONES DEL COMIT�                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9', ' CLIENTE NO ANEXO DOCUMENTACION SOLICITADA                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10', ' CLIENTE NO ES PROPIETARIO DEL NEGOCIO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11', ' CLIENTE NO OFRECE SUFICIENTES GARANTIAS                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12', ' CLIENTE NO POSEE LA EXPERIENCIA REQUERIDA EN LA ACTIVIDAD        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '13', ' CLIENTE NO TIENE CAPACIDAD DE PAGO                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14', ' CLIENTE NO VALIDO EN CENTRALES DE RIESGO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '15', ' CLIENTE NO VIVE EN LA DIRECCION INDICADA                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16', ' CLIENTE PRESENTA ALTO ENDEUDAMIENTO                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17', ' CLIENTE PRESENTA MALA NOTA EN SUS CREDITOS CON EL BANCO          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18', ' CLIENTE ESTA EN MORA EN SUS CREDITOS CON EL BANCO                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19', ' CLIENTE PRESENTA PROBLEMAS DE SALUD                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20', ' CLIENTE PRESENTA PROBLEMAS FAMILIARES                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21', ' CLIENTE REPORTADO EN LISTAS DE CONTROL                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22', ' CLIENTE SE VISITO 3 VECES Y NO SE ENCONTRO                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23', ' CLIENTE SUMINISTRO INFORMACION FALSA                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24', ' CLIENTE TIENE PROBLEMAS JURIDICOS                                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25', ' DEFICIENCIA EN EL ANALISIS DE CREDITO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26', ' ERROR DE PROCESAMIENTO DEL CREDITO                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27', ' ERROR EN LA DIRECCION DE DOMICILIO Y/O NEGOCIO DEL CLIENTE       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '28', ' ERROR EN LOS NOMBRES Y/O APELLIDOS DEL CLIENTE                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '29', ' FALTA DOCUMENTACION SOPORTE EN EL ESTUDIO DE CREDITO             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '30', ' FALTA FIRMA EN LA SOLICITUD DE CREDITO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '31', ' INDICE DE ENDEUDAMIENTO PATRIMONIAL SUPERIOR AL PERMITIDO        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '32', ' INDICE DE LIQUIDEZ MICROEMPRESA SUPERIOR AL PERMITIDO            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '33', ' INDICE DE RESPALDO DECLARACION JURADA SUPERIOR AL PERMITIDO      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '34', ' INDICE VALOR CUOTA DISPONIBLE SUPERIOR AL PERMITIDO              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '35', ' INESTABILIDAD DE VIVIENDA DEL CLIENTE                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '36', ' MAL COMPORTAMIENTO DEL CLIENTE CON EL PERSONAL DE LA INSTI', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '37', ' MALA VOLUNTAD DE PAGO DEL SOLICITANTE                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '38', ' MALAS REFERENCIAS PERSONALES DEL CLIENTE                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '39', ' NEGOCIO DE TEMPORADA                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '40', ' NEGOCIO DEL CLIENTE FIGURA CON CREDITO EN EL BANCO               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '41', ' NEGOCIO EN DECADENCIA                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '42', ' NEGOCIO ESTA EN VENTA                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '43', ' NO HAY CONTACTO CON REFERENCIAS PERSONALES                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '44', ' SOLICITUD NO PERTENCE AL AREA DE COBERTURA DE LA OFICINA         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '45', ' SOLICITUD NO PERTENCE AL AREA DE COBERTURA DEL EJECUTIVO MICR', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '46', ' ZONA DE ALTO RIESGO                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '47', ' ZONA RESTRINGIDA TEMPORALMENTE                                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '48', ' CLIENTE ES FAMILIAR DE FUNCIONARIOS DEL BANCO                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '49', ' CLIENTE NO POSEE NEGOCIO                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '50', ' NEGOCIO NO CUMPLE CON LA ANTIG�EDAD REQUERIDA POR EL BANCO       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '51', ' CLIENTE SUPERA ENDEUDAMIENTO PARA MICROCREDITO                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '52', ' CLIENTE PRESENTO DOCUMENTACION FALSA                             ', 'V') 

go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_ccosto', ' COSTOS DE UNA COBRANZA                                           ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ANTAB', ' ANTICIPOS ABOGADOS                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'AUTDOC', ' AUTENTICACION DOCUMENTOS                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CERTFOT', ' CERTIFICADOS Y FOTOCOPIAS                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CURADL', ' CURADOR AD LITEM                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'DILSEC', ' DILIGENCIAS SECUESTRE BIENES A EMBARGAR                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GASNOT', ' GASTOS DE NOTIFICACION                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'HONCUR', ' HONORARIOS CURADOR ADLITEM                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'HONPERAV', ' HONORARIOS PERITOS AVALUADORES                                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'INVBIE', ' INVESTIGACION BIENES DEUDOR                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'OGAS', ' OTROS GASTOS                                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'POLJUD', ' POLIZAS JUDICIALES                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'TRANAB', ' TRANSPORTE DE ABOGADO                                            ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_clase_abogado', ' CLASES DE COBRADOR                                               ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CF', ' FUNCIONARIO DE COBRANZA                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'AR', ' ANALISTA DE RECUPERACION                                         ', 'V') 

go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_clase_abogado_externo', ' CLASE DE ABOGADOS EXTERNOS                                       ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'AA', ' ABOGADO                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CC', ' CASA DE COBRANZA                                                 ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_clase_cartera', ' CLASIFICACION DE CARTERA') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'Actividad Empresarial o Comercial', 'V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'Liquidez a Otras Cooperativas', 'V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'Tarjeta De Cr�dito', 'V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'Personales', 'V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'N�mina', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', 'Automotriz', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7', 'Adquisici�n De Bienes Muebles', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8', 'Operaciones De Arrendamiento Capitalizable', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9', 'Otros Cr�ditos De Consumo', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10', 'Media y Residencial', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11', 'Inter�s Social', 'V')

go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_codificacion_medidas', ' MEDIDAS CAUTELARES                                               ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'EMBACC', ' EMBARGO DE ACCIONES                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'EMBCUE', ' EMBARGO DE CUENTAS CORRIENTES O SALDOS BANCARIOS                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'EMBEST', ' EMBARGO DE ESTABLECIMIENTO DE COMERCIO                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'EMBINM', ' EMBARGO DE BIEN INMUEBLE                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'EMBMAQ', ' EMBARGO DE MAQUINARIA Y EQUIPOS                                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'EMBMER', ' EMBARGO DE MERCANCIAS                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'EMBMIX', ' EMBARGOS MIXTOS                                                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'EMBMUE', ' EMBARGO DE MUEBLES Y ENSERES                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'EMBSUE', ' EMBARGO DE SUELDOS                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'EMBVEH', ' EMBARGO DE VEHICULOS                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'SECEST', ' SECUESTRO DE ESTABLECIMIENTOS DE COMERCIO                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'SECINM', ' SECUESTRO DE BIEN INMUEBLE                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'SECMAQ', ' SECUESTRO DE MAQUINARIA Y EQUIPOS                                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'SECMUE', ' SECUESTRO DE BIENES MUEBLES Y ENSERES                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'SECVEH', ' SECUESTRO DE VEHICULOS                                           ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_comite', 'COMITES DE CREDITO                                               ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '01', 'COMITE DE REESTRUCTURACIONES                                     ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_concepto', ' CONCEPTOS EN COMITE DE COBRANZA                                  ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ECJ', 'ENVIAR A COBRO JURIDICO                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ECP', 'ENVIAR A COBRO PRE-JURIDICO                                      ', 'V') 

go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_concepto_credito', ' CONCEPTOS DE CREDITO                                             ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'A', 'AUTOMATICO                                                       ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_concepto_rubro', ' CONCEPTOS PARA PROVISIONES                                       ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'CAPITAL                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10', 'ARRENDAMIENTOS DE BIENES PROPIOS                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11', 'ANTICIPOS DE PROVEEDORES                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12', 'ADELANTOS AL PERSONAL - ANTICIPOS LABORALES                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '13', 'ENTIDADES EN INTERVENCION                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14', 'PRESTAMOS A ENTIDADES INSCRITAS                                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '15', 'PROMETIENTES VENDEDORES                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16', 'ADELANTOS AL PERSONAL - GASTOS DE VIAJE                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17', 'COMISIONES POR SERVICIOS BANCARIOS                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19', 'DIVIDENDOS Y PARTICIPACIONES PERS. JURIDICAS                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'INTERES                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20', 'COMISIONES POR GIROS BANCARIOS                                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21', 'ARRENDAMIENTOS DE BIENES ADJUDICADOS                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22', 'ANTICIPOS DE CONTRATOS                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23', 'OTRAS DIVERSAS - FALTANTES EN CAJA                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24', 'OTRAS DIVERSAS - FALTANTES EN CANJE                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25', 'OTRAS DIVERSAS - RECLAMOS A COMPA�IAS ASEGURADORAS               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26', 'OTRAS DIVERSAS - IMPUESTO A LAS VENTAS POR PAGAR                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'COMISION POR CONTINGENCIAS                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'VENTA DE BIENES Y SERVICIOS                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'PAGO POR CUENTA DE CLIENTES POR CLASE DE CARTERA                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', 'HONORARIOS POR SERVICIO BANCO                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7', 'OTRAS DIVERSAS - OTRAS                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8', 'PAGO POR CUENTA DE CLIENTES CXC NO CARTERA                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9', 'DIVIDENDOS Y PARTICIPACIONES, MATRIZ, FILIALES, SUBSIDIARIAS     ', 'V') 
 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_matriz_mrc', ' MATRIZ MRC                                                       ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'A', ' MATRIZ A                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'B', ' MATRIZ B                                                         ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_enfermedades', ' ENFERMEDADES                                                     ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'CANCER                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10', 'DIABETES (AZUCAR EN LA SANGRE)                                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11', 'LIMITACION FISICA                                                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12', 'HIPERTENSION ARTERIAL                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '13', 'DERRAME CEREBRAL                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14', 'OTRA                                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'LEUCEMIA                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'SIDA                                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'INSUFICIENCIA RENAL CRONICA                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'ESCLEROSIS MULTIPLE                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', 'INFARTO CARDIACO                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7', 'CIRROSIS                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8', 'ENFERMEDADES PSIQUIATRICAS                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9', 'ARTRITIS                                                         ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_empresa_mrc', ' TIPO EMPRESA MRC                                                 ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GE', 'GRANDE EMPRESA                                                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ME', 'MEDIANA EMPRESA                                                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PE', 'PEQUENA EMPRESA                                                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PN', 'PERSONA NATURAL                                                  ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_cliente_mrc', ' TIPO CLIENTE MRC                                                 ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'C', 'COMPA�IA                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'P', 'PERSONA                                                          ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_calificacion_mrc', ' TIPO CALIFICACION MRC                                            ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'A', 'CATEGORIA A                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'AA', 'CATEGORIA AA                                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'B', 'CATEGORIA B                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'BB', 'CATEGORIA BB                                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CC', 'CATEGORIA CC                                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'I', 'CATEGORIA I                                                      ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_obg_pers', ' TIPOS DE OBLIGACIONES PERSONALES                                 ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'HIPOTECARIO                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'CONSUMO                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'TDC                                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'OTROS                                                            ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_unidades', ' UNIDADES                                                         ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'AR','ARROBAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'BU','BULTOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'CA','CARGAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'CH','CUCHARADAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'CM','CENTIMETROS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'DM','DECIMETROS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'GR','GRAMOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'KG','KILOGRAMOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'LB','LIBRAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'LT','LITROS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'M','METROS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ON','ONZAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'PI','PIEZAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'PO','PORCIONES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'PZ','PIZCAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'QL','QUILATES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'QN','QUINTALES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'RA','RASTRAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'UN','UNIDADES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'UP','UNIDADES PRODUCIDAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'CJ','CAJAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'PL','PLANTULAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'AL','ALMU','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'CU','CUARTILLOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'MA','MANOJOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'RM','RAMOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'PU','PU�ADOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'SI','SIN INFORMACION','B')
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_carne', ' UNIDADES                                                         ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'DE PRIMERA                                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'DE SEGUNDA                                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'GORDAS O TERCERAS                                                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'HUESO                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'CABEZA                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', 'VICERAS                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7', 'CUERO                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8', 'OTROS UNO                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9', 'OTROS DOS                                                        ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipos_seguro', ' Tipos de Seguros                                                 ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'VIDA                                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'TERCEROS                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'OTRO                                                             ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_coberturas', ' Tipos de coberturas                                              ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'VIDA                                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'ITP                                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'ENFERMEDADES GRAVES                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'AUXILIO GASTOS                                                   ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_excepciones', ' Tipos de EXCEPCIONES DE AMPARO                                   ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_criterio_rutero', ' Criterios de busqueda para clientes en rutero                    ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ALL', 'TODOS                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CAN', 'CANCELADOS                                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'MOR', 'MORA                                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NRE', 'NO RENOVADOS                                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'SOL', 'SOLICITUDES                                                      ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_estado_mic', ' ESTADOS MICROSEGUROS') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'P', 'PROPUESTO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'A', 'ANULADO',   'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_asegurado', ' TIPOS DE ASEGURADOS                                              ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'CLIENTE                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'CONYUGE                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'HIJO                                                             ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_concepto_recuperabilidad', ' Conceptos de Recuperabilidad                                     ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'EVE', 'EVENTUAL                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PRO', 'PROBABLE                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'REM', 'REMOTA                                                           ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_cobro', ' TIPO DE COBRO') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'VISITA', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'TELEFONO', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'CORREO ELECTRONICO', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'CARTA', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'TELEGRAMA', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_contacto', ' TIPO DE CONTACTO                                                 ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'DEUDOR                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'CODEUDOR                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'CONYUGE                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'OTROS                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'SIN CONTACTO                                                     ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_carta', ' TIPO DE CARTA DE COBRO                                           ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1AVISO', '1ER AVISO                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2AVISO', '2O AVISO                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3AVISO', '3ER AVISO                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4AVISO', '4O AVISO                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5AVISO', '5O AVISO                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CITACI', 'CITACION                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'SINAVI', 'SIN AVISO                                                        ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_observ', ' TIPO DE OBSERVACION                                              ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'NO SE UBICO                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'NO VIVE AHI                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'TELEFONO DA�ADO                                                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'NO ABRIERON                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'SE ESTABLECIO COMPROMISO                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', 'FAX                                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7', 'SE NIEGA A PAGAR                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8', 'SIN OBSERVACION                                                  ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_destino_carta', ' DESTINOS DE CARTAS DE COBRANZA                                   ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'AVA', 'AVALISTA                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CLI', 'CLIENTE                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'COD', 'CODEUDOR                                                         ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_efecto', ' EFECTO DEL CAMBIO DE GARANTIAS                                   ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'D', 'DISMINUYE                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'E', 'EQUITATIVA                                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'M', 'MEJORA                                                           ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_est_concordato', ' ESTADOS DEL CONCORDATO                                           ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'A', 'ADMITIDO                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'H', 'HOMOLOGADO                                                       ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_estado_cobranza', ' ESTADO DE UNA COBRANZA                                           ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CA', 'ADMINISTRATIVO                                                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CJ', 'COBRO JURIDICO                                                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CN', 'CONTENCION                                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CP', 'COBRO PREJURIDICO                                                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NO', 'NORMALIZADO                                                      ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_estado_cupo', ' ESTADOS DE CUPOS                                                 ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'A', 'ANULADO                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'B', 'BLOQUEADO                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'D', 'VENCIDO                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'V', 'VIGENTE                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'E', 'ELIMINADO                                                        ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_estado_desembolso_parcial', ' ESTADO DESEMBOLSO PARCIAL                                        ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'D', 'DESEMBOLSADO                                                     ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_estado_garantia', ' ESTADO DE GARANTIA                                               ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'A', 'APROBADA                                                         ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_estado_ins', ' ESTADOS DE INSTRUCCIONES                                         ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'A', 'APROBADA                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'E', 'EJECUTADA                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'P', 'PROPUESTA                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'R', 'RECHAZADA                                                        ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_estado_tramite', ' ESTADOS DE TRAMITES                                              ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'A', 'APROBADO                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'D', 'DEVUELTO                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'N', 'EN TRAMITE                                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'P', 'APLAZADO                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'R', 'APROBADO DESISTIDO                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'S', 'DESISTIDO                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'X', 'ANULADO                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'Z', 'NEGADO                                                           ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_etapa', 'ETAPAS EN EL PROCESO DE COBRANZA                                 ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1AVISO', 'PRIMER AVISO                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2AVISO', 'SEGUNDO AVISO                                           ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3AVISO', 'TERCER AVISO                                           ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4AVISO', 'CUARTO AVISO                                           ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5AVISO', 'QUINTO AVISO                                           ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ACUMDA', 'ACUMULACION DE DEMANDA                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ADMISDA', 'ADMISION DE LA DEMANDA                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ALLANDA', 'ALLANAMIENTO DE LA DEMANDA                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'APELSENT', 'APELACION DE SENTENCIA                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ARCHEXP', 'ARCHIVO DEL EXPEDIENTE                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'AVALBIEM', 'AVALUO BIENES EMBARGADOS                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CONC', 'CONCILIACION                                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CONTESCU', 'CONTESTACION DEMANDA POR EL CURADOR ADLITEM                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CONTESDA', 'CONTESTACION DEMANDA POR EL DEMANDADO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'DECLREM', 'DECLARA DESIERTO EL REMATE                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'DILREMP', 'DILIGENCIA DE REMATE PRIMERA POSTURA                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'DILREMS', 'DILIGENCIA DE REMATE SEGUNDA POSTURA                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'DILREMT', 'DILIGENCIA DE REMATE TERCERA POSTURA                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'EMB', 'EMBARGO                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'EXCEP', 'EXCEPCIONES                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'LIBERMED', 'LIBERACI�N OFICIOS DE MEDIAS CAUTELARES                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'LIQCOST', 'LIQUIDACION DE COSTAS                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'LIQUID', 'LIQUIDACION                                            ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'MANDPAG', 'MANDAMIENTO DE PAGO                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'MEDCAUT', 'MEDIDAS CAUTELARES SOLICITADAS                                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NOTAVIS', 'NOTIFICACION POR AVISO                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NOTCUR', 'NOTIFICACION CURADOR AD LITEM                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NOTEMPL', 'NOTIFICACION POR EMPLAZAMIENTO                                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NOTPER', 'NOTIFICACION PERSONAL                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'OBJAVAL', 'OBJECION DICTAMEN AVALUO                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'OFICEMB', 'OFICIOS DE EMBARGO                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PJAE', 'PREJURIDICO ABOGADO EXTERNO                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PJAI', 'PREJURIDICO ABOGADO INTERNO                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'RADICDA', 'RADICACION DE LA DEMANDA                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'RECAMTIT', 'RECLAMACION DE TITULOS JUDICIALES                                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'RECHDA', 'RECHAZO DE LA DEMANDA                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'SENT', 'SENTENCIA                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'SUBRFNG', 'SUBROGACI�N DE DEUDA AL F.N.G.                                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'SUSPROC', 'SUSPENSION PROCESO                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'TERMPROC', 'TERMINACION POR PAGO DE LA MORA                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'TERMPAGTO', 'TERMINACION POR PAGO TOTAL DE LA OBLIGACION                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'DESISTI', 'DESISTIMIENTO                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'TRASCON', 'TRASLADO CONTESTACION DEMANDA                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ACUERPV', 'ACUERDO DE PAGO VERBAL                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ACUERPE', 'ACUERDO DE PAGO ESCRITO                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'REEST', 'REESTRUCTURACION                                    ', 'V') 

go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

PRINT '@w_tabla'+cast(@w_tabla as char(12))
insert into cl_tabla values (@w_tabla, 'cr_linea_carta', 'LINEAS DE CREDITO QUE NO GENERAN CARTA RECORDATORIA O CONMINATOR') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

PRINT '@w_tabla'+cast(@w_tabla as char(12))
insert into cl_tabla values (@w_tabla, 'cr_novedades', ' SUBTIPOS DE NOVEDADES                                            ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'B', 'RESTITUCION DE PLAZO                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'DACION', ' DACION EN PAGO                                                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'E', ' REESTRUCTURACION                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GTIA', ' APROBACION LIBERACION                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'J', ' REMISION INTERESES                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'MOD.GTIAS', ' MODIFICACION DE GARANTIAS                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'P', ' PRORROGA                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'R', ' RELIQUIDACION DE INTERESES                                       ', 'V') 

go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_problemas', ' PROBLEMAS POTENCIALES EN CLIENTES                                ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CN', ' CLIENTE NO SE UBICO                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'DE', ' DIRECCION ERRADA                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'VE', ' VISITA EFECTUADA                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'VN', ' VISITA NO REALIZADA                                              ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_proceso', ' PROCESOS DE UNA COBRANZA                                         ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CONC', ' CONCORDATO                                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'HIPO', ' EJECUTIVO HIPOTECARIO                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'IECO', ' INTERVENCION ECONOMICA                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'LOBL', ' LIQUIDACION OBLIGATORIA                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'MIXT', ' EJECUTIVO MIXTO                                                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PREND', ' PRENDARIO                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'SING', ' EJECUTIVO SINGULAR                                               ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_producto_consolidador', ' PRODUCTOS PARA EL CONSOLIDADOR                                   ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ACB', ' ACEPTACIONES BANCARIAS COMEXT                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CCA', ' CARTERA                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CEX', ' COMERCIO EXTERIOR                                                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'COB', ' COBRANZAS COMEXT                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'MCB', ' MESA DE CAMBIO                                                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'SAC', ' SIDAC                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'SOC', ' SOBREGIROS CONTRATADOS                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'SOO', ' SOBREGIROS OCASIONALES                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'SOR', ' SOBREGIROS REMESAS                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'TCR', ' TARJETAS DE CREDITO                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'TES', ' TESORERIA                                                        ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_proposito', ' PROPOSITO DEL CAMBIO DE GARANTIAS                                ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ABG', ' AUMENTO O ADICION DE OTRO BIEN A LAS GARANTIAS                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CJE', ' CANJE                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CNP', ' CANCELACION PARCIAL                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'LEV', ' LEVANTAMIENTO                                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'REV', ' REAVALUO                                                         ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_razon', ' RAZON DEL CAMBIO DE GARANTIAS                                    ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'DET', ' POR DETERIORO                                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'OTR', ' OTRO                                                             ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_razon_visita', ' RAZON DE VISITAS                                                 ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'COBR', ' COBRANZA                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'EST', ' ESTUDIO DE CREDITO                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PROM', ' PROMOCION                                                        ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_relaciones', ' RELACIONES DE AFINIDAD Y CONSANGUINIDAD                          ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '01', 'CONYUGE                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '02', 'COMPANERO PERMANENTE                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '03', 'PADRE O MADRE                                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '04', 'HIJOS                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '05', 'ABUELOS                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '06', 'HERMANOS                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '07', 'NIETOS                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '08', 'SUEGROS                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '09', 'YERNOS                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10', 'NUERAS                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11', 'HIJOS DEL CONYUGE                                                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12', 'ABUELOS DEL CONYUGE                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '13', 'CUNADOS                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14', 'NIETOS DEL CONYUGE                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '15', 'ACCIONISTA  PERSONA NATURAL                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16', 'ACCIONISTA PERSONA JURIDICA                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17', 'JUNTA DIRECTIVA PRINCIPAL                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18', 'JUNTA DIRECTIVA SUPLENTE                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19', 'REPRESENTANTE LEGAL                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20', 'HIJO ADOPTADO                                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21', 'PADRE ADOPTANTE                                                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22', 'CONSOLIDACION DEL RIESGO                                         ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_renovacion', ' SUBTIPOS DE RENOVACIONES                                         ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'RE', ' RENOVACION                                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'RR', ' REESTRUCTURACION                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'UN', ' UNIFICACION UTILIZACIONES                                        ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_requisitos', ' REQUISITOS PARA TRAMITES                                         ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'FOTOCOPIA DE CEDULA SOLICITANTE                                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'SOLICITUD DE CREDITO FIRMADA                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'RECIBO DE PAGO CONSULTA A CENTRALES DE RIESGO SOLICITANTE        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'CONSULTA CENTRALES DE RIESGO SOLICITANTE                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'ESTUDIO DE CREDITO                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', 'DECLARACION DE RENTA DEL CLIENTE SI APLICA                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7', 'RESERVA DE CUPO FNG SI APLICA                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8', 'FOTOCOPIA CEDULA CODEUDOR                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9', 'ESTUDIO CREDITO CODEUDOR                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10', 'CONSULTA CENTRALES DE RIESGO CODEUDOR                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11', 'FACTURAS DEUDOR                                                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12', 'REFERENCIAS DEUDOR                                               ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '13', 'CERTIFICACIONES                                                  ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14', 'CERTIFICADO DE LIBERTAD Y TRADICION DEUDOR                       ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '15', 'FOTOCOPIA RECIBO PAGO IMPUESTO PREDIAL                           ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16', 'CERTIFICADO DE LIBERTAD Y TRADICION CODEUDOR                     ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17', 'DESPRENDIBLES DE NOMINA DEL CODEUDOR                             ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18', 'FACTURAS CODEUDOR                                                ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19', 'REFERENCIAS CODEUDOR                                             ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20', 'COMPROBANTE DE APROBACION                                        ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21', 'RECIBO DE SERVICIOS PUBLICOS                                     ', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22', 'DESPRENDIBLES DE NOMINA DEUDOR                                   ', 'V')

go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_rol_deudor', ' ROL DEUDOR                                                       ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'A', ' AVALISTA                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'C', ' CODEUDOR                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'D', ' DEUDOR                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'S', ' DEUDOR SOLIDARIO                                                 ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_sib', ' TABLA DE CORRESPONDENCIA Y PROCESOS                              ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T1', 'CODIGOS DE GARANTIA HIPOTECARIA                                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T100', 'CODIGOS DE LAS CUENTAS DE PASIVOS PARA REPLICAR                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T101', 'CODIGOS DE OBLIGACIONES DE LA EMPRESA                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T12', 'COSTOS VS CONCEPTOS DE CUENTAS POR PAGAR                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T14', 'REFERENCIAS INHIBITORIAS PARA ESTADOS DEL CLIENTE                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T15', 'REFERENCIAS DE MERCADO PARA ESTADOS DEL CLIENTE                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T19', 'LINEAS DE CREDITO DE CTA. CTE.                                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T2', 'LINEAS DE CREDITO PARA CALIFICAR                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T25', 'COSTOS DE COBRANZA VS RUBROS DE CARTERA                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T3', 'LINEAS DE CREDITO PARA PROVISIONAR                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T37', 'GASTOS JUDICIALES COBRANZA                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T38', 'GASTOS HONORARIOS ABOGADO                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T4', 'LINEAS DE CREDITO DE CONVENIOS                                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T40', 'TIPO GTIAS QUE NO CONTABILIZAN ESTADO F                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T5', 'TIPOS DE GARANTIAS CON VENCIMIENTO                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T6', 'LINEAS DE CREDITO PARA CALCULO DE RIESGO                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T65', 'GARANTIAS ESPECIALES Y AVALES DE LA NACION                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T72', 'INFORMACION FINANCIERA CUENTAS QUE SUMAN                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T73', 'CIUDADES DE FUENTES                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T74', 'COD DE LAS VARIABLES DE ACT FIJOS DEC JUR                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T75', 'OFICINAS DE LA CIUDAD DE MEDELLIN                                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T76', 'CODIGOS DE CUENTAS PARA TOTALES DE MICROEMPRESA                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T77', 'LINEAS DE CREDITO PARA PARALELOS                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T78', 'CODIGOS DE TIPO DE CARNE CON FACTOR LIBRAS                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T79', 'CODIGOS DE PARAMETROS PARA TIPO CARNICERIA                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T80', 'CODIGOS DE ETAPAS DE CALIFICACION                                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T81', 'PALM                                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T82', 'PALM                                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T83', 'ARCHIVO FNG GENERO DEL DEUDOR                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T84', 'ARCHIVO FNG ESTADO CIVIL                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T85', 'ARCHIVO FNG NIVEL DE ESTUDIOS                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T86', 'ARCHIVO FNG CODIGO MONEDA                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T87', 'ARCHIVO FNG CODIGO DE PLAZO                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T88', 'ARCHIVO FNG CODIGO TASA INDEXADA                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T89', 'ARCHIVO FNG CODIGO PERIODO DE TASA                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T90', 'ARCHIVO FNG MODALIDAD DE TASA                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T91', 'ARCHIVO FNG PERIODICIDAD DE AMORTIZACION DE CAPITAL              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T92', 'ARCHIVO FNG CALIFICACION DE RIESGO DE LA OBLIGACI�N              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T93', 'ARCHIVO FNG TIPO DE CARTERA                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T94', 'ARCHIVO FNG DESTINO DEL CREDITO                                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T95', 'ARCHIVO FNG TIPO DE RECURSOS                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T96', 'ARCHIVO FNG PERIODO DE COBRO                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T97', 'ARCHIVO FNG DE LA COMISION                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T98', 'ARCHIVO FNG CODIGO DEL PRODUCTO GARANTIA                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T99', 'CODIGOS DE LAS CUENTAS DE PASIVOS                                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T22', 'ACTIVACION REDESCUENTO', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T110', 'CALIFICACIONES DEFINITIVAS', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T20', 'ETAPA CREACION PLANO FINAGRO', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T200', 'HOMOLOGACION LINEAS ACTIVA VS PASIVA', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T102', 'LINEAS DE CREDITO TERRITORIAL CENTRO', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T103', 'LINEAS DE CREDITO TERRITORIAL OCCIDENTE', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T17', 'LINEAS REDESCUENTO', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '102', 'LINEAS DE CREDITO TERRITORIAL CENTRO', 'E') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '103', 'LINEAS DE CREDITO TERRITORIAL OCCIDENTE', 'E')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T104', 'ACTIVOS FIJOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T105', 'ACCIONES DE COBRANZA CORRESPONDIENTES A ACUERDOS DE PAGO', 'V')
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_subtipo_tramite', ' SUBTIPOS DE TRAMITE                                              ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'B', 'RESTITUCION DE PLAZO                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'C', 'CAMBIO DE LINEA                                                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'E', 'REESTRUCTURACION                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'F', 'REFINANCIACION FINAGRO                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GTIA', 'APROBACION LIBERACION                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'J', 'REMISION DE INTERES                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'L', 'LEY 550/99                                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'M', 'LEY 617/00                                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'MOD.GTIAS', 'MODIFICACION GTIAS                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'N', 'REFINANCIACION                                                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'P', 'PRORROGA                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'R', 'RENOVACION                                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'S', 'SUBROGACION                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T', 'CONSOLIDACION PASIVOS                                            ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_taccion', ' ACCIONES DE UNA COBRANZA                                         ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1','MENSAJE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'2','MENSAJE CON UN TERCERO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'3','MENSAJE CONTESTADOR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'4','FALLECIDO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'5','CONFIRMAR PAGO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'6','ILOCALIZADO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'7','VISITA DEUDOR - AI','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'8','VISITA CODEUDOR - AI','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'9','ACUERDO DE PAGO DEUDOR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'10','ACUERDO DE PAGO CODEUDOR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'11','RENUENTE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'12','AL DIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'13','ENVIO A COBRO JUR�DICO - AE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'14','INCUMPLIMIENTO COMPROMISO DE PAGO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'15','NORMALIZACION POR PAGO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'16','INVESTIGACI�N BIENES DEUDOR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'17','INVESTIGACI�N BIENES CODEUDOR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'18','RADICACION DE LA DEMANDA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'19','ACUMULACION DE DEMANDA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'20','ADMISION DE LA DEMANDA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'21','SUBSANACION DE LA DEMANDA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'22','INADMISION DE LA DEMANADA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'23','RECHAZO DE LA DEMANDA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'24','SUSPENSION PROCESO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'25','ALLANAMIENTO DE LA DEMANDA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'26','ACCIONES DE TERCEROS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'27','MANDAMIENTO DE PAGO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'28','RECLAMACION FNG','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'29','DEVOLUCION RECLAMACION FNG','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'30','SUBSANACION RECLAMACION FNG','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'31','NOTIFICACION PERSONAL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'32','NOTIFICACION POR AVISO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'33','NOTIFICACION POR EMPLAZAMIENTO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'34','COBRO X NOMINA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'35','NOTIFICACION POR CONDUCTA CONCLUYENTE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'36','NOTIFICACION CURADOR AD LITEM','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'37','CONTESTACION DEMANDA POR EL DEMANDADO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'38','CONTESTACION DEMANDA POR EL CURADOR ADLITEM','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'39','RECONOCIMIENTO PERSONERIA AL ABOGADO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'40','PRESENTACION EXCEPCIONES DE MERITO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'41','PRESENTACION EXCEPCIONES PREVIAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'42','TRASLADO CONTESTACION DEMANDA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'43','CITACION A CONCILIACION','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'44','RESULTADO CONCILIACION','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'45','SOLICITUD MEDIDAS CAUTELARES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'46','LIBERACI�N OFICIOS DE MEDIAS CAUTELARES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'47','CITACION AUDIENCIA PROCESO CONCORDATARIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'48','RESULTADO ACUERDO CONCORDATARIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'49','PERSECUCION REMANENTES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'50','EXPEDICION OFICIOS DE EMBARGO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'51','REGISTRO DE EMBARGOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'52','DILIGENCIA DE EMBARGO Y SECUESTRO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'53','DESEMBARGO DE BIENES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'54','SOLICITUD DE PRUEBAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'55','PRACTICA DE PRUEBAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'56','DECRETO DE PRUEBAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'57','NOTIFICACIONES Y NOMBRAMIENTOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'58','POSESION PERITO O AVALUADOR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'59','PRESTA CAUCION','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'60','ACTUACIONES PERICIALES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'61','AVALUO BIENES EMBARGADOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'62','OBJECIONES AL AVALUO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'63','FIJACION FECHA PARA REMATE DE BIENES EMBARGADOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'64','REMATE DE BIENES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'65','DECLARA DESIERTO EL REMATE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'66','APROBACION DEL REMATE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'67','DECLARACION DE INVALIDEZ DEL REMTAE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'68','ENTREGA DEL BIEN REMATADO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'69','PRONUNCIAMIENTO DE EXCEPCIONES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'70','SENTENCIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'71','INTERPOSICION DE RECURSOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'72','PRONUNCIAMIENTO A RECURSOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'73','LIQUIDACION DE COSTAS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'74','LIQUIDACION JUDICIAL DEL CREDITO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'75','RECLAMACION DE TITULOS JUDICIALES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'76','TERMINACION PROCESO POR CANCELACION TOTAL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'77','TERMINACION PROCESO POR DESISTIMIENTO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'78','TERMINACION PROCESO POR TRANSACCION','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'79','TERMINACION PROCESO POR EXCEPCION PREVIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'80','TERMINACION PROCESO POR PERENCION','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'81','TERMINACION POR CADUCIDAD','V')

go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tcarta', ' TIPOS DE CARTA DE COBRANZA                                       ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '01', 'CONMINATORIA                                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '02', 'RECORDATORIA                                                     ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_cobrador', ' TIPOS DE COBRADOR                                                ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'AA', 'ABOGADO                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'AR', 'ANALISTA DE RECUPERACION                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CC', 'CASA DE COBRANZA                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CF', 'FUNCIONARIO DE COBRANZA                                                 ', 'V') 

go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_cupo', ' TIPOS DE CUPOS                                                   ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'C', 'CONVENIO                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'N', 'NORMAL                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'O', 'SOLICITUD DE CREDITO                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'S', 'SOBREGIRO                                                        ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_garantia', ' TIPOS DE GARANTIAS                                               ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'A', 'AVALES DE LA NACION                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'E', 'GARANTIAS ESPECIALES                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'H', 'HIPOTECARIA IDONEA                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'I', 'IDONEA                                                           ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_rechazo', ' TIPOS DE RECHAZOS DE TRAMITES                                    ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ANU', 'ANULADO                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'APL', 'APLAZADO                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'DES', 'DESISTIDO                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'DEV', 'DEVOLUCION                                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NEG', 'NEGACION                                                         ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_especialidad', ' ESPECIALIDAD ABOGADO                                             ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CIVIL', 'PROCESOS CIVILES                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ORDINARIO', 'PROCESOS ORDINARIOS                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PENAL', 'PROCESOS PENALES                                                 ', 'V') 

go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_calif_ab', ' CALIFICACION DE ABOGADOS                                         ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '01', 'CALIFICACION UNO                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '02', 'CALIFICACION DOS                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '03', 'CALIFICACION TRES                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '04', 'CALIFICACION CUATRO                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '05', 'CALIFICACION CINCO                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '06', 'CALIFICACION SEIS                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '07', 'CALIFICACION SIETE                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '08', 'CALIFICACION OCHO                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '09', 'CALIFICACION NUEVE                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10', 'CALIFICACION DIEZ                                                 ', 'V') 

go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_causal_situacion', ' CAUSALES PRECASTIGO O CASTIGO                                    ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '01', 'INSOLVENCIA TOTAL DEUDORES Y CODEUDORES                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '02', 'CLIENTES CON GARANTIA PERSONAL VENCIDOS                          ', 'B') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '03', 'ILICITOS CON FALLO DE LA DENUNCIA PENAL                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '04', 'DEUDORES Y CODEUDORES ILOCALIZABLES                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '05', 'SALDOS INSOLUTOS SIN POSIBILIDAD DE RECAUDO                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '06', 'OBLIGACIONES QUE EL BANCO PERDIO EL FNG                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '07', 'PENALIZADO POR LALEY                                             ', 'B') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '08', 'MESES DE MORA                                                    ', 'B') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '09', 'CALAMIDAD DOMESTICA                                              ', 'B') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10', 'DESEMPLEO                                                        ', 'B') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11', 'QUIEBRA                                                          ', 'B') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12', 'RENUENTE AL PAGO                                                 ', 'B') 

go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_indicador_abog', ' INDICADOR EVALUACION DE ABOGADOS                                 ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', ' EFICIENCIA EN GESTION                                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', ' EFECTIVIDAD DE RECUPERACION                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', ' TERMINOS EN LAS ETAPAS PROCESALES                                           ', 'V') 

go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'sb_ctas_tesoreria', ' CUENTAS TESORERIA PARA CARTA SUPER                               ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1         ', ' 13040400005                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1304010000', ' 13040100005                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1304010001', ' 13040100010                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1304010002', ' 13040100020                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1304010003', ' 13040100030                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1304010006', ' 13040100060                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1304010009', ' 13040100090                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1304030000', ' 13040300005                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1304040000', ' 13040400005                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1304080001', ' 13040800015                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1304110002', ' 13041100020                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1304950000', ' 13049500005                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1304950001', ' 13049500010                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1308010000', ' 13080100005                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1308010001', ' 13080100010                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1308010002', ' 13080100020                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1308010006', ' 13080100060                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1308070000', ' 13080700005                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1308110000', ' 13081100005                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1308110001', ' 13081100010                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1316040000', ' 13160400005                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1316040008', ' 13160400088                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2         ', ' 13040100015                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3         ', ' 13040100035                                                      ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_man_un_rec_bac', ' MANEJA UNICAMENTE RECURSOS CON BAC                               ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'N', ' NO                                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'S', ' SI                                                               ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_sujeto_cred', ' SUJETO DE CREDITO                                                ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'MIC', ' MICROEMPRESARIO                                                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'VHV', ' VICTIMA DE HECHOS VIOLENTOS                                      ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_primer_nivel', ' Cuenta Primer Nivel                                              ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ACT', ' ACTIVOS                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'P&G', ' PERDIDAS Y GANANCIAS                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PAS', ' PASIVOS                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PAT', ' PATRIMONIO                                                       ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_segundo_nivel', ' Cuenta Segundo Nivel                                             ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ACTE', ' ACTIVO CORRIENTE                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'AFIJO', ' ACTIVO FIJO                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CMV', ' COSTO MERCANCIA VENDIDA                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'COMP', ' COMPRAS                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'DUF', ' DISPONIBLE UNIDAD FAMILIAR                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GFAM', ' GASTOS FAMILIARES                                                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GGEN', ' GASTOS GENERALES                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GPER', ' GASTOS DE PERSONAL                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'INGAD', ' INGRESOS ADICIONALES                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'OBEMP', ' OBLIGACIONES DE LA EMPRESA                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'OP', ' OBLIGACIONES PERSONALES                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'OTGA', ' OTROS GASTOS                                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PCTE', ' PASIVO CORRIENTE                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PLP', ' PASIVO LARGO PLAZO                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'UB', ' UTILIDAD BRUTA                                                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'UN', ' UTILIDAD NETA                                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'VTAS', ' VENTAS                                                           ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tercer_nivel', ' Cuenta Tercer Nivel                                              ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', ' PROVEEDORES CORTO PLAZO                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', ' OBLIGACIONES FINANCIERA CP                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', ' OTROS PASIVOS CP                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', ' PROVEEDORES LP                                                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', ' OBLIGACIONES FINANCIERAS LP                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', ' OTROS PASIVOS LP                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CXC', ' CUENTAS POR COBRAR                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'EFYBC', ' EFECTIVO Y BANCOS                                                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'INV', ' INVENTARIOS                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'M', ' MENSUAL                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'OBGPER', ' OBLIGACIONES PERSONALES                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'OTR', ' OTROS                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'S', ' SEMANAL                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'TR', ' TRANSPORTE                                                       ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_cuarto_nivel', ' Cuenta Cuarto Nivel                                              ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'MATPRI', ' MATERIA PRIMA                                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PRODPRO', ' PRODUCTOS EN PROCESO                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PRODTER', ' PRODUCTO TERMINADO                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PRODRUR', ' PRODUCTO RURAL                                                   ', 'V') 

go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_parametros_fuente', ' PARAMETROS FUENTE') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'EDAD',                     'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'ESTRATO',                  'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'MONTO',                    'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'OFICINA',                  'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', 'PLAZO ',                   'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7', 'CIUDAD',                   'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8', 'ACTIVOS MICROEMPRESA',     'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9', 'TRABAJADORES REMUNERADOS', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10','BANCOLDEX AECI', 'V')
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_oblig', ' TIPO DE OBLIGACIONES                                             ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'PROVEEDOR                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'OBLIGACIONES FINANACIERAS                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'OTROS PASIVOS                                                    ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_concepto_ef', ' CONCEPTO EFECTIVO Y BANCOS                                       ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'CUENTA CORRIENTE                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'EFECTIVO                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'CDT                                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'AHORRO                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'PRESTAMOS                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', 'OTROS                                                            ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_meses', ' MESES DEL A�O                                                    ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'ENERO                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10', 'OCTUBRE                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11', 'NOVIEMBRE                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12', 'DICIEMBRE                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'FEBRERO                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'MARZO                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'ABRIL                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'MAYO                                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', 'JUNIO                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7', 'JULIO                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8', 'AGOSTO                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9', 'SEPTIEMBRE                                                       ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_dias_semana', ' DIAS DE LA SEMANA                                                ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'LUNES                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'MARTES                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'MIERCOLES                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'JUEVES                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'VIERNES                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', 'SABADO                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7', 'DOMINGO                                                          ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_local', ' TIPO DE LOCAL                                                    ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla)
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1','PROPIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'2','RENTADO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'3','MISMO DE DOMICILIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'4','MERCADO','V')
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_emp', ' TIPO DE EMPRESA                                                  ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'TRANSPORTADOR                                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'OTROS                                                            ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_cond', ' TIPO DE CONDUCTOR                                                ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'S', 'SI', 'V') --SRA: Cambio valor segun requerimiento Aranda 62
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'N', 'NO', 'V') --SRA: Cambio valor segun requerimiento Aranda 62
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'SI','SIN INFORMACION', 'B') 

go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_contr', ' TIPO DE CONTRATO                                                 ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'F', 'FIJO                                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T', 'TEMPORAL                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'SI','SIN INFORMACION                                                 ', 'V') 

go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_bien', ' TIPO DE BIEN                                                     ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'HOGAR                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'NEGOCIO                                                          ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_activo', ' TIPO DE ACTIVO                                                   ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'NEVERA                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'LAVADORA                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'TELEVISOR                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'EQUIPO DE SONIDO                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'DVD                                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', 'OTROS                                                            ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_gasto_otros', ' GASTOS TIPO DE NEGOCIO OTROS                                     ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'ARRIENDO                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10', 'PUBLICIDAD                                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11', 'VIGILANCIA                                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12', 'OTROS                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '13', 'INSUMOS AGRICOLAS                                                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14', 'INSUMOS PECUARIOS                                                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'SERVICIO                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'TRANSPORTE                                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'ALIMENTACION                                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'IMPUESTOS                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', 'SEGURIDAD SOCIAL                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7', 'PRESTACIONES                                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8', 'APORTES PARA                                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9', 'MTO EQUIPO                                                       ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_gasto_trans', ' GASTOS TIPO DE NEGOCIO TRANSPORTACION                                     ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'MANTENIMIENTO                                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10', 'SOAT                                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11', 'IMPUESTO                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12', 'TARJETA OPERA                                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '13', 'PARQUEADERO                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14', 'ASEO                                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '15', 'CERT MOVILIZA                                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'LLANTAS                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'SEGURIDAD SOCIAL                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'PRESTACIONES                                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'CUOTA ADMON                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', 'RADIO TEL                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7', 'SEG TERCEROS                                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8', 'SEG PASAJEROS                                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9', 'SEG ROBO                                                         ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_ingresos_adic', ' INGRESOS ADICIONALES                                             ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'CONYUGE                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'APORTE HIJOS                                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'PENSIONES                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'ARRIENDOS                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'INTERESES                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', 'SUELDOS                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7', 'OTROS                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8', 'ING. ADICIONALES                                                 ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_gastos_famili', ' GASTOS FAMILIARES                                                ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'ALIMENTACION                                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10', 'SOCIEDAD MUTUAL                                                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'EDUCACION                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'TRANSPORTE                                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'ARRIENDOS                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'SERVICIOS                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', 'SALUD                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7', 'TARJETAS CREDITO                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8', 'OTROS                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9', 'CLUBES                                                           ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_destino', ' DESTINO ECONOMICO DEL CREDITO                                    ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '01', 'CAPITAL DE TRABAJO                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '02', 'COMPRA MAQ. Y EQUIPOS                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '03', 'COMPRA MAQ. AGROPECUARIA                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '04', 'MIXTO                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '05', 'MEJORA LOCATIVA                                                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '06', 'MTTO. VEHICULO PUBLICO                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '07', 'MTTO. VEHICULO PARTICULAR                                        ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_seguro_plan', ' PLANES DE SEGURO EXEQUIAL                                        ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'P1', 'PLAN 1                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'P2', 'PLAN 2                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PA1', 'PLAN ADICIONAL 1                                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PA2', 'PLAN ADICIONAL 2                                                 ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_fuente_recurso', 'FUENTES DE RECURSO') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'AUTONOMO',                 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'BANCOLDEX MULTIPROPOSITO', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'BANCOLDEX AECI',           'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_cotr', ' TIPO DE CONTRATO                                                 ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'F', 'FIJO                                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T', 'TEMPORAL                                                         ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_med_ext', ' MEDIDAS                                                 ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'C', 'CUADRAS                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'F', 'FANEGADAS                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'H', 'HECTAREAS                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'M', 'METROS                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CA', 'CUARTERONES                                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'U', 'UNIDAD                                                           ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_viene_otros_bancos', ' CLIENTE VIENE DE OTROS BANCOS                                    ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'N', 'NO                                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'S', 'SI                                                               ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_causa_victima', ' CAUSA DE VICTIMA DE HECHOS VIOLENTOS                             ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'ATENTADO TERROSITA                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'MINA ANTIPERSONAL                                                ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'AFECTADO EXPLOSIVO ABANDONADO                                    ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'COMBATES                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'SECUESTRO                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', 'ATAQUE                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7', 'MASACRE                                                          ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_credito_solicitado', ' CREDITO SOLICITADO POR EL CLIENTE VICTIMA DE HECHOS VIOLENTOS    ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'REPOSICION DE VEHICULOS                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10', 'REPOSICION DE EQUIPAMIENTO                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11', 'REPARACION DE EQUIPAMIENTO                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12', 'RECONSTRUCCION DE EQUIPAMIENTO                                   ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '13', 'REPOSICION DE MUEBLES Y ENSERES                                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14', 'REPARACION DE MUEBLES Y ENSERES                                  ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '15', 'RECONSTRUCCION DE MUEBLES Y ENSERES                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16', 'REPOSICION DE CAPITAL DE TRABAJO                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17', 'REPARACION DE CAPITAL DE TRABAJO                                 ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18', 'RECONSTRUCCION DE CAPITAL DE TRABAJO                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19', 'REPOSICION DE INMUEBLES COMERCIALES                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'REPARACION DE VEHICULOS                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20', 'REPARACION DE INMUEBLES COMERCIALES                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21', 'RECONSTRUCCION DE INMUEBLES COMERCIALES                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22', 'REPOSICION DE INMUEBLES NO COMERCIALES                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23', 'REPARACION DE INMUEBLES NO COMERCIALES                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24', 'RECONSTRUCCION DE INMUEBLES NO COMERCIALES                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25', 'CREDITO DE VIVIENDA                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'RECONSTRUCCION DE VEHICULOS                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'REPOSICION DE MAQUINARIA                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'REPARACION DE MAQUINARIA                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', 'RECONSTRUCCION DE MAQUINARIA                                     ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7', 'REPOSICION DE EQUIPO                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8', 'REPARACION O RECONSTRUCCION DE EQUIPO                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9', 'RECONSTRUCCION DE EQUIPO                                         ', 'V') 
go
       
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_seguro_parentesco', ' PARENTESCO DE SEGURO EXEQUIAL                                    ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'PROGENITOR                                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'CONYUGE                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'HIJO                                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'HERMANO                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'OTROS                                                            ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_sol_exp', ' AFIRMACION-NEGACION                                              ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'N', 'NO                                                               ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'S', 'SI                                                               ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_parentesco_micro', ' PARENTESCO MICROSEGUROS                                          ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
INSERT INTO cl_catalogo(tabla, codigo, valor, estado) VALUES(@w_tabla, '1', 'PADRE', 'V')
INSERT INTO cl_catalogo(tabla, codigo, valor, estado) VALUES(@w_tabla, '2', 'MADRE', 'V')
INSERT INTO cl_catalogo(tabla, codigo, valor, estado) VALUES(@w_tabla, '3', 'ESPOSO(A)', 'V')
INSERT INTO cl_catalogo(tabla, codigo, valor, estado) VALUES(@w_tabla, '4', 'HIJO(A)', 'V')
INSERT INTO cl_catalogo(tabla, codigo, valor, estado) VALUES(@w_tabla, '5', 'FAMILIAR', 'V')
INSERT INTO cl_catalogo(tabla, codigo, valor, estado) VALUES(@w_tabla, '6', 'AMIGO(A)', 'V')
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_parentesco_segexe', ' PARENTESCO SEGURO EXEQUIAL                                       ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '01', 'ABUELA                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '02', 'ABUELO                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '03', 'COMPANERA                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '04', 'COMPANERO                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '05', 'CONYUGE                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '06', 'CUNADA                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '07', 'CUNADO                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '08', 'HERMANA                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '09', 'HERMANASTRA                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '10', 'HERMANASTRO                                                      ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '11', 'HERMANO                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '12', 'HIJA                                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '13', 'HIJASTRA                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '14', 'HIJASTRO                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '15', 'HIJO                                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '16', 'MADRASTRA                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '17', 'MADRE                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '18', 'NIETA                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '19', 'NIETO                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '20', 'NUERA                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '21', 'PADRASTRO                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '22', 'PADRE                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '23', 'PRIMA                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '24', 'PRIMO                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '25', 'SOBRINA                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '26', 'SOBRINO                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '27', 'SUEGRA                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '28', 'SUEGRO                                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '29', 'TIA                                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '30', 'TIO                                                              ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '31', 'YERNO                                                            ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cu_concepto_avaluo', ' CONCEPTO DE AVALUO                                               ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ING', 'INGRESO NUEVA GARANTIA                                           ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PER', 'REAVALUO PERIODICO                                               ', 'V') 
go
       
declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_estado_activo', ' ESTADO DE LOS ACTIVOS                                            ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'B', 'BUENO                                                            ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'M', 'MALO                                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'R', 'REGULAR                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'SI', 'SIN INFORMACION                                                 ', 'B') 

go

declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_motivo_reestruct', 'MOTIVO DE REESTRUCTURACION DE CREDITO') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CALAMDOMES', 'CALAMIDAD DOMESTICA (ENFERMEDAD-ACCIDENTE-MUERTE)', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'BAJAVENTAS', 'BAJARON LAS VENTAS',                                'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CONSTRVIAS', 'AFECTADO POR LA CONSTRUCCION DE VIAS',              'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'DESASTNATU', 'DESASTRES NATURALES',                               'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PAROS',      'PAROS(TRANSPORTE)',                                 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'DESEMPLEO',  'PERDIDA DE EMPLEO (CONYUGUE)',                      'V')

go

declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_act_prodrur', 'TIPOS DE PRODUCTO PARA ACTIVIDADES RURALES') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '01', 'AGRICOLA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '02', 'PECUARIO',                                'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '03', 'COMERCIO',              'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '04', 'BIENES Y SERVICIOS',                               'V')

go

declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cobis..cl_tabla

insert into cobis..cl_tabla values (@w_tabla, 'cr_tipo_gestor', 'TIPO DE GESTOR') 
insert into cobis..cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'E', 'EJECUTIVO', 'V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'A', 'ABOGADO/CASA COBRANZA', 'V') 

go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cobis..cl_tabla

insert into cobis..cl_tabla values (@w_tabla, 'cr_tipo_calif', 'TIPO DE CALIFICACION') 
insert into cobis..cl_catalogo_pro values ('CRE ', @w_tabla)
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'COMERCIAL', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'CONSUMO', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'VIVIENDA', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'MICROCREDITO', 'V') 
go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cobis..cl_tabla

insert into cobis..cl_tabla values (@w_tabla, 'cr_motivo_rechazo', 'MOTIVOS DE RECHAZO DE CR�DITOS') 
insert into cobis..cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'CAPACIDAD DE PAGO',           'V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'ERROR EN SOLICITUD',          'V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'SOBREENDEUDAMIENTO',          'V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'RECHAZADO POR COMIT�',        'V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'DESISTI� DEL CR�DITO',        'V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', 'MAL COMPORTAMIENTO DE PAGO',  'V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7', 'ENVIADO A SU AGENCIA ORIGEN', 'V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '8', 'NO SE PRESENT� AL ESTUDIO',   'V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '9', 'NO CUMPLE REQUISITOS',        'V') 

go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cobis..cl_tabla

insert into cobis..cl_tabla values (@w_tabla, 'cr_cat_deudor', 'TIPO DEUDOR') 
insert into cobis..cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'D', 'DEUDOR PRINCIPAL','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'C', 'CODEUDOR','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'G', 'GRUPAL','V')
go

---cr_frecuencia
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cobis..cl_tabla

insert into cobis..cl_tabla values (@w_tabla,'cr_frecuencia', 'FRECUENCIA')
insert into cobis..cl_catalogo_pro values ('CRE', @w_tabla)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'D', 'DIARIO', 'V' )
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'S', 'SEMANAL', 'V' )
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'M', 'MENSUAL', 'V' )
go

---cr_dividendo_report
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cobis..cl_tabla

insert into cobis..cl_tabla values (@w_tabla,'cr_dividendo_report', 'FRECUENCIA REPORTES')
insert into cobis..cl_catalogo_pro values ('CRE', @w_tabla)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'D', 'DIARIOS', 'V' )
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'A', 'ANUALES', 'V' )
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'M', 'MENSUALES', 'V' )
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T', 'TRIMESTRALES', 'V' )
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'S', 'SEMESTRALES', 'V' )
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'B', 'BIMESTRALES', 'V' )
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'W', 'SEMANALES', 'V' )
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'Q', 'QUINCENALES', 'V' )
go

---cr_redes_sociales
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cobis..cl_tabla

insert into cobis..cl_tabla values (@w_tabla,'cr_redes_sociales', 'REDES SOCIALES')
insert into cobis..cl_catalogo_pro values ('CRE', @w_tabla)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'F', 'FACEBOOK', 'V' )
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'W', 'WHATSAPP', 'V' )
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'N', 'NO USO', 'V' )
go

---cr_tipo_telefono
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cobis..cl_tabla

insert into cobis..cl_tabla values (@w_tabla,'cr_tipo_telefono', 'TIPO DE TELEFONO')
insert into cobis..cl_catalogo_pro values ('CRE', @w_tabla)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'S', 'SMARTPHONE', 'V' )
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'O', 'OTRO', 'V' )
go

--cr_tipo_pago_telefono
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cobis..cl_tabla

insert into cobis..cl_tabla values (@w_tabla,'cr_tipo_pago_telefono', 'TIPO DE PAGO DEL TELEFONO')
insert into cobis..cl_catalogo_pro values ('CRE', @w_tabla)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'R', 'RENTA', 'V' )
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'P', 'PREPAGO', 'V' )
go

--cr_plazo_ind
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cobis..cl_tabla

insert into cobis..cl_tabla values (@w_tabla,'cr_plazo_ind', 'PLAZOS PARA INDIVIDUAL')
insert into cobis..cl_catalogo_pro values ('CRE', @w_tabla)

insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1', '1', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '3', '3', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '6', '6', 'V' )
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '12', '12', 'V' )

go

--cr_tplazo_ind
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cobis..cl_tabla

insert into cobis..cl_tabla values (@w_tabla,'cr_tplazo_ind', 'FRECUENCIA PARA INDIVIDUAL')
insert into cobis..cl_catalogo_pro values ('CRE', @w_tabla)
-- valores de la tabla cob_cartera..ca_tdividendo
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'W', 'SEMANAL'    ,'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'M', 'MENSUAL'    ,'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'Q', 'QUINCENAL'  ,'B')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'BW','CATORCENAL'  ,'V')

go

--Flujos Grupales
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cobis..cl_tabla

insert into cobis..cl_tabla (codigo, tabla, descripcion) values (@w_tabla, 'cr_flujo_grp', 'Flujos Grupales')
insert into cobis..cl_catalogo_pro values ('CRE', @w_tabla)

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PROC4', 'PROCESO 4', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'CREGRP', 'CREDITO GRUPAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'SOLCRGRSTD', 'SANTANDER CREDITO GRUPAL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GRGYE', 'GRUPAL GUAYAQUIL', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'CRRENGR','CREDITO GRUPAL RENOVACION','V',null,null,null)

go

--cr_doc_digitalizado
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla,'cr_doc_digitalizado','Documentos digitalizados')
insert into cl_catalogo_pro values ('CRE', @w_tabla)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'001','PAGARES','V')
--insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'002','REGLAMENTO INTERNO','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'003','IDENTIFICACION OFICIAL','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'004','COMPROBANTE DE DOMICILIO','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'005','AVISO DE PRIVACIDAD','V')    
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'006','AUTORIZACION DE CONSULTA BURO DE CREDITO','V')  
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'007','CONSENTIMIENTO INDIVIDUAL','V')  
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'008','FORMATO DE DOMICILIACION','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'009 ','SOLICITUD DE CREDITO COMPLEMENTARIA','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'010','CERTIFICADO DE CONSENTIMIENTO (SEGURO)','V') --Req.197007
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'011','CERTIFICADO ASISTENCIA FUNERARIA','V')       --Req.197007
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'012','CERTIFICADO ASISTENCIA MÉDICA','V')          --Req.197007
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'013','FORMULARIO KYC','V')                         --Req.197007
   
go


--cr_doc_digitalizado_ind
print 'cr_doc_digitalizado_ind'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cobis..cl_tabla values (@w_tabla,'cr_doc_digitalizado_ind','Documentos digitalizados para clientes individuales')
insert into cl_catalogo_pro values ('CRE', @w_tabla)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'001','IDENTIFICACION FRONTAL','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'002','IDENTIFICACION TRASERA','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'003','COMPROBANTE DOMICILIO','V')  
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'004','AVISO DE PRIVACIDAD','V')  
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'005','AUTORIZACION BURO','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'006','REPORTE DE CREDITO EXTERNO','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'007','REPORTE DE CREDITO INTERNO','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'008','SOLICITUD CONTRATO','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '009', 'DOCUMENTO PROBATORIO ANVERSO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '010', 'SOLICITUD DE MODIFICACION DE DATOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '011', 'DOCUMENTO PROBATORIO REVERSO', 'V') -- caso#194473

go

--cr_doc_prospecto
print 'cr_doc_prospecto'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cobis..cl_tabla values (@w_tabla,'cr_doc_prospecto','Documentos digitalizados de pantalla de prospectos')

insert into cl_catalogo_pro values ('CRE', @w_tabla)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'001','IDENTIFICACION FRONTAL','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'002','IDENTIFICACION TRASERA','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'003','COMPROBANTE DOMICILIO','V')  
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'008','SOLICITUD DE CREDITO CORTA','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '009', 'DOCUMENTO PROBATORIO', 'V')

go
--cr_doc_digitalizado_flujo_ind
print 'cr_doc_digitalizado_flujo_ind'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cobis..cl_tabla values (@w_tabla,'cr_doc_digitalizado_flujo_ind','Documentos digitalizados para flujo individual')
insert into cl_catalogo_pro values ('CRE', @w_tabla)

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'001','AVISO DE PRIVACIDAD','V')  
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'002','AUTORIZACION BURO','V') 
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'003','AVISO DE PRIVACIDAD INDIVIDUAL / AVAL','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'004','AUTORIZACION BURO INDIVIDUAL / AVAL','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'005','FORMATO DE DOMICILIACION', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado)values  (@w_tabla,'006','SOLICITUD DE CREDITO COMPLEMENTARIA', 'V')
go


PRINT 'cr_resultado_cobro'
DECLARE @w_tabla SMALLINT
SELECT @w_tabla = MAX(codigo) + 1 FROM cl_tabla
INSERT INTO cobis..cl_tabla VALUES (@w_tabla, 'cr_resultado_cobro', 'Resultado de proceso de Cobro')
INSERT INTO cl_catalogo_pro VALUES ('CRE', @w_tabla)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '00', 'EXITOSO-COBRADO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '01', 'CUENTA INEXISTENTE', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '02', 'CUENTA BLOQUEADA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '03', 'CUENTA CANCELADA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '04', 'CUENTA CON INSUFICIENCIA DE FONDOS', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '05', 'CUENTA EN OTRA DIVISA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '06', 'CUENTA NO PERTENECE AL BANCO RECEPTOR', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '07', 'TRANSACCI�N DUPLICADA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '08', 'POR ORDEN DEL CLIENTE: ORDEN DE NO PAGAR A ESE EMISOR', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '09', 'POR ORDEN DEL CLIENTE: IMPORTE MAYOR AL AUTORIZADO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '10', 'POR ORDEN DEL CLIENTE: CANCELACI�N DEL SERVICIO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '11', 'CLIENTE NO TIENE AUTORIZADO EL SERVICIO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '12', 'VENCIMIENTO DE LA ORDEN DE PAGO EN VENTANILLA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '13', 'CLIENTE DESCONOCE EL CARGO', 'V')
GO


PRINT 'cr_resultado_desembolso_formato'
DECLARE @w_tabla SMALLINT
SELECT @w_tabla = MAX(codigo) + 1 FROM cl_tabla
INSERT INTO cobis..cl_tabla VALUES (@w_tabla, 'cr_resultado_desembolso_format', 'Resultado de formato de archivo de Desembolso')
INSERT INTO cl_catalogo_pro VALUES ('CRE', @w_tabla)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '00', 'FORMATO VALIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '01', 'ERROR AL IDENTIFICAR FORMATO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '31', 'FORMATO DE FECHA DE TRANSFERENCIA INV�LIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '41', 'FORMATO INVALIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '47', 'SE ENCONTR� DOBLE ENCABEZADO SIN UN SUMARIO PREVIO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '52', 'FORMATO DE FECHA DE PRESENTACI�N INICIAL INV�LIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '54', 'SE ENCONTRO DETALLE SIN ENCABEZADO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '55', 'SE ENCONTRO SUMARIO SIN ENCABEZADO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '91', 'FALL� OBLIGATORIEDAD EN UN CAMPO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '97', 'LONGITUD DEL REGISTRO INV�LIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '98', 'TIPO DE REGISTRO INVALIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '99', 'CUENTA CORRECTA, EN PROCESO DE ACTIVACI�N', 'V')
GO


PRINT 'cr_resultado_desembolso_detalle'
DECLARE @w_tabla SMALLINT
SELECT @w_tabla = MAX(codigo) + 1 FROM cl_tabla
INSERT INTO cobis..cl_tabla VALUES (@w_tabla, 'cr_resultado_desembolso_detall', 'Resultado de detalle de archivo de Desembolso')
INSERT INTO cl_catalogo_pro VALUES ('CRE', @w_tabla)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '02', 'ERROR EN DATOS', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '03', 'SERVICIO NO AUTORIZADO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '08', 'REINTENTOS CONSUMIDOS', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '15', 'FECHA DE PRESENTACION INVALIDA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '16', 'HORARIO DE PRESENTACI�N INV�LIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '22', 'NUMERO DE SECUENCIA INCORRECTA EN EL ENCABEZADO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '23', 'SENTIDO INCORRECTO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '24', 'N�MERO DE SECUENCIA INCORRECTA EN EL SUMARIO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '25', 'TOTAL DE OPERACIONES INCORRECTO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '26', 'IMPORTE TOTAL DE OPERACIONES INCORRECTO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '27', 'CODIGO DE OPERACI�N INVALIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '29', 'N�MERO DE SECUENCIA EN EL DETALLE INCORRECTO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '32', 'FECHA DE TRANSFERENCIA NO PERMITIDA (D�A INH�BIL)', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '35', 'BANCO ORIGEN NO ES SANTANDER', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '36', 'BANCO RECEPTOR CON FORMATO INCORRECTO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '37', 'IMPORTE INVALIDO, DEBE SER MAYOR A CERO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '38', 'BANCO RECEPTOR NO ESTA EN CATALOGO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '40', 'TIPO DE CUENTA DEL ORDENANTE INV�LIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '41', 'FORMATO DE FECHA DE APLICACI�N INV�LIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '42', 'FORMATO INVALIDO DEL CAMPO NUMERO DE CUENTA ORDENANTE', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '43', 'MODALIDAD INVALIDA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '44', 'NUMERO DE BLOQUE ENCABEZADO ES DISTINTO AL SUMARIO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '45', 'TIPO DE CUENTA DEL RECEPTOR INV�LIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '46', 'FORMATO INVALIDO DEL CAMPO NUMERO DE CUENTA RECEPTOR', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '51', 'MOTIVO DE DEVOLUCI�N INV�LIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '56', 'CAMPO DE RECHAZO DE BLOQUE NO ES CERO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '63', 'FECHA DE TRANSFERENCIA MAYOR A LA FECHA DE APLICACI�N', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '64', 'FECHA DE TRANSFERENCIA MENOR A LA FECHA DE PROCESO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '68', 'FECHA DE APLICACI�N NO PERMITIDA (D�A INH�BIL)', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '69', 'DIVISA NO PERMITIDA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '71', 'FECHA DE PRESENTACI�N INICIAL DIFERENTE A FECHA DE PRESENTACI�N', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '74', 'NOMBRE DEL ORDENANTE INV�LIDO, CONTIENE ESPACIOS', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '79', 'REFERENCIA DEL SERVICIO EMISOR INV�LIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '80', 'NOMBRE DEL TITULAR DEL SERVICIO INV�LIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '81', 'FORMATO INVALIDO DEL CAMPO IMPORTE IVA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '83', 'C�DIGO DE OPERACI�N DEL SUMARIO INCONSISTENTE CON EL ENCABEZADO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '85', 'TIPO DE OPERACI�N INV�LIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '86', 'PRODUCTO SIN EMAIL A BENEFICIARIOS ACTIVADO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '88', 'PEND CONFIRMACION OTRO BANCO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '90', 'C�DIGO DE DIVISA INCONSISTENTE CON EL ENCABEZADO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '93', 'FORMATO EMAIL INCORRECTO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '98', 'REFERENCIA DEL CLIENTE INVALIDA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '99', 'CUENTA BENEFICIARIA DADA DE ALTA O YA EXISTENTE', 'V')
go

PRINT 'cr_tipo_negocio'
DECLARE @w_tabla SMALLINT, @w_apostrofe char(1)
SELECT @w_tabla = MAX(codigo) + 1 FROM cl_tabla
INSERT INTO cobis..cl_tabla VALUES (@w_tabla, 'cr_tipo_negocio', 'TIPO DE NGOCIO')
INSERT INTO cl_catalogo_pro VALUES ('CRE', @w_tabla)

select @w_apostrofe = CHAR(39)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '01', 'SERVICIO MEDICO', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '02', 'CIA '+'Q' + @w_apostrofe  +' OTORGA', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '03', 'COMP PETROLERA', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '04', 'EDITORIAL', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '05', 'SERV FIDUCIARIOS', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '06', 'TIENDA COMERCIAL', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '07', 'COMUNICACIONES', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '08', 'SERVICIOS', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '09', 'PRUEBA OTORGANTE', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '10', 'PRUEBAS BC', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '11', 'PROCESADOR', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '12', 'CONSULTA MI BURO', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '13', 'CONSUMIDOR FINAL', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '14', 'EDUCACI�N', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '15', 'SERVS. GRALES.', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '16', 'SEGURO', 'V' )


UPDATE cobis..cl_seqnos 
SET siguiente = @w_tabla 
WHERE tabla  = 'cl_tabla' 
GO

declare @w_tabla int
select @w_tabla = codigo from cl_tabla where tabla = 'cr_tipo_contrato'

if isnull(@w_tabla,0) = 0
begin
    select @w_tabla = isnull(max(codigo), 0) + 1
    from   cobis..cl_tabla

    insert into cobis..cl_tabla (codigo, tabla, descripcion)
    values (@w_tabla,'cr_tipo_contrato', 'TIPO DE CONTRATO')

    insert into cobis..cl_catalogo_pro (cp_producto, cp_tabla)
    values ('CRE', @w_tabla)

    update cobis..cl_seqnos
    set    siguiente = @w_tabla + 1
    where  tabla = 'cl_tabla'
end



INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'AF', 'Aparatos /Muebles', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'AG', 'Agropecuario (PFAE)', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'AL', 'Arrendamiento Automotriz', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'AP', 'Aviaci�n', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'AU', 'Compra de Autom�vil', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'BD', 'Fianza', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'BT', 'Bote / Lancha', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'CE', 'Cartas de Cr�dito (PFAE)', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'CF', 'Cr�dito fiscal', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'CL', 'L�nea de Cr�dito', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'CO', 'Consolidaci�n', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'CS', 'Cr�dito Simple (PFAE)', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'CT', 'Con Colateral (PFAE)', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'DE', 'Descuentos (PFAE)', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'EQ', 'Equipo', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'FI', 'Fideicomiso (PFAE)', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'FT', 'Factoraje', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'HA', 'Habilitaci�n o Av�o (PFAE)', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'HE', 'Pr�stamo tipo - Home Equity', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'HI', 'Mejoras a la casa', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'LR', 'L�nea de Cr�dito Reinstalable', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'LS', 'Arrendamiento', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'MI', 'Otros', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'OA', 'Otros adeudos vencidos (PFAE)', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'PA', 'Pr�stamo para Personas F�sicas con Actividad Empresarial', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'PB', 'Editorial', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'PG', 'PGUE - Pr�stamo como garant�a de unidades industriales', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'PL', 'Pr�stamo personal', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'PN', 'Pr�stamo de n�mina', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'PR', 'Prendario (PFAE)', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'PS', 'Pago de Servicios', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'PQ', 'Quirografario (PFAE)', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'RC', 'Reestructurado (PFAE)', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'RD', 'Redescuento (PFAE)', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'RE', 'Bienes Ra�ces', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'RF', 'Refaccionario (PFAE)', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'RN', 'Renovado (PFAE)', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'RV', 'Veh�culo Recreativo', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'SC', 'Tarjeta garantizada', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'SE', 'Pr�stamo garantizado', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'SG', 'Seguros', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'SM', 'Segunda hipoteca', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'ST', 'Pr�stamo para estudiante', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'TE', 'Tarjeta de Cr�dito Empresarial', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'UK', 'Desconocido', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'US', 'Pr�stamo no garantizado', 'V' )

GO

PRINT '--->> Registro de catalogos-cr_tipo_responsabilidad'
use cobis
go
declare @w_tabla int
select @w_tabla = codigo from cl_tabla where tabla = 'cr_tipo_responsabilidad'

if isnull(@w_tabla,0) = 0
begin
    select @w_tabla = isnull(max(codigo), 0) + 1
    from   cobis..cl_tabla

    insert into cobis..cl_tabla (codigo, tabla, descripcion)
    values (@w_tabla,'cr_tipo_responsabilidad', 'TIPO DE RESPONSABILIDAD')

    insert into cobis..cl_catalogo_pro (cp_producto, cp_tabla)
    values ('CRE', @w_tabla)

    update cobis..cl_seqnos
    set    siguiente = @w_tabla + 1
    where  tabla = 'cl_tabla'
    
end

INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'A', 'Usuario Autorizado', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'C', 'Obligado Solidario', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'I', 'Individual', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'J', 'Mancomunado', 'V' )


GO

PRINT '--->> Registro de catalogos-cr_tipo_cuenta'
use cobis
go
declare @w_tabla int
select @w_tabla = codigo from cl_tabla where tabla = 'cr_tipo_cuenta'

if isnull(@w_tabla,0) = 0
begin
    select @w_tabla = isnull(max(codigo), 0) + 1
    from   cobis..cl_tabla

    insert into cobis..cl_tabla (codigo, tabla, descripcion)
    values (@w_tabla,'cr_tipo_cuenta', 'TIPO DE CUENTA')

    insert into cobis..cl_catalogo_pro (cp_producto, cp_tabla)
    values ('CRE', @w_tabla)

    update cobis..cl_seqnos
    set    siguiente = @w_tabla + 1
    where  tabla = 'cl_tabla'
    
end

INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'O', 'Sin limite prestablecido', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'R', 'Revolvente', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'M', 'Hipotecas', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'I', 'Pagos Fijos', 'V' )


GO

PRINT '--->> Registro de catalogos-cr_forma_pago'
use cobis
go
declare @w_tabla int

select @w_tabla = codigo from cl_tabla where tabla = 'cr_forma_pago'

if isnull(@w_tabla,0) = 0
begin
    select @w_tabla = isnull(max(codigo), 0) + 1
    from   cobis..cl_tabla

    insert into cobis..cl_tabla (codigo, tabla, descripcion)
    values (@w_tabla,'cr_forma_pago', 'FORMA PAGO - MOP')

    insert into cobis..cl_catalogo_pro (cp_producto, cp_tabla)
    values ('CRE', @w_tabla)

    update cobis..cl_seqnos
    set    siguiente = @w_tabla + 1
    where  tabla = 'cl_tabla'
    
end


INSERT INTO cob_credito..cr_catalogo_buro (cb_tabla, cb_codigo, cb_descripcion) VALUES (@w_tabla, 'UR', 'Cuenta sin informaci�n.' )
INSERT INTO cob_credito..cr_catalogo_buro (cb_tabla, cb_codigo, cb_descripcion) VALUES (@w_tabla, '00', 'Muy reciente para ser calificada.')
INSERT INTO cob_credito..cr_catalogo_buro (cb_tabla, cb_codigo, cb_descripcion) VALUES (@w_tabla, '01', 'Cuenta al corriente, 0 d�as de atraso de su fecha l�mite de pago (1 a 29 d�as transcurridos de su fecha de corte o facturaci�n)')
INSERT INTO cob_credito..cr_catalogo_buro (cb_tabla, cb_codigo, cb_descripcion) VALUES (@w_tabla, '02', 'Cuenta con atraso de 1 a 29 d�as de su fecha l�mite de pago (30 a 59 d�as transcurridos de su fecha de corte o facturaci�n).')
INSERT INTO cob_credito..cr_catalogo_buro (cb_tabla, cb_codigo, cb_descripcion) VALUES (@w_tabla, '03', 'Cuenta con atraso de 30 a 59 d�as de su fecha l�mite de pago (60 a 89 d�as transcurridos de su fecha de corte o facturaci�n).')
INSERT INTO cob_credito..cr_catalogo_buro (cb_tabla, cb_codigo, cb_descripcion) VALUES (@w_tabla, '04', 'Cuenta con atraso de 60 a 89 d�as de su fecha l�mite de pago (90 a 119 d�as transcurridos de su fecha de corte o facturaci�n).')
INSERT INTO cob_credito..cr_catalogo_buro (cb_tabla, cb_codigo, cb_descripcion) VALUES (@w_tabla, '05', 'Cuenta con atraso de 90 a 119 d�as de su fecha l�mite de pago (120 a 149 d�as transcurridos de su fecha de corte o facturaci�n).')
INSERT INTO cob_credito..cr_catalogo_buro (cb_tabla, cb_codigo, cb_descripcion) VALUES (@w_tabla, '06', 'Cuenta con atraso de 120 a 149 d�as de su fecha l�mite de pago (150 hasta 180 d�as transcurridos de su fecha de corte o facturaci�n).')
INSERT INTO cob_credito..cr_catalogo_buro (cb_tabla, cb_codigo, cb_descripcion) VALUES (@w_tabla, '07', 'Cuenta con atraso de 150 d�as hasta 12 meses de su fecha l�mite de pago (181 d�as a 12 meses transcurridos de su fecha de corte o facturaci�n).')
INSERT INTO cob_credito..cr_catalogo_buro (cb_tabla, cb_codigo, cb_descripcion) VALUES (@w_tabla, '96', 'Cuenta con atraso de m�s de 12 meses de su fecha de pago y corte o facturaci�n.')
INSERT INTO cob_credito..cr_catalogo_buro (cb_tabla, cb_codigo, cb_descripcion) VALUES (@w_tabla, '97', 'Cuenta con deuda parcial o total sin recuperar.')
INSERT INTO cob_credito..cr_catalogo_buro (cb_tabla, cb_codigo, cb_descripcion) VALUES (@w_tabla, '99', 'Fraude cometido por el Cliente')

GO
PRINT '--->> Registro de correo de Interfactura no valida'

USE cobis
GO
DECLARE 
@w_tabla SMALLINT

select  @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
INSERT INTO cobis..cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'cr_correo_rfc_Global', 'Correo Rfc Interfactura Global')
--inserta catalogo pro
INSERT INTO cobis..cl_catalogo_pro (cp_producto, cp_tabla)
VALUES ('ADM',@w_tabla )
--Insertando Catalogos
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '1', 'ejprado@santander.com.mx', 'V', NULL, NULL, NULL)

go


print '--->> Registro de catalogos--- cr_etapa_genera_tabla'
use cobis
go
declare @w_tabla            int,
        @w_codigo_actividad int,
        @w_codigo_act_varch varchar(8)

select @w_tabla = codigo from cl_tabla where tabla = 'cr_etapa_genera_tabla'

if isnull(@w_tabla,0) = 0
begin
    select @w_tabla = isnull(max(codigo), 0) + 1
    from   cobis..cl_tabla

    insert into cobis..cl_tabla (codigo, tabla, descripcion)
    values (@w_tabla,'cr_etapa_genera_tabla', 'ETAPAS GENERA TABLA')

    insert into cobis..cl_catalogo_pro (cp_producto, cp_tabla)
    values ('CRE', @w_tabla)

    update cobis..cl_seqnos
    set    siguiente = @w_tabla + 1
    where  tabla = 'cl_tabla'
    
end

select @w_codigo_actividad = ac_codigo_actividad
from cob_workflow..wf_actividad
where  ac_nombre_actividad like '%APROBAR PR�STAMO%'

select @w_codigo_act_varch = convert(varchar(8),@w_codigo_actividad) 
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, @w_codigo_act_varch, 'APROBACION', 'V' )
go

use cobis
go
declare @w_tabla int,
@w_codigo_rol varchar(10), 
@w_nombre_rol varchar(64)

select @w_tabla = codigo from cl_tabla where tabla = 'cr_hab_upload_por_rol'

if isnull(@w_tabla,0) = 0
begin
    select @w_tabla = isnull(max(codigo), 0) + 1
    from   cobis..cl_tabla

    insert into cobis..cl_tabla (codigo, tabla, descripcion)
    values (@w_tabla,'cr_hab_upload_por_rol', 'ROLES PARA ACTIVAR CARGA ARCHIVOS')

    insert into cobis..cl_catalogo_pro (cp_producto, cp_tabla)
    values ('CRE', @w_tabla)

    update cobis..cl_seqnos
    set    siguiente = @w_tabla + 1
    where  tabla = 'cl_tabla'
    
end

select @w_codigo_rol = convert(varchar,ro_rol),
       @w_nombre_rol = ro_descripcion
from   cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'

insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_tabla, @w_codigo_rol, @w_nombre_rol, 'V')
go

use cobis
go

delete cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cl_cuenta_dispersion_lcr')
delete cl_tabla WHERE tabla = 'cl_cuenta_dispersion_lcr'

SELECT @w_tabla = max(isnull(codigo,0)) +1
FROM cl_tabla 

INSERT INTO cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'cl_cuenta_dispersion_lcr', 'Cuenta Dispersi�n LCR')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'CL', 'Cliente', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'CO', 'Colectivo', 'V', NULL, NULL, NULL)

declare @w_tabla int
select @w_tabla = codigo from cobis..cl_tabla where tabla = 'cre_des_riesgo'

delete from cl_catalogo where codigo in ('012','013','014') and tabla = @w_tabla

insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'012','No. Contrapartes','V')

insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'013','Canal de contrataci�n','V')

insert into cl_catalogo (tabla, codigo, valor, estado)
values(@w_tabla,'014','F. Nacimiento / Constituci�n','V')
go
go

use cobis
go

delete cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cr_plazo_grp')
delete cl_tabla WHERE tabla = 'cr_plazo_grp'

SELECT @w_tabla = max(isnull(codigo,0)) +1
FROM cl_tabla 

INSERT INTO cl_tabla (codigo, tabla, descripcion) VALUES (@w_tabla, 'cr_plazo_grp', 'PLAZO GRUPAL')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '16', '16', 'V', NULL, NULL, NULL)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '20', '20', 'V', NULL, NULL, NULL)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '24', '24', 'V', NULL, NULL, NULL)

delete cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cr_gracia_grp')
delete cl_tabla WHERE tabla = 'cr_gracia_grp'


SELECT @w_tabla = max(isnull(codigo,0)) +1
FROM cl_tabla

INSERT INTO cl_tabla (codigo, tabla, descripcion) VALUES (@w_tabla, 'cr_gracia_grp', 'GRACIA GRUPAL')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '0', '0', 'V', NULL, NULL, NULL)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '2', '2', 'V', NULL, NULL, NULL)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '4', '4', 'V', NULL, NULL, NULL)


----------------------------------------------------------------
-- CATALOGO DE ROLES PARA PERMITIR SOLICITUD MODIFICACION DATOS
----------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'CREDITO'

select @w_nom_tabla = 'cr_rol_sol_mod_dat'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'ROLES SOLICITUD MODIFICACION DATOS')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'12','ASESOR','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'10','FUNCIONARIO OFICINA','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'20','COORDINADOR','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'32','GERENTE OFICINA','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'29','MESA DE OPERACIONES','V')

----------------------------------------------------------------
-- Actividad biometrica despues de garantia
----------------------------------------------------------------
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla (codigo, tabla, descripcion) values (@w_tabla, 'cr_activ_desp_gar_liq', 'Act Despues de Garantia Liquida Por Flujos')
insert into cl_catalogo_pro (cp_producto, cp_tabla) values ('ADM', @w_tabla)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'GRUPAL', '9', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'REVOLVENTE', '9', 'V', NULL, NULL, NULL)
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_tabla, 'INDIVIDUAL', '9', 'V', NULL, NULL, NULL)
go



----------------------------------------------------------------
------ Para texto en contratos
----------------------------------------------------------------
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_txt_documento', 'Texto Para Documentos') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GPNCT01','CRÉDITO GRUPAL','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GPSCT01','TU CRÉDIITO ANÍMATE','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'RIXCT01','CRÉDITO INDIVIDUAL “TU CRÉDITO AL CLIC”','V')

--FIN
update cobis..cl_seqnos
   set siguiente = @w_tabla
 where tabla = 'cl_tabla'
go


----------------------------------------------------------------
-- CATALOGO DE ETAPAS QUE PUEDEN CONSULTAR A BURO
----------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'CREDITO'

select @w_nom_tabla = 'cr_etapa_si_cons_buro'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'ETAPAS QUE PUEDEN CONSULTAR A BURO')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'5','INGRESAR SOLICITUD','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go

----------------------------------------------------------------
-- CATALOGO VARIABLE BURO
----------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'CREDITO'

select @w_nom_tabla = 'cr_buro'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'BURO')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'V','V','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'W','W','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'K','K','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'M','M','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go


-----------------------------------------------------------------------------------
-- CATALOGO DE EXCLUSIÓN SCORE BURO - Req.203112 - OT Modelo Aceptación Grupal, BC
-----------------------------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'ADMINISTRACION'

select @w_nom_tabla = 'cr_exclusion_score_buro'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'CODIGOS DE EXCLUSION SCORE BURO HISTORICO PETICION 017')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'-001','Consumidor Fallecido','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'-005','Expediente con todas las cuentas cerradas','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'-006','Cuentas antiguas menor a 6 meses y al menos una tiene MOP >= 03','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'-007','Cuentas antiguas menor a 6 meses y al menos una tiene MOP >= 02','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'-008','Sin cuenta actualizada y/o  incluida en el cálculo del BC-Score','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'-009','Expediente sin cuentas para cálculo de BC-Score','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go


-----------------------------------------------------------------------------------
-- CATALOGO DE RAZÓN SCORE BURO - Req.203112 - OT Modelo Aceptación Grupal, BC
-----------------------------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'ADMINISTRACION'

select @w_nom_tabla = 'cr_razon_score_buro'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'CODIGOS DE RAZON SCORE BURO HISTORICO PETICION 017')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'700','Cliente con antecedente de mora.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'701','Cliente con poco historial de crédito.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'702','Alto número de cuentas.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'703','Alta utilización.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'704','Cuentas con saldo vencido.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'705','Alto número de consultas.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'706','Alto número de cuentas con saldo mayor a cero.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'707','Porcentaje alto de cuentas sin información de utilización.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'708','Alta utilización.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'709','Sin créditos activos.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'710','Alta morosidad reportada.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'711','Capacidad de enfrentar una deuda volátil.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'712','Montos a pagar crecientes.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'713','Saldo vencido creciente.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'714','Aceleración en saldo actual.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'715','Aceleración en utilización.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'716','Altas y fluctuosas variaciones en motos a pagar.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'717','Altas y fluctuosas variaciones en exposición.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'718','Alta variabilidad en saldos.','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'719','Alta variabilidad en montos a pagar.','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go


-----------------------------------------------------------------------------------
-- CATALOGO DE ERROR SCORE BURO - Req.203112 - OT Modelo Aceptación Grupal, BC
-----------------------------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'ADMINISTRACION'

select @w_nom_tabla = 'cr_error_score_buro'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'CODIGOS DE ERROR SCORE BURO HISTORICO PETICION 017')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'01','Solicitud No Autorizada','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'02','Solicitud de Score inválida','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'03','Score No Disponible','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go


-----------------------------------------------------------------------------------
-- CATALOGO RIESGO 2 - Req.203112 - OT Modelo Aceptación Grupal, BC
-----------------------------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'ADMINISTRACION'

select @w_nom_tabla = 'cr_calif_riesgo_2_score'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'CALIFICACION DE RIESGO 2 (SCORE)')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'MB','Muy Bajo','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'B','Bajo','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'M','Medio','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'A','Alto','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'MA','Muy Alto','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'CE','Rechazo Código Exclusión','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'SE','Sin experiencia, sin cálculo Score','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'LN','Listas Negras','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go


-----------------------------------------------------------------------------------
-- CATALOGO TIPO DE CALIFICACION - Req.203112 - OT Modelo Aceptación Grupal, BC
-----------------------------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'ADMINISTRACION'

select @w_nom_tabla = 'cr_tipo_calif_cliente'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'TIPOS DE CALIFICACION PARA EVALUACION DEL CLIENTE')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'EA009','Evaluación Antigua','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'EN017','Evaluación Nueva','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go


--------------------------------------------------------------------------------------
-- CATALOGO COLORES CALIFICACION FINAL - Req.203112 - OT Modelo Aceptación Grupal, BC
--------------------------------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'CREDITO'

select @w_nom_tabla = 'cr_color_calif_final'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'COLORES CALIFICACION FINAL')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'VERDE','VERDE','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'AMARILLO','AMARILLO','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'ROJO','ROJO','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go


--------------------------------------------------------------------------------------
-- CATALOGO LETRAS CALIFICACION FINAL - Req.203112 - OT Modelo Aceptación Grupal, BC
--------------------------------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'CREDITO'

select @w_nom_tabla = 'cr_letra_calif_final'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'LETRAS CALIFICACION FINAL')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'A','A','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'D','D','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'F','F','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go


----------------------------------------------------------------
-- CATALOGO VARIABLE NUMERO DE PAGOS
----------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'CREDITO'

select @w_nom_tabla = 'cr_numero_pagos'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'NUMERO DE PAGOS')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'8','8','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'12','12','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'16','16','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'24','24','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go

-----------***********-----------***********-----------***********
-- Caso#200142 AplicaciOn Cuestionario
-----------***********-----------***********-----------***********
-- CATALOGOS ACTIVIDADES CUESITONARIO
use cobis
go

declare @w_id_tabla int, @w_tabla char(30)
select  @w_tabla = 'cr_act_cuestionario'

select @w_id_tabla = codigo from cl_tabla where tabla = @w_tabla

if ( @w_id_tabla is null) begin
    select @w_id_tabla = max(codigo) + 1 from cl_tabla
	insert into cl_tabla (codigo, tabla, descripcion) values (@w_id_tabla, @w_tabla, 'Codigos de Actividades Cuestionarios por Producto')
	
	update cobis..cl_seqnos
	set siguiente = @w_id_tabla
	where tabla = 'cl_tabla'
	and bdatos = 'cobis'

    insert into cl_catalogo_pro (cp_producto, cp_tabla) values ('ADM', @w_id_tabla)
    insert into cl_catalogo_pro (cp_producto, cp_tabla) values ('CRE', @w_id_tabla)
    
    --select * from cob_workflow..wf_actividad where upper(ac_nombre_actividad) like '%CUESTIONAR%'
    --Se agrega la descripcion porque es un valor que puede ser visualizado por pantalla.
    --GRUPAL es tambien para RENOVACION ya que en la sincronizacion los dos son tratados igual.
    insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_id_tabla, 'GRUPAL', 'APLICAR CUESTIONARIO - GRUPAL', 'V', NULL, NULL, NULL)
    insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) values (@w_id_tabla, 'INDIVIDUAL', 'APLICAR CUESTIONARIO - INDIVID', 'V', NULL, NULL, NULL)
end
go
-----------***********-----------***********-----------***********
