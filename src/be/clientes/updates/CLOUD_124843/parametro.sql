use cobis 
go


delete from cl_parametro where pa_nemonico='PAGNC'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PAGINACION CLIENTES', 'PAGNC', 'I', NULL, NULL, NULL, 20, NULL, NULL, NULL, 'ADM')
go
