--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : .sql

print '-- REGISTRO DE SERVICIOS'
go

use cobis
go

declare @w_rol int, @w_producto int, @w_moneda tinyint
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
    select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'

	if not exists (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Loan.LoansQueries.ReadLoanSummary')
       INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
	   VALUES ('Loan.LoansQueries.ReadLoanSummary', 'cobiscorp.ecobis.assets.cloud.service.ILoansQueries', 'readLoanSummary', '', 7203)

    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.LoansQueries.ReadLoanSummary'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)		
    insert into ad_servicio_autorizado
    (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
    values('Loan.LoansQueries.ReadLoanSummary', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())
					
end
else
begin
    select @w_rol = ro_rol from ad_rol where ro_descripcion = 'ADMINISTRADOR'

	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.LoansQueries.ReadLoanSummary')
    INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
	VALUES ('Loan.LoansQueries.ReadLoanSummary', 'cobiscorp.ecobis.assets.cloud.service.ILoansQueries', 'readLoanSummary', '', 7203)
	
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.LoansQueries.ReadLoanSummary'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)		
    insert into ad_servicio_autorizado
    (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
    values('Loan.LoansQueries.ReadLoanSummary', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())	

end

go
