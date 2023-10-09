use cobis
go

select * from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.customerEvaluation'
delete from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.customerEvaluation'

--borrar_ad_servicio_autorizado_168293
select * from ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.customerEvaluation'
delete ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.customerEvaluation'

GO
