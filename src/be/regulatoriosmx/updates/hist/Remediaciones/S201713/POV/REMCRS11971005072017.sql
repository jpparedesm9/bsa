
/**********************************************************************************************************************/
--No Bug                     : NA
--T�tulo de la Historia      : CGS-S119710 Validaci�n de Cancelaci�n de Cr�dito Vigente - Flujo Grupal
--Fecha                      : 05/07/2017
--Descripci�n del Problema   : No existen los parametros para los sp pues son nuevos
--Descripci�n de la Soluci�n : Agregar los parametros 
--Autor                      : Pa�l Ortiz Vera
--Instalador                 : cr_parametro.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- CREACION DE PARAMETROS PARA WORKFLOW
--------------------------------------------------------------------------------------------

use cobis
go

DELETE FROM dbo.cl_parametro
WHERE ( pa_nemonico = 'MESVCC' AND pa_producto = 'CRE')or
( pa_nemonico = 'PORPAT' AND pa_producto = 'CRE')or
( pa_nemonico = 'PATTI' AND pa_producto = 'CRE')
GO


INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('Meses de vigencia del Cuestionario del cliente', 'MESVCC', 'T', null, 6, NULL, NULL, NULL, NULL, NULL, 'CRE')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('Porcentaje Patrimonio', 'PORPAT', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 30.0, 'CRE')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('Patrimonio T�cnico Institucional', 'PATTI', 'M', 'NULL', NULL, NULL, NULL, 100000000, NULL, NULL, 'CRE')
GO

