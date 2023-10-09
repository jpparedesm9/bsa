set nocount on
go
-- Script de instalacion de los servicios
use cobis
go


----------------------------------------------------------------------------------
-- Instalacion de: CustomerServiceSERVImpl.findCustomerById
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'CustomerServiceSERVImpl.findCustomerById')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'CustomerServiceSERVImpl.findCustomerById'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'CustomerServiceSERVImpl.findCustomerById')
   delete cobis..cts_serv_catalog where csc_service_id = 'CustomerServiceSERVImpl.findCustomerById'
go

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('CustomerServiceSERVImpl.findCustomerById','com.cobiscorp.ecobis.cobiscloudparty.bsl.serv.bsl.ICustomerService',
       'findCustomerById',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('CustomerServiceSERVImpl.findCustomerById',1,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('CustomerServiceSERVImpl.findCustomerById',3,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('CustomerServiceSERVImpl.findCustomerById',4,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('CustomerServiceSERVImpl.findCustomerById',5,1,'R',0,getdate(),'V',getdate())
go



----------------------------------------------------------------------------------
-- Instalacion de: CustomerServiceSERVImpl.getDelayGroupDays
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'CustomerServiceSERVImpl.getDelayGroupDays')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'CustomerServiceSERVImpl.getDelayGroupDays'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'CustomerServiceSERVImpl.getDelayGroupDays')
   delete cobis..cts_serv_catalog where csc_service_id = 'CustomerServiceSERVImpl.getDelayGroupDays'
go

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('CustomerServiceSERVImpl.getDelayGroupDays','com.cobiscorp.ecobis.cobiscloudparty.bsl.serv.bsl.ICustomerService',
       'getDelayGroupDays',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('CustomerServiceSERVImpl.getDelayGroupDays',1,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('CustomerServiceSERVImpl.getDelayGroupDays',3,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('CustomerServiceSERVImpl.getDelayGroupDays',4,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('CustomerServiceSERVImpl.getDelayGroupDays',5,1,'R',0,getdate(),'V',getdate())
go



----------------------------------------------------------------------------------
-- Instalacion de: CustomerServiceSERVImpl.updateCustomerInfo
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'CustomerServiceSERVImpl.updateCustomerInfo')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'CustomerServiceSERVImpl.updateCustomerInfo'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'CustomerServiceSERVImpl.updateCustomerInfo')
   delete cobis..cts_serv_catalog where csc_service_id = 'CustomerServiceSERVImpl.updateCustomerInfo'
go

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('CustomerServiceSERVImpl.updateCustomerInfo','com.cobiscorp.ecobis.cobiscloudparty.bsl.serv.bsl.ICustomerService',
       'updateCustomerInfo',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('CustomerServiceSERVImpl.updateCustomerInfo',1,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('CustomerServiceSERVImpl.updateCustomerInfo',3,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('CustomerServiceSERVImpl.updateCustomerInfo',4,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('CustomerServiceSERVImpl.updateCustomerInfo',5,1,'R',0,getdate(),'V',getdate())
go



----------------------------------------------------------------------------------
-- Instalacion de: CustomerServiceSERVImpl.getCustomerDetailsById
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'CustomerServiceSERVImpl.getCustomerDetailsById')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'CustomerServiceSERVImpl.getCustomerDetailsById'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'CustomerServiceSERVImpl.getCustomerDetailsById')
   delete cobis..cts_serv_catalog where csc_service_id = 'CustomerServiceSERVImpl.getCustomerDetailsById'
go

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('CustomerServiceSERVImpl.getCustomerDetailsById','com.cobiscorp.ecobis.cobiscloudparty.bsl.serv.bsl.ICustomerService',
       'getCustomerDetailsById',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('CustomerServiceSERVImpl.getCustomerDetailsById',1,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('CustomerServiceSERVImpl.getCustomerDetailsById',3,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('CustomerServiceSERVImpl.getCustomerDetailsById',4,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('CustomerServiceSERVImpl.getCustomerDetailsById',5,1,'R',0,getdate(),'V',getdate())
go


set nocount off
go
