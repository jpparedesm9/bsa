use cobis
go


print '=====>ad_llave_Key'
go
if exists (select name from sysindexes where name='ad_llave_Key')
	drop index ad_llave.ad_llave_Key
go

/* ad_llave */
print '=====> ad_llave'
if exists ( select * from sysobjects where name = 'ad_llave' )
	drop TABLE ad_llave
go

create table ad_llave (
	ll_nombre		varchar(16)	null,
	ll_tipo			char(1)		null,
	ll_estado		char(1)		null,
	ll_llave		varbinary(16)	null
)
go

print '=====> Clave Principal de ad_llave'
CREATE UNIQUE INDEX ad_llave_Key ON ad_llave (
	ll_nombre)
go
