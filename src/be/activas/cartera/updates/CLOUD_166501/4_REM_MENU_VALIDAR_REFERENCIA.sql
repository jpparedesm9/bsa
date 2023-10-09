use cobis
go
DECLARE @w_menu_parent_id INT, @w_menu_id INT, @w_rol INT,@w_producto INT, @w_menu_order tinyint
-- \bsa\src\be\clientes\installer\sql\cl_cew_menu.sql
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'
SELECT @w_rol = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'SOCIO COMERCIAL'
--- SELECT @w_rol = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'FUNCIONARIO OFICINA'

IF NOT EXISTS (SELECT 1 FROM cew_menu WHERE me_name = 'MNU_VALIDAR_REFERENCIA')
BEGIN
	PRINT 'Ingresa a crear el menu para la pantalla Validar Referencia'

	SELECT @w_menu_id = ISNULL(MAX(me_id), 0) + 1
	FROM cew_menu

	SELECT @w_menu_order = 1

	INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
	VALUES (@w_menu_id, @w_menu_parent_id, 'MNU_VALIDAR_REFERENCIA', 1, 'views/CSTMR/CSTMR/T_CSTMRKRGHIVHP_582/1.0.0/VC_VALIDATERE_626582_TASK.html', @w_menu_order, @w_producto, 0, 'Validar Referencia')
END

SELECT @w_menu_id = me_id
FROM cew_menu
WHERE me_name = 'MNU_VALIDAR_REFERENCIA'

IF @w_rol > 0
BEGIN
	IF NOT EXISTS (
			SELECT 1
			FROM cew_menu_role
			WHERE mro_id_menu = @w_menu_id
				AND mro_id_role = @w_rol
			)
	BEGIN
		INSERT INTO cew_menu_role
		VALUES (@w_menu_id, @w_rol)
	END
END
go
