use cobis
go

update cobis..an_module_group
set mg_version = '4.0.6892.6601'
where upper(mg_name) like '%CON.%'

GO

