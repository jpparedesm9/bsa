/* SCRIPT DE VERSIONAMIENTO */

print 'VERSION ACTUAL'

select *
  from cobis..an_module_group
  where mg_name in ('CTA.Ahos.Query')

print 'ACTUALIZACION'

update cobis..an_module_group
  set mg_version = '4.0.6131.9035'
  where mg_name in ('CTA.Ahos.Query')

print 'VERSION NUEVA'

select *
  from cobis..an_module_group
  where mg_name in ('CTA.Ahos.Query')

go
