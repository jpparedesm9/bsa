/* SCRIPT DE VERSIONAMIENTO */

print 'VERSION ACTUAL'

select *
  from cobis..an_module_group
  where mg_name in ('CTA.Ahos.QueryBalances')

print 'ACTUALIZACION'

update cobis..an_module_group
  set mg_version = '4.0.6136.9303'
  where mg_name in ('CTA.Ahos.QueryBalances')

print 'VERSION NUEVA'

select *
  from cobis..an_module_group
  where mg_name in ('CTA.Ahos.QueryBalances')

go
