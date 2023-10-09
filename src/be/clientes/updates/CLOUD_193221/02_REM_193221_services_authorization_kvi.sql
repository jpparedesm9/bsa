use cobis
go

select ts_rol, ts_producto 
into #rol
from cobis..ad_servicio_autorizado
where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.customerEvaluation'	

select * from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.clientEvaluation'

delete from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.clientEvaluation'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
values ('OrchestrationClientValidationServiceSERVImpl.clientEvaluation', 'com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService', 'clientEvaluation', 'clientEvaluation', NULL, 'N')

select * from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.clientEvaluation'


select * from ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.clientEvaluation'

delete ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.clientEvaluation'

insert into ad_servicio_autorizado
select
ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.clientEvaluation', 
ts_rol = ts_rol, 
ts_producto = ts_producto, 
ts_tipo = 'R', 
ts_moneda = 0, 
ts_fecha_aut =  getdate(), 
ts_estado = 'V', 
ts_fecha_ult_mod = getdate()
from #rol

select * from ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.clientEvaluation'


drop table #rol
go


--Guardado de Aceptacion - R193221 - B2B Grupal Digital---------------------
use cobis
go 

declare @rol int, @w_producto int
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CARTERA'

--Antes
select * from cts_serv_catalog where csc_service_id = 'BusinessToBusiness.SecurityManagement.SaveAcceptance'

delete cts_serv_catalog where csc_service_id = 'BusinessToBusiness.SecurityManagement.SaveAcceptance'

insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
values ('BusinessToBusiness.SecurityManagement.SaveAcceptance', 'cobiscorp.ecobis.businesstobusiness.service.ISecurityManagement', 'saveAcceptance', '', 0)

--Despues
select * from cts_serv_catalog where csc_service_id = 'BusinessToBusiness.SecurityManagement.SaveAcceptance'


--Antes
select * from ad_servicio_autorizado where ts_servicio = 'BusinessToBusiness.SecurityManagement.SaveAcceptance'

delete ad_servicio_autorizado where ts_servicio = 'BusinessToBusiness.SecurityManagement.SaveAcceptance'

select @rol = ro_rol 
from cobis..ad_rol
where ro_descripcion = 'ADMINISTRADOR'

if @@rowcount <> 0 and @rol is not null begin
  insert into dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
  values ('BusinessToBusiness.SecurityManagement.SaveAcceptance', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
end 

select @rol = ro_rol 
from cobis..ad_rol
where ro_descripcion = 'ASESOR'

if @@rowcount <> 0 and @rol is not null begin
   insert into dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   values ('BusinessToBusiness.SecurityManagement.SaveAcceptance', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
end 

select @rol = ro_rol 
from cobis..ad_rol
where ro_descripcion = 'ASESOR MOVIL'

if @@rowcount <> 0 and @rol is not null begin
   insert into dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   values ('BusinessToBusiness.SecurityManagement.SaveAcceptance', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
end

--Despues
select * from ad_servicio_autorizado where ts_servicio = 'BusinessToBusiness.SecurityManagement.SaveAcceptance'

go 




-- -----------------------------------------------------------------------------------------------------
use cobis
GO
declare @w_rol int,	@w_producto int

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'
    
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.VerifyContact')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', csc_method_name = 'verifyContact', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.VerifyContact'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.CustomerManagement.VerifyContact', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'verifyContact', '', 0)

delete from ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CustomerManagement.VerifyContact'
insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.VerifyContact', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())


go
