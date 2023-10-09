/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : CGS-S115350 Verificación de Datos - Flujo Grupal
--Descripción del Problema   : Creación de pantalla para verificación de datos
--Responsable                : Adriana Chiluisa
--Ruta TFS                   : Descripción abajo
--Nombre Archivo             : Descripción abajo
/*----------------------------------------------------------------------------------------------------------------*/

--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMx/SSSuite/BusinessProcess/source/backend/sql
--Nombre Archivo             : service_authorization.sql

print '-- REGISTRO DE SERVICIOS'
go

use cobis
go

declare @w_rol int,
        @w_producto int

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
    select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
    insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
    values (@w_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

delete cts_serv_catalog where csc_service_id in ('Businessprocess.Creditmanagement.DataVerification.CreateVerification')
delete ad_servicio_autorizado where ts_servicio in ('Businessprocess.Creditmanagement.DataVerification.CreateVerification')
delete cts_serv_catalog where csc_service_id in ('Businessprocess.Creditmanagement.DataVerification.UpdateVerification')
delete ad_servicio_autorizado where ts_servicio in ('Businessprocess.Creditmanagement.DataVerification.UpdateVerification')
delete cts_serv_catalog where csc_service_id in ('Businessprocess.Creditmanagement.DataVerification.SearchVerification')
delete ad_servicio_autorizado where ts_servicio in ('Businessprocess.Creditmanagement.DataVerification.SearchVerification')

--CREATE VERIFICATION
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('Businessprocess.Creditmanagement.DataVerification.CreateVerification',  'cobiscorp.ecobis.businessprocess.creditmanagement.service.IDataVerification', 'createVerification', '', 21700, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Businessprocess.Creditmanagement.DataVerification.CreateVerification', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

--UPDATE VERIFICATION
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('Businessprocess.Creditmanagement.DataVerification.UpdateVerification',  'cobiscorp.ecobis.businessprocess.creditmanagement.service.IDataVerification', 'updateVerification', '', 21700, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Businessprocess.Creditmanagement.DataVerification.UpdateVerification', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

--SEARCH VERIFICATION
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('Businessprocess.Creditmanagement.DataVerification.SearchVerification',  'cobiscorp.ecobis.businessprocess.creditmanagement.service.IDataVerification', 'searchVerification', '', 21700, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Businessprocess.Creditmanagement.DataVerification.SearchVerification', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

go

--------------------------------------------------------------------------------------------
-- Inicio Registro de Pantalla de Verificacion de Datos -- subido en business
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMx/SSSuite/BusinessProcess/source/backend/sql
--Nombre Archivo             : an_component.sql

print 'Inicio Registro de Pantalla de Verificacion de Datos'
go

use cobis
go

DECLARE @w_co_id INT, 
        @w_prod_name varchar(10), 
        @w_mo_id int

SELECT @w_prod_name = 'WF' 
SELECT @w_mo_id = mo_id  
from   cobis..an_module 
where  mo_name = 'IBX.InboxOficial'
 
SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component 

SELECT @w_co_id =  isnull(@w_co_id,1)
SELECT @w_mo_id = isnull(@w_mo_id ,1)

IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_class = 'VC_DATAVERITO_790838_TASK.html?SOLICITUD=GRUPAL')
begin
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, @w_mo_id, 'Verificación de Datos', 'VC_DATAVERITO_790838_TASK.html?SOLICITUD=GRUPAL', 'views/BUSIN/FLCRE/T_BUSINSFKMIYJN_838/1.0.0/', 'I', NULL, @w_prod_name)
end 
GO

--------------------------------------------------------------------------------------------
-- REGISTRO TABLAS -- subido en Activas / Credito -- se necesita registrar en la seqnos?
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_table.sql

PRINT 'REGISTRO TABLAS'
GO
PRINT '--->> Creacion tabla - cr_verifica_datos'
GO
USE cob_credito
GO

IF OBJECT_ID ('dbo.cr_verifica_datos') IS NOT NULL
    DROP TABLE dbo.cr_verifica_datos
GO

CREATE TABLE dbo.cr_verifica_datos (
      vd_tramite        INT NOT NULL,
      vd_cliente        INT NOT NULL,
      vd_respuesta      VARCHAR(200) NOT NULL,
      vd_resultado      INT NOT NULL,
      vd_fecha          datetime
    )
GO

ALTER TABLE cr_verifica_datos ADD CONSTRAINT pk_vd_tramite
PRIMARY KEY (vd_tramite, vd_cliente)
GO

IF OBJECT_ID ('dbo.cr_pregunta_ver_dat') IS NOT NULL
    DROP TABLE dbo.cr_pregunta_ver_dat
GO

CREATE TABLE dbo.cr_pregunta_ver_dat (
      pr_codigo         INT NOT NULL,
      pr_descripcion    varchar(1000) NOT NULL
    )
GO

ALTER TABLE cr_pregunta_ver_dat ADD CONSTRAINT pk_pr_codigo
PRIMARY KEY (pr_codigo)
GO

insert into cr_pregunta_ver_dat values (1 ,'Los ingresos mensuales son de: #SUELDO#')
insert into cr_pregunta_ver_dat values (2 ,'Los gastos mensuales son de: #GASTOS#')
insert into cr_pregunta_ver_dat values (3 ,'El grupo se llama: #NOM_GRUPO#')
insert into cr_pregunta_ver_dat values (4 ,'¿En caso de que no pague algun miembro esta dispuesto  hacer el pago solidario?')
insert into cr_pregunta_ver_dat values (5 ,'El nombre de el/la Sr/Sra presidente/a es: #PRESIDENTE#')
insert into cr_pregunta_ver_dat values (6 ,'La dirección del  Señor o Señora #NOM_CLIENTE# es: #DIRECCION#?')
insert into cr_pregunta_ver_dat values (7 ,'¿Usted sabe cuanto tiempo lleva viviendo el/la Sr/Sra #NOM_CLIENTE#  en la direccion #DIRECCION#? Tiempo: #TIEMPO_VIV#')
insert into cr_pregunta_ver_dat values (8 ,'¿Conoce a que se dedica el/la Sr/Sra #NOM_CLIENTE#? Actividad: #ACTIVIDAD#')
insert into cr_pregunta_ver_dat values (9,'"Usted sabe si el/la Sr/Sra  #NOM_CLIENTE# trabaja en el comercio #COMERCIO#')
insert into cr_pregunta_ver_dat values (10,'Usted sabe  si el/la  Sr/Sra #NOM_CLIENTE# es dueño(a) del comercio')
insert into cr_pregunta_ver_dat values (11,'Conoce  cuanto tiempo lleva el/la Sr/Sra #NOM_CLIENTE# laborando en el comercio #COMERCIO#? Tiempo: #TIEMPO_TR#')
insert into cr_pregunta_ver_dat values (12,'¿El local es #LOCAL#?')
insert into cr_pregunta_ver_dat values (13, '¿Tiene Correo electrónico?')
insert into cr_pregunta_ver_dat values (14, '¿Con que frecuencia utiliza su correo electrónico?')
insert into cr_pregunta_ver_dat values (15, '¿Tienes Redes sociales?')
insert into cr_pregunta_ver_dat values (16, 'Tipo de celular')
insert into cr_pregunta_ver_dat values (17, '¿Cómo paga su teléfono?')

go

-------------------------------------------------------------------------------------------
-- REGISTRO ERRORES
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_errores.sql

PRINT '--->> Registro de errrores'
use cobis
go
delete cobis..cl_errores where numero IN (2103057)
insert into cobis..cl_errores values (2103057, 0, 'Error en Actualizacion de Registro')
GO

-------------------------------------------------------------------------------------------
-- REGISTRO CATALOGOS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_catalogos.sql
PRINT '--->> Registro de catalogos'
--------------------------------------------------------------------------------------------
PRINT '--->> Registro de catalogos-cr_frecuencia'
use cobis
go
declare @w_tabla int

select @w_tabla = codigo from cl_tabla where tabla = 'cr_frecuencia'

if isnull(@w_tabla,0) = 0
begin
    select @w_tabla = isnull(max(codigo), 0) + 1
    from   cobis..cl_tabla

    insert into cobis..cl_tabla (codigo, tabla, descripcion)
    values (@w_tabla,'cr_frecuencia', 'FRECUENCIA')

    insert into cobis..cl_catalogo_pro (cp_producto, cp_tabla)
    values ('CRE', @w_tabla)

    update cobis..cl_seqnos
    set    siguiente = @w_tabla + 1
    where  tabla = 'cl_tabla'
end

delete from cobis..cl_catalogo where tabla = @w_tabla

INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'D', 'DIARIO', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'S', 'SEMANAL', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'M', 'MENSUAL', 'V' )
GO

--------------------------------------------------------------------------------------------
PRINT '--->> Registro de catalogos-cr_redes_sociales'
use cobis
go
declare @w_tabla int

select @w_tabla = codigo from cl_tabla where tabla = 'cr_redes_sociales'

if isnull(@w_tabla,0) = 0
begin
    select @w_tabla = isnull(max(codigo), 0) + 1
    from   cobis..cl_tabla

    insert into cobis..cl_tabla (codigo, tabla, descripcion)
    values (@w_tabla,'cr_redes_sociales', 'REDES SOCIALES')

    insert into cobis..cl_catalogo_pro (cp_producto, cp_tabla)
    values ('CRE', @w_tabla)

    update cobis..cl_seqnos
    set    siguiente = @w_tabla + 1
    where  tabla = 'cl_tabla'
end

delete from cobis..cl_catalogo where tabla = @w_tabla

INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'F', 'FACEBOOK', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'W', 'WHATSAPP', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'N', 'NO USO', 'V' )
GO

