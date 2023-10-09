
go

-----------------
--BORRANDO DATA
-----------------

delete cts_serv_catalog
where csc_service_id in (
'MobileManagement.SyncManagement.DeviceSync'
)

delete ad_servicio_autorizado
where ts_servicio in (

'MobileManagement.SyncManagement.DeviceSync'

)

declare @w_rol int,
        @w_producto int

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
    select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
    insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
    values (@w_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'



-------------------------
--SERVICIO DeviceSync
-------------------------

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('MobileManagement.SyncManagement.DeviceSync', 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', 'deviceSync', '', 0, NULL, NULL, NULL)


INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('MobileManagement.SyncManagement.DeviceSync', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

GO