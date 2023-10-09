use cob_credito
go

IF OBJECT_ID ('dbo.cr_reporte_on_boarding') IS NOT NULL
    DROP TABLE cr_reporte_on_boarding
go
-------------->>>>>>>>>>>>>-----CABECERA que clientes
IF OBJECT_ID ('dbo.cr_cli_reporte_on_boarding') IS NOT NULL
    DROP TABLE cr_cli_reporte_on_boarding
go

IF OBJECT_ID ('dbo.cr_cli_reporte_on_boarding_det') IS NOT NULL
    DROP TABLE cr_cli_reporte_on_boarding_det
go
------------->>>>>>templates
delete from cobis..ns_template where te_nombre = 'NotifOnboardingPassword.xslt'
delete from cobis..ns_template where te_nombre = 'NotifOnboardingDocumento.xslt'

go
