/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-R117557 Modificaciones - Demo 1
--Fecha                      : 21/06/2017
--Descripción del Problema   : Registros (Catalogos) de prospectos desactualizados, generan error en la carga de pantalla
--Descripción de la Solución : Actualizar los registros a los nuevos valores
--Autor                      : Paúl Ortiz Vera
--Instalador                 : ----
--Ruta Instalador            : ----
/**********************************************************************************************************************/

-- Correccion de Data

use cobis
go


UPDATE 
cl_ente 
SET p_profesion = '001'
 WHERE p_profesion  IS NOT NULL 

UPDATE 
cl_ente 
SET p_nivel_estudio = '001'
 WHERE p_nivel_estudio  IS NOT NULL 

UPDATE 
cl_ente 
SET p_estado_civil = 'SO'
 WHERE p_estado_civil = 'SE'

UPDATE 
cl_ente 
SET p_estado_civil = 'CA'
 WHERE p_estado_civil = 'CS'

UPDATE 
cl_ente 
SET p_estado_civil = 'UN'
 WHERE p_estado_civil = 'US'
 
UPDATE 
cl_ente 
SET en_tipo_ced = 'CURP'
 WHERE en_tipo_ced = 'CI'