use cob_cartera
go

IF OBJECT_ID ('dbo.ca_datos_simulacion') is not null
	drop table dbo.ca_datos_simulacion
go

------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>
------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>
use cobis
go

select * from cl_errores where numero = 70076
delete cl_errores where numero = 70076

------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>
------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>
use cobis
go

delete from cl_parametro 
where pa_producto = 'CCA' and pa_nemonico in ('VTSPRO', 'VTNPRO')
go
