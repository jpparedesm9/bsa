-------Rollback Req.185234 - Seguros Individual 
use cobis
go

delete cl_parametro where pa_nemonico in ('MVAMSI') and pa_producto='CCA' 
go
