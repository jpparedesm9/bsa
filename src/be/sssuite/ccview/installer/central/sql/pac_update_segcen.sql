use cobis
go

declare @w_tabla int,
        @w_co_id int

select @w_tabla = codigo
from cobis..cl_tabla
where tabla = 'an_product'

---------------------------------------- VISTA CONSOLIDADA DE CLIENTES ------------------------------------
--Eliminación de datos
print 'Iniciando Eliminación de datos existentes VISTA CONSOLIDADA'
delete from cobis..cl_catalogo
where tabla  = @w_tabla
  and codigo  = 'M-VCC'
  

delete cobis..an_service_component 
where sc_co_id in (select co_id 
                   from cobis..an_component 
                   where co_name in ('VCC.AdministracionVista','VCC.VistaConsolidada','VCC.AdministradorContenido',
                                     'VCC.SeguridadContenido','VCC.AdministradorSeccion','VCC.DtosPropiedades'))
									 
delete cobis..an_service_component where sc_oc_nemonic = 'M-VCC'


delete cobis..an_transaction_component
where tc_co_id in (select co_id 
                   from cobis..an_component 
                   where co_name in ('VCC.AdministracionVista','VCC.VistaConsolidada','VCC.AdministradorContenido',
                                     'VCC.SeguridadContenido','VCC.AdministradorSeccion','VCC.DtosPropiedades'))
     
delete cobis..an_service_component where sc_co_id = 73000     

print 'Terminando Eliminación de datos existentes VISTA CONSOLIDADA'

--Inserción de datos
print 'Iniciando Inserción de datos para el control de las Funcionalidades por Rol VISTA CONSOLIDADA'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values  (@w_tabla,'M-VCC','VISTA CONSOLIDADA DE CLIENTES','V')

--Componente de la VCC
select @w_co_id = co_id
from cobis..an_component
where co_name ='VCC.VistaConsolidada'

update cobis..an_component
   set co_prod_name = 'M-VCC'
 where co_id = @w_co_id

--Transacciones de la VCC
insert into cobis..an_transaction_component
select @w_co_id, tn_trn_code, 'M-VCC'
  from cobis..cl_ttransaccion
  where tn_trn_code between 73000 and 74990

insert into cobis..an_transaction_component values (@w_co_id, 1182,'M-VCC')
 
insert into cobis..an_transaction_component values (@w_co_id,  132,'M-VCC')
 
insert into cobis..an_transaction_component values (@w_co_id, 1227,'M-VCC')
 
insert into cobis..an_transaction_component values (@w_co_id,  136,'M-VCC')
 
insert into cobis..an_transaction_component values (@w_co_id,21084,'M-VCC')
 
insert into cobis..an_transaction_component values (@w_co_id, 1312,'M-VCC')
 
insert into cobis..an_transaction_component values (@w_co_id, 1315,'M-VCC')
 
insert into cobis..an_transaction_component values (@w_co_id,  150,'M-VCC')
 
insert into cobis..an_transaction_component values (@w_co_id, 1184,'M-VCC')
 
insert into cobis..an_transaction_component values (@w_co_id, 1235,'M-VCC')
 
insert into cobis..an_transaction_component values (@w_co_id, 1181,'M-VCC')
 
insert into cobis..an_transaction_component values (@w_co_id,9594,'M-VCC')
 
insert into cobis..an_transaction_component values (@w_co_id,29452,'M-VCC')
  
insert into cobis..an_transaction_component values (@w_co_id,7002,'M-VCC')
 
insert into cobis..an_transaction_component values (@w_co_id,7010,'M-VCC')
 
insert into cobis..an_transaction_component values (@w_co_id,7027,'M-VCC')
 
insert into cobis..an_transaction_component values (@w_co_id,7061,'M-VCC')
 
insert into cobis..an_transaction_component values (@w_co_id,7143,'M-VCC')
 
insert into cobis..an_transaction_component values (@w_co_id,21610,'M-VCC')

insert into cobis..an_transaction_component values (@w_co_id,1850022,'M-VCC')

insert into cobis..an_transaction_component values (@w_co_id,644,'M-VCC')

