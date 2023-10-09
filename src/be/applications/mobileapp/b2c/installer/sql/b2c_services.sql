/* ************************************************************************** */
/*  Archivo:            b2c_services.sql                                      */
/*  Base de datos:      cobis                                                 */
/* ************************************************************************** */
/*              IMPORTANTE                                                    */
/*  Este programa es parte de los paquetes bancarios propiedad de             */
/*  "Cobiscorp".                                                              */
/*  Su uso no autorizado queda expresamente prohibido asi como                */
/*  cualquier alteracion o agregado hecho por alguno de sus                   */
/*  usuarios sin el debido consentimiento por escrito de la                   */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.                    */
/* ************************************************************************** */
/*              PROPOSITO                                                     */
/*  Creacion servicios Bussiness to custumer                                  */
/* ************************************************************************** */
/*              MODIFICACIONES                                                */
/* ************************************************************************** */
/* FECHA        VERSION       AUTOR              RAZON                        */
/* ************************************************************************** */
/* 29-Nov-2019                ERA            Emision Inicial B2C              */
/* ************************************************************************** */
use cobis
GO
declare @w_rol smallint, @w_moneda tinyint
   
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint  from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'

--Cambio de Contrase�a
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'MobileBanking.Service.Password.UpdateDefinitivePassword')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.businesstoconsumer.service.IPassword', csc_method_name = 'updateDefinitivePassword', csc_description = '', csc_trn = 17006, csc_procedure_validation = 'Y' WHERE csc_service_id = 'MobileBanking.Service.Password.UpdateDefinitivePassword'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) VALUES ('MobileBanking.Service.Password.UpdateDefinitivePassword', 'cobiscorp.ecobis.businesstoconsumer.service.IPassword', 'updateDefinitivePassword', '', 17006, 'Y')

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'MobileBanking.Service.Password.UpdateDefinitivePassword')
	UPDATE ad_servicio_autorizado set ts_rol = @w_rol, ts_producto =18 , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'MobileBanking.Service.Password.UpdateDefinitivePassword'
ELSE
	insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values('MobileBanking.Service.Password.UpdateDefinitivePassword', @w_rol, 18, 'R', @w_moneda, getdate(), 'V', getdate()) 


-- Enrolamiento
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'BusinessToConsumer.RegistrationManagement.EnrollClient')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.businesstoconsumer.service.IRegistrationManagement', csc_method_name = 'enrollClient', csc_description = '', csc_trn = 1890023, csc_procedure_validation = 'Y' WHERE csc_service_id = 'BusinessToConsumer.RegistrationManagement.EnrollClient'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) VALUES ('BusinessToConsumer.RegistrationManagement.EnrollClient', 'cobiscorp.ecobis.businesstoconsumer.service.IRegistrationManagement', 'enrollClient', '', 1890023, 'Y')

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'BusinessToConsumer.RegistrationManagement.EnrollClient')
	UPDATE ad_servicio_autorizado set ts_rol = @w_rol, ts_producto =18 , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'BusinessToConsumer.RegistrationManagement.EnrollClient'
ELSE
	insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values('BusinessToConsumer.RegistrationManagement.EnrollClient', @w_rol, 18, 'R', @w_moneda, getdate(), 'V', getdate()) 

  
-- Recuperacion de password    
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'MobileBanking.Service.Password.CreateDefinitivePassword')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.businesstoconsumer.service.IPassword', csc_method_name = 'createDefinitivePassword', csc_description = '', csc_trn = 17007, csc_procedure_validation = 'Y' WHERE csc_service_id = 'MobileBanking.Service.Password.CreateDefinitivePassword'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) VALUES ('MobileBanking.Service.Password.CreateDefinitivePassword', 'cobiscorp.ecobis.businesstoconsumer.service.IPassword', 'createDefinitivePassword', '', 17007, 'Y')

	
IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'MobileBanking.Service.Password.CreateDefinitivePassword')
	UPDATE ad_servicio_autorizado set ts_rol = @w_rol, ts_producto =18 , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'MobileBanking.Service.Password.CreateDefinitivePassword'
ELSE
	insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values('MobileBanking.Service.Password.CreateDefinitivePassword', @w_rol, 18, 'R', @w_moneda, getdate(), 'V', getdate()) 
