use cobis
go

print 'Insertando Menu Garantias'

declare @id_menu integer, @id_menu_parent integer, @w_name varchar(50), @w_name_parent varchar(50), @w_rol tinyint

select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'

select @w_name = 'MNU_WARRANTIES'
select @w_name_parent = 'MNU_BACK_OFFICE'

select @id_menu_parent = me_id from cew_menu where me_name = @w_name_parent
select @id_menu= (max(me_id)+1) from cobis..cew_menu

if not exists(select 1 from cew_menu where me_name = @w_name)
   insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product) values(@id_menu,@id_menu_parent,@w_name,null,19)
else
   update cew_menu set me_id_parent = @id_menu_parent, me_id_cobis_product = 19
   where me_name = @w_name

select @id_menu = me_id from cew_menu where me_name = @w_name

if not exists(select 1 from cew_menu_role where mro_id_menu = @id_menu and mro_id_role = @w_rol)
   insert into cobis..cew_menu_role(mro_id_menu,mro_id_role) values(@id_menu,@w_rol)
go


print 'Insertando Menu Consultas'

declare @id_menu        int,
        @id_menu_parent int,
        @w_rol          int

select @w_rol = ro_rol
  from cobis..ad_rol
 where ro_descripcion = 'MENU POR PROCESOS'

select @id_menu_parent = me_id from cew_menu
 where me_name = 'MNU_WARRANTIES'

select @id_menu= (max(me_id)+1) from cobis..cew_menu

if not exists(select 1 from cew_menu where me_name = 'MNU_WARRANTIESQUERY')
   insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product)
   values(@id_menu,@id_menu_parent,'MNU_WARRANTIESQUERY',null,19)
else
   update cew_menu set me_id_parent = @id_menu_parent, me_id_cobis_product = 19
   where me_name = 'MNU_WARRANTIESQUERY'

select @id_menu = me_id from cew_menu where me_name = 'MNU_WARRANTIESQUERY'

if not exists(select 1 from cew_menu_role where mro_id_menu = @id_menu and mro_id_role = @w_rol)
   insert into cobis..cew_menu_role(mro_id_menu,mro_id_role) values(@id_menu,@w_rol)
go


print 'Insertando Menu Consultas/General de Garantias'

declare @w_menu        int,
        @w_menu_padre  int,
        @w_producto    int,
        @w_rol         int,
        @w_url         varchar(255),
        @w_nomb_padre  varchar(100),
        @w_nombre      varchar(100)

select @w_rol = ro_rol
  from cobis..ad_rol
 where ro_descripcion = 'MENU POR PROCESOS'
   
select @w_producto    = 19,
       @w_nomb_padre  = 'MNU_WARRANTIESQUERY',
       @w_nombre      = 'MNU_WARRANTIESQUERY_GENERAL',
       @w_url         = 'views\collateral\collateral-container.html?type=D&mod=BUSIN&sub=FLCRE&task=T_FLCRE_35_RRCAI67&ver=1.0.0&view=VC_RRCAI67_WACRI_884&option=8'

select @w_menu_padre = me_id
  from cobis..cew_menu
 where me_name = @w_nomb_padre

select @w_menu = (max(me_id) + 1) from cobis..cew_menu

if (@w_menu_padre is not null and @w_rol is not null)
begin
   if not exists (select 1 from cobis..cew_menu where me_name = @w_nombre)
      insert into cobis..cew_menu(me_id, me_id_parent, me_name, me_url, me_id_cobis_product)
      values(@w_menu, @w_menu_padre, @w_nombre, @w_url, @w_producto)
   else
      update cew_menu set me_id_parent = @w_menu_padre, me_id_cobis_product = @w_producto
      where me_name = @w_nombre

   select @w_menu = me_id from cew_menu where me_name = @w_nombre

   if not exists (select 1 from cobis..cew_menu_role where mro_id_menu = @w_menu and mro_id_role = @w_rol)
      insert into cobis..cew_menu_role(mro_id_menu, mro_id_role) values(@w_menu, @w_rol)
end
else
begin
   print 'NO EXISTE PADRE'
end
go

print 'Insertando Menu Mantenimiento de Garantias'

declare @id_menu        int,
        @id_menu_parent int,
        @w_rol          int

select @w_rol = ro_rol
  from cobis..ad_rol
 where ro_descripcion = 'MENU POR PROCESOS'

select @id_menu_parent = me_id from cew_menu
 where me_name = 'MNU_WARRANTIES'

select @id_menu= (max(me_id)+1) from cobis..cew_menu

