use cobis
go

declare @w_codigo int

delete from cobis..ns_template where te_nombre = 'NotifInterfacturaPasswordRest.xslt'
select @w_codigo = max(te_id) + 1 from cobis..ns_template
INSERT INTO cobis..ns_template (te_id,te_tipo,te_cultura,te_nombre,te_estado,te_version) 
VALUES(@w_codigo,'XSLT','NEUTRAL','NotifInterfacturaPasswordRest.xslt','A','1.0.0')

delete from cobis..ns_template where te_nombre = 'NotifInterfacturaEstadoCuentaRest.xslt'
select @w_codigo = max(te_id) + 1 from cobis..ns_template
INSERT INTO cobis..ns_template (te_id,te_tipo,te_cultura,te_nombre,te_estado,te_version) 
VALUES(@w_codigo,'XSLT','NEUTRAL','NotifInterfacturaEstadoCuentaRest.xslt','A','1.0.0')

go
