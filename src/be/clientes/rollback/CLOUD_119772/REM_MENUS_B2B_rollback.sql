USE cobis
GO

DECLARE 
@w_menu_id          INT,
@w_producto         INT,
@w_menu_id_parent   INT,
@w_menu_parent_par  int,
@w_rol_perfil_mov   int,
@w_rol_asesor_mov   int,
@w_rol_asesor_ext   int


SELECT @w_producto = pd_producto 
FROM cobis..cl_producto 
WHERE pd_descripcion = 'BANCA VIRTUAL'

SELECT @w_rol_asesor_ext = ro_rol
FROM cobis..ad_rol
WHERE ro_descripcion = 'ASESOR EXTERNO'

SELECT @w_rol_perfil_mov = ro_rol
FROM cobis..ad_rol
WHERE ro_descripcion = 'PERFIL MOVIL'

SELECT @w_rol_asesor_mov = ro_rol
FROM cobis..ad_rol
WHERE ro_descripcion = 'ASESOR MOVIL'


delete cew_menu_role where mro_id_menu in (
select me_id from cew_menu WHERE me_name IN (
'MNU_B2B_ROOT',
'MNU_B2B_PEOPLE',
'MNU_B2B_GROUP','MNU_B2B_APPLICATIONS',
'MNU_B2B_APPLI',
'MNU_B2B_APPLI_GRUPAL',
'MNU_B2B_APPLI_REVOLVENTE',
'MNU_B2B_APPLI_INDIVIDUAL',
'MNU_B2B_SIMULATION',
'MNU_B2B_TASKS',
'MNU_B2B_ELAVON_PAY',
'MNU_B2B_SYNCHRONIZE',
'MNU_B2B_CONFIGURATION',
'MNU_B2B_CLOSE'
))

DELETE cew_menu WHERE me_name IN (
'MNU_B2B_ROOT',
'MNU_B2B_PEOPLE',
'MNU_B2B_GROUP',
'MNU_B2B_APPLI','MNU_B2B_APPLICATIONS',
'MNU_B2B_APPLI_GRUPAL',
'MNU_B2B_APPLI_REVOLVENTE',
'MNU_B2B_APPLI_INDIVIDUAL',
'MNU_B2B_SIMULATION',
'MNU_B2B_TASKS',
'MNU_B2B_ELAVON_PAY',
'MNU_B2B_SYNCHRONIZE',
'MNU_B2B_CONFIGURATION',
'MNU_B2B_CLOSE'
)

SELECT @w_menu_id = max(me_id) FROM cobis..cew_menu

SELECT @w_menu_id = isnull(@w_menu_id,0)+1
SELECT @w_menu_id_parent= @w_menu_id
INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description, me_version, me_container)
VALUES (@w_menu_id, null, 'MNU_B2B_ROOT', 1, '', 1, @w_producto, 0, 'Root B2B', NULL, 'APK')
if @w_rol_perfil_mov is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_perfil_mov)
if @w_rol_asesor_ext is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_asesor_ext)

SELECT @w_menu_id = isnull(@w_menu_id,0)+1
INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description, me_version, me_container)
VALUES (@w_menu_id, @w_menu_id_parent, 'MNU_B2B_PEOPLE', 1, '', 1, @w_producto, 0, 'Personas', NULL, 'APK')
if @w_rol_perfil_mov is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_perfil_mov)

SELECT @w_menu_id = isnull(@w_menu_id,0)+1
INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description, me_version, me_container)
VALUES (@w_menu_id, @w_menu_id_parent, 'MNU_B2B_GROUP', 1, '', 1, @w_producto, 0, 'Grupos', NULL, 'APK')
if @w_rol_perfil_mov is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_perfil_mov)

SELECT @w_menu_id = isnull(@w_menu_id,0)+1
INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description, me_version, me_container)
VALUES (@w_menu_id, @w_menu_id_parent, 'MNU_B2B_APPLI', 1, '', 1, @w_producto, 0, 'Solicitudes', NULL, 'APK')
if @w_rol_perfil_mov is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_perfil_mov)

