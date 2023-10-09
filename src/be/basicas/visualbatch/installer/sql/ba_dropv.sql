/*	Script de eliminacion de vistas del	*/
/*	modulo de VISUAL BATCH	*/



use cobis
go


/* ts_batch */
print '=====> ts_batch'
go
if exists (select * from sysobjects where name = 'ts_batch' )
	DROP VIEW ts_batch
go

/* ts_sarta */
print '=====> ts_sarta'
go
if exists (select * from sysobjects where name = 'ts_sarta' )
	DROP VIEW ts_sarta
go

/* ts_sarta_batch */
print '=====> ts_sarta_batch'
go
if exists (select * from sysobjects where name = 'ts_sarta_batch' )
	DROP VIEW ts_sarta_batch
go

/* ts_batch_param */
print '=====> ts_batch_param'
go
if exists (select * from sysobjects where name = 'ts_batch_param' )
	DROP VIEW ts_batch_param
go


/* ts_lectura */
print '=====> ts_lectura'
go
if exists (select * from sysobjects where name = 'ts_lectura' )
	DROP VIEW ts_lectura
go