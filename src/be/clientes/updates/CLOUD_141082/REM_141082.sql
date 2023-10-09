use cobis
go

delete cl_parametro where pa_nemonico = 'DIRECO' AND pa_producto = 'CCA'
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS PRIMER REPORTE DE CONSENTIMIENTO', 'DIRECO', 'I', NULL, NULL, NULL, 112, NULL, NULL, NULL, 'CCA')

delete cl_errores where numero =720333
INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (720333, 0, 'ERROR: LOS VALORES DEL SEGURO NO HA SIDO PAGADOS')

GO
