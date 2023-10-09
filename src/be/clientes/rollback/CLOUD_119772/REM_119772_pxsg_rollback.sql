use cobis
go
declare @w_menu_parent_id INT,
        @w_menu_id INT,
        @w_menu_id_1 INT,
        @w_producto int,
        @w_rol int,
        @w_rol_1 int,
        @w_menu_order INT
        
 select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'
    
 select @w_menu_id = me_id from cobis..cew_menu where me_name = 'MNU_ALTA_COLEC'
 
 --select * from cobis..cew_menu_role where mro_id_menu = 168 and mro_id_role = 29
    
if exists (select 1 from cobis..cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
begin
    DELETE FROM cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol 
end         
        
if  exists (select 1 from cew_menu where me_name = 'MNU_ALTA_COLEC')
BEGIN

 DELETE FROM cobis..cew_menu WHERE me_name = 'MNU_ALTA_COLEC'
 
END
go

-- Menu Rol Asesor Colectivo

use cobis
go
declare @w_menu_parent_id INT,
        @w_menu_id INT,
        @w_menu_id_1 INT,
        @w_producto int,
        @w_rol int,
        @w_rol_1 int,
        @w_menu_order INT
 
 -- Rol MESA DE OPERACIONES
 select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'
    
 select @w_menu_id = me_id from cobis..cew_menu where me_name = 'MNU_ADVISOR_ROLE'
 
    
if exists (select 1 from cobis..cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
begin
    delete from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol 
end         
        
if  exists (select 1 from cew_menu where me_name = 'MNU_ADVISOR_ROLE')
begin

 delete from cobis..cew_menu where me_name = 'MNU_ADVISOR_ROLE'
 
end

-- Rol ADMINISTRADOR
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
    
select @w_menu_id = me_id from cobis..cew_menu where me_name = 'MNU_ADVISOR_ROLE'

if exists (select 1 from cobis..cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
begin
    delete from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol 
end         
        
if  exists (select 1 from cew_menu where me_name = 'MNU_ADVISOR_ROLE')
begin

 delete from cobis..cew_menu where me_name = 'MNU_ADVISOR_ROLE'
 
end

go


      

USE cobis
GO

declare @w_id_resource int, @w_rol INT,@w_cod INT


select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'
select 'Id_Role' = @w_rol

select @w_id_resource = re_id from cobis..cew_resource where re_pattern = '/cobis/web/views/CLCOL/.*'
select 'Id_Resource' = @w_id_resource

IF EXISTS(select 1 from cobis..cew_resource_rol where rro_id_resource = @w_id_resource and rro_id_rol = @w_rol)
BEGIN

DELETE  from cobis..cew_resource_rol where rro_id_resource = @w_id_resource and rro_id_rol = @w_rol

END


IF EXISTS(SELECT 1  FROM cobis..cew_resource WHERE re_pattern= '/cobis/web/views/CLCOL/.*')
BEGIN
DELETE FROM cobis..cew_resource WHERE re_pattern= '/cobis/web/views/CLCOL/.*'
END

go

use cobis
go
delete cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.validateAccountAndBucFromSantander'
delete cobis..ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.validateAccountAndBucFromSantander'
go

use cobis
go
delete from cobis..cl_parametro
where pa_nemonico='URLGXM' and pa_producto='CLI' 
go
