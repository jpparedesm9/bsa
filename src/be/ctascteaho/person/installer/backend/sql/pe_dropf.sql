/*	Esquema para la eliminacion de indices por clave foranea */ 
/*	de la Base de Datos. */
/*	Generado por gendropp. */
/*	Wed Sep 22 17:10:09 EDT 1993 */


use cob_remesas
go

/* basico_Key */
print 'basico_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'basico_Key' and o.name = 'pe_basico')
drop index pe_basico.basico_Key
go

/* i_mercado */
print 'i_mercado'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'i_mercado' and o.name = 'pe_mercado')
drop index pe_mercado.i_mercado
go

/* i_pro_final */
print 'i_pro_final'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'i_pro_final' and o.name = 'pe_pro_final')
drop index pe_pro_final.i_pro_final
go

/* i_servicio_dis */
print 'i_servicio_dis'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'i_servicio_dis' and o.name = 'pe_servicio_dis')
drop index pe_servicio_dis.i_servicio_dis
go

/* i_servicio_per */
print 'i_servicio_per'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'i_servicio_per' and o.name = 'pe_servicio_per')
drop index pe_servicio_per.i_servicio_per
go

/* pe_cambio_costo_Key */
print 'pe_cambio_costo_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'pe_cambio_costo_Key' and o.name = 'pe_cambio_costo')
drop index pe_cambio_costo.pe_cambio_costo_Key
go

/* pe_causales_restringidas_1 */
print 'pe_causales_restringidas_1'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'pe_causales_restringidas_1' and o.name = 'pe_causales_restringidas')
drop index pe_causales_restringidas.pe_causales_restringidas_1
go

/* costo_Key */
print 'costo_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'costo_Key' and o.name = 'pe_costo')
drop index pe_costo.costo_Key
go

/* costo_especial_Key */
print 'costo_especial_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'costo_especial_Key' and o.name = 'pe_costo_especial')
drop index pe_costo_especial.costo_especial_Key
go

/* costo_especial_per_Key */
print 'costo_especial_per_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'costo_especial_per_Key' and o.name = 'pe_costo_especial_per')
drop index pe_costo_especial_per.costo_especial_per_Key
go

/* equiv_servtrn_Key */
print 'equiv_servtrn_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'equiv_servtrn_Key' and o.name = 'pe_equiv_serv_trn')
drop index pe_equiv_serv_trn.equiv_servtrn_Key
go

/* limite_Key */
print 'limite_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'limite_Key' and o.name = 'pe_limite')
drop index pe_limite.limite_Key
go

/* pe_limites_restrictivos_1 */
print 'pe_limites_restrictivos_1'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'pe_limites_restrictivos_1' and o.name = 'pe_limites_restrictivos')
drop index pe_limites_restrictivos.pe_limites_restrictivos_1
go



/* mercado_Key */
print 'mercado_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'mercado_Key' and o.name = 'pe_mercado')
drop index pe_mercado.mercado_Key
go

/* idx_oa_oficina */
print 'idx_oa_oficina'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'idx_oa_oficina' and o.name = 'pe_oficina_autorizada')
drop index pe_oficina_autorizada.idx_oa_oficina
go

/* idx1 */
print 'idx1'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'idx1' and o.name = 'pe_par_com_trn')
drop index pe_par_com_trn.idx1
go

/* pe_par_comision_Key */
print 'pe_par_comision_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'pe_par_comision_Key' and o.name = 'pe_par_comision')
drop index pe_par_comision.pe_par_comision_Key
go

/* pro_bancario_Key */
print 'pro_bancario_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'pro_bancario_Key' and o.name = 'pe_pro_bancario')
drop index pe_pro_bancario.pro_bancario_Key
go



/* pro_final_Key */
print 'pro_final_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'pro_final_Key' and o.name = 'pe_pro_final')
drop index pe_pro_final.pro_final_Key
go

/* rango_Key */
print 'rango_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'rango_Key' and o.name = 'pe_rango')
drop index pe_rango.rango_Key
go

/* servicio_contr_Key */
print 'servicio_contr_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'servicio_contr_Key' and o.name = 'pe_servicio_contr')
drop index pe_servicio_contr.servicio_contr_Key
go



/* servicio_dis_Key */
print 'servicio_dis_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'servicio_dis_Key' and o.name = 'pe_servicio_dis')
drop index pe_servicio_dis.servicio_dis_Key
go



/* servicio_per_Key */
print 'servicio_per_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'servicio_per_Key' and o.name = 'pe_servicio_per')
drop index pe_servicio_per.servicio_per_Key
go

/* tipo_rango_Key */
print 'tipo_rango_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'tipo_rango_Key' and o.name = 'pe_tipo_rango')
drop index pe_tipo_rango.tipo_rango_Key
go

/* val_contratado_Key */
print 'val_contratado_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'val_contratado_Key' and o.name = 'pe_val_contratado')
drop index pe_val_contratado.val_contratado_Key
go

/* var_servicio_Key */
print 'var_servicio_Key'
if exists (select i.name from sysindexes i, sysobjects o
	where i.id = o.id and i.name = 'var_servicio_Key' and o.name = 'pe_var_servicio')
drop index pe_var_servicio.var_servicio_Key
go

