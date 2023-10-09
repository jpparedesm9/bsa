/*	Esquema para la eliminacion de indices por clave primaria */ 
/*	de la Base de Datos. */
/*	Generado por gendropp. */
/*	Wed Sep 22 17:09:36 EDT 1993 */


use cob_remesas
go


print 're_codigo_Key'
if exists (select i.name from sysindexes i, sysobjects o
    where i.id = o.id and i.name = 're_codigo_Key' and o.name = 'pe_pro_rango_edad')
drop index pe_pro_rango_edad.re_codigo_Key
go

/* pro_bancario_Key */
print 'pro_bancario_Key'
if exists (select * from sysindexes
	where name = 'pro_bancario_Key')
drop index pe_pro_bancario.pro_bancario_Key
go

/* mercado_Key */
print 'mercado_Key'
if exists (select * from sysindexes
	where name = 'mercado_Key')
drop index pe_mercado.mercado_Key
go

/* basico_Key */
print 'basico_Key'
if exists (select * from sysindexes
	where name = 'basico_Key')
drop index pe_basico.basico_Key
go

/* pro_final_Key */
print 'pro_final_Key'
if exists (select * from sysindexes
	where name = 'pro_final_Key')
drop index pe_pro_final.pro_final_Key
go

/* servicio_dis_Key */
print 'servicio_dis_Key'
if exists (select * from sysindexes 
    where name = 'servicio_dis_Key')
drop index pe_servicio_dis.servicio_dis_Key
go

/* pe_cambio_costo_Key */
print 'pe_cambio_costo_Key'
if exists (select * from sysindexes
	where name = 'pe_cambio_costo_Key')
drop index pe_cambio_costo.pe_cambio_costo_Key
go

/* var_servicio_Key */
print 'var_servicio_Key'
if exists (select * from sysindexes
	where name = 'var_servicio_Key')
drop index pe_var_servicio.var_servicio_Key
go

/* tipo_rango_Key */
print 'tipo_rango_Key'
if exists (select * from sysindexes
	where name = 'tipo_rango_Key')
drop index pe_tipo_rango.tipo_rango_Key
go

/* servicio_per_Key */
print 'servicio_per_Key'
if exists (select * from sysindexes
	where name = 'servicio_per_Key')
drop index pe_servicio_per.servicio_per_Key
go

/* rango_Key */
print 'rango_Key'
if exists (select * from sysindexes
	where name = 'rango_Key')
drop index pe_rango.rango_Key
go

/* pe_cambio_costo_Key */
print 'pe_cambio_costo_Key'
if exists (select * from sysindexes
	where name = 'pe_cambio_costo_Key')
drop index pe_cambio_costo.pe_cambio_costo_Key
go

/* servicio_contr_Key */
print 'servicio_contr_Key'
if exists (select * from sysindexes
	where name = 'servicio_contr_Key')
drop index pe_servicio_contr.servicio_contr_Key
go

/* val_contratado_Key */
print 'val_contratado_Key'
if exists (select * from sysindexes
	where name = 'val_contratado_Key')
drop index pe_val_contratado.val_contratado_Key
go

/* limite_Key */
print 'limite_Key'
if exists (select * from sysindexes
	where name = 'limite_Key')
drop index pe_limite.limite_Key
go


/* equiv_servtrn_Key */
print 'equiv_servtrn_Key'
if exists (select * from sysindexes
	where name = 'equiv_servtrn_Key')
drop index pe_equiv_serv_trn.equiv_servtrn_Key
go

/* pe_causales_restringidas_1 */
print 'pe_causales_restringidas_1'
if exists (select * from sysindexes
	where name = 'pe_causales_restringidas_1')
drop index pe_causales_restringidas.pe_causales_restringidas_1
go

/* costo_Key */
print 'costo_Key'
if exists (select * from sysindexes
	where name = 'costo_Key')
drop index pe_costo.costo_Key
go

/* costo_especial_Key */
print 'costo_especial_Key'
if exists (select * from sysindexes
	where name = 'costo_especial_Key')
drop index pe_costo_especial.costo_especial_Key
go

/* costo_especial_per_Key */
print 'costo_especial_per_Key'
if exists (select * from sysindexes
	where name = 'costo_especial_per_Key')
drop index pe_costo_especial_per.costo_especial_per_Key
go



/* pe_limites_restrictivos_1 */
print 'pe_limites_restrictivos_1'
if exists (select * from sysindexes
	where name = 'pe_limites_restrictivos_1')
drop index pe_limites_restrictivos.pe_limites_restrictivos_1
go



/* pe_par_comision_Key */
print 'pe_par_comision_Key'
if exists (select * from sysindexes
	where name = 'pe_par_comision_Key')
drop index pe_par_comision.pe_par_comision_Key
go

/* servicio_dis_Key */
print 'servicio_dis_Key'
if exists (select * from sysindexes
	where name = 'servicio_dis_Key')
drop index pe_servicio_dis.servicio_dis_Key
go