go
	
--Registro de telefono
declare @w_rol smallint, @w_moneda tinyint
   
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint  from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
   
   
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'BusinessToConsumer.RegistrationManagement.CellphoneRegistration')
    UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.businesstoconsumer.service.IRegistrationManagement', csc_method_name = 'cellphoneRegistration', csc_description = '', csc_trn = 1890024, csc_procedure_validation = 'Y' WHERE csc_service_id = 'BusinessToConsumer.RegistrationManagement.CellphoneRegistration'
ELSE
    INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
    VALUES ('BusinessToConsumer.RegistrationManagement.CellphoneRegistration', 'cobiscorp.ecobis.businesstoconsumer.service.IRegistrationManagement', 'cellphoneRegistration', '', 1890024)

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'BusinessToConsumer.RegistrationManagement.CellphoneRegistration')
   UPDATE ad_servicio_autorizado set ts_rol = @w_rol, ts_producto =18 , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'BusinessToConsumer.RegistrationManagement.CellphoneRegistration'
ELSE
   insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
   values('BusinessToConsumer.RegistrationManagement.CellphoneRegistration', @w_rol, 7, 'R', @w_moneda, getdate(), 'V', getdate()) 
go

--
declare @w_rol smallint, @w_moneda tinyint
   
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint  from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
   
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'BusinessToConsumer.RegistrationManagement.RegistrationCodeValidation')
    UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.businesstoconsumer.service.IRegistrationManagement', csc_method_name = 'registrationCodeValidation', csc_description = '', csc_trn = 1890025, csc_procedure_validation = 'Y' WHERE csc_service_id = 'BusinessToConsumer.RegistrationManagement.RegistrationCodeValidation'
ELSE
    INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
    VALUES ('BusinessToConsumer.RegistrationManagement.RegistrationCodeValidation', 'cobiscorp.ecobis.businesstoconsumer.service.IRegistrationManagement', 'registrationCodeValidation', '', 1890025)

IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'BusinessToConsumer.RegistrationManagement.RegistrationCodeValidation')
   UPDATE ad_servicio_autorizado set ts_rol = @w_rol, ts_producto = 18 , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'BusinessToConsumer.RegistrationManagement.RegistrationCodeValidation'
ELSE
   insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
   values('BusinessToConsumer.RegistrationManagement.RegistrationCodeValidation', @w_rol, 7, 'R', @w_moneda, getdate(), 'V', getdate()) 
go

--Validacion Preguntas

declare @w_rol smallint, @w_moneda tinyint
   
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint  from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
   
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'BusinessToConsumer.RegistrationManagement.GenerateValidationQuestion')
    UPDATE cts_serv_catalog SET csc_class_name =  'cobiscorp.ecobis.businesstoconsumer.service.IRegistrationManagement', csc_method_name = 'generateValidationQuestion', csc_description = '', csc_trn = 1890026, csc_procedure_validation = 'Y' WHERE csc_service_id = 'BusinessToConsumer.RegistrationManagement.GenerateValidationQuestion'
ELSE
    INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
    VALUES ('BusinessToConsumer.RegistrationManagement.GenerateValidationQuestion', 'cobiscorp.ecobis.businesstoconsumer.service.IRegistrationManagement', 'generateValidationQuestion', '', 1890026)


IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'BusinessToConsumer.RegistrationManagement.GenerateValidationQuestion')
   UPDATE ad_servicio_autorizado set ts_rol = @w_rol, ts_producto = 18 , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'BusinessToConsumer.RegistrationManagement.GenerateValidationQuestion'
ELSE
    insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
    values('BusinessToConsumer.RegistrationManagement.GenerateValidationQuestion', @w_rol, 7, 'R', @w_moneda, getdate(), 'V', getdate()) 
go

--Validacion respuestas
declare @w_rol smallint, @w_moneda tinyint
   
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint  from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'BusinessToConsumer.RegistrationManagement.ValidateAnswers')
    UPDATE cts_serv_catalog SET csc_class_name =  'cobiscorp.ecobis.businesstoconsumer.service.IRegistrationManagement', csc_method_name = 'validateAnswers', csc_description = '', csc_trn = 1890027, csc_procedure_validation = 'Y' WHERE csc_service_id = 'BusinessToConsumer.RegistrationManagement.ValidateAnswers'
