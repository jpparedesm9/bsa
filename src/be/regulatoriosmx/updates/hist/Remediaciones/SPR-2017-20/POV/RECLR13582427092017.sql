/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S134123 Pantalla Datos Conyugue
--Fecha                      : 13/08/2017
--Descripción del Problema   : No existen permisos de Nuevos Servicios
--Descripción de la Solución : Insertar permisos para Nuevos Servicios
--Autor                      : Paúl Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS MOBILEMANAGEMENT
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo          	 : cl_services_authorization.sql

    use cobis
    GO
    
      IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.DeleteAllRelation')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', csc_method_name = 'deleteAllRelation', csc_description = '', csc_trn = 1368 WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.DeleteAllRelation'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.CustomerManagement.DeleteAllRelation', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'deleteAllRelation', '', 1368)
      GO
      
      IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.CheckRelationship')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', csc_method_name = 'checkRelationship', csc_description = '', csc_trn = 1367 WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.CheckRelationship'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.CustomerManagement.CheckRelationship', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'checkRelationship', '', 1367)
      GO
    
    
USE cobis

GO
declare @w_rol int, @w_producto int
	  
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'


DELETE cobis..ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CustomerManagement.DeleteAllRelation'
INSERT INTO cobis..ad_servicio_autorizado values('CustomerDataManagementService.CustomerManagement.DeleteAllRelation', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
print 'insert en ad_servicio_autorizado'

DELETE cobis..ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CustomerManagement.CheckRelationship'
INSERT INTO cobis..ad_servicio_autorizado values('CustomerDataManagementService.CustomerManagement.CheckRelationship', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
print 'insert en ad_servicio_autorizado'