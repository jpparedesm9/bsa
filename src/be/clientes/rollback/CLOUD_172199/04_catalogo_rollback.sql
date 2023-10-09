use cobis
GO

DECLARE
@w_tabla int

--Tomo valor de la tabla de la cl_seqnos
SELECT @w_tabla = codigo FROM cobis..cl_tabla WHERE tabla = 'cl_cla_con'

DELETE FROM cobis..cl_catalogo where tabla = @w_tabla

DELETE FROM cobis..cl_tabla where codigo = @w_tabla

--Actualizo la cl_seqnos

UPDATE cobis..cl_seqnos
SET siguiente = (SELECT MAX(codigo) FROM cobis..cl_tabla ) + 1
WHERE tabla = 'cl_tabla'
GO