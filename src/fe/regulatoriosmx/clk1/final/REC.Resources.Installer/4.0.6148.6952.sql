/* SCRIPT DE VERSIONAMIENTO */

print 'VERSION ACTUAL'

select *
  from cobis..an_module_group
  where mg_name in ('REC.Resources')

print 'ACTUALIZACION'

update cobis..an_module_group
  set mg_version = '4.0.6148.6952'
  where mg_name in ('REC.Resources')

print 'VERSION NUEVA'

select *
  from cobis..an_module_group
  where mg_name in ('REC.Resources')

go
