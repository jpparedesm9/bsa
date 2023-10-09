USE cobis
GO

DELETE cts_serv_catalog WHERE csc_service_id IN ('BusinessToConsumer.RegistrationManagement.ValidateRegistration', 'BusinessToConsumer.RegistrationManagement.ValidateMail')
DELETE ad_servicio_autorizado WHERE ts_servicio  IN ('BusinessToConsumer.RegistrationManagement.ValidateRegistration', 'BusinessToConsumer.RegistrationManagement.ValidateMail')

GO