insert into cobis..an_transaction_component values (@w_co_id,16979,'M-VCC')

 
delete FROM cobis..an_service_component where sc_oc_nemonic = 'M-VCC'

print 'Terminando Inserción de datos para el control de las Funcionalidades por Rol VISTA CONSOLIDADA'

SELECT @w_co_id = co_id  FROM an_component WHERE co_prod_name = 'M-VCC' and co_name ='VCC.VistaConsolidada'

delete FROM cobis..an_service_component where sc_co_id = @w_co_id
 
print 'Iniciando Inserción de los servicios para el control de las Funcionalidades por Rol VCC'


insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'FPM.Operation.GetBankinProductsApprovedStructure','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'FPM.Operation.GetBankinProductsStructure','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'FPM.Operation.GetBankinProductsRulesFiltered','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'FPM.Operation.GetBankingProductBasicInformationById','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'FPM.Operation.GetBankingProductApprovedInformationById','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'FPM.Catalogs.GetAllCurrencies','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.CustomerService.queryClient','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.CustomerService.queryGroupDetail','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Rate.getAsfiByClientId','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Rate.getInfoCredByClientId','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Rate.getPortfolioRateByClientId','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Rate.getRateByClientId','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Score.serchScoreCustomer','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.GetAllManagementContentSectionRole','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.GetAllManagementContentSectionVCC','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.GetAllProductAdministratorDefaultVCC','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.GetAllRoleConfigurationVCC','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ClientViewer.Administration.GetAllRoleConfigurationVCC','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientViewer.Administration.GetAllRoleConfigurationVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.GetManagementContentSectionRoleByRoleVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.GetManagementContentSectionRoleBySectionVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.getAllDtos','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.getAllDtosByParent','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.getAllProductAdministratorDefaultDinamicByType','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.getDtoSectionById','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.getProductAdministratorDefaultByIdProduct','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.getProductAdministratorDefaultDinamicByParent','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.getPropertiesByDto','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.getPropertiesById','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.BankingProduct.QueryBankingProducts','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Check.QueryProtestedChecks','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Client.AverageBalanceClient','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Client.QueryClient','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Client.QueryClientByParameters','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Client.QueryClientByParametersNext','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Client.QueryClientDirections','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Client.QueryClientRate','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Client.QueryClientReferences','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Client.QueryClientType','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Client.QueryConsolidatedPosition','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Client.QueryGroup','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Client.QueryGroupDetail','M-VCC')


 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Client.QueryGroupMembers','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Client.QueryLegalClient','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Client.QueryLegalRelationships','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Client.QueryPartners','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.HSBC.Client.QueryClient','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.HSBC.Client.QueryGroupDetail','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.HSBC.Client.QueryLegalClient','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.HSBC.Integration.QueryAdvertising','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.HSBC.MaxDebt.QueryMaxDebt','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Products.PrepareProductsData','M-VCC')

