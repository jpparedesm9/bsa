use cobis
go

declare 
@w_me_id            int,
@w_me_parent        int,
@w_me_parent_1      int,
@w_rol              int,
@w_producto         int,
@w_moneda           int

declare @w_roles table(
   role         int,
   menu         int
)

declare @w_services table(
   servicio     varchar(500)
)

declare @w_servicio_autorizado table (
   servicio      varchar(500),
   rol           int,
   producto      int,
   tipo          char(1),
   moneda        int,
   fecha_aut     datetime,
   estado        char(1),
   fecha_ult_mod datetime
)

select @w_producto = pd_producto
from cl_producto
where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'


select @w_moneda = mo_moneda
from cl_moneda
where mo_descripcion = 'PESOS'

insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.GetCustomerCycleNumber')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.ReadTelephone')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchAddress')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchRelation')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchRelationPerson')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.FindPostalCode')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.ReadCustomerInfo')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.ReadDataCustomer')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchAddresBusiness')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchAddresProspectSan')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchAddressByHome')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchCustomerBusiness')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchCustomerReference')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchEconomicActivity')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchPepPerson')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchRelationClient')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchSpouseCustomer')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchTelephone')
insert into @w_services values ( 'CustomerDataManagementService.CustomerManagement.SearchZipPostal')


select @w_me_id = isnull(max(me_id) ,0) +1 from cobis..cew_menu
select @w_me_parent   = me_id from cobis..cew_menu where me_name = 'MNU_CUSTOMER_OPER'
select @w_me_parent_1 = me_id from cobis..cew_menu where me_name = 'MNU_OPER'

insert into @w_roles
select ro_rol, 1
from ad_rol
where ro_descripcion not in 
( 'MESA DE OPERACIONES' , 
'ASESOR', 
'ASESOR MOVIL',
'ASESOR EXTERNO',
'CORRESPONSAL OXXO',
'PERFIL MOVIL',
'SCHEDULER CTS',
'CALL CENTER',
'CORRESPONSAL NO BANCARIO',
'OPERADOR SOFOME'
)

delete from cobis..ad_servicio_autorizado 
where ts_servicio in (select servicio from @w_services)
and ts_rol in (select role from @w_roles where menu = 1)


insert into @w_roles
select ro_rol, 2
from ad_rol
where ro_descripcion in ( 'MESA DE OPERACIONES' , 'ASESOR')

select * from @w_roles


delete cobis..cew_menu_role where mro_id_menu = 
(select me_id from cobis..cew_menu where me_name = 'MNU_CSTMR_SEACHCUSTOMER_QUERY')

delete cobis..cew_menu_role where mro_id_menu = 
(select me_id from cobis..cew_menu where me_name = 'MNU_CUSTOMER_OPER') 
and mro_id_role in (select role from @w_roles)

delete cobis..cew_menu_role where mro_id_menu = 
(select me_id from cobis..cew_menu where me_name = 'MNU_OPER') 
and mro_id_role in (select role from @w_roles)


delete cobis..cew_menu where me_name = 'MNU_CSTMR_SEACHCUSTOMER_QUERY'

if @w_me_parent is not null begin

   insert into cobis..cew_menu values (@w_me_id, @w_me_parent, 'MNU_CSTMR_SEACHCUSTOMER_QUERY', 1, 'views/CSTMR/CSTMR/T_CUSTOMERCOETP_680/1.0.0/VC_CUSTOMEROI_208680_TASK.html?modo=Q', 169, 2,0, 'Consulta Mantenimiento de Personas Naturales', null, 'CWC')
   
   insert into cobis..cew_menu_role 
   select @w_me_parent, role
   from @w_roles
   where menu = 1
   
   insert into cobis..cew_menu_role 
   select @w_me_parent_1, role
   from @w_roles
   where menu = 1
   
   insert into cobis..cew_menu_role 
   select @w_me_id, role
   from @w_roles
   where menu = 1
end



delete from cobis..ad_servicio_autorizado 
where ts_servicio in (select servicio from @w_services)
and ts_rol in (select role from @w_roles where menu = 1)

insert into @w_servicio_autorizado 
select servicio, role, @w_producto, 'R', @w_moneda, getdate(),'V', getdate()
from @w_services, @w_roles
where menu = 1

insert into ad_servicio_autorizado 
select * from @w_servicio_autorizado


delete cobis..cew_resource_rol 
where rro_id_resource in ( select  re_id 
                           from cew_resource where re_pattern in (
                           '/cobis/web/views/CSTMR/.*',
                           '/resources/CSTMR/.*',
                           '/cobis/web/views//customer/.*',
                           '/cobis/web/views/customer/.*',
						   '/cobis/web/views/inbox/.*',
						   '/cobis/web/views//inbox/.*'))
and rro_id_rol in (select role from @w_roles where menu = 1)

insert into cobis..cew_resource_rol
select  re_id, role
from cew_resource, @w_roles
where re_pattern in (
'/cobis/web/views/CSTMR/.*',
'/resources/CSTMR/.*',
'/cobis/web/views//customer/.*',
'/cobis/web/views/customer/.*',
'/cobis/web/views/inbox/.*',
'/cobis/web/views//inbox/.*')
and menu = 1


select @w_me_id  = null 
select @w_me_id = me_id 
from cobis..cew_menu 
where me_name = 'MNU_CSTMR_SEACHCUSTOMER'

if @w_me_id is not null begin
   delete cobis..cew_menu_role where mro_id_menu = (select me_id from cobis..cew_menu where me_name = 'MNU_CSTMR_SEACHCUSTOMER')
   

   insert into cobis..cew_menu_role 
   select @w_me_id, role
   from @w_roles
   where menu = 2
end
go