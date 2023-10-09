set nocount on
go
-- Script de instalacion de los servicios
use cobis
go

declare @w_rol int,
        @w_producto int


select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CREDITO'

----------------------------------------------------------------------------------
-- Instalacion de: DeviceRegistrationSERVImpl.getStatus
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'DeviceRegistrationSERVImpl.getStatus')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'DeviceRegistrationSERVImpl.getStatus'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'DeviceRegistrationSERVImpl.getStatus')
   delete cobis..cts_serv_catalog where csc_service_id = 'DeviceRegistrationSERVImpl.getStatus'


insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('DeviceRegistrationSERVImpl.getStatus','com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.serv.bsl.IDeviceRegistration',
       'getStatus',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('DeviceRegistrationSERVImpl.getStatus',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())



----------------------------------------------------------------------------------
-- Instalacion de: DeviceRegistrationSERVImpl.register
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'DeviceRegistrationSERVImpl.register')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'DeviceRegistrationSERVImpl.register'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'DeviceRegistrationSERVImpl.register')
   delete cobis..cts_serv_catalog where csc_service_id = 'DeviceRegistrationSERVImpl.register'


insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('DeviceRegistrationSERVImpl.register','com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.serv.bsl.IDeviceRegistration',
       'register',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('DeviceRegistrationSERVImpl.register',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())


----------------------------------------------------------------------------------
-- Instalacion de: WebTerminalValidationSERVImpl.validateTerminal
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'com.santander.commons.extlogin.LoginValidation')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'com.santander.commons.extlogin.LoginValidation'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'com.santander.commons.extlogin.LoginValidation')
   delete cobis..cts_serv_catalog where csc_service_id = 'com.santander.commons.extlogin.LoginValidation'


insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('com.santander.commons.extlogin.LoginValidation','com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.serv.bsl.IWebTerminalValidation',
       'validateTerminal',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('com.santander.commons.extlogin.LoginValidation',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())


set nocount off
go
