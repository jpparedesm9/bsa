
--------------------------
-- PAGOS OBJETADOS #108348
--------------------------

use cobis
GO

declare 
@w_rol_1 int,
@w_producto int

select @w_rol_1 = ro_rol from ad_rol 
where ro_descripcion='MESA DE OPERACIONES' 

SELECT @w_producto = pd_producto FROM cobis..cl_producto 
WHERE pd_descripcion = 'CARTERA'

-- GetAllObjetedPayments
delete from cobis..cts_serv_catalog where csc_service_id='RegularizePayments.ObjetedPayments.GetAllObjetedPayments'
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) VALUES ('RegularizePayments.ObjetedPayments.GetAllObjetedPayments', 'cobiscorp.ecobis.regularizepayments.service.IObjetedPayments', 'getAllObjetedPayments', '', 7070001, 'Y')

delete from ad_servicio_autorizado where ts_servicio = 'RegularizePayments.ObjetedPayments.GetAllObjetedPayments' and ts_rol = @w_rol_1
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('RegularizePayments.ObjetedPayments.GetAllObjetedPayments', @w_producto, 'R', 0, getdate(), @w_rol_1, 'V', getdate())


-- InsertObjetedPayments
delete from cobis..cts_serv_catalog where csc_service_id='RegularizePayments.ObjetedPayments.InsertObjetedPayments'
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) VALUES ('RegularizePayments.ObjetedPayments.InsertObjetedPayments', 'cobiscorp.ecobis.regularizepayments.service.IObjetedPayments', 'insertObjetedPayments', '', 7070002, 'Y')

delete from ad_servicio_autorizado where ts_servicio = 'RegularizePayments.ObjetedPayments.InsertObjetedPayments' and ts_rol = @w_rol_1
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('RegularizePayments.ObjetedPayments.InsertObjetedPayments', @w_producto, 'R', 0, getdate(), @w_rol_1, 'V', getdate())


-- OpRegularizePayments
delete from cobis..cts_serv_catalog where csc_service_id='RegularizePayments.ObjetedPayments.OpRegularizePayments'
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) 
VALUES ('RegularizePayments.ObjetedPayments.OpRegularizePayments', 'cobiscorp.ecobis.regularizepayments.service.IObjetedPayments', 'opRegularizePayments', '', 7070003, 'Y')

delete from ad_servicio_autorizado where ts_servicio = 'RegularizePayments.ObjetedPayments.OpRegularizePayments' and ts_rol = @w_rol_1
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('RegularizePayments.ObjetedPayments.OpRegularizePayments', @w_producto, 'R', 0, getdate(), @w_rol_1, 'V', getdate())

-- OpGetPaymentMethods
delete from cobis..cts_serv_catalog where csc_service_id='RegularizePayments.Catalogs.OpGetPaymentMethods'
insert into dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('RegularizePayments.Catalogs.OpGetPaymentMethods', 'cobiscorp.ecobis.regularizepayments.service.ICatalogs', 'opGetPaymentMethods', '',7076, NULL, NULL, 'Y')

delete from cobis..ad_servicio_autorizado where ts_servicio = 'RegularizePayments.Catalogs.OpGetPaymentMethods' and ts_rol = @w_rol_1
insert into cobis..ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('RegularizePayments.Catalogs.OpGetPaymentMethods', @w_producto, 'R', 0, getdate(), @w_rol_1, 'V', getdate())
go