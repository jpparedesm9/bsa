use cobis
go


delete from cobis..cl_parametro where pa_nemonico in ('MOBROL', 'MOBOFF', 'MOBEXP', 'MOBIDT', 'SMDES') and pa_producto = 'ADM'

--Parametros para mobile santander
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('Rol de conexion movil para oficiales','MOBROL','I', null,null,null,3,null,null,null,'ADM')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('Oficina de conexion movil para oficiales','MOBOFF','I', null,null,null,9001,null,null,null,'ADM')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('Tiempo de expiracion de sesion en segundos para moviles', 'MOBEXP', 'I', null, null, null, 14400, null, null, null, 'ADM')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('Tiempo de inactividad pantalla de login en segundos', 'MOBIDT', 'I', null, null, null, 600, null, null, null, 'ADM')

INSERT INTO cobis.dbo.cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_int, pa_producto)
VALUES ('NUMERO DE DIAS MINIMO ENTRE SINCRONIZACIONES', 'SMDES', 'I', 5, 'ADM')


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


delete cl_parametro where pa_nemonico in ('EMING', 'EMAXG', 'IMING',  'PMING','TASAG', 'CMATG', 'MMING', 'MMAXG', 'FRQ1G', 'FRQ2G', 'CATVL')
insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('EDAD MINIMA CREDITO GRUPAL DIGITAL', 'EMING', 'I', NULL, NULL, NULL, 25, NULL, NULL, NULL, 'CRE')

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
values ('TASA CREDITO GRUPAL DIGITAL', 'TASAG', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 84.0, 'CRE')

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('COMISION ATRASO CREDITO GRUPAL DIGITAL', 'CMATG', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 200.0, 'CRE')

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CAT CREDITO GRUPAL', 'CATVL', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 88.0, 'CRE')

go
