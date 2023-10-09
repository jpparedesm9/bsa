/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S134123 Pantalla Datos Cónyugue
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

  IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.NaturalProspectManagement.CreateNaturalProspectSpouse')
    UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.INaturalProspectManagement', csc_method_name = 'createNaturalProspectSpouse', csc_description = '', csc_trn = 73935 WHERE csc_service_id = 'CustomerDataManagementService.NaturalProspectManagement.CreateNaturalProspectSpouse'
  ELSE
    INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.NaturalProspectManagement.CreateNaturalProspectSpouse', 'cobiscorp.ecobis.customerdatamanagementservice.service.INaturalProspectManagement', 'createNaturalProspectSpouse', '', 73935)
  GO
  
  IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchSpouseCustomer')
    UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', csc_method_name = 'searchSpouseCustomer', csc_description = '', csc_trn = 132 WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchSpouseCustomer'
  ELSE
    INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.CustomerManagement.SearchSpouseCustomer', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchSpouseCustomer', '', 132)
  GO
  
    
USE cobis

GO
declare @w_rol int, @w_producto int
	  
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'


DELETE cobis..ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.NaturalProspectManagement.CreateNaturalProspectSpouse'
INSERT INTO cobis..ad_servicio_autorizado values('CustomerDataManagementService.NaturalProspectManagement.CreateNaturalProspectSpouse', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
print 'insert en ad_servicio_autorizado'


DELETE cobis..ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CustomerManagement.SearchSpouseCustomer'
INSERT INTO cobis..ad_servicio_autorizado values('CustomerDataManagementService.CustomerManagement.SearchSpouseCustomer', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
print 'insert en ad_servicio_autorizado'