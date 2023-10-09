/************************************************************************/
/*	Archivo:		ad_dropp.sql				*/
/*	Base de datos:		cobis					*/
/*	Producto:		Admin					*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	'MACOSA', representantes exclusivos para el Ecuador de la 	*/
/*	'NCR CORPORATION'.						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este script elimina los índices sobre clave primaria del ADMIN	*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*  13-04-2016  BBO         Migracion Sybase-SQL FAL                    */
/************************************************************************/

use cobis
go


print '=====>ad_server_logico.ad_server_producto'
go 
if exists (select name from sysindexes where name='ad_server_producto')
drop index ad_server_logico.ad_server_producto
go

print '=====>cl_funcionario.cl_login_Key_ad'
go
if exists (select name from sysindexes where name='cl_login_Key_ad')
drop index cl_funcionario.cl_login_Key_ad
go

print '=====>ad_link.ad_link_Key'
go
if exists (select name from sysindexes where name='ad_link_Key')
drop index ad_link.ad_link_Key
go

print '=====>ad_x25_config.ad_x25_config_Key'
go
if exists (select name from sysindexes where name='ad_x25_config_Key')
drop index ad_x25_config.ad_x25_config_Key
go

print '=====>ad_base_datos.ad_base_datos_Key'
go
if exists (select name from sysindexes where name='ad_base_datos_Key')
drop index ad_base_datos.ad_base_datos_Key
go

print '=====>ad_horario.ad_horario_Key'
go
if exists (select name from sysindexes where name='ad_horario_Key')
drop index ad_horario.ad_horario_Key
go

print '=====>ad_horario_tmp.ad_conexion_h_Key'
go
if exists (select name from sysindexes where name='ad_conexion_h_Key')
drop index ad_horario_tmp.ad_conexion_h_Key
go

print '=====>ad_interface.ad_interface_Key'
go
if exists (select name from sysindexes where name='ad_interface_Key')
drop index ad_interface.ad_interface_Key
go

print '=====>ad_link.ad_link_Key'
go
if exists (select name from sysindexes where name='ad_link_Ke')
drop index ad_link.ad_link_Key
go

print '=====>ad_nodo.ad_nodo_Key'
go
if exists (select name from sysindexes where name='ad_nodo_Key')
drop index ad_nodo.ad_nodo_Key
go

print '=====>ad_nodo_oficina.ad_nodo_oficina_Key'
go
if exists (select name from sysindexes where name='ad_nodo_oficina_Key')
drop index ad_nodo_oficina.ad_nodo_oficina_Key
go

print '=====>ad_procedure.ad_procedure_Key'
go
if exists (select name from sysindexes where name='ad_procedure_Key')
drop index ad_procedure.ad_procedure_Key
go

print '=====>ad_pro_rol.ad_pro_rol_Key'
go
if exists (select name from sysindexes where name='ad_pro_rol_Key')
drop index ad_pro_rol.ad_pro_rol_Key
go

print '=====>ad_protocolo.ad_protocolo_Key'
go
if exists (select name from sysindexes where name='ad_protocolo_Key')
drop index ad_protocolo.ad_protocolo_Key
go

print '=====>ad_pro_transaccion.ad_pro_transaccion_Key'
go
if exists (select name from sysindexes where name='ad_pro_transaccion_Key')
drop index ad_pro_transaccion.ad_pro_transaccion_Key
go

print '=====>ad_rol.ad_rol_Key'
go
if exists (select name from sysindexes where name='ad_rol_Key')
drop index ad_rol.ad_rol_Key
go

print '=====>ad_ruta.ad_ruta_Key'
go
if exists (select name from sysindexes where name='ad_ruta_Key')
drop index ad_ruta.ad_ruta_Key
go

print '=====>ad_server_logico.ad_server_logico_Key'
go
if exists (select name from sysindexes where name='ad_server_logico_Key')
drop index ad_server_logico.ad_server_logico_Key
go

print '=====>ad_sis_operativo.ad_sis_operativo_Key'
go
if exists (select name from sysindexes where name='ad_sis_operativo_Key')
drop index ad_sis_operativo.ad_sis_operativo_Key
go

