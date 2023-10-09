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
-- Instalacion de: SynchronizeServiceSERVImpl.getDataToSynchronize
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'SynchronizeServiceSERVImpl.getDataToSynchronize')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'SynchronizeServiceSERVImpl.getDataToSynchronize'


insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('SynchronizeServiceSERVImpl.getDataToSynchronize','com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.serv.bsl.ISynchronizeService',
       'getDataToSynchronize',                                      'Description',
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('SynchronizeServiceSERVImpl.getDataToSynchronize',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())


----------------------------------------------------------------------------------
-- Instalacion de: SynchronizeServiceSERVImpl.updateDataToSynchronize
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'SynchronizeServiceSERVImpl.updateDataToSynchronize')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'SynchronizeServiceSERVImpl.updateDataToSynchronize'


insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('SynchronizeServiceSERVImpl.updateDataToSynchronize','com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.serv.bsl.ISynchronizeService',
       'updateDataToSynchronize',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('SynchronizeServiceSERVImpl.updateDataToSynchronize',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())


----------------------------------------------------------------------------------
-- Instalacion de: SynchronizeServiceSERVImpl.getCustomerToSynchronize
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'SynchronizeServiceSERVImpl.getCustomerToSynchronize')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'SynchronizeServiceSERVImpl.getCustomerToSynchronize'

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('SynchronizeServiceSERVImpl.getCustomerToSynchronize','com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.serv.bsl.ISynchronizeService',
       'getCustomerToSynchronize',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('SynchronizeServiceSERVImpl.getCustomerToSynchronize',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())



----------------------------------------------------------------------------------
-- Instalacion de: SynchronizeServiceSERVImpl.getGroupToSynchronize
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'SynchronizeServiceSERVImpl.getGroupToSynchronize')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'SynchronizeServiceSERVImpl.getGroupToSynchronize'


insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('SynchronizeServiceSERVImpl.getGroupToSynchronize','com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.serv.bsl.ISynchronizeService',
       'getGroupToSynchronize',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('SynchronizeServiceSERVImpl.getGroupToSynchronize',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())


-- Instalacion de: SynchronizeServiceSERVImpl.getEntitiesData
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'SynchronizeServiceSERVImpl.getEntitiesData')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'SynchronizeServiceSERVImpl.getEntitiesData'



insert into cobis..cts_serv_catalog
      (csc_service_id,                                    csc_class_name,
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('SynchronizeServiceSERVImpl.getEntitiesData','com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.serv.bsl.ISynchronizeService',
       'getEntitiesData',                                      'Description',
       null,                                                 null,
       null,                                              'N')

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('SynchronizeServiceSERVImpl.getEntitiesData',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())



set nocount off
go
