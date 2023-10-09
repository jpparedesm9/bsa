use cobis
go

delete
from an_module 	where mo_mg_id in (select mg_id from cobis..an_module_group 
								  where mg_name = 'COBISCorp.tCOBIS.Utils.Official')
				and mo_id not in (select co_mo_id from an_component where co_name = 'ADM.Official')


update an_module_group
set mg_location = 'http://[servername]/COBISCorp.tCOBIS.Utils.Official.Installer/COBISCorp.tCOBIS.Utils.Official.Installer.application'
where mg_name = 'COBISCorp.tCOBIS.Utils.Official'

go