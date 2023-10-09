use cobis
go

declare
@w_ag_co_id int

if exists (select 1 from cobis..an_agent where ag_name = 'CEN.SharedLibrary')
	select @w_ag_co_id = ag_co_id from cobis..an_agent where ag_name = 'CEN.SharedLibrary'

if exists (select 1 from cobis..an_module where mo_id = (select co_mo_id from cobis..an_component where co_id = @w_ag_co_id))
begin
	if exists (select 1 from cobis..an_role_module where rm_mo_id = (select co_mo_id from cobis..an_component where co_id = @w_ag_co_id))
		delete from cobis..an_role_module where rm_mo_id = (select co_mo_id from cobis..an_component where co_id = @w_ag_co_id)
	
	delete from cobis..an_module where mo_id = (select co_mo_id from cobis..an_component where co_id = @w_ag_co_id)
end

if exists (select 1 from cobis..an_component where co_id = @w_ag_co_id)
begin
	if exists (select 1 from cobis..an_role_component where rc_co_id = @w_ag_co_id)
		delete from cobis..an_role_component where rc_co_id = @w_ag_co_id
		
	delete from cobis..an_component where co_id = @w_ag_co_id
end

if exists (select 1 from cobis..an_role_agent where ra_ag_id = (select ag_id from cobis..an_agent where ag_name = 'CEN.SharedLibrary'))
	delete from cobis..an_role_agent where ra_ag_id = (select ag_id from cobis..an_agent where ag_name = 'CEN.SharedLibrary')
	
if exists (select 1 from cobis..an_module_group where mg_name = 'CEN')
	delete from cobis..an_module_group where mg_name = 'CEN'

if exists (select 1 from cobis..an_agent where ag_name = 'CEN.SharedLibrary')
	delete from cobis..an_agent where ag_name = 'CEN.SharedLibrary'