
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S146755 Pantalla de Administracion de Sincronizacion
--Fecha                      : 27/11/2017
--Descripción del Problema   : No existen instaladores referentes a lo contenido en el archivo
--Descripción de la Solución : Crear scripts de instalación
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/


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

go

--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS MOBILEMANAGEMENT
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/MobileIntegration/Backend/sql
--Nombre Archivo             : si_services_authorization.sql


use cobis
    GO
    
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'MobileManagement.SyncManagement.SearchSyncData')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', csc_method_name = 'searchSyncData', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'MobileManagement.SyncManagement.SearchSyncData'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('MobileManagement.SyncManagement.SearchSyncData', 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', 'searchSyncData', '', 0)
GO
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'MobileManagement.SyncManagement.UpdateSyncData')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', csc_method_name = 'updateSyncData', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'MobileManagement.SyncManagement.UpdateSyncData'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('MobileManagement.SyncManagement.UpdateSyncData', 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', 'updateSyncData', '', 0)
GO



USE cobis

GO
declare @w_rol int, @w_producto int
	  
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'


DELETE cobis..ad_servicio_autorizado where ts_servicio = 'MobileManagement.SyncManagement.SearchSyncData'
INSERT INTO cobis..ad_servicio_autorizado values('MobileManagement.SyncManagement.SearchSyncData', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
print 'insert en ad_servicio_autorizado'


DELETE cobis..ad_servicio_autorizado where ts_servicio = 'MobileManagement.SyncManagement.UpdateStatSyncData'
INSERT INTO cobis..ad_servicio_autorizado values('MobileManagement.SyncManagement.UpdateSyncData', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
print 'insert en ad_servicio_autorizado'
      
GO



--------------------------------------------------------------------------------------------
-- Crear Catalogo
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/MobileIntegration/Backend/sql
--Nombre Archivo             : si_catalogo.sql


USE cobis
GO



delete cl_catalogo_pro
from cl_tabla
where tabla in ('si_sinc_estado')
  and codigo = cp_tabla
go

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('si_sinc_estado')
  and cl_tabla.codigo = cl_catalogo.tabla
go
delete cl_tabla
where cl_tabla.tabla in ('si_sinc_estado')
go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
INSERT INTO cobis..cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'si_sinc_estado', 'Estado de la sincronización')

--Insertando Catalogos
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'P', 'Pendiente', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'D', 'Descargando', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'S', 'Sincronizado', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'E', 'Eliminado ', 'V', NULL, NULL, NULL)


-- Actualizacion secuencial tabla de catalogos

update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
go

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('si_sinc_estado')
go






---------------------------------------------------------------------------------------
---------------------------Crear registro de errores móviles---------------------------
---------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : 


use cobis
go

delete cobis..cl_errores 
where cl_errores.numero in (2109107, 2109108)

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (2109107, 1, 'No existe el registro que desea actualizar')

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (2109108, 1, 'Error al actualizar el registro de sincronización')



go