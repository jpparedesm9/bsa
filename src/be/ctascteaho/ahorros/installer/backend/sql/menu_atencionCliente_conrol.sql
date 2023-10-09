use cobis
go

set nocount ON
--------------------------------------------------------------------------
--CREACION Resources
---------------------------------------------------------------------------
print 'Registros para: CTA.Resources' 
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'

if not exists(select 1 from an_label where la_label = 'CTA.Resources') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, 'ES_EC', 'CTA.Resources', 'M-CTA') 
end else select @w_la_id = la_id from an_label where la_label = 'CTA.Resources'

if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Resources.Installer') begin                                                                                                                                                                                                                                                                                                                                                                                                                           
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) 
values (@w_mg_id, 'CTA.Resources.Installer', '0.0.0.0', 'http://[servername]/CTA.Resources.Installer/CTA.Resources.Installer.application', 'COBISExplorer')                                                                                                                                                                                                                                                                                                  
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Resources.Installer'
																																																																																																		 
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Resources') begin                                                                                                                                                                                                                                                                                                                                                                                                                                 
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Resources', 'COBISCorp.tCOBIS.CTA.Resources.dll', 0, null)                                                                                                                                                                                                                                                                                                                                                                    
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Resources' 
																																																																																																			  
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                    
go

--------------------------------------------------------------------------
--CREACION SharedLibrary
--------------------------------------------------------------------------
print 'Registros para: CTA.SharedLibrary' 
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'

if not exists(select 1 from an_label where la_label = 'CTA.SharedLibrary')begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, 'ES_EC', 'CTA.SharedLibrary', 'M-CTA') 
end else select @w_la_id = la_id from an_label where la_label = 'CTA.SharedLibrary'

if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.SharedLibrary.Installer') begin                                                                                                                                                                                                                                                                                                                                                                                                                           
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) 
values (@w_mg_id, 'CTA.SharedLibrary.Installer', '4.0.0.0', 'http://[servername]/CTA.SharedLibrary.Installer/CTA.SharedLibrary.Installer.application', 'COBISExplorer')                                                                                                                                                                                                                                                                                                  
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.SharedLibrary.Installer'
                                                                                                                                                                                                                                                                                                                                                                                                                         
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.SharedLibrary') begin                                                                                                                                                                                                                                                                                                                                                                                                                                 
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.SharedLibrary', 'COBISCorp.tCOBIS.CTA.SharedLibrary.dll', 0, null)                                                                                                                                                                                                                                                                                                                                                                    
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.SharedLibrary' 
                                                                                                                                                                                                                                                                                                                                                                                                                              
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                    
go


--------------------------------------------------------------------------
--CREACION CTA.Ahos.AccountingAdmAccounts 
--------------------------------------------------------------------------
print 'Registros para: CTA.Ahos.AccountingAdmAccounts'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'

if not exists(select 1 from an_label where la_label = 'CTA.Ahos.AccountingAdmAccounts')begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, 'ES_EC', 'CTA.Ahos.AccountingAdmAccounts', 'M-CTA') 
end else select @w_la_id = la_id from an_label where la_label = 'CTA.Ahos.AccountingAdmAccounts'

if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.AccAdmAcc.Installer') begin                                                                                                                                                                                                                                                                                                                                                                                                                           
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) 
values (@w_mg_id, 'CTA.Ahos.AccAdmAcc.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.AccAdmAcc.Installer/COBISCorp.tCOBIS.CTA.Ahos.AccAdmAcc.Installer.application', 'COBISExplorer')                                                                                                                                                                                                                                                                                                  
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.AccAdmAcc.Installer'
                                                                                                                                                                                                                                                                                                                                                                                                                         
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.AccountingAdmAccounts') begin                                                                                                                                                                                                                                                                                                                                                                                                                                 
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.AccountingAdmAccounts', 'COBISCorp.tCOBIS.CTA.Ahos.AccountingAdmAccounts.dll', 0, null)                                                                                                                                                                                                                                                                                                                                                                    
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.AccountingAdmAccounts' 
                                                                                                                                                                                                                                                                                                                                                                                                                              
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                    
go


--------------------------------------------------------------------------
--CREACION CTA.Ahos.correspondents 
--------------------------------------------------------------------------
-- Registros para: CTA.Ahos.correspondents 
print 'Registros para: CTA.Ahos.Correspondents'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'

if not exists(select 1 from an_label where la_label = 'CTA.Ahos.Correspondents')begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, 'ES_EC', 'CTA.Ahos.Correspondents', 'M-CTA') 
end else select @w_la_id = la_id from an_label where la_label = 'CTA.Ahos.Correspondents'

if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.Correspondents.Installer') begin                                                                                                                                                                                                                                                                                                                                                                                                                           
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) 
values (@w_mg_id, 'CTA.Ahos.Correspondents.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.Correspondents.Installer/CTA.Ahos.Correspondents.Installer.application', 'COBISExplorer')                                                                                                                                                                                                                                                                                                  
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.Correspondents.Installer'
                                                                                                                                                                                                                                                                                                                                                                                                                         
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.correspondents') begin                                                                                                                                                                                                                                                                                                                                                                                                                                 
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.Correspondents', 'COBISCorp.tCOBIS.CTA.Ahos.Correspondents.dll', 0, null)                                                                                                                                                                                                                                                                                                                                                                    
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.Correspondents' 
                                                                                                                                                                                                                                                                                                                                                                                                                              
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                    
go
	
--------------------------------------------------------------------------
--CREACION CTA.Ahos.ExchangeAdmCenters 
--------------------------------------------------------------------------
-- Registros para: CTA.Ahos.ExchangeAdmCenters 
print 'Registros para: CTA.Ahos.ExchangeAdmCenters'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'

