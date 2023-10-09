/* SCRIPT DE VERSIONAMIENTO */

print 'VERSION ACTUAL'

select *
  from cobis..an_module_group
  where mg_name in ('PER.Query')

print 'ACTUALIZACION'

update cobis..an_module_group
  set mg_version = '4.0.6100.9162'
  where mg_name in ('PER.Query')

print 'VERSION NUEVA'

select *
  from cobis..an_module_group
  where mg_name in ('PER.Query')

go
