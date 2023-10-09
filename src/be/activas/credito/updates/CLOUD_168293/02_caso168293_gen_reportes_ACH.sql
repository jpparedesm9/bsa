use cob_credito
go

IF OBJECT_ID ('dbo.cr_reporte_on_boarding') IS NOT NULL
    DROP TABLE cr_reporte_on_boarding
go

create table cr_reporte_on_boarding(
    ra_cod_documento varchar(10),
	ra_nombre_archivo_jasper varchar(256),
	ra_nombre_archivo_presentar varchar(256),
	ra_est_gen char(1),
    ra_est_envio char(1),
    ra_toperacion varchar(10),
    ra_nombre_archivo_term varchar(10)
)
GO

--_buc_banco_fechaPro
--kYCAutoOnboard, caratulaCreditoSimpleAutoOnboard, contratoCredSimpleIndividualAutoOnboard, tablaAmortizacionSimpleIndAutoOnboard, ConsentimientoZurichSimpleIndAutoOnboard
insert into cr_reporte_on_boarding values ('100', 'contratoCredSimpleIndividualAutoOnboard.jasper', 'CONTRATO CRÉDITO SIMPLE', 'S', 'S', 'INDIVIDUAL','_cr')
insert into cr_reporte_on_boarding values ('101', 'tablaAmortizacionSimpleIndAutoOnboard.jasper', 'TABLA DE AMORTIZACIÓN TU CRÉDITO + NEGOCIO', 'S', 'S', 'INDIVIDUAL','_cr')
insert into cr_reporte_on_boarding values ('102', 'caratulaCreditoSimpleAutoOnboard.jasper', 'CARÁTULA CRÉDITO SIMPLE', 'S', 'S', 'INDIVIDUAL','_cr')
insert into cr_reporte_on_boarding values ('103', 'ConsentimientoZurichSimpleIndAutoOnboard.jasper', 'CERTIFICADO CONSENTIMIENTO', 'S', 'N', 'INDIVIDUAL','_cr')
insert into cr_reporte_on_boarding values ('104', 'kYCAutoOnboard.jasper', 'FORMULARIO KYC', 'S', 'N', 'INDIVIDUAL','_cr')
insert into cr_reporte_on_boarding values ('105', 'autorizacionBuroSimpleAutoOnboard.jasper', 'SOLICITUD AUTORIZACIÓN BURO DE CRÉDITO', 'S', 'N', 'INDIVIDUAL','_cr')

--- custumer -- codigo cliente (archivos)

-------------->>>>>>>>>>>>>-----CABECERA que clientes
use cob_credito
go

IF OBJECT_ID ('dbo.cr_cli_reporte_on_boarding') IS NOT NULL
    DROP TABLE cr_cli_reporte_on_boarding
go

create table cr_cli_reporte_on_boarding(
    co_ente int, -- relacionado con el otro    
	co_buc varchar(20),
	co_banco varchar(24), -- relacionado con el otro
	co_tramite int, -- relacionado con el otro
	co_email varchar(256),
	co_est_zip char(1), --- T terminado -- Proceso
	co_fecha_zip datetime, --- T terminado -- Proceso
	co_est_envio char(1),
	co_fecha_envio datetime,
	co_ruta_zip varchar(256),
	co_estd_clv_co varchar(1)
)
go

CREATE INDEX cr_cli_reporte_on_boarding_AKey1
    ON cr_cli_reporte_on_boarding (co_ente)
GO

CREATE UNIQUE INDEX cr_cli_reporte_on_boarding_AKey2
    ON cr_cli_reporte_on_boarding (co_ente, co_banco)
GO
-------------->>>>>>>>>>>>>----->>>>>DETALLE--que reportes deben generar
use cob_credito
go

IF OBJECT_ID ('dbo.cr_cli_reporte_on_boarding_det') IS NOT NULL
    DROP TABLE cr_cli_reporte_on_boarding_det
go

create table cr_cli_reporte_on_boarding_det(
    cod_ente int,
	cod_buc varchar(20),
	cod_banco varchar(24),
	cod_tramite int,
	cod_cod_documento varchar(10),
	cod_est_gen char(1),
    cod_fecha_gen datetime,
    cod_enviar_correo char(1),
	cod_ruta_gen varchar(256)
)
go

CREATE INDEX cr_cli_reporte_on_boarding_det_AKey1
    ON cr_cli_reporte_on_boarding_det (cod_ente)
GO

CREATE UNIQUE INDEX cr_cli_reporte_on_boarding_det_AKey2
    ON cr_cli_reporte_on_boarding_det (cod_ente, cod_banco, cod_cod_documento)
GO

------------->>>>>>templates
use cobis
go

declare @w_codigo int

delete from cobis..ns_template where te_nombre = 'NotifOnboardingPassword.xslt'
select @w_codigo = max(te_id) + 1 from cobis..ns_template
INSERT INTO cobis..ns_template (te_id,te_tipo,te_cultura,te_nombre,te_estado,te_version) 
VALUES(@w_codigo,'XSLT','NEUTRAL','NotifOnboardingPassword.xslt','A','1.0.0')

delete from cobis..ns_template where te_nombre = 'NotifOnboardingDocumento.xslt'
select @w_codigo = max(te_id) + 1 from cobis..ns_template
INSERT INTO cobis..ns_template (te_id,te_tipo,te_cultura,te_nombre,te_estado,te_version) 
VALUES(@w_codigo,'XSLT','NEUTRAL','NotifOnboardingDocumento.xslt','A','1.0.0')

go
