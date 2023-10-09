use cobis
go 




delete cl_parametro where pa_nemonico = 'LCRGRA' and pa_producto = 'CCA'


insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('LCR DIAS DE GRACIA', 'LCRGRA', 'I', NULL, NULL, NULL, 7, NULL, NULL, NULL, 'CCA')
