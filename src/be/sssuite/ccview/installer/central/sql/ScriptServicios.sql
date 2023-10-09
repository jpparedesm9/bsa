use cobis
go

declare @w_id_rol int
select @w_id_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS' 


IF NOT EXISTS (SELECT * FROM ad_procedure where pd_procedure=16979)
begin
	INSERT INTO ad_procedure ( pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo ) 
	VALUES ( 16979, 'sp_atm_cons_tarcli', 'cob_atm', 'V', getdate(), 'cob_atm' ) 
end

IF NOT EXISTS (SELECT * FROM cl_ttransaccion where tn_trn_code=16979)
begin
	INSERT INTO cl_ttransaccion ( tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga ) 
	VALUES ( 16979, 'CONSULTA TARJETA CLIENTE VCC', 'CTCV', 'CONSULTA TARJETA CLIENTE VCC' ) 
end

IF NOT EXISTS (SELECT * FROM ad_pro_transaccion where pt_transaccion=16979)
begin
	INSERT INTO ad_pro_transaccion ( pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial ) 
	VALUES ( 16, 'R', 0, 16979, 'V', getdate(), 16979, ' ' ) 
end

IF NOT EXISTS (SELECT * FROM ad_tr_autorizada where ta_transaccion=16979)
begin
	INSERT INTO ad_tr_autorizada ( ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod ) 
	VALUES ( 16, 'R', 0, 16979, @w_id_rol, getdate(), 1, 'V', getdate() ) 
