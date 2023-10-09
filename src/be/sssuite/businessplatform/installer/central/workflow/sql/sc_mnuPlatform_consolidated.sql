use cobis
go

---------------------------------Declaracion de Variables----------------------------------------
declare @w_id_padre int, 
		@w_id_menu  int, 
		@w_rol_menu int

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
	select @w_rol_menu =  max(ro_rol)+1 from cobis..ad_rol
	insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
	values (@w_rol_menu, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
		
select  @w_id_menu  = null
select  @w_id_padre = null
select  @w_rol_menu = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

-------------------------------------------------------------------------------------------------
---------------------------------------FRONT OFFICE----------------------------------------------
-------------------------------------------------------------------------------------------------

------------------------------------------Eliminacion--------------------------------------------

/*
/ MNU_ADMIN_VCC (Nivel 2) 
*/
select  @w_id_menu = me_id from cobis..cew_menu where me_name = 'MNU_ADMIN_VCC'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu	

/*
/ MNU_VCC (Nivel 2)
*/
select  @w_id_menu = me_id from cobis..cew_menu where me_name = 'MNU_VCC'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu	

/*
/ MNU_CONTENT_SECTION (Nivel 2)
*/
select  @w_id_menu = me_id from cobis..cew_menu where me_name = 'MNU_CONTENT_SECTION'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu	

/*
/ MNU_CONTENT_SECTION_SECURITY (Nivel 2)
*/
select  @w_id_menu = me_id from cobis..cew_menu where me_name = 'MNU_CONTENT_SECTION_SECURITY'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu	

/*
/ MNU_SECTION_ADMINISTRATOR (Nivel 2)
*/
select  @w_id_menu = me_id from cobis..cew_menu where me_name = 'MNU_SECTION_ADMINISTRATOR'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu	

/*
/ MNU_DTOS_AND_PROPERTIES (Nivel 2)
*/
select  @w_id_menu = me_id from cobis..cew_menu where me_name = 'MNU_DTOS_AND_PROPERTIES'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu

/*
/ MNU_FRONTOFFICE (Nivel 1)
*/
select  @w_id_menu  = me_id from cew_menu where me_name      = 'MNU_FRONTOFFICE'
delete from cew_menu_favorite where fav_id_menu = @w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu

------------------------------------------Insert--------------------------------------------------
/*
/ MNU_FRONTOFFICE (Nivel 1)
*/
select @w_id_padre = null
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
	
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values (@w_id_menu, null, 'MNU_FRONTOFFICE', 1, null , 0, 0)
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

select @w_id_padre = @w_id_menu

/*
/ MNU_VCC (Nivel 2) 
*/
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu

insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values(@w_id_menu, @w_id_padre, 'MNU_VCC', 1, 'views/clientviewer/container-clientviewer.html', 0, 73)
	
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

/*
/ MNU_ADMIN_VCC (Nivel 2) 
*/
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
	
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values(@w_id_menu, @w_id_padre, 'MNU_ADMIN_VCC', 1, 'views/admin-clientviewer/admin-client-viewer.html', 1, 73)
	
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

/*
/ MNU_CONTENT_SECTION (Nivel 2) 
*/
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
	
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values(@w_id_menu, @w_id_padre, 'MNU_CONTENT_SECTION', 1, 'views/LATFO/PLATF/T_PLATF_99_NSOSK11/1.0.0/VC_NSOSK11_NNTOO_561_TASK.html', 2, 73)
	
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

/*
/ MNU_CONTENT_SECTION_SECURITY (Nivel 2) 
*/
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
	
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values(@w_id_menu, @w_id_padre, 'MNU_CONTENT_SECTION_SECURITY', 1, 'views/LATFO/PLATF/T_PLATF_90_LTNTI84/1.0.0/VC_LTNTI84_REONA_308_TASK.html', 3, 73)
	
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

/*
/ MNU_SECTION_ADMINISTRATOR (Nivel 2) 
*/
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
	
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values(@w_id_menu, @w_id_padre, 'MNU_SECTION_ADMINISTRATOR', 1, 'views/admin-clientviewer/admin-clientviewer-tree-page.html', 3, 73)
	
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

/*
/ MNU_DTOS_AND_PROPERTIES (Nivel 2) 
*/
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
	
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values(@w_id_menu, @w_id_padre, 'MNU_DTOS_AND_PROPERTIES', 1, 'views/LATFO/UCSPM/T_UCSPM_16_KTOIT54/1.0.0/VC_KTOIT54_DOLST_848_TASK.html', 3, 73)
	
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

-------------------------------------------------------------------------------------------------
---------------------------------------BACK OFFICE-----------------------------------------------
-------------------------------------------------------------------------------------------------

------------------------------------------Eliminacion--------------------------------------------

/*
/ MNU_GROUP_ADMINISTRATION (Nivel 3)
*/
select  @w_id_menu  = me_id from cobis..cew_menu where me_name = 'MNU_GROUP_ADMINISTRATION'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu	

/*
/ MNU_BUSSINESS_RULES_ADMIN (Nivel 3) 
*/
select  @w_id_menu  = me_id from cobis..cew_menu where me_name = 'MNU_BUSSINESS_RULES_ADMIN'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu	

/*
/ MNU_EDITOR_POLITICAS (Nivel 3) 
*/
select  @w_id_menu  = me_id from cobis..cew_menu where me_name = 'MNU_EDITOR_POLITICAS'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu	

/*
/ MNU_VARIABLES_PROGRAMS (Nivel 3)
*/
select  @w_id_menu  = me_id from cew_menu where me_name      = 'MNU_VARIABLES_PROGRAMS'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu	

/*
/ MNU_INBOX_QUERY (Nivel 3)
*/
select  @w_id_menu  = me_id from cobis..cew_menu where me_name = 'MNU_INBOX_QUERY'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu	

/*
/ MNU_CONTAINER_INBOX_SS (Nivel 3)
*/
select  @w_id_menu  = me_id from cobis..cew_menu where me_name = 'MNU_CONTAINER_INBOX_SS'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu		

/*
/ MNU_CONTAINER_INBOX_FF (Nivel 3)
*/
select  @w_id_menu  = me_id from cobis..cew_menu where me_name = 'MNU_CONTAINER_INBOX_FF'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu	

/*
/  MNU_REASIGNACION  (Nivel 3)
*/
select  @w_id_menu  = me_id from cobis..cew_menu where me_name = 'MNU_REASIGNACION'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu	

/*
/ MNU_REPRINT_DOCUMENT (Nivel 3)
*/
select  @w_id_menu  = me_id from cobis..cew_menu where me_name = 'MNU_REPRINT_DOCUMENT'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu	

/*
/ MNU_WORKFLOW_EDITOR (Nivel 3)
*/
select  @w_id_menu  = me_id from cobis..cew_menu where me_name = 'MNU_WORKFLOW_EDITOR'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu		

/*
/ MNU_WORKFLOW_STATISTICS (Nivel 3)
*/
select  @w_id_menu  = me_id from cobis..cew_menu where me_name = 'MNU_WORKFLOW_STATISTICS'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu		

/*
/ MNU_CAT_SUBCAT (Nivel 3)
*/
select  @w_id_menu  = me_id from cobis..cew_menu where me_name = 'MNU_CAT_SUBCAT'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu		

/*
/ MNU_SEARCH_CLAIMS (Nivel 3)
*/
select  @w_id_menu  = me_id from cobis..cew_menu where me_name = 'MNU_SEARCH_CLAIMS'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu	

/*
/ MNU_CAT_SUBCAT (Nivel 3) 
*/
select @w_id_menu = me_id from cobis..cew_menu where me_name = 'MNU_SEARCH_TRAN_MKCHK'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu	

/*
/ MNU_CAT_SUBCAT (Nivel 3) 
*/
select @w_id_menu = me_id from cobis..cew_menu where me_name = 'MNU_GRP_PENALIZATION'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu	

/*
/ MNU_CAT_SUBCAT (Nivel 3) 
*/
select @w_id_menu = me_id from cobis..cew_menu where me_name = 'MNU_QUER_PUNISHMENT'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu	

/*
/ MNU_BUSINESS_RULES (Nivel 2) 
*/
select  @w_id_menu  = me_id from cew_menu where me_name      = 'MNU_BUSINESS_RULES'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu	

/*
/ MNU_INBOX (Nivel 2)
*/
select  @w_id_menu  = me_id from cew_menu where me_name      = 'MNU_INBOX'
delete from cew_menu_favorite where fav_id_menu = @w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from   cew_menu where me_id       = @w_id_menu

/*
/ MNU_MANAGEMENT_CLAIMS (Nivel 2)
*/
select  @w_id_menu  = me_id from cew_menu where me_name      = 'MNU_MANAGEMENT_CLAIMS'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu	

/*
/ MNU_WORKFLOW (Nivel 2)
*/
select  @w_id_menu  = me_id from cew_menu where me_name      = 'MNU_WORKFLOW'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu	

/*
/ MNU_MAKER_CHECKER (Nivel 2)
*/
select @w_id_menu  = me_id from cew_menu where me_name = 'MNU_MAKER_CHECKER'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu	

/*
/ MNU_SIMULATION (Nivel 2)
*/
select @w_id_menu  = me_id from cew_menu where me_name = 'MNU_SIMULATION'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu

/*
/ MNU_REQUEST_PUNISHMENT (Nivel 2)
*/
select @w_id_menu  = me_id from cew_menu where me_name = 'MNU_REQUEST_PUNISHMENT'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu

/*
/ MNU_BACK_OFFICE (Nivel 1) 
*/
select  @w_id_menu  = me_id from cew_menu where me_name      = 'MNU_BACK_OFFICE'
delete from cew_menu_favorite where fav_id_menu =@w_id_menu
delete from cew_menu_role where mro_id_menu = @w_id_menu
delete from cew_menu where me_id = @w_id_menu

------------------------------------------Insert--------------------------------------------------
/*
/ MNU_BACK_OFFICE (Nivel 1) 
*/
select @w_id_padre= null
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
	
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values (@w_id_menu, null, 'MNU_BACK_OFFICE', 1, null , 0, 43)
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

select @w_id_padre = @w_id_menu

/*
/ MNU_BUSINESS_RULES (Nivel 2) 
*/
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu

insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values (@w_id_menu, @w_id_padre , 'MNU_BUSINESS_RULES', 1 , null  , 1, 0)
	
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

/*
/ MNU_INBOX (Nivel 2) 
*/
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu

insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values (@w_id_menu, @w_id_padre , 'MNU_INBOX', 1 , null  , 0, 0)
	
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

/*
/ MNU_MANAGEMENT_CLAIMS (Nivel 2)
*/
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu

insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values (@w_id_menu, @w_id_padre , 'MNU_MANAGEMENT_CLAIMS', 3 , null  , 0, 0)
	
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

/*
/ MNU_WORKFLOW (Nivel 2)
*/
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
	
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values              (@w_id_menu, @w_id_padre , 'MNU_WORKFLOW', 2 , null  , 0, 43)
	
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

/*
/ MNU_MAKER_CHECKER (Nivel 2)
*/
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
	
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values              (@w_id_menu, @w_id_padre , 'MNU_MAKER_CHECKER', 1 , null  , 0, 0)
	
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

/*
/ MNU_WORKFLOW (Nivel 3)
*/ 
select @w_id_padre = me_id from cew_menu where me_name = 'MNU_WORKFLOW'
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
	
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values (@w_id_menu, @w_id_padre, 'MNU_WORKFLOW_EDITOR', 1, 'views/workflow/workflow-tree-process-page.html', 1, 43)
		
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

/*
/ MNU_WORKFLOW_STATISTICS (Nivel 3)
*/ 
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
		
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values(@w_id_menu, @w_id_padre, 'MNU_WORKFLOW_STATISTICS', 1, 'views/workflow/workflow-container-statistics.html', 2, 43)
		
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

/*
/ MNU_BUSINESS_RULES (Nivel 3) 
*/ 
select @w_id_padre = me_id from cew_menu where me_name = 'MNU_BUSINESS_RULES'
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu

insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values(@w_id_menu, @w_id_padre, 'MNU_GROUP_ADMINISTRATION', 1, 'views/businessrules/container-group-businessrules.html', 1, 43)

insert into cew_menu_role values (@w_id_menu, @w_rol_menu)
	
/*
/ MNU_VARIABLES_PROGRAMS (Nivel 3)  
*/ 
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
		
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values(@w_id_menu, @w_id_padre, 'MNU_VARIABLES_PROGRAMS', 1, 'views/businessrules/container-businessrules.html', 2, 43)
		
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

/*
/ MNU_EDITOR_POLITICAS (Nivel 3)  
*/
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
	
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values (@w_id_menu, @w_id_padre, 'MNU_EDITOR_POLITICAS', 1, 'views/businessrules/container-rules-editor.html', 3, 43)
		
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

/*
/ MNU_BUSSINESS_RULES_ADMIN (Nivel 3)  
*/
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
		
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values(@w_id_menu, @w_id_padre, 'MNU_BUSSINESS_RULES_ADMIN', 1, 'views/businessrules/container-admin-businessrules.html', 4, 43)
		
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

/*
/ MNU_INBOX_QUERY (Nivel 3)  
*/
select @w_id_padre = me_id from cew_menu where me_name = 'MNU_INBOX'
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
	
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values (@w_id_menu, @w_id_padre, 'MNU_INBOX_QUERY', 1, 'views/inbox/inbox-query.html', 1, 43)
		
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)
	
