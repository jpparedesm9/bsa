/************************************************************************/
/*	Archivo:		ad_dropt.sql				*/
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
/*	Este script elimina las tablas del ADMIN			*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cobis
go

/* ad_base_datos */
print '=====> ad_base_datos'
if exists ( select * from sysobjects where name = 'ad_base_datos' )
	drop TABLE ad_base_datos
go

/* ad_horario */
print '=====> ad_horario'
if exists ( select * from sysobjects where name = 'ad_horario' )
	drop TABLE ad_horario
go

/* ad_horario_tmp */
print '=====> ad_horario_tmp'
if exists ( select * from sysobjects where name = 'ad_horario_tmp' )
	drop TABLE ad_horario_tmp
go

/* ad_interface */
print '=====> ad_interface'
if exists ( select * from sysobjects where name = 'ad_interface' )
	drop TABLE ad_interface
go

/* ad_tipo_horario */
print '=====> ad_tipo_horario'
if exists ( select * from sysobjects where name = 'ad_tipo_horario' )
	drop TABLE ad_tipo_horario
go

/* ad_tipo_horario_tmp */
print '=====> ad_tipo_horario_tmp'
if exists ( select * from sysobjects where name = 'ad_tipo_horario_tmp' )
	drop TABLE ad_tipo_horario_tmp
go

/* ad_x25 */
print '=====> ad_x25'
if exists ( select * from sysobjects where name = 'ad_x25' )
	drop VIEW ad_x25
go

/* ad_tcpip */
print '=====> ad_tcpip'
if exists ( select * from sysobjects where name = 'ad_tcpip' )
	drop VIEW ad_tcpip
go

/* ad_link */
print '=====> ad_link'
if exists ( select * from sysobjects where name = 'ad_link' )
	drop TABLE ad_link
go

/* ad_nodo */
print '=====> ad_nodo'
if exists ( select * from sysobjects where name = 'ad_nodo' )
	drop TABLE ad_nodo
go

/* ad_nodo_oficina */
print '=====> ad_nodo_oficina'
if exists ( select * from sysobjects where name = 'ad_nodo_oficina' )
	drop TABLE ad_nodo_oficina
go

/* ad_pro_instalado */
print '=====> ad_pro_instalado'
if exists ( select * from sysobjects where name = 'ad_pro_instalado' )
	drop TABLE ad_pro_instalado
go

/* ad_pro_rol */
print '=====> ad_pro_rol'
if exists ( select * from sysobjects where name = 'ad_pro_rol' )
	drop TABLE ad_pro_rol
go

/* ad_procedure */
print '=====> ad_procedure'
if exists ( select * from sysobjects where name = 'ad_procedure' )
	drop TABLE ad_procedure
go

/* ad_protocolo */
print '=====> ad_protocolo'
if exists ( select * from sysobjects where name = 'ad_protocolo' )
	drop TABLE ad_protocolo
go

/* ad_pro_transaccion */
print '=====> ad_pro_transaccion'
if exists ( select * from sysobjects where name = 'ad_pro_transaccion' )
	drop TABLE ad_pro_transaccion
go

/* ad_rol */
print '=====> ad_rol'
if exists ( select * from sysobjects where name = 'ad_rol' )
	drop TABLE ad_rol
go

/* ad_ruta */
print '=====> ad_ruta'
if exists ( select * from sysobjects where name = 'ad_ruta' )
	drop TABLE ad_ruta
go

/* ad_directa */
print '=====> ad_directa'
if exists ( select * from sysobjects where name = 'ad_directa' )
	drop VIEW ad_directa
go

/* ad_indirecta */
print '=====> ad_indirecta'
if exists ( select * from sysobjects where name = 'ad_indirecta' )
	drop VIEW ad_indirecta
go

/* ad_server_logico */
print '=====> ad_server_logico'
if exists ( select * from sysobjects where name = 'ad_server_logico' )
	drop TABLE ad_server_logico