print '=====>ad_terminal.ad_terminal_Key1'
go
if exists (select name from sysindexes where name='ad_terminal_Key1')
drop index ad_terminal.ad_terminal_Key1
go

print '=====>ad_terminal.ad_terminal_Key2'
go
if exists (select name from sysindexes where name='ad_terminal_Key2')
drop index ad_terminal.ad_terminal_Key2
go

print '=====>ad_tipo_horario_Key'
go
if exists (select name from sysindexes where name='ad_tipo_horario_Key')
drop index ad_tipo_horario.ad_tipo_horario_Key
go

print '=====>ad_tipo_horario_tmp.ad_conexion_th_Key'
go
if exists (select name from sysindexes where name='ad_conexion_th_Key')
drop index ad_tipo_horario_tmp.ad_conexion_th_Key
go

print '=====>ad_tlink.ad_tlink_Key'
go
if exists (select name from sysindexes where name='ad_tlink_Key')
drop index ad_tlink.ad_tlink_Key
go

print '=====>ad_tr_autorizada.ad_tr_autorizada_Key'
go
if exists (select name from sysindexes where name='ad_tr_autorizada_Key')
drop index ad_tr_autorizada.ad_tr_autorizada_Key
go

print '=====>ad_usuario.ad_usuario_Key'
go
if exists (select name from sysindexes where name='ad_usuario_Key')
drop index ad_usuario.ad_usuario_Key
go

print '=====>ad_usuario_rol.ad_usuario_rol_Key'
go
if exists (select name from sysindexes where name='ad_usuario_rol_Key')
drop index ad_usuario_rol.ad_usuario_rol_Key
go


print '=====>ad_vigencia.ad_vigencia_Key'
go
if exists (select name from sysindexes where name='ad_vigencia_Key')
drop index ad_vigencia.ad_vigencia_Key
go

print '=====>ad_vistas_trnser.ad_vistas_trnser_key'
go
if exists (select name from sysindexes where name='ad_vistas_trnser_key')
drop index ad_vistas_trnser.ad_vistas_trnser_key
go

print '=====>cl_tabla.cl_tabla_Key'
go
if exists (select name from sysindexes where name='cl_tabla_Key')
drop index cl_tabla.cl_tabla_Key
go

print '=====>cl_catalogo.cl_catalogo_Key'
go
if exists (select name from sysindexes where name='cl_catalogo_Key')
drop index cl_catalogo.cl_catalogo_Key
go

print '=====>cl_catalogo_pro.cl_catalogo_pro_Key'
go
if exists (select name from sysindexes where name='cl_catalogo_pro_Key')
drop index cl_catalogo_pro.cl_catalogo_pro_Key
go

print '=====>cl_ciudad.cl_ciudad_Key'
go
if exists (select name from sysindexes where name='cl_ciudad_Key')
drop index cl_ciudad.cl_ciudad_Key
go

print '=====>cl_dias_laborables.cl_dias_laborables_Key'
go
if exists (select name from sysindexes where name='cl_dias_laborables_Key')
drop index cl_dias_laborables.cl_dias_laborables_Key
go

print '=====>cl_dias_feriados.cl_dias_feriados_Key'
go
if exists (select name from sysindexes where name='cl_dias_feriados_Key')
drop index cl_dias_feriados.cl_dias_feriados_Key
go

print '=====>cl_parametro.cl_parametro_Key'
go
if exists (select name from sysindexes where name='cl_parametro_Key')
drop index cl_parametro.cl_parametro_Key
go

print '=====>cl_departamento.cl_departamento_Key'
go
if exists (select name from sysindexes where name='cl_departamento_Key')
drop index cl_departamento.cl_departamento_Key
go

print '=====>cl_default_tr.cl_default_tr_Key'
go
if exists (select name from sysindexes where name='cl_default_tr_Key')
drop index cl_default_tr.cl_default_tr_Key
go

