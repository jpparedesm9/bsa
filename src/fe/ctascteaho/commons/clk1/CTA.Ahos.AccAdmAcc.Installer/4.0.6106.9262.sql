/* SCRIPT DE VERSIONAMIENTO */

print 'VERSION ACTUAL'

select *
  from cobis..an_module_group
  where mg_name in ('CTA.Ahos.AccAdmAcc')

print 'ACTUALIZACION'

update cobis..an_module_group
  set mg_version = '4.0.6106.9262'
  where mg_name in ('CTA.Ahos.AccAdmAcc')

print 'VERSION NUEVA'

select *
  from cobis..an_module_group
  where mg_name in ('CTA.Ahos.AccAdmAcc')

go
