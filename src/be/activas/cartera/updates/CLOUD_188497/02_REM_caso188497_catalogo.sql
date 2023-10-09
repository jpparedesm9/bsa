DECLARE @w_tabla INT

SELECT @w_tabla = codigo FROM cobis..cl_tabla WHERE tabla = 'cl_offices_barcodes'

SELECT * FROM cobis..cl_catalogo WHERE tabla = @w_tabla AND codigo = '9103'

DELETE cobis..cl_catalogo WHERE tabla = @w_tabla AND codigo = '9103'

insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, '9103', 'VIRTUAL', 'V', NULL, NULL, NULL)

SELECT * FROM cobis..cl_catalogo WHERE tabla = @w_tabla AND codigo = '9103'

go
