/**********************************************************************************************************************/
--No Bug                     : NA
--T�tulo de la Historia      : CGS-S134123 Pantalla Datos Conyugue
--Fecha                      : 13/08/2017
--Descripci�n del Problema   : No existen permisos de Nuevos Servicios
--Descripci�n de la Soluci�n : Insertar permisos para Nuevos Servicios
--Autor                      : Pa�l Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS MOBILEMANAGEMENT
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo          	 : cl_services_authorization.sql

use cobis go

DELETE cobis..cl_errores WHERE numero = 103155

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103155, 0, ' Revisar el estado civil de las personas relacionadas. ')
GO