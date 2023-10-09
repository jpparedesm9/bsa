/************************************************************************/
/*	Archivo:		ad_pkey.sql				*/
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
/*	Este script crea los indices en clave primaria del ADMIN	*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*  12/ABR/2016 BBO         Migracion SYBASE-SQLServer FAL              */
/************************************************************************/

use cobis
go

/* cl_funcionario */
print '=====> cl_funcionario'
CREATE UNIQUE INDEX cl_login_Key_ad ON cl_funcionario (
	fu_login)
go

/* ad_x25_config */
print '=====> ad_x25_config'
CREATE UNIQUE CLUSTERED INDEX ad_x25_config_Key ON ad_x25_config (
	xc_filial,
	xc_oficina,
	xc_nodo,
	xc_protocolo,
	xc_tlink,
	xc_link,
	xc_secuencial)
go

/* ad_base_datos */
print '=====> ad_base_datos'
CREATE UNIQUE CLUSTERED INDEX ad_base_datos_Key ON ad_base_datos (
       bd_filial,
       bd_oficina,
       bd_nodo,
       bd_base)
go


/* ad_horario */
print '=====> ad_horario'
CREATE UNIQUE CLUSTERED INDEX ad_horario_Key ON ad_horario (
	ho_tipo_horario,
	ho_secuencial)
go


/* ad_horario_tmp */
print '=====> ad_horario_tmp'
CREATE UNIQUE CLUSTERED INDEX ad_conexion_h_Key ON ad_horario_tmp (
	hot_conexion,
	hot_tipo_horario,
	hot_secuencial)
go


/* ad_interface */
print '=====> ad_horario_tmp'
CREATE UNIQUE CLUSTERED INDEX ad_interface_Key ON ad_interface (
	in_filial,
	in_oficina,
	in_nodo,
	in_protocolo,
	in_tlink,
	in_link)
go


/* ad_link */
print '=====> ad_link'
CREATE UNIQUE CLUSTERED INDEX ad_link_Key ON ad_link (
	li_filial,
	li_oficina,
	li_nodo,
	li_tipo,
	li_link)
go


/* ad_nodo */
print '=====> ad_nodo'
CREATE UNIQUE CLUSTERED INDEX ad_nodo_Key ON ad_nodo (
	no_nodo)
go



/* ad_nodo_oficina */
print '=====> ad_nodo_oficina'
CREATE UNIQUE CLUSTERED INDEX ad_nodo_oficina_Key ON ad_nodo_oficina (
	nl_filial,
	nl_oficina,
	nl_nodo)
go

/* ad_procedure */
print '=====> ad_procedure'
CREATE UNIQUE CLUSTERED INDEX ad_procedure_Key ON ad_procedure (
	pd_procedure)
go

/* ad_pro_rol */
print '=====> ad_pro_rol'
CREATE UNIQUE CLUSTERED INDEX ad_pro_rol_Key ON ad_pro_rol (
	pr_rol,
	pr_producto,
	pr_tipo,
	pr_moneda)
go


/* ad_protocolo */
print '=====> ad_protocolo'
CREATE UNIQUE CLUSTERED INDEX ad_protocolo_Key ON ad_protocolo (
	pr_protocolo)
go


/* ad_pro_transaccion */
print '=====> ad_pro_transaccion'
CREATE UNIQUE CLUSTERED INDEX ad_pro_transaccion_Key ON ad_pro_transaccion (
	pt_producto,
	pt_tipo,
	pt_moneda,
	pt_transaccion)
go


/* ad_rol */
print '=====> ad_rol'
CREATE UNIQUE CLUSTERED INDEX ad_rol_Key ON ad_rol (
	ro_rol)
go


/* ad_ruta */
print '=====> ad_ruta'
CREATE UNIQUE CLUSTERED INDEX ad_ruta_Key ON ad_ruta (
	ru_filial_d,
	ru_oficina_d,
	ru_nodo_d,
	ru_filial_h,
	ru_oficina_h,
	ru_nodo_h,
	ru_subtipo)
go


/* ad_server_logico */
print '=====> ad_server_logico'
CREATE UNIQUE CLUSTERED INDEX ad_server_logico_Key ON ad_server_logico (
	sg_filial_i,
	sg_oficina_i,
	sg_nodo_i,
	sg_filial_p,
	sg_oficina_p,
	sg_producto,
	sg_tipo,
	sg_moneda
)
go


