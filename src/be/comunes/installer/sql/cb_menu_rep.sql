use cobis
go

declare @w_return int, @w_rol int
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
--insert into cobis..an_role_install values ('M-CON', @w_rol)

delete from cobis..an_module_dependency where md_mo_id in (select mo_id from cobis..an_module where mo_name in ('CON.MXN.resources', 'CON.MXN.SharedLibrary'))
delete from cobis..an_role_module where rm_mo_id in (select mo_id from cobis..an_module where mo_name in ('CON.MXN.resources', 'CON.MXN.SharedLibrary'))
delete from cobis..an_module_group where mg_name in ('CON.MXN.resources', 'CON.MXN.SharedLibrary')
delete from cobis..an_module where mo_name in ('CON.MXN.resources', 'CON.MXN.SharedLibrary')
delete from cobis..an_label where la_label  in ('CON.MXN.resources', 'CON.MXN.SharedLibrary')

 --Create Module Group and Modules
 exec @w_return = sp_cen_catalogar
   @i_opcion               = 'MOD',                                   
   @i_role                 = @w_rol,        
   @i_prod_name            = 'M-CON',
   @i_module_group         = 'CON.MXN.resources',                        
   @i_zone                 = 'Zona 1',
   @i_module               = 'CON.MXN.resources',
   @i_label_module         = 'CON.MXN.resources',
   @i_filename_module      = 'COBISCorp.tCOBIS.CON.MXN.resources.dll',
   @i_version              = '4.0.0.1', 
   @i_localizacion         = 'http://[servername]/CONTA.MXN.Reports.Installer/CONTA.MXN.Reports.Installer.application',
   @i_namespace_component  = 'COBISCorp.tCOBIS.CON.MXN.resources'--,
   --@i_parent_module        = 'CON.Toolbar'

if @w_return<> 0
	print 'Error crear Modulo Resources_Contabilidad_MXN'  

print 'SCRIPT DE CATALOGACION DE SHAREDLIBRARY'

/***************************************************************************/
/*        SCRIPT DE CATALOGACION DE SHAREDLIBRARY                          */
/***************************************************************************/

exec @w_return =sp_cen_catalogar
	@i_debug                = 'S',
	@i_opcion               = 'MOD',
	@i_role                 = @w_rol,
	@i_prod_name            = 'M-CON',
	@i_module_group         = 'CON.MXN.SharedLibrary',
	@i_zone                 = 'Zona 1',
	@i_module               = 'CON.MXN.SharedLibrary',
	@i_label_module         = 'CON.MXN.SharedLibrary',
	@i_namespace_component  = 'COBISCorp.tCOBIS.CON.MXN.SharedLibrary',
	@i_filename_module		= 'COBISCorp.tCOBIS.CON.MXN.SharedLibrary.dll',
	@i_version				= '4.0.0.1',
	@i_localizacion			= 'http://[servername]/CONTA.MXN.Reports.Installer/CONTA.MXN.Reports.Installer.application',
	@i_parent_module		= 'CON.MXN.resources'
	
if @w_return <> 0
	print 'Error Creando MOD:CON.MXN.SharedLibrary'
go

-- Registros para: PI.Empresas
print 'Registros para: PI.Reportes'

if  exists (select 1 from cobis..an_page where pa_name = 'PI.Reportes') 
begin
	delete from cobis..an_role_page where rp_pa_id in (select pa_id from cobis..an_page where pa_name = 'PI.Reportes')
	delete from cobis..an_page where pa_name = 'PI.Reportes'
end

