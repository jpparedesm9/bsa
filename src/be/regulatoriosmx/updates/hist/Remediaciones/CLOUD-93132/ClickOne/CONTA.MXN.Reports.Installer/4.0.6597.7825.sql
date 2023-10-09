/* SCRIPT DE VERSIONAMIENTO */

print 'VERSION ACTUAL'

select *
  from cobis..an_module_group
  where mg_name in ('CON.MXN.resources', 'CON.MXN.SharedLibrary', 'CON.MXN.Reports')

print 'ACTUALIZACION'

update cobis..an_module_group
  set mg_version = '4.0.6597.7825'
  where mg_name in ('CON.MXN.resources', 'CON.MXN.SharedLibrary', 'CON.MXN.Reports')

print 'VERSION NUEVA'

select *
  from cobis..an_module_group
  where mg_name in ('CON.MXN.resources', 'CON.MXN.SharedLibrary', 'CON.MXN.Reports')

go