print '=====>ad_ambito.ad_ambito_Key'
go
if exists (select name from sysindexes where name='ad_ambito_Key')
drop index ad_ambito.ad_ambito_Key
go

print '=====>cl_dis_seqnos.cl_dis_seqnos_Key'
go
if exists (select name from sysindexes where name='cl_dis_seqnos_Key')
drop index cl_dis_seqnos.cl_dis_seqnos_Key
go

print '=====>cl_distributivo.cl_distributivo_Key'
go
if exists (select name from sysindexes where name='cl_distributivo_Key')
drop index cl_distributivo.cl_distributivo_Key
go

print '=====>cl_filial.cl_filial_Key'
go
if exists (select name from sysindexes where name='cl_filial_Key')
drop index cl_filial.cl_filial_Key
go

print '=====>cl_funcionario.cl_funcionario_Key'
go
if exists (select name from sysindexes where name='cl_funcionario_Key')
drop index cl_funcionario.cl_funcionario_Key
go

print '=====>cl_oficina.cl_oficina_Key'
go
if exists (select name from sysindexes where name='cl_oficina_Key')
drop index cl_oficina.cl_oficina_Key
go

print '=====>cl_moneda.cl_moneda_Key'
go
if exists (select name from sysindexes where name='cl_moneda_Key')
drop index cl_moneda.cl_moneda_Key
go

print '=====>cl_pais.cl_pais_Key'
go
if exists (select name from sysindexes where name='cl_pais_Key')
drop index cl_pais.cl_pais_Key
go

print '=====>cl_parroquia.cl_parroquia_Key'
go
if exists (select name from sysindexes where name='cl_parroquia_Key')
drop index cl_parroquia.cl_parroquia_Key
go

print '=====>cl_pro_asociado.cl_pro_asociado_Key'
go
if exists (select name from sysindexes where name='cl_pro_asociado_Key')
drop index cl_pro_asociado.cl_pro_asociado_Key
go

print '=====>cl_pro_oficina.cl_pro_oficina_Key'
go
if exists (select name from sysindexes where name='cl_pro_oficina_Key')
drop index cl_pro_oficina.cl_pro_oficina_Key
go

print '=====>cl_pro_moneda.cl_pro_moneda_Key'
go
if exists (select name from sysindexes where name='cl_pro_moneda_Key')
drop index cl_pro_moneda.cl_pro_moneda_Key
go

print '=====>cl_producto.cl_producto_Key'
go
if exists (select name from sysindexes where name='cl_producto_Key')
drop index cl_producto.cl_producto_Key
go

print '=====>cl_provincia.cl_provincia_Key'
go
if exists (select name from sysindexes where name='cl_provincia_Key')
drop index cl_provincia.cl_provincia_Key
go

print '=====>cl_seqnos_Key'
go
if exists (select name from sysindexes where name='cl_seqnos_Key')
drop index cl_seqnos.cl_seqnos_Key
go

print '=====>cl_errores_Key'
--go
--if exists (select name from sysindexes where name='cl_errores_Key')
--drop index cl_errores.cl_errores_Key
--go

print '=====>cl_suc_correo_Key'
go
if exists (select name from sysindexes where name='cl_suc_correo_Key')
drop index cl_suc_correo.cl_suc_correo_Key
go

print '=====>cl_ttransaccion_Key'
go
if exists (select name from sysindexes where name='cl_ttransaccion_Key')
drop index cl_ttransaccion.cl_ttransaccion_Key
go

print '=====> oficial_Key'
go
if exists (select name from sysindexes where name='oficial_Key')
drop index cc_oficial.oficial_Key
go

print '=====> cl_medios_depar_KEY'
go
if exists (select name from sysindexes where name='cl_medios_depar_KEY')
drop index cl_medios_depar.cl_medios_depar_KEY
go


print '=====> cl_medios_funcio_KEY'
go
if exists (select name from sysindexes where name='cl_medios_funcio_KEY')
drop index cl_medios_funcio.cl_medios_funcio_KEY
go

print '=====> cl_medios_ofi_KEY'
go
if exists (select name from sysindexes where name='cl_medios_ofi_KEY')
drop index cl_medios_ofi.cl_medios_ofi_KEY
go


