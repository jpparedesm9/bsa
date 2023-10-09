DECLARE @w_tabla INT

SELECT @w_tabla = codigo FROM cobis..cl_tabla WHERE tabla = 'cl_offices_barcodes'

SELECT * FROM cobis..cl_catalogo WHERE tabla = @w_tabla AND codigo = '9103'

DELETE cobis..cl_catalogo WHERE tabla = @w_tabla AND codigo = '9103'

SELECT * FROM cobis..cl_catalogo WHERE tabla = @w_tabla AND codigo = '9103'

go
