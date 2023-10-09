/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S143267 CC Formato KYC - Reporte
--Fecha                      : 14/11/2017
--Descripción del Problema   : Se agrega un sp nuevo por lo que no tiene las respectivas autorizaciones y registros
--Descripción de la Solución : Generar el script para registrar el sp en las tablas respectivas
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/


---------------------------------------------------------------------------------------
-------------------------Registrar Servicio de Consulta de KYC-------------------------
---------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : cl_error.sql

use cobis
go

delete cobis..cl_errores
where numero in (103158, 103159)

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103158, 1, 'Error, uno de los integrantes del grupo es Vinculado.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103159, 1, 'Error, el cliente es Vinculado.')
GO