go

/* ad_sis_operativo */
print '=====> ad_sis_operativo'
if exists ( select * from sysobjects where name = 'ad_sis_operativo' )
	drop TABLE ad_sis_operativo
go

/* ad_terminal */
print '=====> ad_terminal'
if exists ( select * from sysobjects where name = 'ad_terminal' )
	drop TABLE ad_terminal
go

/* ad_tlink */
print '=====> ad_tlink'
if exists ( select * from sysobjects where name = 'ad_tlink' )
	drop TABLE ad_tlink
go

/* ad_tr_autorizada */
print '=====> ad_tr_autorizada'
if exists ( select * from sysobjects where name = 'ad_tr_autorizada' )
	drop TABLE ad_tr_autorizada
go

/* ad_usuario */
print '=====> ad_usuario'
if exists ( select * from sysobjects where name = 'ad_usuario' )
	drop TABLE ad_usuario
go

/* ad_usuario_rol */
print '=====> ad_usuario_rol'
if exists ( select * from sysobjects where name = 'ad_usuario_rol' )
	drop TABLE ad_usuario_rol
go

/* ad_vigencia */
print '=====> ad_vigencia'
if exists ( select * from sysobjects where name = 'ad_vigencia' )
	drop TABLE ad_vigencia
go

/* ad_x25_config */
print '=====> ad_x25_config'
if exists ( select * from sysobjects where name = 'ad_x25_config' )
	drop TABLE ad_x25_config
go

/* ad_nivel*/
print '=====> ad_nivel'
if exists ( select * from sysobjects where name = 'ad_nivel' )
	drop TABLE ad_nivel
go

/* ad_mapa */
print '=====> ad_mapa'
if exists ( select * from sysobjects where name = 'ad_mapa' )
	drop TABLE ad_mapa
go

/* ad_nivel_mapa */
print '=====> ad_nivel_mapa'
if exists ( select * from sysobjects where name = 'ad_nivel_mapa' )
	drop TABLE ad_nivel_mapa
go

/* ad_icono */
print '=====> ad_icono'
if exists ( select * from sysobjects where name = 'ad_icono' )
	drop TABLE ad_icono
go

/* ad_nodo_nivel */
print '=====> ad_nodo_nivel'
if exists ( select * from sysobjects where name = 'ad_nodo_nivel' )
	drop TABLE ad_nodo_nivel
go

/* ad_catalogo_icono */
print '=====> ad_catalogo_icono'
if exists ( select * from sysobjects where name = 'ad_catalogo_icono' )
	drop TABLE ad_catalogo_icono
go

/* cl_catalogo */
print '=====> cl_catalogo'
if exists ( select * from sysobjects where name = 'cl_catalogo' )
	drop TABLE cl_catalogo
go

/* ad_vistas_trnser */
print '=====> ad_vistas_trnser'
if exists (select * from sysobjects where name = 'ad_vistas_trnser')
    DROP TABLE ad_vistas_trnser
go





/* cl_catalogo_pro */
print '=====> cl_catalogo_pro'
if exists ( select * from sysobjects where name = 'cl_catalogo_pro' )
	drop TABLE cl_catalogo_pro
go

/* cl_ciudad */
print '=====> cl_ciudad'
if exists ( select * from sysobjects where name = 'cl_ciudad' )
	drop TABLE cl_ciudad
go

/* cl_departamento */
print '=====> cl_departamento'
if exists ( select * from sysobjects where name = 'cl_departamento' )
	drop TABLE cl_departamento
go

/* cl_departamento_tmp */
print '=====> cl_departamento_tmp'
if exists ( select * from sysobjects where name = 'cl_departamento_tmp' )
	drop TABLE cl_departamento_tmp
go

/* cl_dias_feriados */
print '=====> cl_dias_feriados'
if exists ( select * from sysobjects where name = 'cl_dias_feriados' )
	drop TABLE cl_dias_feriados
