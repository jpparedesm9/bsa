--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
USE cobis
go

select * from cl_parametro where pa_producto = 'CRE' and pa_nemonico = 'CDOGEN'

delete cl_parametro where pa_producto = 'CRE' and pa_nemonico = 'CDOGEN'

go