if not exists(select 1 from an_label where la_label = 'CTA.Ahos.ExchangeAdmCenters')begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, 'ES_EC', 'CTA.Ahos.ExchangeAdmCenters', 'M-CTA') 
end else select @w_la_id = la_id from an_label where la_label = 'CTA.Ahos.ExchangeAdmCenters'

if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.ExchangeAdmCenters.Installer') begin                                                                                                                                                                                                                                                                                                                                                                                                                           
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) 
values (@w_mg_id, 'CTA.Ahos.ExchangeAdmCenters.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.ExchangeAdmCenters.Installer/CTA.Ahos.ExchangeAdmCenters.Installer.application', 'COBISExplorer')                                                                                                                                                                                                                                                                                                  
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.ExchangeAdmCenters.Installer'
                                                                                                                                                                                                                                                                                                                                                                                                                         
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.ExchangeAdmCenters') begin                                                                                                                                                                                                                                                                                                                                                                                                                                 
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.ExchangeAdmCenters', 'COBISCorp.tCOBIS.CTA.Ahos.ExchangeAdmCenters.dll', 0, null)                                                                                                                                                                                                                                                                                                                                                                    
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.ExchangeAdmCenters' 
                                                                                                                                                                                                                                                                                                                                                                                                                              
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                    
go
				
--------------------------------------------------------------------------
--CREACION CTA.Ahos.RemittanceProcess 
--------------------------------------------------------------------------
-- Registros para: CTA.Ahos.RemittanceProcess 
print 'Registros para: CTA.Ahos.RemittanceProcess'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'

if not exists(select 1 from an_label where la_label = 'CTA.Ahos.RemittanceProcess')begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, 'ES_EC', 'CTA.Ahos.RemittanceProcess', 'M-CTA') 
end else select @w_la_id = la_id from an_label where la_label = 'CTA.Ahos.RemittanceProcess'

if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.RemittanceProcess.Installer') begin                                                                                                                                                                                                                                                                                                                                                                                                                           
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) 
values (@w_mg_id, 'CTA.Ahos.RemittanceProcess.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.RemittanceProcess.Installer/CTA.Ahos.RemittanceProcess.Installer.application', 'COBISExplorer')                                                                                                                                                                                                                                                                                                  
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.RemittanceProcess.Installer'
                                                                                                                                                                                                                                                                                                                                                                                                                         
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.RemittanceProcess') begin                                                                                                                                                                                                                                                                                                                                                                                                                                 
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.RemittanceProcess', 'COBISCorp.tCOBIS.CTA.Ahos.RemittanceProcess.dll', 0, null)                                                                                                                                                                                                                                                                                                                                                                    
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.RemittanceProcess' 
                                                                                                                                                                                                                                                                                                                                                                                                                              
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                    
go
	
--------------------------------------------------------------------------
--CREACION CTA.Ahos.AccountsAdmCatalogs 
--------------------------------------------------------------------------
-- Registros para: CTA.Ahos.AccountsAdmCatalogs 
print 'Registros para: CTA.Ahos.AccountsAdmCatalogs'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'

if not exists(select 1 from an_label where la_label = 'CTA.Ahos.AccountsAdmCatalogs')begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, 'ES_EC', 'CTA.Ahos.AccountsAdmCatalogs', 'M-CTA') 
end else select @w_la_id = la_id from an_label where la_label = 'CTA.Ahos.AccountsAdmCatalogs'

if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.AccountsAdmCatalogs.Installer') begin                                                                                                                                                                                                                                                                                                                                                                                                                           
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) 
values (@w_mg_id, 'CTA.Ahos.AccountsAdmCatalogs.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.AccountsAdmCatalogs.Installer/COBISCorp.tCOBIS.CTA.Ahos.AccountsAdmCatalogs.Installer.application', 'COBISExplorer')                                                                                                                                                                                                                                                                                                  
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.AccountsAdmCatalogs.Installer'
                                                                                                                                                                                                                                                                                                                                                                                                                         
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.AccountsAdmCatalogs') begin                                                                                                                                                                                                                                                                                                                                                                                                                                 
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.AccountsAdmCatalogs', 'COBISCorp.tCOBIS.CTA.Ahos.AccountsAdmCatalogs.dll', 0, null)                                                                                                                                                                                                                                                                                                                                                                    
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.AccountsAdmCatalogs' 
                                                                                                                                                                                                                                                                                                                                                                                                                              
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                    
go

--------------------------------------------------------------------------
--CREACION CTA.Ahos.QueryMovements 
--------------------------------------------------------------------------
-- Registros para: CTA.Ahos.QueryMovements 
print 'Registros para: CTA.Ahos.QueryMovements'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'

if not exists(select 1 from an_label where la_label = 'CTA.Ahos.QueryMovements')begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, 'ES_EC', 'CTA.Ahos.QueryMovements', 'M-CTA') 
end else select @w_la_id = la_id from an_label where la_label = 'CTA.Ahos.QueryMovements'

if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryMovements.Installer') begin                                                                                                                                                                                                                                                                                                                                                                                                                           
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) 
values (@w_mg_id, 'CTA.Ahos.QueryMovements.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.QueryMovements.Installer/CTA.Ahos.QueryMovements.Installer.application', 'COBISExplorer')                                                                                                                                                                                                                                                                                                  
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryMovements.Installer'
                                                                                                                                                                                                                                                                                                                                                                                                                         
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.QueryMovements') begin                                                                                                                                                                                                                                                                                                                                                                                                                                 
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.QueryMovements', 'COBISCorp.tCOBIS.CTA.Ahos.QueryMovements.dll', 0, null)                                                                                                                                                                                                                                                                                                                                                                    
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.QueryMovements' 
                                                                                                                                                                                                                                                                                                                                                                                                                              
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                    
go

