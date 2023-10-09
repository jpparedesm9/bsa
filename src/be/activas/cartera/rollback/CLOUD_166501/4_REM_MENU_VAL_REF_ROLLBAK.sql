use cobis
go
DECLARE @w_menu_parent_id INT, @w_menu_id INT, @w_rol INT

SELECT @w_rol = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'SOCIO COMERCIAL'
--- SELECT @w_rol = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'FUNCIONARIO OFICINA'

SELECT @w_menu_id = me_id	FROM cew_menu	WHERE me_name = 'MNU_VALIDAR_REFERENCIA'
	
delete from cew_menu_role WHERE mro_id_menu = @w_menu_id AND mro_id_role = @w_rol
delete from cew_menu WHERE me_name = 'MNU_VALIDAR_REFERENCIA'
go

