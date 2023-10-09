use cobis
go

delete cl_parametro where pa_nemonico in ('ELAENV')
--ELAVON
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON ENVIROMENT','ELAENV', 'C', 'PROD', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
go
