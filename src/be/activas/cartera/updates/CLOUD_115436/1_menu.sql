use cobis
go

declare 
@w_ultimo int,
@w_existente int,
@w_rol_2 int

select @w_rol_2 = ro_rol from ad_rol where ro_descripcion='OPERACIONES' 

select @w_existente=me_id  from cobis..cew_menu where me_name='MNU_CARGA_MASIVA'

if @w_existente is not null
begin
	delete from cobis..cew_menu_role where  mro_id_menu = @w_existente
	delete from cobis..cew_menu where me_name='MNU_CARGA_MASIVA'
end

select @w_ultimo=max(me_id)  from cobis..cew_menu

insert into cobis..cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
values (@w_ultimo+1, 34, 'MNU_CARGA_MASIVA', 1, 'views/ASSTS/MNTNN/T_ASSTSEUQOESBB_349/1.0.0/VC_MASSIVEPTY_109349_TASK.html', 2, 7, 0, 'Carga Masiva de Pagos')


insert into cobis..cew_menu_role values (@w_ultimo+1,@w_rol_2)


if not exists (select 1 from cobis..cew_menu_role where mro_id_menu = 34 and mro_id_role=16)
insert into cobis..cew_menu_role values (34,16)