end

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ClientViewer.Administration.DeleteConfigurationVCC')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', csc_method_name = 'deleteProductAdministrator', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'ClientViewer.Administration.DeleteConfigurationVCC'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('ClientViewer.Administration.DeleteConfigurationVCC', 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', 'deleteProductAdministrator', '', 0)

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'clientviewer.Administration.DeleteConfigurationVCC')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', csc_method_name = 'deleteProductAdministrator', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'clientviewer.Administration.DeleteConfigurationVCC'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('clientviewer.Administration.DeleteConfigurationVCC', 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', 'deleteProductAdministrator', '', 0)

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ClientViewer.Administration.GetAllRoleConfigurationVCC')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', csc_method_name = 'getAllRolesProductAdministrator', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'ClientViewer.Administration.GetAllRoleConfigurationVCC'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('ClientViewer.Administration.GetAllRoleConfigurationVCC', 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', 'getAllRolesProductAdministrator', '', 0)

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'clientViewer.Administration.GetAllRoleConfigurationVCC')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', csc_method_name = 'getAllRolesProductAdministrator', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'clientViewer.Administration.GetAllRoleConfigurationVCC'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('clientViewer.Administration.GetAllRoleConfigurationVCC', 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', 'getAllRolesProductAdministrator', '', 0)

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'clientviewer.Administration.GetAllRoleConfigurationVCC')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', csc_method_name = 'getAllRolesProductAdministrator', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'clientviewer.Administration.GetAllRoleConfigurationVCC'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('clientviewer.Administration.GetAllRoleConfigurationVCC', 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', 'getAllRolesProductAdministrator', '', 0)

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ClientViewer.Administration.InsertConfigurationVCC')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', csc_method_name = 'insertProductAdministrator', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'ClientViewer.Administration.InsertConfigurationVCC'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('ClientViewer.Administration.InsertConfigurationVCC', 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', 'insertProductAdministrator', '', 0)
 
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ClientViewer.Administration.QueryConfigurationVCC')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', csc_method_name = 'getProductAdministratorByRole', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'ClientViewer.Administration.QueryConfigurationVCC'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('ClientViewer.Administration.QueryConfigurationVCC', 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', 'getProductAdministratorByRole', '', 0)
 
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ClientViewer.Administration.UpdateConfigurationVCC')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', csc_method_name = 'updateProductAdministrator', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'ClientViewer.Administration.UpdateConfigurationVCC'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('ClientViewer.Administration.UpdateConfigurationVCC', 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', 'updateProductAdministrator', '', 0)
 
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ClientViewer.Client.QueryClient')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.customer.CustomerService', csc_method_name = 'queryClient ', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'ClientViewer.Client.QueryClient'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('ClientViewer.Client.QueryClient', 'com.cobiscorp.ecobis.customer.CustomerService', 'queryClient ', '', 0)

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ClientViewer.Client.QueryClientByParameters')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.customer.CustomerService', csc_method_name = 'getCustomersByParameters ', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'ClientViewer.Client.QueryClientByParameters'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('ClientViewer.Client.QueryClientByParameters', 'com.cobiscorp.ecobis.customer.CustomerService', 'getCustomersByParameters ', '', 0)
 
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ClientViewer.Client.QueryClientDirections')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.customer.CustomerService', csc_method_name = 'getQueryClientAddress ', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'ClientViewer.Client.QueryClientDirections'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('ClientViewer.Client.QueryClientDirections', 'com.cobiscorp.ecobis.customer.CustomerService', 'getQueryClientAddress ', '', 0)
 
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ClientViewer.Client.QueryClientRate')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.customer.CustomerService', csc_method_name = 'queryClientRate', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'ClientViewer.Client.QueryClientRate'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('ClientViewer.Client.QueryClientRate', 'com.cobiscorp.ecobis.customer.CustomerService', 'queryClientRate', '', 0)
 
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ClientViewer.Client.QueryClientType')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.customer.CustomerService', csc_method_name = 'getCustomerType', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'ClientViewer.Client.QueryClientType'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('ClientViewer.Client.QueryClientType', 'com.cobiscorp.ecobis.customer.CustomerService', 'getCustomerType', '', 0)

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ClientViewer.Client.QueryConsolidatedPosition')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.clientviewer.ConsolidatePositionService', csc_method_name = 'queryConsolidatedPosition', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'ClientViewer.Client.QueryConsolidatedPosition'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('ClientViewer.Client.QueryConsolidatedPosition', 'com.cobiscorp.ecobis.clientviewer.ConsolidatePositionService', 'queryConsolidatedPosition', '', 0)
 
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ClientViewer.Client.QueryGroup')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.customer.CustomerService', csc_method_name = 'queryGroup', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'ClientViewer.Client.QueryGroup'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('ClientViewer.Client.QueryGroup', 'com.cobiscorp.ecobis.customer.CustomerService', 'queryGroup', '', 0)
 
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ClientViewer.Client.QueryGroupDetail')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.customer.CustomerService', csc_method_name = 'getGroupDetail', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'ClientViewer.Client.QueryGroupDetail'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('ClientViewer.Client.QueryGroupDetail', 'com.cobiscorp.ecobis.customer.CustomerService', 'getGroupDetail', '', 0)
 
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ClientViewer.Client.QueryGroupMembers')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.customer.CustomerService', csc_method_name = 'getGroupMembers', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'ClientViewer.Client.QueryGroupMembers'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('ClientViewer.Client.QueryGroupMembers', 'com.cobiscorp.ecobis.customer.CustomerService', 'getGroupMembers', '', 0)
 
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ClientViewer.Client.QueryLegalClient')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.customer.CustomerService', csc_method_name = 'getQueryLegalClient', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'ClientViewer.Client.QueryLegalClient'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('ClientViewer.Client.QueryLegalClient', 'com.cobiscorp.ecobis.customer.CustomerService', 'getQueryLegalClient', '', 0)

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ClientViewer.MaxDebt.QueryMaxDebt')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.clientviewer.MaxDebtService', csc_method_name = 'getMaxDebt', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'ClientViewer.MaxDebt.QueryMaxDebt'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('ClientViewer.MaxDebt.QueryMaxDebt', 'com.cobiscorp.ecobis.clientviewer.MaxDebtService', 'getMaxDebt', '', 0)

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ClientViewer.Products.PrepareProductsData')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.clientviewer.PrepareProductsDataService', csc_method_name = 'prepareProductsData', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'ClientViewer.Products.PrepareProductsData'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('ClientViewer.Products.PrepareProductsData', 'com.cobiscorp.ecobis.clientviewer.PrepareProductsDataService', 'prepareProductsData', '', 0)
 
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ClientViewer.Products.QueryProductsByClientId')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.clientviewer.QueryProductsService', csc_method_name = 'queryProductsByClientId', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'ClientViewer.Products.QueryProductsByClientId'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('ClientViewer.Products.QueryProductsByClientId', 'com.cobiscorp.ecobis.clientviewer.QueryProductsService', 'queryProductsByClientId', '', 0) 

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'AddressTxService.getAddressesbyCustomer')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.customer.services.AddressTxService', csc_method_name = 'getAddressesbyCustomer', csc_description = 'getAddressesbyCustomer', csc_trn = 0 WHERE csc_service_id = 'AddressTxService.getAddressesbyCustomer'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('AddressTxService.getAddressesbyCustomer', 'com.cobiscorp.ecobis.customer.services.AddressTxService', 'getAddressesbyCustomer', 'getAddressesbyCustomer', 0)

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'clientviewer.Score.serchScoreCustomer')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.clientviewer.IScoreServices', csc_method_name = 'searchScoreCustomer', csc_description = 'searchScoreCustomer', csc_trn = 0 WHERE csc_service_id = 'clientviewer.Score.serchScoreCustomer'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('clientviewer.Score.serchScoreCustomer', 'com.cobiscorp.ecobis.clientviewer.IScoreServices', 'searchScoreCustomer', 'searchScoreCustomer', 0)

IF NOT EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'QuickCreateTxService.executeQuickCreate')
begin
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
	VALUES ('QuickCreateTxService.executeQuickCreate', 'com.cobiscorp.ecobis.customer.services.QuickCreateTxService', 'executeQuickCreate', 'executeQuickCreate', NULL, NULL, NULL, NULL)