CREATE UNIQUE INDEX ad_server_producto ON ad_server_logico (
	sg_filial_p,
	sg_oficina_p,
	sg_producto,
	sg_tipo,
	sg_moneda,
	sg_nodo_i
)
go


/* ad_sis_operativo */
print '=====> ad_sis_operativo'
CREATE UNIQUE CLUSTERED INDEX ad_sis_operativo_Key ON ad_sis_operativo (
	so_sis_operativo)
go


/* ad_terminal */
print '=====> ad_terminal'
CREATE UNIQUE CLUSTERED INDEX ad_terminal_Key1 ON ad_terminal (
	te_filial,
	te_oficina,
	te_nodo,
	te_terminal)
go

CREATE UNIQUE INDEX ad_terminal_Key2 ON ad_terminal (
	te_filial,
	te_oficina,
	te_nodo,
	te_nombre)
go


/* ad_tipo_horario */
print '=====> ad_tipo_horario'
CREATE UNIQUE CLUSTERED INDEX ad_tipo_horario_Key ON ad_tipo_horario (
	th_tipo)
go


/* ad_tipo_horario_tmp */
print '=====> ad_tipo_horario_tmp'
CREATE UNIQUE CLUSTERED INDEX ad_conexion_th_Key ON ad_tipo_horario_tmp (
	tht_conexion)
go


/* ad_tlink */
print '=====> ad_tlink'
CREATE UNIQUE CLUSTERED INDEX ad_tlink_Key ON ad_tlink (
	tl_tipo_link)
go


/* ad_tr_autorizada */
print '=====> ad_tr_autorizada'
CREATE UNIQUE CLUSTERED INDEX ad_tr_autorizada_Key ON ad_tr_autorizada (
	ta_producto,
	ta_tipo,
	ta_moneda,
	ta_transaccion,
	ta_rol)
go


/* ad_usuario */
print '=====> ad_usuario'
CREATE UNIQUE CLUSTERED INDEX ad_usuario_Key ON ad_usuario (
	us_filial,
	us_oficina,
	us_nodo,
	us_login)
go


/* ad_usuario_rol */
print '=====> ad_usuario_rol'
CREATE UNIQUE CLUSTERED INDEX ad_usuario_rol_Key ON ad_usuario_rol (
	ur_login,
	ur_rol)
go

/* ad_vigente */
print '=====> ad_vigente'
CREATE UNIQUE CLUSTERED INDEX ad_vigencia_Key ON ad_vigencia (
	vi_tabla)
go


/* cl_catalogo */
print '=====> cl_catalogo_Key'
CREATE UNIQUE CLUSTERED INDEX cl_catalogo_Key ON cl_catalogo (
	tabla,
	codigo)
go


/* cl_catalogo_pro */
print '=====> cl_catalogo_pro_Key'
CREATE UNIQUE CLUSTERED INDEX cl_catalogo_pro_Key ON cl_catalogo_pro (
	cp_producto,
	cp_tabla)
go


/* cl_ciudad */
print '=====> cl_ciudad_Key'
CREATE UNIQUE CLUSTERED INDEX cl_ciudad_Key ON cl_ciudad (
	ci_ciudad)
go


/* cl_default_tr */
print '=====> cl_default_tr_Key'
CREATE UNIQUE CLUSTERED INDEX cl_default_tr_Key ON cl_default_tr (
	df_nemonico)
go


/* cl_departamento */
print '=====> cl_departamento_Key'
CREATE UNIQUE CLUSTERED INDEX cl_departamento_Key ON cl_departamento (
	de_oficina,de_departamento)
go


/* cl_dias_feriados */
print '=====> cl_dias_feriados'
CREATE UNIQUE CLUSTERED INDEX cl_dias_feriados_Key ON cl_dias_feriados (
	df_ciudad,df_fecha)
go


/* cl_dis_seqnos */
print '=====> cl_dis_seqnos_Key'
CREATE UNIQUE CLUSTERED INDEX cl_dis_seqnos_Key ON cl_dis_seqnos (
	dq_oficina,
	dq_departamento,
	dq_cargo)
go


/* cl_distributivo */
print '=====> cl_distributivo_Key'
CREATE UNIQUE CLUSTERED INDEX cl_distributivo_Key ON cl_distributivo (
	ds_oficina,
	ds_departamento,
	ds_cargo,
	ds_secuencial)
go


/* cl_filial */
print '=====> cl_filial_Key'
CREATE UNIQUE CLUSTERED INDEX cl_filial_Key ON cl_filial (
	fi_filial)
go


