
--select TOP 100 * from ca_param_seguro_externo

SELECT TOP 100 * FROM cobis..cl_parametro WHERE pa_producto = 'CRE' AND pa_nemonico = 'SEVIDV'

DELETE cobis..cl_parametro WHERE pa_producto = 'CRE' AND pa_nemonico = 'SEVIDV'

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('VALIDA VALOR MONTO DEL SEGURO', 'SEVIDV', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

SELECT TOP 100 * FROM cobis..cl_parametro WHERE pa_producto = 'CRE' AND pa_nemonico = 'SEVIDV'
GO

