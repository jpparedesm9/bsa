
use cobis
GO

IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.BusinessPartnerReference.PurchaseConfirmation')
UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.IBusinessPartnerReference', csc_method_name = 'purchaseConfirmation', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'CustomerDataManagementService.BusinessPartnerReference.PurchaseConfirmation'
ELSE
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.BusinessPartnerReference.PurchaseConfirmation', 'cobiscorp.ecobis.customerdatamanagementservice.service.IBusinessPartnerReference', 'purchaseConfirmation', '', 0)
GO

IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.BusinessPartnerReference.QueryReference')
UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.IBusinessPartnerReference', csc_method_name = 'queryReference', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'CustomerDataManagementService.BusinessPartnerReference.QueryReference'
ELSE
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.BusinessPartnerReference.QueryReference', 'cobiscorp.ecobis.customerdatamanagementservice.service.IBusinessPartnerReference', 'queryReference', '', 0)
GO

IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.BusinessPartnerReference.ValidateReference')
UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.IBusinessPartnerReference', csc_method_name = 'validateReference', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'CustomerDataManagementService.BusinessPartnerReference.ValidateReference'
ELSE
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.BusinessPartnerReference.ValidateReference', 'cobiscorp.ecobis.customerdatamanagementservice.service.IBusinessPartnerReference', 'validateReference', '', 0)
GO

DECLARE @w_rol int, @w_producto INT,@w_moneda TINYINT,@w_rol_1 int
SELECT @w_rol = ro_rol from cobis..ad_rol where ro_descripcion='SOCIO COMERCIAL'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'

if not exists (select 1 from ad_servicio_autorizado 
	where ts_servicio = 'CustomerDataManagementService.BusinessPartnerReference.PurchaseConfirmation'
	and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)    
    insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
    values('CustomerDataManagementService.BusinessPartnerReference.PurchaseConfirmation', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())

if not exists (select 1 from ad_servicio_autorizado 
	where ts_servicio = 'CustomerDataManagementService.BusinessPartnerReference.QueryReference'
	and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)    
    insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
    values('CustomerDataManagementService.BusinessPartnerReference.QueryReference', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())

if not exists (select 1 from ad_servicio_autorizado 
	where ts_servicio = 'CustomerDataManagementService.BusinessPartnerReference.ValidateReference'
	and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)    
    insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
    values('CustomerDataManagementService.BusinessPartnerReference.ValidateReference', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())
go