--dump tran cobis with no_log

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Products.QueryProductsByClientId','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Sales.QueryProductInformation','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.View.QueryAuthorizedView','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.Administration.GetAllRoleAssociatesVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.Administration.GetAllRoleConfigurationVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.Administration.QueryConfigurationVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.Creditmanagement.RuleByRoleQuery.QueryExceptionByClient','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Loan.ReadOperationGuarantees.GetOperationGuarantees','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ActivityTxService.getEconomicActivity','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ActivityTxService.getMainActivity','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'AddressTxService.getAddressesbyCustomer','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'BusinessSegmentTxService.getBusinessSegment','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ContactTxService.getContactsbyCustomer','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ClientService.createClient','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CustomerTxService.getCustomerAllData','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ProductDetailService.createProductDetail','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'NationalityService.searchNationality','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'PhoneTxService.getPhonebyCustomerAndAddress','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'POBoxTxService.getAllPOBOX','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'QuickCreateTxService.executeQuickCreate','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CustomerService.getCustomerType','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CustomerService.queryGroup','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CustomerService.getGroupsByParameters','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CustomerService.queryClient','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CustomerService.getGroupMembers','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CustomerService.getQueryLegalClient','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CustomerService.getQueryClientAddress','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CustomerService.queryClientRate','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CustomerService.getGroupDetail','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ClientViewer.Client.QueryConsolidatedPosition','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ClientViewer.Products.PrepareProductsData','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ClientViewer.MaxDebt.QueryMaxDebt','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ClientViewer.Products.QueryProductsByClientId','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetSupervisorTaskList','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ISalesProduct.startProcessInstance','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Preferences.getUserPreferences','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Official.GetOfficialInfo','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Favorites.getUserFavorites','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Score.searchPunctuationCustomer','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.ContainerInfo.getContainerInfo','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.CreateProcessInstance','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.GetTaskListCriteria','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'HTM.API.HumanTask.ClaimTask','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.GetComments','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryAllStepPolicy','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'BankingServices.Query.Remittance.QueryRemittanceByClientAndBeneficiary','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.UpdateInstanceProcess','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ClientViewer.Client.QueryClient','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ClientViewer.Client.QueryClientByParameters','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ClientViewer.Client.QueryClientDirections','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ClientViewer.Client.QueryClientRate','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ClientViewer.Client.QueryClientType','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ClientViewer.Client.QueryGroup','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ClientViewer.Client.QueryGroupDetail','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ClientViewer.Client.QueryGroupMembers','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ClientViewer.Client.QueryLegalClient','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.Query.RuleQueryManager.FindRuleActiveByAcronym', 'M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Bpl.Rules.Engine.RuleManager.Generate','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Inbox.CommentsManager.GetRecords','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryHierarchyLevelProcessInstance','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryRuleProcessHistory','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryActivitiesRequirements','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'FPM.Operation.FindAllAvailableBankingProducts','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryExceptionApprovedByStep','M-VCC')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.CreateClaimRequest','M-VCC')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.CreateClaimSettlement','M-VCC')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.DeleteClaimRequest','M-VCC')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.DeleteClaimSettlement','M-VCC')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.ReadCategoryClaim','M-VCC')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.ReadClaimRequest','M-VCC')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.ReadClaimSettlement','M-VCC')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.ReadSubcategoryClaim','M-VCC')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.SearchCategoryClaim','M-VCC')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.SearchClaimDuplicates','M-VCC')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.SearchClaimRequest','M-VCC')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.SearchClaimSettlement','M-VCC')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.SearchDescriptionSettlement','M-VCC')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.SearchSubcategoryClaim','M-VCC')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.UpdateClaimRequest','M-VCC')
 
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.UpdateClaimSettlement','M-VCC')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Businessprocess.CRM.CRMServices.AddDaysSkipHolidays','M-VCC')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CustomerService.getCustomersByParameters','M-VCC')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryRuleInstanceProcess','M-VCC')

insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Workflow.Admin.WorkflowAdmin.QueryRuleHistory','M-VCC')

--dump tran cobis with no_log

SELECT @w_co_id = co_id  FROM an_component WHERE co_prod_name = 'M-VCC' and  co_name ='VCC.AdministracionVista'

delete FROM cobis..an_service_component where sc_co_id = @w_co_id

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CustomerService.queryGroup','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CustomerService.getCustomersByParameters','M-VCC') 

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Preferences.getUserPreferences','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Official.GetOfficialInfo','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Favorites.getUserFavorites','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.ContainerInfo.getContainerInfo','M-VCC')


--dump tran cobis with no_log

SELECT @w_co_id = co_id  FROM an_component WHERE co_prod_name = 'M-VCC' and  co_name ='VCC.AdministradorContenido'

delete FROM cobis..an_service_component where sc_co_id = @w_co_id

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.deleteManagementContentSectionById','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.insertManagementContentSection','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.updateManagementContentSectionById','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ClientViewer.Administration.GetAllManagementContentSectionVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientViewer.Administration.GetAllManagementContentSectionVCC','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.GetAllManagementContentSectionVCC','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Preferences.getUserPreferences','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Official.GetOfficialInfo','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Favorites.getUserFavorites','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.ContainerInfo.getContainerInfo','M-VCC')


--dump tran cobis with no_log

SELECT @w_co_id = co_id  FROM an_component WHERE co_prod_name = 'M-VCC' and   co_name ='VCC.SeguridadContenido'

