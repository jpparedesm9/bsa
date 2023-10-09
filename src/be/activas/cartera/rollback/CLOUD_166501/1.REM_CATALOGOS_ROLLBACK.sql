USE cobis
GO

declare 
@w_tabla           int 

DELETE cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cl_socio_comercial')
DELETE cl_tabla WHERE tabla = 'cl_socio_comercial'

select @w_tabla = isnull(max(codigo),0)
from cl_tabla

update cobis..cl_seqnos
set siguiente = @w_tabla
where tabla = 'cl_tabla'

go