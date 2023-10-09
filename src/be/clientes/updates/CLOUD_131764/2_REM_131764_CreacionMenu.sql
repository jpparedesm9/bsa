use cobis
go

        
	
/*Creacion de cew_menu_role MNU_EXCLUSION_LIST*/
use cobis
go

declare @w_menu_parent_id INT,
        @w_menu_id INT,
        @w_producto int,
        @w_rol int,
        @w_menu_order int   

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'
select @w_menu_parent_id = me_id_parent from cew_menu where me_name = 'MNU_PROSPECTS'
select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id

select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

if @w_menu_parent_id is not null
begin

    if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES')
	begin 
		if not exists (select 1 from cew_menu where me_name = 'MNU_EXCLUSION_LIST')
	    begin
	        select @w_menu_id    = isnull( max(me_id), 0 ) + 1 from cew_menu
	        select @w_menu_order = isnull( max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
	        insert into dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	        values (@w_menu_id, @w_menu_parent_id, 'MNU_EXCLUSION_LIST', 1,'views\LOANS\GROUP\T_LOANSUAYYOAVM_556\1.0.0\VC_EXCLUSIOSL_682556_TASK.html', @w_menu_order, 
	        @w_producto, 0, 'Lista de Exclusion de Clientes')
	    end    
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_EXCLUSION_LIST'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end
	end   
end
else
begin
    print 'No existe el menu padre: MNU_PROSPECTS'
end


/*Asigancion de rol a las vistas*/
USE cobis
go

declare @w_id_resource int, @w_rol INT,@w_cod int
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'
select 'Id_Role' = @w_rol

SELECT @w_cod=isnull(max(re_id),0)  FROM cobis..cew_resource WHERE re_pattern= '/cobis/web/views/LOANS/.*'


IF NOT EXISTS(SELECT 1  FROM cobis..cew_resource WHERE re_pattern= '/cobis/web/views/LOANS/.*')
BEGIN
 PRINT 'a'
  INSERT INTO dbo.cew_resource (re_id, re_pattern)
  VALUES (@w_cod+1, '/cobis/web/views/LOANS/.*')

END

select @w_id_resource = re_id from cobis..cew_resource where re_pattern = '/cobis/web/views/LOANS/.*'
select 'Id_Resource' = @w_id_resource

IF NOT EXISTS(select 1 from cobis..cew_resource_rol where rro_id_resource = @w_id_resource and rro_id_rol = @w_rol)
BEGIN
 PRINT 'b'
insert into dbo.cew_resource_rol (rro_id_resource, rro_id_rol)
values (@w_id_resource, @w_rol)
END

go

