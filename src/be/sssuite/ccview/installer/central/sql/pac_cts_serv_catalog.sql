/***************************************************************/
/* NOMBRE LOGICO:  pac_cts_serv_catalog.sql	    		       */
/* PRODUCTO:       PLATAFORMA DE ATENCIÓN A CLIENTE 	       */
/***************************************************************/
/*                       IMPORTANTE                            */
/* Esta Aplicaci?n es parte de los paquetes bancarios pro-     */
/* piedad de MACOSA.                                           */
/* Su uso no autorizado queda expresamente prohibido asf como  */
/* cualquier alteraci=n o agregado hecho por alguno de sus     */
/* usuarios sin el debido consentimiento por escrito de MACOSA.*/
/* Este Programa esta protegido por la Ley de derechos de autor*/
/* y por las convenciones internacionales de propiedad inte-   */
/* lectual. Su uso no autorizado dara derecho a MACOSA para    */
/* obtener ordenes de secuestro o retencion y para perseguir   */
/* penalmente a los autores de cualquier infraccion.           */
/***************************************************************/
/*                         PROPOSITO                           */
/* Permite realizar el insert de los datos de catalogo para la */ 
/* ejecucion de servicios a traves de ServiceExecutor 		   */
/***************************************************************/
/*                        MODIFICACIONES                       */
/* FECHA         AUTOR             			RAZON              */
/* 04-NOV-2010	Santiago Gavilanes		Emision inicial	       */
/* 11-FEB-2011	César Loachamin			Ingreso servicios      */
/* 										vista 360              */
/* 27-MAR-2014  Sergio Hidalgo          Agregado de Servicios  */
/*                                      para el Administrador  */
/*                                      de la Vista y HSBC     */
/***************************************************************/