end

IF NOT EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ProductDetailService.createProductDetail')
begin
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
	VALUES ('ProductDetailService.createProductDetail', 'com.cobiscorp.ecobis.customer.services.ProductDetailService', 'createProductDetail', 'createProductDetail', NULL, NULL, NULL, NULL)
end

IF NOT EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'POBoxTxService.getAllPOBOX')
begin
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)	
VALUES ('POBoxTxService.getAllPOBOX', 'com.cobiscorp.ecobis.customer.services.POBoxTxService', 'getAllPOBOX', 'getAllPOBOX', NULL, NULL, NULL, NULL)
end

IF NOT EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'PhoneTxService.getPhonebyCustomerAndAddress')
begin
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
	VALUES ('PhoneTxService.getPhonebyCustomerAndAddress', 'com.cobiscorp.ecobis.customer.services.PhoneTxService', 'getPhonebyCustomerAndAddress', 'getPhonebyCustomerAndAddress', NULL, NULL, NULL, NULL)
end

IF NOT EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'NationalityService.searchNationality')
begin
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
	VALUES ('NationalityService.searchNationality', 'com.cobiscorp.ecobis.customer.services.NationalityService', 'searchNationality', 'searchNationality', NULL, NULL, NULL, NULL)
end

IF NOT EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Loan.ReadOperationGuarantees.GetOperationGuarantees')
begin
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
	VALUES ('Loan.ReadOperationGuarantees.GetOperationGuarantees', 'cobiscorp.ecobis.loan.service.IReadOperationGuarantees', 'getOperationGuarantees', 'getOperationGuarantees', 0, NULL, NULL, NULL)
end

IF NOT EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerTxService.getCustomerAllData')
begin
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
	VALUES ('CustomerTxService.getCustomerAllData', 'com.cobiscorp.ecobis.customer.services.CustomerTxService', 'getCustomerAllData', 'getCustomerAllData', NULL, NULL, NULL, NULL)
end

IF NOT EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ClientService.createClient')
begin
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
	VALUES ('ClientService.createClient', 'com.cobiscorp.ecobis.customer.services.ClientService', 'createClient', 'createClient', NULL, NULL, NULL, NULL)
