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
delete from cobis..cts_serv_catalog where csc_service_id='PaymentsCollect.PaymentsCollect.QueryListCollect'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('PaymentsCollect.PaymentsCollect.QueryListCollect','cobiscorp.ecobis.mccollect.service.IPaymentsCollect','queryListCollect','obtiene lista de pagos historicos',0)

delete from ad_servicio_autorizado where ts_servicio = 'PaymentsCollect.PaymentsCollect.QueryListCollect' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('PaymentsCollect.PaymentsCollect.QueryListCollect', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())