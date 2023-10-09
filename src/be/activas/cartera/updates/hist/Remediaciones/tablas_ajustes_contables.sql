use cob_cartera
go
IF OBJECT_ID ('dbo.ca_operacion_ext') IS NOT NULL
	DROP TABLE dbo.ca_operacion_ext
GO
IF OBJECT_ID ('dbo.ca_operacion_ext_his') IS NOT NULL
	DROP TABLE dbo.ca_operacion_ext_his
GO
CREATE TABLE dbo.ca_operacion_ext(
oe_operacion int,
oe_dias_mora_anterior int
)
GO

CREATE TABLE dbo.ca_operacion_ext_his(
oeh_secuencial int,
oeh_operacion int,
oeh_dias_mora_anterior int
)
GO

 use cobis
go

DELETE cobis..cl_parametro WHERE pa_nemonico IN ('PRERE','PCAPRE') AND pa_producto = 'CCA'
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PORCENTAJE RENOVACION REESTRUCTURACION', 'PRERE', 'I', NULL, NULL, NULL, 80, NULL, NULL, NULL, 'CCA')
GO
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PORCENTAJE CAPITAL RENOVAR', 'PCAPRE', 'I', NULL, NULL, NULL, 40, NULL, NULL, NULL, 'CCA')
GO

DELETE cobis..cl_errores WHERE numero in (724592,724594,724590,724595,724596,724597)
GO

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (724592, 0, 'Error. No se ha definido parametro de IMO')
GO

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (724594, 0, 'NO SE HA DEFINIDO PARAMETRO DE PORCENTAJE CAPITAL RENOVAR')
GO

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (724590, 0, 'NO SE HA DEFINIDO PARAMETRO DE PORCENTAJE RENOVACION REESTRUCTURACION')
GO

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (724595, 0, 'ERROR AL INSERTAR DIAS DE MORA EN LA TABLA CA_OPERACION_EXT')
GO

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (724596, 0, 'NO FUE POSIBLE GUARDAR HISTORICOS DE DIAS MORA')
GO

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (724597, 0, 'NO FUE POSIBLE RECUPERAR HISTORICOS DE DIAS MORA')
GO