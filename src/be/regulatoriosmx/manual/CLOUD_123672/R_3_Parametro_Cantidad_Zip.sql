select * from cobis..cl_parametro where pa_nemonico = 'NUFAEM' and pa_producto = 'ADM'

update cobis..cl_parametro 
set pa_int = 250
where pa_nemonico = 'NUFAEM' 
and pa_producto = 'ADM'

select * from cobis..cl_parametro where pa_nemonico = 'NUFAEM' and pa_producto = 'ADM'
 