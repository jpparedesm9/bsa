use cobis
go

--PARÁMETROS FLUJO DE RENOVACIÓN
delete from cl_parametro where pa_nemonico in ('PTRREN','PCAREN', 'ATMREN','ATAREN','CICREN', 'RDTGRP', 'PORREN', 'MNPRTG')

INSERT INTO cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES 
('PORCENTAJE DE PLAZO TRANSCURRIDO DE RENOVACION', 'PTRREN', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 80, 'CRE')

INSERT INTO cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES 
('PORCENTAJE DE CAPITAL DE RENOVACION', 'PCAREN', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 60, 'CRE')

INSERT INTO cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES 
('ATRASO MAXIMO DE RENOVACION', 'ATMREN', 'I', NULL, NULL, 30, NULL, NULL, NULL, NULL, 'CRE')

INSERT INTO cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES 
('ATRASO ACTUAL DE RENOVACION', 'ATAREN', 'I', NULL, NULL, 0, NULL, NULL, NULL, NULL, 'CRE')

INSERT INTO cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES 
('CICLO DE RENOVACION', 'CICREN', 'I', NULL, NULL, 4, NULL, NULL, NULL, NULL, 'CRE')

INSERT INTO cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES 
('REDUCCION TASA GRUPAL RENOVACION', 'RDTGRP', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 3.0, 'CRE')

INSERT INTO cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES 
('PORCENTAJE REINGRESO RENOVACION', 'PORREN', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 20, 'CRE')

INSERT INTO cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES 
('MINIMO PORCENTAJE TASA GRUPAL', 'MNPRTG', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 70, 'CRE')

--ERRORES FLUJO DE RENOVACIÓN
delete cl_errores where numero in (2108080, 2108081, 2108082, 2108083, 2108084, 2108085, 2108086)
insert into cl_errores(numero, severidad, mensaje) 
values (2108080,0,'ERROR: EL GRUPO NO TIENE UNA OPERACION VIGENTE')
insert into cl_errores(numero, severidad, mensaje) 
values (2108081,0,'ERROR: NO HA TRANSCURRIDO EL TIEMPO REQUERIDO PARA LA OPERACION A RENOVAR')
insert into cl_errores(numero, severidad, mensaje) 
values (2108082,0,'ERROR: NO HA CUBIERTO EL CAPITAL REQUERIDO PARA LA OPERACION A RENOVAR')
insert into cl_errores(numero, severidad, mensaje) 
values (2108083,0,'ERROR: EL GRUPO TIENE DIAS DE ATRASO EN LA CUOTA ACTUAL')
insert into cl_errores(numero, severidad, mensaje) 
values (2108084,0,'ERROR: EL GRUPO TIENE MAS DIAS DE ATRASO DE LOS PERMITIDOS')
insert into cl_errores(numero, severidad, mensaje) 
values (2108085,0,'ERROR: EL GRUPO NO SE ENCUENTRA EN EL CICLO PERMITIDO')
insert into cl_errores(numero, severidad, mensaje) 
values (2108086,0,'ERROR: LA OPERACION TIENE UNA SOLICITUD DE CRÉDITO EN EJECUCIÓN')
go