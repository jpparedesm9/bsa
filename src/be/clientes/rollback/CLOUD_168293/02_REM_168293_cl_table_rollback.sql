/****************************************************/
-- ROLLBACK TABLA FORMULARIO KYC - AUTO-ONBOARDING --
/****************************************************/
use cobis
go

if object_id ('dbo.cl_auto_onboard_form_kyc') is not null
	drop table dbo.cl_auto_onboard_form_kyc
go

if exists (select name from sysindexes where name='iko_ente')
	drop index cl_auto_onboard_form_kyc.iko_ente
go
