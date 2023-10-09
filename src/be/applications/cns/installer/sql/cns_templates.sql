use cobis
go

declare @w_codigo int

delete from ns_template where te_nombre in (
'NotificacionesEC_ctas.xslt',
'CreacionLCR.xslt',
'Alerta_Respuesta.xslt',
'Alerta_Ampliacion_Plazo.xslt',
'Desviacion_Indicadores.xslt',
'GarantiaLiquida.xslt',
'NotificacionGeneral.xslt',
'PagoCorresponsal.xslt',
'NotificacionDescuento.xslt',
'report-file-process-success.xslt',
'report-file-process-fail.xslt',
'report-connection-ftp.xslt',
'report-ftp-without-files.xslt',
'NotifDesembolsosNoRealizados.xslt',
'NotifDesembolsosPendientes.xslt',
'NotifInterfacturaPassword.xslt',
'NotifInterfacturaEstadoCuenta.xslt',
'NotifRechazoTipo1.xslt',
'NotifRechazoTipo2.xslt',
'NotifRechazoTipo3.xslt',
'NotifNoCtaSantander.xslt',
'NotifOtorgamiento.xslt',
'NotificacionBiometrica.xslt',
'NotifOnboardingPassword.xslt',
'NotifOnboardingDocumento.xslt',
'NotifGeneracionReportesPassword.xslt',
'NotifGeneracionReportesDocumento.xslt'
)

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (1, 'XSLT', 'NEUTRAL', 'NotificacionesEC_ctas.xslt', 'A', '1.0.0.0')

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (5, 'XSLT', 'NEUTRAL', 'CreacionLCR.xslt', 'A', '1.0.0.0')

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (11, 'XSLT', 'NEUTRAL', 'Alerta_Respuesta.xslt', 'A', '1.0.0.0')

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (12, 'XSLT', 'NEUTRAL', 'Alerta_Ampliacion_Plazo.xslt', 'A', '1.0.0.0')

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (13, 'XSLT', 'NEUTRAL', 'Desviacion_Indicadores.xslt', 'A', '1.0.0.0')

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (14, 'XSLT', 'NEUTRAL', 'GarantiaLiquida.xslt', 'A', '1.0.0.0')

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (15, 'XSLT', 'NEUTRAL', 'NotificacionGeneral.xslt', 'A', '1.0.0.0')

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (16, 'XSLT', 'NEUTRAL', 'PagoCorresponsal.xslt', 'A', '1.0.0.0')

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (17, 'XSLT', 'NEUTRAL', 'NotificacionDescuento.xslt', 'A', '1.0.0.0')

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (1000, 'XSLT', '', 'report-file-process-success.xslt', 'A', '1.0.0')

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (1001, 'XSLT', '', 'report-file-process-fail.xslt', 'A', '1.0.0')

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (1002, 'XSLT', '', 'report-connection-ftp.xslt', 'A', '1.0.0')

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (1003, 'XSLT', '', 'report-ftp-without-files.xslt', 'A', '1.0.0')

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (1005, 'XSLT', '', 'NotifDesembolsosNoRealizados.xslt', 'A', '1.0.0')

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (1006, 'XSLT', '', 'NotifDesembolsosPendientes.xslt', 'A', '1.0.0')

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (1007, 'XSLT', '', 'NotifInterfacturaPassword.xslt', 'A', '1.0.0')

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (1008, 'XSLT', '', 'NotifInterfacturaEstadoCuenta.xslt', 'A', '1.0.0')

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (1009, 'XSLT', '', 'NotifRechazoTipo1.xslt', 'A', '1.0.0')

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (1010, 'XSLT', '', 'NotifRechazoTipo2.xslt', 'A', '1.0.0')

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (1011, 'XSLT', '', 'NotifRechazoTipo3.xslt', 'A', '1.0.0')

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (1012, 'XSLT', '', 'NotifNoCtaSantander.xslt', 'A', '1.0.0')

INSERT INTO ns_template (te_id, te_tipo, te_cultura, te_nombre, te_estado, te_version)
VALUES (1013, 'XSLT', '', 'NotifOtorgamiento.xslt', 'A', '1.0.0')

INSERT INTO cobis..ns_template (te_id,te_tipo,te_cultura,te_nombre,te_estado,te_version) 
VALUES(1016,'XSLT','','NotificacionBiometrica.xslt','A','1.0.0')

INSERT INTO cobis.ns_template (te_id,te_tipo,te_cultura,te_nombre,te_estado,te_version) VALUES
	 (1017,'XSLT','NEUTRAL','NotificacionBiometricaCLILCR.xslt','A','1.0.0.0');
	 
INSERT INTO cobis.ns_template (te_id,te_tipo,te_cultura,te_nombre,te_estado,te_version) VALUES
	 (1018,'XSLT','NEUTRAL','NotificacionBiometricaASELCR.xslt','A','1.0.0.0');

select @w_codigo = max(te_id) + 1 from cobis..ns_template
insert into cobis..ns_template (te_id,te_tipo,te_cultura,te_nombre,te_estado,te_version) 
values(@w_codigo,'XSLT','NEUTRAL','NotifOnboardingPassword.xslt','A','1.0.0')

select @w_codigo = max(te_id) + 1 from cobis..ns_template
insert into cobis..ns_template (te_id,te_tipo,te_cultura,te_nombre,te_estado,te_version) 
values(@w_codigo,'XSLT','NEUTRAL','NotifOnboardingDocumento.xslt','A','1.0.0')

select @w_codigo = max(te_id) + 1 from cobis..ns_template
insert into cobis..ns_template (te_id,te_tipo,te_cultura,te_nombre,te_estado,te_version) 
values(@w_codigo,'XSLT','NEUTRAL','NotifGeneracionReportePassword.xslt','A','1.0.0')

select @w_codigo = max(te_id) + 1 from cobis..ns_template
insert into cobis..ns_template (te_id,te_tipo,te_cultura,te_nombre,te_estado,te_version) 
values(@w_codigo,'XSLT','NEUTRAL','NotifGeneracionReporteDocumento.xslt','A','1.0.0')

GO