go

/* cl_dis_seqnos */
print '=====> cl_dis_seqnos'
if exists ( select * from sysobjects where name = 'cl_dis_seqnos' )
	drop TABLE cl_dis_seqnos
go

/* cl_distributivo */
print '=====> cl_distributivo'
if exists ( select * from sysobjects where name = 'cl_distributivo' )
	drop TABLE cl_distributivo
go

/* cl_filial */
print '=====> cl_filial'
if exists ( select * from sysobjects where name = 'cl_filial' )
	drop TABLE cl_filial
go

/* cl_funcionario */
print '=====> cl_funcionario'
if exists ( select * from sysobjects where name = 'cl_funcionario' )
	drop TABLE cl_funcionario
go

/* cl_oficina */
print '=====> cl_oficina'
if exists ( select * from sysobjects where name = 'cl_oficina' )
	drop TABLE cl_oficina
go

/* cl_det_oficina */
print '=====> cl_det_oficina'
if exists ( select * from sysobjects where name = 'cl_det_oficina' )
	drop TABLE cl_det_oficina
go

/* cl_sucursal */
print '=====> cl_sucursal'
if exists ( select * from sysobjects where name = 'cl_sucursal' )
	drop VIEW cl_sucursal
go

/* cl_agencia */
print '=====> cl_agencia'
if exists ( select * from sysobjects where name = 'cl_agencia' )
	drop VIEW cl_agencia
go

/* cl_moneda */
print '=====> cl_moneda'
if exists ( select * from sysobjects where name = 'cl_moneda' )
	drop TABLE cl_moneda
go

/* cl_pais */
print '=====> cl_pais'
if exists ( select * from sysobjects where name = 'cl_pais' )
	drop TABLE cl_pais
go

/* cl_parametro */
print '=====> cl_parametro'
if exists ( select * from sysobjects where name = 'cl_parametro' )
	drop TABLE cl_parametro
go

/* cl_parroquia */
print '=====> cl_parroquia'
if exists ( select * from sysobjects where name = 'cl_parroquia' )
	drop TABLE cl_parroquia
go

/* cl_pro_asociado */
print '=====> cl_pro_asociado'
if exists ( select * from sysobjects where name = 'cl_pro_asociado' )
	drop TABLE cl_pro_asociado
go

/* cl_pro_oficina */
print '=====> cl_pro_oficina'
if exists ( select * from sysobjects where name = 'cl_pro_oficina' )
	drop TABLE cl_pro_oficina
go

/* cl_pro_moneda */
print '=====> cl_pro_moneda'
if exists ( select * from sysobjects where name = 'cl_pro_moneda' )
	drop TABLE cl_pro_moneda
go

/* cl_producto */
print '=====> cl_producto'
if exists ( select * from sysobjects where name = 'cl_producto' )
	drop TABLE cl_producto
go

/* cl_provincia */
print '=====> cl_provincia'
if exists ( select * from sysobjects where name = 'cl_provincia' )
	drop TABLE cl_provincia
go

/* cl_seqnos */
print '=====> cl_seqnos'
if exists ( select * from sysobjects where name = 'cl_seqnos' )
	drop TABLE cl_seqnos
go

/* cl_tabla */
print '=====> cl_tabla'
if exists ( select * from sysobjects where name = 'cl_tabla' )
	drop TABLE cl_tabla
go

/* cl_ttransaccion */
print '=====> cl_ttransaccion'
if exists ( select * from sysobjects where name = 'cl_ttransaccion' )
	drop TABLE cl_ttransaccion
go

/* cl_errores */
--print '=====> cl_errores'
--if exists ( select * from sysobjects where name = 'cl_errores' )
--	drop TABLE cl_errores
--go

/* cl_default_tr */
print '=====> cl_default_tr'
if exists ( select * from sysobjects where name = 'cl_default_tr' )
        drop TABLE cl_default_tr
