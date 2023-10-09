use cobis
go

declare 
@w_producto          int,
@w_rol               int

SELECT @w_producto = pd_producto 
FROM cl_producto 
WHERE pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

select ts_rol, ts_producto 
into #rol
from cobis..ad_servicio_autorizado
where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.validate'	

select * from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.customerEvaluation'
delete from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.customerEvaluation'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) values ('OrchestrationClientValidationServiceSERVImpl.customerEvaluation', 'com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService', 'customerEvaluation', 'customerEvaluation', NULL, 'N')

--borrar_ad_servicio_autorizado_168293
select * from ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.customerEvaluation'
delete ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.customerEvaluation'

SELECT '#_serv' = count(1) FROM ad_servicio_autorizado
SELECT '#_rol' = count(1) from #rol

insert into ad_servicio_autorizado
select
ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.customerEvaluation', 
ts_rol = ts_rol, 
ts_producto = ts_producto, 
ts_tipo = 'R', 
ts_moneda = 0, 
ts_fecha_aut =  getdate(), 
ts_estado = 'V', 
ts_fecha_ult_mod = getdate()
from #rol

SELECT '#_serv' = count(1) FROM ad_servicio_autorizado

DROP TABLE #rol
GO
