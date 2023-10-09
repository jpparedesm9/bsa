 --Cambios iniciales subido en Changeset 218824 successfully checked in.
/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : CGS-S133389 Orquestación Creación TR
--Descripción del Problema   : llamar al sp cob_credito..sp_up_tr_solicitud para que se ejecute luego de la creación del trámite
--Responsable                : Adriana Chiluisa
--Ruta TFS                   : Descripción abajo
--Nombre Archivo             : Descripción abajo
/*----------------------------------------------------------------------------------------------------------------*/

--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 

use cobis
go

declare @w_rol int, @w_producto int, @w_moneda tinyint

select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CREDITO'

-------------------------
--ad_servicio_autorizado
-------------------------
print 'registro de UpdateFieldFive'
if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Businessprocess.Creditmanagement.ApplicationManagment.UpdateFieldFive'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.ApplicationManagment.UpdateFieldFive', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	-- Ejecuta la regla de monto maximo
if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.ApplicationManagment.UpdateFieldFive')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Businessprocess.Creditmanagement.ApplicationManagment.UpdateFieldFive','cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment','updateFieldFive', '',0, null, null, null)
	