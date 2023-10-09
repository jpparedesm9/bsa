-------------------------------------------
--- SERVICIO OBTENER ESTADOS          -----
-------------------------------------------
use cobis
go

declare 
@w_producto              int,
@w_tn_trn_code           int,
@w_pd_procedure          int

declare @w_roles table (
   rol       int
)

select @w_producto = pd_producto
from cl_producto
where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

select 
@w_tn_trn_code  = 21745,
@w_pd_procedure = 21745

insert into @w_roles
select ro_rol
from ad_rol
where ro_descripcion in (
'ASESOR',
'FUNCIONARIO OFICINA',
'COORDINADOR',
'GERENTE OFICINA', 
'MESA DE OPERACIONES'
)

delete cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchState'

insert into cts_serv_catalog values ('CustomerDataManagementService.CustomerManagement.SearchState', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement','searchState','',@w_tn_trn_code,null, null, null)

delete ad_servicio_autorizado  where ts_servicio = 'CustomerDataManagementService.CustomerManagement.SearchState'

insert into ad_servicio_autorizado 
select 'CustomerDataManagementService.CustomerManagement.SearchState',rol, @w_producto, 'R', 0, getdate(), 'V', getdate()
from @w_roles


-------------------------------------------
--- SERVICIO ACTUALIZAR ESTADOS       -----
-------------------------------------------
use cobis
go

declare 
@w_producto              int,
@w_tn_trn_code           int,
@w_pd_procedure          int

declare @w_roles table (
   rol       int
)

select @w_producto = pd_producto
from cl_producto
where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

select 
@w_tn_trn_code  = 21745,
@w_pd_procedure = 21745

insert into @w_roles
select ro_rol
from ad_rol
where ro_descripcion in (
'ASESOR',
'FUNCIONARIO OFICINA',
'COORDINADOR',
'GERENTE OFICINA', 
'MESA DE OPERACIONES'
)

delete cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.UpdateState'

insert into cts_serv_catalog values ('CustomerDataManagementService.CustomerManagement.UpdateState', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement','updateState','',@w_tn_trn_code,null, null, null)

delete ad_servicio_autorizado  where ts_servicio = 'CustomerDataManagementService.CustomerManagement.UpdateState'

insert into ad_servicio_autorizado 
select 'CustomerDataManagementService.CustomerManagement.UpdateState',rol, @w_producto, 'R', 0, getdate(), 'V', getdate()
from @w_roles

go
