---version 2
select * from cobis..cl_parametro 
where pa_producto = 'CRE' and pa_nemonico in ('ACOVIT')

delete from cobis..cl_parametro 
where pa_producto = 'CRE' and pa_nemonico in ('ACOVIT')

go
