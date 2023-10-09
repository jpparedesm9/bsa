
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : ERROR EN ETAPA INGRESO DE SOLICITUD PRUEBA INTEGRAL
--Fecha                      : 21/07/2017
--Descripción del Problema   : No existen los parametros para los sp pues son nuevos
--Descripción de la Solución : Agregar los parametros 
--Autor                      : Paúl Ortiz Vera
--Instalador                 : cr_parametro.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- CREACION DE PARAMETROS PARA WORKFLOW
--------------------------------------------------------------------------------------------
use cobis
go


delete
cobis..cl_parametro WHERE pa_nemonico = 'MESVCC'
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('Meses de vigencia del Cuestionario del cliente', 'MESVCC', 'T', null, 6, NULL, NULL, NULL, NULL, NULL, 'CRE')
GO


delete
cobis..cl_parametro WHERE pa_nemonico = 'PORPAT'
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('Porcentaje Patrimonio', 'PORPAT', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 30.0, 'CRE')
GO


delete
cobis..cl_parametro WHERE pa_nemonico = 'PATTI'
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('Patrimonio Técnico Institucional', 'PATTI', 'M', 'NULL', NULL, NULL, NULL, 100000000, NULL, NULL, 'CRE')
GO


delete
cobis..cl_parametro WHERE pa_nemonico = 'PORCGP'
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PORCENTAJE GARANTIA PREDETERMINADO', 'PORCGP', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 10, 'CCA')
GO