SELECT @w_menu_parent_par = @w_menu_id
SELECT @w_menu_id = isnull(@w_menu_id,0)+1
INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description, me_version, me_container)
VALUES (@w_menu_id, @w_menu_parent_par, 'MNU_B2B_APPLI_GRUPAL', 1, '', 1, @w_producto, 0, 'Solicitud Grupal', NULL, 'APK')
if @w_rol_perfil_mov is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_perfil_mov)

SELECT @w_menu_id = isnull(@w_menu_id,0)+1
INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description, me_version, me_container)
VALUES (@w_menu_id, @w_menu_parent_par, 'MNU_B2B_APPLI_REVOLVENTE', 1, '', 1, @w_producto, 0, 'Solicitud Revolvente', NULL, 'APK')
if @w_rol_perfil_mov is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_perfil_mov)

SELECT @w_menu_id = isnull(@w_menu_id,0)+1
INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description, me_version, me_container)
VALUES (@w_menu_id, @w_menu_parent_par, 'MNU_B2B_APPLI_INDIVIDUAL', 1, '', 1, @w_producto, 0, 'Solicitud Individual', NULL, 'APK')
if @w_rol_perfil_mov is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_perfil_mov)

SELECT @w_menu_id = isnull(@w_menu_id,0)+1
INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description, me_version, me_container)
VALUES (@w_menu_id, @w_menu_id_parent, 'MNU_B2B_SIMULATION', 1, '', 1, @w_producto, 0, 'Simulación', NULL, 'APK')
if @w_rol_perfil_mov is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_perfil_mov)

SELECT @w_menu_id = isnull(@w_menu_id,0)+1
INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description, me_version, me_container)
VALUES (@w_menu_id, @w_menu_id_parent, 'MNU_B2B_TASKS', 1, '', 1, @w_producto, 0, 'Tareas', NULL, 'APK')
if @w_rol_perfil_mov is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_perfil_mov)
if @w_rol_asesor_ext is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_asesor_ext)

SELECT @w_menu_id = isnull(@w_menu_id,0)+1
INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description, me_version, me_container)
VALUES (@w_menu_id, @w_menu_id_parent, 'MNU_B2B_ELAVON_PAY', 1, '', 1, @w_producto, 0, 'Pagos Elavon', NULL, 'APK')
if @w_rol_perfil_mov is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_perfil_mov)

SELECT @w_menu_id = isnull(@w_menu_id,0)+1
INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description, me_version, me_container)
VALUES (@w_menu_id, @w_menu_id_parent, 'MNU_B2B_SYNCHRONIZE', 1, '', 1, @w_producto, 0, 'Sincronizar', NULL, 'APK')
if @w_rol_perfil_mov is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_perfil_mov)

SELECT @w_menu_id = isnull(@w_menu_id,0)+1
INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description, me_version, me_container)
VALUES (@w_menu_id, @w_menu_id_parent, 'MNU_B2B_CONFIGURATION', 1, '', 1, @w_producto, 0, 'Configuración', NULL, 'APK')
if @w_rol_perfil_mov is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_perfil_mov)
if @w_rol_asesor_ext is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_asesor_ext)

SELECT @w_menu_id = isnull(@w_menu_id,0)+1
INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description, me_version, me_container)
VALUES (@w_menu_id, @w_menu_id_parent, 'MNU_B2B_CLOSE', 1, '', 1, @w_producto, 0, 'Cerrar Sesión', NULL, 'APK')
if @w_rol_perfil_mov is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_perfil_mov)
if @w_rol_asesor_ext is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_asesor_ext)


delete ad_usuario_rol where ur_rol = @w_rol_perfil_mov
insert into ad_usuario_rol
select ur_login, @w_rol_perfil_mov,getdate(),3,'V', getdate(), 1, null, getdate()
from cobis..ad_usuario_rol
where ur_rol = @w_rol_asesor_mov
go