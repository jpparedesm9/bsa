-----------------------------------------------------------
-----------------------------------------------------------
use cobis
go
----------------------------------------------------------- Registro en cts_serv_catalog

if not exists ( select 1 from cts_serv_catalog where csc_service_id = 'LoanGroup.ReportMaintenance.SearchKYC')
begin
    insert into cts_serv_catalog(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
    values('LoanGroup.ReportMaintenance.SearchKYC','cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'searchKYC', '', 1718)
end
go
-----------------------------------------------------------
-----------------------------------------------------------
use cobis
go
----------------------------------------------------------- Registro en ad_servicio_autorizado
declare @w_rol int,
        @w_producto int
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR' -- 1
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

if not exists ( select 1 from ad_servicio_autorizado where ts_servicio = 'LoanGroup.ReportMaintenance.SearchKYC' and 
                ts_rol = @w_rol and @w_producto = @w_producto)
begin
    insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
    values('LoanGroup.ReportMaintenance.SearchKYC',@w_rol, @w_producto,'R',0,getdate(),'V',getdate())
end
go
-----------------------------------------------------------
-----------------------------------------------------------
declare @w_rol int,
        @w_producto int

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'OPERADOR DE BATCH COBIS' -- 2
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

if not exists ( select 1 from ad_servicio_autorizado where ts_servicio = 'LoanGroup.ReportMaintenance.SearchKYC' and 
                ts_rol = @w_rol and @w_producto = @w_producto)
begin
    insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
    values('LoanGroup.ReportMaintenance.SearchKYC',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())
end
go
-----------------------------------------------------------
-----------------------------------------------------------

declare @w_rol int,
        @w_producto int

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS' -- 3
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

if not exists ( select 1 from ad_servicio_autorizado where ts_servicio = 'LoanGroup.ReportMaintenance.SearchKYC' and 
                ts_rol = @w_rol and @w_producto = @w_producto)
begin
    insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
    values('LoanGroup.ReportMaintenance.SearchKYC',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())
end
go
-----------------------------------------------------------
-----------------------------------------------------------

declare @w_rol int,
        @w_producto int

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR DE VERSIONES' --4
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

if not exists ( select 1 from ad_servicio_autorizado where ts_servicio = 'LoanGroup.ReportMaintenance.SearchKYC' and 
                ts_rol = @w_rol and @w_producto = @w_producto)
begin
    insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
    values('LoanGroup.ReportMaintenance.SearchKYC',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())
end
go
-----------------------------------------------------------
-----------------------------------------------------------

declare @w_rol int,
        @w_producto int

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR DPF' --5
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

if not exists ( select 1 from ad_servicio_autorizado where ts_servicio = 'LoanGroup.ReportMaintenance.SearchKYC' and 
                ts_rol = @w_rol and @w_producto = @w_producto)
begin
    insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
    values('LoanGroup.ReportMaintenance.SearchKYC',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())
end
go

-----------------------------------------------------------
-----------------------------------------------------------

declare @w_rol int,
        @w_producto int

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'FUNCIONARIO OFICINA' --7
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

if not exists ( select 1 from ad_servicio_autorizado where ts_servicio = 'LoanGroup.ReportMaintenance.SearchKYC' and 
                ts_rol = @w_rol and @w_producto = @w_producto)
begin
    insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
    values('LoanGroup.ReportMaintenance.SearchKYC',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())
end
go
-----------------------------------------------------------
-----------------------------------------------------------

declare @w_rol int,
        @w_producto int

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'CONSULTA' -- 8
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

if not exists ( select 1 from ad_servicio_autorizado where ts_servicio = 'LoanGroup.ReportMaintenance.SearchKYC' and 
                ts_rol = @w_rol and @w_producto = @w_producto)
begin
    insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
    values('LoanGroup.ReportMaintenance.SearchKYC',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())
end
go
-----------------------------------------------------------
-----------------------------------------------------------

declare @w_rol int,
        @w_producto int

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ASESOR' -- 9
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

if not exists ( select 1 from ad_servicio_autorizado where ts_servicio = 'LoanGroup.ReportMaintenance.SearchKYC' and 
                ts_rol = @w_rol and @w_producto = @w_producto)
begin
    insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
    values('LoanGroup.ReportMaintenance.SearchKYC',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())
end
go
-----------------------------------------------------------
-----------------------------------------------------------

declare @w_rol int,
        @w_producto int

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'SUPERVISOR DE BATCH COBIS' -- 10
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

if not exists ( select 1 from ad_servicio_autorizado where ts_servicio = 'LoanGroup.ReportMaintenance.SearchKYC' and 
                ts_rol = @w_rol and @w_producto = @w_producto)
begin
    insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
    values('LoanGroup.ReportMaintenance.SearchKYC',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())
end
go
-----------------------------------------------------------
-----------------------------------------------------------

declare @w_rol int,
        @w_producto int

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'LECTURA DE REPORTES DE BATCH COBIS' -- 11
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

if not exists ( select 1 from ad_servicio_autorizado where ts_servicio = 'LoanGroup.ReportMaintenance.SearchKYC' and 
                ts_rol = @w_rol and @w_producto = @w_producto)
begin
    insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
    values('LoanGroup.ReportMaintenance.SearchKYC',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())
end
go
-----------------------------------------------------------
-----------------------------------------------------------

declare @w_rol int,
        @w_producto int

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'OPERADOR SOFOM' -- 12
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

if not exists ( select 1 from ad_servicio_autorizado where ts_servicio = 'LoanGroup.ReportMaintenance.SearchKYC' and 
                ts_rol = @w_rol and @w_producto = @w_producto)
begin
    insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
    values('LoanGroup.ReportMaintenance.SearchKYC',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())
end
go
