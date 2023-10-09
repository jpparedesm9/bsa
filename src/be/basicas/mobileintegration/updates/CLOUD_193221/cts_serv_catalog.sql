use cobis
GO
    
	
declare @w_rol int, @w_producto int

select @w_rol = ro_rol from ad_rol where ro_descripcion = 'ASESOR'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

-------------------------
--SERVICIO SearchSyncCatalogData
-------------------------
delete from cobis..cts_serv_catalog where csc_service_id='MobileManagement.SyncManagement.SearchSyncCatalogData'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('MobileManagement.SyncManagement.SearchSyncCatalogData','cobiscorp.ecobis.mobilemanagement.service.ISyncManagement','searchSyncCatalogData','obtiene lista de catalogs con fecha de actualizacion',1716)

delete from ad_servicio_autorizado where ts_servicio = 'MobileManagement.SyncManagement.SearchSyncCatalogData' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('MobileManagement.SyncManagement.SearchSyncCatalogData', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

go