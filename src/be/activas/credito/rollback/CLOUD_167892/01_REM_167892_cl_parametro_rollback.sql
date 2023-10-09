use cobis
go

update cl_parametro
set pa_char = '14795-440-033778/01-03870-1120'
where pa_nemonico = 'RDADHR' and pa_producto = 'CRE'

update cl_parametro
set pa_char = '(112020)'
where pa_nemonico = 'PPREPA' and pa_producto = 'CRE'

update cl_parametro
set pa_char = '14795-440-033778/01-03870-1120'
where pa_nemonico = 'RDADHS' and pa_producto = 'CRE'

go
