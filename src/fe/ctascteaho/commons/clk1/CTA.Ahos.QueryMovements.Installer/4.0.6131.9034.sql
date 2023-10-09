/* SCRIPT DE VERSIONAMIENTO */

print 'VERSION ACTUAL'

select *
  from cobis..an_module_group
  where mg_name in ('CTA.Ahos.QueryMovements')

print 'ACTUALIZACION'

update cobis..an_module_group
  set mg_version = '4.0.6131.9034'
  where mg_name in ('CTA.Ahos.QueryMovements')

print 'VERSION NUEVA'

select *
  from cobis..an_module_group
  where mg_name in ('CTA.Ahos.QueryMovements')

go
