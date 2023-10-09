use cobis
go

DECLARE
@w_tabla          int,
@w_codigo         int

DELETE cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cl_tipo_identif_bio')
DELETE cl_tabla WHERE tabla = 'cl_tipo_identif_bio'

SELECT @w_tabla = max(isnull(codigo,0)) +1
FROM cl_tabla 

INSERT INTO cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'cl_tipo_identif_bio', 'Tipo de Identificación Biométrico')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'INE', 'INE', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'IFE', 'IFE', 'V', NULL, NULL, NULL)


DELETE cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cl_respuesta_renapo')
DELETE cl_tabla WHERE tabla = 'cl_respuesta_renapo'

SELECT @w_tabla = max(isnull(codigo,0)) +1
FROM cl_tabla 

INSERT INTO cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'cl_respuesta_renapo', 'Respuesta Renapo')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'N', 'PENDIENTE', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'I', 'NO EXISTEN DATOS', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'E', 'ERROR DE CONEXIÓN', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'S', 'VALIDADO', 'V', NULL, NULL, NULL)


SELECT @w_tabla = codigo 
FROM cl_tabla
where tabla = 'cr_doc_digitalizado_ind'

DELETE cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cr_doc_digitalizado_ind')
and codigo = '009'

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '009', 'ACTA DE NACIMIENTO', 'V', NULL, NULL, NULL)



SELECT @w_tabla = codigo 
FROM cl_tabla
where tabla = 'cr_doc_prospecto'

DELETE cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cr_doc_prospecto')
and codigo = '009'

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '009', 'ACTA DE NACIMIENTO', 'V', NULL, NULL, NULL)

go


