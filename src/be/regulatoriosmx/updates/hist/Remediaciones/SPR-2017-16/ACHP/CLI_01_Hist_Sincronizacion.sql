/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : CGS-S127325 Interface Móvil - Verificación de Datos Individual
--Descripción del Problema   : Cambios a la pantalla de verificación de datos (Cuestionario)
--Responsable                : Adriana Chiluisa
--Ruta TFS                   : Descripción abajo
--Nombre Archivo             : Descripción abajo
/*----------------------------------------------------------------------------------------------------------------*/

--------------------------------------------------------------------------------------------
-- INGRESO DE TABLA-subido
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_table.sql
use cob_credito
go

IF OBJECT_ID ('dbo.cr_verifica_xml_tmp') IS NOT NULL
	DROP TABLE dbo.cr_verifica_xml_tmp
GO

CREATE TABLE dbo.cr_verifica_xml_tmp
	(
	vt_x_tramite    INT NOT NULL,
	vt_x_cliente    INT NOT NULL,
	vt_x_codigo     INT NOT NULL,
	vt_x_secuencial INT NOT NULL,
	vt_x_preg_dato  CHAR (1000) NOT NULL,
	vt_x_respuesta  VARCHAR (10) NOT NULL
	)
GO

--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS-subido
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMx/SSSuite/BusinessProcess/source/backend/sql
--Nombre Archivo             : service_authorization.sql

print '-- REGISTRO DE SERVICIOS'
go

use cobis
go

declare @w_rol int, @w_producto int, @w_moneda tinyint

select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CREDITO'

print 'registro de CreateSynchronizationActivity'
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Businessprocess.Creditmanagement.Synchronization.CreateSynchronizationActivity'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.Synchronization.CreateSynchronizationActivity', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.Synchronization.CreateSynchronizationActivity')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Businessprocess.Creditmanagement.Synchronization.CreateSynchronizationActivity','cobiscorp.ecobis.businessprocess.creditmanagement.service.ISynchronization','createSynchronizationActivity', '',2174, null, null, null)
	
	print 'registro de QuerySynchronizationActivity'
	    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Businessprocess.Creditmanagement.Synchronization.QuerySynchronizationActivity'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.Synchronization.QuerySynchronizationActivity', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.Synchronization.QuerySynchronizationActivity')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Businessprocess.Creditmanagement.Synchronization.QuerySynchronizationActivity','cobiscorp.ecobis.businessprocess.creditmanagement.service.ISynchronization','querySynchronizationActivity', '',2174, null, null, null)

	print 'registro de UpdateSynchronizationActivity'
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Businessprocess.Creditmanagement.Synchronization.UpdateSynchronizationActivity'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.Synchronization.UpdateSynchronizationActivity', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.Synchronization.UpdateSynchronizationActivity')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Businessprocess.Creditmanagement.Synchronization.UpdateSynchronizationActivity','cobiscorp.ecobis.businessprocess.creditmanagement.service.ISynchronization','updateSynchronizationActivity', '',2174, null, null, null)

	print 'registro de XMLQuestionnaire'
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Businessprocess.Creditmanagement.Synchronization.XMLQuestionnaire'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.Synchronization.XMLQuestionnaire', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.Synchronization.XMLQuestionnaire')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Businessprocess.Creditmanagement.Synchronization.XMLQuestionnaire','cobiscorp.ecobis.businessprocess.creditmanagement.service.ISynchronization','xMLQuestionnaire', '',0, null, null, null)		
go

--------------------------------------------------------------------------------------------
-- REGISTRO SP - SEGURIDADES -subido
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_transac.sql
use cobis
GO

DECLARE @w_numero int, @w_producto int
select @w_numero = 2174
select @w_producto = 21
-- reprocesable
delete cobis..ad_tr_autorizada where ta_transaccion = @w_numero and ta_producto = @w_producto
delete cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero and pt_producto = @w_producto
delete cobis..cl_ttransaccion where tn_trn_code = @w_numero
delete cobis..ad_procedure where pd_procedure = @w_numero

-- sql\ca_segur.sql
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (@w_numero,'sp_actividad_sincroniza','cob_credito','V',getdate(),'sp_actsinc.sp')

insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values (@w_numero, 'INSERTA,ACTUALIZA,CONSULTA LA SINCRO', convert(varchar,@w_numero), 'INSERTA,ACTUALIZA,CONSULTA LA SINCRO')

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (@w_producto,'R',0,@w_numero,'V',getdate(),@w_numero)

declare @w_moneda tinyint, @w_fecha datetime, @w_rol int
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
set    @w_fecha = getdate()

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, getdate(), 1, 'V', getdate())
go
