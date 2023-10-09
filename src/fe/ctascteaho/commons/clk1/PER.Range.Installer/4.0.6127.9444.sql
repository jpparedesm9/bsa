/* SCRIPT DE VERSIONAMIENTO */

print 'VERSION ACTUAL'

select *
  from cobis..an_module_group
  where mg_name in ('PER.Range')

print 'ACTUALIZACION'

update cobis..an_module_group
  set mg_version = '4.0.6127.9444'
  where mg_name in ('PER.Range')

print 'VERSION NUEVA'

select *
  from cobis..an_module_group
  where mg_name in ('PER.Range')

go
