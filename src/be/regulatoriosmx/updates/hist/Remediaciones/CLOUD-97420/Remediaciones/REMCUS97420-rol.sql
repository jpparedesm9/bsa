use cobis
go

declare @w_rol         int,
        @w_resource    int,
		@w_producto    int ,
		@w_moneda      int
		
select @w_producto = pd_producto 
from cl_producto 
where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

select @w_moneda = mo_moneda 
from cl_moneda 
where mo_descripcion = 'PESOS'

if not exists (select 1 from ad_rol where ro_descripcion = 'GERENTE DIVISIONAL') begin
   select @w_rol = max(ro_rol) + 1 
   from ad_rol
   
   INSERT INTO ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out, ro_admin_seg, ro_departamento, ro_oficina)
   VALUES (@w_rol, 1, 'GERENTE DIVISIONAL', getdate(), 1, 'V', getdate(), 900, NULL, NULL, NULL)
end

select @w_rol = ro_rol
from ad_rol 
where ro_descripcion = 'GERENTE DIVISIONAL'


print 'rol: '+ convert(varchar, @w_rol)

delete cobis..cew_menu_role 
where mro_id_menu in (select me_id 
                      from cobis..cew_menu
                      where me_name 
					  in ('MNU_TRANSFER','MNU_AUTO_TRANSFER','MNU_SOL_TRANSFER', 'MNU_ADMIN'))
and mro_id_role = @w_rol

insert into cobis..cew_menu_role
select me_id,@w_rol from cobis..cew_menu
where me_name in ('MNU_TRANSFER','MNU_AUTO_TRANSFER','MNU_SOL_TRANSFER','MNU_ADMIN')


select @w_resource = re_id 
from cobis..cew_resource
where re_pattern = '/cobis/web/views/CSTMR/.*'

print 'recurso: '+ convert(varchar,@w_resource)

delete cobis..cew_menu_resource
where mr_id_menu in (select me_id 
                      from cobis..cew_menu
                      where me_name 
					  in ('MNU_TRANSFER','MNU_AUTO_TRANSFER','MNU_SOL_TRANSFER', 'MNU_ADMIN'))
and mr_id_resource = @w_resource
					  

insert into cobis..cew_menu_resource
select me_id,@w_resource from cobis..cew_menu
where me_name in ('MNU_TRANSFER','MNU_AUTO_TRANSFER','MNU_SOL_TRANSFER', 'MNU_ADMIN')

delete cobis..cew_resource_rol
where rro_id_resource = @w_resource
and rro_id_rol = @w_rol

insert into cobis..cew_resource_rol
values (@w_resource, @w_rol)


delete ad_servicio_autorizado where ts_servicio in (
'CustomerDataManagementService.CustomerManagement.AuthorizationTransferDetail',
'CustomerDataManagementService.CustomerManagement.AuthorizationTransfer',
'CustomerDataManagementService.CustomerManagement.CreateRequestTransfer',
'CustomerDataManagementService.CustomerManagement.RefuseTransfer',
'CustomerDataManagementService.CustomerManagement.SearchOfficeTransfer',
'CustomerDataManagementService.CustomerManagement.SearchOfficialTransfer',
'CustomerDataManagementService.CustomerManagement.SearchRequestTransfer',
'CustomerDataManagementService.CustomerManagement.SearchCustomerByOfficial')
and ts_rol = @w_rol

insert into ad_servicio_autorizado values ('CustomerDataManagementService.CustomerManagement.AuthorizationTransferDetail', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate())

insert into ad_servicio_autorizado values ('CustomerDataManagementService.CustomerManagement.AuthorizationTransfer', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate())

insert into ad_servicio_autorizado values ('CustomerDataManagementService.CustomerManagement.CreateRequestTransfer', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate())

insert into ad_servicio_autorizado values ('CustomerDataManagementService.CustomerManagement.RefuseTransfer', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate())

insert into ad_servicio_autorizado values ('CustomerDataManagementService.CustomerManagement.SearchOfficeTransfer', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate())

insert into ad_servicio_autorizado values ('CustomerDataManagementService.CustomerManagement.SearchOfficialTransfer', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate())

insert into ad_servicio_autorizado values ('CustomerDataManagementService.CustomerManagement.SearchRequestTransfer', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate())

insert into ad_servicio_autorizado values ('CustomerDataManagementService.CustomerManagement.SearchCustomerByOfficial', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate())
go
