/*
*   Archivo para crear parametros iniciales requerimiento 141620
*   Johan castro
*   04/09/2020
*/
use cobis
GO 

delete from cl_parametro where pa_nemonico IN ('NRPOLZ','ANPOLZ','SEPROZ','SVIDAZ','SIFCEZ','SIFMIZ','SCANZ','COMSEZ','MONSEZ','DIRECZ','AMBISZ', 'FEINZU','RGASE1', 'RGASE2')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('ANIO POLIZA ZURICH', 'ANPOLZ', 'I', NULL, NULL, NULL, 2020, NULL, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('COMISION POR SEGURO ZURICH', 'COMSEZ', 'M', NULL, NULL, NULL, NULL, NULL, NULL, 0.0, 'CCA')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('DIAS PRIMER REPORTE DE CONSENTIMIENTO SEGZURCH', 'DIRECZ', 'I', NULL, NULL, NULL, 112, NULL, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('SUMA MONTO SEGURO ZURICH', 'MONSEZ', 'M', NULL, NULL, NULL, NULL, 12.0000, NULL, NULL, 'ADM')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('NO POLIZA ZURICH', 'NRPOLZ', 'C', 'ZUR-10060-', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('SUMA ASEGURADA CANCER SEGZURICH', 'SCANZ ', 'M', NULL, NULL, NULL, NULL, 5000.0000, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('SEGURO PRODUCTO ZURICH', 'SEPROZ', 'C', 'CNFS-S0018-0461-2020', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('SUMA ASEGURADA ZURICH INFARTO CEREBRAL', 'SIFCEZ', 'M', NULL, NULL, NULL, NULL, 5000.0000, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('SUMA ASEGURADA ZURICH INFARTO AL MIOCARIO', 'SIFMIZ', 'M', NULL, NULL, NULL, NULL, 5000.0000, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('SUMA ASEGURADA ZURICH VIDA', 'SVIDAZ', 'M', NULL, NULL, NULL, NULL, 20000.0000, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('AMBIENTE ZURICH (AZUR)', 'AMBISZ', 'C', 'PROD', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES('FECHA INICIO ZURICH', 'FEINZU', 'D', NULL, NULL, NULL, NULL, NULL, '10/24/2020', NULL, 'CCA')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES 
('REPORTE CARATULA GRUPAL ASEGURADORA 1', 'RGASE1', 'C', 'ZURICH SANTANDER SEGUROS', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

INSERT INTO cobis..cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES 
('REPORTE CARATULA GRUPAL ASEGURADORA 2', 'RGASE2', 'C', ' MEXICO, S.A.', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

go