go

/* cl_default */
print '=====> cl_default'
if exists ( select * from sysobjects where name = 'cl_default' )
	drop TABLE cl_default
go

/* cl_def_tran */
print '=====> cl_def_tran'
if exists ( select * from sysobjects where name = 'cl_def_tran' )
        drop TABLE cl_def_tran
go


/* cl_dias_laborables */
print '=====> cl_dias_laborables'
if exists ( select * from sysobjects where name = 'cl_dias_laborables' )
	drop TABLE cl_dias_laborables
go

/* cl_sector */
print '=====> cl_sector'
if exists ( select * from sysobjects where name = 'cl_sector' )
	drop TABLE cl_sector
go

/* cl_suc_correo */
print '=====> cl_suc_correo'
if exists ( select * from sysobjects where name = 'cl_suc_correo' )
	drop TABLE cl_suc_correo
go


/* cl_telefono_of */
print '=====> cl_telefono_of'
if exists ( select * from sysobjects where name = 'cl_telefono_of' )
	drop TABLE cl_telefono_of
go

/* cc_oficial */
print '=====> cc_oficial'
if exists ( select * from sysobjects where name = 'cc_oficial' )
	drop TABLE cc_oficial
go

/* cl_medios_depar */
print '=====> cl_medios_depar'
if exists ( select * from sysobjects where name = 'cl_medios_depar' )
	drop TABLE cl_medios_depar
go

/* cl_medios_ofi */
print '=====> cl_medios_ofi'
if exists ( select * from sysobjects where name = 'cl_medios_ofi' )
	drop TABLE cl_medios_ofi
go

/* cl_medios_funcio */
print '=====> cl_medios_funcio'
if exists ( select * from sysobjects where name = 'cl_medios_funcio' )
	drop TABLE cl_medios_funcio
go


/* cl_trn_atrib */
print '=====> cl_trn_atrib'
if exists ( select * from sysobjects where name = 'cl_trn_atrib' )
	drop TABLE cl_trn_atrib
go


/******************** TASAS REFERENCIALES **************/
/* ARO: 4 de Julio del 2000 */


print '=====> te_tasas_referenciales'
if exists ( select * from sysobjects where name = 'te_tasas_referenciales' )
	drop TABLE te_tasas_referenciales
go

print '=====> te_caracteristicas_tasa'
if exists ( select * from sysobjects where name = 'te_caracteristicas_tasa' )
	drop TABLE te_caracteristicas_tasa
go

print '=====> te_pizarra'
if exists ( select * from sysobjects where name = 'te_pizarra' )
	drop TABLE te_pizarra
go

print '=====> te_tasa_coap'
if exists ( select * from sysobjects where name = 'te_tasa_coap' )
	drop TABLE te_tasa_coap
go

print '=====> te_tasa_divisas'
if exists ( select * from sysobjects where name = 'te_tasa_divisas' )
	drop TABLE te_tasa_divisas
go

print '=====> te_divisa_futura'
if exists ( select * from sysobjects where name = 'te_divisa_futura' )
	drop TABLE te_divisa_futura
go

print '=====> te_relacion_dolar'
if exists ( select * from sysobjects where name = 'te_relacion_dolar' )
	drop TABLE te_relacion_dolar
go

print '=====> te_control'
if exists ( select * from sysobjects where name = 'te_control' )
	drop TABLE te_control
go


/****************** FIN TASAS REFERENCIALES **************/

/******* MANEJO DE PASSWORDS ***********/

print '=====> cl_clave_his'
go
if exists (select name from sysobjects where name = 'cl_clave_his')
   drop TABLE cl_clave_his
go


/******* FIN MANEJO DE PASSWORDS ***********/


/******* ADMIN WEB ******/

print '=====> aw_funcionalidad'
go
if exists (select name from sysobjects where name = 'aw_funcionalidad')
   drop TABLE aw_funcionalidad
