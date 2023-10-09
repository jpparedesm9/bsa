use cobis
go
delete from cobis..cl_errores
where numero in (720313,720314,720315,720316,720317,720318,720319,720320)
go 

use cobis
go

declare @w_rol integer, @w_producto int
select @w_rol = ro_rol from ad_rol where ro_descripcion='MENU POR PROCESOS' -- validar con el rol que va a disparar la ejecucion desde el REST
SELECT @w_producto = pd_producto FROM cobis..cl_producto 
WHERE pd_descripcion = 'CARTERA'
--Servicios
delete from cobis..cts_serv_catalog where csc_service_id='McCollect.PaymentsCollect.UpdatePaymentSolidarity'
delete from ad_servicio_autorizado where ts_servicio = 'McCollect.PaymentsCollect.UpdatePaymentSolidarity' and ts_rol = @w_rol


-----------
use cobis
go

declare @w_rol integer, @w_producto int
select @w_rol = ro_rol from ad_rol where ro_descripcion='MENU POR PROCESOS' -- validar con el rol que va a disparar la ejecucion desde el REST
SELECT @w_producto = pd_producto FROM cobis..cl_producto 
WHERE pd_descripcion = 'CARTERA'

--CONSULTA 
delete from cobis..cts_serv_catalog where csc_service_id='McCollect.PaymentsCollect.ValidatePaymentSolidarity'
delete from ad_servicio_autorizado where ts_servicio = 'McCollect.PaymentsCollect.ValidatePaymentSolidarity' and ts_rol = @w_rol


---use cobis
go

declare @w_rol integer, @w_producto int
select @w_rol = ro_rol from ad_rol where ro_descripcion='MENU POR PROCESOS' -- validar con el rol que va a disparar la ejecucion desde el REST
SELECT @w_producto = pd_producto FROM cobis..cl_producto 
WHERE pd_descripcion = 'CARTERA'

--CONSULTA 
delete from cobis..cts_serv_catalog where csc_service_id='McCollect.PaymentsCollect.InsertPaymentSolidarity'
delete from ad_servicio_autorizado where ts_servicio = 'McCollect.PaymentsCollect.InsertPaymentSolidarity' and ts_rol = @w_rol

