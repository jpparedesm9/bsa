use cobis
go

select * from cobis..cl_parametro where pa_nemonico='MEREIN' and pa_producto='CCA'


delete cobis..cl_parametro where pa_nemonico='MEREIN' and pa_producto='CCA'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MESES REPORTE INDIVIDUAL', 'MEREIN', 'I', NULL, NULL, NULL, 4, NULL, NULL, NULL, 'CCA')

select * from cobis..cl_parametro where pa_nemonico='MEREIN' and pa_producto='CCA'

go
