use cobis
go

select ts_rol, ts_producto 
into #rol
from cobis..ad_servicio_autorizado
where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.validate'	

select * from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.blackListValidation'

delete from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.blackListValidation'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
values ('OrchestrationClientValidationServiceSERVImpl.blackListValidation', 'com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService', 'blackListValidation', 'blackListValidation', null, 'N')

select * from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.blackListValidation'


select * from ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.blackListValidation'

delete ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.blackListValidation'

insert into ad_servicio_autorizado
select
ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.blackListValidation', 
ts_rol = ts_rol, 
ts_producto = ts_producto, 
ts_tipo = 'R', 
ts_moneda = 0, 
ts_fecha_aut =  getdate(), 
ts_estado = 'V', 
ts_fecha_ult_mod = getdate()
from #rol

select * from ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.blackListValidation'


drop table #rol
go
