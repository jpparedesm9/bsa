USE cobis
GO

declare 
@w_tabla           int 

DELETE cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cl_socio_comercial')
DELETE cl_tabla WHERE tabla = 'cl_socio_comercial'

select @w_tabla = isnull(max(codigo),0) + 1
from cl_tabla

INSERT INTO cl_tabla (codigo, tabla, descripcion) VALUES (@w_tabla, 'cl_socio_comercial', 'SOCIO COMERCIAL')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'SODI', 'SODIMAC', 'V', NULL, NULL, NULL)


update cobis..cl_seqnos
set siguiente = @w_tabla
where tabla = 'cl_tabla'

go