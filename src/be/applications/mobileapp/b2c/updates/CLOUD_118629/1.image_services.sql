use cobis
go
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
