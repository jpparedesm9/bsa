/***********************************************************************/
-- ROLLBACK TABLA CONSENTIMIENTO ZURICH - AUTO-ONBOARDING - REQ.168293--
/***********************************************************************/
use cob_cartera
go

if object_id ('dbo.ca_consentimiento_zurich') is not null
	drop table dbo.ca_consentimiento_zurich
go