--------------------------------------------------------------------------------------------
PRINT '--->> Registro de catalogos-cr_tipo_telefono'
use cobis
go
declare @w_tabla int

select @w_tabla = codigo from cl_tabla where tabla = 'cr_tipo_telefono'

if isnull(@w_tabla,0) = 0
begin
    select @w_tabla = isnull(max(codigo), 0) + 1
    from   cobis..cl_tabla

    insert into cobis..cl_tabla (codigo, tabla, descripcion)
    values (@w_tabla,'cr_tipo_telefono', 'TIPO DE TELEFONO')

    insert into cobis..cl_catalogo_pro (cp_producto, cp_tabla)
    values ('CRE', @w_tabla)

    update cobis..cl_seqnos
    set    siguiente = @w_tabla + 1
    where  tabla = 'cl_tabla'
end

delete from cobis..cl_catalogo where tabla = @w_tabla

INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'S', 'SMARTPHONE', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'O', 'OTRO', 'V' )
GO

--------------------------------------------------------------------------------------------
PRINT '--->> Registro de catalogos-cr_tipo_pago_telefono'
use cobis
go
declare @w_tabla int

select @w_tabla = codigo from cl_tabla where tabla = 'cr_tipo_pago_telefono'

if isnull(@w_tabla,0) = 0
begin
    select @w_tabla = isnull(max(codigo), 0) + 1
    from   cobis..cl_tabla

    insert into cobis..cl_tabla (codigo, tabla, descripcion)
    values (@w_tabla,'cr_tipo_pago_telefono', 'TIPO DE PAGO DEL TELEFONO')

    insert into cobis..cl_catalogo_pro (cp_producto, cp_tabla)
    values ('CRE', @w_tabla)

    update cobis..cl_seqnos
    set    siguiente = @w_tabla + 1
    where  tabla = 'cl_tabla'
