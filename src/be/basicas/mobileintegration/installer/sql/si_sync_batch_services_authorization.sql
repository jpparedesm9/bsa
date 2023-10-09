-- Remediacion

-- Actualizar el nombre en la cts_aplicacion 

if exists (select 1 from cobis..cts_aplicacion where ap_id_aplicacion = 200)
begin
   update cobis..cts_aplicacion
   set ap_nombre = 'SCHEDULER CTS'
   where ap_id_aplicacion = 200 
end

DECLARE
	@w_rol INT,
	@w_producto INT,
	@w_transaccion INT

SELECT @w_rol = ro_rol
FROM cobis..ad_rol
WHERE ro_descripcion = 'SCHEDULER CTS'

SELECT @w_producto = pd_producto
FROM cobis..cl_producto
WHERE pd_abreviatura = 'MIS'

SET @w_transaccion = 775072

-- SE INSERTA EN LA TABLA DE REGISTRO DE SERVICIOS
delete from cobis.dbo.cts_serv_catalog where csc_service_id = 'MobileManagement.SyncManagement.DeviceSyncBatch'
insert into cobis.dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values ('MobileManagement.SyncManagement.DeviceSyncBatch', 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', 'deviceSyncBatch', 'Tanqueo de sincronizacion', 0)

-- SE INSERTA EN LA TABLA DE AUTORIZACION
delete from cobis.dbo.ad_servicio_autorizado where ts_servicio = 'MobileManagement.SyncManagement.DeviceSyncBatch'
insert into cobis.dbo.ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values ('MobileManagement.SyncManagement.DeviceSyncBatch', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-- SE INSERTA EN LA TABLA DE TRANSACCIONES CON EL SECUENCIAL DE TRANSACCIONES
delete from cobis..cl_ttransaccion where tn_trn_code = @w_transaccion
INSERT INTO cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
VALUES(@w_transaccion, 'SINCRONIZACION MOVILES OFICIALES', 'SMO', 'SINCRONIZACION MOVILES OFICIALES')

-- SE INSERTA EN LA TABLA AD_PROCEDURE EL SP CON EL SECUENCUAL DE PROCEDURE
delete from cobis..ad_procedure where pd_procedure = @w_transaccion
INSERT INTO cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
VALUES(@w_transaccion, 'sp_sincroniza_batch', 'cob_sincroniza', 'V', getdate(), 'sp_snc_btch.sp')

-- ASOCIACION DE LA TRANSACCION CON EL SP POR LA TRANSACCION SECUENCIAL
delete from cobis..ad_pro_transaccion where pt_transaccion = @w_transaccion and pt_procedure = @w_transaccion
INSERT INTO cobis..ad_pro_transaccion(pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
VALUES(@w_producto, 'R', 0, @w_transaccion, 'V', getdate(), @w_transaccion, NULL)

-- AUTORIZACION DE LA TRANSACCION EN EL ROL DEL SCHEDULER DE CTS
delete from cobis..ad_tr_autorizada where ta_transaccion = @w_transaccion
INSERT INTO cobis..ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
VALUES(@w_producto, 'R', 0, @w_transaccion, 18, getdate(), 1, 'V', getdate())
