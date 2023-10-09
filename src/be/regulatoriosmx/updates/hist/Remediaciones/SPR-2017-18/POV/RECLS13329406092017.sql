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
--Ruta TFS                   : 
--Nombre Archivo             : 


use cobis
    GO
    
    use cobis
    GO
    
      IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'MobileManagement.SyncManagement.GroupSync')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', csc_method_name = 'groupSync', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'MobileManagement.SyncManagement.GroupSync'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('MobileManagement.SyncManagement.GroupSync', 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', 'groupSync', '', 0)
      GO
    
      IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'MobileManagement.SyncManagement.CustomerSync')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', csc_method_name = 'customerSync', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'MobileManagement.SyncManagement.CustomerSync'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('MobileManagement.SyncManagement.CustomerSync', 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', 'customerSync', '', 0)
      GO
    
      

USE cobis

GO
declare @w_rol int, @w_producto int
	  
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'


DELETE cobis..ad_servicio_autorizado where ts_servicio = 'MobileManagement.SyncManagement.GroupSync'
INSERT INTO cobis..ad_servicio_autorizado values('MobileManagement.SyncManagement.GroupSync', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
print 'insert en ad_servicio_autorizado'


DELETE cobis..ad_servicio_autorizado where ts_servicio = 'MobileManagement.SyncManagement.CustomerSync'
INSERT INTO cobis..ad_servicio_autorizado values('MobileManagement.SyncManagement.CustomerSync', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
print 'insert en ad_servicio_autorizado'