if not exists (select 1 from cobis..an_page where pa_name = 'PI.Reportes') 
begin
	declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
	select @w_rol = ro_rol from cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
	select @w_la_cod = 'ES_EC'
	select @w_la_id = isnull(max(la_id), 0) + 1 from cobis..an_label

	insert into cobis..an_label (la_id, la_cod, la_label, la_prod_name) 
						 values (@w_la_id, @w_la_cod, 'Reportes', 'M-CON')
	
	select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
	select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'CCA.OP.Accounting'

	insert into cobis..an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id) 
						values (@w_pa_id, @w_la_id, 'PI.Reportes', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CON', '', null)

	insert into cobis..an_role_page (rp_pa_id, rp_rol) 
							 values (@w_pa_id, @w_rol)
end
go

-- Registros para: PI.CON.FBcoDefinicionClass
print 'Registros para: PI.CON.FSolRepRegClass'

if exists (select 1 from cobis..an_page where pa_name = 'PI.CON.FSolRepRegClass') 
begin	
	delete from cobis..an_module_dependency where md_mo_id in (select mo_id from cobis..an_module where mo_name in ('CON.MXN.Reports'))
	delete from cobis..an_role_module where rm_mo_id in (select mo_id from cobis..an_module where mo_name in ('CON.MXN.Reports'))
	delete from cobis..an_role_component where rc_co_id in (select co_id from cobis..an_component where co_name in ('CON.FSolRepReg'))
	delete from cobis..an_role_page where rp_pa_id in (select pa_id from cobis..an_page where pa_name = 'PI.CON.FSolRepRegClass')
	delete from cobis..an_page_zone where pz_pa_id in (select pa_id from cobis..an_page where pa_name = 'PI.CON.FSolRepRegClass')	
	
	delete from cobis..an_page where pa_name = 'PI.CON.FSolRepRegClass'
	delete from cobis..an_module_group where mg_name in ('CON.MXN.Reports')
	delete from cobis..an_module where mo_name in ('CON.MXN.Reports')
	delete from cobis..an_component where co_name in ('CON.FSolRepReg')
end

if not exists (select 1 from cobis..an_page where pa_name = 'PI.CON.FSolRepRegClass') 
begin
	declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int,
			@w_parent_module varchar(100), @w_id_parent_module int --JHI
	
	select @w_rol = ro_rol from cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
	select @w_la_cod = 'ES_EC'
	select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
	select @w_parent_module  = 'CON.MXN.SharedLibrary'     --JHI
	select @w_id_parent_module = mo_id       --JHI
			from cobis..an_module
			where mo_name = @w_parent_module
	
	insert into cobis..an_label (la_id, la_cod, la_label, la_prod_name) 
						 values (@w_la_id, @w_la_cod, 'Solicitud de Reportes', 'M-CON')
	
	select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
	select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Reportes'
	
	insert into cobis..an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id) 
						values (@w_pa_id, @w_la_id, 'PI.CON.FSolRepRegClass', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CON', '', null)

	insert into cobis..an_role_page(rp_pa_id, rp_rol) 
							values (@w_pa_id, @w_rol)

	if not exists (select 1 from an_zone where zo_id = 1) 
	begin  
		insert into cobis..an_zone (zo_id, zo_name, zo_pin_visible, zo_close_visible, zo_title_visible, zo_pin_value)
							values (1, 'Zona 1', 1, 1, 1, 1)  
	end

	if not exists (select 1 from cobis..an_module_group where mg_name = 'CON.MXN.Reports') 
	begin
		select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
		
		insert into cobis..an_module_group (mg_id, mg_name, mg_version, mg_location, mg_store_name)
									values (@w_mg_id, 'CON.MXN.Reports', '4.0.0.1', 'http://[servername]/CONTA.MXN.Reports.Installer/CONTA.MXN.Reports.Installer.application', 'COBISExplorer')
	end 
	else 
		select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CON.MXN.Company'

	if not exists (select 1 from cobis..an_module where mo_name = 'CON.MXN.Reports') 
	begin
		select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
		
		insert into cobis..an_module (mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token)
							values (@w_mo_id, @w_mg_id, @w_la_id, 'CON.MXN.Reports', 'COBISCorp.tCOBIS.CON.MXN.Reports.dll', 0, null)
	end 
	else 
		select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CON.MXN.Reports'

	if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
		insert into cobis..an_role_module (rm_mo_id, rm_rol)
									values (@w_mo_id, @w_rol)
	
	select @w_co_id  = isnull(max(co_id), 0) + 1 from cobis..an_component
	
	insert into cobis..an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
							values (@w_co_id, @w_mo_id, 'CON.FSolRepReg', 'FSolRepRegClass', 'COBISCorp.tCOBIS.CON.MXN.Reports', 'SV', '', 'M-CON')
	
	insert into cobis..an_role_component (rc_co_id, rc_rol)
								values (@w_co_id, @w_rol)
	
	if not exists (select 1 from cobis..an_label where la_label = 'Solicitud de Reportes') 
	begin
		select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
		insert into cobis..an_label values (@w_la_id, @w_la_cod, 'Solicitud de Reportes', 'M-CON')
	end
	else 
		select @w_la_id = la_id from cobis..an_label where la_label = 'Solicitud de Reportes'

	select @w_pz_id = isnull(max(pz_id), 0) + 1 from cobis..an_page_zone
	if @w_pz_id is null select @w_pz_id = 1
	
	if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) 
	begin
		insert into cobis..an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id)
										values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
	end
	
	if not exists (select 1 from cobis..an_module_dependency where md_mo_id = @w_mo_id and md_dependency_id = @w_id_parent_module)
	begin
		insert into cobis..an_module_dependency (md_mo_id, md_dependency_id)
										values (@w_mo_id ,@w_id_parent_module)    --JHI
	end
end
go
