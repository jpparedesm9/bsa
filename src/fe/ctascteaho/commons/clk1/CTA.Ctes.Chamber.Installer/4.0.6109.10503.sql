/* SCRIPT DE VERSIONAMIENTO */

print 'VERSION ACTUAL'

select *
  from cobis..an_module_group
  where mg_name in ('CTA.Ctes.Chamber')

print 'ACTUALIZACION'

update cobis..an_module_group
  set mg_version = '4.0.6109.10503'
  where mg_name in ('CTA.Ctes.Chamber')

print 'VERSION NUEVA'

select *
  from cobis..an_module_group
  where mg_name in ('CTA.Ctes.Chamber')

go
