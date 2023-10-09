/***********************************************************************/
-- CREACION TABLA CONSENTIMIENTO ZURICH - AUTO-ONBOARDING - REQ.168293--
/***********************************************************************/
use cob_cartera
go

if object_id ('dbo.ca_consentimiento_zurich') is not null
	drop table dbo.ca_consentimiento_zurich
go

create table ca_consentimiento_zurich (
	cz_nombre      varchar(200),
	cz_rfc         varchar(25),
	cz_fechanac    date,
	cz_domicilio   varchar(500),
	cz_colonia     varchar(50),
	cz_codigo      varchar(20),
	cz_email       varchar(200),
	cz_certificado varchar(100),
	cz_fechaini    date,
	cz_fechafin    date,
	cz_poliza      varchar(50),
	cz_contratante varchar(100),
	cz_rfccontra   varchar(25),
	cz_cliente     int,
	cz_primaneta   money,
	cz_derechos    money,
	cz_recargo     money,
	cz_primatotal  money,
	cz_razonsocial varchar(500),
	cz_fechaemi    date,
	cz_meses       int,
	cz_tramite     int
)
go
