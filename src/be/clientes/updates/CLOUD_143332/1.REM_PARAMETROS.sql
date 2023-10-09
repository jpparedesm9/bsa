use cobis
go


delete from cobis..cl_parametro where pa_nemonico in ('ESCB','ECCB','NDCB')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ENVIO SMS CONTRATACION BIOMETRICO', 'ESCB', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ENVIO CORREO CONTRATACION BIOMETRICO', 'ECCB', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE CONTACTO BIOMETRICO', 'NDCB', 'C', '5551694363', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
GO

declare @w_codigo int

delete from cobis..ns_template where te_nombre = 'NotificacionBiometrica.xslt'
select @w_codigo = max(te_id) + 1 from cobis..ns_template
INSERT INTO cobis..ns_template (te_id,te_tipo,te_cultura,te_nombre,te_estado,te_version) 
VALUES(@w_codigo,'XSLT','','NotificacionBiometrica.xslt','A','1.0.0')
GO