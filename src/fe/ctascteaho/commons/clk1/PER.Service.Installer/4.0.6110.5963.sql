/* SCRIPT DE VERSIONAMIENTO */

print 'VERSION ACTUAL'

select *
  from cobis..an_module_group
  where mg_name in ('PER.Service')

print 'ACTUALIZACION'

update cobis..an_module_group
  set mg_version = '4.0.6110.5963'
  where mg_name in ('PER.Service')

print 'VERSION NUEVA'

select *
  from cobis..an_module_group
  where mg_name in ('PER.Service')

go