/* cl_funcionario */
print '=====> cl_funcionario_Key'
CREATE UNIQUE CLUSTERED INDEX cl_funcionario_Key ON cl_funcionario (
	fu_funcionario)
go


/* cl_oficina */
print '=====> cl_oficina_Key'
CREATE UNIQUE CLUSTERED INDEX cl_oficina_Key ON cl_oficina (
	of_oficina)
go


/* cl_moneda */
print '=====> cl_moneda_Key'
CREATE UNIQUE CLUSTERED INDEX cl_moneda_Key ON cl_moneda (
	mo_moneda)
go


/* cl_pais */
print '=====> cl_pais_Key'
CREATE UNIQUE CLUSTERED INDEX cl_pais_Key ON cl_pais (
	pa_pais)
go


/* cl_parroquia */
print '=====> cl_parroquia_Key'
CREATE UNIQUE CLUSTERED INDEX cl_parroquia_Key ON cl_parroquia (
	pq_ciudad,pq_parroquia)
go


/* cl_pro_asociado */
print '=====> cl_pro_asociado_Key'
CREATE UNIQUE CLUSTERED INDEX cl_pro_asociado_Key ON cl_pro_asociado (
	pp_base,
	pp_asociado)
go


/* cl_pro_oficina */
print '=====> cl_pro_oficina_Key'
CREATE UNIQUE CLUSTERED INDEX cl_pro_oficina_Key ON cl_pro_oficina (
	pl_filial,
	pl_oficina,
	pl_producto,
	pl_tipo,
	pl_moneda)
go


/* cl_pro_moneda */
print '=====> cl_pro_moneda_Key'
CREATE UNIQUE CLUSTERED INDEX cl_pro_moneda_Key ON cl_pro_moneda (
	pm_producto,
	pm_tipo,
	pm_moneda)
go


/* cl_producto */
print '=====> cl_producto_Key'
CREATE UNIQUE CLUSTERED INDEX cl_producto_Key ON cl_producto (
	pd_producto,
	pd_tipo)
go


/* cl_provincia */
print '=====> cl_provincia_Key'
CREATE UNIQUE CLUSTERED INDEX cl_provincia_Key ON cl_provincia (
	pv_provincia)
go


/* cl_seqnos */
print '=====> cl_seqnos_Key'
CREATE UNIQUE CLUSTERED INDEX cl_seqnos_Key ON cl_seqnos (
	tabla)
go


/* cl_tabla */
print '=====> cl_tabla_Key'
CREATE UNIQUE CLUSTERED INDEX cl_tabla_Key ON cl_tabla (
	codigo)
go


/* cl_errores */
--print '=====> cl_errores_Key'
--CREATE UNIQUE CLUSTERED INDEX cl_errores_Key ON 
--	cl_errores (numero)
--go


/* cl_dias_laborables */
print '=====> cl_dias_laborables_Key'
CREATE UNIQUE CLUSTERED INDEX cl_dias_laborables_Key ON cl_dias_laborables (
	dl_fecha)
go


/* cl_suc_correo */
print '=====> cl_suc_correo_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_suc_correo_Key ON cl_suc_correo (
		sc_provincia,
		sc_sucursal)
go


/* cl_ttransaccion */
print '=====> cl_ttransaccion_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_ttransaccion_Key ON cl_ttransaccion (
		tn_trn_code)
go

/* cl_parametro */
print '=====> cl_parametro_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_parametro_Key ON cl_parametro (
	pa_producto,
	pa_nemonico)
go

/* cc_oficial */
print '=====> oficial_Key'
go
CREATE UNIQUE CLUSTERED INDEX oficial_Key on cc_oficial(oc_oficial)
go

/* cl_medios_depar */
print '=====> cl_medios_depar_KEY'
go
create unique clustered index cl_medios_depar_KEY
on cl_medios_depar (md_filial, md_oficina, md_departamento, md_codigo)
go

/* cl_medios_funcio */
print '=====> cl_medios_funcio_KEY'
go
create unique clustered index cl_medios_funcio_KEY
on cl_medios_funcio (mf_funcionario, mf_codigo)
go

/* cl_medios_ofi */
print '=====> cl_medios_ofi_KEY'
go
create unique clustered index cl_medios_ofi_KEY
on cl_medios_ofi (mo_filial, mo_oficina, mo_codigo)
go

/**************** TASAS REFERENCIALES ***************/
/* ARO: 4 de Julio  del 2000 */

