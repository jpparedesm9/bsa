set nocount on
go
-- Script de instalacion de los servicios
use cobis
go


----------------------------------------------------------------------------------
-- Instalacion de: OrchestrationClientValidationServiceSERVImpl.validate
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.validate')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.validate'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.validate')
   delete cobis..cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.validate'
go

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('OrchestrationClientValidationServiceSERVImpl.validate','com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService',
       'validate',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validate',1,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validate',3,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validate',4,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validate',5,1,'R',0,getdate(),'V',getdate())
go



----------------------------------------------------------------------------------
-- Instalacion de: OrchestrationClientValidationServiceSERVImpl.validateBuroClient
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.validateBuroClient')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.validateBuroClient'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.validateBuroClient')
   delete cobis..cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.validateBuroClient'
go

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('OrchestrationClientValidationServiceSERVImpl.validateBuroClient','com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService',
       'validateBuroClient',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validateBuroClient',1,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validateBuroClient',3,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validateBuroClient',4,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validateBuroClient',5,1,'R',0,getdate(),'V',getdate())
go



----------------------------------------------------------------------------------
-- Instalacion de: OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup')
   delete cobis..cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup'
go

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup','com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService',
       'validateBuroClientGroup',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup',1,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup',3,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup',4,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup',5,1,'R',0,getdate(),'V',getdate())
go



----------------------------------------------------------------------------------
-- Instalacion de: WorkflowServiceSERVImpl.executeRule
----------------------------------------------------------------------------------
if exists (select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'WorkflowServiceSERVImpl.executeRule')
   delete cobis..ad_servicio_autorizado where ts_servicio = 'WorkflowServiceSERVImpl.executeRule'

if exists (select 1 from cobis..cts_serv_catalog where csc_service_id = 'WorkflowServiceSERVImpl.executeRule')
   delete cobis..cts_serv_catalog where csc_service_id = 'WorkflowServiceSERVImpl.executeRule'
go

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('WorkflowServiceSERVImpl.executeRule','com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IWorkflowService',
       'executeRule',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('WorkflowServiceSERVImpl.executeRule',1,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('WorkflowServiceSERVImpl.executeRule',3,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('WorkflowServiceSERVImpl.executeRule',4,1,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('WorkflowServiceSERVImpl.executeRule',5,1,'R',0,getdate(),'V',getdate())
go


set nocount off
go
