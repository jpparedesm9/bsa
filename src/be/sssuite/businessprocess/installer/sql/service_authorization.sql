/**********************************************************************/
/*   Archivo:         loanGroup_services_authorization.sql            */
/*   Data base:       cobis                                           */
/**********************************************************************/
/*                     IMPORTANTE                                     */
/*   Esta aplicacion es parte de los  paquetes bancarios              */
/*   propiedad de COBISCORP.                                          */
/*   Su uso no autorizado queda  expresamente  prohibido              */
/*   asi como cualquier alteracion o agregado hecho  por              */
/*   alguno de sus usuarios sin el debido consentimiento              */
/*   por escrito de COBISCORP.                                        */
/*   Este programa esta protegido por la ley de derechos              */
/*   de autor y por las convenciones  internacionales de              */
/*   propiedad intelectual.  Su uso  no  autorizado dara              */
/*   derecho a COBISCORP para obtener ordenes  de secuestro           */
/*   o  retencion  y  para  perseguir  penalmente a  los              */
/*   autores de cualquier infraccion.                                 */
/**********************************************************************/
/*                      PROPOSITO                                     */
/*           Autorizacion de los servicios de LOANGROUP               */
/**********************************************************************/
/*                      MODIFICACIONES                                */
/*   FECHA              AUTOR                  RAZON                  */
/*   23-31-2017         Ma. Jose Taco          Emision Inicial        */
/**********************************************************************/
  
use cobis
go

declare @w_rol int, @w_producto int, @w_moneda tinyint

select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CREDITO'

--cts_serv_catalog
if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.GetCustomerCycleNumber')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('CustomerDataManagementService.CustomerManagement.GetCustomerCycleNumber','cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement','getCustomerCycleNumber', 'Get Customer Cycle Number',0, null, null, null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Account.ValidateAmounts.ValidateAmountSavingAccounts')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Account.ValidateAmounts.ValidateAmountSavingAccounts','cobiscorp.ecobis.account.service.IValidateAmounts','validateAmountSavingAccounts','Validate Amount Saving Accounts',1288, null, null, null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'BusinessProcess.LoanRequest.CreditOperation.GetProcessedNumber')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('BusinessProcess.LoanRequest.CreditOperation.GetProcessedNumber','cobiscorp.ecobis.businessprocess.loanrequest.service.ICreditOperation','getProcessedNumber', 'Get Processed Number',73903, null, null, null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'SystemConfiguration.ParameterManagement.ParameterManagement')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('SystemConfiguration.ParameterManagement.ParameterManagement','cobiscorp.ecobis.systemconfiguration.service.IParameterManagement','parameterManagement', 'Parameter Management',1579, null, null, null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.DebtorsManagment.HelpDebtor')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Businessprocess.Creditmanagement.DebtorsManagment.HelpDebtor','cobiscorp.ecobis.businessprocess.creditmanagement.service.IDebtorsManagment','helpDebtor', 'Help Debtor',21513, null, null, null)
    