ELSE
    INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
    VALUES ('BusinessToConsumer.RegistrationManagement.ValidateAnswers', 'cobiscorp.ecobis.businesstoconsumer.service.IRegistrationManagement', 'validateAnswers', '', 1890027)


IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'BusinessToConsumer.RegistrationManagement.ValidateAnswers')
   UPDATE ad_servicio_autorizado set ts_rol = @w_rol, ts_producto = 18 , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'BusinessToConsumer.RegistrationManagement.GenerateValidationQuestion'
ELSE
    insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
    values('BusinessToConsumer.RegistrationManagement.ValidateAnswers', @w_rol, 7, 'R', @w_moneda, getdate(), 'V', getdate()) 
go

--Query Messages
declare @w_rol smallint, @w_moneda tinyint
   
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint  from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'BusinessToConsumer.MessageManagement.QueryMessages')
    UPDATE cts_serv_catalog SET csc_class_name =  'cobiscorp.ecobis.businesstoconsumer.service.IMessageManagement', csc_method_name = 'queryMessages', csc_description = '', csc_trn = 1890028, csc_procedure_validation = 'Y' WHERE csc_service_id = 'BusinessToConsumer.MessageManagement.QueryMessages'
ELSE
    INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
    VALUES ('BusinessToConsumer.MessageManagement.QueryMessages', 'cobiscorp.ecobis.businesstoconsumer.service.IMessageManagement', 'queryMessages', '', 1890028)


IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'BusinessToConsumer.MessageManagement.QueryMessages')
   UPDATE ad_servicio_autorizado set ts_rol = @w_rol, ts_producto = 18 , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'BusinessToConsumer.MessageManagement.QueryMessages'
ELSE
    insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
    values('BusinessToConsumer.MessageManagement.QueryMessages', @w_rol, 7, 'R', @w_moneda, getdate(), 'V', getdate()) 
go

--Execute Message
declare @w_rol smallint, @w_moneda tinyint
   
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint  from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'BusinessToConsumer.MessageManagement.ExecuteMessage')
    UPDATE cts_serv_catalog SET csc_class_name =  'cobiscorp.ecobis.businesstoconsumer.service.IMessageManagement', csc_method_name = 'executeMessage', csc_description = '', csc_trn = 1890029, csc_procedure_validation = 'Y' WHERE csc_service_id = 'BusinessToConsumer.MessageManagement.ExecuteMessage'
ELSE
    INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
    VALUES ('BusinessToConsumer.MessageManagement.ExecuteMessage', 'cobiscorp.ecobis.businesstoconsumer.service.IMessageManagement', 'executeMessage', '', 1890029)


IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'BusinessToConsumer.MessageManagement.ExecuteMessage')
   UPDATE ad_servicio_autorizado set ts_rol = @w_rol, ts_producto = 18 , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'BusinessToConsumer.MessageManagement.ExecuteMessage'
ELSE
    insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
    values('BusinessToConsumer.MessageManagement.ExecuteMessage', @w_rol, 7, 'R', @w_moneda, getdate(), 'V', getdate()) 
go


IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Channels.Token.Services.GenerateTokenUser')
UPDATE cts_serv_catalog SET csc_procedure_validation='Y', csc_class_name = 'com.cobiscorp.ecobis.admintoken.interfaces.IAdminTokenUser', csc_method_name = 'generateTokenUser', csc_description = '', csc_trn = 1875900 WHERE csc_service_id = 'Channels.Token.Services.GenerateTokenUser'
ELSE
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) VALUES ('Channels.Token.Services.GenerateTokenUser', 'com.cobiscorp.ecobis.admintoken.interfaces.IAdminTokenUser', 'generateTokenUser', '', 1875900, 'Y')
GO

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Channels.Token.Services.ValidateTokenUser')
UPDATE cts_serv_catalog SET csc_procedure_validation='Y', csc_class_name = 'com.cobiscorp.ecobis.admintoken.interfaces.IAdminTokenUser', csc_method_name = 'validateTokenUser', csc_description = '', csc_trn = 1875901 WHERE csc_service_id = 'Channels.Token.Services.ValidateTokenUser'
ELSE
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) VALUES ('Channels.Token.Services.ValidateTokenUser', 'com.cobiscorp.ecobis.admintoken.interfaces.IAdminTokenUser', 'validateTokenUser', '', 1875901, 'Y')
GO

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'BusinessToConsumer.RegistrationManagement.BlockingByClient')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.businesstoconsumer.service.IRegistrationManagement', csc_method_name = 'blockingByClient', csc_description = '', csc_trn = 1890030, csc_procedure_validation = 'Y' WHERE csc_service_id = 'BusinessToConsumer.RegistrationManagement.BlockingByClient'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) VALUES ('BusinessToConsumer.RegistrationManagement.BlockingByClient', 'cobiscorp.ecobis.businesstoconsumer.service.IRegistrationManagement', 'blockingByClient', '', 1890030, 'Y')
GO
    
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'BusinessToConsumer.RegistrationManagement.UnlockByClient')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.businesstoconsumer.service.IRegistrationManagement', csc_method_name = 'unlockByClient', csc_description = '', csc_trn = 1890031, csc_procedure_validation = 'Y' WHERE csc_service_id = 'BusinessToConsumer.RegistrationManagement.UnlockByClient'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) VALUES ('BusinessToConsumer.RegistrationManagement.UnlockByClient', 'cobiscorp.ecobis.businesstoconsumer.service.IRegistrationManagement', 'unlockByClient', '', 1890031, 'Y')
GO

-- Obtener Lista de Imagenes
declare @w_rol smallint, @w_moneda tinyint
   
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint  from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'InternetBanking.WebApp.Security.Service.Security.QueryLoginImageUX')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.businesstoconsumer.service.IImageManagement', csc_method_name = 'queryLoginImageUX', csc_description = '', csc_trn = 1800266 WHERE csc_service_id = 'InternetBanking.WebApp.Security.Service.Security.QueryLoginImageUX'
ELSE
    INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
	VALUES ('InternetBanking.WebApp.Security.Service.Security.QueryLoginImageUX', 'cobiscorp.ecobis.businesstoconsumer.service.IImageManagement', 'queryLoginImageUX', '', 1800266)

	
IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'InternetBanking.WebApp.Security.Service.Security.QueryLoginImageUX')
	UPDATE ad_servicio_autorizado set ts_rol = @w_rol, ts_producto =18 , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'InternetBanking.WebApp.Security.Service.Security.QueryLoginImageUX'
ELSE
	insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values('InternetBanking.WebApp.Security.Service.Security.QueryLoginImageUX', @w_rol, 18, 'R', @w_moneda, getdate(), 'V', getdate()) 
go

-- Grabar Imagen y Alias
declare @w_rol smallint, @w_moneda tinyint
   
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint  from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'InternetBanking.WebApp.Security.Service.Security.InsertLoginImage')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.businesstoconsumer.service.IImageManagement', csc_method_name = 'insertLoginImage', csc_description = '', csc_trn = 1800266 WHERE csc_service_id = 'InternetBanking.WebApp.Security.Service.Security.InsertLoginImage'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('InternetBanking.WebApp.Security.Service.Security.InsertLoginImage', 'cobiscorp.ecobis.businesstoconsumer.service.IImageManagement', 'insertLoginImage', '', 1800266)
	
IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'InternetBanking.WebApp.Security.Service.Security.InsertLoginImage')
	UPDATE ad_servicio_autorizado set ts_rol = @w_rol, ts_producto =18 , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'BusinessToConsumer.ImageManagement.InsertLoginImage'
ELSE
	insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values('InternetBanking.WebApp.Security.Service.Security.InsertLoginImage', @w_rol, 18, 'R', @w_moneda, getdate(), 'V', getdate()) 
go

-- Obtener Imagen por Login
declare @w_rol smallint, @w_moneda tinyint
   
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint  from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'InternetBanking.WebApp.Security.Service.Security.QueryLoginImage')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.businesstoconsumer.service.IImageManagement', csc_method_name = 'queryLoginImage', csc_description = '', csc_trn = 1800266 WHERE csc_service_id = 'InternetBanking.WebApp.Security.Service.Security.QueryLoginImage'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('InternetBanking.WebApp.Security.Service.Security.QueryLoginImage', 'cobiscorp.ecobis.businesstoconsumer.service.IImageManagement', 'queryLoginImage', '', 1800266)
	
IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = 'InternetBanking.WebApp.Security.Service.Security.QueryLoginImage')
	UPDATE ad_servicio_autorizado set ts_rol = @w_rol, ts_producto =18 , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'InternetBanking.WebApp.Security.Service.Security.QueryLoginImage'
ELSE
	insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values('InternetBanking.WebApp.Security.Service.Security.QueryLoginImage', @w_rol, 18, 'R', @w_moneda, getdate(), 'V', getdate()) 
go

-- Validar Correo electronico
declare @w_rol smallint, @w_moneda tinyint
   
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint  from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'BusinessToConsumer.RegistrationManagement.ValidateMail')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.businesstoconsumer.service.IRegistrationManagement', csc_method_name = 'validateMail', csc_description = '', csc_trn = 1890025 WHERE csc_service_id = 'BusinessToConsumer.RegistrationManagement.ValidateMail'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('BusinessToConsumer.RegistrationManagement.ValidateMail', 'cobiscorp.ecobis.businesstoconsumer.service.IRegistrationManagement', 'validateMail', '', 1890025)
	
IF EXISTS (SELECT * FROM ad_servicio_autorizado WHERE ts_servicio ='BusinessToConsumer.RegistrationManagement.ValidateMail')
	UPDATE ad_servicio_autorizado set ts_rol = @w_rol, ts_producto =18 , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'BusinessToConsumer.RegistrationManagement.ValidateMail'
ELSE
	insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values('BusinessToConsumer.RegistrationManagement.ValidateMail', @w_rol, 18, 'R', @w_moneda, getdate(), 'V', getdate()) 
go

-- Obtener Prestamos del cliente 
declare @w_rol smallint, @w_moneda tinyint
   
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'

if exists (select * from cts_serv_catalog where csc_service_id = 'BusinessToConsumer.OperationsInfo.QueryLoans')
	update cts_serv_catalog set csc_class_name = 'cobiscorp.ecobis.businesstoconsumer.service.IOperationsInfo', csc_method_name = 'queryLoans', csc_description = '', csc_trn = 9999 where csc_service_id = 'BusinessToConsumer.OperationsInfo.QueryLoans'
else
    insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
	values ('BusinessToConsumer.OperationsInfo.QueryLoans', 'cobiscorp.ecobis.businesstoconsumer.service.IOperationsInfo', 'queryLoans', '', 9999)

	
if exists (SELECT * FROM ad_servicio_autorizado where ts_servicio = 'BusinessToConsumer.OperationsInfo.QueryLoans')
	update ad_servicio_autorizado set ts_rol = @w_rol, ts_producto =18 , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'BusinessToConsumer.OperationsInfo.QueryLoans'
else
	insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values('BusinessToConsumer.OperationsInfo.QueryLoans', @w_rol, 18, 'R', @w_moneda, getdate(), 'V', getdate()) 

-- ======================== BusinessToConsumer.OperationsInfo.ApplyPayment ========================
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'BusinessToConsumer.OperationsInfo.ApplyPayment')
  UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.businesstoconsumer.service.IOperationsInfo', csc_method_name = 'applyPayment', csc_description = '', csc_trn = 9999 WHERE csc_service_id = 'BusinessToConsumer.OperationsInfo.ApplyPayment'
ELSE
  INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('BusinessToConsumer.OperationsInfo.ApplyPayment', 'cobiscorp.ecobis.businesstoconsumer.service.IOperationsInfo', 'applyPayment', '', 9999)

if exists (SELECT * FROM ad_servicio_autorizado where ts_servicio = 'BusinessToConsumer.OperationsInfo.ApplyPayment')
	update ad_servicio_autorizado set ts_rol = @w_rol, ts_producto =18 , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'BusinessToConsumer.OperationsInfo.ApplyPayment'
else
	insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values('BusinessToConsumer.OperationsInfo.ApplyPayment', @w_rol, 18, 'R', @w_moneda, getdate(), 'V', getdate()) 


--Requerimiento #158566
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

-- ======================== BusinessToConsumer.DisbursementCreditLineManagement.CreateKycForm ========================
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'BusinessToConsumer.DisbursementCreditLineManagement.CreateKycForm')
  UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.businesstoconsumer.service.IDisbursementCreditLineManagement', csc_method_name = 'createKycForm', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'BusinessToConsumer.DisbursementCreditLineManagement.CreateKycForm'
