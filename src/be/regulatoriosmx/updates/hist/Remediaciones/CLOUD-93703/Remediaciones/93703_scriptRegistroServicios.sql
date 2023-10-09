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
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CARTERA'

if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
    select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'
/*SearchDetailAmortizacion*/
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchDetailAmortizacion'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.StateAccount.SearchDetailAmortizacion', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchDetailAmortizacion')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Loan.StateAccount.SearchDetailAmortizacion','cobiscorp.ecobis.assets.cloud.service.IStateAccount','searchDetailAmortizacion', '',36005, null, null, null)

/*SearchDetailMovements*/
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchDetailMovements'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.StateAccount.SearchDetailMovements', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchDetailMovements')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Loan.StateAccount.SearchDetailMovements','cobiscorp.ecobis.assets.cloud.service.IStateAccount','searchDetailMovements', '',36005, null, null, null)

/*SearchMovementsTotal*/
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchMovementsTotal'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.StateAccount.SearchMovementsTotal', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchMovementsTotal')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Loan.StateAccount.SearchMovementsTotal','cobiscorp.ecobis.assets.cloud.service.IStateAccount','searchMovementsTotal', '',36005, null, null, null)
	
/*SearchLoanInformation*/
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchLoanInformation'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.StateAccount.SearchLoanInformation', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchLoanInformation')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Loan.StateAccount.SearchLoanInformation','cobiscorp.ecobis.assets.cloud.service.IStateAccount','searchLoanInformation', '',36005, null, null, null)

/*SearchStateSccountHeadboard*/
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchStateSccountHeadboard'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.StateAccount.SearchStateSccountHeadboard', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchStateSccountHeadboard')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Loan.StateAccount.SearchStateSccountHeadboard','cobiscorp.ecobis.assets.cloud.service.IStateAccount','searchStateAccountHeadboard', '',36005, null, null, null)
	
/*CreateStateAccount*/
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.LoanMaintenance.CreateStateAccount'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.LoanMaintenance.CreateStateAccount', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.LoanMaintenance.CreateStateAccount')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Loan.LoanMaintenance.CreateStateAccount','cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance','createStateAccount', '',36006, null, null, null)

/*ExecutionOptions*/
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.ExecutionOptions'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.StateAccount.ExecutionOptions', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.ExecutionOptions')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Loan.StateAccount.ExecutionOptions','cobiscorp.ecobis.assets.cloud.service.IStateAccount','executionOptions', '',36005, null, null, null)
		
end
else
begin
    select @w_rol = ro_rol from ad_rol where ro_descripcion = 'ADMINISTRADOR'
/*SearchDetailAmortizacion*/
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchDetailAmortizacion'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.StateAccount.SearchDetailAmortizacion', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchDetailAmortizacion')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Loan.StateAccount.SearchDetailAmortizacion','cobiscorp.ecobis.assets.cloud.service.IStateAccount','searchDetailAmortizacion', '',36005, null, null, null)

/*SearchDetailMovements*/
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchDetailMovements'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.StateAccount.SearchDetailMovements', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchDetailMovements')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Loan.StateAccount.SearchDetailMovements','cobiscorp.ecobis.assets.cloud.service.IStateAccount','searchDetailMovements', '',36005, null, null, null)

/*SearchMovementsTotal*/
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchMovementsTotal'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.StateAccount.SearchMovementsTotal', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchMovementsTotal')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Loan.StateAccount.SearchMovementsTotal','cobiscorp.ecobis.assets.cloud.service.IStateAccount','searchMovementsTotal', '',36005, null, null, null)
	
/*SearchLoanInformation*/
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchLoanInformation'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.StateAccount.SearchLoanInformation', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchLoanInformation')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Loan.StateAccount.SearchLoanInformation','cobiscorp.ecobis.assets.cloud.service.IStateAccount','searchLoanInformation', '',36005, null, null, null)

/*SearchStateSccountHeadboard*/
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchStateSccountHeadboard'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.StateAccount.SearchStateSccountHeadboard', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchStateSccountHeadboard')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Loan.StateAccount.SearchStateSccountHeadboard','cobiscorp.ecobis.assets.cloud.service.IStateAccount','searchStateAccountHeadboard', '',36005, null, null, null)

/*CreateStateAccount*/
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.LoanMaintenance.CreateStateAccount'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.LoanMaintenance.CreateStateAccount', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.LoanMaintenance.CreateStateAccount')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Loan.LoanMaintenance.CreateStateAccount','cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance','createStateAccount', '',36006, null, null, null)

/*ExecutionOptions*/
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.ExecutionOptions'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('Loan.StateAccount.ExecutionOptions', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.ExecutionOptions')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('Loan.StateAccount.ExecutionOptions','cobiscorp.ecobis.assets.cloud.service.IStateAccount','executionOptions', '',36005, null, null, null)
			
end

go