/*
/ MNU_CONTAINER_INBOX_SS (Nivel 3)   
*/
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
		
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values(@w_id_menu, @w_id_padre, 'MNU_CONTAINER_INBOX_SS', 1, 'views/LATFO/INBOX/T_INBOX_72_NXNNR78/1.0.0/VC_NXNNR78_TSOGE_560_TASK.html?role=S', 2, 43)
		
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

/*
/ MNU_CONTAINER_INBOX_FF (Nivel 3) 
*/
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
		
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values(@w_id_menu, @w_id_padre, 'MNU_CONTAINER_INBOX_FF', 1, 'views/LATFO/INBOX/T_INBOX_72_NXNNR78/1.0.0/VC_NXNNR78_TSOGE_560_TASK.html?role=F', 3, 43)
		
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

/*
/ MNU_REASIGNACION (Nivel 3) 
*/
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
		
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values(@w_id_menu, @w_id_padre, 'MNU_REASIGNACION', 1, 'views/BUSIN/FLCRE/T_FLCRE_83_OCIPA21/1.0.0/VC_OCIPA21_AOLAO_722_TASK.html', 3, 43)
		
--insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

/*
/ MNU_REPRINT_DOCUMENT (Nivel 3) 
*/
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
		
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values(@w_id_menu, @w_id_padre, 'MNU_REPRINT_DOCUMENT', 1, 'views/BUSIN/FLCRE/T_FLCRE_13_RPUME79/1.0.0/VC_RPUME79_RERNO_643_TASK.html', 3, 43)
		
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

