use cob_remesas
go

if exists (select * from sysobjects 
where name = 'pe_ts_cambio_costo')
	drop view pe_ts_cambio_costo
go

if exists (select * from sysobjects 
			where name = 'pe_ts_costo')
	drop view pe_ts_costo
go

if exists (select * from sysobjects 
			where name = 'pe_ts_val_contratado')
	drop view pe_ts_val_contratado
go

if exists (select * from sysobjects 
			where name = 'pe_ts_personaliza')
	drop view pe_ts_personaliza
go

if exists (select * from sysobjects 
			where name = 'ts_tope_oficina')
	drop view ts_tope_oficina
go

if exists (select * from sysobjects 
			where name = 'ts_limites_restrictivos')
	drop view ts_limites_restrictivos
go

if exists (select * from sysobjects 
			where name = 'ts_causales_restringidas')
	drop view ts_causales_restringidas
go

if exists (select * from sysobjects 
			where name = 'pe_ts_contrato_producto')
	drop view pe_ts_contrato_producto
go