go

print '=====> aw_etiqueta_funcionalidad'
go
if exists (select name from sysobjects where name = 'aw_etiqueta_funcionalidad')
   drop TABLE aw_etiqueta_funcionalidad
go

print '=====> aw_ayuda_funcionalidad'
go
if exists (select name from sysobjects where name = 'aw_ayuda_funcionalidad')
   drop TABLE aw_ayuda_funcionalidad
go

print '=====> aw_tr_func'
go
if exists (select name from sysobjects where name = 'aw_tr_func')
   drop TABLE aw_tr_func
go

print '=====> aw_func_rol'
go
if exists (select name from sysobjects where name = 'aw_func_rol')
   drop TABLE aw_func_rol
go

print '=====> aw_herramienta'
go
if exists (select name from sysobjects where name = 'aw_herramienta')
   drop TABLE aw_herramienta
go

print '=====> aw_nombre_herramienta'
go
if exists (select name from sysobjects where name = 'aw_nombre_herramienta')
   drop TABLE aw_nombre_herramienta
go


print '=====> aw_ayuda_herramienta'
go
if exists (select name from sysobjects where name = 'aw_ayuda_herramienta')
   drop TABLE aw_ayuda_herramienta
go


print '=====> aw_herr_rol'
go
if exists (select name from sysobjects where name = 'aw_herr_rol')
   drop TABLE aw_herr_rol
go


print '=====> aw_contexto'
go
if exists (select name from sysobjects where name = 'aw_contexto')
   drop TABLE aw_contexto
go


print '=====> aw_ayuda_contexto'
go
if exists (select name from sysobjects where name = 'aw_ayuda_contexto')
   drop TABLE aw_ayuda_contexto
go


print '=====> aw_nombre_contexto'
go
if exists (select name from sysobjects where name = 'aw_nombre_contexto')
   drop TABLE aw_nombre_contexto
go

print '=====> aw_contexto_func'
go
if exists (select name from sysobjects where name = 'aw_contexto_func')
   drop TABLE aw_contexto_func
go

print '=====> aw_prereq_func'
go
if exists (select name from sysobjects where name = 'aw_prereq_func')
   drop TABLE aw_prereq_func
go


/******* FIN ADMIN WEB ******/

/******* NUEVO BATCH ********/
go
print '=====> ba_operador'
go
if exists ( select * from sysobjects where name = 'ba_operador')
	drop TABLE ba_operador
go


print '=====> ba_log_operador'

go
if exists ( select * from sysobjects where name = 'ba_log_operador')
	drop table ba_log_operador 
go
/******* FIN DE NUEVO BATCH*****/

-------------------------- Proyecto HSBC ------------------------
print '=====> ad_error_batch'
go

if exists (select 1 from sysobjects where name = 'ad_error_batch') 
begin   
   DROP TABLE ad_error_batch
end
go

print '=====> ad_rango_producto'
go

if exists (select 1 from sysobjects where name = 'ad_rango_producto') 
begin   
   DROP TABLE ad_rango_producto
end
go

print '=====> ad_nodo_reentry_tmp'
go

if exists(select * from sysobjects where name = 'ad_nodo_reentry_tmp')
	drop view ad_nodo_reentry_tmp
go


print '=====> ad_nodo_reentry_tmp_tbl'
go

if exists(select * from sysobjects where name = 'ad_nodo_reentry_tmp_tbl')
	drop table ad_nodo_reentry_tmp_tbl
go


print '=====> cl_dias_feriados_bcocentral'
go

if exists(select 1 from sysobjects where name = 'cl_dias_feriados_bcocentral')
   drop table cl_dias_feriados_bcocentral
go

-- Tabla de catálogo de tablas EX para la extracción de datos ETL
print '=====> cat_ex_table'
go

if exists(select 1 from sysobjects where name = 'cat_ex_table')
   drop table cat_ex_table
