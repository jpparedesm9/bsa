
/**********************************************************************************************************************/
--Incidencia                 : SI
--Fecha                      : 25/01/2018
--Descripción del Problema   : Descargar grupos,clientes,solicitudes
--Descripción de la Solución : Creación de Servicio para Descargar grupos,clientes,solicitudes
--Instalador                 : si_services_authorization.sql
--Ruta Instalador            : $/ASP/CLOUD/Main/CLOUD/MobileIntegration/Backend/sql/si_services_authorization.sql
/**********************************************************************************************************************/
USE cobis 
GO

declare @w_rol int,
        @w_producto int


select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'
----------------------------------------------------
--Elimino servicios nuevos para Device Sync
----------------------------------------------------
if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
 BEGIN
 	select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
 	
 	 delete ad_servicio_autorizado where ts_servicio in ('MobileManagement.SyncManagement.DeviceSync') AND ts_rol=@w_rol
 	
 	IF EXISTS(SELECT 1 FROM cts_serv_catalog where csc_service_id in ('MobileManagement.SyncManagement.DeviceSync'))
       BEGIN
        	delete cts_serv_catalog where csc_service_id in ('MobileManagement.SyncManagement.DeviceSync')
       END
 
 END
ELSE 
 BEGIN

	select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
	
	delete ad_servicio_autorizado where ts_servicio in ('MobileManagement.SyncManagement.DeviceSync') AND ts_rol=@w_rol
	
 	IF EXISTS(SELECT 1 FROM cts_serv_catalog where csc_service_id in ('MobileManagement.SyncManagement.DeviceSync'))
       BEGIN
         delete cts_serv_catalog where csc_service_id in ('MobileManagement.SyncManagement.DeviceSync')
       END
	
 END

go