end

IF NOT EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'BusinessSegmentTxService.getBusinessSegment')
begin
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
	VALUES ('BusinessSegmentTxService.getBusinessSegment', 'com.cobiscorp.ecobis.customer.services.BusinessSegmentTxService', 'getBusinessSegment', 'getBusinessSegment', NULL, NULL, NULL, NULL)
end

IF NOT EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ActivityTxService.getMainActivity')
begin
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
	VALUES ('ActivityTxService.getMainActivity', 'com.cobiscorp.ecobis.customer.services.ActivityTxService', 'getMainActivity', 'getMainActivity', NULL, NULL, NULL, NULL)
end

IF NOT EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ActivityTxService.getEconomicActivity')
begin
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
	VALUES ('ActivityTxService.getEconomicActivity', 'com.cobiscorp.ecobis.customer.services.ActivityTxService', 'getEconomicActivity', 'getEconomicActivity', NULL, NULL, NULL, NULL)
end

IF NOT EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_service_id = 'Card.CardManagement.getCardsByCustomer')
BEGIN
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
	VALUES ('Card.CardManagement.getCardsByCustomer', 'cobiscorp.ecobis.card.service.ICardManagement', 'getCardsByCustomer', '', 16979, 'Y')
END

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ClientViewer.Products.PrepareProductsDataHistory')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.clientviewer.PrepareProductsDataService', csc_method_name = 'prepareProductsDataHistory', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'ClientViewer.Products.PrepareProductsDataHistory'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('ClientViewer.Products.PrepareProductsDataHistory', 'com.cobiscorp.ecobis.clientviewer.PrepareProductsDataService', 'prepareProductsDataHistory', '', 0)
 
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ClientViewer.Products.QueryHistoryProductsByClientId')
	UPDATE cts_serv_catalog SET csc_class_name = 'com.cobiscorp.ecobis.clientviewer.QueryProductsService', csc_method_name = 'queryHistoryProductsByClientId', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'ClientViewer.Products.QueryHistoryProductsByClientId'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) VALUES ('ClientViewer.Products.QueryHistoryProductsByClientId', 'com.cobiscorp.ecobis.clientviewer.QueryProductsService', 'queryHistoryProductsByClientId', '', 0) 

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'ContactManagement.Customer.Query')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.contactmanagement.service.ICustomer', csc_method_name = 'query', csc_description = '', csc_trn = 65003 WHERE csc_service_id = 'ContactManagement.Customer.Query'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) VALUES ('ContactManagement.Customer.Query', 'cobiscorp.ecobis.contactmanagement.service.ICustomer', 'query', '', 65003, 'Y') 
go

declare @rol tinyint, 
 @producto tinyint, 
 @moneda tinyint

select @rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'
 
