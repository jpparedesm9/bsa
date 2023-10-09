/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : 
--Fecha                      : 17/10/2017
--Descripción del Problema   : Usuario caducado
--Descripción de la Solución : Actualizar fecha de usuario caducado
--Autor                      : Paúl Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS MOBILEMANAGEMENT
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo          	 : 


use cobis 
go

UPDATE cobis..ad_usuario 
SET us_fecha_ult_mod = '12/30/2017 0:00:00'
WHERE us_login = 'admuser'

/* Actualizar parametro para no consultar buro real */ 


UPDATE cobis..cl_parametro
SET pa_int = 1
WHERE pa_nemonico = 'SIMSAN'