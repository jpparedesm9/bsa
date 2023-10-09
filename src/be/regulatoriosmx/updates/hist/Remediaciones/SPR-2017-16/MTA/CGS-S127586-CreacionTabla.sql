/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S127586
--Fecha                      : 08/08/2017
--Descripción del Problema   : Se requiere registrar un nueva estructura de tabla
--Descripción de la Solución : Crear nueva tabla
--Autor                      : Maria Jose Taco
--Instalador                 : cr_table.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--                           : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
/**********************************************************************************************************************/
USE cob_credito
GO

-----------------------
--CREACION DE LA TABLA
-----------------------
IF OBJECT_ID ('dbo.cr_tr_sincronizar') IS NOT NULL
    DROP TABLE dbo.cr_tr_sincronizar
GO

CREATE TABLE cr_tr_sincronizar(
ti_tramite         INT,
ti_seccion         VARCHAR(30) NULL,-- nombre de la actividad en el flujo
ti_sincroniza      CHAR(1)     NULL -- sincronización en el móvil S/N
)

CREATE nonclustered INDEX cr_tr_sincronizar
    ON dbo.cr_tr_sincronizar (ti_tramite)
GO

----------------------
--REGISTRAR SERVICIOS
----------------------
use cobis
go

declare @w_rol int, @w_producto int, @w_moneda tinyint

select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CREDITO'

--XMLIngresoIndividual
delete ad_servicio_autorizado where ts_servicio in ('Businessprocess.Creditmanagement.Synchronization.XMLIngresoIndividual')
insert into ad_servicio_autorizado
	(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Businessprocess.Creditmanagement.Synchronization.XMLIngresoIndividual', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())

--XMLIngresoIndividual'
delete cts_serv_catalog where csc_service_id in ('Businessprocess.Creditmanagement.Synchronization.XMLIngresoIndividual')
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('Businessprocess.Creditmanagement.Synchronization.XMLIngresoIndividual', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.ISynchronization', 'xMLIngresoIndividual', '', 0, null, null, 'N')

--XMLIngresoGrupal
delete ad_servicio_autorizado where ts_servicio in ('Businessprocess.Creditmanagement.Synchronization.XMLIngresoGrupal')
insert into ad_servicio_autorizado
	(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Businessprocess.Creditmanagement.Synchronization.XMLIngresoGrupal', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())

--XMLIngresoGrupal
delete cts_serv_catalog where csc_service_id in ('Businessprocess.Creditmanagement.Synchronization.XMLIngresoGrupal')
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('Businessprocess.Creditmanagement.Synchronization.XMLIngresoGrupal', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.ISynchronization', 'xMLIngresoGrupal', '', 0, null, null, 'N')
go


--------------------------
--PARAMETRO
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Cartera/Backend/sql
--Nombre Archivo             : ca_parametros.sql

update cl_parametro
set pa_tinyint= 15
where pa_nemonico = 'DVOG'


go