delete FROM cobis..an_service_component where sc_co_id = @w_co_id

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.deleteManagementContentSectionRole','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.insertManagementContentSectionRole','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.GetAllManagementContentSectionRole','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ClientViewer.Administration.GetAllManagementContentSectionVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ClientViewer.Administration.GetAllRoleConfigurationVCC','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientViewer.Administration.GetAllRoleConfigurationVCC','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.GetAllRoleConfigurationVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Preferences.getUserPreferences','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Official.GetOfficialInfo','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Favorites.getUserFavorites','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.ContainerInfo.getContainerInfo','M-VCC') 


--dump tran cobis with no_log

SELECT @w_co_id = co_id  FROM an_component WHERE co_prod_name = 'M-VCC' and co_name ='VCC.AdministradorSeccion'

delete FROM cobis..an_service_component where sc_co_id = @w_co_id

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.Administration.DefaultConfigurationVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.Administration.DeleteConfigurationVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.Administration.GetAllRoleAssociatesVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.Administration.GetAllRoleConfigurationVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.Administration.InsertConfigurationVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.Administration.QueryConfigurationVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.Administration.UpdateConfigurationVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.DeleteParameter','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.DeleteProductFuncionality','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.InsertFuncionalityInProduct','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.InsertParameter','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.InsertParameterValue','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.QueryFuncionalitiesAttached','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.QueryFuncionalitiesByProduct','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.QueryParametersAndValues','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.QueryProducts','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.UpdateParameter','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'UCSP.Admin.UpdateParameterValue','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.GetAllManagementContentSectionRole','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.GetAllManagementContentSectionVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.GetAllProductAdministratorDefaultVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.GetAllRoleConfigurationVCC','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ClientViewer.Administration.GetAllRoleConfigurationVCC','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientViewer.Administration.GetAllRoleConfigurationVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.GetManagementContentSectionRoleByRoleVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.GetManagementContentSectionRoleBySectionVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.InsertConfigurationVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.QueryConfigurationVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.UpdateConfigurationVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.deleteDefaultProductAdministratorById','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.deleteDtoSection','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.deleteManagementContentSectionById','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.deleteManagementContentSectionRole','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.deletePropertiesSection','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.getAllDtos','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.getAllDtosByParent','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.getAllProductAdministratorDefaultDinamicByType','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.getDtoById','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.getDtoSectionById','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.getProductAdministratorDefaultByIdProduct','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.getProductAdministratorDefaultDinamicByParent','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.getPropertiesByDto','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.getPropertiesById','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.insertDefaultProductAdministrator','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.insertDtoSection','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.insertManagementContentSection','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.insertManagementContentSectionRole','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.insertPropertiesSection','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.updateDefaultProductAdministratorById','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.updateDtoSection','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.updateManagementContentSectionById','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.updatePropertiesSection','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'ClientViewer.Administration.DeleteConfigurationVCC','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.DeleteConfigurationVCC','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Preferences.getUserPreferences','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Official.GetOfficialInfo','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Favorites.getUserFavorites','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.ContainerInfo.getContainerInfo','M-VCC')

--dump tran cobis with no_log

SELECT @w_co_id = co_id  FROM an_component WHERE co_prod_name = 'M-VCC' and  co_name ='VCC.DtosPropiedades'

delete FROM cobis..an_service_component where sc_co_id = @w_co_id

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.getAllDtos','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.deleteDtoSection','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.insertDtoSection','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.updateDtoSection','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.insertPropertiesSection','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.updatePropertiesSection','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.deletePropertiesSection','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientviewer.Administration.getPropertiesByDto','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientViewer.Products.PrepareProductsDataHistory','M-VCC')
 
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'clientViewer.Products.QueryHistoryProductsByClientId', 'M-VCC') 
  
insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Preferences.getUserPreferences','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Official.GetOfficialInfo','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.Favorites.getUserFavorites','M-VCC')

insert into cobis..an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'CEW.ContainerInfo.getContainerInfo','M-VCC')

--dump tran cobis with no_log
print 'Finalizando Inserción de los servicios para el control de las Funcionalidades por Rol VCC'
go
