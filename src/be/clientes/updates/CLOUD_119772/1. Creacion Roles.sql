use cobis
go
----------------------------------------------------------------------------------------------------------
-- CREACION DE ROLES 
----------------------------------------------------------------------------------------------------------
Declare 
@w_menu_id              int,
@w_producto             int,
@w_menu_id_parent       int,
@w_menu_parent_par      int,
@w_rol_perfil_mov       int,
@w_rol_perfil_mov_desc  varchar(64),
@w_rol_asesor_mov       int,
@w_rol_asesor_ext       int,
@w_rol_asesor_ext_desc  varchar(64)

--- CREACION DE ROL DE EJECUCION DE SERVICIOS ------------------------------------------------------------

select @w_rol_perfil_mov_desc = 'PERFIL MOVIL'
delete cobis..ad_usuario_rol where ur_rol = (select ro_rol from ad_rol where ro_descripcion = @w_rol_perfil_mov_desc)
delete cobis..ad_rol where ro_descripcion = @w_rol_perfil_mov_desc

select  @w_rol_asesor_ext_desc  = 'ASESOR EXTERNO'
delete cobis..ad_usuario_rol where ur_rol = (select ro_rol from ad_rol where ro_descripcion = @w_rol_asesor_ext_desc)
delete cobis..ad_rol where ro_descripcion = @w_rol_asesor_ext_desc

-- Se calcula el secuencial
select @w_rol_perfil_mov = isnull(max(ro_rol),0) + 1
from cobis..ad_rol


INSERT INTO cobis..ad_rol
(
	ro_rol,       ro_filial,         ro_descripcion,   ro_fecha_crea,  ro_creador,
	ro_estado,    ro_fecha_ult_mod,  ro_time_out,      ro_admin_seg,   ro_departamento,
	ro_oficina,   ro_canal
)
VALUES
(
	@w_rol_perfil_mov,    1,                 @w_rol_perfil_mov_desc, GETDATE(),     1,
	'V',                  GETDATE(),         900,                    NULL,          NULL, 
	NULL,                 'APK'
)                         

-- verificacion que exista el registro
select * from cobis..ad_rol where ro_descripcion = @w_rol_perfil_mov_desc

update cobis..cl_seqnos set
siguiente   = @w_rol_perfil_mov + 1
where tabla = 'ad_rol'
and bdatos  = 'cobis'


--- CREACION DE PERFILES ---------------------------------------------------------------------------------

-- Se calcula el secuencial
select @w_rol_asesor_ext = isnull(max(ro_rol),0) + 1
from ad_rol

-- Se inserta en la tabla el nuevo rol
INSERT INTO cobis..ad_rol
(
	ro_rol,       ro_filial,         ro_descripcion,   ro_fecha_crea,  ro_creador,
	ro_estado,    ro_fecha_ult_mod,  ro_time_out,      ro_admin_seg,   ro_departamento,
	ro_oficina,   ro_canal
)
VALUES
(
	@w_rol_asesor_ext,    1,                 @w_rol_asesor_ext_desc, GETDATE(),     1,
	'V',                  GETDATE(),         900,                    NULL,          NULL, 
	NULL,                 'APK'
)

-- verificacion que exista el registro
select * from cobis..ad_rol where ro_descripcion = @w_rol_asesor_ext_desc

update cobis..cl_seqnos set
siguiente   = @w_rol_asesor_ext + 1
where tabla = 'ad_rol'
and bdatos  = 'cobis'

--------- ASIGNAR PERFIL MOVIL A USUARIOS CON ROL ASESOR MOVIL ---------------
SELECT @w_rol_asesor_mov = ro_rol
FROM cobis..ad_rol
WHERE ro_descripcion = 'ASESOR MOVIL'

delete cobis..ad_usuario_rol where ur_rol = @w_rol_perfil_mov
insert into cobis..ad_usuario_rol
select ur_login, @w_rol_perfil_mov,getdate(),3,'V', getdate(), 1, null, getdate()
from cobis..ad_usuario_rol
where ur_rol = @w_rol_asesor_mov

------------------------------------------------------------------------------
---------- ASIGNAR MENUS B2B A: PERFIL MOVIL Y ASESOR EXTERNO ----------
------------------------------------------------------------------------------
SELECT @w_producto = pd_producto 
FROM cobis..cl_producto 
WHERE pd_descripcion = 'BANCA VIRTUAL'

