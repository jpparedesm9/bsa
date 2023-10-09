/************************************************************************/
/*	Archivo:		ad_dropv.sql				*/
/*	Base de datos:		cobis					*/
/*	Producto:		Admin					*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este script elimina las vistas del ADMIN			*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cobis
go


/* ts_x25_config */
print '=====> ts_x25_config'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_x25_config')
	drop view ts_x25_config
go

/* ts_base_datos */
print '=====> ts_base_datos'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_base_datos')
	drop VIEW ts_base_datos
go

/* ts_horario */
print '=====> ts_horario'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_horario')
	drop VIEW ts_horario
go

/* ts_x25 */
print '=====> ts_x25'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_x25')
	drop VIEW ts_x25
go

/* ts_tcpip */
print '=====> ts_tcpip'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_tcpip')
	drop VIEW ts_tcpip
go

/* ts_link */
print '=====> ts_link'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_link')
	drop VIEW ts_link
go

/* ts_nodo */
print '=====> ts_nodo'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_nodo')
	drop VIEW ts_nodo
go

/* ts_nodo_nivel */
print '=====> ts_nodo_nivel'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_nodo_nivel')
	drop VIEW ts_nodo_nivel
go

/* ts_nivel */
print '=====> ts_nivel'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_nivel')
	drop VIEW ts_nivel
go

/* ts_icono */
print '=====> ts_icono'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_icono')
	drop VIEW ts_icono
go

/* ts_mapa */
print '=====> ts_mapa'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_mapa')
	drop VIEW ts_mapa
go

/* ts_cat_icono */
print '=====> ts_cat_icono'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_cat_icono')
	drop VIEW ts_cat_icono
go


/* ts_nodo_oficina */
print '=====> ts_nodo_oficina'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_nodo_oficina')
	drop VIEW ts_nodo_oficina
go

/* ts_pro_rol */
print '=====> ts_pro_rol'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_pro_rol')
	drop VIEW ts_pro_rol
go

/* ts_procedure */
print '=====> ts_procedure'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_procedure')
	drop VIEW ts_procedure
go

/* ts_protocolo */
print '=====> ts_protocolo'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_protocolo')
	drop VIEW ts_protocolo
go

/* ts_pro_transaccion */
print '=====> ts_pro_transaccion'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_pro_transaccion')
	drop VIEW ts_pro_transaccion
go

/* ts_procedure_tran */
print '=====> ts_procedure_tran'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_procedure_tran')
	drop VIEW ts_procedure_tran
go

/* ts_ad_rol */
print '=====> ts_ad_rol'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_ad_rol')
	drop VIEW ts_ad_rol
go

/* ts_directa */
print '=====> ts_directa'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_directa')
	drop VIEW ts_directa
go

/* ts_indirecta */
print '=====> ts_indirecta'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_indirecta')
	drop VIEW ts_indirecta
go

/* ts_server_logico */
print '=====> ts_server_logico'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_server_logico')
	drop VIEW ts_server_logico
go

/* ts_sis_operativo */
print '=====> ts_sis_operativo'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_sis_operativo')
	drop VIEW ts_sis_operativo
go

/* ts_terminal */
print '=====> ts_terminal'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_terminal')
	drop VIEW ts_terminal
go

/* ts_tlink */
print '=====> ts_tlink'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_tlink')
	drop VIEW ts_tlink
go

/* ts_transaccion */
print '=====> ts_transaccion'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_transaccion')
	drop VIEW ts_transaccion
go

/* ts_tr_autorizada */
print '=====> ts_tr_autorizada'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_tr_autorizada')
	drop VIEW ts_tr_autorizada
go

/* ts_usuario */
print '=====> ts_usuario'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_usuario')
	drop VIEW ts_usuario
go

/* ts_usuario_rol */
print '=====> ts_usuario_rol'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_usuario_rol')
	drop VIEW ts_usuario_rol
go


/* ts_parametro */
print '=====> ts_parametro'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_parametro')
	drop VIEW ts_parametro
go

/* ts_tipo_horario */
print '=====> ts_tipo_horario'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_tipo_horario')
	drop VIEW ts_tipo_horario
go


/* ts_val_tran */
print '=====> ts_val_tran'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_val_tran')
	drop VIEW ts_val_tran
go

/* ts_vigencia */
print '=====> ts_vigencia'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_vigencia')
	drop VIEW ts_vigencia
go

/* ts_catalogo */
print '=====> ts_catalogo'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_catalogo')
	drop VIEW ts_catalogo
go

/* ts_pais */
print '=====> ts_pais'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_pais')
	drop VIEW ts_pais
go

/* ts_ciudad */
print '=====> ts_ciudad'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_ciudad')
	drop VIEW ts_ciudad
go

/* ts_moneda */
print '=====> ts_moneda'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_moneda')
	drop VIEW ts_moneda
go

/* ts_rol */
print '=====> ts_rol'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_rol')
	drop VIEW ts_rol
go

/* ts_producto */
print '=====> ts_producto'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_producto')
	drop VIEW ts_producto
go

/* ts_provincia */
print '=====> ts_provincia'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_provincia')
	drop VIEW ts_provincia
go

/* ts_parroquia */
print '=====> ts_parroquia'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_parroquia')
	drop VIEW ts_parroquia
go

/* ts_pro_moneda */
print '=====> ts_pro_moneda'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_pro_moneda')
	drop VIEW ts_pro_moneda
go

/* ts_pro_oficina */
print '=====> ts_pro_oficina'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_pro_oficina')
	drop VIEW ts_pro_oficina
