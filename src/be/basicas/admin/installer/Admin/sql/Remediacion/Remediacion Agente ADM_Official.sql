use cobis
go

-- Agente
declare @w_la_id 	   int,
		@w_mg_id       int,
		@w_mo_id 	   int,
		@w_co_id 	   int,
		@w_ag_id 	   int,
		@w_rol 		   int

-- Instalacion de Agente del ADM.Official
print 'Instalacion Agente ADM.Official'
if not exists (select 1 from cobis..an_label where la_label = 'ADM.Official')
begin
	select @w_la_id = isnull(max(la_id), 0)+1 from cobis..an_label
	insert into cobis..an_label (la_id, la_cod, la_label, la_prod_name )
	values (@w_la_id, 'ES_EC', 'ADM.Official','M-ADM.Util')
end
else
	select @w_la_id = la_id from cobis..an_label where la_label = 'ADM.Official' 

if not exists (select 1 from cobis..an_module_group where mg_name = 'COBISCorp.tCOBIS.Utils.Official')
begin	
	select @w_mg_id = isnull(max(mg_id),0)+1 from cobis..an_module_group
	insert into cobis..an_module_group (mg_id, mg_name, mg_version,  mg_location, mg_store_name )
	values (@w_mg_id, 'COBISCorp.tCOBIS.Utils.Official', '1.0.0.0', 'http://[servername]/COBISCorp.tCOBIS.Utils.Official.Installer/COBISCorp.tCOBIS.Utils.Official.Installer.application', 'COBISExplorer')
end
else
	select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'COBISCorp.tCOBIS.Utils.Official'
	
if not exists (select 1 from cobis..an_module where mo_name = 'ADM.Official')
begin
	select @w_mo_id = isnull(max(mo_id),0)+1 from cobis..an_module
	insert into cobis..an_module (mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token)
	values (@w_mo_id,@w_mg_id, @w_la_id, 'ADM.Official', 'COBISCorp.tCOBIS.Utils.OfficialSearch.dll', 0  ,null)
end
else
	select @w_mo_id = mo_id from cobis..an_module where mo_name = 'ADM.Official'

if not exists (select 1 from cobis..an_component where co_name = 'ADM.Official')
begin
	select @w_co_id = isnull(max(co_id),0)+1 from cobis..an_component
	insert into cobis..an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name )
	values (@w_co_id,  @w_mo_id, 'ADM.Official',  'COBISAgentOfficialDescarga', 'COBISCorp.tCOBIS.Utils.Official','A',null,'M-ADM.Util')
end
else
	select @w_co_id = co_id from cobis..an_component where co_name = 'ADM.Official'
	
if not exists (select 1 from cobis..an_agent where ag_name = 'ADM.Official')
begin
	select @w_ag_id = isnull(max(ag_id),0)+1 from cobis..an_agent
	insert into cobis..an_agent (ag_id, ag_co_id, ag_name, ag_la_id )
	values (@w_ag_id, @w_co_id, 'ADM.Official', @w_la_id)
end
else
	select @w_ag_id = ag_id from cobis..an_agent where ag_name = 'ADM.Official'
	
-- ROL 
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'  

if not exists (select 1 from cobis..an_role_component where rc_co_id = @w_co_id and rc_rol = @w_rol)
	insert into cobis..an_role_component values (@w_co_id,@w_rol)
	
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
	insert into cobis..an_role_module values (@w_mo_id,@w_rol)
	
if not exists (select 1 from cobis..an_role_agent where ra_ag_id =@w_ag_id and ra_rol = @w_rol)
	insert into cobis..an_role_agent (ra_ag_id, ra_rol, ra_order) values (@w_ag_id,@w_rol, 1)
go