/**************** TASAS REFERENCIALES ***************/
/* ARO: 4 de Julio  del 2000 */

print '=====> te_tasas_referenciales_Key'
go
if exists (select name from sysindexes where name='te_tasas_referenciales_Key')
   drop index te_tasas_referenciales.te_tasas_referenciales_Key
go


print '=====> te_caracteristicas_tasa_Key'
go
if exists (select name from sysindexes where name='te_caracteristicas_tasa_Key')
   drop index te_caracteristicas_tasa.te_caracteristicas_tasa_Key
go


print '=====> te_pizarra_Key'
go
if exists (select name from sysindexes where name='te_pizarra_Key')
   drop index te_pizarra.te_pizarra_Key
go


print '=====> te_tasa_coap_Key'
go
if exists (select name from sysindexes where name='te_tasa_coap_Key')
   drop index te_tasa_coap.te_tasa_coap_Key
go


print '=====> te_tasa_divisas_Key'
go
if exists (select name from sysindexes where name='te_tasa_divisas_Key')
   drop index te_tasa_divisas.te_tasa_divisas_Key
go

print '=====> te_divisa_futura_Key  '
go
if exists (select name from sysindexes where name='te_divisa_futura_Key')
   drop index te_divisa_futura.te_divisa_futura_Key
go


print '=====> te_relacion_dolar_Key '
go
if exists (select name from sysindexes where name='te_relacion_dolar_Key')
   drop index te_relacion_dolar.te_relacion_dolar_Key
go

/************* FIN DE TASAS REGERENCIALES ***********/

/******* MANEJO DE PASSWORDS ***********/

print '=====> cl_clave_his_KEY '
go
if exists (select name from sysindexes where name='cl_clave_his_KEY')
   drop index cl_clave_his.cl_clave_his_KEY
go
/******* FIN MANEJO DE PASSWORDS ***********/


/********* ADMIN WEB ************/

print '=====> aw_funcionalidad_KEY'
go
if exists (select name from sysindexes where name='aw_funcionalidad_KEY')
   drop index aw_funcionalidad.aw_funcionalidad_KEY
go

print '=====> aw_etiqueta_funcionalidad_KEY'
go
if exists (select name from sysindexes where name='aw_etiqueta_funcionalidad_KEY')
   drop index aw_etiqueta_funcionalidad.aw_etiqueta_funcionalidad_KEY
go

print '=====> aw_ayuda_funcionalidad_KEY'
go
if exists (select name from sysindexes where name='aw_ayuda_funcionalidad_KEY')
   drop index aw_ayuda_funcionalidad.aw_ayuda_funcionalidad_KEY
go


print '=====> aw_tr_func_KEY'
go
if exists (select name from sysindexes where name='aw_tr_func_KEY')
   drop index aw_tr_func.aw_tr_func_KEY
go

print '=====> aw_func_rol_KEY'
go
if exists (select name from sysindexes where name='aw_func_rol_KEY')
   drop index aw_func_rol.aw_func_rol_KEY
go

print '=====> aw_herramienta_KEY'
go
if exists (select name from sysindexes where name='aw_herramienta_KEY')
   drop index aw_herramienta.aw_herramienta_KEY
go

print '=====> aw_nombre_herramienta_KEY'
go
if exists (select name from sysindexes where name='aw_nombre_herramienta_KEY')
   drop index aw_nombre_herramienta.aw_nombre_herramienta_KEY
go

print '=====> aw_ayuda_herramienta_KEY'
go
if exists (select name from sysindexes where name='aw_ayuda_herramienta_KEY')
   drop index aw_ayuda_herramienta.aw_ayuda_herramienta_KEY
go

print '=====> aw_herr_rol_KEY'
go
if exists (select name from sysindexes where name='aw_herr_rol_KEY')
   drop index aw_herr_rol.aw_herr_rol_KEY
go

print '=====> aw_contexto_KEY'
go
if exists (select name from sysindexes where name='aw_contexto_KEY')
   drop index aw_contexto.aw_contexto_KEY
