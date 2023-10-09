
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S123429 Administración  de Dispositivos móviles
--Fecha                      : 02/08/2017
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
	di_codigo             INT NOT NULL,
	di_tipo               VARCHAR(10) NOT null,
	di_imei               VARCHAR(15) NOT NULL,
	di_macaddress          VARCHAR(60) NOT NULL,
	di_oficial            VARCHAR(10) NOT NULL,
	di_estado             CHAR(1) NOT null
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
	
	
end
else
begin
    print 'No existe el menu padre: MNU_ADMIN'
end

go

--------------------------------------------------------------------------------------------
-- Crear Catalogo
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/MobileIntegration/Backend/sql
--Nombre Archivo             : si_catalogo.sql


USE cobis
GO



delete cl_catalogo_pro
from cl_tabla
where tabla in ('si_tipo_movil', 'cr_tipo_local')
  and codigo = cp_tabla
go

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('si_tipo_movil', 'cr_tipo_local')
  and cl_tabla.codigo = cl_catalogo.tabla
go
delete cl_tabla
where cl_tabla.tabla in ('si_tipo_movil', 'cr_tipo_local')
go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
INSERT INTO cobis..cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'si_tipo_movil', 'Tipos de Sistemas Operativos Movil')

--Insertando Catalogos
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'SP', 'SMARTPHONE', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'AD', 'ANDROID', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'OS', 'iOS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'TB', 'TABLET', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'OT', 'OTROS', 'V', NULL, NULL, NULL)
go

--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_catalogos.sql

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_local', ' TIPO DE LOCAL                                                    ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla)
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1','PROPIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'2','RENTADO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'3','MERCADO','V')

-- Actualizacion secuencial tabla de catalogos

update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
go

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('si_tipo_movil')
go




--------------------------------------------------------------------------------------------
-- REGISTRO SP - SEGURIDADES -- activa/credito   --sp_sincroniza_mobil
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/MobileIntegration/Backend/sql
--Nombre Archivo             : si_transac.sql
PRINT '--->> Registro de sp sp_sincroniza_mobil.sp'
GO

use cobis
GO

DECLARE @w_numero int, @w_producto int
select @w_numero = 21609
select @w_producto = 21
-- reprocesable
delete cobis..ad_tr_autorizada where ta_transaccion = @w_numero and ta_producto = @w_producto
delete cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero and pt_producto = @w_producto
delete cobis..cl_ttransaccion where tn_trn_code in (1713, 1714, 1715, 1716)

delete cobis..ad_procedure where pd_procedure = @w_numero

-- sql\ca_segur.sql
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (@w_numero,'sp_sincroniza_mobil','cob_sincroniza','V',getdate(),'sp_si_mobi.sp')


INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (1713, 'INSERTAR DISPOSITIVO OFICIAL', '1713', 'INSERTAR DISPOSITIVO OFICIAL')

INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (1714, 'ACTUALIZAR DISPOSITIVO OFICIAL', '1714', 'ACTUALIZAR DISPOSITIVO OFICIAL')

INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (1715, 'ELIMINAR DISPOSITIVO OFICIAL', '1715', 'ELIMINAR DISPOSITIVO OFICIAL')

INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (1716, 'LISTAR Y OBTIENE DISPOSITIVO OFICIAL', '1716', 'LISTAR Y OBTIENE DISPOSITIVO OFICIAL')


insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (@w_producto,'R',0,@w_numero,'V',getdate(),@w_numero)

declare @w_moneda tinyint, @w_fecha datetime, @w_rol int
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
set    @w_fecha = getdate()

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, getdate(), 1, 'V', getdate())
GO


--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS MOBILEMANAGEMENT
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/MobileIntegration/Backend/sql
--Nombre Archivo             : si_services_authorization.sql        : 


use cobis
    GO
    
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'MobileManagement.MobileManagement.CreateMobile')
UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.mobilemanagement.service.IMobileManagement', csc_method_name = 'createMobile', csc_description = '', csc_trn = 1713 WHERE csc_service_id = 'MobileManagement.MobileManagement.CreateMobile'
ELSE
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('MobileManagement.MobileManagement.CreateMobile', 'cobiscorp.ecobis.mobilemanagement.service.IMobileManagement', 'createMobile', '', 1713)
GO

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'MobileManagement.MobileManagement.UpdateMobile')
UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.mobilemanagement.service.IMobileManagement', csc_method_name = 'updateMobile', csc_description = '', csc_trn = 1714 WHERE csc_service_id = 'MobileManagement.MobileManagement.UpdateMobile'
ELSE
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('MobileManagement.MobileManagement.UpdateMobile', 'cobiscorp.ecobis.mobilemanagement.service.IMobileManagement', 'updateMobile', '', 1714)
GO

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'MobileManagement.MobileManagement.DeleteMobile')
UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.mobilemanagement.service.IMobileManagement', csc_method_name = 'deleteMobile', csc_description = '', csc_trn = 1715 WHERE csc_service_id = 'MobileManagement.MobileManagement.DeleteMobile'
ELSE
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('MobileManagement.MobileManagement.DeleteMobile', 'cobiscorp.ecobis.mobilemanagement.service.IMobileManagement', 'deleteMobile', '', 1715)
GO

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'MobileManagement.MobileManagement.SearchMobile')
UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.mobilemanagement.service.IMobileManagement', csc_method_name = 'searchMobile', csc_description = '', csc_trn = 1716 WHERE csc_service_id = 'MobileManagement.MobileManagement.SearchMobile'
ELSE
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('MobileManagement.MobileManagement.SearchMobile', 'cobiscorp.ecobis.mobilemanagement.service.IMobileManagement', 'searchMobile', '', 1716)
GO
      
      

USE cobis

GO
declare @w_rol int, @w_producto int
	  
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'


DELETE cobis..ad_servicio_autorizado where ts_servicio = 'MobileManagement.MobileManagement.CreateMobile'
INSERT INTO cobis..ad_servicio_autorizado values('MobileManagement.MobileManagement.CreateMobile', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
print 'insert en ad_servicio_autorizado'


DELETE cobis..ad_servicio_autorizado where ts_servicio = 'MobileManagement.MobileManagement.UpdateMobile'
INSERT INTO cobis..ad_servicio_autorizado values('MobileManagement.MobileManagement.UpdateMobile', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
print 'insert en ad_servicio_autorizado'


DELETE cobis..ad_servicio_autorizado where ts_servicio = 'MobileManagement.MobileManagement.DeleteMobile'
INSERT INTO cobis..ad_servicio_autorizado values('MobileManagement.MobileManagement.DeleteMobile', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
print 'insert en ad_servicio_autorizado'

DELETE cobis..ad_servicio_autorizado where ts_servicio = 'MobileManagement.MobileManagement.SearchMobile'
INSERT INTO cobis..ad_servicio_autorizado values('MobileManagement.MobileManagement.SearchMobile', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
print 'insert en ad_servicio_autorizado'
      
GO


---------------------------------------------------------------------------------------
---------------------------Crear registro de errores móviles---------------------------
---------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : si_errores.sql
use cobis
go

delete cobis..cl_errores 
where cl_errores.numero in ( 2109100, 2109101, 2109102, 2109103)

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (2109100, 1, 'ERROR AL INSERTAR MOVIL DEL OFICIAL')

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (2109101, 1, 'NO EXISTE MOVIL DEL OFICIAL')

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (2109102, 1, 'ERROR AL ACTUALIZAR MOVIL DEL OFICIAL')

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (2109103, 1, 'ERROR AL ELIMINAR MOVIL DEL OFICIAL')
go





