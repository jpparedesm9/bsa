/*************************************************** VCC ***************************************************/
use cobis
go

declare @w_id_menu int,@w_moneda tinyint, @w_id_producto int,@w_tipo varchar(20)
select @w_id_menu 	= me_id from cobis..cew_menu where me_name = 'MNU_VCC'
select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura='VCC' --73
select @w_tipo		= 'R'
select @w_moneda   	= 0

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
print '--VCC--'

insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.Administration.DeleteConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                      
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.Administration.DefaultConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                     
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.Administration.GetAllRoleAssociatesVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                     
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.Administration.GetAllRoleConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                  
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.Administration.InsertConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                      
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.Administration.QueryConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                       
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.Administration.UpdateConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                      
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.DeleteParameter',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                            
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.DeleteProductFuncionality',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                  
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.InsertFuncionalityInProduct',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.InsertParameter',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                            
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.InsertParameterValue',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                       
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.QueryFuncionalitiesAttached',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.QueryFuncionalitiesByProduct',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                               
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.QueryParametersAndValues',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                   
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.QueryProducts',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                              
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.UpdateParameter',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                            
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.UpdateParameterValue',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                       
insert into cew_menu_service values(@w_id_menu,'UCSP.BankingProduct.QueryBankingProducts',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                              
insert into cew_menu_service values(@w_id_menu,'UCSP.Check.QueryProtestedChecks',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                       
insert into cew_menu_service values(@w_id_menu,'UCSP.Client.AverageBalanceClient',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                      
insert into cew_menu_service values(@w_id_menu,'UCSP.Client.QueryClient',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                               
insert into cew_menu_service values(@w_id_menu,'UCSP.Client.QueryClientByParameters',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                   
insert into cew_menu_service values(@w_id_menu,'UCSP.Client.QueryClientByParametersNext',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                               
insert into cew_menu_service values(@w_id_menu,'UCSP.Client.QueryClientDirections',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                     
insert into cew_menu_service values(@w_id_menu,'UCSP.Client.QueryClientRate',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                           
insert into cew_menu_service values(@w_id_menu,'UCSP.Client.QueryClientReferences',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                     
insert into cew_menu_service values(@w_id_menu,'UCSP.Client.QueryClientType',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                           
insert into cew_menu_service values(@w_id_menu,'UCSP.Client.QueryConsolidatedPosition',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                 
insert into cew_menu_service values(@w_id_menu,'UCSP.Client.QueryGroup',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                                
insert into cew_menu_service values(@w_id_menu,'UCSP.Client.QueryGroupDetail',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                          
insert into cew_menu_service values(@w_id_menu,'UCSP.Client.QueryGroupMembers',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                         
insert into cew_menu_service values(@w_id_menu,'UCSP.Client.QueryLegalClient',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                          
insert into cew_menu_service values(@w_id_menu,'UCSP.Client.QueryLegalRelationships',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                   
insert into cew_menu_service values(@w_id_menu,'UCSP.Client.QueryPartners',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                             
insert into cew_menu_service values(@w_id_menu,'UCSP.HSBC.Client.QueryClient',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                          
insert into cew_menu_service values(@w_id_menu,'UCSP.HSBC.Client.QueryGroupDetail',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                     
insert into cew_menu_service values(@w_id_menu,'UCSP.HSBC.Client.QueryLegalClient',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                     
insert into cew_menu_service values(@w_id_menu,'UCSP.HSBC.Integration.QueryAdvertising',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                
insert into cew_menu_service values(@w_id_menu,'UCSP.HSBC.MaxDebt.QueryMaxDebt',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                        
insert into cew_menu_service values(@w_id_menu,'UCSP.Products.PrepareProductsData',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                     
insert into cew_menu_service values(@w_id_menu,'UCSP.Products.QueryProductsByClientId',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                 
insert into cew_menu_service values(@w_id_menu,'UCSP.Sales.QueryProductInformation',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                    
insert into cew_menu_service values(@w_id_menu,'UCSP.View.QueryAuthorizedView',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                         
insert into cew_menu_service values(@w_id_menu,'CustomerService.getCustomerType',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                       
insert into cew_menu_service values(@w_id_menu,'CustomerService.getCustomersByParameters',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                              
insert into cew_menu_service values(@w_id_menu,'CustomerService.checkColumnExist',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'CustomerService.getCustomersByAutoCompleteText',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'CustomerService.getGroupDetail',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                        
insert into cew_menu_service values(@w_id_menu,'CustomerService.getGroupMembers',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                       
insert into cew_menu_service values(@w_id_menu,'CustomerService.getQueryClientAddress',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                 
insert into cew_menu_service values(@w_id_menu,'CustomerService.getQueryLegalClient',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                   
insert into cew_menu_service values(@w_id_menu,'CustomerService.queryClient',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                           
insert into cew_menu_service values(@w_id_menu,'CustomerService.queryClientRate',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                       
insert into cew_menu_service values(@w_id_menu,'CustomerService.queryGroup',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'CustomerService.getGroupsByParameters',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                            
insert into cew_menu_service values(@w_id_menu,'clientviewer.CustomerService.queryClient',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                              
insert into cew_menu_service values(@w_id_menu,'clientviewer.CustomerService.queryGroupDetail',@w_id_producto,@w_tipo,@w_moneda)   
insert into cew_menu_service values(@w_id_menu,'ClientViewer.Administration.DeleteConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                    
insert into cew_menu_service values(@w_id_menu,'ClientViewer.Administration.GetAllRoleConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                
insert into cew_menu_service values(@w_id_menu,'ClientViewer.Administration.InsertConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                    
insert into cew_menu_service values(@w_id_menu,'ClientViewer.Administration.QueryConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                     
insert into cew_menu_service values(@w_id_menu,'ClientViewer.Administration.UpdateConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                    
insert into cew_menu_service values(@w_id_menu,'ClientViewer.Client.QueryClient',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                       
insert into cew_menu_service values(@w_id_menu,'ClientViewer.Client.QueryClientByParameters',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                           
insert into cew_menu_service values(@w_id_menu,'ClientViewer.Client.QueryClientDirections',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                             
insert into cew_menu_service values(@w_id_menu,'ClientViewer.Client.QueryClientRate',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                   
insert into cew_menu_service values(@w_id_menu,'ClientViewer.Client.QueryClientType',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                   
insert into cew_menu_service values(@w_id_menu,'ClientViewer.Client.QueryConsolidatedPosition',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                         
insert into cew_menu_service values(@w_id_menu,'ClientViewer.Client.QueryGroup',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                        
insert into cew_menu_service values(@w_id_menu,'ClientViewer.Client.QueryGroupDetail',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                  
insert into cew_menu_service values(@w_id_menu,'ClientViewer.Client.QueryGroupMembers',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                 
insert into cew_menu_service values(@w_id_menu,'ClientViewer.Client.QueryLegalClient',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                  
insert into cew_menu_service values(@w_id_menu,'ClientViewer.MaxDebt.QueryMaxDebt',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                     
insert into cew_menu_service values(@w_id_menu,'ClientViewer.Products.PrepareProductsData',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                             
insert into cew_menu_service values(@w_id_menu,'ClientViewer.Products.PrepareProductsDataHistory',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                      
insert into cew_menu_service values(@w_id_menu,'ClientViewer.Products.QueryHistoryProductsByClientId',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                  
insert into cew_menu_service values(@w_id_menu,'ClientViewer.Products.QueryProductsByClientId',@w_id_producto,@w_tipo,@w_moneda)   
insert into cew_menu_service values(@w_id_menu,'ISalesProduct.startProcessInstance',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                    
insert into cew_menu_service values(@w_id_menu,'AddressTxService.getAddressesbyCustomer',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                               
insert into cew_menu_service values(@w_id_menu,'BankingServices.Query.Remittance.QueryRemittanceByClientAndBeneficiary',@w_id_producto,@w_tipo,@w_moneda)                                                                                                
insert into cew_menu_service values(@w_id_menu,'Comext.Query.ComextQuery.QueryAnnualTransferenceByClient',@w_id_producto,@w_tipo,@w_moneda)                                                                                                              
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.DeleteConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                    
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.GetAllManagementContentSectionRole',@w_id_producto,@w_tipo,@w_moneda)                                                                                                        
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.GetAllManagementContentSectionVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                         
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.GetAllProductAdministratorDefaultVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                      
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.GetAllRoleConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.GetManagementContentSectionRoleByRoleVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                  
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.GetManagementContentSectionRoleBySectionVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                               
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.InsertConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                    
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.QueryConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                     
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.UpdateConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                    
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.deleteDefaultProductAdministratorById',@w_id_producto,@w_tipo,@w_moneda)                                                                                                     
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.deleteDtoSection',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                          
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.deleteManagementContentSectionById',@w_id_producto,@w_tipo,@w_moneda)                                                                                                        
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.deleteManagementContentSectionRole',@w_id_producto,@w_tipo,@w_moneda)                                                                                                        
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.deletePropertiesSection',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                   
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.getDtoById',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.getAllDtos',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.getAllDtosByParent',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                        
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.getAllManagementContentSectionRole',@w_id_producto,@w_tipo,@w_moneda)                                                                                                        
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.getAllProductAdministratorDefaultDinamicByType',@w_id_producto,@w_tipo,@w_moneda)                                                                                            
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.getDtoSectionById',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                         
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.getProductAdministratorDefaultByIdProduct',@w_id_producto,@w_tipo,@w_moneda)                                                                                                 
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.getProductAdministratorDefaultDinamicByParent',@w_id_producto,@w_tipo,@w_moneda)                                                                                             
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.getPropertiesByDto',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                        
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.getPropertiesById',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                         
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.insertDefaultProductAdministrator',@w_id_producto,@w_tipo,@w_moneda)                                                                                                         
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.insertDtoSection',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.insertManagementContentSection',@w_id_producto,@w_tipo,@w_moneda)                                                                                                            
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.insertManagementContentSectionRole',@w_id_producto,@w_tipo,@w_moneda)                                                                                                        
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.insertPropertiesSection',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                   
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.updateDefaultProductAdministratorById',@w_id_producto,@w_tipo,@w_moneda)                                                                                                     
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.updateDtoSection',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                          
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.updateManagementContentSectionById',@w_id_producto,@w_tipo,@w_moneda)                                                                                                        
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.updatePropertiesSection',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'clientviewer.Rate.getAsfiByClientId',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                   
insert into cew_menu_service values(@w_id_menu,'clientviewer.Rate.getInfoCredByClientId',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                               
insert into cew_menu_service values(@w_id_menu,'clientviewer.Rate.getPortfolioRateByClientId',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                          
insert into cew_menu_service values(@w_id_menu,'clientviewer.Rate.getRateByClientId',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                   
insert into cew_menu_service values(@w_id_menu,'clientviewer.Score.searchPunctuationCustomer',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                          
insert into cew_menu_service values(@w_id_menu,'clientviewer.Score.serchScoreCustomer',@w_id_producto,@w_tipo,@w_moneda)      
insert into cew_menu_service values(@w_id_menu,'InternetBanking.WebApp.Customer.Service.Customer.GetContractInformation',@w_id_producto,@w_tipo,@w_moneda)                                                                                               
insert into cew_menu_service values(@w_id_menu,'ContactTxService.getContactsbyCustomer',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                
insert into cew_menu_service values(@w_id_menu,'PhoneTxService.getPhonebyCustomerAndAddress',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.RuleByRoleQuery.QueryExceptionByClient',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'FPM.Operation.GetBankinProductsApprovedStructure',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                             
insert into cew_menu_service values(@w_id_menu,'FPM.Operation.GetBankinProductsStructure',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                     
insert into cew_menu_service values(@w_id_menu,'FPM.Operation.GetBankinProductsRulesFiltered',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                 
insert into cew_menu_service values(@w_id_menu,'FPM.Operation.GetBankingProductBasicInformationById',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                          
insert into cew_menu_service values(@w_id_menu,'FPM.Operation.GetBankingProductApprovedInformationById',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                       
insert into cew_menu_service values(@w_id_menu,'FPM.Catalogs.GetAllCurrencies',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                                
insert into cew_menu_service values(@w_id_menu,'clientViewer.Administration.GetAllRoleConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                       
insert into cew_menu_service values(@w_id_menu,'Loan.ReadOperationGuarantees.GetOperationGuarantees',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                          
insert into cew_menu_service values(@w_id_menu,'ActivityTxService.getEconomicActivity',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                        
insert into cew_menu_service values(@w_id_menu,'ActivityTxService.getMainActivity',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                            
insert into cew_menu_service values(@w_id_menu,'BusinessSegmentTxService.getBusinessSegment',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                  
insert into cew_menu_service values(@w_id_menu,'ClientService.createClient',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                                   
insert into cew_menu_service values(@w_id_menu,'CustomerTxService.getCustomerAllData',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                         
insert into cew_menu_service values(@w_id_menu,'ProductDetailService.createProductDetail',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                     
insert into cew_menu_service values(@w_id_menu,'NationalityService.searchNationality',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                         
insert into cew_menu_service values(@w_id_menu,'POBoxTxService.getAllPOBOX',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'QuickCreateTxService.executeQuickCreate',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                      
insert into cew_menu_service values(@w_id_menu,'HTM.API.HumanTask.GetSupervisorTaskList',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                      
insert into cew_menu_service values(@w_id_menu,'CEW.Preferences.getUserPreferences',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                           
insert into cew_menu_service values(@w_id_menu,'CEW.Official.GetOfficialInfo',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                                 
insert into cew_menu_service values(@w_id_menu,'CEW.Favorites.getUserFavorites',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                               
insert into cew_menu_service values(@w_id_menu,'CEW.ContainerInfo.getContainerInfo',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                           
insert into cew_menu_service values(@w_id_menu,'HTM.API.HumanTask.CreateProcessInstance',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                      
insert into cew_menu_service values(@w_id_menu,'HTM.API.HumanTask.GetTaskListCriteria',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                        
insert into cew_menu_service values(@w_id_menu,'HTM.API.HumanTask.ClaimTask',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                                  
insert into cew_menu_service values(@w_id_menu,'Inbox.CommentsManager.GetComments',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                            
insert into cew_menu_service values(@w_id_menu,'Workflow.Admin.WorkflowAdmin.QueryAllStepPolicy',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                              
insert into cew_menu_service values(@w_id_menu,'Workflow.Admin.WorkflowAdmin.UpdateInstanceProcess',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Bpl.Rules.Engine.Query.RuleQueryManager.FindRuleActiveByAcronym',@w_id_producto,@w_tipo,@w_moneda)                                                                                                              
insert into cew_menu_service values(@w_id_menu,'Bpl.Rules.Engine.RuleManager.Generate',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                        
insert into cew_menu_service values(@w_id_menu,'Inbox.CommentsManager.GetRecords',@w_id_producto,@w_tipo,@w_moneda)     
insert into cew_menu_service values(@w_id_menu,'Workflow.Admin.WorkflowAdmin.QueryHierarchyLevelProcessInstance',@w_id_producto,@w_tipo,@w_moneda)                                                                                                              
insert into cew_menu_service values(@w_id_menu,'Workflow.Admin.WorkflowAdmin.QueryRuleProcessHistory',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                         
insert into cew_menu_service values(@w_id_menu,'Workflow.Admin.WorkflowAdmin.QueryActivitiesRequirements',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                     
insert into cew_menu_service values(@w_id_menu,'FPM.Operation.FindAllAvailableBankingProducts',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                
insert into cew_menu_service values(@w_id_menu,'Workflow.Admin.WorkflowAdmin.QueryExceptionApprovedByStep',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                    
insert into cew_menu_service values(@w_id_menu,'Businessprocess.CRM.CRMServices.CreateClaimRequest',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                           
insert into cew_menu_service values(@w_id_menu,'Businessprocess.CRM.CRMServices.CreateClaimSettlement',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                        
insert into cew_menu_service values(@w_id_menu,'Businessprocess.CRM.CRMServices.DeleteClaimRequest',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                           
insert into cew_menu_service values(@w_id_menu,'Businessprocess.CRM.CRMServices.DeleteClaimSettlement',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                        
insert into cew_menu_service values(@w_id_menu,'Businessprocess.CRM.CRMServices.ReadCategoryClaim',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                            
insert into cew_menu_service values(@w_id_menu,'Businessprocess.CRM.CRMServices.ReadClaimRequest',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                             
insert into cew_menu_service values(@w_id_menu,'Businessprocess.CRM.CRMServices.ReadClaimSettlement',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.CRM.CRMServices.ReadSubcategoryClaim',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                         
insert into cew_menu_service values(@w_id_menu,'Businessprocess.CRM.CRMServices.SearchCategoryClaim',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                          
insert into cew_menu_service values(@w_id_menu,'Businessprocess.CRM.CRMServices.SearchClaimDuplicates',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                        
insert into cew_menu_service values(@w_id_menu,'Businessprocess.CRM.CRMServices.SearchClaimRequest',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                           
insert into cew_menu_service values(@w_id_menu,'Businessprocess.CRM.CRMServices.SearchClaimSettlement',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                        
insert into cew_menu_service values(@w_id_menu,'Businessprocess.CRM.CRMServices.SearchDescriptionSettlement',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                  
insert into cew_menu_service values(@w_id_menu,'Businessprocess.CRM.CRMServices.SearchSubcategoryClaim',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                       
insert into cew_menu_service values(@w_id_menu,'Businessprocess.CRM.CRMServices.UpdateClaimRequest',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                           
insert into cew_menu_service values(@w_id_menu,'Businessprocess.CRM.CRMServices.UpdateClaimSettlement',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                        
insert into cew_menu_service values(@w_id_menu,'Businessprocess.CRM.CRMServices.AddDaysSkipHolidays',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                          
insert into cew_menu_service values(@w_id_menu,'Workflow.Admin.WorkflowAdmin.QueryRuleInstanceProcess',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                        
insert into cew_menu_service values(@w_id_menu,'Workflow.Admin.WorkflowAdmin.QueryRuleHistory',@w_id_producto,@w_tipo,@w_moneda)

go

use cobis
go

declare @w_id_menu int,@w_moneda tinyint, @w_id_producto int,@w_tipo varchar(20)
select @w_id_menu 	= me_id from cobis..cew_menu where me_name = 'MNU_SECTION_ADMINISTRATOR'
select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura='VCC' --69
select @w_tipo		= 'R'
select @w_moneda   	= 0

print '--Administrator Section--'

insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.Administration.DefaultConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                       
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.Administration.DeleteConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                        
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.Administration.GetAllRoleAssociatesVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                       
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.Administration.GetAllRoleConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                    
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.Administration.InsertConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                        
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.Administration.QueryConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                         
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.Administration.UpdateConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                        
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.DeleteParameter',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                              
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.DeleteProductFuncionality',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                    
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.InsertFuncionalityInProduct',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                  
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.InsertParameter',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                              
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.InsertParameterValue',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                         
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.QueryFuncionalitiesAttached',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                  
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.QueryFuncionalitiesByProduct',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                 
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.QueryParametersAndValues',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                     
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.QueryProducts',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                                
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.UpdateParameter',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                              
insert into cew_menu_service values(@w_id_menu,'UCSP.Admin.UpdateParameterValue',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                         
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.GetAllManagementContentSectionRole',@w_id_producto,@w_tipo,@w_moneda)                                                                                                          
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.GetAllManagementContentSectionVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                           
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.GetAllProductAdministratorDefaultVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                        
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.GetAllRoleConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                  
insert into cew_menu_service values(@w_id_menu,'ClientViewer.Administration.GetAllRoleConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                  
insert into cew_menu_service values(@w_id_menu,'clientViewer.Administration.GetAllRoleConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                  
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.GetManagementContentSectionRoleByRoleVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                    
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.GetManagementContentSectionRoleBySectionVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                 
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.InsertConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                      
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.QueryConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                       
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.UpdateConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                      
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.deleteDefaultProductAdministratorById',@w_id_producto,@w_tipo,@w_moneda)                                                                                                       
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.deleteDtoSection',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                            
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.deleteManagementContentSectionById',@w_id_producto,@w_tipo,@w_moneda)                                                                                                          
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.deleteManagementContentSectionRole',@w_id_producto,@w_tipo,@w_moneda)                                                                                                          
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.deletePropertiesSection',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                     
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.getAllDtos',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                  
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.getAllDtosByParent',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                          
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.getAllProductAdministratorDefaultDinamicByType',@w_id_producto,@w_tipo,@w_moneda)                                                                                              
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.getDtoById',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                  
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.getDtoSectionById',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                           
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.getProductAdministratorDefaultByIdProduct',@w_id_producto,@w_tipo,@w_moneda)                                                                                                   
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.getProductAdministratorDefaultDinamicByParent',@w_id_producto,@w_tipo,@w_moneda)                                                                                               
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.getPropertiesByDto',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                          
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.getPropertiesById',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                           
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.insertDefaultProductAdministrator',@w_id_producto,@w_tipo,@w_moneda)                                                                                                           
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.insertDtoSection',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                            
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.insertManagementContentSection',@w_id_producto,@w_tipo,@w_moneda)                                                                                                              
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.insertManagementContentSectionRole',@w_id_producto,@w_tipo,@w_moneda)                                                                                                          
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.insertPropertiesSection',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                     
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.updateDefaultProductAdministratorById',@w_id_producto,@w_tipo,@w_moneda)                                                                                                       
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.updateDtoSection',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                            
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.updateManagementContentSectionById',@w_id_producto,@w_tipo,@w_moneda)                                                                                                          
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.updatePropertiesSection',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                     
insert into cew_menu_service values(@w_id_menu,'ClientViewer.Administration.DeleteConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                      
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.DeleteConfigurationVCC',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                      
insert into cew_menu_service values(@w_id_menu,'CEW.Preferences.getUserPreferences',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                      
insert into cew_menu_service values(@w_id_menu,'CEW.Official.GetOfficialInfo',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                            
insert into cew_menu_service values(@w_id_menu,'CEW.Favorites.getUserFavorites',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                          
insert into cew_menu_service values(@w_id_menu,'CEW.ContainerInfo.getContainerInfo',@w_id_producto,@w_tipo,@w_moneda)

go


use cobis
go

declare @w_id_menu int,@w_moneda tinyint, @w_id_producto int,@w_tipo varchar(20)
select @w_id_menu 	= me_id from cobis..cew_menu where me_name = 'MNU_DTOS_AND_PROPERTIES'
select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura='VCC' --69
select @w_tipo		= 'R'
select @w_moneda   	= 0

print '--DTO´s y Propiedades--'

insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.getAllDtos',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                  
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.deleteDtoSection',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                            
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.insertDtoSection',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                            
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.updateDtoSection',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                            
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.insertPropertiesSection',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                     
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.updatePropertiesSection',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                     
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.deletePropertiesSection',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                     
insert into cew_menu_service values(@w_id_menu,'clientviewer.Administration.getPropertiesByDto',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                          
insert into cew_menu_service values(@w_id_menu,'clientViewer.Products.PrepareProductsDataHistory',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                        
insert into cew_menu_service values(@w_id_menu,'clientViewer.Products.QueryHistoryProductsByClientId',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                    
insert into cew_menu_service values(@w_id_menu,'CEW.Preferences.getUserPreferences',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                      
insert into cew_menu_service values(@w_id_menu,'CEW.Official.GetOfficialInfo',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                            
insert into cew_menu_service values(@w_id_menu,'CEW.Favorites.getUserFavorites',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                          
insert into cew_menu_service values(@w_id_menu,'CEW.ContainerInfo.getContainerInfo',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                      

go

/********************************************************************************************************************************************************/
/*************************************************************Arrancar flujos desde la Vista Consolidada*************************************************/
/********************************************************************************************************************************************************/
use cobis
go

declare @w_id_menu int,@w_moneda tinyint, @w_id_producto int,@w_tipo varchar(20)
select @w_id_menu 	= me_id from cobis..cew_menu where me_name = 'MNU_VCC'
select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura='VCC' --73
select @w_tipo		='R'
select @w_moneda   	= 0

--CREDITO
print '<<<<<<<<<<<<BusinessProcess Servicios para VCC>>>>>>>>>>>>'
print 'BusinessProcess Ingreso de datos'

insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.DebtorsManagment.HelpDebtor',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.DebtorsManagment.QueryDebtor',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.ApplicationQuery.ReadApplication',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.LineOpCurrency.GetCreditLineDataByCustomer',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.DebtorsManagment.CreateDebtor',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.ApplicationManagment.CreateApplication',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.ApplicationManagment.UpdateApplication',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.RenewManagement.SearchRenewOperByOperation',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.RenewManagement.SearchRenewLoanData',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.RenewManagement.AddRenewData',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.RenewManagement.DeleteRenewData',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.RenewManagement.SearchBalancebyOperation',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.RenewManagement.SearchRenewData',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.RenewManagement.UpdateRenewData',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'BusinessProcess.LoanRequest.CreditOperation.GetProcessedNumber',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Busin.Service.GetCatalogByStoredProcedure',@w_id_producto,@w_tipo,@w_moneda)
--ADMIN

print 'BusinessProcess Ingreso de datos ADMIN para VCC'
insert into cew_menu_service values(@w_id_menu,'SystemConfiguration.OfficeManagement.ReadOffice',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'SystemConfiguration.CatalogManagement.Search',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'SystemConfiguration.OfficeManagement.SearchCity',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'SystemConfiguration.OfficerManagement.SearchOfficer',@w_id_producto,@w_tipo,@w_moneda)

--APF
print 'BusinessProcess Ingreso de datos APF'
insert into cew_menu_service values(@w_id_menu,'FPM.Operation.FindGeneralParameterValuesDescription',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'FPM.Operation.GetBankinProductsLatestByModule',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'FPM.Operation.GetBankingProductSector',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'FPM.Portfolio.Administration.GetEconomicDestinationHistoricalLog',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'FPM.Operation.GetLatestHistorical',@w_id_producto,@w_tipo,@w_moneda)


/*****************************************************************************************************************************************/
/************************************************Unidad Funcional Verificación de Datos***************************************************/
/*****************************************************************************************************************************************/

--ADMIN 
print 'BusinessProcess Verificacion de datos ADMIN'
insert into cew_menu_service values(@w_id_menu,'SystemConfiguration.ParameterManagement.ParameterManagementValueSearch',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'SystemConfiguration.ParameterManagement.ProcessDate',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'SystemConfiguration.ParameterManagement.ParameterManagement',@w_id_producto,@w_tipo,@w_moneda)
	
--CLIENTES
print 'BusinessProcess Verificacion de datos CLIENTES'
insert into cew_menu_service values(@w_id_menu,'CustomerDataManagementService.CustomerManagement.ReadAddressCode',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'CustomerDataManagementService.CustomerManagement.ReadAddress',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'CustomerDataManagementService.CustomerManagement.ReadActivityByCustomer',@w_id_producto,@w_tipo,@w_moneda)

/*******************************************************************************************************************************************/
/************************************************Unidad Funcional Asociación de Garantías***************************************************/
/*******************************************************************************************************************************************/

--CREDITO
select @w_id_menu 	= me_id from cobis..cew_menu where me_name = 'MNU_VCC'
select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura='VCC' --73
print 'BusinessProcess Asociasion de Garantias CREDITO'
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.CollateralApplicationQuery.SearchCollateralApplication',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.GuaranteesFundManagment.ValidationGuaranteeProrated',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.LineOpCurrency.GetCreditLineDataByBank',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.CollateralApplicationManagement.CreateCollateralApplication',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.RenewManagement.SearchRenewOperData',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.CollateralApplicationManagement.DeleteCollateralApplication',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Collateral.SearchDeposit.SearchDeposit',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Collateral.SearchDeposit.QueryDeposit',@w_id_producto,@w_tipo,@w_moneda)
	
--CARTERA
print 'BusinessProcess Asociasion de Garantias CARTERA'
insert into cew_menu_service values(@w_id_menu,'Loan.SearchLoanItems.SearchLoanItemsSearch',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Loan.LoansQueries.ReadLoanGeneralDataTmp',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'ICommitPaymentPlan.commitPaymentPlan',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Collateral.CollateralQuery.SearchCollateral',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Collateral.CollateralQuery.SearchCollateralType',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Collateral.TypeGuarantee.GetQueryTypeGuaranteeData',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Collateral.TypeGuarantee.GetCoverageCustody',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Collateral.CollateralMaintenance.UpdateCollateral',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Collateral.CollateralMaintenance.InsertCollateral',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Collateral.CollateralMaintenance.InsertCustomerCollateral',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Loan.SearchLoanItems.ReadValueApply',@w_id_producto,@w_tipo,@w_moneda)  
insert into cew_menu_service values(@w_id_menu,'Loan.SearchLoanItems.InsertItem',@w_id_producto,@w_tipo,@w_moneda)   
insert into cew_menu_service values(@w_id_menu,'Loan.SearchLoanItems.DeleteItems',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Collateral.CollateralQuery.ReadCollateral',@w_id_producto,@w_tipo,@w_moneda)   
insert into cew_menu_service values(@w_id_menu,'Collateral.CollateralQuery.ReadPolicy',@w_id_producto,@w_tipo,@w_moneda)
 
/*******************************************************************************************************************************************/
/*************************************************************Unidad Funcional Aprobación***************************************************/
/*******************************************************************************************************************************************/

print 'BusinessProcess Aprobacion WORKFLOW'
--WORKFLOW
insert into cew_menu_service values(@w_id_menu,'HTM.API.HumanTask.GetApprovedExceptionsByProcessInstanceOrCode',@w_id_producto,@w_tipo,@w_moneda)
	
--CREDITO
print 'BusinessProcess Aprobacion CREDITO'
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.RuleByRoleQuery.readRuleByRole',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.RuleByRoleQuery.createRuleByRole',@w_id_producto,@w_tipo,@w_moneda)

/********************************************************************************************************************************************************/
/*************************************************************Unidad Funcional Impresión de documentos***************************************************/
/********************************************************************************************************************************************************/

--CREDITO
print 'BusinessProcess Impresion de documentos CREDITO '
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.DocumentsApplicationQuery.SearchDocumentsByType',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.DocumentsApplicationManagment.SearchDocumentsApplication',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.DocumentsApplicationManagment.CreateDocumentsApplication',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'CustomerDataManagementService.CustomerManagement.ReadReference',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.DataTypeOperationQuery.SearchTypeOperation',@w_id_producto,@w_tipo,@w_moneda)
	
/********************************************************************************************************************************************************/
/*************************************************************Unidad Funcional Formas de Desembolso******************************************************/
/********************************************************************************************************************************************************/


--CARTERA
select @w_id_menu 	= me_id from cobis..cew_menu where me_name = 'MNU_VCC'
select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura='VCC' --73
print 'BusinessProcess Impresion de documentos CARTERA '
insert into cew_menu_service values(@w_id_menu,'Loan.LoanMaintenance.DeleteTmpTables',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Loan.ReadDisbursementForm.ReadDisbursementFormSearch',@w_id_producto,@w_tipo,@w_moneda)	
insert into cew_menu_service values(@w_id_menu,'Loan.LoanMaintenance.removeDisbursementForm',@w_id_producto,@w_tipo,@w_moneda)	
insert into cew_menu_service values(@w_id_menu,'Loan.LoansQueries.SearchLoanItemsTmp',@w_id_producto,@w_tipo,@w_moneda)	
insert into cew_menu_service values(@w_id_menu,'Loan.SearchLoanItems.SearchValueReferenceByValueApply',@w_id_producto,@w_tipo,@w_moneda)	
insert into cew_menu_service values(@w_id_menu,'Loan.SearchLoanItems.GetLoanItemsAllDetails',@w_id_producto,@w_tipo,@w_moneda)	
insert into cew_menu_service values(@w_id_menu,'Loan.SearchLoanItems.GetLoanItemsDetails',@w_id_producto,@w_tipo,@w_moneda)   
insert into cew_menu_service values(@w_id_menu,'Loan.SearchLoanItems.UpdateLoanItems',@w_id_producto,@w_tipo,@w_moneda)   
 insert into cew_menu_service values(@w_id_menu,'Loan.SearchLoanItems.CreateLoanItems',@w_id_producto,@w_tipo,@w_moneda)   
insert into cew_menu_service values(@w_id_menu,'Loan.LoanMaintenance.CreateDisbursementForm',@w_id_producto,@w_tipo,@w_moneda)	
insert into cew_menu_service values(@w_id_menu,'Loan.LoanMaintenance.ManualTable',@w_id_producto,@w_tipo,@w_moneda)
	
--CREDITO
print 'BusinessProcess Impresion de documentos CREDITO '
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.LineOpCurrency.GetQuoteBusin',@w_id_producto,@w_tipo,@w_moneda)
	
--CLIENTES
insert into cew_menu_service values(@w_id_menu,'Account.SearchAccount.SearchAccountRequest',@w_id_producto,@w_tipo,@w_moneda)
	
/**************************************************************************************************************************************************************/
/*************************************************************Unidad Funcional Desembolso Credito Cartera******************************************************/
/**************************************************************************************************************************************************************/

--CARTERA
select @w_id_menu 	= me_id from cobis..cew_menu where me_name = 'MNU_VCC'
select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura='VCC' --73
print 'BusinessProcesss Desembolso Credito Cartera CARTERA '
insert into cew_menu_service values(@w_id_menu,'Loan.LoansQueries.SearchDisbursmentForm',@w_id_producto,@w_tipo,@w_moneda)
	
/**************************************************************************************************************************************************************/
/*************************************************************Unidad Funcional Operaciones Candidatas de Castigo***********************************************/
/**************************************************************************************************************************************************************/
--CREDITO
print 'BusinessProcesss Operaciones Candidatas de Castigo'
insert into cew_menu_service values(@w_id_menu,'Loan.LoanMaintenance.UpdatePenalizationLoan',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Loan.LoanMaintenance.SearchPenalizationLoan',@w_id_producto,@w_tipo,@w_moneda)

/**************************************************************************************************************************************************************/
/************************************************************Unidad Funcional Solicitud de Castigo - Ingreso de datos******************************************/
/**************************************************************************************************************************************************************/

--CREDITO

print 'BusinessProcesss Solicitud de castigo Ingreso de datos'	   
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.ApplicationQuery.ReadAditionalInformation',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Loan.LoansQueries.ReadCurrentValuesByOperation',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Loan.LoansQueries.GetPenalizationLoan',@w_id_producto,@w_tipo,@w_moneda)   
insert into cew_menu_service values(@w_id_menu,'Loan.LoanGeneralData.ReadLoanGeneralDataSearch',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.PenalizationManagement.UpdatePenalization',@w_id_producto,@w_tipo,@w_moneda)
   
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.PenalizationManagement.InsertPenalization',@w_id_producto,@w_tipo,@w_moneda)
   
/**************************************************************************************************************************************************************/
/************************************************************Unidad Funcional Consolidacion de Solicitudes de Castigo******************************************/
/**************************************************************************************************************************************************************/

--CREDITO
print 'BusinessProcesss Consolidacion solicitudes de castigo CREDITO'
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.PenalizationManagement.QueryConsolidatePenalizationLoan',@w_id_producto,@w_tipo,@w_moneda)   
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.PenalizationManagement.ChangeStateConsolidatePenalizationLoan',@w_id_producto,@w_tipo,@w_moneda)

insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.PenalizationManagement.InsertDetailPenalizationLoanTmp',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.PenalizationManagement.UpdateConsolidatePenalizationLoan',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.PenalizationManagement.InsertConsolidatePenalizationLoan',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Businessprocess.Creditmanagement.PenalizationManagement.GetPenalization',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Loan.Queries.GetStatus',@w_id_producto,@w_tipo,@w_moneda)
  
--Obtener Vinculacion Cliente   
print 'BusinessProcesss Consolidacion solicitudes de castigo VINCULACION CLIENTE'
insert into cew_menu_service values(@w_id_menu,'BusinessProcess.Customers.QueryCustomer.QueryCustomerEntailment',@w_id_producto,@w_tipo,@w_moneda)

  
/**************************************************************************************************************************************************************/
/*******************************************************Unidad Funcional Solicitud de Credito - tabla de Amortizacion******************************************/
/**************************************************************************************************************************************************************/

--CREDITO
print 'BusinessProcesss Tabla de amortizacion'
insert into cew_menu_service values(@w_id_menu,'Account.SearchAccount.SearchAccountByCurrency',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'Loan.LoanMaintenance.UpdateLoanDataTmp',@w_id_producto,@w_tipo,@w_moneda)

go
