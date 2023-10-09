use cobis
go

delete cl_parametro where pa_nemonico in ('EMINS', 'EMAXS', 'IMINS',  'PMINS','TASAS', 'CMATS')
insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('EDAD MINIMA CREDITO SIMPLE', 'EMINS', 'I', NULL, NULL, NULL, 25, NULL, NULL, NULL, 'CRE')

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('EDAD MAXIMA CREDITO SIMPLE', 'EMAXS', 'I', NULL, NULL, NULL, 50, NULL, NULL, NULL, 'CRE')

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('INGRESO MINIMO CREDITO SIMPLE', 'IMINS', 'M', NULL, NULL, NULL, NULL, 1500, NULL, NULL, 'CRE')

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PLAZO MINIMO CREDITO SIMPLE', 'PMINS', 'I', NULL, NULL, NULL, 6, NULL, NULL, NULL, 'CRE')

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('TASA CREDITO SIMPLE', 'TASAS', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 84, 'CRE')

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('COMISION ATRASO CREDITO SIMPLE', 'CMATS', 'I', NULL, NULL, NULL, 50, NULL, NULL, NULL, 'CRE')


delete cl_parametro where pa_nemonico in ('EMING', 'EMAXG', 'IMING',  'PMING', 'CMATG', 'MMING', 'MMAXG', 'FRQ1G', 'FRQ2G', 'CATVL')
insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('EDAD MINIMA CREDITO GRUPAL DIGITAL', 'EMING', 'I', NULL, NULL, NULL, 20, NULL, NULL, NULL, 'CRE')

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('EDAD MAXIMA CREDITO GRUPAL DIGITAL', 'EMAXG', 'I', NULL, NULL, NULL, 85, NULL, NULL, NULL, 'CRE')

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MONTO MINIMO CREDITO GRUPAL DIGITAL', 'MMING', 'M', NULL, NULL, NULL, NULL, 6000, NULL, NULL, 'CRE')

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MONTO MAXIMO CREDITO GRUPAL DIGITAL', 'MMAXG', 'M', NULL, NULL, NULL, NULL, 57000, NULL, NULL, 'CRE')

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('FRECUENCIA 1 CREDITO GRUPAL DIGITAL', 'FRQ1G', 'C', 'SEMANAL', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('FRECUENCIA 2 CREDITO GRUPAL DIGITAL', 'FRQ2G', 'C', 'MENSUAL', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('INGRESO MINIMO CREDITO GRUPAL DIGITAL', 'IMING', 'M', NULL, NULL, NULL, NULL, 1500, NULL, NULL, 'CRE')

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PLAZO MINIMO CREDITO GRUPAL DIGITAL', 'PMING', 'I', NULL, NULL, NULL, 4, NULL, NULL, NULL, 'CRE')

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('COMISION ATRASO CREDITO GRUPAL DIGITAL', 'CMATG', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 200.0, 'CRE')

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CAT CREDITO GRUPAL', 'CATVL', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 88.0, 'CRE')

go