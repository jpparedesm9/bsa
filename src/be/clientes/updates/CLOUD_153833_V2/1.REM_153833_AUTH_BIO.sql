use cobis
go


declare 
@w_rol int,
@w_producto int

SELECT @w_producto = pd_producto FROM cl_producto WHERE pd_descripcion = 'CLIENTES'
SELECT @w_rol = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'ADMINISTRADOR'
--------------------------------------------
--- SERVICIO PARA OBTENER ACCESS TOKEN -----
--------------------------------------------
delete from cts_serv_catalog where csc_service_id = 'OrchestrationBiometricServiceSERVImpl.accessTokenBC'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
values ('OrchestrationBiometricServiceSERVImpl.accessTokenBC', 'com.cobiscorp.ecobis.cobiscloudbiometric.bsl.serv.bsl.IOrchestationBiometricService', 'accessTokenBC', 'Obtener Access Token', NULL, 'N')

delete from ad_servicio_autorizado where ts_servicio = 'OrchestrationBiometricServiceSERVImpl.accessTokenBC' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('OrchestrationBiometricServiceSERVImpl.accessTokenBC', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

------------------------------------------------
--- SERVICIO PARA OBTENER EL ID DE OFICINA -----
------------------------------------------------
delete from cts_serv_catalog where csc_service_id = 'CustomerBiocheck.CustomerBiocheck.QueryOfficeId'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
values ('CustomerBiocheck.CustomerBiocheck.QueryOfficeId', 'cobiscorp.ecobis.customerbiocheck.service.ICustomerBiocheck', 'queryOfficeId', 'Obtener el ID de la oficina', 18000, 'N')

delete from ad_servicio_autorizado where ts_servicio = 'CustomerBiocheck.CustomerBiocheck.QueryOfficeId' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('CustomerBiocheck.CustomerBiocheck.QueryOfficeId', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

------------------------------------------------
--- SERVICIO PARA OBTENER EL ID DE OFICINA -----
------------------------------------------------
delete from cts_serv_catalog where csc_service_id = 'CustomerBiocheck.CustomerBiocheck.ValidateErrorBiocheck'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
values ('CustomerBiocheck.CustomerBiocheck.ValidateErrorBiocheck', 'cobiscorp.ecobis.customerbiocheck.service.ICustomerBiocheck', 'validateErrorBiocheck', 'Registrar error de Biometricos', 18000, 'N')
	
delete from ad_servicio_autorizado where ts_servicio = 'CustomerBiocheck.CustomerBiocheck.ValidateErrorBiocheck' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('CustomerBiocheck.CustomerBiocheck.ValidateErrorBiocheck', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

go

