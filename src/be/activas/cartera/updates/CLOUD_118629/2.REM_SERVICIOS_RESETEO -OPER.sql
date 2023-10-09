

--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : .sql
-- Parametrizar el rol

--------------------------------------------------------------------------------------------
-- SERVICIO DE RESETEO
--------------------------------------------------------------------------------------------
USE cobis
GO
    
DECLARE @w_rol int, @w_producto INT,@w_moneda TINYINT,@w_rol_1 int
SELECT  @w_rol = ro_rol from cobis..ad_rol where ro_descripcion='OPERACIONES'
SELECT @w_producto = 7 -- select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CARTERA'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'




if exists (select 1 from cobis..ad_rol where ro_descripcion = 'OPERACIONES')
begin
    select @w_rol = ro_rol from ad_rol where ro_descripcion = 'OPERACIONES'
    print 'Ingreso rol operaciones'	
   
    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'BussinesCallCenter.CallCenterManager.ResetInformationImageMessage')	
    insert into cts_serv_catalog
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
    values('BussinesCallCenter.CallCenterManager.ResetInformationImageMessage',  'cobiscorp.ecobis.bussinescallcenter.service.ICallCenterManager', 'resetInformationImageMessage', '', 0, null, null, 'N')

    if not exists (select 1 from ad_servicio_autorizado where 
    ts_servicio = 'BussinesCallCenter.CallCenterManager.ResetInformationImageMessage' and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)    
    insert into ad_servicio_autorizado
    (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
    values('BussinesCallCenter.CallCenterManager.ResetInformationImageMessage', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())
end
else
begin 
    print 'cambio rol'
	select @w_rol = ro_rol from ad_rol where ro_descripcion = 'ADMINISTRADOR'
 
    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'BussinesCallCenter.CallCenterManager.ResetInformationImageMessage')	
    insert into cts_serv_catalog
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
    values('BussinesCallCenter.CallCenterManager.ResetInformationImageMessage',  'cobiscorp.ecobis.bussinescallcenter.service.ICallCenterManager', 'resetInformationImageMessage', '', 0, null, null, 'N')

    if not exists (select 1 from ad_servicio_autorizado where 
    ts_servicio = 'BussinesCallCenter.CallCenterManager.ResetInformationImageMessage' and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)    
    insert into ad_servicio_autorizado
    (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
    values('BussinesCallCenter.CallCenterManager.ResetInformationImageMessage', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())	
end

go