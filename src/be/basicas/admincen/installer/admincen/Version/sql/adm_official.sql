use cobis
go

declare @w_return int,
		@w_rol int,
		@s_ruta varchar(200)

select @w_rol = min(ro_rol)
from ad_rol
where ro_descripcion = 'MENU POR PROCESOS'

delete an_role_install where ri_prod_name = 'M-ADM.Util'
if not exists (select 1 from an_role_install where ri_prod_name = 'M-ADM.Util')
    insert into an_role_install values ('M-ADM.Util', @w_rol)

exec @w_return =sp_cen_catalogar
    @i_opcion               = 'MOD',
    @i_role                 = @w_rol,
    @i_prod_name            = 'M-ADM.Util',
    @i_module_group         = 'COBISCorp.tCOBIS.Utils.Official',
    @i_version              = '4.0.0.0',
    @i_zone                 = 'DefaultPorting 100x100',
    @i_module               = 'ADM.Official',
    @i_label_module         = 'ADM.Official',
    @i_namespace_component  = 'COBISCorp.tCOBIS.Utils.OfficialSearch'
    if @w_return <> 0
        print 'Error Creando MOD:ADM.Official'

set @s_ruta='http://[servername]/'

UPDATE an_module_group 
SET mg_location=@s_ruta+'Utils/Utils.application', mg_version = '4.6.1.0'
WHERE mg_name = 'COBISCorp.tCOBIS.Utils.Official'
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
if not exists (select 1 from an_label where la_label = 'ADM.Official')
begin
	select @w_la_id = isnull(max(la_id), 0)+1 from an_label
	insert into an_label (la_id, la_cod, la_label, la_prod_name )
	values (@w_la_id, 'ES_EC', 'ADM.Official','M-ADM.Util')
end
else
	select @w_la_id = la_id from an_label where la_label = 'ADM.Official' 

if not exists (select 1 from an_module_group where mg_name = 'COBISCorp.tCOBIS.Utils.Official')
begin	
	select @w_mg_id = isnull(max(mg_id),0)+1 from an_module_group
	insert into an_module_group (mg_id, mg_name, mg_version,  mg_location, mg_store_name)
	values (@w_mg_id, 'COBISCorp.tCOBIS.Utils.Official', '1.0.0.0', 'http://[servername]/Utils/Utils.application', 'COBISExplorer')
end
else
	select @w_mg_id = mg_id from an_module_group where mg_name = 'COBISCorp.tCOBIS.Utils.Official'
	
if not exists (select 1 from an_module where mo_name = 'ADM.Official')
begin
	select @w_mo_id = isnull(max(mo_id),0)+1 from an_module
	insert into an_module (mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token)
	values (@w_mo_id,@w_mg_id, @w_la_id, 'ADM.Official', 'COBISCorp.tCOBIS.Utils.OfficialSearch.dll', 0  ,null)
end
else
	select @w_mo_id = mo_id from an_module where mo_name = 'ADM.Official'

if not exists (select 1 from an_component where co_name = 'ADM.Official')
begin
	select @w_co_id = isnull(max(co_id),0)+1 from an_component
	insert into an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name )
	values (@w_co_id,  @w_mo_id, 'ADM.Official',  'COBISAgentOfficialDescarga', 'COBISCorp.tCOBIS.Utils.Official','A',null,'M-ADM.Util')
end
else
	select @w_co_id = co_id from an_component where co_name = 'ADM.Official'
	
if not exists (select 1 from an_agent where ag_name = 'ADM.Official')
begin
	select @w_ag_id = isnull(max(ag_id),0)+1 from an_agent
	insert into an_agent (ag_id, ag_co_id, ag_name, ag_la_id )
	values (@w_ag_id, @w_co_id, 'ADM.Official', @w_la_id)
end
else
	select @w_ag_id = ag_id from an_agent where ag_name = 'ADM.Official'
	
-- ROL 
select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'  

if not exists (select 1 from an_role_component where rc_co_id = @w_co_id and rc_rol = @w_rol)
	insert into an_role_component values (@w_co_id,@w_rol)
	
if not exists (select 1 from an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
	insert into an_role_module values (@w_mo_id,@w_rol)
	
if not exists (select 1 from an_role_agent where ra_ag_id =@w_ag_id and ra_rol = @w_rol)
	insert into an_role_agent (ra_ag_id, ra_rol, ra_order) values (@w_ag_id,@w_rol, 1)
go