delete cew_menu_role where mro_id_menu in (
select me_id from cew_menu WHERE me_name IN (
'MNU_B2B_ROOT',
'MNU_B2B_PEOPLE',
'MNU_B2B_GROUP',
'MNU_B2B_APPLICATIONS',
'MNU_B2B_APPLI',
'MNU_B2B_APPLI_GRUPAL',
'MNU_B2B_APPLI_REVOLVENTE',
'MNU_B2B_APPLI_INDIVIDUAL',
'MNU_B2B_SIMULATION',
'MNU_B2B_TASKS',
'MNU_B2B_T_ALL',
'MNU_B2B_T_SOLIDARITY_PAY',
'MNU_B2B_T_GRUPAL_VERF',
'MNU_B2B_T_INDIVIDUAL_VERF',
'MNU_B2B_T_LCR_DOCUMENTS',
'MNU_B2B_T_COLLECTIVE',
'MNU_B2B_ELAVON_PAY',
'MNU_B2B_SYNCHRONIZE',
'MNU_B2B_CONFIGURATION',
'MNU_B2B_CLOSE'
))

delete cew_menu where me_name in (
'MNU_B2B_ROOT',
'MNU_B2B_PEOPLE',
'MNU_B2B_GROUP',
'MNU_B2B_APPLICATIONS',
'MNU_B2B_APPLI',
'MNU_B2B_APPLI_GRUPAL',
'MNU_B2B_APPLI_REVOLVENTE',
'MNU_B2B_APPLI_INDIVIDUAL',
'MNU_B2B_SIMULATION',
'MNU_B2B_TASKS',
'MNU_B2B_T_ALL',
'MNU_B2B_T_SOLIDARITY_PAY',
'MNU_B2B_T_GRUPAL_VERF',
'MNU_B2B_T_INDIVIDUAL_VERF',
'MNU_B2B_T_LCR_DOCUMENTS',
'MNU_B2B_T_COLLECTIVE',
'MNU_B2B_ELAVON_PAY',
'MNU_B2B_SYNCHRONIZE',
'MNU_B2B_CONFIGURATION',
'MNU_B2B_CLOSE'
)

SELECT @w_menu_id = max(me_id) FROM cew_menu

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
VALUES (@w_menu_id, @w_menu_id_parent, 'MNU_B2B_APPLICATIONS', 1, '', 1, @w_producto, 0, 'Solicitudes', NULL, 'APK')
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


SELECT @w_menu_parent_par = @w_menu_id
SELECT @w_menu_id = isnull(@w_menu_id,0)+1
INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description, me_version, me_container)
VALUES (@w_menu_id, @w_menu_parent_par, 'MNU_B2B_T_ALL', 1, '', 1, @w_producto, 0, 'Todas', NULL, 'APK')
if @w_rol_perfil_mov is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_perfil_mov)

SELECT @w_menu_id = isnull(@w_menu_id,0)+1
INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description, me_version, me_container)
VALUES (@w_menu_id, @w_menu_parent_par, 'MNU_B2B_T_SOLIDARITY_PAY', 1, '', 1, @w_producto, 0, 'Pagos Solidarios', NULL, 'APK')
if @w_rol_perfil_mov is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_perfil_mov)
   
SELECT @w_menu_id = isnull(@w_menu_id,0)+1
INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description, me_version, me_container)
VALUES (@w_menu_id, @w_menu_parent_par, 'MNU_B2B_T_GRUPAL_VERF', 1, '', 1, @w_producto, 0, 'Verificaciones Grupales', NULL, 'APK')
if @w_rol_perfil_mov is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_perfil_mov)
   
SELECT @w_menu_id = isnull(@w_menu_id,0)+1
INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description, me_version, me_container)
VALUES (@w_menu_id, @w_menu_parent_par, 'MNU_B2B_T_INDIVIDUAL_VERF', 1, '', 1, @w_producto, 0, 'Verificaciones Individuales', NULL, 'APK')
if @w_rol_perfil_mov is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_perfil_mov)

SELECT @w_menu_id = isnull(@w_menu_id,0)+1
INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description, me_version, me_container)
VALUES (@w_menu_id, @w_menu_parent_par, 'MNU_B2B_T_LCR_DOCUMENTS', 1, '', 1, @w_producto, 0, 'Documentos LCR', NULL, 'APK')
if @w_rol_perfil_mov is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_perfil_mov)
   
SELECT @w_menu_id = isnull(@w_menu_id,0)+1
INSERT INTO cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option, me_description, me_version, me_container)
VALUES (@w_menu_id, @w_menu_parent_par, 'MNU_B2B_T_COLLECTIVE', 1, '', 1, @w_producto, 0, 'Colectivos', NULL, 'APK')
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
if @w_rol_asesor_ext is not null  
   INSERT INTO cew_menu_role VALUES (@w_menu_id,@w_rol_asesor_ext)

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


go
