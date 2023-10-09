
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-R132047  Campos Dispositivos Móbiles
--Fecha                      : 28/08/2017
--Descripción del Problema   : No existen instaladores referentes a lo contenido en el archivo
--Descripción de la Solución : Crear scripts de instalación
--Autor                      : Paúl Ortiz Vera
/**********************************************************************************************************************/

---------------------------------------------------------------------------------------
--------------------------Crear tabla de dispositivos móviles--------------------------
---------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/MobileIntegration/Backend/sql
--Nombre Archivo             : si_table.sql


use cob_sincroniza
go


IF OBJECT_ID ('dbo.si_dispositivo') IS NOT NULL
	DROP TABLE dbo.si_dispositivo
GO

CREATE TABLE dbo.si_dispositivo
	(
	di_codigo             int NOT NULL,
	di_tipo               varchar(10) NOT null,
	di_imei               varchar(45) NOT NULL,
	di_macaddress         varchar(60) NOT NULL,
	di_oficial            varchar(10) NOT NULL,
	di_login              login NOT NULL,
	di_estado             char(1) NOT NULL,
	di_alias              varchar(45),
	di_fecha_reg          datetime NOT NULL,
	di_usuario_reg        login
	)
GO

CREATE UNIQUE CLUSTERED INDEX si_dispositivo_Key
	ON dbo.si_dispositivo (di_codigo)
GO


--------------------------------------------------------------------------------------------
-- Insertar en tabla de secuenciales
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/MobileIntegration/Backend/sql
--Nombre Archivo             : si_seqnos.sql


use cobis
go


DELETE cobis..cl_seqnos where bdatos = 'cob_sincroniza' and tabla = 'si_dispositivo'

INSERT INTO dbo.cl_seqnos (bdatos, tabla, siguiente, pkey)
VALUES ('cob_sincroniza', 'si_dispositivo', 0, 'di_codigo')
GO

--------------------------------------------------------------------------------------------
-- Agregar menú y permisos
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/MobileIntegration/Backend/sql
--Nombre Archivo             : si_cew_menu.sql


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

select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

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
	
	--MENU ADMINISTRACION DE DISPOSITIVOS MÓVILES
    if not exists (select 1 from cew_menu where me_name = 'MNU_MOBILE_DIVICE_POP')
    begin
        SELECT @w_menu_id = isnull( max(me_id), 0 ) + 1 FROM cew_menu
        SELECT @w_menu_order = isnull(max(me_id),0) FROM cew_menu WHERE me_id_parent = @w_menu_parent_id
        INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option)
        VALUES (@w_menu_id, @w_menu_parent_id, 'MNU_MOBILE_DIVICE_POP', 1, 'views/MBILE/ADMIN/T_MBILEKTPCSLCM_549/1.0.0/VC_MOBILEPOPP_688549_TASK.html', @w_menu_order, 
        @w_producto, 0)
    end    
    SELECT @w_menu_id = me_id from cew_menu where me_name = 'MNU_MOBILE_DIVICE_POP'    
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

if exists (select 1 from cew_menu where me_name = 'MNU_MOBILE_DIVICE_POP')
begin
	UPDATE cobis..cew_menu
	SET me_id_parent = -1
	WHERE me_name = 'MNU_MOBILE_DIVICE_POP'
	
	PRINT 'insertando MNU_MOBILE_DIVICE_POP'
end


---------------------------------------------------------------------------------------
---------------------------Crear registro de errores móviles---------------------------
---------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : si_errores.sql
use cobis
go

delete cobis..cl_errores 
where cl_errores.numero in (2109105)


INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (2109105, 1, 'EL OFICIAL YA CUENTA CON UN DISPOSITIVO ACTIVO')
go
