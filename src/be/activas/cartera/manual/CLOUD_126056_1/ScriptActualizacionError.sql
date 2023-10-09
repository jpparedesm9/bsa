
select *
from cobis..cl_errores
where numero = 6900070


update cobis..cl_errores
set mensaje = 'Producto bancario deshabilitado'
where numero = 6900070


select *
from cobis..cl_errores
where numero = 6900070
