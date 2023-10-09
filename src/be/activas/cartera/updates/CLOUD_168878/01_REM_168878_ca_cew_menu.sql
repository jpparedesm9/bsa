use cobis
go

declare 
@w_me_id            int,
@w_me_parent        int,
@w_producto         int,
@w_menu_order       int

declare @w_roles table(
   role         int
)

select @w_producto = pd_producto
from cl_producto
where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'


select @w_me_id = isnull(max(me_id) ,0) +1 from cobis..cew_menu
select @w_me_parent = me_id from cobis..cew_menu where me_name = 'MNU_OPER'
select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_me_parent

insert into @w_roles
select ro_rol
from ad_rol
where ro_estado = 'V'

select * from @w_roles

delete cobis..cew_menu_role where mro_id_menu = 
(select me_id from cobis..cew_menu where me_name = 'MNU_ASSETSCRE_PREFILLED_REQUEST')

delete cobis..cew_menu where me_name = 'MNU_ASSETSCRE_PREFILLED_REQUEST'


if @w_me_parent is not null begin

   insert into cobis..cew_menu values (@w_me_id, @w_me_parent, 'MNU_ASSETSCRE_PREFILLED_REQUEST', 1, 'views/ASSCR/CREIR/T_ASSCRMFWPCNKI_783/1.0.0/VC_PREFILLESE_234783_TASK.html', @w_menu_order, @w_producto, 0, 'Solicitud Prellenada', null, 'CWC')
         
   insert into cobis..cew_menu_role 
   select @w_me_id, role
   from @w_roles
end


delete cobis..cew_resource_rol 
where rro_id_resource in ( select  re_id 
                           from cew_resource where re_pattern in (
						   '/cobis/web/views/ASSCR/.*'))
and rro_id_rol in (select role from @w_roles)

insert into cobis..cew_resource_rol
select  re_id, role
from cew_resource, @w_roles
where re_pattern in (
'/cobis/web/views/ASSCR/.*')

go
