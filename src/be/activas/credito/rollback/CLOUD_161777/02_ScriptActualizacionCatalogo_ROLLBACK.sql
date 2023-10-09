

select *
from cobis..cl_catalogo
where tabla = 857


update cobis..cl_catalogo set
estado = 'V'
where tabla = 857
and codigo <> 'BW'

select *
from cobis..cl_catalogo
where tabla = 857
