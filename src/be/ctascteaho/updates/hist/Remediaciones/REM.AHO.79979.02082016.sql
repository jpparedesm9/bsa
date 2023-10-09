use cobis
go

delete cobis..ad_pro_transaccion
 where  pt_producto = 10
 and pt_transaccion in (429,602,606,407,447)
 and pt_procedure in (423,472,630,406,436)
 
INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 429, 'V', '2016-07-29 15:11:34.29', 423, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 602, 'V', '2016-07-29 15:11:34.293', 472, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 606, 'V', '2016-07-29 15:11:34.3', 630, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 407, 'V', '2016-07-29 15:11:34.27', 406, NULL)
GO

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 447, 'V', '2016-07-29 15:11:34.273', 436, NULL)
GO

delete cobis..ad_procedure
where pd_base_datos = 'cob_remesas'
and pd_procedure in (423,472,630,406,436)
GO

INSERT INTO cobis..ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (423, 'sp_rem_chequexofi', 'cob_remesas', 'V', '2016-07-29 15:01:21.447', 'remcheqxofi.sp')
GO

INSERT INTO cobis..ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (472, 'sp_cons_carta_remesas', 'cob_remesas', 'V', '2016-07-29 15:01:21.48', 'recocart.sp')
GO

INSERT INTO cobis..ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (630, 'sp_rem_cons_chq_eofi', 'cob_remesas', 'V', '2016-07-29 15:01:21.447', 'remconcheof.sp')
GO

INSERT INTO cobis..ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (406, 'sp_rem_consulcar', 'cob_remesas', 'V', '2016-07-29 15:01:21.443', 'remconscar.sp')
GO

INSERT INTO cobis..ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (436, 'sp_rem_ayuda', 'cob_remesas', 'V', '2016-07-29 15:01:21.44', 'remayuda.sp')
GO