if not exists (select 1 from cts_serv_catalog where csc_service_id = 'BusinessProcess.Customers.QueryCustomer.QueryCustomerEntailment')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('BusinessProcess.Customers.QueryCustomer.QueryCustomerEntailment','cobiscorp.ecobis.businessprocess.customers.service.IQueryCustomer','queryCustomerEntailment', '',73935, null, null, null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'SystemConfiguration.CatalogManagement.Search')
    INSERT INTO cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('SystemConfiguration.CatalogManagement.Search', 'cobiscorp.ecobis.systemconfiguration.service.ICatalogManagement', 'search', '', 1564, NULL, NULL, NULL)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'SystemConfiguration.ParameterManagement.ProcessDate')
    INSERT INTO cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('SystemConfiguration.ParameterManagement.ProcessDate', 'cobiscorp.ecobis.systemconfiguration.service.IParameterManagement', 'processDate', 'processDate', 15168, NULL, NULL, NULL)

    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.ApplicationManagment.CreateNewApplication')
    INSERT INTO cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Businessprocess.Creditmanagement.ApplicationManagment.CreateNewApplication', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', 'createNewApplication', '', 77100, NULL, NULL, NULL)

    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.DebtorsManagment.CreateDebtor')
    INSERT INTO cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Businessprocess.Creditmanagement.DebtorsManagment.CreateDebtor', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IDebtorsManagment', 'createDebtor', '', 21013, NULL, NULL, NULL)

    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.ApplicationQuery.ReadNewApplication')
    INSERT INTO cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    VALUES ('Businessprocess.Creditmanagement.ApplicationQuery.ReadNewApplication', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationQuery', 'readNewApplication', '', 77200, NULL, NULL, NULL)

    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.LoanMaintenance.DeleteTmpTables')
    INSERT INTO cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Loan.LoanMaintenance.DeleteTmpTables', 'cobiscorp.ecobis.loan.service.ILoanMaintenance', 'deleteTmpTables', '', 7002, NULL, NULL, NULL)
    
    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.LoanMaintenance.CreateTmpTables')
    INSERT INTO dbo.cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Loan.LoanMaintenance.CreateTmpTables', 'cobiscorp.ecobis.loan.service.ILoanMaintenance', 'createTmpTables', ' ', 73911, NULL, NULL, NULL)
    
    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.ApplicationManagment.UpdateNewApplication')
    INSERT INTO dbo.cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Businessprocess.Creditmanagement.ApplicationManagment.UpdateNewApplication', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', 'updateNewApplication', '', 77300, NULL, NULL, NULL)
    
    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.DebtorsManagment.QueryDebtor')
    INSERT INTO cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Businessprocess.Creditmanagement.DebtorsManagment.QueryDebtor', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IDebtorsManagment', 'queryDebtor', 'queryDebtor', NULL, NULL, NULL, NULL)
    
    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.LoansQueries.ReadLoanGeneralDataTmp')
    INSERT INTO cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Loan.LoansQueries.ReadLoanGeneralDataTmp', 'cobiscorp.ecobis.loan.service.ILoansQueries', 'readLoanGeneralDataTmp', ' ', 7143, NULL, NULL, NULL)
    
    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Account.SearchAccount.SearchAccountByCurrency')
    INSERT INTO cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Account.SearchAccount.SearchAccountByCurrency', 'cobiscorp.ecobis.account.service.ISearchAccount', 'searchAccountByCurrency', ' ', 7003, NULL, NULL, NULL)
    
    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'SystemConfiguration.OfficeManagement.ReadOffice')
    INSERT INTO cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    VALUES ('SystemConfiguration.OfficeManagement.ReadOffice', 'cobiscorp.ecobis.systemconfiguration.service.IOfficeManagement', 'readOffice', '', 1572, NULL, NULL, NULL)
    
    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.ReadLoanAmortizationTable.ReadLoanAmortizationTableSearchTmp')
    INSERT INTO cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    VALUES ('Loan.ReadLoanAmortizationTable.ReadLoanAmortizationTableSearchTmp', 'cobiscorp.ecobis.loan.service.IReadLoanAmortizationTable', 'readLoanAmortizationTableSearchTmp', ' ', 7462, NULL, NULL, NULL)
    
    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.SearchLoanItems.SearchLoanItemsSearch')
    INSERT INTO cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    VALUES ('Loan.SearchLoanItems.SearchLoanItemsSearch', 'cobiscorp.ecobis.loan.service.ISearchLoanItems', 'searchLoanItemsSearch', 'searchLoanItemsSearch', 7095, NULL, NULL, NULL)
    
    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.SearchLoanItems.GetLoanItemsDetails_busin')
    INSERT INTO cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    VALUES ('Loan.SearchLoanItems.GetLoanItemsDetails_busin', 'cobiscorp.ecobis.loan.service.ISearchLoanItems', 'GetLoanItemsDetails', 'searchLoanItemsSearch', 7095, NULL, NULL, NULL)
    
    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.LoanMaintenance.UpdateLoanDataTmp')
    INSERT INTO cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    VALUES ('Loan.LoanMaintenance.UpdateLoanDataTmp', 'cobiscorp.ecobis.loan.service.ILoanMaintenance', 'updateLoanDataTmp', ' ', 7061, NULL, NULL, NULL)

    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'ICommitPaymentPlan.commitPaymentPlan')
    INSERT INTO cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    VALUES ('ICommitPaymentPlan.commitPaymentPlan', 'com.cobiscorp.ecobis.businessprocess.orchestrator.wf.route.ICommitPaymentPlan', 'commitPaymentPlan', 'Call orchestration to commit playmet plan', NULL, NULL, NULL, NULL)
    
    
    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.LineOpCurrency.GetQuoteBusin')
    INSERT INTO cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    VALUES ('Businessprocess.Creditmanagement.LineOpCurrency.GetQuoteBusin', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.ILineOpCurrency', 'getQuoteBusin', '', 73930, NULL, NULL, NULL)
    
    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.LoansQueries.SearchLoanItemsTmp')
    INSERT INTO cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    VALUES ('Loan.LoansQueries.SearchLoanItemsTmp', 'cobiscorp.ecobis.loan.service.ILoansQueries', 'searchLoanItemsTmp', '', 7076, NULL, NULL, NULL)
    
    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.LoanMaintenance.CreateDisbursementForm')
    INSERT INTO cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    VALUES ('Loan.LoanMaintenance.CreateDisbursementForm', 'cobiscorp.ecobis.loan.service.ILoanMaintenance', 'createDisbursementForm', '', 7030, NULL, NULL, NULL)
    
    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.LoanMaintenance.removeDisbursementForm')
    INSERT INTO cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    VALUES ('Loan.LoanMaintenance.removeDisbursementForm', 'cobiscorp.ecobis.loan.service.ILoanMaintenance', 'removeDisbursementForm', '', 7031, NULL, NULL, NULL)
    
print 'Businessprocess.Creditmanagement.DebtorsManagment.HelpDebtor'

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchCustomerReference')
    insert into cobis..cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values('CustomerDataManagementService.CustomerManagement.SearchCustomerReference', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchCustomerReference', '', 136, null, null, null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchAddresProspectSan')
    insert into cobis..cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('CustomerDataManagementService.CustomerManagement.SearchAddresProspectSan', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchAddresProspectSan', '', 1227, null, null, null) 

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchCustomerBusiness')
    insert into cobis..cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('CustomerDataManagementService.CustomerManagement.SearchCustomerBusiness', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchCustomerBusiness', '', 1712, null, null, null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.CreateCustomerReference')
   insert into cobis..cts_serv_catalog 
   (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
   values  ('CustomerDataManagementService.CustomerManagement.CreateCustomerReference', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'createCustomerReference', '', 177, null, null, null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.CreateCustomerBusiness')
   insert into cobis..cts_serv_catalog 
   (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
   values ('CustomerDataManagementService.CustomerManagement.CreateCustomerBusiness', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'createCustomerBusiness', '', 1709, null, null, null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.UpdateCustomerBusiness')
   insert into cobis..cts_serv_catalog 
   (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
   values ('CustomerDataManagementService.CustomerManagement.UpdateCustomerBusiness', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'UpdateCustomerBusiness', '', 1709, null, null, null)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.DeleteCustomerBusiness')
   insert into cobis..cts_serv_catalog 
   (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
   values ('CustomerDataManagementService.CustomerManagement.DeleteCustomerBusiness', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'DeleteCustomerBusiness', '', 1711, null, null, null)

--DeleteDebtor
if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.DebtorsManagment.DeleteDebtor')
   insert into cobis..cts_serv_catalog 
   (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
   values ('Businessprocess.Creditmanagement.DebtorsManagment.DeleteDebtor', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IDebtorsManagment', 'deleteDebtor', '', 21213, null, null, null)
      
--Cartera
--Loan.ReadDisbursementForm.ReadDisbursementFormSearch.Busin hasce referencia en el SG Loan.ReadDisbursementForm.ReadDisbursementFormSearch
if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.ReadDisbursementForm.ReadDisbursementFormSearch.Busin')
   insert into cobis..cts_serv_catalog 
   (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
   values ('Loan.ReadDisbursementForm.ReadDisbursementFormSearch.Busin', 'cobiscorp.ecobis.loan.service.IReadDisbursementForm', 'readDisbursementFormSearch', '', 7032, null, null, null)

   -- Carga de usuario login  SearchOfficer
if not exists (select 1 from cts_serv_catalog where csc_service_id = 'SystemConfiguration.OfficerManagement.SearchOfficer')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('SystemConfiguration.OfficerManagement.SearchOfficer','cobiscorp.ecobis.systemconfiguration.service.IOfficerManagement','searchOfficer', '',15153, null, null, null)

	-- Ejecuta la regla de monto maximo
if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.RuleExecutionManagement.QueryRuleAmountMaxInd')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Businessprocess.Creditmanagement.RuleExecutionManagement.QueryRuleAmountMaxInd','cobiscorp.ecobis.businessprocess.creditmanagement.service.IRuleExecutionManagement','queryRuleAmountMaxInd', '',0, null, null, null)

    --Registro de CreateSynchronizationActivity'	
if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.Synchronization.CreateSynchronizationActivity')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Businessprocess.Creditmanagement.Synchronization.CreateSynchronizationActivity','cobiscorp.ecobis.businessprocess.creditmanagement.service.ISynchronization','createSynchronizationActivity', '',2174, null, null, null)
	
	--Registro de QuerySynchronizationActivity'
	
if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.Synchronization.QuerySynchronizationActivity')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Businessprocess.Creditmanagement.Synchronization.QuerySynchronizationActivity','cobiscorp.ecobis.businessprocess.creditmanagement.service.ISynchronization','querySynchronizationActivity', '',2174, null, null, null)

	--Registro de UpdateSynchronizationActivity'	
if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.Synchronization.UpdateSynchronizationActivity')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Businessprocess.Creditmanagement.Synchronization.UpdateSynchronizationActivity','cobiscorp.ecobis.businessprocess.creditmanagement.service.ISynchronization','updateSynchronizationActivity', '',2174, null, null, null)

	--Registro de XMLQuestionnaire
if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.Synchronization.XMLQuestionnaire')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Businessprocess.Creditmanagement.Synchronization.XMLQuestionnaire','cobiscorp.ecobis.businessprocess.creditmanagement.service.ISynchronization','xMLQuestionnaire', '',0, null, null, null)		
	
--CreateVerification
delete cts_serv_catalog where csc_service_id in ('Businessprocess.Creditmanagement.DataVerification.CreateVerification')
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('Businessprocess.Creditmanagement.DataVerification.CreateVerification',  'cobiscorp.ecobis.businessprocess.creditmanagement.service.IDataVerification', 'createVerification', '', 21700, null, null, 'N')

--UpdateVerification
delete cts_serv_catalog where csc_service_id in ('Businessprocess.Creditmanagement.DataVerification.UpdateVerification')
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('Businessprocess.Creditmanagement.DataVerification.UpdateVerification',  'cobiscorp.ecobis.businessprocess.creditmanagement.service.IDataVerification', 'updateVerification', '', 21700, null, null, 'N')
 
--SearchVerification
delete cts_serv_catalog where csc_service_id in ('Businessprocess.Creditmanagement.DataVerification.SearchVerification')
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('Businessprocess.Creditmanagement.DataVerification.SearchVerification',  'cobiscorp.ecobis.businessprocess.creditmanagement.service.IDataVerification', 'searchVerification', '', 21700, null, null, 'N')



--UpdateEconomicInformation - Mobile
delete cts_serv_catalog where csc_service_id in ('CustomerDataManagementService.CustomerManagement.UpdateEconomicInformation')
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.UpdateEconomicInformation', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'updateEconomicInformation', '', 104, null, null, 'N')


--ReadDataCustomer
delete cts_serv_catalog where csc_service_id in ('CustomerDataManagementService.CustomerManagement.ReadDataCustomer')
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.ReadDataCustomer',  'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'readCustomer', '', 132, null, null, 'N')



--Query Aplication - Reimpresión
delete cts_serv_catalog where csc_service_id in ('Businessprocess.Creditmanagement.ApplicationManagment.QueryCustomerApplication')
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('Businessprocess.Creditmanagement.ApplicationManagment.QueryCustomerApplication',  'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', 'queryCustomerApplication', '', 22555, null, null, 'N')

--Buscar Documentos
delete cts_serv_catalog
where csc_service_id in ('Businessprocess.Creditmanagement.DocumentsApplicationQuery.SearchDocuments')
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('Businessprocess.Creditmanagement.DocumentsApplicationQuery.SearchDocuments', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IDocumentsApplicationQuery', 'searchDocuments', '', 21433, NULL, NULL, NULL)

--Buscar SearchDocumentsApplication
delete cts_serv_catalog
where csc_service_id in ('Businessprocess.Creditmanagement.DocumentsApplicationManagment.SearchDocumentsApplication')

INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('Businessprocess.Creditmanagement.DocumentsApplicationManagment.SearchDocumentsApplication', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IDocumentsApplicationManagment', 'searchDocumentsApplication', '', 21434, NULL, NULL, NULL)

--CreateDocumentsApplication
delete cts_serv_catalog
where csc_service_id in ('Businessprocess.Creditmanagement.DocumentsApplicationManagment.CreateDocumentsApplication')

INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('Businessprocess.Creditmanagement.DocumentsApplicationManagment.CreateDocumentsApplication', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IDocumentsApplicationManagment', 'createDocumentsApplication', '', 21034, NULL, NULL, NULL)

--FindPostalCode
delete cts_serv_catalog
where csc_service_id in ('CustomerDataManagementService.CustomerManagement.FindPostalCode')

INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('CustomerDataManagementService.CustomerManagement.FindPostalCode', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'findPostalCode', '', 0, NULL, NULL, NULL)

--UpdateCustomerMobile
delete cts_serv_catalog 
where csc_service_id in ('CustomerDataManagementService.CustomerManagement.UpdateCustomerMobile')
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.UpdateCustomerMobile', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'updateCustomerMobile', '', 104, null, null, 'N')

--GenerateMatrix
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.GenerateMatrix',  'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'generateMatrix', '', 0, null, null, 'N')

--XMLIngresoIndividual'
delete cts_serv_catalog where csc_service_id in ('Businessprocess.Creditmanagement.Synchronization.XMLIngresoIndividual')
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('Businessprocess.Creditmanagement.Synchronization.XMLIngresoIndividual', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.ISynchronization', 'xMLIngresoIndividual', '', 0, null, null, 'N')

--XMLIngresoGrupal
delete cts_serv_catalog where csc_service_id in ('Businessprocess.Creditmanagement.Synchronization.XMLIngresoGrupal')
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('Businessprocess.Creditmanagement.Synchronization.XMLIngresoGrupal', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.ISynchronization', 'xMLIngresoGrupal', '', 0, null, null, 'N')


--updateFieldFive
delete cts_serv_catalog where csc_service_id in ('Businessprocess.Creditmanagement.ApplicationManagment.UpdateFieldFive')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
values ('Businessprocess.Creditmanagement.ApplicationManagment.UpdateFieldFive', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', 'updateFieldFive', '', 0, NULL, NULL, 'N')


--ValidateGroup


delete cts_serv_catalog where csc_service_id in ('Businessprocess.Creditmanagement.ApplicationManagment.ValidateGroup')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
values ('Businessprocess.Creditmanagement.ApplicationManagment.ValidateGroup', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', 'validateGroup', '', 0, NULL, NULL, 'N')


IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Businessprocess.Creditmanagement.WorkloadOfficerQuery.QueryOfficeOfficer')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IWorkloadOfficerQuery', csc_method_name = 'queryOfficeOfficer', csc_description = '', csc_trn = 21975 WHERE csc_service_id = 'Businessprocess.Creditmanagement.WorkloadOfficerQuery.QueryOfficeOfficer'
ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('Businessprocess.Creditmanagement.WorkloadOfficerQuery.QueryOfficeOfficer', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IWorkloadOfficerQuery', 'queryOfficeOfficer', '', 21975)    	


/* Nuevos servicios para Individuales */
if exists (select * from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.ApplicationManagment.CreateApplicationIndividual')
	update cts_serv_catalog set csc_class_name = 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', csc_method_name = 'createApplicationIndividual', csc_description = '', csc_trn = 77100 where csc_service_id = 'Businessprocess.Creditmanagement.ApplicationManagment.CreateApplicationIndividual'
else
	insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) values ('Businessprocess.Creditmanagement.ApplicationManagment.CreateApplicationIndividual', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', 'createApplicationIndividual', '', 77100)
go

if exists (select * from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.ApplicationManagment.UpdateApplicationIndividual')
	update cts_serv_catalog set csc_class_name = 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', csc_method_name = 'updateApplicationIndividual', csc_description = '', csc_trn = 77300 where csc_service_id = 'Businessprocess.Creditmanagement.ApplicationManagment.UpdateApplicationIndividual'
else
	insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) values ('Businessprocess.Creditmanagement.ApplicationManagment.UpdateApplicationIndividual', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', 'updateApplicationIndividual', '', 77300)
go

-------------------------
--ad_servicio_autorizado
-------------------------
if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CustomerManagement.GetCustomerCycleNumber'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('CustomerDataManagementService.CustomerManagement.GetCustomerCycleNumber', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )


if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Account.ValidateAmounts.ValidateAmountSavingAccounts'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Account.ValidateAmounts.ValidateAmountSavingAccounts', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
    
    
if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'BusinessProcess.LoanRequest.CreditOperation.GetProcessedNumber'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('BusinessProcess.LoanRequest.CreditOperation.GetProcessedNumber', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
    
if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'SystemConfiguration.ParameterManagement.ParameterManagement'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('SystemConfiguration.ParameterManagement.ParameterManagement', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Businessprocess.Creditmanagement.DebtorsManagment.HelpDebtor'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.DebtorsManagment.HelpDebtor', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
    
    if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'BusinessProcess.Customers.QueryCustomer.QueryCustomerEntailment'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('BusinessProcess.Customers.QueryCustomer.QueryCustomerEntailment', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
    
    if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'SystemConfiguration.CatalogManagement.Search'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('SystemConfiguration.CatalogManagement.Search', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

    if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'SystemConfiguration.ParameterManagement.ProcessDate'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('SystemConfiguration.ParameterManagement.ProcessDate', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

    if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Businessprocess.Creditmanagement.ApplicationManagment.CreateNewApplication'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.ApplicationManagment.CreateNewApplication', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Businessprocess.Creditmanagement.DebtorsManagment.CreateDebtor'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.DebtorsManagment.CreateDebtor', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Businessprocess.Creditmanagement.ApplicationQuery.ReadNewApplication'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.ApplicationQuery.ReadNewApplication', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.LoanMaintenance.DeleteTmpTables'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.LoanMaintenance.DeleteTmpTables', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.LoanMaintenance.CreateTmpTables'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.LoanMaintenance.CreateTmpTables', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Businessprocess.Creditmanagement.ApplicationManagment.UpdateNewApplication'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.ApplicationManagment.UpdateNewApplication', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
    
 
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Businessprocess.Creditmanagement.DebtorsManagment.QueryDebtor'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.DebtorsManagment.QueryDebtor', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
    
 if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.LoansQueries.ReadLoanGeneralDataTmp'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.LoansQueries.ReadLoanGeneralDataTmp', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
    
 if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Account.SearchAccount.SearchAccountByCurrency'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Account.SearchAccount.SearchAccountByCurrency', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
    

 if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'SystemConfiguration.OfficeManagement.ReadOffice'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('SystemConfiguration.OfficeManagement.ReadOffice', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
 
 if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.ReadLoanAmortizationTable.ReadLoanAmortizationTableSearchTmp'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.ReadLoanAmortizationTable.ReadLoanAmortizationTableSearchTmp', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.SearchLoanItems.SearchLoanItemsSearch'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.SearchLoanItems.SearchLoanItemsSearch', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.SearchLoanItems.GetLoanItemsDetails_busin'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.SearchLoanItems.GetLoanItemsDetails_busin', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.LoanMaintenance.UpdateLoanDataTmp'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.LoanMaintenance.UpdateLoanDataTmp', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'ICommitPaymentPlan.commitPaymentPlan'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('ICommitPaymentPlan.commitPaymentPlan', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.LoansQueries.SearchLoanItemsTmp'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.LoansQueries.SearchLoanItemsTmp', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.LoanMaintenance.CreateDisbursementForm'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.LoanMaintenance.CreateDisbursementForm', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.LoanMaintenance.removeDisbursementForm'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.LoanMaintenance.removeDisbursementForm', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
    
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'CustomerDataManagementService.CustomerManagement.SearchCustomerReference' and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('CustomerDataManagementService.CustomerManagement.SearchCustomerReference', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
    
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'CustomerDataManagementService.CustomerManagement.SearchAddresProspectSan'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('CustomerDataManagementService.CustomerManagement.SearchAddresProspectSan', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
    
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'CustomerDataManagementService.CustomerManagement.SearchCustomerBusiness'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('CustomerDataManagementService.CustomerManagement.SearchCustomerBusiness', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
    
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'CustomerDataManagementService.CustomerManagement.CreateCustomerReference' and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('CustomerDataManagementService.CustomerManagement.CreateCustomerReference', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
    
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'CustomerDataManagementService.CustomerManagement.CreateCustomerBusiness' and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('CustomerDataManagementService.CustomerManagement.CreateCustomerBusiness', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
    
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'CustomerDataManagementService.CustomerManagement.UpdateCustomerBusiness' and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('CustomerDataManagementService.CustomerManagement.UpdateCustomerBusiness', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'CustomerDataManagementService.CustomerManagement.DeleteCustomerBusiness' and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('CustomerDataManagementService.CustomerManagement.DeleteCustomerBusiness', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Businessprocess.Creditmanagement.LineOpCurrency.GetQuoteBusin' and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.LineOpCurrency.GetQuoteBusin', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

    --Cartera
    --Loan.ReadDisbursementForm.ReadDisbursementFormSearch.Busin hasce referencia en el SG Loan.ReadDisbursementForm.ReadDisbursementFormSearch
    if not exists (select 1 from ad_servicio_autorizado where
        ts_servicio = 'Loan.ReadDisbursementForm.ReadDisbursementFormSearch.Busin' and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.ReadDisbursementForm.ReadDisbursementFormSearch.Busin', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )    
    
    -- Carga de usuario login SearchOfficer
    
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'SystemConfiguration.OfficerManagement.SearchOfficer'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('SystemConfiguration.OfficerManagement.SearchOfficer', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

	-- Ejecuta la regla de monto maximo
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Businessprocess.Creditmanagement.RuleExecutionManagement.QueryRuleAmountMaxInd'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.RuleExecutionManagement.QueryRuleAmountMaxInd', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

    -- Registro de CreateSynchronizationActivity
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Businessprocess.Creditmanagement.Synchronization.CreateSynchronizationActivity'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.Synchronization.CreateSynchronizationActivity', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )

	-- Registro de QuerySynchronizationActivity
	    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Businessprocess.Creditmanagement.Synchronization.QuerySynchronizationActivity'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.Synchronization.QuerySynchronizationActivity', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )	

	-- Registro de UpdateSynchronizationActivity
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Businessprocess.Creditmanagement.Synchronization.UpdateSynchronizationActivity'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.Synchronization.UpdateSynchronizationActivity', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )	

	-- Registro de XMLQuestionnaire
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Businessprocess.Creditmanagement.Synchronization.XMLQuestionnaire'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.Synchronization.XMLQuestionnaire', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
--DeleteDebtor
if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Businessprocess.Creditmanagement.DebtorsManagment.DeleteDebtor'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
insert into dbo.ad_servicio_autorizado 
values ('Businessprocess.Creditmanagement.DebtorsManagment.DeleteDebtor', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )

--CREATE VERIFICATION
delete ad_servicio_autorizado where ts_servicio in ('Businessprocess.Creditmanagement.DataVerification.CreateVerification')
insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Businessprocess.Creditmanagement.DataVerification.CreateVerification', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())

--UPDATE VERIFICATION
delete ad_servicio_autorizado where ts_servicio in ('Businessprocess.Creditmanagement.DataVerification.UpdateVerification')
insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Businessprocess.Creditmanagement.DataVerification.UpdateVerification', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())


--SEARCH VERIFICATION
delete ad_servicio_autorizado where ts_servicio in ('Businessprocess.Creditmanagement.DataVerification.SearchVerification')
insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Businessprocess.Creditmanagement.DataVerification.SearchVerification', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())

--ReadDataCustomer
delete ad_servicio_autorizado where ts_servicio in ('CustomerDataManagementService.CustomerManagement.ReadDataCustomer')
insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.ReadDataCustomer', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

--Query Aplication - Reimpresión
delete ad_servicio_autorizado where ts_servicio in ('Businessprocess.Creditmanagement.ApplicationManagment.QueryCustomerApplication')
insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Businessprocess.Creditmanagement.ApplicationManagment.QueryCustomerApplication', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())

--UpdateEconomicInformation - Mobile
delete ad_servicio_autorizado where ts_servicio in ('CustomerDataManagementService.CustomerManagement.UpdateEconomicInformation')
insert into ad_servicio_autorizado
	(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.UpdateEconomicInformation', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())

--Buscar Documentos

delete ad_servicio_autorizado
where ts_servicio in ('Businessprocess.Creditmanagement.DocumentsApplicationQuery.SearchDocuments')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Businessprocess.Creditmanagement.DocumentsApplicationQuery.SearchDocuments', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())

--Buscar SearchDocumentsApplication
delete ad_servicio_autorizado
where ts_servicio in ('Businessprocess.Creditmanagement.DocumentsApplicationManagment.SearchDocumentsApplication')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Businessprocess.Creditmanagement.DocumentsApplicationManagment.SearchDocumentsApplication', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())

--CreateDocumentsApplication
delete ad_servicio_autorizado
where ts_servicio in ('Businessprocess.Creditmanagement.DocumentsApplicationManagment.CreateDocumentsApplication')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Businessprocess.Creditmanagement.DocumentsApplicationManagment.CreateDocumentsApplication', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())
	

--FindPostalCode
delete ad_servicio_autorizado
where ts_servicio in ('CustomerDataManagementService.CustomerManagement.FindPostalCode')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.FindPostalCode', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())

--UpdateCustomerMobile
delete ad_servicio_autorizado 
where ts_servicio in ('CustomerDataManagementService.CustomerManagement.UpdateCustomerMobile')
insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.UpdateCustomerMobile', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())

--GenerateMatrix
delete ad_servicio_autorizado 
where ts_servicio in ('CustomerDataManagementService.CustomerManagement.GenerateMatrix')
insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.GenerateMatrix', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())
	
--XMLIngresoIndividual
delete ad_servicio_autorizado where ts_servicio in ('Businessprocess.Creditmanagement.Synchronization.XMLIngresoIndividual')
insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Businessprocess.Creditmanagement.Synchronization.XMLIngresoIndividual', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())

--XMLIngresoGrupal
delete ad_servicio_autorizado where ts_servicio in ('Businessprocess.Creditmanagement.Synchronization.XMLIngresoGrupal')
insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Businessprocess.Creditmanagement.Synchronization.XMLIngresoGrupal', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())

--UpdateFieldFive
delete ad_servicio_autorizado where ts_servicio in ('Businessprocess.Creditmanagement.ApplicationManagment.UpdateFieldFive')
insert into ad_servicio_autorizado 
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values ('Businessprocess.Creditmanagement.ApplicationManagment.UpdateFieldFive', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())

--ValidateGroup
delete ad_servicio_autorizado where ts_servicio in ('Businessprocess.Creditmanagement.ApplicationManagment.ValidateGroup')
insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Businessprocess.Creditmanagement.ApplicationManagment.ValidateGroup', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())

--QueryOfficeOfficer
if not exists (select 1 from ad_servicio_autorizado where  ts_servicio = 'Businessprocess.Creditmanagement.WorkloadOfficerQuery.QueryOfficeOfficer'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)
   insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.WorkloadOfficerQuery.QueryOfficeOfficer', @w_rol, @w_producto, 'R', 
   @w_moneda, getdate(), 'V', getdate())
go

--CreateApplicationIndividual
delete cobis..ad_servicio_autorizado where ts_servicio = 'Businessprocess.Creditmanagement.ApplicationManagment.CreateApplicationIndividual'
insert into cobis..ad_servicio_autorizado 
values('Businessprocess.Creditmanagement.ApplicationManagment.CreateApplicationIndividual', @w_rol,@w_producto,'R',@w_moneda,getdate(),'V',getdate())

--UpdateApplicationIndividual
delete cobis..ad_servicio_autorizado where ts_servicio = 'Businessprocess.Creditmanagement.ApplicationManagment.UpdateApplicationIndividual'
insert into cobis..ad_servicio_autorizado
values('Businessprocess.Creditmanagement.ApplicationManagment.UpdateApplicationIndividual', @w_rol,@w_producto,'R',@w_moneda,getdate(),'V',getdate())
