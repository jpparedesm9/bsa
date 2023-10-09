/**********************************************************************/
/*   Archivo:         si_cew_menu.sql                                 */
/*   Data base:       cobis                                           */
/**********************************************************************/
/*                     IMPORTANTE                                     */
/*   Esta aplicacion es parte de los  paquetes bancarios              */
/*   propiedad de COBISCORP.                                          */
/*   Su uso no autorizado queda  expresamente  prohibido              */
/*   asi como cualquier alteracion o agregado hecho  por              */
/*   alguno de sus usuarios sin el debido consentimiento              */
/*   por escrito de COBISCORP.                                        */
/*   Este programa esta protegido por la ley de derechos              */
/*   de autor y por las convenciones  internacionales de              */
/*   propiedad intelectual.  Su uso  no  autorizado dara              */
/*   derecho a COBISCORP para obtener ordenes  de secuestro           */
/*   o  retencion  y  para  perseguir  penalmente a  los              */
/*   autores de cualquier infraccion.                                 */
/**********************************************************************/
/*                      PROPOSITO                                     */
/*  Creación de menú y autorización del mismo para MOVILEINTEGRATION  */
/**********************************************************************/
/*                      MODIFICACIONES                                */
/*   FECHA              AUTOR                  RAZON                  */
/*   02-08-2017         Paúl Ortiz             Emision Inicial        */
/**********************************************************************/

/* Creación de menú y autorización del mismo */


use cobis
go

DECLARE @w_menu_parent_id INT,
        @w_menu_id INT,
        @w_producto int,
        @w_rol int,
        @w_menu_order int 

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
    select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
    insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
    values (@w_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'


SELECT @w_menu_parent_id = me_id FROM cew_menu WHERE me_name = 'MNU_ADMIN'
SELECT @w_menu_order = isnull(max(me_id),0) FROM cew_menu WHERE me_id_parent = @w_menu_parent_id

select @w_producto = pd_producto from cl_producto where pd_descripcion = 'ADMINISTRACION'

if @w_menu_parent_id is not null
begin
    
    
	--MENU ADMINISTRACION DE DISPOSITIVOS MÓVILES
    if not exists (select 1 from cew_menu where me_name = 'MNU_MOBILE_DIVICE_MGNT')
    begin
        SELECT @w_menu_id = isnull( max(me_id), 0 ) + 1 FROM cew_menu
        SELECT @w_menu_order = isnull(max(me_id),0) FROM cew_menu WHERE me_id_parent = @w_menu_parent_id
        INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option)
        VALUES (@w_menu_id, @w_menu_parent_id, 'MNU_MOBILE_DIVICE_MGNT', 1, 'views/MBILE/ADMIN/T_MBILEJIXXTPVT_502/1.0.0/VC_MOBILEMATM_689502_TASK.html', @w_menu_order, 
        @w_producto, 0)
    end    
    SELECT @w_menu_id = me_id from cew_menu where me_name = 'MNU_MOBILE_DIVICE_MGNT'    
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
        insert into cew_menu_role values (@w_menu_id, @w_rol)
    end
	
	--MENU ADMINISTRACION DE SINCRONIZACION
    if not exists (select 1 from cew_menu where me_name = 'MNU_MOBILE_SYNC_MGNT')
    begin
        SELECT @w_menu_id = isnull( max(me_id), 0 ) + 1 FROM cew_menu
        SELECT @w_menu_order = isnull(max(me_id),0) FROM cew_menu WHERE me_id_parent = @w_menu_parent_id
        INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option)
        VALUES (@w_menu_id, @w_menu_parent_id, 'MNU_MOBILE_SYNC_MGNT', 1, 'views/MBILE/ADMIN/T_MBILEJTPUKGUK_409/1.0.0/VC_SYNCMANAGE_316409_TASK.html', @w_menu_order, 
        @w_producto, 0)
    end    
    SELECT @w_menu_id = me_id from cew_menu where me_name = 'MNU_MOBILE_SYNC_MGNT'    
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
        insert into cew_menu_role values (@w_menu_id, @w_rol)
    end
	
end
else
begin
    print 'No existe el menu padre: MNU_ADMIN'
end

/*Menu Administración de Terminales*/
if @w_menu_parent_id is not null
begin   
	--MENU ADMINISTRACION DE TERMINALES
    if not exists (select 1 from cew_menu where me_name = 'MNU_MOBILE_TERMINAL_MGNT')
    begin
        SELECT @w_menu_id = isnull( max(me_id), 0 ) + 1 FROM cew_menu
        SELECT @w_menu_order = isnull(max(me_id),0) FROM cew_menu WHERE me_id_parent = @w_menu_parent_id
        INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option,me_description)
        VALUES (@w_menu_id, @w_menu_parent_id, 'MNU_MOBILE_TERMINAL_MGNT', 1, 'views/MBILE/ADMIN/T_MBILEHJPNKLMQ_522/1.0.0/VC_TERMINALAA_708522_TASK.html?mode=2', @w_menu_order, 
        @w_producto, 0, 'Administración de Terminales')
    end    
    SELECT @w_menu_id = me_id from cew_menu where me_name = 'MNU_MOBILE_TERMINAL_MGNT'    
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
        insert into cew_menu_role values (@w_menu_id, @w_rol)
    end	
end
else
begin
    print 'No existe el menu padre: MNU_ADMIN'
end

/*Menu Administración de Terminales*/
if @w_menu_parent_id is not null
begin   
	--MENU ADMINISTRACION DE TERMINALES
    if not exists (select 1 from cew_menu where me_name = 'MNU_MOBILE_TERMINAL_MGNT')
    begin
        SELECT @w_menu_id = isnull( max(me_id), 0 ) + 1 FROM cew_menu
        SELECT @w_menu_order = isnull(max(me_id),0) FROM cew_menu WHERE me_id_parent = @w_menu_parent_id
        INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option,me_description)
        VALUES (@w_menu_id, @w_menu_parent_id, 'MNU_MOBILE_TERMINAL_MGNT', 1, 'views/MBILE/ADMIN/T_MBILEHJPNKLMQ_522/1.0.0/VC_TERMINALAA_708522_TASK.html?mode=2', @w_menu_order, 
        @w_producto, 0, 'Administración de Terminales')
    end    
    SELECT @w_menu_id = me_id from cew_menu where me_name = 'MNU_MOBILE_TERMINAL_MGNT'    
    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
    begin
        insert into cew_menu_role values (@w_menu_id, @w_rol)
    end	
end
else
begin
    print 'No existe el menu padre: MNU_ADMIN'
end


go
--------------------------------------------------------------------
-------------------          MENU B2B       ------------------------
--------------------------------------------------------------------

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

DELETE cew_menu WHERE me_name IN (
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

SELECT @w_menu_id = max(me_id) FROM cobis..cew_menu
SELECT @w_menu_id = isnull(@w_menu_id,0)+1

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



delete ad_usuario_rol where ur_rol = @w_rol_perfil_mov
insert into ad_usuario_rol
select ur_login, @w_rol_perfil_mov,getdate(),3,'V', getdate(), 1, null, getdate()
from cobis..ad_usuario_rol
where ur_rol = @w_rol_asesor_mov
go
go
