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
where mo_descripcion = 'PESOS MEXICANOS'

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
	
delete cobis..cew_resource_rol
where rro_id_resource = @w_resource
and rro_id_rol = @w_rol



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

delete ad_rol
where ro_rol = @w_rol

go