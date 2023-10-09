use cobis
go

--antes de modificacion
select * from cobis..cl_parametro
where pa_nemonico in ('RDADHR', 'PPREPA', 'RDADHS')
and pa_producto = 'CRE'

--modificacion
update cobis..cl_parametro
set pa_char = '14795-440-033778/03-00350-0122'
where pa_nemonico = 'RDADHR'
and pa_producto = 'CRE'

update cobis..cl_parametro
set pa_char = '(062023)'
where pa_nemonico = 'PPREPA'
and pa_producto = 'CRE'

update cobis..cl_parametro
set pa_char = '14795-440-033778/03-00350-0122'
where pa_nemonico = 'RDADHS'
and pa_producto = 'CRE'

--despues de modificacion
select * from cobis..cl_parametro
where pa_nemonico in ('RDADHR', 'PPREPA', 'RDADHS')
and pa_producto = 'CRE'

go