/*
/ MNU_CAT_SUBCAT (Nivel 3) 
*/
select @w_id_padre = me_id from cew_menu where me_name = 'MNU_MANAGEMENT_CLAIMS'
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
	
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values (@w_id_menu, @w_id_padre, 'MNU_CAT_SUBCAT', 1, 'views/LATFO/CLAIM/T_CLAIM_44_AGORY85/1.0.0/VC_AGORY85_CEGOR_783_TASK.html', 1, 43)
		
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

/*
/ MNU_SEARCH_CLAIMS (Nivel 3) 
*/
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
	
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values (@w_id_menu, @w_id_padre, 'MNU_SEARCH_CLAIMS', 1, 'views/LATFO/CLAIM/T_CLAIM_41_AHMES22/1.0.0/VC_AHMES22_FSCHE_616_TASK.html', 1, 43)
		
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

--MEKER AND CHECKER

/*
/ MNU_CAT_SUBCAT (Nivel 3) 
*/
select @w_id_padre = me_id from cew_menu where me_name = 'MNU_MAKER_CHECKER'
select @w_id_menu = isnull( max(me_id), 0 ) + 1	from cew_menu
insert into cew_menu(me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product)
values(@w_id_menu, @w_id_padre, 'MNU_SEARCH_TRAN_MKCHK', 1, 'views/MKCHK/ADMWS/T_ADMWS_85_NSACG04/1.0.0/VC_NSACG04_EASAD_863_TASK.html', 1, 77)
		
insert into cew_menu_role values (@w_id_menu, @w_rol_menu)

go
