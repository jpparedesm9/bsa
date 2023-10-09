
use cobis
go

declare @w_rol int, @w_producto int, @w_moneda tinyint

select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CREDITO'

-------------------------
--ad_servicio_autorizado
-------------------------
print 'CreateEconomicActivity'
if exists (select 1 from ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CustomerManagement.CreateEconomicActivity')
BEGIN
DELETE from ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CustomerManagement.CreateEconomicActivity'
END

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.CreateEconomicActivity', 1, 2, 'R', 0, getdate(), 'V', getdate())


INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.CreateEconomicActivity', 2, 2, 'R', 0,getdate(), 'V', getdate())


INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.CreateEconomicActivity', 3, 2, 'R', 0, getdate(), 'V', getdate())


INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.CreateEconomicActivity', 10, 2, 'R', 0,getdate(), 'V', getdate())


INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.CreateEconomicActivity', 11, 2, 'R', 0, getdate(), 'V',getdate())


INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.CreateEconomicActivity', 12, 2, 'R', 0, getdate(), 'V', getdate())


INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.CreateEconomicActivity', 13, 2, 'R', 0, getdate(), 'V', getdate())



	-- Ejecuta la regla de monto maximo
IF exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.CreateEconomicActivity')
BEGIN
DELETE  from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.CreateEconomicActivity'
END

INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_procedure_validation, csc_component)
VALUES ('CustomerDataManagementService.CustomerManagement.CreateEconomicActivity', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'createEconomicActivity', '', 2437, NULL, NULL, NULL)

select * from ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CustomerManagement.CreateEconomicActivity'


select * from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.CreateEconomicActivity'
GO