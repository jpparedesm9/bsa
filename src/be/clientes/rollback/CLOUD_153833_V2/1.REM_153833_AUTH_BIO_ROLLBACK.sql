use cobis
go


declare 
@w_rol int,
@w_producto int

SELECT @w_producto = pd_producto FROM cl_producto WHERE pd_descripcion = 'CLIENTES'
SELECT @w_rol = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'ADMINISTRADOR'
--------------------------------------------
--- SERVICIO PARA OBTENER ACCESS TOKEN -----
--------------------------------------------
delete from cts_serv_catalog where csc_service_id = 'OrchestrationBiometricServiceSERVImpl.accessTokenBC'
delete from ad_servicio_autorizado where ts_servicio = 'OrchestrationBiometricServiceSERVImpl.accessTokenBC' and ts_rol = @w_rol

------------------------------------------------
--- SERVICIO PARA OBTENER EL ID DE OFICINA -----
------------------------------------------------
delete from cts_serv_catalog where csc_service_id = 'CustomerBiocheck.CustomerBiocheck.QueryOfficeId'
delete from ad_servicio_autorizado where ts_servicio = 'CustomerBiocheck.CustomerBiocheck.QueryOfficeId' and ts_rol = @w_rol

------------------------------------------------
--- SERVICIO PARA OBTENER EL ID DE OFICINA -----
------------------------------------------------
delete from cts_serv_catalog where csc_service_id = 'CustomerBiocheck.CustomerBiocheck.ValidateErrorBiocheck'
delete from ad_servicio_autorizado where ts_servicio = 'CustomerBiocheck.CustomerBiocheck.ValidateErrorBiocheck' and ts_rol = @w_rol

go

