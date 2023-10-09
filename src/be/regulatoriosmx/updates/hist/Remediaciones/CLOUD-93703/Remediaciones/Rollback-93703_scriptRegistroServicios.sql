print '-- DELETE DE SERVICIOS'
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
    if exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchDetailAmortizacion' and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)        
        DELETE ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchDetailAmortizacion' and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda
        	
	if exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchDetailAmortizacion')
	    DELETE cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchDetailAmortizacion'

/*SearchDetailMovements*/			
    if exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchDetailMovements'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)        
        DELETE ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchDetailMovements'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda
        	
	if exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchDetailMovements')
	    DELETE cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchDetailMovements'

/*SearchMovementsTotal*/			
    if exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchMovementsTotal'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)        
        DELETE ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchMovementsTotal'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda
        	
	if exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchMovementsTotal')
	    DELETE cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchMovementsTotal'
						
/*SearchLoanInformation*/			
    if exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchLoanInformation'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)        
        DELETE ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchLoanInformation'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda
        	
	if exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchLoanInformation')
	    DELETE cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchLoanInformation'
						
/*SearchDetailAmortizacion*/			
    if exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchStateSccountHeadboard'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)        
        DELETE ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchStateSccountHeadboard'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda
        	
	if exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchStateSccountHeadboard')
	    DELETE cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchStateSccountHeadboard'
		
/*CreateStateAccount*/			
    if exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.LoanMaintenance.CreateStateAccount'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)        
        DELETE ad_servicio_autorizado where 
        ts_servicio = 'Loan.LoanMaintenance.CreateStateAccount'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda
        	
	if exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.LoanMaintenance.CreateStateAccount')
	    DELETE cts_serv_catalog where csc_service_id = 'Loan.LoanMaintenance.CreateStateAccount'			

/*ExecutionOptions*/			
    if exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.ExecutionOptions'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)        
        DELETE ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.ExecutionOptions'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda
        	
	if exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.ExecutionOptions')
	    DELETE cts_serv_catalog where csc_service_id = 'Loan.StateAccount.ExecutionOptions'

end
else
begin
    select @w_rol = ro_rol from ad_rol where ro_descripcion = 'ADMINISTRADOR'
/*SearchDetailAmortizacion*/
    if exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchDetailAmortizacion' and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)        
        DELETE ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchDetailAmortizacion' and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda
        	
	if exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchDetailAmortizacion')
	    DELETE cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchDetailAmortizacion'

/*SearchDetailMovements*/			
    if exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchDetailMovements'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)        
        DELETE ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchDetailMovements'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda
        	
	if exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchDetailMovements')
	    DELETE cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchDetailMovements'

/*SearchMovementsTotal*/			
    if exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchMovementsTotal'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)        
        DELETE ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchMovementsTotal'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda
        	
	if exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchMovementsTotal')
	    DELETE cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchMovementsTotal'
						
/*SearchLoanInformation*/			
    if exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchLoanInformation'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)        
        DELETE ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchLoanInformation'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda
        	
	if exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchLoanInformation')
	    DELETE cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchLoanInformation'
						
/*SearchDetailAmortizacion*/			
    if exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchStateSccountHeadboard'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)        
        DELETE ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.SearchStateSccountHeadboard'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda
        	
	if exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchStateSccountHeadboard')
	    DELETE cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchStateSccountHeadboard'

/*CreateStateAccount*/			
    if exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.LoanMaintenance.CreateStateAccount'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)        
        DELETE ad_servicio_autorizado where 
        ts_servicio = 'Loan.LoanMaintenance.CreateStateAccount'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda
        	
	if exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.LoanMaintenance.CreateStateAccount')
	    DELETE cts_serv_catalog where csc_service_id = 'Loan.LoanMaintenance.CreateStateAccount'	

/*ExecutionOptions*/			
    if exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.ExecutionOptions'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)        
        DELETE ad_servicio_autorizado where 
        ts_servicio = 'Loan.StateAccount.ExecutionOptions'  and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda
        	
	if exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.ExecutionOptions')
	    DELETE cts_serv_catalog where csc_service_id = 'Loan.StateAccount.ExecutionOptions'

end								
go
