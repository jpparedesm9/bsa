set nocount on
go
-- Script de instalacion de los servicios
use cobis
go


----------------------------------------------------------------------------------
-- Instalacion de: BuroCustomerServiceSERVImpl.verify
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'BuroCustomerServiceSERVImpl.verify')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'BuroCustomerServiceSERVImpl.verify'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'BuroCustomerServiceSERVImpl.verify')
   delete cobis..cts_serv_catalog where csc_service_id = 'BuroCustomerServiceSERVImpl.verify'
go

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('BuroCustomerServiceSERVImpl.verify','com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.bsl.IBuroCustomerService',
       'verify',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerServiceSERVImpl.verify',1,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerServiceSERVImpl.verify',3,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerServiceSERVImpl.verify',4,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerServiceSERVImpl.verify',5,1,'R',0,getdate(),'V',getdate())
go



----------------------------------------------------------------------------------
-- Instalacion de: BuroCustomerServiceSERVImpl.validateRequest
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'BuroCustomerServiceSERVImpl.validateRequest')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'BuroCustomerServiceSERVImpl.validateRequest'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'BuroCustomerServiceSERVImpl.validateRequest')
   delete cobis..cts_serv_catalog where csc_service_id = 'BuroCustomerServiceSERVImpl.validateRequest'
go

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('BuroCustomerServiceSERVImpl.validateRequest','com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.bsl.IBuroCustomerService',
       'validateRequest',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerServiceSERVImpl.validateRequest',1,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerServiceSERVImpl.validateRequest',3,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerServiceSERVImpl.validateRequest',4,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerServiceSERVImpl.validateRequest',5,1,'R',0,getdate(),'V',getdate())
go



----------------------------------------------------------------------------------
-- Instalacion de: BuroCustomerUtilSERVImpl.generateHeader
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'BuroCustomerUtilSERVImpl.generateHeader')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'BuroCustomerUtilSERVImpl.generateHeader'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'BuroCustomerUtilSERVImpl.generateHeader')
   delete cobis..cts_serv_catalog where csc_service_id = 'BuroCustomerUtilSERVImpl.generateHeader'
go

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('BuroCustomerUtilSERVImpl.generateHeader','com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.bsl.IBuroCustomerUtil',
       'generateHeader',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerUtilSERVImpl.generateHeader',1,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerUtilSERVImpl.generateHeader',3,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerUtilSERVImpl.generateHeader',4,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerUtilSERVImpl.generateHeader',5,1,'R',0,getdate(),'V',getdate())
go



----------------------------------------------------------------------------------
-- Instalacion de: BuroCustomerUtilSERVImpl.getBlackList
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'BuroCustomerUtilSERVImpl.getBlackList')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'BuroCustomerUtilSERVImpl.getBlackList'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'BuroCustomerUtilSERVImpl.getBlackList')
   delete cobis..cts_serv_catalog where csc_service_id = 'BuroCustomerUtilSERVImpl.getBlackList'
go

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('BuroCustomerUtilSERVImpl.getBlackList','com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.bsl.IBuroCustomerUtil',
       'getBlackList',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerUtilSERVImpl.getBlackList',1,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerUtilSERVImpl.getBlackList',3,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerUtilSERVImpl.getBlackList',4,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerUtilSERVImpl.getBlackList',5,1,'R',0,getdate(),'V',getdate())
go



----------------------------------------------------------------------------------
-- Instalacion de: BuroCustomerUtilSERVImpl.isPartner
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'BuroCustomerUtilSERVImpl.isPartner')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'BuroCustomerUtilSERVImpl.isPartner'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'BuroCustomerUtilSERVImpl.isPartner')
   delete cobis..cts_serv_catalog where csc_service_id = 'BuroCustomerUtilSERVImpl.isPartner'
go

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('BuroCustomerUtilSERVImpl.isPartner','com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.bsl.IBuroCustomerUtil',
       'isPartner',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerUtilSERVImpl.isPartner',1,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerUtilSERVImpl.isPartner',3,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerUtilSERVImpl.isPartner',4,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerUtilSERVImpl.isPartner',5,1,'R',0,getdate(),'V',getdate())
go



----------------------------------------------------------------------------------
-- Instalacion de: BuroCustomerUtilSERVImpl.getDelayPercentage
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'BuroCustomerUtilSERVImpl.getDelayPercentage')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'BuroCustomerUtilSERVImpl.getDelayPercentage'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'BuroCustomerUtilSERVImpl.getDelayPercentage')
   delete cobis..cts_serv_catalog where csc_service_id = 'BuroCustomerUtilSERVImpl.getDelayPercentage'
go

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('BuroCustomerUtilSERVImpl.getDelayPercentage','com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.bsl.IBuroCustomerUtil',
       'getDelayPercentage',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerUtilSERVImpl.getDelayPercentage',1,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerUtilSERVImpl.getDelayPercentage',3,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerUtilSERVImpl.getDelayPercentage',4,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('BuroCustomerUtilSERVImpl.getDelayPercentage',5,1,'R',0,getdate(),'V',getdate())
go


set nocount off
go
