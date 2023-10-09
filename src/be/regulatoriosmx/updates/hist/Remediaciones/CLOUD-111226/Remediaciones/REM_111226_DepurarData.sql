USE cobis
GO

--Mantenimiento de Direcciones
DELETE  cobis..cew_menu_role WHERE mro_id_menu=33
DELETE  cew_menu WHERE me_id=33

--Mantenimiento de Negocio
DELETE  cobis..cew_menu_role WHERE mro_id_menu=31
DELETE  cew_menu WHERE me_id=31

--Mantenimiento de Referencias
DELETE  cobis..cew_menu_role WHERE mro_id_menu=32
DELETE  cew_menu WHERE me_id=32

--Menu Prospectos en el Administrador
DELETE cobis..cew_menu_role WHERE mro_id_menu=69
DELETE cobis..cew_menu WHERE  me_id=69 

--Reasignacion
update cobis..cew_menu
SET me_description ='Reasignación'
WHERE me_id=100

--Consulta Alerta de riesgo
update cobis..cew_menu
SET me_description ='Consulta Alerta de riesgo'
WHERE me_id=156

--Buzon de Tareas del oficial (oficial inbox)
update cobis..cew_menu
SET me_description ='Oficial Inbox'
WHERE me_id=99

--Transacciones de Negocio (Maker and Checker)
DELETE cobis..cew_menu WHERE  me_id=104

--Menu Maker and Checker
DELETE cobis..cew_menu WHERE  me_id=90

--Consulta de Reclamos
DELETE cobis..cew_menu WHERE me_id= 103

--Categoria y Subcategoria
DELETE cobis..cew_menu_role WHERE mro_id_menu=102
DELETE cobis..cew_menu WHERE me_id= 102

--Gestion de reclamos
DELETE  cobis..cew_menu WHERE me_id= 88

--Alertas PDL y FT
DELETE cobis..cew_menu_role WHERE mro_id_menu=139
DELETE  cobis..cew_menu WHERE me_id= 139

--Estado de cuenta
DELETE cobis..cew_menu_role WHERE mro_id_menu=138
DELETE  cobis..cew_menu WHERE me_id= 138

--INGRESAR ROL NORMATIVO A LA FUNCIONALIDAD DE MATRIZ DE RIESGO
IF NOT exists (SELECT 1 FROM cobis..cew_resource_rol WHERE rro_id_resource = 21 AND rro_id_rol = 31)
   INSERT INTO cew_resource_rol (rro_id_resource, rro_id_rol)
   VALUES (21, 31)

GO
