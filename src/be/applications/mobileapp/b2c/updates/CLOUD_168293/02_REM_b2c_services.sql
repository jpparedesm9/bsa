-- \bsa\src\be\applications\mobileapp\b2c\installer\sql\b2c_services.sql

use cobis
go

declare 
@w_producto        int,
@w_rol             int

select @w_rol = ro_rol
from cobis..ad_rol
where ro_descripcion = 'MENU POR PROCESOS' 

select @w_producto = pd_producto 
from  cl_producto 
where pd_descripcion = 'BANCA VIRTUAL'

delete ad_servicio_autorizado where ts_servicio in ('BusinessToConsumer.BioOnboardManagement.QueryOCRInfor')
delete cts_serv_catalog where csc_service_id in ('BusinessToConsumer.BioOnboardManagement.QueryOCRInfor')


INSERT INTO cts_serv_catalog(
	csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, 
	csc_support_offline, csc_component, csc_procedure_validation)
VALUES(
	'BusinessToConsumer.BioOnboardManagement.QueryOCRInfor', 'cobiscorp.ecobis.businesstoconsumer.service.IBioOnboardManagement', 
	'queryOCRInfor', '', 0, NULL, NULL, 'Y')

INSERT INTO ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BusinessToConsumer.BioOnboardManagement.QueryOCRInfor', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-- -----
delete ad_servicio_autorizado where ts_servicio in ('BusinessToConsumer.BioOnboardManagement.QuerySCORESInfor')
delete cts_serv_catalog where csc_service_id in ('BusinessToConsumer.BioOnboardManagement.QuerySCORESInfor')


INSERT INTO cts_serv_catalog(
	csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, 
	csc_support_offline, csc_component, csc_procedure_validation)
VALUES(
	'BusinessToConsumer.BioOnboardManagement.QuerySCORESInfor', 'cobiscorp.ecobis.businesstoconsumer.service.IBioOnboardManagement', 
	'querySCORESInfor', '', 0, NULL, NULL, 'Y')

INSERT INTO ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BusinessToConsumer.BioOnboardManagement.QuerySCORESInfor', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-- -----

delete ad_servicio_autorizado where ts_servicio in ('BusinessToConsumer.BioOnboardManagement.InsertFingerIDResponse')
delete cts_serv_catalog where csc_service_id in ('BusinessToConsumer.BioOnboardManagement.InsertFingerIDResponse')


INSERT INTO cts_serv_catalog(
	csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, 
	csc_support_offline, csc_component, csc_procedure_validation)
VALUES(
	'BusinessToConsumer.BioOnboardManagement.InsertFingerIDResponse', 'cobiscorp.ecobis.businesstoconsumer.service.IBioOnboardManagement', 
	'insertFingerIDResponse', '', 0, NULL, NULL, 'Y')

INSERT INTO ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('BusinessToConsumer.BioOnboardManagement.InsertFingerIDResponse', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


go

