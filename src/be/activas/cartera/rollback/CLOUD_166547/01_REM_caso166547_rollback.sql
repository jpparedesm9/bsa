----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>
----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>
use cobis
go

select * from cl_parametro where pa_nemonico = 'ERCTRE' and pa_producto = 'CCA'
delete cl_parametro WHERE pa_nemonico = 'ERCTRE' and pa_producto = 'CCA'

----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>
----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>
use cobis
go

declare @w_batch int
select @w_batch = 7977--se toma el ultimo numero, puede variar.

--Nuevo
select * from ba_batch where ba_batch = @w_batch
delete from ba_batch where ba_batch = @w_batch
					  
select * from ba_parametro where pa_batch = @w_batch and pa_nombre = 'FECHA PROCESO'
delete from ba_parametro where pa_batch = @w_batch and pa_nombre = 'FECHA PROCESO'
go
