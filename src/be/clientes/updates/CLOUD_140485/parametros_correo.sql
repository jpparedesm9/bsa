/*
*     REQ#140485 Face 2
*/

INSERT INTO cobis..cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_char,pa_tinyint,pa_smallint,pa_int,pa_money,pa_datetime,pa_float,pa_producto) VALUES
	 ('ENVIA CORREO LCR','CLCR  ','C','S',NULL,NULL,NULL,NULL,NULL,NULL,'CLI');
INSERT INTO cobis..ns_template (te_id,te_tipo,te_cultura,te_nombre,te_estado,te_version) VALUES
	 (1017,'XSLT','NEUTRAL','NotificacionBiometricaCLILCR.xslt','A','1.0.0.0');
INSERT INTO cobis..ns_template (te_id,te_tipo,te_cultura,te_nombre,te_estado,te_version) VALUES
	 (1018,'XSLT','NEUTRAL','NotificacionBiometricaASELCR.xslt','A','1.0.0.0');