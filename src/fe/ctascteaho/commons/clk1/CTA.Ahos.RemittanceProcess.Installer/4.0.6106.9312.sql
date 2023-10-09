/* SCRIPT DE VERSIONAMIENTO */

print 'VERSION ACTUAL'

select *
  from cobis..an_module_group
  where mg_name in ('CTA.Ahos.RemittanceProcess')

print 'ACTUALIZACION'

update cobis..an_module_group
  set mg_version = '4.0.6106.9312'
  where mg_name in ('CTA.Ahos.RemittanceProcess')

print 'VERSION NUEVA'

select *
  from cobis..an_module_group
  where mg_name in ('CTA.Ahos.RemittanceProcess')

go