print '=====> te_tasas_referenciales_Key'
go
create unique index te_tasas_referenciales_Key
       on te_tasas_referenciales (tr_tasa)
go

print '=====> te_caracteristicas_tasa_Key'
go
create unique index te_caracteristicas_tasa_Key
       on te_caracteristicas_tasa (ca_tasa, ca_periodo, ca_modalidad)
go

print '=====> te_pizarra_Key'
go
create unique clustered index te_pizarra_Key
       on te_pizarra (pi_cod_pizarra, pi_moneda, pi_fecha_inicio, pi_fecha_fin)
go

print '=====> te_tasa_coap_Key'
go
CREATE UNIQUE CLUSTERED INDEX te_tasa_coap_Key 
  ON te_tasa_coap (lc_num_tasa, lc_moneda, lc_fecha_inicio, lc_fecha_final)
go

print '=====> te_tasa_divisas_Key'
go
CREATE UNIQUE CLUSTERED INDEX te_tasa_divisas_Key 
  ON te_tasa_divisas (td_num_tasa, td_moneda, td_fecha)
go

print '=====> te_divisa_futura_Key  '
go
CREATE UNIQUE CLUSTERED INDEX te_divisa_futura_Key 
  ON te_divisa_futura (df_num_registro, df_moneda, df_fecha_inicio, df_fecha_fin)
go

print '=====> te_relacion_dolar_Key '
go
CREATE CLUSTERED INDEX te_relacion_dolar_Key 
  ON te_relacion_dolar (rd_cod_moneda,rd_fecha_final, rd_secuencial)
go

/************* FIN DE TASAS REGERENCIALES ***********/

/********** MANEJO DE PASSWORDS ************/

print '=====> cl_clave_his_KEY'
go
create unique clustered index cl_clave_his_KEY on cl_clave_his (ch_login, ch_secuencial)
go

/********** FIN MANEJO DE PASSWORDS ************/


/************ ADMIN WEB *************/


print '=====> aw_funcionalidad_KEY'
go
CREATE UNIQUE CLUSTERED INDEX aw_funcionalidad_KEY 
ON aw_funcionalidad(fn_func)
go

print '=====> aw_etiqueta_funcionalidad_KEY'
go
CREATE UNIQUE CLUSTERED INDEX aw_etiqueta_funcionalidad_KEY 
ON aw_etiqueta_funcionalidad(ef_func,ef_idioma)
go

print '=====> aw_ayuda_funcionalidad_KEY'
go
CREATE UNIQUE CLUSTERED INDEX aw_ayuda_funcionalidad_KEY 
ON aw_ayuda_funcionalidad(af_func,af_idioma)
go


print '=====> aw_tr_func_KEY'
go
CREATE UNIQUE CLUSTERED INDEX aw_tr_func_KEY 
ON aw_tr_func(tf_func,tf_transaccion)
go

print '=====> aw_func_rol_KEY'
go
CREATE UNIQUE CLUSTERED INDEX aw_func_rol_KEY 
ON aw_func_rol(fr_rol,fr_func)
go

print '=====> aw_herramienta_KEY'
go
CREATE UNIQUE CLUSTERED INDEX aw_herramienta_KEY 
ON aw_herramienta(he_herramienta)
go

print '=====> aw_nombre_herramienta_KEY'
go
CREATE UNIQUE CLUSTERED INDEX aw_nombre_herramienta_KEY 
ON aw_nombre_herramienta(nh_herramienta,nh_idioma)
go

print '=====> aw_ayuda_herramienta_KEY'
go
CREATE UNIQUE CLUSTERED INDEX aw_ayuda_herramienta_KEY 
ON aw_ayuda_herramienta(ah_herramienta,ah_idioma)
go

print '=====> aw_herr_rol_KEY'
go
CREATE UNIQUE CLUSTERED INDEX aw_herr_rol_KEY 
ON aw_herr_rol(hr_rol,hr_herramienta)
go

print '=====> aw_contexto_KEY'
go
CREATE UNIQUE CLUSTERED INDEX aw_contexto_KEY 
ON aw_contexto(co_contexto)
go

print '=====> aw_ayuda_contexto_KEY'
go
CREATE UNIQUE CLUSTERED INDEX aw_ayuda_contexto_KEY 
ON aw_ayuda_contexto(ac_contexto,ac_idioma)
go

print '=====> aw_nombre_contexto_KEY'
go
CREATE UNIQUE CLUSTERED INDEX aw_nombre_contexto_KEY 
ON aw_nombre_contexto(nc_contexto,nc_idioma)
go

