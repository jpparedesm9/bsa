/************************************************************************/
/*  Archivo:        ad_dropf.sql                                        */
/*  Base de datos:      cobis                                           */
/*  Producto:       Admin                   */
/************************************************************************/
/*              IMPORTANTE              */
/*  Este programa es parte de los paquetes bancarios propiedad de   */
/*  'MACOSA', representantes exclusivos para el Ecuador de la   */
/*  'NCR CORPORATION'.                      */
/*  Su uso no autorizado queda expresamente prohibido asi como  */
/*  cualquier alteracion o agregado hecho por alguno de sus     */
/*  usuarios sin el debido consentimiento por escrito de la     */
/*  Presidencia Ejecutiva de MACOSA o su representante.     */
/*              PROPOSITO               */
/*  Este script elimina los índices sobre clave foránea del ADMIN   */
/*              MODIFICACIONES              */
/*  FECHA       AUTOR       RAZON               */
/*  13-04-2016  BBO         Migracion SYB-SQL FAL                       */
/************************************************************************/


use cobis
go


print '=====> cl_ciudad.ci_provincia'
if exists (select name from sysindexes where name='ici_provincia')
    drop index cl_ciudad.ici_provincia



print '=====> cl_departamento.ide_organigrama'
if exists (select name from sysindexes where name='ide_organigrama')
    drop index cl_departamento.ide_organigrama



print '=====> cl_funcionario.ifu_distributivo'
if exists (select name from sysindexes where name='ifu_distributivo')
    drop index cl_funcionario.ifu_distributivo


print '=====> cl_tabla.cl_tabla_Key2'
if exists (select name from sysindexes where name='cl_tabla_Key2')
    drop index cl_tabla.cl_tabla_Key2

    
print '=====> cl_oficina.iof_subtipo'
if exists (select name from sysindexes where name='iof_subtipo')
    drop index cl_oficina.iof_subtipo


print '=====> cl_oficina.iof_filial_ofi'
if exists (select name from sysindexes where name='iof_filial_ofi')
    drop index cl_oficina.iof_filial_ofi



print '=====> cl_moneda.imo_pais'
if exists (select name from sysindexes where name='imo_pais')
    drop index cl_moneda.imo_pais



print '=====> cl_pro_oficina.ipl_producto'
if exists (select name from sysindexes where name='ipl_producto')
    drop index cl_pro_oficina.ipl_producto



print '=====> cc_oficial.ofic_fun_Key'
if exists (select name from sysindexes where name='ofic_fun_Key')
    drop index cc_oficial.ofic_fun_Key



print '=====> cl_medios_depar.cl_medios_depar_UQ'
if exists (select name from sysindexes where name='cl_medios_depar_UQ')
    drop index cl_medios_depar.cl_medios_depar_UQ



print '=====> cl_medios_funcio.cl_medios_funcio_UQ'
if exists (select name from sysindexes where name='cl_medios_funcio_UQ')
    drop index cl_medios_funcio.cl_medios_funcio_UQ



print '=====> cl_medios_ofi.cl_medios_ofi_UQ'
if exists (select name from sysindexes where name='cl_medios_ofi_UQ')
    drop index cl_medios_ofi.cl_medios_ofi_UQ


/**************** TASAS REFERENCIALES ***************/
/* ARO: 4 de Julio  del 2000 */

print '=====> te_pizarra_FKey1'
go
if exists (select name from sysindexes where name='te_pizarra_FKey1')
   drop index te_pizarra.te_pizarra_FKey1
go

print '=====> te_pizarra_FKey2'
go
if exists (select name from sysindexes where name='te_pizarra_FKey2')
   drop index te_pizarra.te_pizarra_FKey2
go


print '=====> te_tasa_coap_FKey1'
go
if exists (select name from sysindexes where name='te_tasa_coap_FKey1')
   drop index te_tasa_coap.te_tasa_coap_FKey1
go

print '=====> te_tasa_divisas_FKey1 '
go
if exists (select name from sysindexes where name='te_tasa_divisas_FKey1')
   drop index te_tasa_divisas.te_tasa_divisas_FKey1
go

print '=====> te_divisa_futura_Key1  '
go
if exists (select name from sysindexes where name='te_divisa_futura_Key1')
   drop index te_divisa_futura.te_divisa_futura_Key1
go


print '=====> te_divisa_futura_FKey1  '
go
if exists (select name from sysindexes where name='te_divisa_futura_FKey1')
   drop index te_divisa_futura.te_divisa_futura_FKey1
go


/************* FIN DE TASAS REGERENCIALES ***********/


/********* ADMIN WEB *********/

print '=====> aw_funcionalidad_KeyA'
go
if exists (select name from sysindexes where name='aw_funcionalidad_KeyA')
   drop index aw_funcionalidad.aw_funcionalidad_KeyA
go

/********* FIN ADMIN WEB *********/

/********  NUEVO BATCH   *********/
print '=====> ba_log_operador_KEYA'
go
if exists (select name from sysindexes where name='ba_log_operador_KEYA')
   drop index ba_log_operador.ba_log_operador_KEYA
go
/********  FIN DE NUEVO BATCH *****/


/********* ADMIN *********/

print '=====> ad_traut_rol_Key'
go
if exists (select name from sysindexes where name='ad_traut_rol_Key')
   drop index ad_tr_autorizada.ad_traut_rol_Key
go

print '=====> ad_procedure_name_Key'
go
if exists (select name from sysindexes where name='ad_procedure_name_Key')
   drop index ad_procedure.ad_procedure_name_Key
go


print '=====> ad_transaccion_Key'
go
if exists (select name from sysindexes where name='ad_transaccion_Key')
   drop index ad_pro_transaccion.ad_transaccion_Key
go


print '=====> ad_nodo_reentry_tmp_spid_idx'
go
if exists (select name from sysindexes where name='ad_nodo_reentry_tmp_spid_idx')
   drop index ad_nodo_reentry_tmp_tbl.ad_nodo_reentry_tmp_spid_idx
go

if exists (select name from sysobjects where name='spid')
   drop default spid
go

/********* FIN ADMIN *********/

print '=====> cl_ofic_servicioFK1'
go
if exists (select name from sysindexes where name='cl_ofic_servicioFK1')
   drop index cl_ofic_servicio.cl_ofic_servicioFK1
go

