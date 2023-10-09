use cobis
go

delete cobis..ad_pro_transaccion
 where  pt_producto = 10
 and pt_transaccion = 607
 and pt_procedure = 630

INSERT INTO dbo.ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (10, 'R', 0, 607, 'V', getdate(), 630, NULL)
GO

delete cobis..ad_procedure
where pd_base_datos = 'cob_remesas'
and pd_procedure = 630
GO

INSERT INTO dbo.ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (630, 'sp_rem_cons_chq_eofi', 'cob_remesas', 'V', getdate(), 'remconcheof.sp')
GO


