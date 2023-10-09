--INSERT EN LA TABLA cts_serv_catalog
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description)
values ('CtsService.registerCtsEntity', 'com.cobiscorp.ecobis.fpm.fpm_cobis_portfolio_dao.service.CtsService', 'registerCtsEntity', 'Prueba de Servicio con JPA')

--INSERT EN LA TABLA ad_servicio_autorizado 
insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values ('CtsService.registerCtsEntity', 1, 1, 'R', 0, getdate(), 'V', getdate())