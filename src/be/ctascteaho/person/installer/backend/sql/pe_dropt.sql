/*	Esquema para la eliminacion de tablas y vistas */
/*	de la Base de Datos. */
/*	Generado por gendropt. */
/*	Wed Sep 22 16:46:05 EDT 1993 */

print 'ELIMINACION DE TABLAS'
go

/* pe_prod_bancario */
use cob_remesas
go

if exists (select * from sysobjects where name = 'pe_pro_bancario')
	drop TABLE pe_pro_bancario
go

/* pe_limite */
print 'ELIMINA TABLA ====> pe_limite'
go
if exists (select * from sysobjects where name = 'pe_limite')
    drop TABLE pe_limite
go

/* pe_mercado */
print 'ELIMINA TABLA ====> pe_mercado'
go
if exists (select * from sysobjects where name = 'pe_mercado')
    drop TABLE pe_mercado
go

/* pe_basico */
print 'ELIMINA TABLA ====> pe_basico'
go
if exists (select * from sysobjects where name = 'pe_basico')
    drop TABLE pe_basico
go

/* pe_pro_final */
print 'ELIMINA TABLA ====> pe_pro_final'
go
if exists (select * from sysobjects where name = 'pe_pro_final')
    drop TABLE pe_pro_final
go

/* pe_servicio_dis */
print 'ELIMINA TABLA ====> pe_servicio_dis'
go
if exists (select * from sysobjects where name = 'pe_servicio_dis')
    drop TABLE pe_servicio_dis
go

/* pe_tipo_rango */
print 'ELIMINA TABLA ====> pe_tipo_rango'
go
if exists (select * from sysobjects where name = 'pe_tipo_rango')
    drop TABLE pe_tipo_rango
go

/* pe_var_servicio */
print 'ELIMINA TABLA ====> pe_var_servicio'
go
if exists (select * from sysobjects where name = 'pe_var_servicio')
    drop TABLE pe_var_servicio
go

/* pe_cambio_val_contr */
print 'ELIMINA TABLA ====> pe_cambio_val_contr'
go
if exists (select * from sysobjects where name = 'pe_cambio_val_contr')
    drop TABLE pe_cambio_val_contr
go

/* pe_servicio_per */
print 'ELIMINA TABLA ====> pe_servicio_per'
go
if exists (select * from sysobjects where name = 'pe_servicio_per')
    drop TABLE pe_servicio_per
go

/* pe_rango */
print 'ELIMINA TABLA ====> pe_rango'
go
if exists (select * from sysobjects where name = 'pe_rango')
    drop TABLE pe_rango
go

/* pe_costo */
print 'ELIMINA TABLA ====> pe_costo'
go
if exists (select * from sysobjects where name = 'pe_costo')
    drop TABLE pe_costo
go

/* pe_cambio_costo */
print 'ELIMINA TABLA ====> pe_cambio_costo'
go
if exists (select * from sysobjects where name = 'pe_cambio_costo')
    drop TABLE pe_cambio_costo
go

/* pe_val_contratado */
print 'ELIMINA TABLA ====> pe_val_contratado'
go
if exists (select * from sysobjects where name = 'pe_val_contratado')
    drop TABLE pe_val_contratado
go

/* pe_servicio_contr */
print 'ELIMINA TABLA ====> pe_servicio_contr'
go
if exists (select * from sysobjects where name = 'pe_servicio_contr')
    drop TABLE pe_servicio_contr
go

/* vista pe_ts_costo */
if exists (select * from sysobjects where name = 'pe_ts_costo')
	drop VIEW pe_ts_costo
go

/* vista pe_ts_cambio_costo */
if exists (select * from sysobjects where name = 'pe_ts_cambio_costo')
	drop VIEW pe_ts_cambio_costo
go

/* vista pe_ts_val_contratado */
if exists (select * from sysobjects where name = 'pe_ts_val_contratado')
	drop VIEW pe_ts_val_contratado
go

/* vista pe_ts_personaliza */
if exists (select * from sysobjects where name = 'pe_ts_personaliza')
	drop VIEW pe_ts_personaliza
go

/* pe_tran_servicio */
print 'ELIMINA TABLA ====> pe_tran_servicio'
go
if exists (select * from sysobjects where name = 'pe_tran_servicio')
    drop TABLE pe_tran_servicio
go

