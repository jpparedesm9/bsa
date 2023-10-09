use cobis
go
delete from cl_parametro where pa_nemonico in ('DATRE','MXILC','RADBL') and pa_producto='CCA'
delete from cl_errores where numero in (724683,724684,724685,724686)
go
use cob_cartera
go

if object_id ('dbo.ca_lcr_autoriza_bloqueo') is not null
	drop table dbo.ca_lcr_autoriza_bloqueo
go