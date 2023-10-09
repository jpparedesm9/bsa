use cobis
go
----------------------------------------------------------- Registro en cts_serv_catalog
select * from cts_serv_catalog where csc_service_id = 'Loan.ReportMaintenance.PreFilledApplication'

delete cts_serv_catalog where csc_service_id = 'Loan.ReportMaintenance.PreFilledApplication'
 
if not exists ( select 1 from cts_serv_catalog where csc_service_id = 'Loan.ReportMaintenance.PreFilledApplication')
begin
    insert into cts_serv_catalog(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
    values('Loan.ReportMaintenance.PreFilledApplication','cobiscorp.ecobis.assets.cloud.service.IReportMaintenance', 'preFilledApplication', '', 0)
end
go
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
 
select * from ad_servicio_autorizado where ts_servicio = 'Loan.ReportMaintenance.PreFilledApplication' and 
                ts_rol in (select rol from @w_roles) and ts_producto = @w_producto

delete ad_servicio_autorizado 
where ts_servicio = 'Loan.ReportMaintenance.PreFilledApplication' 
and ts_rol in (select rol from @w_roles) and ts_producto = @w_producto
				
if not exists ( select 1 from ad_servicio_autorizado where ts_servicio = 'Loan.ReportMaintenance.PreFilledApplication' and ts_producto = @w_producto
                and ts_rol in (select rol from @w_roles))
begin
    insert into ad_servicio_autorizado 
    select 'Loan.ReportMaintenance.PreFilledApplication',rol, @w_producto, 'R', 0, getdate(), 'V', getdate()
    from @w_roles
end
 
go