if not exists(select 1 from cew_menu where me_name = 'MNU_WARR_MANT')
   insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product)
   values(@id_menu,@id_menu_parent,'MNU_WARR_MANT',null,19)
else
   update cew_menu set me_id_parent = @id_menu_parent, me_id_cobis_product = 19
   where me_name = 'MNU_WARR_MANT'

select @id_menu = me_id from cew_menu where me_name = 'MNU_WARR_MANT'

if not exists(select 1 from cew_menu_role where mro_id_menu = @id_menu and mro_id_role = @w_rol)
   insert into cobis..cew_menu_role(mro_id_menu,mro_id_role) values(@id_menu,@w_rol)
go

print 'Insertando Menu Mantenimiento/Creacion de Garantias'

declare @w_menu        int,
        @w_menu_padre  int,
        @w_producto    int,
        @w_rol         int,
        @w_url         varchar(255),
        @w_nomb_padre  varchar(100),
        @w_nombre      varchar(100)

select @w_rol = ro_rol
  from cobis..ad_rol
 where ro_descripcion = 'MENU POR PROCESOS'
   
select @w_producto    = 19,
       @w_nomb_padre  = 'MNU_WARR_MANT',
       @w_nombre      = 'MNU_WARR_MANT_CREATION',
       @w_url         = 'views\collateral\collateral-container.html?type=M&mod=businessprocess&id=process&pag=busin-tree-process-page&ctr=busin-tree-process-ctrl&srv=busin-tree-process-srv'
select @w_menu_padre = me_id
  from cobis..cew_menu
 where me_name = @w_nomb_padre

select @w_menu = (max(me_id) + 1)
  from cobis..cew_menu

if (@w_menu_padre is not null and @w_rol is not null)
begin
   if not exists (select 1 from cobis..cew_menu where me_name = @w_nombre)
      insert into cobis..cew_menu(me_id, me_id_parent, me_name, me_url, me_id_cobis_product)
      values(@w_menu, @w_menu_padre, @w_nombre, @w_url, @w_producto)
   else
      update cew_menu set me_id_parent = @w_menu_padre, me_id_cobis_product = 19
      where me_name = @w_nombre

   select @w_menu = me_id from cew_menu where me_name = @w_nombre

   if not exists (select 1 from cobis..cew_menu_role where mro_id_menu = @w_menu and mro_id_role = @w_rol)
      insert into cobis..cew_menu_role(mro_id_menu, mro_id_role) values(@w_menu, @w_rol) 
end
else
begin
   print 'NO EXISTE PADRE'
end
go


print 'Insertando Menu Mantenimiento/Modificacion de Garantias'

declare  @w_menu        int,
         @w_menu_padre  int,
         @w_producto    int,
         @w_rol         int,
         @w_url         varchar(255),
         @w_nomb_padre  varchar(100),
         @w_nombre      varchar(100)

select @w_rol = ro_rol 
   from cobis..ad_rol
   where ro_descripcion = 'MENU POR PROCESOS'
   
select   @w_producto    = 19,
         @w_nomb_padre  = 'MNU_WARR_MANT',
         @w_nombre      = 'MNU_WARR_MANT_MODIFICATION',
         @w_url         = 'views\collateral\collateral-container.html?type=D&mod=BUSIN&sub=FLCRE&task=T_FLCRE_35_RRCAI67&ver=1.0.0&view=VC_RRCAI67_WACRI_884&option=2'

select @w_menu_padre = me_id
  from cobis..cew_menu
 where me_name = @w_nomb_padre

select @w_menu = (max(me_id) + 1)
  from cobis..cew_menu

if (@w_menu_padre is not null and @w_rol is not null)
begin
   if not exists (select 1 from cobis..cew_menu where me_name = @w_nombre)
      insert into cobis..cew_menu(me_id, me_id_parent, me_name, me_url, me_id_cobis_product)
      values(@w_menu, @w_menu_padre, @w_nombre, @w_url, @w_producto)
   else
      update cew_menu set me_id_parent = @w_menu_padre, me_id_cobis_product = 19
      where me_name = @w_nombre

   select @w_menu = me_id from cew_menu where me_name = @w_nombre

   if not exists (select 1 from cobis..cew_menu_role where mro_id_menu = @w_menu and mro_id_role = @w_rol)
      insert into cobis..cew_menu_role(mro_id_menu, mro_id_role) values(@w_menu, @w_rol) 
end
else
begin
   print 'NO EXISTE PADRE'
end
go

