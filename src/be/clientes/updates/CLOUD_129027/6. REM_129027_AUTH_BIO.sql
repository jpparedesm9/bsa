use cobis
go


declare 
@w_rol int,
@w_producto int

SELECT @w_producto = pd_producto 
FROM cl_producto 
WHERE pd_descripcion = 'CLIENTES'

--------------------------------------------
--- SERVICIO INVOCAR A RENAPO          -----
--------------------------------------------

delete from cts_serv_catalog where csc_service_id = 'OrchestationRenapoServiceSERVImpl.renapoQueryByDetail'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
values ('OrchestationRenapoServiceSERVImpl.renapoQueryByDetail', 'com.cobiscorp.ecobis.cobiscloudrenapo.bsl.serv.bsl.IOrchestationRenapoService', 'renapoQueryByDetail', 'Consultar Servicio RENAPO', NULL, 'N')
	
select @w_rol = ro_rol 
from ad_rol 
where ro_descripcion ='ASESOR' 

delete from ad_servicio_autorizado where ts_servicio = 'OrchestationRenapoServiceSERVImpl.renapoQueryByDetail' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('OrchestationRenapoServiceSERVImpl.renapoQueryByDetail', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


select @w_rol = ro_rol 
from ad_rol 
where ro_descripcion ='ASESOR MOVIL' 

delete from ad_servicio_autorizado where ts_servicio = 'OrchestationRenapoServiceSERVImpl.renapoQueryByDetail' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('OrchestationRenapoServiceSERVImpl.renapoQueryByDetail', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

--------------------------------------------
--- SERVICIO PARA OBTENER ACCESS TOKEN -----
--------------------------------------------

delete from cts_serv_catalog where csc_service_id = 'OrchestrationBiometricServiceSERVImpl.accessToken'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
values ('OrchestrationBiometricServiceSERVImpl.accessToken', 'com.cobiscorp.ecobis.cobiscloudbiometric.bsl.serv.bsl.IOrchestationBiometricService', 'accessToken', 'Obtener Access Token', NULL, 'N')
	
select @w_rol = ro_rol 
from ad_rol 
where ro_descripcion ='ASESOR' 

delete from ad_servicio_autorizado where ts_servicio = 'OrchestrationBiometricServiceSERVImpl.accessToken' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('OrchestrationBiometricServiceSERVImpl.accessToken', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


select @w_rol = ro_rol 
from ad_rol 
where ro_descripcion ='ASESOR MOVIL' 

delete from ad_servicio_autorizado where ts_servicio = 'OrchestrationBiometricServiceSERVImpl.accessToken' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('OrchestrationBiometricServiceSERVImpl.accessToken', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


--------------------------------------------
--- SERVICIO PARA OBTENER TOKEN OPACO  -----
--------------------------------------------

delete from cts_serv_catalog where csc_service_id = 'OrchestrationBiometricServiceSERVImpl.opaqueToken'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
values ('OrchestrationBiometricServiceSERVImpl.opaqueToken', 'com.cobiscorp.ecobis.cobiscloudbiometric.bsl.serv.bsl.IOrchestationBiometricService', 'opaqueToken', 'Obtener Token Opaco', NULL, 'N')
	
select @w_rol = ro_rol 
from ad_rol 
where ro_descripcion ='ASESOR' 

delete from ad_servicio_autorizado where ts_servicio = 'OrchestrationBiometricServiceSERVImpl.opaqueToken' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('OrchestrationBiometricServiceSERVImpl.opaqueToken', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


select @w_rol = ro_rol 
from ad_rol 
where ro_descripcion ='ASESOR MOVIL' 

delete from ad_servicio_autorizado where ts_servicio = 'OrchestrationBiometricServiceSERVImpl.opaqueToken' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('OrchestrationBiometricServiceSERVImpl.opaqueToken', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


--------------------------------------------
--- SERVICIO PARA OBTENER EQUIVALENCIAS-----
--------------------------------------------

delete from cts_serv_catalog where csc_service_id = 'SystemConfiguration.EquivalenceManagement.QueryEquivalences'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
values ('SystemConfiguration.EquivalenceManagement.QueryEquivalences', 'cobiscorp.ecobis.systemconfiguration.service.IEquivalenceManagement', 'queryEquivalences', 'Obtener Equivalencias', NULL, 'N')
	
select @w_rol = ro_rol 
from ad_rol 
where ro_descripcion ='ASESOR' 

delete from ad_servicio_autorizado where ts_servicio = 'SystemConfiguration.EquivalenceManagement.QueryEquivalences' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('SystemConfiguration.EquivalenceManagement.QueryEquivalences', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


select @w_rol = ro_rol 
from ad_rol 
where ro_descripcion ='ASESOR MOVIL' 

delete from ad_servicio_autorizado where ts_servicio = 'SystemConfiguration.EquivalenceManagement.QueryEquivalences' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('SystemConfiguration.EquivalenceManagement.QueryEquivalences', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

------------------------------------------------
--- SERVICIO PARA ACTUALIZAR RENAPO CLIENTE-----
------------------------------------------------


delete from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.UpdateCustomerRENAPO'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
values ('CustomerDataManagementService.CustomerManagement.UpdateCustomerRENAPO', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'updateCustomerRENAPO', 'Actualizar Cliente con RENAPO', NULL, 'N')
	
select @w_rol = ro_rol 
from ad_rol 
where ro_descripcion ='ASESOR' 

delete from ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CustomerManagement.UpdateCustomerRENAPO' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.UpdateCustomerRENAPO', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


select @w_rol = ro_rol 
from ad_rol 
where ro_descripcion ='ASESOR MOVIL' 

delete from ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CustomerManagement.UpdateCustomerRENAPO' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.UpdateCustomerRENAPO', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-----------------------------------------------------
-------- TRANSACCIONES ------------------------------
-----------------------------------------------------

use cobis
GO

DECLARE @w_numero int, @w_producto int
select @w_numero = 36009
select @w_producto = 36
-- reprocesable
delete cobis..ad_tr_autorizada where ta_transaccion = @w_numero and ta_producto = @w_producto
delete cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero and pt_producto = @w_producto
delete cobis..cl_ttransaccion where tn_trn_code = @w_numero
delete cobis..ad_procedure where pd_procedure = @w_numero

-- sql\ca_segur.sql
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (@w_numero,'sp_equivalencias','cob_conta_super','V',getdate(),'equiv.sp')

insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values (@w_numero, 'OBTENER EQUIVALENCIAS', convert(varchar,@w_numero), 'OBTENER EQUIVALENCIAS')

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (@w_producto,'R',0,@w_numero,'V',getdate(),@w_numero)

declare @w_moneda tinyint, @w_fecha datetime, @w_rol int
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
set    @w_fecha = getdate()

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, getdate(), 1, 'V', getdate())
go

