/* SCRIPT DE VERSIONAMIENTO */

print 'VERSION ACTUAL'

select *
  from cobis..an_module_group
  where mg_name in ('CTA.Cte.Chamber')

print 'ACTUALIZACION'

update cobis..an_module_group
  set mg_version = '4.0.6074.5713'
  where mg_name in ('CTA.Cte.Chamber')

print 'VERSION NUEVA'

select *
  from cobis..an_module_group
  where mg_name in ('CTA.Cte.Chamber')

go