--------------------------------------------------------------------------
--CREACION CTA.Ahos.QueryBackOffice 
--------------------------------------------------------------------------
-- Registros para: CTA.Ahos.QueryBackOffice 
print 'Registros para: CTA.Ahos.QueryBackOffice'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'

if not exists(select 1 from an_label where la_label = 'CTA.Ahos.QueryBackOffice')begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, 'ES_EC', 'CTA.Ahos.QueryBackOffice', 'M-CTA') 
end else select @w_la_id = la_id from an_label where la_label = 'CTA.Ahos.QueryBackOffice'

if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBackOffice.Installer') begin                                                                                                                                                                                                                                                                                                                                                                                                                           
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) 
values (@w_mg_id, 'CTA.Ahos.QueryBackOffice.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.QueryBackOffice.Installer/CTA.Ahos.QueryBackOffice.Installer.application', 'COBISExplorer')                                                                                                                                                                                                                                                                                                  
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBackOffice.Installer'
                                                                                                                                                                                                                                                                                                                                                                                                                         
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.QueryBackOffice') begin                                                                                                                                                                                                                                                                                                                                                                                                                                 
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.QueryBackOffice', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice.dll', 0, null)                                                                                                                                                                                                                                                                                                                                                                    
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.QueryBackOffice' 
                                                                                                                                                                                                                                                                                                                                                                                                                              
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                    
go

--------------------------------------------------------------------------
--CREACION CTA.Ahos.CausalAdmAccounts 
--------------------------------------------------------------------------
-- Registros para: CTA.Ahos.CausalAdmAccounts 
print 'Registros para: CTA.Ahos.CausalAdmAccounts'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'

if not exists(select 1 from an_label where la_label = 'CTA.Ahos.CausalAdmAccounts')begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, 'ES_EC', 'CTA.Ahos.CausalAdmAccounts', 'M-CTA') 
end else select @w_la_id = la_id from an_label where la_label = 'CTA.Ahos.CausalAdmAccounts'

if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CausalAdmAccounts.Installer') begin                                                                                                                                                                                                                                                                                                                                                                                                                           
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) 
values (@w_mg_id, 'CTA.Ahos.CausalAdmAccounts.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CausalAdmAccounts.Installer/COBISCorp.tCOBIS.CTA.Ahos.CausalAdmAccounts.Installer.application', 'COBISExplorer')                                                                                                                                                                                                                                                                                                  
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CausalAdmAccounts.Installer'
                                                                                                                                                                                                                                                                                                                                                                                                                         
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CausalAdmAccounts') begin                                                                                                                                                                                                                                                                                                                                                                                                                                 
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CausalAdmAccounts', 'COBISCorp.tCOBIS.CTA.Ahos.CausalAdmAccounts.dll', 0, null)                                                                                                                                                                                                                                                                                                                                                                    
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CausalAdmAccounts' 
                                                                                                                                                                                                                                                                                                                                                                                                                              
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                    
go

--------------------------------------------------------------------------
--CREACION CTA.Ahos.Query 
--------------------------------------------------------------------------
print 'Registros para: CTA.Ahos.Query'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'

if not exists(select 1 from an_label where la_label = 'CTA.Ahos.Query')begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, 'ES_EC', 'CTA.Ahos.Query', 'M-CTA') 
end else select @w_la_id = la_id from an_label where la_label = 'CTA.Ahos.Query'

if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.Query.Installer') begin                                                                                                                                                                                                                                                                                                                                                                                                                           
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) 
values (@w_mg_id, 'CTA.Ahos.Query.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.Query.Installer/CTA.Ahos.Query.Installer.application', 'COBISExplorer')                                                                                                                                                                                                                                                                                                  
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.Query.Installer'
                                                                                                                                                                                                                                                                                                                                                                                                                         
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.Query') begin                                                                                                                                                                                                                                                                                                                                                                                                                                 
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.Query', 'COBISCorp.tCOBIS.CTA.Ahos.Query.dll', 0, null)                                                                                                                                                                                                                                                                                                                                                                    
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.Query' 
                                                                                                                                                                                                                                                                                                                                                                                                                              
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                    
go

--------------------------------------------------------------------------
--CREACION CTA.Ahos.BackOfficeProcesses 
--------------------------------------------------------------------------
print 'Registros para: CTA.Ahos.BackOfficeProcesses'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'

if not exists(select 1 from an_label where la_label = 'CTA.Ahos.BackOfficeProcesses')begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, 'ES_EC', 'CTA.Ahos.BackOfficeProcesses', 'M-CTA') 
end else select @w_la_id = la_id from an_label where la_label = 'CTA.Ahos.BackOfficeProcesses'

if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer') begin                                                                                                                                                                                                                                                                                                                                                                                                                           
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) 
values (@w_mg_id, 'CTA.Ahos.BackOfficeProcesses.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.BackOfficeProcesses.Installer/COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses.Installer.application', 'COBISExplorer')                                                                                                                                                                                                                                                                                                  
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer'
                                                                                                                                                                                                                                                                                                                                                                                                                         
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses') begin                                                                                                                                                                                                                                                                                                                                                                                                                                 
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.BackOfficeProcesses', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses.dll', 0, null)                                                                                                                                                                                                                                                                                                                                                                    
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses' 
                                                                                                                                                                                                                                                                                                                                                                                                                              
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                    
go

--------------------------------------------------------------------------
--CREACION CTA.Ahos.QueryBalances
--------------------------------------------------------------------------
print 'Registros para: CTA.Ahos.QueryBalances'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'

if not exists(select 1 from an_label where la_label = 'CTA.Ahos.QueryBalances')begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, 'ES_EC', 'CTA.Ahos.QueryBalances', 'M-CTA') 
end else select @w_la_id = la_id from an_label where la_label = 'CTA.Ahos.QueryBalances'

