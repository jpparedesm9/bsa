


use cobis
go

declare 
@w_rol int,
@w_producto int,
@w_menu_id int


select @w_rol = ro_rol from ad_rol where ro_descripcion='MESA DE OPERACIONES'

SELECT @w_producto = pd_producto FROM cobis..cl_producto 
WHERE pd_descripcion = 'CARTERA'

---PERMISOS EN SERVICIOS
delete from ad_servicio_autorizado where ts_servicio = 'Payments.MassivePayment.RegisterPayment'and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Payments.MassivePayment.RegisterPayment', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())


delete from ad_servicio_autorizado where ts_servicio = 'Payments.MassivePayment.ValidatePayments'and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Payments.MassivePayment.ValidatePayments', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

delete from ad_servicio_autorizado where ts_servicio = 'Payments.MassivePayment.ExecutePayments'and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Payments.MassivePayment.ExecutePayments', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())


delete from ad_servicio_autorizado where ts_servicio = 'Payments.MassivePayment.GetPaymentsResult'and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Payments.MassivePayment.GetPaymentsResult', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

--PERMISOS EN MENU
select @w_menu_id=me_id from cobis..cew_menu where me_name='MNU_CARGA_MASIVA'
if not exists(select 1 from cobis..cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
insert into cobis..cew_menu_role values (@w_menu_id,@w_rol)