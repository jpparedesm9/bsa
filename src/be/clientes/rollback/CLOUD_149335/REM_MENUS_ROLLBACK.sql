use cobis
go

declare 
@w_me_id            int,
@w_me_parent        int,
@w_rol              int

declare @w_roles table(
   role         int,
   menu         int
)

declare @w_roles_d table(
   role         int
)


insert into @w_roles
select mro_id_role, 0 from cobis..cew_menu_role
where mro_id_menu in ( select me_id from cobis..cew_menu where me_name = 'MNU_CSTMR_SEACHCUSTOMER_QUERY')

delete cobis..cew_menu_role where mro_id_menu in ( select me_id from cobis..cew_menu where me_name = 'MNU_CSTMR_SEACHCUSTOMER_QUERY')
delete cobis..cew_menu where me_name = 'MNU_CSTMR_SEACHCUSTOMER_QUERY'

select @w_rol = 0
while 1 = 1 begin

   select top 1 @w_rol = role
   from @w_roles
   order by role asc
   
   if @@rowcount = 0 break
   
   select @w_me_parent = me_id
   from cobis..cew_menu 
   where me_name = 'MNU_CUSTOMER_OPER'
   
   if not exists (select 1 from cobis..cew_menu, cobis..cew_menu_role where me_id = mro_id_menu and me_id_parent = @w_me_parent 
   and mro_id_role = @w_rol) begin
      delete cobis..cew_menu_role where mro_id_role = @w_rol and mro_id_menu = @w_me_parent
   end
   
end


delete cobis..cew_menu_role where mro_id_menu in ( select me_id from cobis..cew_menu where me_name = 'MNU_CSTMR_SEACHCUSTOMER')

insert into @w_roles
select ro_rol, 1
from ad_rol
where ro_descripcion  in (
'ADMINISTRADOR',
'FUNCIONARIO OFICINA',
'ASESOR',
'MESA DE OPERACIONES',
'NORMATIVO')



select @w_me_id  = null 
select @w_me_id = me_id 
from cobis..cew_menu 
where me_name = 'MNU_CSTMR_SEACHCUSTOMER'

if @w_me_id is not null begin
   delete cobis..cew_menu_role where mro_id_menu = (select me_id from cobis..cew_menu where me_name = 'MNU_CSTMR_SEACHCUSTOMER')
   and mro_id_role in (select role from @w_roles where menu = 1)

   insert into cobis..cew_menu_role 
   select @w_me_id, role
   from @w_roles
   where menu = 1
end
go