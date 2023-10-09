USE cobis
GO

declare 
@w_tabla           int 

DELETE cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cl_proveedor_correo')
DELETE cl_tabla WHERE tabla = 'cl_proveedor_correo'

select @w_tabla = isnull(max(codigo),0) + 1
from cl_tabla

INSERT INTO cl_tabla (codigo, tabla, descripcion) VALUES (@w_tabla, 'cl_proveedor_correo', 'PROVEEDOR DE CORREOS')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'INFOBIP', 'informaciondetucredito@informacion.tuiio.com.mx', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'TELEFONICA', 'informaciondetucredito@tuiio.com.mx', 'V', NULL, NULL, NULL)


update cobis..cl_seqnos
set siguiente = @w_tabla
where tabla = 'cl_tabla'

go