go

print '=====> aw_ayuda_contexto_KEY'
go
if exists (select name from sysindexes where name='aw_ayuda_contexto_KEY')
   drop index aw_ayuda_contexto.aw_ayuda_contexto_KEY
go

print '=====> aw_nombre_contexto_KEY'
go
if exists (select name from sysindexes where name='aw_nombre_contexto_KEY')
   drop index aw_nombre_contexto.aw_nombre_contexto_KEY
go

print '=====> aw_contexto_func_KEY'
go
if exists (select name from sysindexes where name='aw_contexto_func_KEY')
   drop index aw_contexto_func.aw_contexto_func_KEY
go

print '=====> aw_prereq_func_KEY'
go
if exists (select name from sysindexes where name='aw_prereq_func_KEY')
   drop index aw_prereq_func.aw_prereq_func_KEY
go

/********* FIN ADMIN WEB ************/

/********* NUEVO BATCH ***************/
print '=====> ba_operador_KEY'
go
if exists (select name from sysindexes where name='ba_operador_KEY')
   drop index ba_operador.ba_operador_KEY
go

print '=====> ba_log_operador_KEY'
go
if exists (select name from sysindexes where name='ba_log_operador_KEY')
   drop index ba_log_operador.ba_log_operador_KEY
go

/*******FIN NUEVO BATCH****************/

-------------------------- Proyecto HSBC ------------------------
print '=====> ad_error_batch_key'
go
if exists (select name from sysindexes where name='ad_error_batch_key')
   drop index ad_error_batch.ad_error_batch_key
go

print '=====> ad_nodo_reentry_tmp_spid_idx'
go

if exists (select name from sysindexes where name='ad_nodo_reentry_tmp_spid_idx')
   drop index ad_nodo_reentry_tmp_tbl.ad_nodo_reentry_tmp_spid_idx
go

-- Tabla de catálogo de tablas EX para la extracción de datos ETL
print '=====> cat_ex_table_Key'
go
if exists (select name from sysindexes where name='cat_ex_table_Key')
   drop index cat_ex_table.cat_ex_table_Key
go

-- Tabla de cuadre extracción de datos ETL
print '=====> etl_cuadre_extraccion_cobis_pk'
go
if exists (select name from sysindexes where name='etl_cuadre_extraccion_cobis_pk')
   drop index etl_cuadre_extraccion_cobis.etl_cuadre_extraccion_cobis_pk
go


print '=====> ad_acceso_func_cen_KEY'
go
if exists (select name from sysindexes where name='ad_acceso_func_cen_KEY')
   drop index ad_acceso_func_cen.ad_acceso_func_cen_KEY
go


print '=====> cl_barrio_key'
go
if exists (select name from sysindexes where name='cl_barrio_key')
   drop index cl_barrio.cl_barrio_key
go

print '=====>cl_depart_pais.cl_depart_pais_Key'
go
if exists (select name from sysindexes where name='cl_depart_pais_Key')
drop index cl_depart_pais.cl_depart_pais_Key
go

print '=====>cl_ofic_servicio_pk'
go
if exists (select name from sysindexes where name='cl_ofic_servicio_pk')
   drop index cl_ofic_servicio.cl_ofic_servicio_pk
go

print '=====>cl_ofic_func.cl_ofic_func_pk'
go
if exists (select name from sysindexes where name='cl_ofic_func_pk')
drop index cl_ofic_func.cl_ofic_func_pk
go

print '=====>cl_canton.cl_canton_Key'
go
if exists (select name from sysindexes where name='cl_canton_Key')
drop index cl_canton.cl_canton_Key
go

print '=====>cl_municipio.cl_municipio_pk'
go
if exists (select name from sysindexes where name='cl_municipio_pk')
drop index cl_municipio.cl_municipio_pk
go

print '=====>cl_ofic_func_rol_key'
go
if exists (select name from sysindexes where name='cl_ofic_func_rol_key')
drop index cl_ofic_func_rol.cl_ofic_func_rol_key
go