ELSE
  INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('BusinessToConsumer.DisbursementCreditLineManagement.CreateKycForm', 'cobiscorp.ecobis.businesstoconsumer.service.IDisbursementCreditLineManagement', 'createKycForm', '', 0)

if exists (SELECT * FROM ad_servicio_autorizado where ts_servicio = 'BusinessToConsumer.DisbursementCreditLineManagement.CreateKycForm')
	update ad_servicio_autorizado set ts_rol = @w_rol, ts_producto = 18 , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'BusinessToConsumer.DisbursementCreditLineManagement.CreateKycForm'
else
	insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
	values('BusinessToConsumer.DisbursementCreditLineManagement.CreateKycForm', @w_rol, 18, 'R', @w_moneda, getdate(), 'V', getdate())
go


-- ======================== IndividualLoan.OnBoarding.CreateLifeInsurance ========================
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'IndividualLoan.OnBoarding.CreateLifeInsurance')
  UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.individualloan.service.IOnBoarding', csc_method_name = 'createLifeInsurance', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'IndividualLoan.OnBoarding.CreateLifeInsurance'
ELSE
  INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('IndividualLoan.OnBoarding.CreateLifeInsurance', 'cobiscorp.ecobis.individualloan.service.IOnBoarding', 'createLifeInsurance', '', 0)


if exists (SELECT * FROM ad_servicio_autorizado where ts_servicio = 'IndividualLoan.OnBoarding.CreateLifeInsurance')
	update ad_servicio_autorizado set ts_rol = @w_rol, ts_producto =18 , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'IndividualLoan.OnBoarding.CreateLifeInsurance'
else
	insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
	values('IndividualLoan.OnBoarding.CreateLifeInsurance', @w_rol, 18, 'R', @w_moneda, getdate(), 'V', getdate())
go

-- ======================== IndividualLoan.OnBoarding.SimulationTableAmortization =====================================

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'IndividualLoan.OnBoarding.SimulationTableAmortization')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.individualloan.service.IOnBoarding', csc_method_name = 'simulationTableAmortization', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'IndividualLoan.OnBoarding.SimulationTableAmortization'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('IndividualLoan.OnBoarding.SimulationTableAmortization', 'cobiscorp.ecobis.individualloan.service.IOnBoarding', 'simulationTableAmortization', '', 0)

if exists (SELECT * FROM ad_servicio_autorizado where ts_servicio = 'IndividualLoan.OnBoarding.SimulationTableAmortization')
	update ad_servicio_autorizado set ts_rol = @w_rol, ts_producto =18 , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'IndividualLoan.OnBoarding.SimulationTableAmortization'
else
	insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values('IndividualLoan.OnBoarding.SimulationTableAmortization', @w_rol, 18, 'R', @w_moneda, getdate(), 'V', getdate()) 
GO

-- ======================== IndividualLoan.DisbursementManagement.DisbursementOperation =====================================
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'IndividualLoan.DisbursementManagement.DisbursementOperation')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.individualloan.service.IDisbursementManagement', csc_method_name = 'disbursementOperation', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'IndividualLoan.DisbursementManagement.DisbursementOperation'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('IndividualLoan.DisbursementManagement.DisbursementOperation', 'cobiscorp.ecobis.individualloan.service.IDisbursementManagement', 'disbursementOperation', '', 0)
      
if exists (SELECT * FROM ad_servicio_autorizado where ts_servicio = 'IndividualLoan.DisbursementManagement.DisbursementOperation')
	update ad_servicio_autorizado set ts_rol = @w_rol, ts_producto =18 , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'IndividualLoan.OnBoarding.SimulationTableAmortization'
else
	insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values('IndividualLoan.DisbursementManagement.DisbursementOperation', @w_rol, 18, 'R', @w_moneda, getdate(), 'V', getdate()) 
GO

--========================== ONBOARDING REQUERIMIENTO 168293 ================================
use cobis
go

declare 
@w_producto        int,
@w_rol             int

select @w_rol = ro_rol
from cobis..ad_rol
where ro_descripcion = 'MENU POR PROCESOS' 

