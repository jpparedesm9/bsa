use cobis
go

select * from cl_parametro where pa_producto = 'CLI' AND pa_nemonico = 'EXTVDC'

delete cl_parametro where pa_producto = 'CLI' AND pa_nemonico = 'EXTVDC'

go
