

use cobis
go

declare 
@w_rol_2 int,
@w_producto int

select @w_rol_2 = ro_rol from ad_rol where ro_descripcion='OPERACIONES' 

SELECT @w_producto = pd_producto FROM cobis..cl_producto 
WHERE pd_descripcion = 'CARTERA'

--REGISTER PAYMENT
delete from cobis..cts_serv_catalog where csc_service_id='Payments.MassivePayment.RegisterPayment'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Payments.MassivePayment.RegisterPayment','cobiscorp.ecobis.payments.service.IMassivePayment','registerPayment','registra el pago tomado del archivo',0)

delete from ad_servicio_autorizado where ts_servicio = 'Payments.MassivePayment.RegisterPayment'and ts_rol = @w_rol_2
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Payments.MassivePayment.RegisterPayment', @w_producto, 'R', 0, getdate(), @w_rol_2, 'V', getdate())


--VALIDATE PAYMENTS
delete from cobis..cts_serv_catalog where csc_service_id='Payments.MassivePayment.ValidatePayments'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Payments.MassivePayment.ValidatePayments','cobiscorp.ecobis.payments.service.IMassivePayment','validatePayments','valida las condiciones de los pagos cargados a través del archivo',0)

delete from ad_servicio_autorizado where ts_servicio = 'Payments.MassivePayment.ValidatePayments'and ts_rol = @w_rol_2
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Payments.MassivePayment.ValidatePayments', @w_producto, 'R', 0, getdate(), @w_rol_2, 'V', getdate())


--EXECUTE PAYMENTS
delete from cobis..cts_serv_catalog where csc_service_id='Payments.MassivePayment.ExecutePayments'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Payments.MassivePayment.ExecutePayments','cobiscorp.ecobis.payments.service.IMassivePayment','executePayments','ejecuta los pagos tomados desde el archivo',0)


delete from ad_servicio_autorizado where ts_servicio = 'Payments.MassivePayment.ExecutePayments'and ts_rol = @w_rol_2
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Payments.MassivePayment.ExecutePayments', @w_producto, 'R', 0, getdate(), @w_rol_2, 'V', getdate())


--GET PAYMENTS RESULT
delete from cobis..cts_serv_catalog where csc_service_id='Payments.MassivePayment.GetPaymentsResult'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Payments.MassivePayment.GetPaymentsResult','cobiscorp.ecobis.payments.service.IMassivePayment','getPaymentsResult','consulta el resultado de la ejecución de los pagos',0)


delete from ad_servicio_autorizado where ts_servicio = 'Payments.MassivePayment.GetPaymentsResult'and ts_rol = @w_rol_2
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Payments.MassivePayment.GetPaymentsResult', @w_producto, 'R', 0, getdate(), @w_rol_2, 'V', getdate())


