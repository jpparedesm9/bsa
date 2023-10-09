/* SCRIPT DE VERSIONAMIENTO */

print 'VERSION ACTUAL'

select *
  from cobis..an_module_group
  where mg_name in ('CTA.Ahos.QueryBackOffice')

print 'ACTUALIZACION'

update cobis..an_module_group
  set mg_version = '4.0.6127.6282'
  where mg_name in ('CTA.Ahos.QueryBackOffice')

print 'VERSION NUEVA'

select *
  from cobis..an_module_group
  where mg_name in ('CTA.Ahos.QueryBackOffice')

go
