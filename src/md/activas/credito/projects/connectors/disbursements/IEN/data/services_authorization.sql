--Autorizacion de servicios java
use cobis
go


if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Disbursement.ValidationService')
begin
	INSERT INTO cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
	VALUES ('Disbursement.ValidationService', 'com.cobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.tasklet.IValidation', 'execute', 'Description', NULL, NULL, NULL, 'N')
end

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Disbursement.ValidationService' and ts_rol = 3)
begin
	INSERT INTO cobis..ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
	VALUES ('Disbursement.ValidationService', 3, 1, 'R', 0, getdate(), 'V', getdate())
end

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Disbursement.ValidationService' and ts_rol = 1)
begin
	INSERT INTO cobis..ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
	VALUES ('Disbursement.ValidationService', 1, 1, 'R', 0, getdate(), 'V', getdate())
end
go