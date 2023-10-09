USE cobis 
GO

if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.validateBuro')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.validateBuro'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.validateBuro')
   delete cobis..cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.validateBuro'

insert into cobis..cts_serv_catalog
      (csc_service_id,                                    csc_class_name,
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('OrchestrationClientValidationServiceSERVImpl.validateBuro','com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService',
       'validateBuro',                                      'Description',
       null,                                                 null,
       null,                                              'N')

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validateBuro',1,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validateBuro',3,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validateBuro',4,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validateBuro',5,1,'R',0,getdate(),'V',getdate())


----------------------------------------------------------------------------------
-- Instalacion de: OrchestrationClientValidationServiceSERVImpl.validateSantander
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.validateSantander')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.validateSantander'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.validateSantander')
   delete cobis..cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.validateSantander'


insert into cobis..cts_serv_catalog
      (csc_service_id,                                    csc_class_name,
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('OrchestrationClientValidationServiceSERVImpl.validateSantander','com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService',
       'validateSantander',                                      'Description',
       null,                                                 null,
       null,                                              'N')

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validateSantander',1,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validateSantander',3,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validateSantander',4,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validateSantander',5,1,'R',0,getdate(),'V',getdate())
go