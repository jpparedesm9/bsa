-----------------------------------------------------------------------------------
-- REMEDIACIONES COLECTIVOS - 
-----------------------------------------------------------------------------------
use cobis
go

delete cts_serv_catalog 
 where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.validateBuroFromSantander'
 
delete ad_servicio_autorizado 
 where ts_servicio='OrchestrationClientValidationServiceSERVImpl.validateBuroFromSantander'
