use cobis
go


delete cl_parametro where pa_nemonico in ('MINATR','MAXATR')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MINIMO ATRASO REPORTE MOROSIDAD', 'MINATR', 'I', NULL, NULL, NULL, 1, NULL, NULL, NULL, 'CCA')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MAXIMO ATRASO REPORTE MOROSIDAD', 'MAXATR', 'I', NULL, NULL, NULL, 180, NULL, NULL, NULL, 'CCA')
GO
