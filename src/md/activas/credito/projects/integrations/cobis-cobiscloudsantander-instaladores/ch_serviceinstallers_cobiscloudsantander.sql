set nocount on
go
-- Script de instalacion de los servicios
use cobis
go


----------------------------------------------------------------------------------
-- Instalacion de: CobisRegisterServiceSERVImpl.registerCustomerInformation
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'CobisRegisterServiceSERVImpl.registerCustomerInformation')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'CobisRegisterServiceSERVImpl.registerCustomerInformation'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'CobisRegisterServiceSERVImpl.registerCustomerInformation')
   delete cobis..cts_serv_catalog where csc_service_id = 'CobisRegisterServiceSERVImpl.registerCustomerInformation'
go

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('CobisRegisterServiceSERVImpl.registerCustomerInformation','com.cobiscorp.ecobis.cobiscloudsantander.bsl.serv.bsl.ICobisRegisterService',
       'registerCustomerInformation',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('CobisRegisterServiceSERVImpl.registerCustomerInformation',1,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('CobisRegisterServiceSERVImpl.registerCustomerInformation',3,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('CobisRegisterServiceSERVImpl.registerCustomerInformation',4,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('CobisRegisterServiceSERVImpl.registerCustomerInformation',5,1,'R',0,getdate(),'V',getdate())
go



----------------------------------------------------------------------------------
-- Instalacion de: SantanderCoreServiceSERVImpl.getCustomerInformation
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'SantanderCoreServiceSERVImpl.getCustomerInformation')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'SantanderCoreServiceSERVImpl.getCustomerInformation'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'SantanderCoreServiceSERVImpl.getCustomerInformation')
   delete cobis..cts_serv_catalog where csc_service_id = 'SantanderCoreServiceSERVImpl.getCustomerInformation'
go

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('SantanderCoreServiceSERVImpl.getCustomerInformation','com.cobiscorp.ecobis.cobiscloudsantander.bsl.serv.bsl.ISantanderCoreService',
       'getCustomerInformation',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('SantanderCoreServiceSERVImpl.getCustomerInformation',1,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('SantanderCoreServiceSERVImpl.getCustomerInformation',3,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('SantanderCoreServiceSERVImpl.getCustomerInformation',4,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('SantanderCoreServiceSERVImpl.getCustomerInformation',5,1,'R',0,getdate(),'V',getdate())
go


set nocount off
go
