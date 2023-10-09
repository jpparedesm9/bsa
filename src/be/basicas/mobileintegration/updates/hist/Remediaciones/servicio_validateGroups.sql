INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('Businessprocess.Creditmanagement.ApplicationManagment.ValidateGroup', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', 'validateGroup', '', 800, NULL, NULL, NULL)
GO


INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('Businessprocess.Creditmanagement.ApplicationManagment.ValidateGroup', 3, 2, 'R', 0, '11/02/2017 04:53:03', 'V', '11/02/2017 04:53:03')
GO
