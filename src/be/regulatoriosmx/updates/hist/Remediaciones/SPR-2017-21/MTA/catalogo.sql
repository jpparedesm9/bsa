/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : N/A
--Fecha                      : 26/10/2017
--Descripción del Problema   : Modificar catalogo de parentesco
--Descripción de la Solución : Modificar catalogo de parentesco
--Autor                      : MARIA JOSE TACO
--SQL                        : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql/cl_catalogo.sql
/**********************************************************************************************************************/

use cobis
go

DECLARE @w_codigo INT

SELECT @w_codigo= codigo FROM cobis..cl_tabla WHERE tabla = 'cl_parentesco'
DELETE cobis..cl_catalogo WHERE tabla = @w_codigo

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'AB', 'ABUELO','V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'CU', 'CUNADO','V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'HE', 'HERMANO','V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'HI', 'HIJO','V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'MA', 'MADRE','V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'PA', 'PADRE','V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'SU', 'SUEGRO','V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'YE', 'YERNO','V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'NU', 'NUERA','V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'NI', 'NIETO','V')
go


