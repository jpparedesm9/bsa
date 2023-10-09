/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-R138980 Sincronizacion desde Pantalla
--Fecha                      : 11/10/2017
--Descripción del Problema   : No existen permisos de Nuevos Servicios
--Descripción de la Solución : Insertar permisos para Nuevos Servicios
--Autor                      : Paúl Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS MOBILEMANAGEMENT
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo          	 : 

    use cobis
    GO
    
      IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'MobileManagement.SyncManagement.CustomerSyncOfficial')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', csc_method_name = 'customerSyncOfficial', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'MobileManagement.SyncManagement.CustomerSyncOfficial'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('MobileManagement.SyncManagement.CustomerSyncOfficial', 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', 'customerSyncOfficial', '', 0)
      GO
    
      IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'MobileManagement.SyncManagement.GroupSyncOfficial')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', csc_method_name = 'groupSyncOfficial', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'MobileManagement.SyncManagement.GroupSyncOfficial'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('MobileManagement.SyncManagement.GroupSyncOfficial', 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', 'groupSyncOfficial', '', 0)
      GO
    
    
USE cobis

GO
declare @w_rol int, @w_producto int
	  
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'


DELETE cobis..ad_servicio_autorizado where ts_servicio = 'MobileManagement.SyncManagement.CustomerSyncOfficial'
INSERT INTO cobis..ad_servicio_autorizado values('MobileManagement.SyncManagement.CustomerSyncOfficial', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
print 'insert en ad_servicio_autorizado'

DELETE cobis..ad_servicio_autorizado where ts_servicio = 'MobileManagement.SyncManagement.GroupSyncOfficial'
INSERT INTO cobis..ad_servicio_autorizado values('MobileManagement.SyncManagement.GroupSyncOfficial', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
print 'insert en ad_servicio_autorizado'


--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS MOBILEMANAGEMENT
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo          	 : cl_error.sql


use cobis 
go

DELETE cobis..cl_errores WHERE numero = 103157

INSERT INTO cobis..cl_errores VALUES ( 103157,1, 'Existe un Cliente casado y sin datos de Conyugue')


