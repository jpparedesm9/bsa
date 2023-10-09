/* SCRIPT DE VERSIONAMIENTO */

print 'VERSION ACTUAL'

select *
  from cobis..an_module_group
  where mg_name in ('PER.SharedLibrary')

print 'ACTUALIZACION'

update cobis..an_module_group
  set mg_version = '4.0.6109.6563'
  where mg_name in ('PER.SharedLibrary')

print 'VERSION NUEVA'

select *
  from cobis..an_module_group
  where mg_name in ('PER.SharedLibrary')

go
