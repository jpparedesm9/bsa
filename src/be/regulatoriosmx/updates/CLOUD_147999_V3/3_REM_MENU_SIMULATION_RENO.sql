--------------------------------------------------------------------------------------------
-- REGISTRO DE MENU DE PANTALLA SIMULACIÓN RENOVACIONES FINANCIADAS
--------------------------------------------------------------------------------------------
-- Ruta TFS                   :
-- Nombre Archivo             : .sql
-- Parametrizar el rol
---------------------------------------------------------------------------------------------
-- MENU PARA PANTALLA DE RESETEO
---------------------------------------------------------------------------------------------
USE cobis 
GO

DECLARE @w_menu_parent_id INT, @w_menu_id INT, @w_menu_id_1 INT, @w_producto INT, @w_rol INT, @w_rol_1 INT, @w_menu_order INT

/*Creacion de menu*/
SELECT @w_menu_parent_id = me_id
FROM cew_menu
WHERE me_name = 'MNU_ASSETS_QUERY'

PRINT 'Menu Padre -> ' + convert(VARCHAR(10), @w_menu_parent_id)

SELECT @w_menu_order = ISNULL(MAX(me_id), 0)
FROM cew_menu
WHERE me_id_parent = @w_menu_parent_id

PRINT 'Secuencial tabla de menus -> ' + convert(VARCHAR(10), @w_menu_order)

SELECT @w_producto = pd_producto
FROM cl_producto
WHERE pd_descripcion = 'CARTERA'

PRINT 'Producto -> ' + convert(VARCHAR(10), @w_producto)

SELECT @w_rol = ro_rol
FROM cobis..ad_rol
WHERE ro_descripcion = 'ASESOR'

PRINT 'Rol -> ' + convert(VARCHAR(10), @w_rol)

IF @w_menu_parent_id IS NOT NULL
BEGIN
	IF EXISTS (SELECT 1 FROM cobis..ad_rol WHERE ro_descripcion = 'ASESOR')
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM cew_menu WHERE me_name = 'MNU_SIMUL_RENOV_FIN')
		BEGIN
			PRINT 'Ingresa a crear el menu para la pantalla de simulación'

			SELECT @w_menu_id = ISNULL(MAX(me_id), 0) + 1
			FROM cew_menu

			SELECT @w_menu_order = ISNULL(MAX(me_id), 0)
			FROM cew_menu
			WHERE me_id_parent = @w_menu_parent_id

			INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
			VALUES (@w_menu_id, @w_menu_parent_id, 'MNU_SIMUL_RENOV_FIN', 1, 'views/LOANS/GROUP/T_LOANSYBASRMCC_810/1.0.0/VC_SIMULATIEE_163810_TASK.html', @w_menu_order, @w_producto, 0, 'Simulación Renovaciones Financiadas')
		END

		SELECT @w_menu_id = me_id
		FROM cew_menu
		WHERE me_name = 'MNU_SIMUL_RENOV_FIN'

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
	ELSE
	BEGIN
		SELECT @w_rol = ro_rol
		FROM cobis..ad_rol
		WHERE ro_descripcion = 'ADMINISTRADOR'

		IF NOT EXISTS (
				SELECT 1
				FROM cew_menu
				WHERE me_name = 'MNU_SIMUL_RENOV_FIN'
				)
		BEGIN
			SELECT @w_menu_id = ISNULL(MAX(me_id), 0) + 1
			FROM cew_menu

			SELECT @w_menu_order = ISNULL(MAX(me_id), 0)
			FROM cew_menu
			WHERE me_id_parent = @w_menu_parent_id

			INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description)
			VALUES (@w_menu_id, @w_menu_parent_id, 'MNU_SIMUL_RENOV_FIN', 1, 'views/LOANS/GROUP/T_LOANSYBASRMCC_810/1.0.0/VC_SIMULATIEE_163810_TASK.html', @w_menu_order, @w_producto, 0, 'Simulación Renovaciones Financiadas')
		END

		SELECT @w_menu_id = me_id
		FROM cew_menu
		WHERE me_name = 'MNU_SIMUL_RENOV_FIN'

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
END
ELSE
BEGIN
	PRINT 'No existe el menu padre: MNU_ASSETS_QUERY'
END

/*Asigancion de rol a las vistas*/
/* Menu Call Center*/
USE cobis 
GO

DECLARE 
@w_id_resource 	INT, 
@w_rol 			INT, 
@w_cod 			INT

SELECT @w_rol = ro_rol
FROM cobis..ad_rol
WHERE ro_descripcion = 'ASESOR'

SELECT 'Id_Role' = @w_rol

SELECT @w_cod = ISNULL(MAX(re_id), 0)
FROM cobis..cew_resource

IF NOT EXISTS (
		SELECT 1
		FROM cobis..cew_resource
		WHERE re_pattern = '/cobis/web/views/LOANS/.*'
		)
BEGIN
	PRINT 'a'

	INSERT INTO dbo.cew_resource (re_id, re_pattern)
	VALUES (@w_cod + 1, '/cobis/web/views/LOANS/.*')
END

SELECT @w_id_resource = re_id
FROM cobis..cew_resource
WHERE re_pattern = '/cobis/web/views/LOANS/.*'

SELECT 'Id_Resource' = @w_id_resource

IF NOT EXISTS (
		SELECT 1
		FROM cobis..cew_resource_rol
		WHERE rro_id_resource = @w_id_resource
			AND rro_id_rol = @w_rol
		)
BEGIN
	PRINT 'b'

	INSERT INTO dbo.cew_resource_rol (rro_id_resource, rro_id_rol)
	VALUES (@w_id_resource, @w_rol)
END
