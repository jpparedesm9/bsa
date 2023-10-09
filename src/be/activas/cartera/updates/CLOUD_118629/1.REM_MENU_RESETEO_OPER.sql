--------------------------------------------------------------------------------------------
-- REGISTRO DE MENU DE PANTALLA PARA RESETEO DE IMAGENES Y MENSAJE DE BIENVENIDA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : .sql
-- Parametrizar el rol

---------------------------------------------------------------------------------------------
-- MENU PARA PANTALLA DE RESETEO
---------------------------------------------------------------------------------------------

use cobis
go
declare @w_menu_parent_id INT,
        @w_menu_id INT,
        @w_menu_id_1 INT,
        @w_producto int,
        @w_rol int,
        @w_rol_1 int,
        @w_menu_order INT
        
   /*Creacion de menu*/

    select @w_menu_parent_id = me_id from cew_menu where me_name ='MNU_OPER'
    select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
    select @w_producto = pd_producto from cl_producto where pd_descripcion = 'ADMINISTRACION'
    SELECT @w_rol=ro_rol FROM cobis..ad_rol WHERE ro_descripcion ='OPERACIONES'    
      
    /*Creacion de cew_menu_role MNU_CALL_CENTER*/
    
    select @w_menu_id = me_id from cew_menu where me_name ='MNU_OPER'
    select @w_menu_id_1 = me_id from cew_menu where me_name = 'MNU_CALL_CENTER' 
   
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
    	insert into cobis..cew_menu_role values (@w_menu_id, @w_rol)
    end 
       
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id_1 and mro_id_role = @w_rol)
    begin
    	insert into cobis..cew_menu_role values (@w_menu_id_1, @w_rol)
    end 
	
	/*Creacion de cew_menu_role MNU_RESET_IMAGE_MESSAGE*/
use cobis
go

declare @w_menu_parent_id INT,
        @w_menu_id INT,
        @w_producto int,
        @w_rol int,
        @w_menu_order int   


select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'OPERACIONES'
select @w_menu_parent_id = me_id from cew_menu where me_name = 'MNU_CALL_CENTER'
select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id

select @w_producto = pd_producto from cl_producto where pd_descripcion = 'ADMINISTRACION'

if @w_menu_parent_id is not null
begin

    if exists(select 1 from cobis..ad_rol where ro_descripcion = 'OPERACIONES')
	begin 
		if not exists (select 1 from cew_menu where me_name = 'MNU_RESET_IMAGE_MESSAGE')
	    begin
	        print 'Ingresa a crear el menu de reseteo pantalla'
	        select @w_menu_id    = isnull( max(me_id), 0 ) + 1 from cew_menu
	        select @w_menu_order = isnull( max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
	        insert into dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	        values (@w_menu_id, @w_menu_parent_id, 'MNU_RESET_IMAGE_MESSAGE', 1,'views/ASSCR/CREIR/T_ASSCRLLURZAUF_274/1.0.0/VC_RESETMESME_339274_TASK.html', @w_menu_order, 
	        @w_producto, 0, 'Preguntas Call Center')
	    end
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_RESET_IMAGE_MESSAGE'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end
	end
	else
	begin
		
		select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
		
		if not exists (select 1 from cew_menu where me_name = 'MNU_RESET_IMAGE_MESSAGE')
	    begin
	        select @w_menu_id = isnull( max(me_id), 0 ) + 1 from cew_menu
	        select @w_menu_order = isnull(max(me_id),0) from cew_menu where me_id_parent = @w_menu_parent_id
	        insert into dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	        values (@w_menu_id, @w_menu_parent_id, 'MNU_RESET_IMAGE_MESSAGE', 1,'views/ASSCR/CREIR/T_ASSCRLLURZAUF_274/1.0.0/VC_RESETMESME_339274_TASK.html', @w_menu_order, 
	        @w_producto, 0, 'Preguntas Call Center')
	    end    
	    select @w_menu_id = me_id from cew_menu where me_name = 'MNU_RESET_IMAGE_MESSAGE'    
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
/* Menu Call Center*/
USE cobis
go

declare @w_id_resource int, @w_rol INT,@w_cod int
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'OPERACIONES'
select 'Id_Role' = @w_rol

SELECT @w_cod=isnull(max(re_id),0)  FROM cobis..cew_resource

 
IF NOT EXISTS(SELECT 1  FROM cobis..cew_resource WHERE re_pattern= '/cobis/web/views/ASSCR/.*')
BEGIN
 PRINT 'a'
  INSERT INTO dbo.cew_resource (re_id, re_pattern)
  VALUES (@w_cod+1, '/cobis/web/views/ASSCR/.*')

END

select @w_id_resource = re_id from cobis..cew_resource where re_pattern = '/cobis/web/views/ASSCR/.*'
select 'Id_Resource' = @w_id_resource

IF NOT EXISTS(select 1 from cobis..cew_resource_rol where rro_id_resource = @w_id_resource and rro_id_rol = @w_rol)
BEGIN
 PRINT 'b'
insert into dbo.cew_resource_rol (rro_id_resource, rro_id_rol)
values (@w_id_resource, @w_rol)
END

/* Menu Operaciones*/

USE cobis
go

declare 
@w_rol int,
@w_resource int

select @w_rol = ro_rol 
from cobis..ad_rol
where ro_descripcion = 'OPERACIONES'

select @w_resource = re_id
from cobis..cew_resource
where re_pattern = '/cobis/web/views/customer/.*'

if not exists(select 1 from cobis..cew_resource_rol where rro_id_resource = @w_resource and rro_id_rol = @w_rol)
   insert into cobis..cew_resource_rol values(@w_resource,@w_rol)

go