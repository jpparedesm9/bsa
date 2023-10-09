/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : 
--Fecha                      : 13/10/2017
--Descripción del Problema   : No existen errores en la base de Sustaining
--Descripción de la Solución : Insertar errores
--Autor                      : Paúl Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS MOBILEMANAGEMENT
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo          	 : cl_error.sql


use cobis 
go

DELETE cobis..cl_errores WHERE numero in (208932, 208933, 103156)

INSERT INTO cobis..cl_errores VALUES ( 208932,1, 'POR FAVOR INGRESE EL LUGAR DE REUNION')

INSERT INTO cobis..cl_errores VALUES ( 208933,1, 'EL GRUPO NO CUENTA CON LUGAR DE REUNION, POR FAVOR INGRESE')

INSERT INTO cobis..cl_errores VALUES ( 103156,1, ' Error el grupo tiene un trámite en ejecución. ')


