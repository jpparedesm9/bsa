USE cobis
GO

SELECT * FROM cobis..cl_parametro
WHERE pa_producto = 'CRE'
AND pa_nemonico IN ('BLPATH', 'BLNAME')

DELETE FROM cobis..cl_parametro
WHERE pa_producto = 'CRE'
AND pa_nemonico IN ('BLPATH', 'BLNAME')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
VALUES ('LISTA NEGRA - RUTA ARCHIVO', 'BLPATH', 'C', 'E:\LN\', 'CRE')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
VALUES ('LISTA NEGRA - NOMBRE ARCHIVO', 'BLNAME', 'C', 'SofomSantander.txt', 'CRE')

SELECT * FROM cobis..cl_parametro
WHERE pa_producto = 'CRE'
AND pa_nemonico IN ('BLPATH', 'BLNAME')

GO
