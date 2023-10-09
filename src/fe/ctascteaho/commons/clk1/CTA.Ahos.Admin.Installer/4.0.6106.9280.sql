/* SCRIPT DE VERSIONAMIENTO */

print 'VERSION ACTUAL'

select *
  from cobis..an_module_group
  where mg_name in ('CTA.Ahos.Admin')

print 'ACTUALIZACION'

update cobis..an_module_group
  set mg_version = '4.0.6106.9280'
  where mg_name in ('CTA.Ahos.Admin')

print 'VERSION NUEVA'

select *
  from cobis..an_module_group
  where mg_name in ('CTA.Ahos.Admin')

go
