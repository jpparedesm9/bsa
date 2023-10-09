use cobis
go

select * from cl_parametro where pa_producto = 'CLI' AND pa_nemonico = 'EXTVDC'

delete cl_parametro where pa_producto = 'CLI' AND pa_nemonico = 'EXTVDC'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('Extensiones válidas para Documentos', 'EXTVDC', 'C', 'PDF;PNG;JPG', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
go
