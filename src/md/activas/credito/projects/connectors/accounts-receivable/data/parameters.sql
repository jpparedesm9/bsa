USE cobis
GO

SELECT * FROM cobis..cl_parametro
WHERE pa_producto = 'CRE'
AND pa_nemonico IN ('PRGRNT', 'PRCRDT')

DELETE FROM cobis..cl_parametro
WHERE pa_producto = 'CRE'
AND pa_nemonico IN ('PRGRNT', 'PRCRDT')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
VALUES ('PAGO REFERENCIADO - GARANTIA', 'PRGRNT', 'C', '65506362002', 'CRE')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
VALUES ('PAGO REFERENCIADO - CREDITO', 'PRCRDT', 'C', '65506362155', 'CRE')

SELECT * FROM cobis..cl_parametro
WHERE pa_producto = 'CRE'
AND pa_nemonico IN ('PRGRNT', 'PRCRDT')

GO