select @producto = 73, @moneda = 0

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'ClientViewer.Administration.DeleteConfigurationVCC' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'ClientViewer.Administration.DeleteConfigurationVCC' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('ClientViewer.Administration.DeleteConfigurationVCC',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'clientviewer.Administration.DeleteConfigurationVCC' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'clientviewer.Administration.DeleteConfigurationVCC' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		
	VALUES ('clientviewer.Administration.DeleteConfigurationVCC',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())
	
IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'ClientViewer.Administration.GetAllRoleConfigurationVCC' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'ClientViewer.Administration.GetAllRoleConfigurationVCC' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('ClientViewer.Administration.GetAllRoleConfigurationVCC',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())
	
IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'clientviewer.Administration.GetAllRoleConfigurationVCC' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'clientviewer.Administration.GetAllRoleConfigurationVCC' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('clientviewer.Administration.GetAllRoleConfigurationVCC',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'clientViewer.Administration.GetAllRoleConfigurationVCC' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'clientViewer.Administration.GetAllRoleConfigurationVCC' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('clientViewer.Administration.GetAllRoleConfigurationVCC',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

	

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'ClientViewer.Administration.InsertConfigurationVCC' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'ClientViewer.Administration.InsertConfigurationVCC' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('ClientViewer.Administration.InsertConfigurationVCC',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'ClientViewer.Administration.QueryConfigurationVCC' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'ClientViewer.Administration.QueryConfigurationVCC' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('ClientViewer.Administration.QueryConfigurationVCC',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'ClientViewer.Administration.UpdateConfigurationVCC' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'ClientViewer.Administration.UpdateConfigurationVCC' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('ClientViewer.Administration.UpdateConfigurationVCC',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'ClientViewer.Client.QueryClient' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'ClientViewer.Client.QueryClient' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('ClientViewer.Client.QueryClient',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'ClientViewer.Client.QueryClientByParameters' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'ClientViewer.Client.QueryClientByParameters' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('ClientViewer.Client.QueryClientByParameters',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'ClientViewer.Client.QueryClientDirections' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'ClientViewer.Client.QueryClientDirections' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('ClientViewer.Client.QueryClientDirections',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'ClientViewer.Client.QueryClientRate' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'ClientViewer.Client.QueryClientRate' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('ClientViewer.Client.QueryClientRate',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'ClientViewer.Client.QueryClientType' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'ClientViewer.Client.QueryClientType' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('ClientViewer.Client.QueryClientType',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'ClientViewer.Client.QueryConsolidatedPosition' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'ClientViewer.Client.QueryConsolidatedPosition' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('ClientViewer.Client.QueryConsolidatedPosition',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'ClientViewer.Client.QueryGroup' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'ClientViewer.Client.QueryGroup' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('ClientViewer.Client.QueryGroup',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'ClientViewer.Client.QueryGroupDetail' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'ClientViewer.Client.QueryGroupDetail' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('ClientViewer.Client.QueryGroupDetail',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'ClientViewer.Client.QueryGroupMembers' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'ClientViewer.Client.QueryGroupMembers' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('ClientViewer.Client.QueryGroupMembers',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'ClientViewer.Client.QueryLegalClient' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'ClientViewer.Client.QueryLegalClient' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('ClientViewer.Client.QueryLegalClient',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'ClientViewer.MaxDebt.QueryMaxDebt' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'ClientViewer.MaxDebt.QueryMaxDebt' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('ClientViewer.MaxDebt.QueryMaxDebt',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'ClientViewer.Products.PrepareProductsData' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'ClientViewer.Products.PrepareProductsData' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('ClientViewer.Products.PrepareProductsData',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'ClientViewer.Products.QueryProductsByClientId' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'ClientViewer.Products.QueryProductsByClientId' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('ClientViewer.Products.QueryProductsByClientId',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'AddressTxService.getAddressesbyCustomer' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'AddressTxService.getAddressesbyCustomer' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('AddressTxService.getAddressesbyCustomer',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'ClientViewer.Products.PrepareProductsDataHistory' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'ClientViewer.Products.PrepareProductsDataHistory' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('ClientViewer.Products.PrepareProductsDataHistory',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'ClientViewer.Products.QueryHistoryProductsByClientId' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'ClientViewer.Products.QueryHistoryProductsByClientId' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('ClientViewer.Products.QueryHistoryProductsByClientId',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'PhoneTxService.getPhonebyCustomerAndAddress' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'PhoneTxService.getPhonebyCustomerAndAddress' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		VALUES ('PhoneTxService.getPhonebyCustomerAndAddress',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'Loan.ReadOperationGuarantees.GetOperationGuarantees' and ts_rol=@rol)
	UPDATE ad_servicio_autorizado SET ts_rol=@rol ,ts_producto=@producto ,ts_moneda=@moneda ,ts_estado='V' WHERE ts_servicio = 'Loan.ReadOperationGuarantees.GetOperationGuarantees' and ts_rol=@rol
ELSE
	INSERT INTO ad_servicio_autorizado VALUES ('Loan.ReadOperationGuarantees.GetOperationGuarantees',@rol,@producto, 'R', @moneda, getDate(), 'V', getDate())

go
