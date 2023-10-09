
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Requerimiento 115268: Rol de Operaciones
--Fecha                      : 04/05/2018
--Descripción del Problema   : Se debe modificar catalogos
--Descripción de la Solución : Crear scripts de instalación
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- ACTUALIZA CATALOGO DE NOTIFICADOR
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 

use cobis
go


if exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.UpdateAltairAccount')
    update cts_serv_catalog set csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', csc_method_name = 'updateAltairAccount', csc_description = '', csc_trn = 104 where csc_service_id = 'CustomerDataManagementService.CustomerManagement.UpdateAltairAccount'
else
    insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) values ('CustomerDataManagementService.CustomerManagement.UpdateAltairAccount', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'updateAltairAccount', '', 104)
go

declare @w_rol int, @w_producto int

if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES')
begin  
	select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'
	select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'
	
	delete cobis..ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CustomerManagement.UpdateAltairAccount'
	insert into cobis..ad_servicio_autorizado values('CustomerDataManagementService.CustomerManagement.UpdateAltairAccount', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
	print 'insert en ad_servicio_autorizado OPERACIONES'
end
else
begin
	select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
	select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'
	
	delete cobis..ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CustomerManagement.UpdateAltairAccount'
	insert into cobis..ad_servicio_autorizado values('CustomerDataManagementService.CustomerManagement.UpdateAltairAccount', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
	print 'insert en ad_servicio_autorizado ADMINISTRADOR'
end