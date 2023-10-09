--------------------------------------------------------------------------
--- CARATULA DE CRÉDITO - anio
--------------------------------------------------------------------------
---Incluir en los instaladores de credito
select * from cobis..cl_parametro where pa_nemonico = 'RDADHS'
update cobis..cl_parametro
set pa_char = '14795-440-030864/02-01020-0319'
where pa_nemonico = 'RDADHS' and pa_producto = 'CRE'
select * from cobis..cl_parametro where pa_nemonico = 'RDADHS'
go

select * from cobis..cl_parametro where pa_nemonico = 'RDADHR'
update cobis..cl_parametro
set pa_char = '14795-440-030864/02-01020-0319'
where pa_nemonico = 'RDADHR' and pa_producto = 'CRE'
select * from cobis..cl_parametro where pa_nemonico = 'RDADHR'

delete cobis..cl_parametro where pa_nemonico = 'PPREPA' and pa_producto = 'CRE'

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PIE PERIODO REPORTES', 'PPREPA', 'C', '(032019)', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
go
