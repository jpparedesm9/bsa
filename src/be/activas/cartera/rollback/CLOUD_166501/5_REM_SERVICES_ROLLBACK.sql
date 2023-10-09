
use cobis
GO

delete FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.BusinessPartnerReference.PurchaseConfirmation'
delete FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.BusinessPartnerReference.QueryReference'
delete FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.BusinessPartnerReference.ValidateReference'
GO

DECLARE @w_rol int, @w_producto INT,@w_moneda TINYINT,@w_rol_1 int
SELECT @w_rol = ro_rol from cobis..ad_rol where ro_descripcion='SOCIO COMERCIAL'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'

delete from ad_servicio_autorizado 
where ts_servicio = 'CustomerDataManagementService.BusinessPartnerReference.PurchaseConfirmation'
and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda  
    
delete from ad_servicio_autorizado 
where ts_servicio = 'CustomerDataManagementService.BusinessPartnerReference.QueryReference'
and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda
    
delete from ad_servicio_autorizado 
where ts_servicio = 'CustomerDataManagementService.BusinessPartnerReference.ValidateReference'
and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda
go
