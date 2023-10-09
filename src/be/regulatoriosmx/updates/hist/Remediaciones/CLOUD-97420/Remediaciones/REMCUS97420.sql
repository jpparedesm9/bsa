--------------------------------------------------------------------------------------------
-- Agregar menú Traspasos
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 

use cobis
go

declare @w_menu_parent_id INT,
        @w_menu_id INT,
        @w_producto int,
        @w_rol int,
		@w_rol1 int,
		@w_rol2 int,
		@w_rol3 int,
		@w_rol4 int,
        @w_menu_order int   

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'COORDINADOR')
begin
    select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
    insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
    values (@w_rol, 1, 'COORDINADOR', getdate(), 1, 'V', getdate(), 9000)
end

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'GERENTE DE SUCURSAL')
begin
    select @w_rol1 =  max(ro_rol)+2 from cobis..ad_rol
    insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
    values (@w_rol1, 1, 'GERENTE DE SUCURSAL', getdate(), 1, 'V', getdate(), 9000)
end

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'GERENTE REGIONAL')
begin
    select @w_rol2 =  max(ro_rol)+3 from cobis..ad_rol
    insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
    values (@w_rol2, 1, 'GERENTE REGIONAL', getdate(), 1, 'V', getdate(), 9000)
end

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES')
begin
    select @w_rol3 =  max(ro_rol)+4 from cobis..ad_rol
    insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
    values (@w_rol3, 1, 'MESA DE OPERACIONES', getdate(), 1, 'V', getdate(), 9000)
end




select @w_producto = pd_producto from cl_producto where pd_descripcion = 'ADMINISTRACION'
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'COORDINADOR'
select @w_rol1 = ro_rol from cobis..ad_rol where ro_descripcion = 'GERENTE DE SUCURSAL'
select @w_rol2 = ro_rol from cobis..ad_rol where ro_descripcion = 'GERENTE REGIONAL'
select @w_rol3 = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'
select @w_rol4 = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_menu_parent_id = me_id from cew_menu where me_name = 'MNU_ADMIN'
select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
if not exists (select 1 from cew_menu where me_name = 'MNU_TRANSFER')
begin
	select @w_menu_id = isnull( max(me_id), 0 ) + 1 from cew_menu
	insert into dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	values (@w_menu_id, @w_menu_parent_id, 'MNU_TRANSFER', 1,null, @w_menu_order, 
	@w_producto, 0, 'Traspasos')
end
select @w_menu_id = me_id from cew_menu where me_name = 'MNU_TRANSFER'    
if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
begin
	insert into cew_menu_role values (@w_menu_id, @w_rol)
end  
   
if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol1)
begin
	insert into cew_menu_role values (@w_menu_id, @w_rol1)
end 

if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol2)
begin
	insert into cew_menu_role values (@w_menu_id, @w_rol2)
end 

if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol3)
begin
	insert into cew_menu_role values (@w_menu_id, @w_rol3)
end 
if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol4)
begin
	insert into cew_menu_role values (@w_menu_id, @w_rol4)
end 

/* Insertar al Menu Padre */
if not exists (select 1 from cew_menu where me_name = 'MNU_ADMIN')
begin
	if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_parent_id and mro_id_role = @w_rol)
	begin
		insert into cew_menu_role values (@w_menu_parent_id, @w_rol)
	end  
	if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_parent_id and mro_id_role = @w_rol1)
	begin
		insert into cew_menu_role values (@w_menu_parent_id, @w_rol1)
	end 
	if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_parent_id and mro_id_role = @w_rol2)
	begin
		insert into cew_menu_role values (@w_menu_parent_id, @w_rol2)
	end 
	if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_parent_id and mro_id_role = @w_rol3)
	begin
		insert into cew_menu_role values (@w_menu_parent_id, @w_rol3)
	end 
	if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_parent_id and mro_id_role = @w_rol4)
	begin
		insert into cew_menu_role values (@w_menu_parent_id, @w_rol4)
	end 
end


--------------------------------------------------------------------------------------------
-- Agregar menú solicitud Traspasos
--------------------------------------------------------------------------------------------
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'COORDINADOR'
select @w_rol1 = ro_rol from cobis..ad_rol where ro_descripcion = 'GERENTE DE SUCURSAL'
select @w_rol2 = ro_rol from cobis..ad_rol where ro_descripcion = 'GERENTE REGIONAL'
select @w_rol3 = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'
select @w_rol4 = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_menu_parent_id = me_id from cew_menu where me_name = 'MNU_TRANSFER'
select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id

