------------->>>>>>>>>>>>>script 
use cobis
go

select * from cobis..cl_parametro
where pa_nemonico         in ('NRSPN1','NRSPN2')
and   pa_producto         = 'CRE'

delete cl_parametro where pa_nemonico = 'NRSPN1'

delete cl_parametro where pa_nemonico = 'NRSPN2'

select * from cobis..cl_parametro
where pa_nemonico         in ('NRSPN1','NRSPN2')
and   pa_producto         = 'CRE'

go
