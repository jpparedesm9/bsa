use cob_cartera
go

IF OBJECT_ID ('dbo.ca_gen_ficha_pago_det') IS NOT NULL
	DROP TABLE dbo.ca_gen_ficha_pago_det
GO

IF OBJECT_ID ('ca_gen_ficha_pago') IS NOT NULL
	DROP TABLE ca_gen_ficha_pago
go

-------------->>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>
IF OBJECT_ID ('dbo.ca_notificacion_reporte') IS NOT NULL
	DROP TABLE dbo.ca_notificacion_reporte
GO

-------------->>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>
------------->>>>>>templates
use cobis
go

declare @w_codigo int

delete from cobis..ns_template where te_nombre = 'NotifGeneracionReportesPassword.xslt'

delete from cobis..ns_template where te_nombre = 'NotifGeneracionReportesDocumento.xslt'

go