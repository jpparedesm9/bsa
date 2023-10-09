select pa_char, * from cobis..cl_parametro
where pa_nemonico = 'RDRECA'
and pa_producto = 'CRE'

update cobis..cl_parametro
set pa_char = '14795-439-028351/02-00343-0119'
where pa_nemonico = 'RDRECA'
and pa_producto = 'CRE'
go

select pa_char, * from cobis..cl_parametro
where pa_nemonico = 'PPREPA'
and pa_producto = 'CRE'

update cobis..cl_parametro
set pa_char = '(032019)'
where pa_nemonico = 'PPREPA'
and pa_producto = 'CRE'

select * from cobis..cl_parametro 
where pa_producto = 'CRE' and pa_nemonico in ('ACOVIT')

delete from cobis..cl_parametro 
where pa_producto = 'CRE' and pa_nemonico in ('ACOVIT')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ACTIVAR CAMBIO POR COVIT', 'ACOVIT', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
GO

select * from cobis..cl_parametro 
where pa_producto = 'CRE' and pa_nemonico in ('ACOVIT')
go