if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBalances.Installer') begin                                                                                                                                                                                                                                                                                                                                                                                                                           
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) 
values (@w_mg_id, 'CTA.Ahos.QueryBalances.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.QueryBalances.Installer/CTA.Ahos.QueryBalances.Installer.application', 'COBISExplorer')                                                                                                                                                                                                                                                                                                  
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBalances.Installer'
                                                                                                                                                                                                                                                                                                                                                                                                                         
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.QueryBalances') begin                                                                                                                                                                                                                                                                                                                                                                                                                                 
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.QueryBalances', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBalances.dll', 0, null)                                                                                                                                                                                                                                                                                                                                                                    
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.QueryBalances' 
                                                                                                                                                                                                                                                                                                                                                                                                                              
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                    
go

--------------------------------------------------------------------------
--CREACION CTA.Ahos.Admin 
--------------------------------------------------------------------------
-- Registros para: CTA.Ahos.Admin 
print 'Registros para: CTA.Ahos.Admin'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'

if not exists(select 1 from an_label where la_label = 'CTA.Ahos.Admin')begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, 'ES_EC', 'CTA.Ahos.Admin', 'M-CTA') 
end else select @w_la_id = la_id from an_label where la_label = 'CTA.Ahos.Admin'

if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.Admin.Installer') begin                                                                                                                                                                                                                                                                                                                                                                                                                           
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) 
values (@w_mg_id, 'CTA.Ahos.Admin.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.Admin.Installer/CTA.Ahos.Admin.Installer.application', 'COBISExplorer')                                                                                                                                                                                                                                                                                                  
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.Admin.Installer'
                                                                                                                                                                                                                                                                                                                                                                                                                         
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.Admin') begin                                                                                                                                                                                                                                                                                                                                                                                                                                 
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.Admin', 'COBISCorp.tCOBIS.CTA.Ahos.Admin.dll', 0, null)                                                                                                                                                                                                                                                                                                                                                                    
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.Admin' 
                                                                                                                                                                                                                                                                                                                                                                                                                              
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                    
go

--------------------------------------------------------------------------
--CREACION CTA.Ahos.CustService 
--------------------------------------------------------------------------
-- Registros para: CTA.Ahos.CustService 
print 'Registros para: CTA.Ahos.CustService'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'

if not exists(select 1 from an_label where la_label = 'CTA.Ahos.CustService')begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, 'ES_EC', 'CTA.Ahos.CustService', 'M-CTA') 
end else select @w_la_id = la_id from an_label where la_label = 'CTA.Ahos.CustService'

if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin                                                                                                                                                                                                                                                                                                                                                                                                                           
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) 
values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')                                                                                                                                                                                                                                                                                                  
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
                                                                                                                                                                                                                                                                                                                                                                                                                         
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin                                                                                                                                                                                                                                                                                                                                                                                                                                 
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)                                                                                                                                                                                                                                                                                                                                                                    
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService' 
                                                                                                                                                                                                                                                                                                                                                                                                                              
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                    
go


-- -------------------------------------------
-- OPCION: Atención al Cliente (MENU PRIN)
-- -------------------------------------------
-- Registros para: AC.Atención al Cliente
if exists (select 1 from cobis..an_page where pa_name = 'AC.Atencion al Cliente') 
begin
	print 'Eliminación PA_NAME: AC.Atencion al Cliente'
	delete from cobis..an_page where pa_name = 'AC.Atencion al Cliente'
end
go

