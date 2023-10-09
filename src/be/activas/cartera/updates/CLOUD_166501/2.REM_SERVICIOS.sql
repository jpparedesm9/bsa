

--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : .sql
-- Parametrizar el rol

--------------------------------------------------------------------------------------------
-- SERVICIO DE RESETEO
--------------------------------------------------------------------------------------------

-- TODO: Falta hacer la transacción
USE cobis
GO
    
DECLARE @w_rol int, @w_producto INT,@w_moneda TINYINT,@w_rol_1 int
SELECT  @w_rol = ro_rol from cobis..ad_rol where ro_descripcion='MENU POR PROCESOS'
SELECT @w_producto = 7 -- select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CARTERA'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'

/*Inserto el Rol si no existe */  
    
if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
    select @w_rol_1 =  max(ro_rol)+1 from cobis..ad_rol
    insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
    values (@w_rol_1, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
END


if exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
    select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'
	
   
    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'IndividualLoan.DisbursementManagement.GenerateReferenceCreditLine' and csc_method_name = 'generateReferenceCreditLine')	
    insert into cts_serv_catalog
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
    values('IndividualLoan.DisbursementManagement.GenerateReferenceCreditLine',  'cobiscorp.ecobis.individualloan.service.IDisbursementManagement', 'generateReferenceCreditLine', '', 0, null, null, 'N')

    if not exists (select 1 from ad_servicio_autorizado where 
    ts_servicio = 'IndividualLoan.DisbursementManagement.GenerateReferenceCreditLine' and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)    
    insert into ad_servicio_autorizado
    (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
    values('IndividualLoan.DisbursementManagement.GenerateReferenceCreditLine', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())
end
else
begin 
    print 'cambio rol'
	select @w_rol = ro_rol from ad_rol where ro_descripcion = 'ADMINISTRADOR'
 
    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'IndividualLoan.DisbursementManagement.GenerateReferenceCreditLine' and csc_method_name = 'generateReferenceCreditLine')	
    insert into cts_serv_catalog
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
    values('IndividualLoan.DisbursementManagement.GenerateReferenceCreditLine',  'cobiscorp.ecobis.individualloan.service.IDisbursementManagement', 'generateReferenceCreditLine', '', 0, null, null, 'N')

    if not exists (select 1 from ad_servicio_autorizado where 
    ts_servicio = 'IndividualLoan.DisbursementManagement.GenerateReferenceCreditLine' and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)    
    insert into ad_servicio_autorizado
    (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
    values('IndividualLoan.DisbursementManagement.GenerateReferenceCreditLine', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())	
end

go