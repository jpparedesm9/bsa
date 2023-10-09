
--============== AUTORIZACION DE SERVICIOS=============
use cobis
go

IF EXISTS (SELECT 1 FROM ad_servicio_autorizado WHERE ts_servicio = 'clientviewer.Rate.getInfoCredByClientId')
BEGIN
	DELETE ad_servicio_autorizado  WHERE ts_servicio = 'clientviewer.Rate.getInfoCredByClientId'
END
go

IF EXISTS (SELECT 1 FROM ad_servicio_autorizado WHERE ts_servicio = 'clientviewer.Rate.getAsfiByClientId')
BEGIN
	DELETE ad_servicio_autorizado  WHERE ts_servicio = 'clientviewer.Rate.getAsfiByClientId'
END
go

IF EXISTS (SELECT 1 FROM ad_servicio_autorizado WHERE ts_servicio = 'clientviewer.Rate.getRateByClientId')
BEGIN
	DELETE ad_servicio_autorizado  WHERE ts_servicio = 'clientviewer.Rate.getRateByClientId'
END
go

IF EXISTS (SELECT 1 FROM ad_servicio_autorizado WHERE ts_servicio = 'clientviewer.Administration.GetAllProductAdministratorDefaultVCC')
BEGIN
	DELETE ad_servicio_autorizado  WHERE ts_servicio = 'clientviewer.Administration.GetAllProductAdministratorDefaultVCC'
END
go

IF EXISTS (SELECT 1 FROM ad_servicio_autorizado WHERE ts_servicio = 'clientviewer.Rate.getPortfolioRateByClientId')
BEGIN
	DELETE ad_servicio_autorizado  WHERE ts_servicio = 'clientviewer.Rate.getPortfolioRateByClientId'
END
go

IF EXISTS (SELECT 1 FROM ad_servicio_autorizado WHERE ts_servicio = 'ContactTxService.getContactsbyCustomer')
BEGIN
	DELETE ad_servicio_autorizado  WHERE ts_servicio = 'ContactTxService.getContactsbyCustomer'
END
go

IF EXISTS (SELECT 1 FROM ad_servicio_autorizado WHERE ts_servicio = 'clientviewer.Score.searchPunctuationCustomer')
BEGIN
	DELETE ad_servicio_autorizado  WHERE ts_servicio = 'clientviewer.Score.searchPunctuationCustomer'
END
go


IF EXISTS (SELECT 1 FROM ad_servicio_autorizado WHERE ts_servicio = 'Businessprocess.Creditmanagement.RuleByRoleQuery.QueryExceptionByClient')
BEGIN
	DELETE ad_servicio_autorizado  WHERE ts_servicio = 'Businessprocess.Creditmanagement.RuleByRoleQuery.QueryExceptionByClient'
END
go

IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_service_id = 'clientviewer.Rate.getRateByClientId')
BEGIN
	DELETE cts_serv_catalog  WHERE csc_service_id = 'clientviewer.Rate.getRateByClientId'
END
go


IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_service_id = 'clientviewer.Rate.getAsfiByClientId')
BEGIN
	DELETE cts_serv_catalog  WHERE csc_service_id = 'clientviewer.Rate.getAsfiByClientId'
END
go


IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_service_id = 'clientviewer.Rate.getInfoCredByClientId')
BEGIN
	DELETE cts_serv_catalog  WHERE csc_service_id = 'clientviewer.Rate.getInfoCredByClientId'
END
go

IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_service_id = 'clientviewer.Administration.GetAllProductAdministratorDefaultVCC')
BEGIN
	DELETE cts_serv_catalog  WHERE csc_service_id = 'clientviewer.Administration.GetAllProductAdministratorDefaultVCC'
END
go

IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_service_id = 'clientviewer.Rate.getPortfolioRateByClientId')
BEGIN
	DELETE cts_serv_catalog  WHERE csc_service_id = 'clientviewer.Rate.getPortfolioRateByClientId'
END
go

IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_service_id = 'ContactTxService.getContactsbyCustomer')
BEGIN
	DELETE cts_serv_catalog  WHERE csc_service_id = 'ContactTxService.getContactsbyCustomer'
END
go

IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_service_id = 'Businessprocess.Creditmanagement.RuleByRoleQuery.QueryExceptionByClient')
BEGIN
	DELETE cts_serv_catalog  WHERE  csc_service_id = 'Businessprocess.Creditmanagement.RuleByRoleQuery.QueryExceptionByClient'
END
go

IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_service_id = 'clientviewer.Score.searchPunctuationCustomer')
BEGIN
	DELETE cts_serv_catalog  WHERE  csc_service_id = 'clientviewer.Score.searchPunctuationCustomer'
END
go


INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('clientviewer.Administration.GetAllProductAdministratorDefaultVCC', 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', 'getAllProductAdministratorDefaultDinamic', 'Obtiene todo los campos de deudas', 0, NULL, NULL, NULL)
GO


INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('clientviewer.Rate.getRateByClientId', 'com.cobiscorp.ecobis.clientviewer.IRateServices', 'getRateByCustomerId', ' ', 0, NULL, NULL, NULL)
GO


INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('clientviewer.Rate.getAsfiByClientId', 'com.cobiscorp.ecobis.clientviewer.IRateServices', 'getAsfiByClientId', ' ', 0, NULL, NULL, NULL)
GO

INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('clientviewer.Rate.getInfoCredByClientId', 'com.cobiscorp.ecobis.clientviewer.IRateServices', 'getInfoCredByClientId', ' ', 0, NULL, NULL, NULL)
GO

INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('clientviewer.Rate.getPortfolioRateByClientId', 'com.cobiscorp.ecobis.clientviewer.IRateServices', 'getPortfolioRateByClientId', ' ', 0, NULL, NULL, NULL)
GO

INSERT INTO cobis..cts_serv_catalog (csc_service_id,csc_class_name,csc_method_name,csc_description,csc_trn,csc_support_offline,csc_component,csc_procedure_validation)
values ('ContactTxService.getContactsbyCustomer','com.cobiscorp.ecobis.customer.services.ContactTxService','getContactsbyCustomer','getContactsbyCustomer',0,null,null,null)
GO

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('Businessprocess.Creditmanagement.RuleByRoleQuery.QueryExceptionByClient', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IRuleByRoleQuery', 'queryExceptionByClient', ' ', 21796, NULL, NULL, 'Y')
go

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('clientviewer.Score.searchPunctuationCustomer', 'com.cobiscorp.ecobis.clientviewer.IScoreServices', 'searchPunctuationCustomer', 'searchPunctuationCustomer', 0, NULL, NULL, 'N')
go

--=================AD_SERVICIO_AUTORIZADO====================

declare @w_id_rol int
select @w_id_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'


INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('clientviewer.Administration.GetAllProductAdministratorDefaultVCC', @w_id_rol, 73, 'R', 0, getdate(), 'V', getdate())

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('clientviewer.Rate.getRateByClientId',@w_id_rol, 73, 'R', 0, getdate(), 'V', getdate())

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('clientviewer.Rate.getAsfiByClientId',@w_id_rol, 73, 'R', 0, getdate(), 'V', getdate())

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('clientviewer.Rate.getInfoCredByClientId',@w_id_rol, 73, 'R', 0, getdate(), 'V',getdate())

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('clientviewer.Rate.getPortfolioRateByClientId',@w_id_rol, 73, 'R', 0, getdate(), 'V',getdate())

INSERT INTO cobis..ad_servicio_autorizado(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values ('ContactTxService.getContactsbyCustomer',@w_id_rol,73,'R',0,getdate(),'V',getdate())

INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('Businessprocess.Creditmanagement.RuleByRoleQuery.QueryExceptionByClient',@w_id_rol, 73, 'R', 0, getdate(), 'V', getdate())

INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('clientviewer.Score.searchPunctuationCustomer',@w_id_rol, 73, 'R', 0, getdate(), 'V', getdate())

go
