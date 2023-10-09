--------------------
-- PAGOS OBJETADOS #108348
--------------------
use cobis
go

declare 
@w_me_id_old int -- Codigo del menu a eliminar

select @w_me_id_old = me_id from cew_menu where me_name IN ('MNU_ASSETS_PAGO_OBJETADO') -- Obtiene el codigo del menu a eliminar

delete from cew_menu_role where mro_id_menu IN (@w_me_id_old) -- Elimina el menu rol
delete from cew_menu where me_name IN ('MNU_ASSETS_PAGO_OBJETADO') -- Elimina el menu
go

declare 
@w_me_id  int, -- Codigo del menu
@w_me_id_parent int, -- Codigo del menu padre
@w_ro_rol int, -- Codigo del rol
@w_pd_producto int -- Codigo del producto

select @w_me_id = isnull(max(me_id), 0) +1 from cew_menu -- Obtiene el nuevo id para el menu
select @w_me_id_parent = me_id from cobis..cew_menu where me_name = 'MNU_ASSETS' -- Obtiene el id del menu para el modulo de Cartera
select @w_pd_producto = pd_producto FROM cobis..cl_producto WHERE pd_descripcion = 'CARTERA' AND pd_abreviatura = 'CCA' -- Obtiene el id del producto 'Cartera'
select @w_ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES' -- Obtiene el id del rol de operaciones

insert into cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	values (@w_me_id, @w_me_id_parent, 'MNU_ASSETS_PAGO_OBJETADO', 1, 'views/PAOBJ/PAOBJ/T_PAOBJXPZXAKUO_168/1.0.0/VC_FREGULARPJ_493168_TASK.html', 182,  @w_pd_producto,  0, 'Regularizar Pago Objetado')

insert into cew_menu_role (mro_id_menu, mro_id_role) values (@w_me_id, @w_ro_rol) 

if exists (select 1 from cew_menu_role where mro_id_menu = @w_me_id_parent and mro_id_role = @w_ro_rol)
begin
	print 'YA EXISTE MENU CON EL ROL MESA DE OPERACIONES'
end
else
begin
	print 'SE CREA LA RELACION MENU-ROL CON EL ROL MESA DE OPERACIONES'
	insert into cew_menu_role (mro_id_menu, mro_id_role) values (@w_me_id_parent, @w_ro_rol)
end

go
