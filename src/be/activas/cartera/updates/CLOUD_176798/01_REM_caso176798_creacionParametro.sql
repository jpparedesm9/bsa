use cobis
go

------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>
------------------>>>>>>>>>>>>>>>>>> Creacion de parametro
------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>

select * from cl_parametro where pa_nemonico = 'NPRLCR' and pa_producto = 'CCA'
delete from cl_parametro where pa_nemonico = 'NPRLCR' and pa_producto = 'CCA'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO DE PAGOS PARA REACTIVAR LINEA DE CREDITO', 'NPRLCR', 'I', NULL, NULL, NULL, 0, NULL, NULL, NULL, 'CCA')
go

------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>
------------------>>>>>>>>>>>>>>>>>> Actualización de datos
------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>------------------>>>>>>>>>>>>>>>>>>
declare @w_numero int
select @w_numero = 724685
select * from cobis..cl_errores WHERE numero = @w_numero

update cobis..cl_errores set mensaje = 'Se deben tener al menos # pagos' where numero = @w_numero

select * from cobis..cl_errores WHERE numero = @w_numero

go
