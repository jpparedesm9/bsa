use cobis
go

--antes de modificacion
select * from cobis..cl_parametro
where pa_nemonico in ('RDADHR', 'PPREPA', 'RDADHS')
and pa_producto = 'CRE'

--modificacion
update cobis..cl_parametro
set pa_char = '14795-440-033778/02-01832-0521'
where pa_nemonico = 'RDADHR'
and pa_producto = 'CRE'

update cobis..cl_parametro
set pa_char = '(012023)'
where pa_nemonico = 'PPREPA'
and pa_producto = 'CRE'

update cobis..cl_parametro
set pa_char = '14795-440-033778/02-01832-0521'
where pa_nemonico = 'RDADHR'
and pa_producto = 'CRE'

--despues de modificacion
select * from cobis..cl_parametro
where pa_nemonico in ('RDADHR', 'PPREPA', 'RDADHS')
and pa_producto = 'CRE'

go
