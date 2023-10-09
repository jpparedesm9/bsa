----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>
----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>ROLLBACK
----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>

DELETE cobis..cl_parametro WHERE pa_nemonico = 'PPREPR'
DELETE cobis..cl_parametro WHERE pa_nemonico = 'PPREPL'

INSERT INTO dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PIE PERIODO RENOVACIONES', 'PPREPR', 'C', '(JUR-963)', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
GO


INSERT INTO dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PIE PERIODO RENOVACIONES PIE LEGAL', 'PPREPL', 'C', '-(062021)', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
GO