/* pe_equiv_serv_trn */
print 'ELIMINA TABLA ====> pe_equiv_serv_trn'
go
if exists (select * from sysobjects where name = 'pe_equiv_serv_trn')
    drop TABLE pe_equiv_serv_trn
go

/* pe_capitaliza_profinal */
print 'ELIMINA TABLA ====> pe_capitaliza_profinal'
go
if exists (select * from sysobjects where name = 'pe_capitaliza_profinal')
    drop TABLE pe_capitaliza_profinal
go

/* pe_categoria_profinal */
print 'ELIMINA TABLA ====> pe_categoria_profinal'
go
if exists (select * from sysobjects where name = 'pe_categoria_profinal')
    drop TABLE pe_categoria_profinal
go

/* pe_causales_restringidas */
print 'ELIMINA TABLA ====> pe_causales_restringidas'
go
if exists (select * from sysobjects where name = 'pe_causales_restringidas')
    drop TABLE pe_causales_restringidas
go

/* pe_ciclo_profinal */
print 'ELIMINA TABLA ====> pe_ciclo_profinal'
go
if exists (select * from sysobjects where name = 'pe_ciclo_profinal')
    drop TABLE pe_ciclo_profinal
go



/* pe_costo_especial */
print 'ELIMINA TABLA ====> pe_costo_especial'
go
if exists (select * from sysobjects where name = 'pe_costo_especial')
    drop TABLE pe_costo_especial
go

/* pe_costo_especial_per */
print 'ELIMINA TABLA ====> pe_costo_especial_per'
go
if exists (select * from sysobjects where name = 'pe_costo_especial_per')
    drop TABLE pe_costo_especial_per
go





/* pe_limites_restrictivos */
print 'ELIMINA TABLA ====> pe_limites_restrictivos'
go
if exists (select * from sysobjects where name = 'pe_limites_restrictivos')
    drop TABLE pe_limites_restrictivos
go



/* pe_oficina_autorizada */
print 'ELIMINA TABLA ====> pe_oficina_autorizada'
go
if exists (select * from sysobjects where name = 'pe_oficina_autorizada')
    drop TABLE pe_oficina_autorizada
go

/* pe_par_com_trn */
print 'ELIMINA TABLA ====> pe_par_com_trn'
go
if exists (select * from sysobjects where name = 'pe_par_com_trn')
    drop TABLE pe_par_com_trn
go

/* pe_par_comision */
print 'ELIMINA TABLA ====> pe_par_comision'
go
if exists (select * from sysobjects where name = 'pe_par_comision')
    drop TABLE pe_par_comision
go

/* pe_pro_bancario */
print 'ELIMINA TABLA ====> pe_pro_bancario'
go
if exists (select * from sysobjects where name = 'pe_pro_bancario')
    drop TABLE pe_pro_bancario
go



/* pe_producto_contractual */
print 'ELIMINA TABLA ====> pe_producto_contractual'
go
if exists (select * from sysobjects where name = 'pe_producto_contractual')
    drop TABLE pe_producto_contractual
go

/* pe_servicio_ws */
print 'ELIMINA TABLA ====> pe_servicio_ws'
go
if exists (select * from sysobjects where name = 'pe_servicio_ws')
    drop TABLE pe_servicio_ws
go

/* pe_tope_oficina */
print 'ELIMINA TABLA ====> pe_tope_oficina'
go
if exists (select * from sysobjects where name = 'pe_tope_oficina')
    drop TABLE pe_tope_oficina
go

/* pe_var_servicio_CCA554 */
print 'ELIMINA TABLA ====> pe_var_servicio_CCA554'
go
if exists (select * from sysobjects where name = 'pe_var_servicio_CCA554')
    drop TABLE pe_var_servicio_CCA554
go


if exists (select * from sysobjects where name = 'pe_pro_rango_edad')
    drop TABLE pe_pro_rango_edad
go


if exists (select 1 from sysobjects where name ='re_contrato_producto')
    drop table cob_remesas..re_contrato_producto
go

/* Tablas que se encuentran en la base de datos de historicos */

use cob_remesas_his
go

/* pe_his_ts */
if exists (select * from sysobjects where name = 'pe_his_ts')
	drop TABLE pe_his_ts
go


if exists (select * from sysobjects where name = 're_camara_hist')
	drop TABLE re_camara_hist
go
