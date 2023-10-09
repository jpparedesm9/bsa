
use cobis
go

declare @w_rol integer, @w_producto int
select @w_rol = ro_rol from ad_rol where ro_descripcion='ASESOR' -- validar con el rol que va a disparar la ejecución desde el REST
SELECT @w_producto = pd_producto FROM cobis..cl_producto 
WHERE pd_descripcion = 'CARTERA'

delete from cobis..cts_serv_catalog where csc_service_id='Parameter.SearchParameterService.SearchByNemonicAndProduct'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Parameter.SearchParameterService.SearchByNemonicAndProduct','cobiscorp.ecobis.parameter.service.ISearchParameterService','searchByNemonicAndProduct','consulta el parámetro por nemonico  y producto',0)

delete from ad_servicio_autorizado where ts_servicio = 'Parameter.SearchParameterService.SearchByNemonicAndProduct' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Parameter.SearchParameterService.SearchByNemonicAndProduct', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