print '=====> aw_contexto_func_KEY'
go
CREATE UNIQUE CLUSTERED INDEX aw_contexto_func_KEY 
ON aw_contexto_func(cf_func, cf_contexto)
go

print '=====> aw_prereq_func_KEY'
go
CREATE UNIQUE CLUSTERED INDEX aw_prereq_func_KEY 
ON aw_prereq_func(pf_func,pf_prereq)
go

/************ FIN ADMIN WEB *************/

/************ NUEVO BATCH ***************/

print '=====> ba_operador_KEY'
go
create unique clustered index ba_operador_KEY on ba_operador (op_login, op_rol, op_osuser)
go


print '=====> ba_log_operador_KEY'
go
create unique clustered index ba_log_operador_KEY on ba_log_operador (lo_sec)
go
/********** FIN NUEVO BATCH**************/

-------------------------- Proyecto HSBC ------------------------
print '=====> ad_error_batch_key'
go
create unique clustered index ad_error_batch_key
    on ad_error_batch (eb_secuencial_error, eb_fecha_proceso)
go

print '=====> ad_vistas_trnser_key'
go
CREATE UNIQUE CLUSTERED INDEX ad_vistas_trnser_key 
    on ad_vistas_trnser  (vt_producto,vt_base_datos,vt_tabla)
go

print '=====> ad_acceso_func_cen_KEY'
create nonclustered index ad_acceso_func_cen_KEY
    on ad_acceso_func_cen (af_fecha, af_terminal, af_usuario, af_rol)
go

print '=====> cl_barrio_key'
create unique clustered index cl_barrio_key
    on cl_barrio (ba_barrio, ba_canton, ba_distrito) --Nota: los datos del campo ba_distrito hace referencia a la provincia CC-CLI-0009
go

-- Tabla de catálogo de tablas EX para la extracción de datos ETL
print '=====> cat_ex_table'
go
CREATE UNIQUE INDEX cat_ex_table_Key
    ON cat_ex_table(et_module, et_path_dst, et_base, et_table)
go

-- Tabla de cuadre extracción de datos ETL
print '=====> etl_cuadre_extraccion_cobis'
go
CREATE UNIQUE CLUSTERED INDEX etl_cuadre_extraccion_cobis_pk 
ON etl_cuadre_extraccion_cobis 
(
   cec_empresa,
   cec_fecha_proceso,
   cec_modulo,
   cec_tabla_fuente,
   cec_campo_criterio,
   cec_valor_criterio
)
go

--Tabla de asociacion de oficinas con servicios
print '=====> cl_ofic_servicio'
go
CREATE UNIQUE CLUSTERED INDEX cl_ofic_servicio_pk
ON cl_ofic_servicio
(
   os_oficina,
   os_filial,
   os_cat_servicio
)
go

/* cl_depart_pais */
print '=====> cl_depart_pais_Key'
CREATE UNIQUE CLUSTERED INDEX cl_depart_pais_Key ON cl_depart_pais (
	dp_departamento)
go


--Tabla de asociacion de oficinas con funcionarios
print '=====> cl_ofic_func'
go
CREATE UNIQUE CLUSTERED INDEX cl_ofic_func_pk
ON cl_ofic_func
(
   of_oficina,
   of_filial,
   of_funcionar
)
go

--Tabla de municipios
print '=====> cl_municipio'
go
CREATE UNIQUE CLUSTERED INDEX cl_municipio_pk
ON cl_municipio
(
   mu_municipio
)
go

/* cl_canton */
print '=====> cl_canton'
go
CREATE UNIQUE CLUSTERED INDEX cl_canton_Key 
ON cl_canton 
(
    ca_canton
)
go

/*--ad_ambito--*/
print '=====>ad_ambito'
go
CREATE UNIQUE CLUSTERED INDEX ad_ambito_Key 
ON ad_ambito (
   am_secuencial
)
go

/* cl_ofic_func_rol */
print '=====> cl_ofic_func_rol'
go
CREATE UNIQUE INDEX cl_ofic_func_rol_key ON cl_ofic_func_rol (
or_oficfunc,or_rol)
go


print 'ba_error_batch_key ...'
go

if exists (select name from sysindexes where name='ba_error_batch_key')
   drop index ba_error_batch.ba_error_batch_key
go

CREATE UNIQUE CLUSTERED INDEX ba_error_batch_key on ba_error_batch 
(
     er_secuencial_error, 
     er_fecha_proceso
)
go
