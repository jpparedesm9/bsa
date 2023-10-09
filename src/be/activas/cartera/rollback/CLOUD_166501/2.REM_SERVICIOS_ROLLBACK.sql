

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
    
delete from cts_serv_catalog where csc_service_id = 'IndividualLoan.DisbursementManagement.GenerateReferenceCreditLine' and csc_method_name = 'generateReferenceCreditLine'
delete from ad_servicio_autorizado where     ts_servicio = 'IndividualLoan.DisbursementManagement.GenerateReferenceCreditLine' and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda

select @w_rol = ro_rol from ad_rol where ro_descripcion = 'ADMINISTRADOR'
delete from ad_servicio_autorizado where     ts_servicio = 'IndividualLoan.DisbursementManagement.GenerateReferenceCreditLine' and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda

GO