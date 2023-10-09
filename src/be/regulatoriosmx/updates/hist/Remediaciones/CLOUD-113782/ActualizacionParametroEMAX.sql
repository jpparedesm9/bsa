
select *
from cobis..cl_parametro
where pa_nemonico = 'EMAX'
and pa_producto = 'CLI'

update cobis..cl_parametro
set   pa_tinyint  = 85
where pa_nemonico = 'EMAX'
and   pa_producto = 'CLI'



select *
from cobis..cl_parametro
where pa_nemonico = 'EMAX'
and pa_producto = 'CLI'