if not exists (select 1 from cobis..an_page where pa_name = 'AC.Atención al Cliente') begin
	print 'Registros para: AC.Atención al Cliente'
	declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
	select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
	select @w_la_cod = 'ES_EC'
	select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
	insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Atención al Cliente', 'M-MENUPRIN')
	select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
	select @w_pa_id_parent = 0
	insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
	values (@w_pa_id, @w_la_id, 'AC.Atención al Cliente', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-MENUPRIN', '', null)
	insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
end
go

		-- Registros para: AC.Aperturas y Originaciones
		if not exists (select 1 from cobis..an_page where pa_name = 'AC.Aperturas y Originaciones' and pa_prod_name = 'M-MENUPRIN') begin
		print 'Registros para: AC.Aperturas y Originaciones'
		declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
		select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
		select @w_la_cod = 'ES_EC'
		select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
		insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Aperturas y Originaciones', 'M-MENUPRIN')
		select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
		select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Atención al Cliente' and pa_prod_name = 'M-MENUPRIN'
		insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
		values (@w_pa_id, @w_la_id, 'AC.Aperturas y Originaciones', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-MENUPRIN', '', null)
		insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
		end
		go

				-- Registros para: AC.Cuentas
				if not exists (select 1 from cobis..an_page where pa_name = 'AC.Aho.Cuentas' and pa_prod_name = 'M-CTA') begin
				print 'Registros para: AC.Cuentas'
				declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
				select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
				select @w_la_cod = 'ES_EC'
				select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
				insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cuentas', 'M-CTA')
				select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
				select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aperturas y Originaciones' and pa_prod_name = 'M-MENUPRIN'
				insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
				values (@w_pa_id, @w_la_id, 'AC.Aho.Cuentas', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
				insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
				end
				go

-- Registros para: AC.CTA.FTran351
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTran351') begin
print 'Registros para: AC.CTA.FTran351'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Solicitud', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Cuentas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'AC.CTA.FTran351', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran351', 'FTran351Class', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Solicitud') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Solicitud', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Solicitud'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: AC.CTA.FTRAN354
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTRAN354') begin
print 'Registros para: AC.CTA.FTRAN354'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Autorización de Solicitud', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Cuentas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'AC.CTA.FTRAN354', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
values (@w_co_id, @w_mo_id, 'CTA.FTRAN354', 'FTRAN354Class', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Autorización de Solicitud') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Autorización de Solicitud', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Autorización de Solicitud'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: AC.CTA.FTran201
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTran201') begin
print 'Registros para: AC.CTA.FTran201'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Apertura de Cuentas', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Cuentas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'AC.CTA.FTran201', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran201', 'FTran201Class', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Apertura de Cuentas') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Apertura de Cuentas', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Apertura de Cuentas'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

		-- Registros para: AC.Servicios Bancarios1
		if not exists (select 1 from cobis..an_page where pa_name = 'AC.Servicios Bancarios1' and pa_prod_name = 'M-MENUPRIN') begin
		print 'Registros para: AC.Servicios Bancarios1'
		declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
		select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
		select @w_la_cod = 'ES_EC'
		select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
		insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Servicios Bancarios', 'M-MENUPRIN')
		select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
		select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Atención al Cliente' and pa_prod_name = 'M-MENUPRIN'
		insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
		values (@w_pa_id, @w_la_id, 'AC.Servicios Bancarios1', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-MENUPRIN', '', null)
		insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
		end
		go						
						-- Registros para: AC.Bloqueos
						if not exists (select 1 from cobis..an_page where pa_name = 'AC.Aho.Bloqueos' and pa_prod_name = 'M-CTA') begin
						print 'Registros para: AC.Bloqueos'
						declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
						select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
						select @w_la_cod = 'ES_EC'
						select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
						insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Bloqueos', 'M-CTA')
						select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
						select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Servicios Bancarios1' and pa_prod_name = 'M-MENUPRIN'
						insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
						values (@w_pa_id, @w_la_id, 'AC.Aho.Bloqueos', 'icono pagina', @w_pa_id_parent, 2, 'horizontal', 'Nemonic', 'M-CTA', '', null)
						insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
						end
						go

						
-- Registros para: AC.CTA.FTran211 (FMotorBusq)
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTran211') begin
print 'Registros para: AC.CTA.FTran211'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Movimientos', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Bloqueos'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'AC.CTA.FTran211', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Bloqueo_de_Movimientos', null)
--values (@w_pa_id, @w_la_id, 'AC.CTA.FTran211', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
values (@w_co_id, @w_mo_id, 'CTA.FTran211', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
-- values (@w_co_id, @w_mo_id, 'CTA.FTran211', 'FTran211Class', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'De Movimientos') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Movimientos', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'De Movimientos'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go
-- Registros para: AC.CTA.FTran217 (FMotorBusq)
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTran217') begin
print 'Registros para: AC.CTA.FTran217'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Valor en Cuentas de Ahorros', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Bloqueos'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'AC.CTA.FTran217', 'icono pagina', @w_pa_id_parent, 2, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Bloqueo_de_Valor_a_ctas_aho', null)
-- values (@w_pa_id, @w_la_id, 'AC.CTA.FTran217', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
values (@w_co_id, @w_mo_id, 'CTA.FTran217', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
-- values (@w_co_id, @w_mo_id, 'CTA.FTran217', 'FTran217Class', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'De Valor en Cuentas de Ahorros') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Valor en Cuentas de Ahorros', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'De Valor en Cuentas de Ahorros'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

						-- Registros para: AC.Levantamientos
						if not exists (select 1 from cobis..an_page where pa_name = 'AC.Aho.Levantamientos' and pa_prod_name = 'M-CTA') begin
						print 'Registros para: AC.Levantamientos'
						declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
						select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
						select @w_la_cod = 'ES_EC'
						select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
						insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Levantamientos', 'M-CTA')
						select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
						select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Servicios Bancarios1' and pa_prod_name = 'M-MENUPRIN'
						insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
						values (@w_pa_id, @w_la_id, 'AC.Aho.Levantamientos', 'icono pagina', @w_pa_id_parent, 3, 'horizontal', 'Nemonic', 'M-CTA', '', null)
						insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
						end
						go
-- Registros para: AC.CTA.FTran212 (FMotorBusq)
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTran212') begin
print 'Registros para: AC.CTA.FTran212'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Bloqueos de Movimientos', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Levantamientos'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'AC.CTA.FTran212', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Desbloqueo_de_Movimientos', null)
-- values (@w_pa_id, @w_la_id, 'AC.CTA.FTran212', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
values (@w_co_id, @w_mo_id, 'CTA.FTran212', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
-- values (@w_co_id, @w_mo_id, 'CTA.FTran212', 'FTran212Class', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'De Bloqueos de Movimientos') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Bloqueos de Movimientos', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'De Bloqueos de Movimientos'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: AC.CTA.FTran218 (FMotorBusq)
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTran218') begin
print 'Registros para: AC.CTA.FTran218'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Valor a Cuentas de Ahorros', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Levantamientos'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'AC.CTA.FTran218', 'icono pagina', @w_pa_id_parent, 2, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Desbloqueo_de_valor_en_cta', null)
-- values (@w_pa_id, @w_la_id, 'AC.CTA.FTran218', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
values (@w_co_id, @w_mo_id, 'CTA.FTran218', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
-- values (@w_co_id, @w_mo_id, 'CTA.FTran218', 'FTran218Class', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'De Valor a Cuentas de Ahorros') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Valor a Cuentas de Ahorros', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'De Valor a Cuentas de Ahorros'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

						-- Registros para: AC.Cancelación
						if not exists (select 1 from cobis..an_page where pa_name = 'AC.Aho.Cancelacion' and pa_prod_name = 'M-CTA') begin
						print 'Registros para: AC.Cancelación'
						declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
						select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
						select @w_la_cod = 'ES_EC'
						select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
						insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cancelación', 'M-CTA')
						select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
						select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Servicios Bancarios1' and pa_prod_name = 'M-MENUPRIN'
						insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
						values (@w_pa_id, @w_la_id, 'AC.Aho.Cancelacion', 'icono pagina', @w_pa_id_parent, 4, 'horizontal', 'Nemonic', 'M-CTA', '', null)
						insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
						end
						go
						
-- Registros para: AC.CTA.FTran203 (FMotorBusq)
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTran203') begin
print 'Registros para: AC.CTA.FTran203'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Reactivación de Cuentas', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Cancelacion'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'AC.CTA.FTran203', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Reactivacion_de_Cuentas', null)
-- values (@w_pa_id, @w_la_id, 'AC.CTA.FTran203', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
values (@w_co_id, @w_mo_id, 'CTA.FTran203', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
--values (@w_co_id, @w_mo_id, 'CTA.FTran203', 'FTran203', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Reactivación de Cuentas') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Reactivación de Cuentas', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Reactivación de Cuentas'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go
-- Registros para: AC.CTA.FTran214 (FMotorBusq)
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTran214') begin
print 'Registros para: AC.CTA.FTran214'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cancelación de Cuentas', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Cancelacion'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'AC.CTA.FTran214', 'icono pagina', @w_pa_id_parent, 2, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Cancelacion_de_Cuentas', null)
-- values (@w_pa_id, @w_la_id, 'AC.CTA.FTran214', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
values (@w_co_id, @w_mo_id, 'CTA.FTran214', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
-- values (@w_co_id, @w_mo_id, 'CTA.FTran214', 'FTran214Class', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Cancelación de Cuentas') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cancelación de Cuentas', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Cancelación de Cuentas'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

		-- Registros para: AC.Consultas y Reportes
		if not exists (select 1 from cobis..an_page where pa_name = 'AC.Consultas y Reportes' and pa_prod_name = 'M-MENUPRIN') begin
		print 'Registros para: AC.Consultas y Reportes'
		declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
		select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
		select @w_la_cod = 'ES_EC'
		select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
		insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consultas y Reportes', 'M-MENUPRIN')
		select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
		select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Atención al Cliente' and pa_prod_name = 'M-MENUPRIN'
		insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
		values (@w_pa_id, @w_la_id, 'AC.Consultas y Reportes', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-MENUPRIN', '', null)
		insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
		end
		
		go	
			-- Registros para: AC.Consultas
			if not exists (select 1 from cobis..an_page where pa_name = 'AC.Aho.Consultas' and pa_prod_name = 'M-CTA') begin
			print 'Registros para: AC.Consultas'
			declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
			select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
			select @w_la_cod = 'ES_EC'
			select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
			insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consultas', 'M-CTA')
			select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
			select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Consultas y Reportes' and pa_prod_name = 'M-MENUPRIN'
			insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
			values (@w_pa_id, @w_la_id, 'AC.Aho.Consultas', 'icono pagina', @w_pa_id_parent, 5, 'horizontal', 'Nemonic', 'M-CTA', '', null)
			insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
			end
			go


-- Registros para: AC.CTA.FTran216 (FMotorBusq)
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTran216') begin
print 'Registros para: AC.CTA.FTran216'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Bloqueos de Valores a la Cuenta', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'AC.CTA.FTran216', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Consulta_BloqueoValores_En_Las_Cuentas', null)
-- values (@w_pa_id, @w_la_id, 'AC.CTA.FTran216', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
values (@w_co_id, @w_mo_id, 'CTA.FTran216', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
-- values (@w_co_id, @w_mo_id, 'CTA.FTran216', 'FTran216Class', 'COBISCorp.tCOBIS.CTA.Ahos.Query', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'De Bloqueos de Valores a la Cuenta') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Bloqueos de Valores a la Cuenta', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'De Bloqueos de Valores a la Cuenta'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go
-- Registros para: AC.CTA.FTran245 (FMotorBusq)
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTran245') begin
print 'Registros para: AC.CTA.FTran245'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Bloqueo de Movimientos', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'AC.CTA.FTran245', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Consulta_de_Bloqueo_de_Movimientos', null)
-- values (@w_pa_id, @w_la_id, 'AC.CTA.FTran245', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
values (@w_co_id, @w_mo_id, 'CTA.FTran245', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
-- values (@w_co_id, @w_mo_id, 'CTA.FTran245', 'FTran245Class', 'COBISCorp.tCOBIS.CTA.Ahos.Query', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'De Bloqueo de Movimientos') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Bloqueo de Movimientos', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'De Bloqueo de Movimientos'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go
-- Registros para: AC.CTA.Ftran220 (FMotorBusq)
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.Ftran220') begin
print 'Registros para: AC.CTA.Ftran220'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta De Saldos Y Promedios', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'AC.CTA.Ftran220', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Consulta_de_Saldos_y_Promedios', null)
-- values (@w_pa_id, @w_la_id, 'AC.CTA.Ftran220', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
values (@w_co_id, @w_mo_id, 'CTA.Ftran220', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
-- values (@w_co_id, @w_mo_id, 'CTA.Ftran220', 'Ftran220Class', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBalances', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Consulta De Saldos Y Promedios') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta De Saldos Y Promedios', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta De Saldos Y Promedios'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go
-- Registros para: AC.CTA.FTran235 (FMotorBusq)
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTran235') begin
print 'Registros para: AC.CTA.FTran235'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta General', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'AC.CTA.FTran235', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Consulta_General', null)
-- values (@w_pa_id, @w_la_id, 'AC.CTA.FTran235', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
values (@w_co_id, @w_mo_id, 'CTA.FTran235', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
-- values (@w_co_id, @w_mo_id, 'CTA.FTran235', 'FTran235Class', 'COBISCorp.tCOBIS.CTA.Ahos.Query', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Consulta General') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta General', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta General'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: AC.CTA.FTran232 (FMotorBusq)
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTran232') begin
print 'Registros para: AC.CTA.FTran232'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Movimientos', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'AC.CTA.FTran232', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Consulta_de_Movimientos', null)
-- values (@w_pa_id, @w_la_id, 'AC.CTA.FTran232', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
values (@w_co_id, @w_mo_id, 'CTA.FTran232', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
-- values (@w_co_id, @w_mo_id, 'CTA.FTran232', 'FTran232Class', 'COBISCorp.tCOBIS.CTA.Ahos.QueryMovements', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'De Movimientos') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Movimientos', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'De Movimientos'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: AC.CTA.FTran247 (FMotorBusq)
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTran247') begin
print 'Registros para: AC.CTA.FTran247'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Valores en Suspenso', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'AC.CTA.FTran247', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Consulta_de_Valores_en_Suspenso', null)
-- values (@w_pa_id, @w_la_id, 'AC.CTA.FTran247', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
values (@w_co_id, @w_mo_id, 'CTA.FTran247', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
-- values (@w_co_id, @w_mo_id, 'CTA.FTran247', 'FTran247Class', 'COBISCorp.tCOBIS.CTA.Ahos.Query', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'De Valores en Suspenso') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Valores en Suspenso', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'De Valores en Suspenso'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: AC.CTA.FTran343 (FMotorBusq)
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTran343') begin
print 'Registros para: AC.CTA.FTran343'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Detalle de cálculo de intereses', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'AC.CTA.FTran343', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Consulta_de_Detalle_de_Calculo_de_Intereses', null)
-- values (@w_pa_id, @w_la_id, 'AC.CTA.FTran343', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
values (@w_co_id, @w_mo_id, 'CTA.FTran343', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
--values (@w_co_id, @w_mo_id, 'CTA.FTran343', 'FTran343Class', 'COBISCorp.tCOBIS.CTA.Ahos.Query', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Detalle de cálculo de intereses') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Detalle de cálculo de intereses', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Detalle de cálculo de intereses'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go
						
-- Registros para: AC.CTA.FTran234 (FMotorBusq)
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTran234') begin
print 'Registros para: AC.CTA.FTran234'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Extracto de Cuenta de Ahorros', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'AC.CTA.FTran234', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Consulta_de_Extracto_de_Cuenta_de_Ahorros', null)
-- values (@w_pa_id, @w_la_id, 'AC.CTA.FTran234', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
values (@w_co_id, @w_mo_id, 'CTA.FTran234', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
-- values (@w_co_id, @w_mo_id, 'CTA.FTran234', 'FTran234Class', 'COBISCorp.tCOBIS.CTA.Ahos.QueryMovements', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Extracto de Cuenta de Ahorros') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Extracto de Cuenta de Ahorros', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Extracto de Cuenta de Ahorros'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go
-- Registros para: AC.CTA.FTran223 (FMotorBusq)
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTran223') begin
print 'Registros para: AC.CTA.FTran223'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Extracto de Cuenta de Ahorros sin Costo', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'AC.CTA.FTran223', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Extracto_de_Cuenta_de_Ahorros_sin_Costo', null)
-- values (@w_pa_id, @w_la_id, 'AC.CTA.FTran223', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
values (@w_co_id, @w_mo_id, 'CTA.FTran223', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
-- values (@w_co_id, @w_mo_id, 'CTA.FTran223', 'FTran223Class', 'COBISCorp.tCOBIS.CTA.Ahos.QueryMovements', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Extracto de Cuenta de Ahorros sin Costo') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Extracto de Cuenta de Ahorros sin Costo', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Extracto de Cuenta de Ahorros sin Costo'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Validacion Param OCUCOL - INI
if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
    -- Registros para: AC.CTA.FTran096 (FMotorBusq)
    if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTran096') 
    begin
        print 'Registros para: AC.CTA.FTran096'
        declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
        select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
        select @w_la_cod = 'ES_EC'
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Canje en Cuenta', 'M-CTA')
        select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
        select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Consultas'
        insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
        values (@w_pa_id, @w_la_id, 'AC.CTA.FTran096', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Consulta_de_Canje_por_Cuenta', null)
        -- values (@w_pa_id, @w_la_id, 'AC.CTA.FTran096', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
        insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
        if not exists (select 1 from an_zone where zo_id = 1)
        begin
            insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
        end
        if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer')
        begin
            select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
            insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
        end 
        else
            select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
        if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService')
        begin
            select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
            insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
        end 
        else 
            select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
        if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
            insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
        select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
        insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
        values (@w_co_id, @w_mo_id, 'CTA.FTran096', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
        -- values (@w_co_id, @w_mo_id, 'CTA.FTran096', 'FTran096Class', 'COBISCorp.tCOBIS.CTA.Ahos.Query', 'SV', '', 'M-CTA')
        insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
        if not exists (select 1 from cobis..an_label where la_label = 'Consulta de Canje en Cuenta')
        begin
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Canje en Cuenta', 'M-CTA')
        end
        else 
            select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta de Canje en Cuenta'
        select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
        if @w_pz_id is null select @w_pz_id = 1
            if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
            begin
                insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
            end
    --end
    end
-- Validacion Param OCUCOL - FIN
go

-- Registros para: AC.CTA.FTranCME1
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTranCME1') begin
print 'Registros para: AC.CTA.FTranCME1'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cuentas Menor de Edad', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'AC.CTA.FTranCME1', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Cuentas_Menor_de_Edad', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBackOffice.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.QueryBackOffice.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.QueryBackOffice.Installer/CTA.Ahos.QueryBackOffice.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBackOffice.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.QueryBackOffice') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.QueryBackOffice', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.QueryBackOffice'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
values (@w_co_id, @w_mo_id, 'CTA.FTranCME1', 'FTranCMEClass', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Cuentas Menor de Edad') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cuentas Menor de Edad', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Cuentas Menor de Edad'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: AC.CTA.FTranCME2
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTranCME2') begin
print 'Registros para: AC.CTA.FTranCME2'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cuentas Próximo Mayor de Edad', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'AC.CTA.FTranCME2', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Cuentas_Proximo_Mayor_de_Edad', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBackOffice.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.QueryBackOffice.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.QueryBackOffice.Installer/CTA.Ahos.QueryBackOffice.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBackOffice.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.QueryBackOffice') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.QueryBackOffice', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.QueryBackOffice'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
values (@w_co_id, @w_mo_id, 'CTA.FTranCME2', 'FTranCMEClass', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Cuentas Próximo Mayor de Edad') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cuentas Próximo Mayor de Edad', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Cuentas Próximo Mayor de Edad'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

		-- Registros para: AC.Históricos
		if not exists (select 1 from cobis..an_page where pa_name = 'AC.Aho.Historicos' and pa_prod_name = 'M-CTA') begin
		print 'Registros para: AC.Históricos'
		declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
		select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
		select @w_la_cod = 'ES_EC'
		select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
		insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Históricos', 'M-CTA')
		select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
		select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Consultas y Reportes' and pa_prod_name = 'M-MENUPRIN'
		insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
		values (@w_pa_id, @w_la_id, 'AC.Aho.Historicos', 'icono pagina', @w_pa_id_parent, 6, 'horizontal', 'Nemonic', 'M-CTA', '', null)
		insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
		end
		go



-- Registros para: AC.CTA.FHistoricoAM
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FHistoricoAM') begin
print 'Registros para: AC.CTA.FHistoricoAM'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta Histórica de Transacciones Monetarias', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Historicos'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'AC.CTA.FHistoricoAM', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryMovements.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.QueryMovements.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.QueryMovements.Installer/CTA.Ahos.QueryMovements.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryMovements.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.QueryMovements') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.QueryMovements', 'COBISCorp.tCOBIS.CTA.Ahos.QueryMovements.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.QueryMovements'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FHistoricoAM', 'FHistoricoAMClass', 'COBISCorp.tCOBIS.CTA.Ahos.QueryMovements', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Consulta Histórica de Transacciones Monetarias') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta Histórica de Transacciones Monetarias', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta Histórica de Transacciones Monetarias'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go
-- Registros para: AC.CTA.FHistoricoAS
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FHistoricoAS') begin
print 'Registros para: AC.CTA.FHistoricoAS'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta Histórica de Transacciones de Servicio', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Historicos'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'AC.CTA.FHistoricoAS', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryMovements.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.QueryMovements.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.QueryMovements.Installer/CTA.Ahos.QueryMovements.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryMovements.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.QueryMovements') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.QueryMovements', 'COBISCorp.tCOBIS.CTA.Ahos.QueryMovements.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.QueryMovements'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FHistoricoAS', 'FHistoricoASClass', 'COBISCorp.tCOBIS.CTA.Ahos.QueryMovements', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Consulta Histórica de Transacciones de Servicio') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta Histórica de Transacciones de Servicio', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta Histórica de Transacciones de Servicio'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

                -- Registros para: AC.Transacciones
		if not exists (select 1 from cobis..an_page where pa_name = 'AC.Aho.Transacciones' and pa_prod_name = 'M-CTA') begin
		print 'Registros para: AC.Transacciones'
		declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
		select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
		select @w_la_cod = 'ES_EC'
		select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
		insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Transacciones', 'M-CTA')
		select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
		select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Servicios Bancarios1' and pa_prod_name = 'M-MENUPRIN'
		insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id, pa_visible)
		values (@w_pa_id, @w_la_id, 'AC.Aho.Transacciones', 'icono pagina', @w_pa_id_parent, 7, 'horizontal', 'Nemonic', 'M-CTA', '', null, 1)
		insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)		
		end
		go

-- Registros para: AC.CTA.FTRAN41 (Deposito de ahorros)
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTRAN41') begin
print 'Registros para: AC.CTA.FTRAN41'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Depósito de ahorros', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Transacciones'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id, pa_visible) values (@w_pa_id, @w_la_id, 'AC.CTA.FTRAN41', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null, 1)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTRAN41', 'FTRAN41Class', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: AC.CTA.FTRAN76 (Retiro de ahorros)
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FTRAN76') begin
print 'Registros para: AC.CTA.FTRAN76'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Retiro de ahorros', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Transacciones'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id, pa_visible) values (@w_pa_id, @w_la_id, 'AC.CTA.FTRAN76', 'icono pagina', @w_pa_id_parent, 2, 'horizontal', 'Nemonic', 'M-CTA', '', null, 1)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTRAN76', 'FTRAN76Class', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: AC.CTA.FReversos (Reverso de transacciones)
if not exists (select 1 from cobis..an_page where pa_name = 'AC.CTA.FReversos') begin
print 'Registros para: AC.CTA.FReversos'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Reverso de transacciones', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'AC.Aho.Transacciones'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id, pa_visible) values (@w_pa_id, @w_la_id, 'AC.CTA.FReversos', 'icono pagina', @w_pa_id_parent, 3, 'horizontal', 'Nemonic', 'M-CTA', '', null, 1)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.0', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FReversos', 'FReversosClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go
