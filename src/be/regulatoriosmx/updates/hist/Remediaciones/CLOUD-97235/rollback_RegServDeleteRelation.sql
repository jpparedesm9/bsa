print '-- DELETE DE SERVICIOS'
go

use cobis
go

declare @w_rol int, @w_producto int, @w_moneda tinyint

select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
    select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'

/*DeleteRelation*/
    if exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'CustomerDataManagementService.CustomerManagement.DeleteRelation' and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)        
        DELETE ad_servicio_autorizado where 
        ts_servicio = 'CustomerDataManagementService.CustomerManagement.DeleteRelation' and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda
        	
	if exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.DeleteRelation')
	    DELETE cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.DeleteRelation'			
end
else
begin
    select @w_rol = ro_rol from ad_rol where ro_descripcion = 'ADMINISTRADOR'
/*DeleteRelation*/
    if exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'CustomerDataManagementService.CustomerManagement.DeleteRelation' and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)        
        DELETE ad_servicio_autorizado where 
        ts_servicio = 'CustomerDataManagementService.CustomerManagement.DeleteRelation' and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda
        	
	if exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.DeleteRelation')
	    DELETE cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.DeleteRelation'	
end								
go

