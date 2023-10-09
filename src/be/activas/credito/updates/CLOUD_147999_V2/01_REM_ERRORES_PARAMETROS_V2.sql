use cobis
go

--PARÁMETROS FLUJO DE RENOVACIÓN
delete from cl_parametro where pa_nemonico in ('WSCRN1','WSCRN2','TTPREN')

INSERT INTO cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES 
('WORKFLOW SOLICITUD CREDITO RENOVACION PARTE 1', 'WSCRN1', 'C', 'SOLICITUD CREDITO GRUPAL', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

INSERT INTO cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES 
('WORKFLOW SOLICITUD CREDITO RENOVACION PARTE 2', 'WSCRN2', 'C', ' - RENOVACIÓN', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

INSERT INTO cl_parametro 
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES 
('TIEMPO TRANSCURRIDO RENOVACION', 'TTPREN', 'I', NULL, NULL, NULL, 0, NULL, NULL, NULL, 'CRE')

go