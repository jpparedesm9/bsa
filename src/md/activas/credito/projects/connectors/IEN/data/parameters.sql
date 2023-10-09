USE cobis
GO

SELECT * FROM cobis..cl_parametro
WHERE pa_producto = 'CRE'
AND pa_nemonico IN ('CRYPFL', 'CRYPSW')

DELETE FROM cobis..cl_parametro
WHERE pa_producto = 'CRE'
AND pa_nemonico IN ('CRYPFL', 'CRYPSW')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
VALUES ('RUTA DE ARCHIVOS DE IEN PARA PROCESOS DE CRIPTOGRAFIA', 'CRYPFL', 'C', 'cryptography', 'CRE')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
VALUES ('RUTA DE SOFTWARE DE CRIPTOGRAFIA', 'CRYPSW', 'C', 'c:\apicifrado\', 'CRE')

SELECT * FROM cobis..cl_parametro
WHERE pa_producto = 'CRE'
AND pa_nemonico IN ('CRYPFL', 'CRYPSW')

GO
