use cobis
go

delete from cobis..cl_parametro where pa_nemonico in ('CRSIAO', 'PRSIAO', 'PCTSIO')

insert into cobis..cl_parametro values ('CONDUSEF REPORTE SIMPLE INDIVIDUAL AUTO-ONBOARDING', 'CRSIAO', 'C', '14795-439-034696/02-00349-0122', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
insert into cobis..cl_parametro values ('PIE REPORTE SIMPLE INDIVIDUAL AUTO-ONBOARDING', 'PRSIAO', 'C', 'IF-041 (032022)', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
insert into cobis..cl_parametro values ('PIE CONTRATO TAB-AMORT REPORTE SIMPLE INDIVIDUAL AUTO-ONBOARDING', 'PCTSIO', 'C', 'IF-038 (032022)', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

go
