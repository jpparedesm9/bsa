use cobis
go
----------------------------------------------------------- Registro en cts_serv_catalog
select * from cts_serv_catalog where csc_service_id = 'Loan.ReportMaintenance.PreFilledApplication'
delete cts_serv_catalog where csc_service_id = 'Loan.ReportMaintenance.PreFilledApplication'

----------------------------------------------------------- Registro en ad_servicio_autorizado
declare @w_rol int,
        @w_producto int
 
declare @w_roles table (
   rol       int
)

insert into @w_roles
select ro_rol
from ad_rol
where ro_estado = 'V'
 
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CARTERA'
 
select * from ad_servicio_autorizado 
where ts_servicio = 'Loan.ReportMaintenance.PreFilledApplication' 
and ts_producto = @w_producto

delete ad_servicio_autorizado 
where ts_servicio = 'Loan.ReportMaintenance.PreFilledApplication' 
and ts_producto = @w_producto
go
