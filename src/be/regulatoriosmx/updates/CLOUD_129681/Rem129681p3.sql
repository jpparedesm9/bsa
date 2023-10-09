----------------------------------------------------------
-------------    SERVICIOS    ----------------------------
----------------------------------------------------------
use cobis
go

declare @w_rol integer, @w_producto int
select @w_rol = ro_rol from ad_rol where ro_descripcion='MENU POR PROCESOS' -- validar con el rol que va a disparar la ejecucion desde el REST
SELECT @w_producto = pd_producto FROM cobis..cl_producto 
WHERE pd_descripcion = 'CARTERA'

--CONSULTA 
delete from cobis..cts_serv_catalog where csc_service_id='McCollect.PaymentsCollect.UpdatePaymentSolidarity'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('McCollect.PaymentsCollect.UpdatePaymentSolidarity','cobiscorp.ecobis.mccollect.service.IPaymentsCollect','updatePaymentSolidarity','Pagos cliente grp Sol',0)

delete from ad_servicio_autorizado where ts_servicio = 'McCollect.PaymentsCollect.UpdatePaymentSolidarity' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('McCollect.PaymentsCollect.UpdatePaymentSolidarity', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-----------
use cobis
go

declare @w_rol integer, @w_producto int
select @w_rol = ro_rol from ad_rol where ro_descripcion='MENU POR PROCESOS' -- validar con el rol que va a disparar la ejecucion desde el REST
SELECT @w_producto = pd_producto FROM cobis..cl_producto 
WHERE pd_descripcion = 'CARTERA'

--CONSULTA 
delete from cobis..cts_serv_catalog where csc_service_id='McCollect.PaymentsCollect.ValidatePaymentSolidarity'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('McCollect.PaymentsCollect.ValidatePaymentSolidarity','cobiscorp.ecobis.mccollect.service.IPaymentsCollect','validatePaymentSolidarity','validar pagos cliente grp Sol',0)

delete from ad_servicio_autorizado where ts_servicio = 'McCollect.PaymentsCollect.ValidatePaymentSolidarity' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('McCollect.PaymentsCollect.ValidatePaymentSolidarity', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

---use cobis
go

declare @w_rol integer, @w_producto int
select @w_rol = ro_rol from ad_rol where ro_descripcion='MENU POR PROCESOS' -- validar con el rol que va a disparar la ejecucion desde el REST
SELECT @w_producto = pd_producto FROM cobis..cl_producto 
WHERE pd_descripcion = 'CARTERA'

--CONSULTA 
delete from cobis..cts_serv_catalog where csc_service_id='McCollect.PaymentsCollect.InsertPaymentSolidarity'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('McCollect.PaymentsCollect.InsertPaymentSolidarity','cobiscorp.ecobis.mccollect.service.IPaymentsCollect','insertPaymentSolidarity','Insercion temporal de tablas',0)

delete from ad_servicio_autorizado where ts_servicio = 'McCollect.PaymentsCollect.InsertPaymentSolidarity' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('McCollect.PaymentsCollect.InsertPaymentSolidarity', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

--Errores
select * from cobis..cl_errores
where numero in (720313,720314,720315,720316,720317,720318,720319)
--Eroores para pagos Grupales Solidarios
use cobis
go

delete from cobis..cl_errores
where numero in (720313,720314,720315,720316,720317,720318,720319,720320)

insert into cobis..cl_errores (numero, severidad, mensaje)
values (720313, 0, 'EL CONTRATO NO CORRESPONDE A UN CREDITO AGRUPADOR ')
go

insert into cobis..cl_errores (numero, severidad, mensaje)
values (720314, 0, 'EL MONTO TOTAL NO ES IGUAL A LA SUMA DE LOS MONTOS INDIVIDUALES ')
go

insert into cobis..cl_errores (numero, severidad, mensaje)
values (720315, 0, 'EL ID DE CANAL DEL PAGO NO EXISTE EN COBIS ')
go

insert into cobis..cl_errores (numero, severidad, mensaje)
values (720316, 0, 'EL MONTO INGRESADO NO CORRESPONDE AL MONTO REGISTRADO EN COBIS ')
go

insert into cobis..cl_errores (numero, severidad, mensaje)
values (720317, 0, 'ALGUNO DE LOS CLIENTES NO PERTENECE  AL GRUPO ')
go


insert into cobis..cl_errores (numero, severidad, mensaje)
values (720318, 0, 'LOS MONTOS DE LOS CLIENTES DEBE SER MAYOR A CERO ')
go

insert into cobis..cl_errores (numero, severidad, mensaje)
values (720319, 0, 'EL NUMERO DE DECIMALES DE LOS MONTOS INDIVIDUALES DEBE SER HASTA 2 ')
go

insert into cobis..cl_errores (numero, severidad, mensaje)
values (720320, 0, 'EL ID DE CANAL DEL PAGO NO CORRESPONDE AL CREDITO AGRUPADOR ')
go


