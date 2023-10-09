use cobis
go

delete cl_parametro
where pa_nemonico = 'COPAPE'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('COLOCAR PAGOS EN PENDIENTE', 'COPAPE', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'ADM')

select  *
from cl_parametro
where pa_nemonico = 'COPAPE'

delete cl_parametro
where pa_nemonico = 'DAVPAP'



insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIAS ANTES VALIDA PAGOS PENDIENTE', 'DAVPAP', 'T', NULL, 1, NULL, NULL, NULL, NULL, NULL, 'ADM')


select  *
from cl_parametro
where pa_nemonico = 'DAVPAP'
