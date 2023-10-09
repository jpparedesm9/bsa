use cobis
go

------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>
------------------>>>>>>>>>>>>>>>>>> Creacion de parametro
------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>

select * from cl_parametro where pa_nemonico = 'NPRLCR' and pa_producto = 'CCA'
delete from cl_parametro where pa_nemonico = 'NPRLCR' and pa_producto = 'CCA'

------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>
------------------>>>>>>>>>>>>>>>>>> Actualización de datos
------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>
declare @w_numero int
select @w_numero = 724685
select * from cobis..cl_errores WHERE numero = @w_numero

update cobis..cl_errores set mensaje = 'Se deben tener al menos 2 pagos' where numero = @w_numero
go