end

delete from cobis..cl_catalogo where tabla = @w_tabla

INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'R', 'RENTA', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, 'P', 'PREPAGO', 'V' )
GO

--------------------------------------------------------------------------------------------
-- REGISTRO SP - SEGURIDADES -- activa/credito
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_transac.sql
PRINT '--->> Registro de sp sp_verificacion_datos.sp'
GO

use cobis
GO

DECLARE @w_numero int, @w_producto int
select @w_numero = 21700
select @w_producto = 21
-- reprocesable
delete cobis..ad_tr_autorizada where ta_transaccion = @w_numero and ta_producto = @w_producto
delete cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero and pt_producto = @w_producto
delete cobis..cl_ttransaccion where tn_trn_code = @w_numero
delete cobis..ad_procedure where pd_procedure = @w_numero

-- sql\ca_segur.sql
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (@w_numero,'sp_verificacion_datos','cob_credito','V',getdate(),'sp_verif_da.sp')

insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values (@w_numero, 'VERIFICACION DATOS', convert(varchar,@w_numero), 'VERIFICACION DATOS')

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (@w_producto,'R',0,@w_numero,'V',getdate(),@w_numero)

declare @w_moneda tinyint, @w_fecha datetime, @w_rol int
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
set    @w_fecha = getdate()

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, getdate(), 1, 'V', getdate())
go