use cobis
go

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Admin.Administration.DefaultConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Admin.Administration.DefaultConfigurationVCC','cobiscorp.ecobis.ucsp.admin.service.IAdministration','defaultConfigurationVCC',' ',731001)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Admin.Administration.DeleteConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Admin.Administration.DeleteConfigurationVCC','cobiscorp.ecobis.ucsp.admin.service.IAdministration','deleteConfigurationVCC',' ',731001)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Admin.Administration.GetAllRoleAssociatesVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Admin.Administration.GetAllRoleAssociatesVCC','cobiscorp.ecobis.ucsp.admin.service.IAdministration','getAllRoleAssociatesVCC',' ',731001)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Admin.Administration.GetAllRoleConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Admin.Administration.GetAllRoleConfigurationVCC','cobiscorp.ecobis.ucsp.admin.service.IAdministration','getAllRoleConfigurationVCC',' ',731001)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Admin.Administration.InsertConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Admin.Administration.InsertConfigurationVCC','cobiscorp.ecobis.ucsp.admin.service.IAdministration','insertConfigurationVCC',' ',731001)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Admin.Administration.QueryConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Admin.Administration.QueryConfigurationVCC','cobiscorp.ecobis.ucsp.admin.service.IAdministration','queryConfigurationVCC',' ',731001)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Admin.Administration.UpdateConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Admin.Administration.UpdateConfigurationVCC','cobiscorp.ecobis.ucsp.admin.service.IAdministration','updateConfigurationVCC',' ',731001)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Admin.DeleteParameter')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Admin.DeleteParameter','cobiscorp.ecobis.ucsp.service.IAdmin','deleteParameter',' ',73018)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Admin.DeleteProductFuncionality')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Admin.DeleteProductFuncionality','cobiscorp.ecobis.ucsp.service.IAdmin','deleteProductFuncionality',' ',73015)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Admin.InsertFuncionalityInProduct')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Admin.InsertFuncionalityInProduct','cobiscorp.ecobis.ucsp.service.IAdmin','insertProductFuncionality',' ',73014)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Admin.InsertParameter')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Admin.InsertParameter','cobiscorp.ecobis.ucsp.service.IAdmin','insertParameter',' ',73016)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Admin.InsertParameterValue')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Admin.InsertParameterValue','cobiscorp.ecobis.ucsp.service.IAdmin','insertParameterValue',' ',73019)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Admin.QueryFuncionalitiesAttached')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Admin.QueryFuncionalitiesAttached','cobiscorp.ecobis.ucsp.service.IAdmin','queryFuncionalitiesAttached',' ',73012)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Admin.QueryFuncionalitiesByProduct')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Admin.QueryFuncionalitiesByProduct','cobiscorp.ecobis.ucsp.service.IAdmin','queryFuncionalitiesByProduct',' ',73011)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Admin.QueryParametersAndValues')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Admin.QueryParametersAndValues','cobiscorp.ecobis.ucsp.service.IAdmin','queryParametersAndValues',' ',73013)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Admin.QueryProducts')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Admin.QueryProducts','cobiscorp.ecobis.ucsp.service.IAdmin','queryProducts',' ',73010)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Admin.UpdateParameter')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Admin.UpdateParameter','cobiscorp.ecobis.ucsp.service.IAdmin','updateParameter',' ',73017)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Admin.UpdateParameterValue')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Admin.UpdateParameterValue','cobiscorp.ecobis.ucsp.service.IAdmin','updateParameterValue',' ',73020)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.BankingProduct.QueryBankingProducts')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.BankingProduct.QueryBankingProducts','cobiscorp.ecobis.ucsp.service.IBankingProduct','queryBankingProducts',' ',73002)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Check.QueryProtestedChecks')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Check.QueryProtestedChecks','cobiscorp.ecobis.ucsp.service.ICheck','queryProtestedChecks',' ',73008)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Client.AverageBalanceClient')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Client.AverageBalanceClient','cobiscorp.ecobis.ucsp.service.IClient','averageBalanceClient',' ',73005)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Client.QueryClient')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Client.QueryClient','cobiscorp.ecobis.ucsp.service.IClient','queryClient',' ',132)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Client.QueryClientByParameters')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Client.QueryClientByParameters','cobiscorp.ecobis.ucsp.service.IClient','queryClientByParameters',' ',132)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Client.QueryClientByParametersNext')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Client.QueryClientByParametersNext','cobiscorp.ecobis.ucsp.service.IClient','queryClientByParametersNext',' ',132)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Client.QueryClientDirections')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Client.QueryClientDirections','cobiscorp.ecobis.ucsp.service.IClient','queryClientDirections',' ',1182)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Client.QueryClientRate')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Client.QueryClientRate','cobiscorp.ecobis.ucsp.service.IClient','queryClientRate',' ',73007)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Client.QueryClientReferences')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Client.QueryClientReferences','cobiscorp.ecobis.ucsp.service.IClient','queryClientReferences',' ',136)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Client.QueryClientType')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Client.QueryClientType','cobiscorp.ecobis.ucsp.service.IClient','queryClientType',' ',1181)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Client.QueryConsolidatedPosition')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Client.QueryConsolidatedPosition','cobiscorp.ecobis.ucsp.service.IClient','queryConsolidatedPosition',' ',73005)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Client.QueryGroup')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Client.QueryGroup','cobiscorp.ecobis.ucsp.service.IClient','queryGroup',' ',150)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Client.QueryGroupDetail')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Client.QueryGroupDetail','cobiscorp.ecobis.ucsp.service.IClient','queryGroupDetail',' ',1184)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Client.QueryGroupMembers')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Client.QueryGroupMembers','cobiscorp.ecobis.ucsp.service.IClient','queryGroupMembers',' ',1235)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Client.QueryLegalClient')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Client.QueryLegalClient','cobiscorp.ecobis.ucsp.service.IClient','queryLegalClient',' ',1034)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Client.QueryLegalRelationships')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Client.QueryLegalRelationships','cobiscorp.ecobis.ucsp.service.IClient','queryLegalRelationships',' ',1312)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Client.QueryPartners')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Client.QueryPartners','cobiscorp.ecobis.ucsp.service.IClient','queryPartners',' ',1315)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.HSBC.Client.QueryClient')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.HSBC.Client.QueryClient','cobiscorp.ecobis.ucsp.hsbc.service.IClient','queryClient',' ',132)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.HSBC.Client.QueryGroupDetail')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.HSBC.Client.QueryGroupDetail','cobiscorp.ecobis.ucsp.hsbc.service.IClient','queryGroupDetail',' ',1184)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.HSBC.Client.QueryLegalClient')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.HSBC.Client.QueryLegalClient','cobiscorp.ecobis.ucsp.hsbc.service.IClient','queryLegalClient',' ',1218)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.HSBC.Integration.QueryAdvertising')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.HSBC.Integration.QueryAdvertising','cobiscorp.ecobis.ucsp.hsbc.service.IIntegration','queryAdvertising',' ',1718)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.HSBC.MaxDebt.QueryMaxDebt')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.HSBC.MaxDebt.QueryMaxDebt','cobiscorp.ecobis.ucsp.hsbc.service.IMaxDebt','queryMaxDebt',' ',9390)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Products.PrepareProductsData')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Products.PrepareProductsData','cobiscorp.ecobis.ucsp.service.IProducts','prepareProductsData',' ',21084)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Products.QueryProductsByClientId')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Products.QueryProductsByClientId','cobiscorp.ecobis.ucsp.service.IProducts','queryProductsByClientId',' ',73004)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.Sales.QueryProductInformation')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.Sales.QueryProductInformation','cobiscorp.ecobis.ucsp.service.ISales','queryProductInformation',' ',73003)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'UCSP.View.QueryAuthorizedView')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('UCSP.View.QueryAuthorizedView','cobiscorp.ecobis.ucsp.service.IView','queryAuthorizedView',' ',73009)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerService.getCustomerType')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('CustomerService.getCustomerType','com.cobiscorp.ecobis.customer.commons.CustomerService','getCustomerType','getCustomerType',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerService.getCustomersByParameters')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('CustomerService.getCustomersByParameters','com.cobiscorp.ecobis.customer.commons.CustomerService','getCustomersByParameters','getCustomersByParameters',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerService.checkColumnExist')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('CustomerService.checkColumnExist','com.cobiscorp.ecobis.customer.commons.CustomerService','checkColumnExist','checkColumnExist',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerService.getCustomersByAutoCompleteText')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('CustomerService.getCustomersByAutoCompleteText','com.cobiscorp.ecobis.customer.commons.CustomerService','getCustomersByAutoCompleteText','getCustomersByAutoCompleteText',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerService.getGroupDetail')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('CustomerService.getGroupDetail','com.cobiscorp.ecobis.customer.commons.CustomerService','getGroupDetail','getGroupDetail',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerService.getGroupMembers')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('CustomerService.getGroupMembers','com.cobiscorp.ecobis.customer.commons.CustomerService','getGroupMembers','getGroupMembers',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerService.getQueryClientAddress')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('CustomerService.getQueryClientAddress','com.cobiscorp.ecobis.customer.commons.CustomerService','getQueryClientAddress','getQueryClientAddress',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerService.getQueryLegalClient')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('CustomerService.getQueryLegalClient','com.cobiscorp.ecobis.customer.commons.CustomerService','getQueryLegalClient','getQueryLegalClient',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerService.queryClient')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('CustomerService.queryClient','com.cobiscorp.ecobis.customer.commons.CustomerService','queryClient','queryClient',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerService.queryClientRate')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('CustomerService.queryClientRate','com.cobiscorp.ecobis.customer.commons.CustomerService','queryClientRate','queryClientRate',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerService.queryGroup')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('CustomerService.queryGroup','com.cobiscorp.ecobis.customer.commons.CustomerService','queryGroup','queryGroup',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerService.getGroupsByParameters')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('CustomerService.getGroupsByParameters','com.cobiscorp.ecobis.customer.commons.CustomerService','getGroupsByParameters','getGroupsByParameters',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'ClientViewer.Administration.DeleteConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('ClientViewer.Administration.DeleteConfigurationVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','deleteProductAdministrator',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.DeleteConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.DeleteConfigurationVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','deleteProductAdministrator',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientViewer.Administration.GetAllRoleConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientViewer.Administration.GetAllRoleConfigurationVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllRolesProductAdministrator',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'ClientViewer.Administration.GetAllRoleConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('ClientViewer.Administration.GetAllRoleConfigurationVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllRolesProductAdministrator',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.GetAllRoleConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.GetAllRoleConfigurationVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllRolesProductAdministrator',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.InsertConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.InsertConfigurationVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','insertProductAdministrator',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.QueryConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.QueryConfigurationVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getProductAdministratorByRole',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.UpdateConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.UpdateConfigurationVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','updateProductAdministrator',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'ClientViewer.Client.QueryClient')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('ClientViewer.Client.QueryClient','com.cobiscorp.ecobis.customer.CustomerService','queryClient',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'ClientViewer.Client.QueryClientByParameters')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('ClientViewer.Client.QueryClientByParameters','com.cobiscorp.ecobis.customer.CustomerService','getCustomersByParameters',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'ClientViewer.Client.QueryClientDirections')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('ClientViewer.Client.QueryClientDirections','com.cobiscorp.ecobis.customer.CustomerService','getQueryClientAddress',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'ClientViewer.Client.QueryClientRate')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('ClientViewer.Client.QueryClientRate','com.cobiscorp.ecobis.customer.CustomerService','queryClientRate',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'ClientViewer.Client.QueryClientType')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('ClientViewer.Client.QueryClientType','com.cobiscorp.ecobis.customer.CustomerService','getCustomerType',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'ClientViewer.Client.QueryConsolidatedPosition')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('ClientViewer.Client.QueryConsolidatedPosition','com.cobiscorp.ecobis.clientviewer.ConsolidatePositionService','queryConsolidatedPosition',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'ClientViewer.Client.QueryGroup')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('ClientViewer.Client.QueryGroup','com.cobiscorp.ecobis.customer.CustomerService','queryGroup',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'ClientViewer.Client.QueryGroupDetail')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('ClientViewer.Client.QueryGroupDetail','com.cobiscorp.ecobis.customer.CustomerService','getGroupDetail',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'ClientViewer.Client.QueryGroupMembers')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('ClientViewer.Client.QueryGroupMembers','com.cobiscorp.ecobis.customer.CustomerService','getGroupMembers',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'ClientViewer.Client.QueryLegalClient')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('ClientViewer.Client.QueryLegalClient','com.cobiscorp.ecobis.customer.CustomerService','getQueryLegalClient',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'ClientViewer.MaxDebt.QueryMaxDebt')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('ClientViewer.MaxDebt.QueryMaxDebt','com.cobiscorp.ecobis.clientviewer.MaxDebtService','getMaxDebt',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'ClientViewer.Products.PrepareProductsData')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('ClientViewer.Products.PrepareProductsData','com.cobiscorp.ecobis.clientviewer.PrepareProductsDataService','prepareProductsData',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'ClientViewer.Products.QueryProductsByClientId')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('ClientViewer.Products.QueryProductsByClientId','com.cobiscorp.ecobis.clientviewer.QueryProductsService','queryProductsByClientId',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Score.serchScoreCustomer')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Score.serchScoreCustomer','com.cobiscorp.ecobis.clientviewer.IScoreServices','searchScoreCustomer',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Score.serchScoreCustomer')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Score.serchScoreCustomer','com.cobiscorp.ecobis.clientviewer.IScoreServices','searchScoreCustomer',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Score.searchPunctuationCustomer')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Score.searchPunctuationCustomer','com.cobiscorp.ecobis.clientviewer.IScoreServices','searchPunctuationCustomer','searchPunctuationCustomer',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'ISalesProduct.startProcessInstance')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('ISalesProduct.startProcessInstance','com.cobiscorp.ecobis.sales.api.ISalesProduct','startProcessInstance',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'AddressTxService.getAddressesbyCustomer')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('AddressTxService.getAddressesbyCustomer','com.cobiscorp.ecobis.customer.services.AddressTxService','getAddressesbyCustomer',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'BankingServices.Query.Remittance.QueryRemittanceByClientAndBeneficiary')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('BankingServices.Query.Remittance.QueryRemittanceByClientAndBeneficiary','cobiscorp.ecobis.bankingservices.query.service.IRemittance','queryRemittanceByClientAndBeneficiary',' ',29452)

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'BankingServices.Query.Remittance.QueryRemittanceByClientAndBeneficiary')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('BankingServices.Query.Remittance.QueryRemittanceByClientAndBeneficiary',3,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Comext.Query.ComextQuery.QueryAnnualTransferenceByClient')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('Comext.Query.ComextQuery.QueryAnnualTransferenceByClient','cobiscorp.ecobis.comext.query.service.IComextQuery','queryAnnualTransferenceByClient',' ',9594)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.getDtoSectionById')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.getDtoSectionById','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getDtoSectionById',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.insertDtoSection')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.insertDtoSection','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','insertDtoSection',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.updateDtoSection')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.updateDtoSection','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','updateDtoSection',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.deleteDtoSection')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.deleteDtoSection','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','deleteDtoSection',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.getPropertiesByDto')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.getPropertiesByDto','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getPropertiesByDto',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.getPropertiesById')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.getPropertiesById','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getPropertiesById',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.insertPropertiesSection')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.insertPropertiesSection','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','insertPropertiesSection',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.updatePropertiesSection')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.updatePropertiesSection','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','updatePropertiesSection',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.deletePropertiesSection')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.deletePropertiesSection','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','deletePropertiesSection',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.getProductAdministratorDefaultByIdProduct')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.getProductAdministratorDefaultByIdProduct','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getProductAdministratorDefaultByIdProduct',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.getAllDtos')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.getAllDtos','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllDtos',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.deleteManagementContentSectionById')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.deleteManagementContentSectionById','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','deleteManagementContentSectionById',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.deleteManagementContentSectionRole')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.deleteManagementContentSectionRole','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','deleteManagementContentSectionRole',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.getAllManagementContentSectionRole')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.getAllManagementContentSectionRole','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllManagementContentSectionRole',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.GetAllManagementContentSectionVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.GetAllManagementContentSectionVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllManagementContentSection','Obtiene vcc_section_management_content',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientViewer.Administration.GetAllManagementContentSectionVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientViewer.Administration.GetAllManagementContentSectionVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllManagementContentSection','Obtiene vcc_section_management_content',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.GetAllProductAdministratorDefaultVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.GetAllProductAdministratorDefaultVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllProductAdministratorDefaultDinamic','Obtiene todo los campos de deudas',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.GetManagementContentSectionRoleByRoleVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.GetManagementContentSectionRoleByRoleVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getManagementContentSectionRoleByRole','Obtiene vcc_rol_content_management por rol',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.GetManagementContentSectionRoleBySectionVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.GetManagementContentSectionRoleBySectionVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getManagementContentSectionRoleBySection','Obtiene vcc_rol_content_management por sección',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.insertManagementContentSection')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.insertManagementContentSection','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','insertManagementContentSection',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.insertManagementContentSectionRole')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.insertManagementContentSectionRole','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','insertManagementContentSectionRole',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.updateManagementContentSectionById')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.updateManagementContentSectionById','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','updateManagementContentSectionById',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientViewer.Administration.GetAllManagementContentSectionVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientViewer.Administration.GetAllManagementContentSectionVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllManagementContentSection',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientViewer.Administration.GetAllRoleConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientViewer.Administration.GetAllRoleConfigurationVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllRolesProductAdministrator',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'ClientViewer.Administration.GetAllRoleConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('ClientViewer.Administration.GetAllRoleConfigurationVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllRolesProductAdministrator',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.GetAllRoleConfigurationVCC')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.GetAllRoleConfigurationVCC','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllRolesProductAdministrator',' ',0)

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.Administration.GetAllManagementContentSectionRole')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values('clientviewer.Administration.GetAllManagementContentSectionRole','com.cobiscorp.ecobis.clientviewer.admin.AdministratorService','getAllManagementContentSectionRole',' ',0)

