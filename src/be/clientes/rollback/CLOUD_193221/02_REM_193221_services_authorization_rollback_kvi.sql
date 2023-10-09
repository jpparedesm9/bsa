use cobis
go

select * from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.clientEvaluation'
delete from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.clientEvaluation'
select * from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.clientEvaluation'

select * from ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.clientEvaluation'
delete ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.clientEvaluation'
select * from ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.clientEvaluation'


--Guardado de Aceptacion - R193221 - B2B Grupal Digital---------------------
select * from cts_serv_catalog where csc_service_id = 'BusinessToBusiness.SecurityManagement.SaveAcceptance'
delete from cts_serv_catalog where csc_service_id = 'BusinessToBusiness.SecurityManagement.SaveAcceptance'
select * from cts_serv_catalog where csc_service_id = 'BusinessToBusiness.SecurityManagement.SaveAcceptance'

select * from ad_servicio_autorizado where ts_servicio = 'BusinessToBusiness.SecurityManagement.SaveAcceptance'
delete ad_servicio_autorizado where ts_servicio = 'BusinessToBusiness.SecurityManagement.SaveAcceptance'
select * from ad_servicio_autorizado where ts_servicio = 'BusinessToBusiness.SecurityManagement.SaveAcceptance'

go
