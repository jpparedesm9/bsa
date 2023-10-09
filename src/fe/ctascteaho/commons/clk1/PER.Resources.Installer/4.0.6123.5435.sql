/* SCRIPT DE VERSIONAMIENTO */

print 'VERSION ACTUAL'

select *
  from cobis..an_module_group
  where mg_name in ('PER.Resources')

print 'ACTUALIZACION'

update cobis..an_module_group
  set mg_version = '4.0.6123.5435'
  where mg_name in ('PER.Resources')

print 'VERSION NUEVA'

select *
  from cobis..an_module_group
  where mg_name in ('PER.Resources')

go
