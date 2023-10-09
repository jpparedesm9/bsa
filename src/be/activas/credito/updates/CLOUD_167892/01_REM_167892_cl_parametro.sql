use cobis
go

update cl_parametro
set pa_char = '14795-440-033778/02-01832-0521'
where pa_nemonico = 'RDADHR' and pa_producto = 'CRE'

update cl_parametro
set pa_char = '(082021)'
where pa_nemonico = 'PPREPA' and pa_producto = 'CRE'

update cl_parametro
set pa_char = '14795-440-033778/02-01832-0521'
where pa_nemonico = 'RDADHS' and pa_producto = 'CRE'

go