go

/* ts_pro_asociado */
print '=====> ts_pro_asociado'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_pro_asociado')
	drop VIEW ts_pro_asociado
go

/* ts_distributivo */
print '=====> ts_distributivo'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_distributivo')
	drop VIEW ts_distributivo
go

/* ts_departamento */
print '=====> ts_departamento'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_departamento')
	drop VIEW ts_departamento
go

/* ts_oficina */
print '=====> ts_oficina'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_oficina')
	drop VIEW ts_oficina
go

/* ts_oficina_geo */
print '=====> ts_oficina_geo'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_oficina_geo')
	drop VIEW ts_oficina_geo
go

/* ts_filial */
print '=====> ts_filial'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_filial')
	drop VIEW ts_filial
go

/* ts_funcionario */
print '=====> ts_funcionario'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_funcionario')
	drop VIEW ts_funcionario
go

/* ts_funcionario_bloq */
print '=====> ts_funcionario_bloq'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_funcionario_bloq')
	drop VIEW ts_funcionario_bloq
go

/* ts_tabla */
print '=====> ts_tabla'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_tabla')
	drop VIEW ts_tabla
go

/* ts_feriados */
print '=====> ts_feriados'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_feriados')
	drop VIEW ts_feriados
go

/* ts_def_tran */
print '=====> ts_def_tran'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_def_tran')
	drop VIEW ts_def_tran
go

/* ts_cat_prod */
print '=====> ts_cat_prod'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_cat_prod')
	drop VIEW ts_cat_prod
go

/* ts_error */
print '=====> ts_error'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_error')
	drop VIEW ts_error
go

/* ts_suc_correo */
print '=====> ts_suc_correo'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_suc_correo')
	drop VIEW ts_suc_correo
go

/* ts_telefono_of */
print '=====> ts_telefono_of'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_telefono_of')
	drop VIEW ts_telefono_of
go

/* cc_tsoficial */
print '=====> cc_tsoficial'
go
if exists (select * from sysobjects 
           where type='V' and name='cc_tsoficial')
	drop VIEW cc_tsoficial
go


/*ts_ofic_func*/
print '=====> ts_ofic_func'
if exists (select * from sysobjects 
   where type='V' and name='ts_ofic_func')
drop VIEW ts_ofic_func
go

/*ts_canton*/
print '=====> ts_canton'
if exists (select * from sysobjects 
           where type='V' and name='ts_canton')
   drop VIEW ts_canton
go

/*ts_ambito*/
print '=====> ts_ambito'
if exists (select * from sysobjects 
           where type='V' and name='ts_ambito')
   drop VIEW ts_ambito
go

/*ts_ambito_tmp*/
print '=====> ts_ambito_tmp'
if exists (select * from sysobjects 
           where type='V' and name='ts_ambito_tmp')
   drop VIEW ts_ambito_tmp
go






/*********** TASAS REFERENCIALES ************/
/* ARO : 4 de Julio del 2000 */

print '=====> ts_tasas_referenciales'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_tasas_referenciales')
	drop view ts_tasas_referenciales
go

print '=====> ts_caracteristicas_tasa'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_caracteristicas_tasa')
	drop view ts_caracteristicas_tasa
go

print '=====> ts_pizarra'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_pizarra')
	drop view ts_pizarra
go


print '=====> ts_coap'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_coap')
	drop view ts_coap
go

print '=====> ts_divd'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_divd')
	drop view ts_divd
go

print '=====> ts_divf'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_divf')
	drop view ts_divf
go


print '=====> ts_reldo'
go
if exists (select * from sysobjects 
           where type='V' and name='ts_reldo')
	drop view ts_reldo
go


/********* FIN TASAS REFERENCIALES **********/

--------------------------------------- HSBC ----------------------------------
if exists (select * from sysobjects where name = 'ts_acceso_func_cen' and type='V')
    DROP VIEW ts_acceso_func_cen
go

print '=====> ad_nodo_reentry_tmp'
go

if exists ( select * from sysobjects where name = 'ad_nodo_reentry_tmp' )
	drop VIEW ad_nodo_reentry_tmp
go

if exists(select 1 from sysobjects where name = 'ts_feriados_bcocentral' and type = 'V')
   DROP VIEW ts_feriados_bcocentral
go

print '=====> ts_adm_seguridades'
go
if exists (select * from sysobjects where name = 'ts_adm_seguridades' and type='V')
    DROP VIEW ts_adm_seguridades
go

print '=====> ts_label'
go
if exists (select * from sysobjects where name = 'ts_label' and type='V')
    DROP VIEW ts_label
go


print '=====> ts_desbloqueo_func'
go
if exists (select * from sysobjects where name = 'ts_desbloqueo_func')
    DROP VIEW ts_desbloqueo_func
go

print '=====> ts_barrio'
go
if exists (select * from sysobjects where name = 'ts_barrio')
    DROP VIEW ts_barrio
go

print '=====> ts_serv_ofic'
go
if exists (select * from sysobjects where name = 'ts_serv_ofic')
    DROP VIEW ts_serv_ofic
go

print '=====> ts_depart_pais'
go
if exists (select * from sysobjects where name = 'ts_depart_pais')
    DROP VIEW ts_depart_pais
go

print '=====> ts_oficfunc_rol'
if exists (select * from sysobjects where name =  'ts_oficfunc_rol')
   drop view ts_oficfunc_rol
go

print '=====> ts_municipio'
if exists (select * from sysobjects where name =  'ts_municipio')
   drop view ts_municipio
go