select @w_producto = pd_producto 
from  cl_producto 
where pd_descripcion = 'BANCA VIRTUAL'

delete ad_servicio_autorizado where ts_servicio in 
('BusinessToConsumer.CustomerManagement.OnboardingRegister',
 'BusinessToConsumer.CustomerManagement.UpdateProspect', 
 'BusinessToConsumer.CustomerManagement.CreateAddress', 
 'BusinessToConsumer.CustomerManagement.SearchCustomer',
 'BusinessToConsumer.BioOnboardManagement.QueryOCRInfor',
 'BusinessToConsumer.BioOnboardManagement.QuerySCORESInfor',
 'BusinessToConsumer.OnboardingCreditManagement.CreateOperation')
delete cts_serv_catalog where csc_service_id in 
('BusinessToConsumer.CustomerManagement.OnboardingRegister',
 'BusinessToConsumer.CustomerManagement.UpdateProspect', 
 'BusinessToConsumer.CustomerManagement.CreateAddress', 
 'BusinessToConsumer.CustomerManagement.SearchCustomer',
 'BusinessToConsumer.BioOnboardManagement.QueryOCRInfor',
 'BusinessToConsumer.BioOnboardManagement.QuerySCORESInfor',
 'BusinessToConsumer.OnboardingCreditManagement.CreateOperation')

INSERT INTO cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES
('BusinessToConsumer.CustomerManagement.OnboardingRegister', 'cobiscorp.ecobis.businesstoconsumer.service.ICustomerManagement', 'onboardingRegister', '', 1721, NULL, NULL, 'Y')
INSERT INTO ad_servicio_autorizado
(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BusinessToConsumer.CustomerManagement.OnboardingRegister', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


INSERT INTO cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES
('BusinessToConsumer.CustomerManagement.UpdateProspect', 'cobiscorp.ecobis.businesstoconsumer.service.ICustomerManagement', 'updateProspect', '', 1722, NULL, NULL, 'Y')
INSERT INTO ad_servicio_autorizado
(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BusinessToConsumer.CustomerManagement.UpdateProspect', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


INSERT INTO cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES
('BusinessToConsumer.CustomerManagement.CreateAddress', 'cobiscorp.ecobis.businesstoconsumer.service.ICustomerManagement', 'createAddress', '', 1723, NULL, NULL, 'Y')
INSERT INTO ad_servicio_autorizado
(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BusinessToConsumer.CustomerManagement.CreateAddress', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


INSERT INTO cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES
('BusinessToConsumer.CustomerManagement.SearchCustomer', 'cobiscorp.ecobis.businesstoconsumer.service.ICustomerManagement', 'searchCustomer', '', 1724, NULL, NULL, 'Y')
INSERT INTO ad_servicio_autorizado
(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BusinessToConsumer.CustomerManagement.SearchCustomer', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-- ====================
-- Servicio: BusinessToConsumer.BioOnboardManagement.QueryOCRInfor
INSERT INTO cts_serv_catalog(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES('BusinessToConsumer.BioOnboardManagement.QueryOCRInfor', 'cobiscorp.ecobis.businesstoconsumer.service.IBioOnboardManagement', 'queryOCRInfor', '', 0, NULL, NULL, 'Y')

INSERT INTO ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BusinessToConsumer.BioOnboardManagement.QueryOCRInfor', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-- Servicio: BusinessToConsumer.BioOnboardManagement.QuerySCORESInfor
INSERT INTO cts_serv_catalog(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES('BusinessToConsumer.BioOnboardManagement.QuerySCORESInfor', 'cobiscorp.ecobis.businesstoconsumer.service.IBioOnboardManagement', 'querySCORESInfor', '', 0, NULL, NULL, 'Y')

INSERT INTO ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BusinessToConsumer.BioOnboardManagement.QuerySCORESInfor', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

--Servicio: BusinessToConsumer.OnboardingCreditManagement.CreateOperation
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('BusinessToConsumer.OnboardingCreditManagement.CreateOperation', 'cobiscorp.ecobis.businesstoconsumer.service.IOnboardingCreditManagement', 'createOperation', '', 0, NULL, NULL, NULL)

INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BusinessToConsumer.OnboardingCreditManagement.CreateOperation', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

go