go

-- Tabla de cuadre extracción de datos ETL
print '=====> etl_cuadre_extraccion_cobis'
go

if exists(select 1 from sysobjects where name = 'etl_cuadre_extraccion_cobis')
   drop table etl_cuadre_extraccion_cobis
go

print '=====> an_menu_role_page_tmp'
go

if exists(select 1 from sysobjects where name = 'an_menu_role_page_tmp')
   drop table an_menu_role_page_tmp
go

print '=====> an_operation_component'
go

if exists(select 1 from sysobjects where name = 'an_operation_component')
   drop table an_operation_component
go

print '=====> an_transaction_component'
go

if exists(select 1 from sysobjects where name = 'an_transaction_component')
   drop table an_transaction_component
go

print '=====> an_referenced_components'
go

if exists(select 1 from sysobjects where name = 'an_referenced_components')
   drop table an_referenced_components
go

print '=====> an_cust_referenced_components'
go

if exists(select 1 from sysobjects where name = 'an_cust_referenced_components')
   drop table an_cust_referenced_components
go

print '=====> an_mig_role_module'
go

if exists(select 1 from sysobjects where name = 'an_mig_role_module')
   drop table an_mig_role_module
go

print '=====> an_mig_role_component'
go

if exists(select 1 from sysobjects where name = 'an_mig_role_component')
   drop table an_mig_role_component
go

print '=====> an_mig_role_page'
go

if exists(select 1 from sysobjects where name = 'an_mig_role_page')
   drop table an_mig_role_page
go

print '=====> an_mig_role_navigation_zone'
go

if exists(select 1 from sysobjects where name = 'an_mig_role_navigation_zone')
   drop table an_mig_role_navigation_zone
go

print '=====> an_mig_role_agent'
go

if exists(select 1 from sysobjects where name = 'an_mig_role_agent')
   drop table an_mig_role_agent
go

print '=====> ad_acceso_func_cen'
go

if exists(select 1 from sysobjects where name = 'ad_acceso_func_cen')
   drop table ad_acceso_func_cen
go

print '=====> cl_barrio'
go

if exists(select 1 from sysobjects where name = 'cl_barrio')
   drop table cl_barrio
go


print '=====> an_service_component'
go

if exists(select 1 from sysobjects where name = 'an_service_component')
   drop table an_service_component
go

/* cl_depart_pais */
print '=====> cl_depart_pais'
if exists ( select * from sysobjects where name = 'cl_depart_pais' )
	drop TABLE cl_depart_pais
go

print '======> cl_ofic_func'
go

if exists (select * from sysobjects where name ='cl_ofic_func')
   drop table cl_ofic_func
go


print '=====> cl_canton'
go

if exists (select * from sysobjects where name =  'cl_canton')
   drop table cl_canton
go

print '=====> ad_ambito'
go

if exists (select * from sysobjects where name =  'ad_ambito')
   drop table ad_ambito
go


/* cl_ofic_servicio */
print '======> cl_ofic_servicio'
if exists (select * from sysobjects where name =  'cl_ofic_servicio')
   drop table cl_ofic_servicio
go

/* cl_municipio */
--Tabla que al macena los municipios
print '======> cl_municipio'
if exists (select * from sysobjects where name =  'cl_municipio')
   drop table cl_municipio
go

/* ad_ambito_tmp */
print '======> ad_ambito_tmp'
if exists (select * from sysobjects where name =  'ad_ambito_tmp')
   drop table ad_ambito_tmp
go

/* ba_error_batch */
print '======> ba_error_batch'
if exists (select * from sysobjects where name =  'ba_error_batch')
   drop table ba_error_batch
go

/* cl_ofic_func_rol */
print '======> cl_ofic_func_rol'
if exists (select * from sysobjects where name =  'cl_ofic_func_rol')
   drop table cl_ofic_func_rol
go
