USE cobis
GO

DECLARE @w_tabla INT 
SELECT @w_tabla =  codigo FROM cobis..cl_tabla WHERE tabla = 'cl_tipo_mercado'

SELECT * FROM cobis..cl_tabla WHERE codigo = @w_tabla
SELECT * FROM cobis..cl_catalogo WHERE tabla = @w_tabla

DELETE cobis..cl_catalogo WHERE tabla = @w_tabla

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'AV', 'AVON', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'CC', 'Cliente Candidato', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'I', 'INDEPENDIENTE', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'ID', 'INDEPENDIENTE COLECTIVO', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'SR', 'SUPER RED', 'V', NULL, NULL, NULL)
GO
