use cobis
go

delete cl_parametro where pa_nemonico in ('ELAMCP','ELAM3M', 'ELAM6M')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON MERCHANT CASH PAYMENT','ELAMCP', 'C', '184541', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON MERCHANT 3 MONTH WITHOUT INT','ELAM3M', 'C', '157490', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON MERCHANT 6 MONTH WITHOUT INTT','ELAM6M', 'C', '157491', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
go
