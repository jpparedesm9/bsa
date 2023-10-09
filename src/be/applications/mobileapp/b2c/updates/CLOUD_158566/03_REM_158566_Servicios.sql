USE cobis
GO

DECLARE @w_rol INT, @w_producto int

SELECT @w_rol = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'MENU POR PROCESOS'
SELECT @w_producto = pd_producto FROM cobis..cl_producto WHERE pd_descripcion = 'BANCA VIRTUAL'

DELETE cts_serv_catalog WHERE csc_service_id IN ('BusinessToConsumer.RegistrationManagement.ValidateRegistration', 'BusinessToConsumer.RegistrationManagement.ValidateMail')
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('BusinessToConsumer.RegistrationManagement.ValidateRegistration', 'cobiscorp.ecobis.businesstoconsumer.service.IRegistrationManagement', 'validateRegistration', '', 1890025, NULL, NULL, NULL)

DELETE ad_servicio_autorizado WHERE ts_servicio  IN ('BusinessToConsumer.RegistrationManagement.ValidateRegistration', 'BusinessToConsumer.RegistrationManagement.ValidateMail')

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('BusinessToConsumer.RegistrationManagement.ValidateRegistration', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
GO

