USE cobis
GO
delete FROM  cobis..cl_parametro WHERE pa_nemonico IN('NDCCAB','NDCCCE') AND 
pa_producto='CRE'
delete FROM  cobis..cl_parametro WHERE pa_nemonico IN('OAA') AND 
pa_producto='CWF'
delete from cobis..cl_errores  where numero IN (2109004,2109005,2109006)

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUM DIAS CUENTAS ABIERTAS', 'NDCCAB', 'I', NULL, NULL, NULL, 90, NULL, NULL, NULL, 'CRE')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUM DIAS CUENTAS CERRADAS', 'NDCCCE', 'I', NULL, NULL, NULL, 360, NULL, NULL, NULL, 'CRE')
--REM Sandino
INSERT INTO cobis..cl_parametro (pa_parametro,	pa_nemonico,	pa_tipo,	pa_char,	pa_tinyint,	pa_smallint,	pa_int,	pa_money,	pa_datetime,	pa_float,	pa_producto)
VALUES ('OBSERVACION AUTOMATICA ASESOR',	'OAA',  	'I',	NULL,	NULL,	NULL,	4,	NULL,	NULL,	NULL,	'CWF')

--cr Errores
INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (2109004, 0, 'NO EXISTE PARAMETRO DIAS CUENTAS ABIERTAS')
INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (2109005, 0, 'NO EXISTE PARAMETRO DIAS CUENTAS CERRADAS')
INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (2109006, 0, 'Error el Porcentaje de Incremento Grupal es Menor o Igual que -100%')

SELECT * FROM cobis..cl_parametro WHERE pa_nemonico IN('NDCCAB','NDCCCE')


SELECT * FROM cobis..cl_errores WHERE numero IN (2109004,2109005,2109006)

GO








