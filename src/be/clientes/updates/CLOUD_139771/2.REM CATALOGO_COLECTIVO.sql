USE cobis
GO

DECLARE
@w_tabla          int

SELECT @w_tabla = codigo FROM cl_tabla WHERE tabla = 'cl_colectivo'

DELETE cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cl_colectivo' and valor= 'SUPER RED')


INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'SR', 'SUPER RED', 'V', NULL, NULL, NULL)


SELECT * FROM cl_catalogo WHERE tabla = @w_tabla