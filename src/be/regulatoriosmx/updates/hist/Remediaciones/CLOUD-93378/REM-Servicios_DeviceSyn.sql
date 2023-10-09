

/**********************************************************************************************************************/
--Incidencia                 : SI
--Fecha                      : 22/01/2018
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

delete cts_serv_catalog
where csc_service_id in ('MobileManagement.SyncManagement.DeviceSync')
delete ad_servicio_autorizado
where ts_servicio in ('MobileManagement.SyncManagement.DeviceSync')

----------------------------------------------------
--Servicio para descargar clientes, grupos y cuestionarios
----------------------------------------------------

if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
 BEGIN

  select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
   
   INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
   VALUES ('MobileManagement.SyncManagement.DeviceSync', 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', 'deviceSync', '', 0, NULL, NULL, NULL)
   
   INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('MobileManagement.SyncManagement.DeviceSync', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
 END
ELSE 
 BEGIN

	select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
	
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
	VALUES ('MobileManagement.SyncManagement.DeviceSync', 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', 'deviceSync', '', 0, NULL, NULL, NULL)
	
	INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('MobileManagement.SyncManagement.DeviceSync', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

 END

go