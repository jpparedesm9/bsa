use cobis
go

delete from cobis..cl_parametro where pa_nemonico in ('RRPATH') and pa_producto = 'ADM'

--Ruta Reporte de Reintegro
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('RUTA REPORTE REINTEGROS','RRPATH','C','C:\WorkFolder\',null,null,null,null,null,null,'ADM')

go