-----------------------------------------------------ad_servicio_autorizado-----------------------------------------------------------

declare @w_id_rol  int

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
	select @w_id_rol =  max(ro_rol)+1 from cobis..ad_rol
	insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
	values (@w_id_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_id_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'BankingServices.Query.Remittance.QueryRemittanceByClientAndBeneficiary' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('BankingServices.Query.Remittance.QueryRemittanceByClientAndBeneficiary',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Admin.Administration.DefaultConfigurationVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Admin.Administration.DefaultConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Admin.Administration.DeleteConfigurationVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Admin.Administration.DeleteConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Admin.Administration.GetAllRoleAssociatesVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Admin.Administration.GetAllRoleAssociatesVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Admin.Administration.GetAllRoleConfigurationVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Admin.Administration.GetAllRoleConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Admin.Administration.InsertConfigurationVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Admin.Administration.InsertConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Admin.Administration.QueryConfigurationVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Admin.Administration.QueryConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Admin.Administration.UpdateConfigurationVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Admin.Administration.UpdateConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Admin.DeleteParameter' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Admin.DeleteParameter',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Admin.DeleteProductFuncionality' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Admin.DeleteProductFuncionality',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Admin.InsertFuncionalityInProduct' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Admin.InsertFuncionalityInProduct',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Admin.InsertParameter' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Admin.InsertParameter',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Admin.InsertParameterValue' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Admin.InsertParameterValue',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Admin.QueryFuncionalitiesAttached' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Admin.QueryFuncionalitiesAttached',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Admin.QueryFuncionalitiesByProduct' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Admin.QueryFuncionalitiesByProduct',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Admin.QueryParametersAndValues' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Admin.QueryParametersAndValues',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Admin.QueryProducts' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Admin.QueryProducts',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Admin.UpdateParameter' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Admin.UpdateParameter',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Admin.UpdateParameterValue' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Admin.UpdateParameterValue',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.BankingProduct.QueryBankingProducts' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.BankingProduct.QueryBankingProducts',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Check.QueryProtestedChecks' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Check.QueryProtestedChecks',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Client.AverageBalanceClient' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Client.AverageBalanceClient',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Client.QueryClient' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Client.QueryClient',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Client.QueryClientByParameters' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Client.QueryClientByParameters',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Client.QueryClientByParametersNext' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Client.QueryClientByParametersNext',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Client.QueryClientDirections' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Client.QueryClientDirections',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Client.QueryClientRate' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Client.QueryClientRate',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Client.QueryClientReferences' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Client.QueryClientReferences',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Client.QueryClientType' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Client.QueryClientType',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Client.QueryConsolidatedPosition' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Client.QueryConsolidatedPosition',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Client.QueryGroup' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Client.QueryGroup',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Client.QueryGroupDetail' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Client.QueryGroupDetail',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Client.QueryGroupMembers' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Client.QueryGroupMembers',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Client.QueryLegalClient' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Client.QueryLegalClient',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Client.QueryLegalRelationships' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Client.QueryLegalRelationships',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Client.QueryPartners' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Client.QueryPartners',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.HSBC.Client.QueryClient' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.HSBC.Client.QueryClient',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.HSBC.Client.QueryGroupDetail' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.HSBC.Client.QueryGroupDetail',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.HSBC.Client.QueryLegalClient' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.HSBC.Client.QueryLegalClient',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.HSBC.Integration.QueryAdvertising' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.HSBC.Integration.QueryAdvertising',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.HSBC.MaxDebt.QueryMaxDebt' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.HSBC.MaxDebt.QueryMaxDebt',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Products.PrepareProductsData' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Products.PrepareProductsData',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Products.QueryProductsByClientId' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Products.QueryProductsByClientId',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.Sales.QueryProductInformation' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.Sales.QueryProductInformation',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'UCSP.View.QueryAuthorizedView' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('UCSP.View.QueryAuthorizedView',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'CustomerService.getCustomerType' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerService.getCustomerType',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'CustomerService.getCustomersByParameters' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerService.getCustomersByParameters',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'CustomerService.checkColumnExist')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerService.checkColumnExist',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'CustomerService.getCustomersByAutoCompleteText')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerService.getCustomersByAutoCompleteText',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'CustomerService.getGroupDetail' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerService.getGroupDetail',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'CustomerService.getGroupMembers' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerService.getGroupMembers',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'CustomerService.getQueryClientAddress' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerService.getQueryClientAddress',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'CustomerService.getQueryLegalClient' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerService.getQueryLegalClient',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'CustomerService.queryClient' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerService.queryClient',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'CustomerService.queryClientRate' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerService.queryClientRate',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'CustomerService.queryGroup' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerService.queryGroup',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'CustomerService.getGroupsByParameters' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerService.getGroupsByParameters',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'ClientViewer.Administration.DeleteConfigurationVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('ClientViewer.Administration.DeleteConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.DeleteConfigurationVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.DeleteConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientViewer.Administration.GetAllRoleConfigurationVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientViewer.Administration.GetAllRoleConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.GetAllRoleConfigurationVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.GetAllRoleConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'ClientViewer.Administration.GetAllRoleConfigurationVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('ClientViewer.Administration.GetAllRoleConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.InsertConfigurationVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.InsertConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.QueryConfigurationVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.QueryConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.UpdateConfigurationVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.UpdateConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'ClientViewer.Client.QueryClient' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('ClientViewer.Client.QueryClient',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'ClientViewer.Client.QueryClientByParameters' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('ClientViewer.Client.QueryClientByParameters',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'ClientViewer.Client.QueryClientDirections' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('ClientViewer.Client.QueryClientDirections',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'ClientViewer.Client.QueryClientRate' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('ClientViewer.Client.QueryClientRate',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'ClientViewer.Client.QueryClientType' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('ClientViewer.Client.QueryClientType',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'ClientViewer.Client.QueryConsolidatedPosition' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('ClientViewer.Client.QueryConsolidatedPosition',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'ClientViewer.Client.QueryGroup' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('ClientViewer.Client.QueryGroup',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'ClientViewer.Client.QueryGroupDetail' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('ClientViewer.Client.QueryGroupDetail',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'ClientViewer.Client.QueryGroupMembers' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('ClientViewer.Client.QueryGroupMembers',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'ClientViewer.Client.QueryLegalClient' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('ClientViewer.Client.QueryLegalClient',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'ClientViewer.MaxDebt.QueryMaxDebt' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('ClientViewer.MaxDebt.QueryMaxDebt',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'ClientViewer.Products.PrepareProductsData' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('ClientViewer.Products.PrepareProductsData',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'ClientViewer.Products.QueryProductsByClientId' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('ClientViewer.Products.QueryProductsByClientId',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Score.serchScoreCustomer' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Score.serchScoreCustomer',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Score.searchPunctuationCustomer' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Score.searchPunctuationCustomer',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'ISalesProduct.startProcessInstance' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('ISalesProduct.startProcessInstance',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'AddressTxService.getAddressesbyCustomer' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('AddressTxService.getAddressesbyCustomer',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'BankingServices.Query.Remittance.QueryRemittanceByClientAndBeneficiary' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('BankingServices.Query.Remittance.QueryRemittanceByClientAndBeneficiary',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Comext.Query.ComextQuery.QueryAnnualTransferenceByClient' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Comext.Query.ComextQuery.QueryAnnualTransferenceByClient',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.getDtoSectionById' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.getDtoSectionById',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.insertDtoSection' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.insertDtoSection',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.updateDtoSection' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.updateDtoSection',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.deleteDtoSection' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.deleteDtoSection',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.getPropertiesByDto' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.getPropertiesByDto',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.getPropertiesById' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.getPropertiesById',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.insertPropertiesSection' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.insertPropertiesSection',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.updatePropertiesSection' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.updatePropertiesSection',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.deletePropertiesSection' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.deletePropertiesSection',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.getProductAdministratorDefaultByIdProduct' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.getProductAdministratorDefaultByIdProduct',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.getAllDtos' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.getAllDtos',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.deleteManagementContentSectionById' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.deleteManagementContentSectionById',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.deleteManagementContentSectionRole' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.deleteManagementContentSectionRole',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.getAllManagementContentSectionRole' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.getAllManagementContentSectionRole',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.GetAllManagementContentSectionVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.GetAllManagementContentSectionVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.GetAllProductAdministratorDefaultVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.GetAllProductAdministratorDefaultVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.GetManagementContentSectionRoleByRoleVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.GetManagementContentSectionRoleByRoleVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.GetManagementContentSectionRoleBySectionVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.GetManagementContentSectionRoleBySectionVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.insertManagementContentSection' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.insertManagementContentSection',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.insertManagementContentSectionRole' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.insertManagementContentSectionRole',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.updateManagementContentSectionById' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.updateManagementContentSectionById',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientViewer.Administration.GetAllManagementContentSectionVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientViewer.Administration.GetAllManagementContentSectionVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientViewer.Administration.GetAllRoleConfigurationVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientViewer.Administration.GetAllRoleConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.GetAllRoleConfigurationVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.GetAllRoleConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'ClientViewer.Administration.GetAllRoleConfigurationVCC' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('ClientViewer.Administration.GetAllRoleConfigurationVCC',@w_id_rol,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'clientviewer.Administration.GetAllManagementContentSectionRole' and ts_rol = @w_id_rol)
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('clientviewer.Administration.GetAllManagementContentSectionRole',@w_id_rol,1,'R',0,getdate(),'V',getdate())

IF EXISTS (SELECT 1 FROM ad_servicio_autorizado WHERE ts_servicio = 'clientviewer.CustomerService.queryClient')
BEGIN
	DELETE FROM cobis..ad_servicio_autorizado WHERE ts_servicio='clientviewer.CustomerService.queryClient'
END

IF EXISTS (SELECT 1 FROM ad_servicio_autorizado WHERE ts_servicio = 'clientviewer.CustomerService.queryGroupDetail')
BEGIN
	DELETE FROM cobis..ad_servicio_autorizado WHERE ts_servicio='clientviewer.CustomerService.queryGroupDetail'
END

IF EXISTS (SELECT 1 FROM ad_servicio_autorizado WHERE ts_servicio = 'clientviewer.Administration.getAllProductAdministratorDefaultDinamicByType')
BEGIN
	DELETE ad_servicio_autorizado  WHERE ts_servicio = 'clientviewer.Administration.getAllProductAdministratorDefaultDinamicByType'
END

IF EXISTS (SELECT 1 FROM ad_servicio_autorizado WHERE ts_servicio = 'clientviewer.Administration.insertDefaultProductAdministrator')
BEGIN
	DELETE ad_servicio_autorizado  WHERE ts_servicio = 'clientviewer.Administration.insertDefaultProductAdministrator'
END

IF EXISTS (SELECT 1 FROM ad_servicio_autorizado WHERE ts_servicio = 'clientviewer.Administration.updateDefaultProductAdministratorById')
BEGIN
	DELETE ad_servicio_autorizado  WHERE ts_servicio = 'clientviewer.Administration.updateDefaultProductAdministratorById'
END

IF EXISTS (SELECT 1 FROM ad_servicio_autorizado WHERE ts_servicio = 'clientviewer.Administration.deleteDefaultProductAdministratorById')
BEGIN
	DELETE ad_servicio_autorizado  WHERE ts_servicio = 'clientviewer.Administration.deleteDefaultProductAdministratorById'
END

IF EXISTS (SELECT 1 FROM ad_servicio_autorizado WHERE ts_servicio = 'clientviewer.Administration.getProductAdministratorDefaultDinamicByParent')
BEGIN
	DELETE ad_servicio_autorizado  WHERE ts_servicio = 'clientviewer.Administration.getProductAdministratorDefaultDinamicByParent'
END

IF EXISTS (SELECT 1 FROM ad_servicio_autorizado WHERE ts_servicio = 'clientviewer.Administration.getAllDtosByParent')
BEGIN
	DELETE ad_servicio_autorizado  WHERE ts_servicio = 'clientviewer.Administration.getAllDtosByParent'
END

if exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.CustomerService.queryClient')
begin
	delete cts_serv_catalog  WHERE csc_service_id = 'clientviewer.CustomerService.queryClient'
end

if exists (select 1 from cts_serv_catalog where csc_service_id = 'clientviewer.CustomerService.queryGroupDetail')
begin
	delete cts_serv_catalog  WHERE csc_service_id = 'clientviewer.CustomerService.queryGroupDetail'
end

IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_service_id = 'clientviewer.Administration.getAllProductAdministratorDefaultDinamicByType')
BEGIN
	DELETE cts_serv_catalog  WHERE csc_service_id = 'clientviewer.Administration.getAllProductAdministratorDefaultDinamicByType'
END

IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_service_id = 'clientviewer.Administration.insertDefaultProductAdministrator')
BEGIN
	DELETE cts_serv_catalog  WHERE csc_service_id = 'clientviewer.Administration.insertDefaultProductAdministrator'
END

IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_service_id = 'clientviewer.Administration.updateDefaultProductAdministratorById')
BEGIN
	DELETE cts_serv_catalog  WHERE csc_service_id = 'clientviewer.Administration.updateDefaultProductAdministratorById'
END

IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_service_id = 'clientviewer.Administration.deleteDefaultProductAdministratorById')
BEGIN
	DELETE cts_serv_catalog  WHERE csc_service_id = 'clientviewer.Administration.deleteDefaultProductAdministratorById'
END

IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_service_id = 'clientviewer.Administration.getProductAdministratorDefaultDinamicByParent')
BEGIN
	DELETE cts_serv_catalog  WHERE csc_service_id = 'clientviewer.Administration.getProductAdministratorDefaultDinamicByParent'
END

IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_service_id = 'clientviewer.Administration.getAllDtosByParent')
BEGIN
	DELETE cts_serv_catalog  WHERE csc_service_id = 'clientviewer.Administration.getAllDtosByParent'
END

insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('clientviewer.CustomerService.queryClient','com.cobiscorp.ecobis.clientviewer.ICustomerService','getCustomer',' ',0,'N')

insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('clientviewer.CustomerService.queryGroupDetail','com.cobiscorp.ecobis.clientviewer.ICustomerService','getGroupDetail',' ',0,'N')

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('clientviewer.Administration.getAllProductAdministratorDefaultDinamicByType', 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', 'getAllProductAdministratorDefaultDinamicByType', '', 0, NULL, NULL, 'N')

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('clientviewer.Administration.insertDefaultProductAdministrator', 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', 'insertDefaultProductAdministrator', '', 0, NULL, NULL, 'N')

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('clientviewer.Administration.updateDefaultProductAdministratorById', 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', 'updateDefaultProductAdministratorById', '', 0, NULL, NULL, 'N')

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('clientviewer.Administration.deleteDefaultProductAdministratorById', 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', 'deleteDefaultProductAdministratorById', '', 0, NULL, NULL, 'N')

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('clientviewer.Administration.getProductAdministratorDefaultDinamicByParent', 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', 'getProductAdministratorDefaultDinamicByParent', '', 0, NULL, NULL, 'N')

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('clientviewer.Administration.getAllDtosByParent', 'com.cobiscorp.ecobis.clientviewer.admin.AdministratorService', 'getAllDtosByParent', '', 0, NULL, NULL, 'N')

INSERT INTO ad_servicio_autorizado(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod) 
VALUES ('clientviewer.CustomerService.queryClient',@w_id_rol,73,'R',0,getdate(),'V',getdate()) 

INSERT INTO ad_servicio_autorizado(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod) 
VALUES ('clientviewer.CustomerService.queryGroupDetail',@w_id_rol,73,'R',0,getdate(),'V',getdate()) 

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('clientviewer.Administration.getAllProductAdministratorDefaultDinamicByType', @w_id_rol, 73, 'R', 0, getdate(), 'V', getdate())

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('clientviewer.Administration.insertDefaultProductAdministrator', @w_id_rol, 73, 'R', 0, getdate(), 'V', getdate())

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('clientviewer.Administration.updateDefaultProductAdministratorById', @w_id_rol, 73, 'R', 0, getdate(), 'V', getdate())

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('clientviewer.Administration.deleteDefaultProductAdministratorById', @w_id_rol, 73, 'R', 0, getdate(), 'V', getdate())

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('clientviewer.Administration.getProductAdministratorDefaultDinamicByParent', @w_id_rol, 73, 'R', 0, getdate(), 'V', getdate())

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('clientviewer.Administration.getAllDtosByParent', @w_id_rol, 73, 'R', 0, getdate(), 'V', getdate())

-- FIENET

IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_service_id = 'InternetBanking.WebApp.Customer.Service.Customer.GetContractInformation')
BEGIN
	DELETE cts_serv_catalog  WHERE csc_service_id = 'InternetBanking.WebApp.Customer.Service.Customer.GetContractInformation'
END


IF EXISTS (SELECT 1 FROM ad_tr_autorizada WHERE ta_transaccion = 1850022 AND ta_rol = @w_id_rol)
BEGIN 
    DELETE FROM ad_tr_autorizada WHERE  ta_transaccion = 1850022 AND ta_rol = @w_id_rol  
END

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
VALUES ('InternetBanking.WebApp.Customer.Service.Customer.GetContractInformation', 'cobiscorp.ecobis.internetbanking.webapp.customer.service.service.ICustomer', 'getContractInformation', '', 1850022, 'Y')

INSERT INTO ad_tr_autorizada ( ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod ) 
		 VALUES ( 18, 'R', 0, 1850022, @w_id_rol, getdate(), 1, 'V', getdate() ) 
go
