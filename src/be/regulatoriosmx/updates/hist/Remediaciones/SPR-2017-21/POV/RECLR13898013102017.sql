/**********************************************************************************************************************/
--No Bug                     : NA
--T�tulo de la Historia      : 
--Fecha                      : 17/10/2017
--Descripci�n del Problema   : Usuario caducado
--Descripci�n de la Soluci�n : Actualizar fecha de usuario caducado
--Autor                      : Pa�l Ortiz Vera
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