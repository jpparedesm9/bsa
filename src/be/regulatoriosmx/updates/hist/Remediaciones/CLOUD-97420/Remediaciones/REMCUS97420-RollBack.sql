--------------------------------------------------------------------------------------------
-- Agregar menú Traspasos
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 

use cobis
go

declare @w_menu_id INT

if exists (select 1 from cobis..ad_rol where ro_descripcion = 'COORDINADOR')
begin
    delete cobis..ad_rol where ro_descripcion = 'COORDINADOR'
end

if exists (select 1 from cobis..ad_rol where ro_descripcion = 'GERENTE DE SUCURSAL')
begin
    delete cobis..ad_rol where ro_descripcion = 'GERENTE DE SUCURSAL'
end

if exists (select 1 from cobis..ad_rol where ro_descripcion = 'GERENTE REGIONAL')
begin
    delete cobis..ad_rol where ro_descripcion = 'GERENTE REGIONAL'
end

if exists (select 1 from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES')
begin
    delete cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'
end

--------------------------------------------------------------------------------------------
-- Eliminar menú solicitud Traspasos
--------------------------------------------------------------------------------------------

select @w_menu_id = me_id from cew_menu where me_name = 'MNU_SOL_TRANSFER' 
if exists (select 1 from cew_menu where me_name = 'MNU_SOL_TRANSFER')
begin
	select @w_menu_id = me_id from cew_menu where me_name = 'MNU_SOL_TRANSFER' 
	delete cew_menu_role where mro_id_menu = @w_menu_id
	delete cew_menu where me_id = @w_menu_id
end

--------------------------------------------------------------------------------------------
-- Agregar menú autorización Traspasos
--------------------------------------------------------------------------------------------

select @w_menu_id = me_id from cew_menu where me_name = 'MNU_AUTO_TRANSFER' 
if exists (select 1 from cew_menu where me_name = 'MNU_AUTO_TRANSFER')
begin
	select @w_menu_id = me_id from cew_menu where me_name = 'MNU_AUTO_TRANSFER' 
	delete cew_menu_role where mro_id_menu = @w_menu_id
	delete cew_menu where me_id = @w_menu_id
end

--------------------------------------------------------------------------------------------
-- Eliminar menu Traspasos
--------------------------------------------------------------------------------------------

select @w_menu_id = me_id from cew_menu where me_name = 'MNU_TRANSFER' 
if exists (select 1 from cew_menu where me_name = 'MNU_TRANSFER')
begin
	select @w_menu_id = me_id from cew_menu where me_name = 'MNU_TRANSFER' 
	delete cew_menu_role where mro_id_menu = @w_menu_id
	delete cew_menu where me_id = @w_menu_id
end

