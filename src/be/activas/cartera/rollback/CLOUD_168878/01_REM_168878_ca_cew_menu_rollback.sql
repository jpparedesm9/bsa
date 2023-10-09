use cobis
go

declare @w_roles table(
   role         int
)

insert into @w_roles
select ro_rol
from ad_rol
where ro_descripcion in 
( 'OPERACIONES', 
'AUDITORIA', 
'CALL CENTER'
)

select * from @w_roles

delete cobis..cew_menu_role where mro_id_menu = 
(select me_id from cobis..cew_menu where me_name = 'MNU_ASSETSCRE_PREFILLED_REQUEST')

delete cobis..cew_menu where me_name = 'MNU_ASSETSCRE_PREFILLED_REQUEST'


delete cobis..cew_resource_rol 
where rro_id_resource in ( select  re_id 
                           from cew_resource where re_pattern in (
						   '/cobis/web/views/ASSCR/.*'))

insert into cobis..cew_resource_rol
select  re_id, role
from cew_resource, @w_roles
where re_pattern in (
'/cobis/web/views/ASSCR/.*')

go
