----------------------------------------------------------
-------------    SERVICIOS    ----------------------------
----------------------------------------------------------
use cobis
go

declare @w_rol integer, @w_producto int
select @w_rol = ro_rol from ad_rol where ro_descripcion='MENU POR PROCESOS' -- validar con el rol que va a disparar la ejecucion desde el REST
SELECT @w_producto = pd_producto FROM cobis..cl_producto 
WHERE pd_descripcion = 'CARTERA'


delete from cobis..cts_serv_catalog where csc_service_id='PaymentsCollect.PaymentsCollect.QueryListCollect'
delete from ad_servicio_autorizado where ts_servicio = 'PaymentsCollect.PaymentsCollect.QueryListCollect' and ts_rol = @w_rol
