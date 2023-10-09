/************************************************************************/
/*	Archivo:		ad_fkey.sql				*/
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
/*	Este script crea los indices en clave foranea del ADMIN		*/
/*				MODIFICACIONES				*/
/*	FECHA		    AUTOR		RAZON				*/
/*  12/ABR/2016     BBO         Migracion SYBASE-SQLServer FAL          */
/************************************************************************/


use cobis
go


print '=====> cl_ciudad.ici_provincia'
CREATE INDEX ici_provincia ON cl_ciudad (
	ci_provincia)
go


print '=====> cl_departamento.ide_organigrama'
CREATE INDEX ide_organigrama ON cl_departamento (
	de_o_oficina,de_o_departamento)
go


print '=====> cl_funcionario.i_fu_distributivo'
CREATE INDEX ifu_distributivo ON cl_funcionario (
	fu_oficina,
	fu_departamento,
	fu_cargo)
go


print '=====> cl_oficina.iof_subtipo'
CREATE INDEX iof_subtipo ON cl_oficina (
	of_subtipo)
go

print '=====> cl_oficina.iof_filial_ofi'
CREATE UNIQUE INDEX iof_filial_ofi ON cl_oficina (
	of_filial,of_oficina)
go


print '=====> cl_moneda.imo_pais'
CREATE INDEX imo_pais ON cl_moneda (
	mo_pais)
go


print '=====> cl_pro_oficina.ipl_producto'
CREATE INDEX ipl_producto ON cl_pro_oficina (
	pl_producto,
	pl_tipo,
	pl_moneda)
go


print '=====> cl_tabla.cl_tabla_Key2'
CREATE INDEX cl_tabla_Key2 ON cl_tabla (
        tabla)
go


print '=====> ad_tr_autorizada.ad_traut_rol_Key'
create index ad_traut_rol_Key on ad_tr_autorizada
(ta_rol,
 ta_transaccion)
go


print '=====> ad_procedure.ad_procedure_name_Key'
create index ad_procedure_name_Key on ad_procedure
(pd_procedure,
 pd_base_datos,
 pd_stored_procedure)
go

print '=====> ad_pro_transaccion.ad_transaccion_Key'
create index ad_transaccion_Key on ad_pro_transaccion
(pt_transaccion)
go

print '=====> cc_oficial.ofic_fun_Key'
CREATE UNIQUE INDEX ofic_fun_Key on cc_oficial(oc_funcionario)
go


print '=====> cl_medios_depar.cl_medios_depar_UQ'
create unique index cl_medios_depar_UQ
on cl_medios_depar (md_filial, md_descripcion)
go


print '=====> cl_medios_funcio.cl_medios_funcio_UQ'
create unique index cl_medios_funcio_UQ
on cl_medios_funcio (mf_descripcion)
go

print '=====> cl_medios_ofi.cl_medios_ofi_UQ'
create unique index cl_medios_ofi_UQ
on cl_medios_ofi (mo_filial, mo_descripcion)
go

/**************** TASAS REFERENCIALES ***************/
/* ARO: 4 de Julio  del 2000 */

print '=====> te_pizarra_FKey1'
go
CREATE INDEX te_pizarra_FKey1 
   ON te_pizarra (pi_cod_pizarra, pi_fecha_inicio, pi_fecha_fin, pi_moneda)
go

print '=====> te_pizarra_FKey2'
go
CREATE INDEX te_pizarra_FKey2
   ON te_pizarra (pi_referencia, pi_periodo, pi_modalidad, pi_tipo_tasa, pi_moneda)
go

print '=====> te_tasa_coap_FKey1'
go
CREATE INDEX te_tasa_coap_FKey1 
   ON te_tasa_coap (lc_fecha_inicio, lc_fecha_final, lc_moneda)
go

print '=====> te_tasa_divisas_FKey1 '
go
CREATE INDEX te_tasa_divisas_FKey1 
  ON te_tasa_divisas (td_fecha, td_moneda)
go

print '=====> te_divisa_futura_Key1  '
go
CREATE INDEX te_divisa_futura_FKey1 
   ON te_divisa_futura (df_moneda, df_fecha_inicio, df_fecha_fin)
go

/************* FIN DE TASAS REGERENCIALES ***********/


/************ ADMIN WEB ****************/

print '=====> aw_funcionalidad_KeyA'
go
CREATE INDEX aw_funcionalidad_KeyA
ON aw_funcionalidad(fn_padre)
go

/************ FIN ADMIN WEB ****************/
/***********  NUEVO BATCH   ****************/

print '=====> ba_log_operador_KEYA'
go

create index ba_log_operador_KEYA on ba_log_operador (lo_login,lo_rol,lo_osuser,lo_fecha)
go

/*********** FIN BATCH      ***************/

print '=====> ad_nodo_reentry_tmp_spid_idx  '
go

create index ad_nodo_reentry_tmp_spid_idx on ad_nodo_reentry_tmp_tbl (spid)
go

create default spid as @@spid
go

sp_bindefault spid,'ad_nodo_reentry_tmp_tbl.spid'

go

print 'ba_error_batch_idx  ...'
go
 
if exists (select 1 from sysindexes where name='ba_error_batch_idx')
   drop index ba_error_batch.ba_error_batch_idx
go 
 
CREATE INDEX ba_error_batch_idx on ba_error_batch
(
     er_fecha_proceso,
     er_sarta,
     er_batch
)
Go
