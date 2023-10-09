use cobis
go

declare @w_menu_parent_id INT,
        @w_menu_id INT,
        @w_producto int,
        @w_rol int,
        @w_menu_order int   


select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'
select @w_menu_parent_id = me_id from cew_menu where me_name = 'MNU_CUSTOMER_OPER'
select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id

select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

if @w_menu_parent_id is not null
begin

    if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES')
	begin 
		if not exists (select 1 from cew_menu where me_name = 'MNU_ALTA_COLEC')
	    begin
	        select @w_menu_id    = isnull( max(me_id), 0 ) + 1 from cew_menu
	        select @w_menu_order = isnull( max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
	        insert into cobis..cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	        values (@w_menu_id, @w_menu_parent_id, 'MNU_ALTA_COLEC', 1,'views/CLCOL/CLTVO/T_CLCOLIQAJNDTG_333/1.0.0/VC_LOADCOLLEV_719333_TASK.html?mode=1', @w_menu_order, 
	        @w_producto, 0, 'Alta masivo colectivos')
	    end    
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_ALTA_COLEC'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end
	end
	else
	begin
		
		select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
		
		if not exists (select 1 from cew_menu where me_name = 'MNU_ALTA_COLEC')
	    begin
	        select @w_menu_id = isnull( max(me_id), 0 ) + 1 from cew_menu
	        select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
	        insert into dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	        values (@w_menu_id, @w_menu_parent_id, 'MNU_ALTA_COLEC', 1,'views/CLCOL/CLTVO/T_CLCOLIQAJNDTG_333/1.0.0/VC_LOADCOLLEV_719333_TASK.html?mode=1', @w_menu_order, 
	        @w_producto, 0, 'Alta masivo colectivos')
	    end    
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_ALTA_COLEC'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end
	end
end
else
begin
    print 'No existe el menu padre: MNU_ADMIN'
end


/*Asigancion de rol a las vistas*/
USE cobis
go

declare @w_id_resource int, @w_rol INT,@w_cod int
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'
select 'Id_Role' = @w_rol

SELECT @w_cod=isnull(max(re_id),0)  FROM cobis..cew_resource

 
IF NOT EXISTS(SELECT 1  FROM cobis..cew_resource WHERE re_pattern= '/cobis/web/views/CLCOL/.*')
BEGIN
 PRINT 'a'
  INSERT INTO dbo.cew_resource (re_id, re_pattern)
  VALUES (@w_cod+1, '/cobis/web/views/CLCOL/.*')

END

select @w_id_resource = re_id from cobis..cew_resource where re_pattern = '/cobis/web/views/CLCOL/.*'
select 'Id_Resource' = @w_id_resource

IF NOT EXISTS(select 1 from cobis..cew_resource_rol where rro_id_resource = @w_id_resource and rro_id_rol = @w_rol)
BEGIN
 PRINT 'b'
insert into cobis..cew_resource_rol (rro_id_resource, rro_id_rol)
values (@w_id_resource, @w_rol)
END


--Rol Administrador
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'

IF NOT EXISTS(select 1 from cobis..cew_resource_rol where rro_id_resource = @w_id_resource and rro_id_rol = @w_rol)
BEGIN
   insert into cobis..cew_resource_rol (rro_id_resource, rro_id_rol)
   values (@w_id_resource, @w_rol)
END

go

    

-------------------
use cobis
go

declare @w_menu_parent_id INT,
        @w_menu_id INT,
        @w_producto int,
        @w_rol int,
        @w_menu_order int   


select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'
select @w_menu_parent_id = me_id from cew_menu where me_name = 'MNU_ASSETS'
select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id

select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CARTERA'

if @w_menu_parent_id is not null
begin

    if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES')
	begin 
		if not exists (select 1 from cew_menu where me_name = 'MNU_ALTA_ADVISOR')
	    begin
	        select @w_menu_id    = isnull( max(me_id), 0 ) + 1 from cew_menu
	        select @w_menu_order = isnull( max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
	        insert into cobis..cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	        values (@w_menu_id, @w_menu_parent_id, 'MNU_ALTA_ADVISOR', 1,'views/CLCOL/CLTVO/T_CLCOLETZFPPIC_497/1.0.0/VC_LOADEXTERA_441497_TASK.html?mode=2', @w_menu_order, 
	        @w_producto, 0, 'Alta masivo Asesor')
	    end    
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_ALTA_ADVISOR'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end
	end
	else
	begin
		
		select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
		
		if not exists (select 1 from cew_menu where me_name = 'MNU_ALTA_ADVISOR')
	    begin
	        select @w_menu_id = isnull( max(me_id), 0 ) + 1 from cew_menu
	        select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
	        insert into cobis..cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	        values (@w_menu_id, @w_menu_parent_id, 'MNU_ALTA_ADVISOR', 1,'views/CLCOL/CLTVO/T_CLCOLETZFPPIC_497/1.0.0/VC_LOADEXTERA_441497_TASK.html?mode=2', @w_menu_order, 
	        @w_producto, 0, 'Alta masivo Asesor')
	    end    
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_ALTA_ADVISOR'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end
	end
end
else
begin
    print 'No existe el menu padre: MNU_ASSETS'
end

-- Pantalla Rol Asesor Colectivo
-- Rol MESA DE OPERACIONES
select @w_menu_parent_id = me_id from cew_menu where me_name = 'MNU_ADMIN'

if @w_menu_parent_id is not null
begin
	if not exists (select 1 from cew_menu where me_name = 'MNU_ADVISOR_ROLE')
    begin
        select @w_menu_id    = isnull( max(me_id), 0 ) + 1 from cew_menu
        select @w_menu_order = isnull( max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
        insert into cobis..cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
        values (@w_menu_id, @w_menu_parent_id, 'MNU_ADVISOR_ROLE', 1,'views/CLCOL/CLTVO/T_CLCOLWGNHFDMI_872/1.0.0/VC_COLLECTIAV_943872_TASK.html', @w_menu_order, 
        @w_producto, 0, 'Rol Asesor Colectivo')
    end    
    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_ADVISOR_ROLE'    
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
        insert into cew_menu_role values (@w_menu_id, @w_rol)
    end
end
else
begin
    print 'No existe el menu padre: MNU_ADMIN'
end

-- Pantalla Rol Asesor Colectivo
-- Rol ADMINISTRADOR

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
select @w_menu_parent_id = me_id from cew_menu where me_name = 'MNU_ADMIN'

if @w_menu_parent_id is not null
begin
	if not exists (select 1 from cew_menu where me_name = 'MNU_ADVISOR_ROLE')
    begin
        select @w_menu_id    = isnull( max(me_id), 0 ) + 1 from cew_menu
        select @w_menu_order = isnull( max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
        insert into cobis..cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
        values (@w_menu_id, @w_menu_parent_id, 'MNU_ADVISOR_ROLE', 1,'views/CLCOL/CLTVO/T_CLCOLWGNHFDMI_872/1.0.0/VC_COLLECTIAV_943872_TASK.html', @w_menu_order, 
        @w_producto, 0, 'Rol Asesor Colectivo')
    end    
    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_ADVISOR_ROLE'    
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
        insert into cew_menu_role values (@w_menu_id, @w_rol)
    end
end
else
begin
    print 'No existe el menu padre: MNU_ADMIN'
end

use cobis
go
if not exists (select 1 from cobis..cl_parametro
               where pa_nemonico='URLGXM' and pa_producto='CLI' )
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('URL GEOLOCALIZACION XML', 'URLGXM', 'C', '/maps/api/geocode/xml?', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
go







