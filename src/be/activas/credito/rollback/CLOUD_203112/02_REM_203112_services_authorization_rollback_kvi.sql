use cobis
go

select * from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.blackListValidation'
delete from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.blackListValidation'
select * from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.blackListValidation'

select * from ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.blackListValidation'
delete ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.blackListValidation'
select * from ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.blackListValidation'

go 