if @w_menu_parent_id is not null
begin
    if exists(select 1 from cobis..ad_rol where ro_descripcion = 'COORDINADOR')
	begin 
		if not exists (select 1 from cew_menu where me_name = 'MNU_SOL_TRANSFER')
	    begin
	        select @w_menu_id = isnull( max(me_id), 0 ) + 2 from cew_menu
	        select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
	        insert into dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	        values (@w_menu_id, @w_menu_parent_id, 'MNU_SOL_TRANSFER', 1,'views/CSTMR/CSTMR/T_CSTMRTCAJUPXM_188/1.0.0/VC_TRANSFERUR_363188_TASK.html', @w_menu_order, 
	        @w_producto, 0, 'Solicitud de Traspaso')
	    end    
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_SOL_TRANSFER'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end
		if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol1)
		begin
			insert into cew_menu_role values (@w_menu_id, @w_rol1)
		end 

		if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol2)
		begin
			insert into cew_menu_role values (@w_menu_id, @w_rol2)
		end 

		if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol3)
		begin
			insert into cew_menu_role values (@w_menu_id, @w_rol3)
		end
		if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol4)
		begin
			insert into cew_menu_role values (@w_menu_id, @w_rol4)
		end
	end
	else
	begin
		
		select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
		
		if not exists (select 1 from cew_menu where me_name = 'MNU_SOL_TRANSFER')
	    begin
	        select @w_menu_id = isnull( max(me_id), 0 ) + 2 from cew_menu
	        select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
	        insert into dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	        values (@w_menu_id, @w_menu_parent_id, 'MNU_SOL_TRANSFER', 1,'views/CSTMR/CSTMR/T_CSTMRTCAJUPXM_188/1.0.0/VC_TRANSFERUR_363188_TASK.html', @w_menu_order, 
	        @w_producto, 0, 'Solicitud de Traspaso')
	    end    
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_SOL_TRANSFER'    
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



--------------------------------------------------------------------------------------------
-- Agregar menú autorización Traspasos
--------------------------------------------------------------------------------------------
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'COORDINADOR'
select @w_rol1 = ro_rol from cobis..ad_rol where ro_descripcion = 'GERENTE DE SUCURSAL'
select @w_rol2 = ro_rol from cobis..ad_rol where ro_descripcion = 'GERENTE REGIONAL'
select @w_rol3 = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'
select @w_menu_parent_id = me_id from cew_menu where me_name = 'MNU_TRANSFER'
select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id

if @w_menu_parent_id is not null
begin
    if exists(select 1 from cobis..ad_rol where ro_descripcion = 'COORDINADOR')
	begin 
		if not exists (select 1 from cew_menu where me_name = 'MNU_AUTO_TRANSFER')
	    begin
	        select @w_menu_id = isnull( max(me_id), 0 ) + 3 from cew_menu
	        select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
	        insert into dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	        values (@w_menu_id, @w_menu_parent_id, 'MNU_AUTO_TRANSFER', 1,'views/CSTMR/CSTMR/T_CSTMRTVGMFYGK_259/1.0.0/VC_AUTHORIZOS_306259_TASK.html', @w_menu_order, 
	        @w_producto, 0, 'Autorizacion de Traspaso')
	    end    
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_AUTO_TRANSFER'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end
		if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol1)
		begin
			insert into cew_menu_role values (@w_menu_id, @w_rol1)
		end 

		if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol2)
		begin
			insert into cew_menu_role values (@w_menu_id, @w_rol2)
		end 

		if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol3)
		begin
			insert into cew_menu_role values (@w_menu_id, @w_rol3)
		end
		if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol4)
		begin
			insert into cew_menu_role values (@w_menu_id, @w_rol4)
		end
	end
	else
	begin
		
		select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
		
		if not exists (select 1 from cew_menu where me_name = 'MNU_AUTO_TRANSFER')
	    begin
	        select @w_menu_id = isnull( max(me_id), 0 ) + 3 from cew_menu
	        select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
	        insert into dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	        values (@w_menu_id, @w_menu_parent_id, 'MNU_AUTO_TRANSFER', 1,'views/CSTMR/CSTMR/T_CSTMRTVGMFYGK_259/1.0.0/VC_AUTHORIZOS_306259_TASK.html', @w_menu_order, 
	        @w_producto, 0, 'Autorizacion de Traspaso')
	    end    
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_AUTO_TRANSFER'    
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



go

declare @w_rol int

 select @w_rol = isnull( max(ro_rol), 0 ) + 1
 from ad_rol

update cl_seqnos
        set siguiente = @w_rol
        where tabla = 'ad_rol'
go

