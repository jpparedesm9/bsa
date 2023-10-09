-- Servicios Autorizados
-- Parametrizar el rol
USE cobis
GO
    
DECLARE @rol int, @w_producto int
SELECT @rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
SELECT @w_producto = 7 -- select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CARTERA'

    IF NOT EXISTS (SELECT 1 FROM dbo.ad_servicio_autorizado WHERE ts_servicio = 'Loan.LoanTransaction.QueryLiquidation' AND ts_rol = @rol)
        INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
            VALUES ('Loan.LoanTransaction.QueryLiquidation', @rol, 7, 'R', 0, getdate(), 'V', getdate())        
            
    IF NOT EXISTS (SELECT 1 FROM dbo.ad_servicio_autorizado WHERE ts_servicio = 'Loan.LoanTransaction.QueryDebtorInformation' AND ts_rol = @rol)
        INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
            VALUES ('Loan.LoanTransaction.QueryDebtorInformation', @rol, 7, 'R', 0, getdate(), 'V', getdate())    
            
    IF NOT EXISTS (SELECT 1 FROM dbo.ad_servicio_autorizado WHERE ts_servicio = 'Loan.LoanTransaction.QueryPaymentTableDetail' AND ts_rol = @rol)
        INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
            VALUES ('Loan.LoanTransaction.QueryPaymentTableDetail', @rol, 7, 'R', 0, getdate(), 'V', getdate())        
            
    IF NOT EXISTS (SELECT 1 FROM dbo.ad_servicio_autorizado WHERE ts_servicio = 'Loan.LoanTransaction.QueryPaymentTableDetailsHis' AND ts_rol = @rol)
        INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
            VALUES ('Loan.LoanTransaction.QueryPaymentTableDetailsHis', @rol, 7, 'R', 0, getdate(), 'V', getdate())    
    
    IF NOT EXISTS (SELECT 1 FROM dbo.ad_servicio_autorizado WHERE ts_servicio = 'Loan.LoanTransaction.QueryPaymentTableHead' AND ts_rol = @rol)
        INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
            VALUES ('Loan.LoanTransaction.QueryPaymentTableHead', @rol, 7, 'R', 0, getdate(), 'V', getdate())    
    
    IF NOT EXISTS (SELECT 1 FROM dbo.ad_servicio_autorizado WHERE ts_servicio = 'Loan.LoanTransaction.QueryPaymentTableHeadHis' AND ts_rol = @rol)
        INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
            VALUES ('Loan.LoanTransaction.QueryPaymentTableHeadHis', @rol, 7, 'R', 0, getdate(), 'V', getdate())    


    IF NOT EXISTS (SELECT 1 FROM dbo.ad_servicio_autorizado WHERE ts_servicio = 'Loan.LoanTransaction.QueryReceiptPayment' AND ts_rol = @rol)
        INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
            VALUES ('Loan.LoanTransaction.QueryReceiptPayment', @rol, 7, 'R', 0, getdate(), 'V', getdate())        
    
    IF NOT EXISTS (SELECT 1 FROM dbo.ad_servicio_autorizado WHERE ts_servicio = 'Loan.LoanTransaction.QueryReceipPaymentInfo' AND ts_rol = @rol)
        INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
            VALUES ('Loan.LoanTransaction.QueryReceipPaymentInfo', @rol, 7, 'R', 0, getdate(), 'V', getdate())                    
    
    IF NOT EXISTS (SELECT 1 FROM ad_servicio_autorizado WHERE ts_servicio = 'Loan.LoanTransaction.QueryPromissoryNote' AND ts_rol = @rol)
       INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
           VALUES ('Loan.LoanTransaction.QueryPromissoryNote', @rol, 7, 'R', 0, getdate(), 'V', getdate()) 

    IF NOT EXISTS (SELECT 1 FROM dbo.ad_servicio_autorizado WHERE ts_servicio = 'Loan.LoanTransaction.QueryOffice' AND ts_rol = @rol)
        INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
            VALUES ('Loan.LoanTransaction.QueryOffice', @rol, 7, 'R', 0, getdate(), 'V', getdate())        
    
    IF NOT EXISTS (SELECT 1 FROM dbo.ad_servicio_autorizado WHERE ts_servicio = 'Loan.LoanTransaction.QueryProcessingDate' AND ts_rol = @rol)
        INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
            VALUES ('Loan.LoanTransaction.QueryProcessingDate', @rol, 7, 'R', 0, getdate(), 'V', getdate())    
   
   IF NOT EXISTS (SELECT 1 FROM dbo.ad_servicio_autorizado WHERE ts_servicio = 'Loan.LoanTransaction.LoanRepayment' AND ts_rol = @rol)
        INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
            VALUES ('Loan.LoanTransaction.LoanRepayment', @rol, 7, 'R', 0, getdate(), 'V', getdate())    
            
    -- Pago Solidario
    
    IF NOT EXISTS (SELECT 1 FROM dbo.ad_servicio_autorizado WHERE ts_servicio = 'Loan.SolidarityPayment.SearchSolidarityDetail' AND ts_rol = @rol)
        INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
            VALUES ('Loan.SolidarityPayment.SearchSolidarityDetail', @rol, 7, 'R', 0, getdate(), 'V', getdate())

    IF NOT EXISTS (SELECT 1 FROM dbo.ad_servicio_autorizado WHERE ts_servicio = 'Loan.SolidarityPayment.ReadSolidarity' AND ts_rol = @rol)
        INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
            VALUES ('Loan.SolidarityPayment.ReadSolidarity', @rol, 7, 'R', 0, getdate(), 'V', getdate())
    
    IF NOT EXISTS (SELECT 1 FROM dbo.ad_servicio_autorizado WHERE ts_servicio = 'Loan.SolidarityPayment.UpdateSolidarityDetail' AND ts_rol = @rol)
        INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
            VALUES ('Loan.SolidarityPayment.UpdateSolidarityDetail', @rol, 7, 'R', 0, getdate(), 'V', getdate())    

    -- Formas de desembolso
    IF NOT EXISTS (SELECT 1 FROM dbo.ad_servicio_autorizado WHERE ts_servicio = 'Loan.ReadDisbursementForm.ReadDisbursementFormSearch' AND ts_rol = @rol)
        INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
            VALUES ('Loan.ReadDisbursementForm.ReadDisbursementFormSearch', @rol, 7, 'R', 0, getdate(), 'V', getdate())

    /*------Para reporte de estado de cuenta*/
	/*SearchDetailAmortizacion*/
    if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Loan.StateAccount.SearchDetailAmortizacion' and ts_rol = @rol)
    insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
	     values ('Loan.StateAccount.SearchDetailAmortizacion', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate() )
		 
	/*SearchDetailMovements*/
    if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Loan.StateAccount.SearchDetailMovements' and ts_rol = @rol)
    insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	    values ('Loan.StateAccount.SearchDetailMovements', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate() )
		
    /*SearchMovementsTotal*/
    if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Loan.StateAccount.SearchMovementsTotal' and ts_rol = @rol)
    insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values ('Loan.StateAccount.SearchMovementsTotal', @rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
	
    /*SearchLoanInformation*/
    if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Loan.StateAccount.SearchLoanInformation' and ts_rol = @rol)
    insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	    values ('Loan.StateAccount.SearchLoanInformation', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate() )
		
    /*SearchStateSccountHeadboard*/
    if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Loan.StateAccount.SearchStateSccountHeadboard' and ts_rol = @rol)
    insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	    values ('Loan.StateAccount.SearchStateSccountHeadboard', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate() )

    /*ExecutionOptions*/
    if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Loan.StateAccount.ExecutionOptions'  and ts_rol = @rol)
    insert into ad_servicio_autorizado  (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values ('Loan.StateAccount.ExecutionOptions', @rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
	
    /*------Para actualizar notificacion*/
    /*CreateStateAccount*/		
    if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Loan.LoanMaintenance.CreateStateAccount' and ts_rol = @rol)
    insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values ('Loan.LoanMaintenance.CreateStateAccount', @rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
	  /*SearchAccountStatus*/		
    if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Loan.LoanMaintenance.SearchAccountStatus' and ts_rol = @rol)
    insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values ('Loan.LoanMaintenance.SearchAccountStatus', @rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
	
	  /*QueryDocumentsInd*/		
    if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Loan.QueryDocuments.QueryDocumentsInd' and ts_rol = @rol)
    insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values ('Loan.QueryDocuments.QueryDocumentsInd', @rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
	
	  /*QueryCycles*/		
    if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Loan.QueryDocuments.QueryCycles' and ts_rol = @rol)
    insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values ('Loan.QueryDocuments.QueryCycles', @rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
	
	  /*QueryDocumentsCredit*/		
    if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Loan.QueryDocuments.QueryDocumentsCredit' and ts_rol = @rol)
    insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values ('Loan.QueryDocuments.QueryDocumentsCredit', @rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
	
	--Conciliación
	DELETE cts_serv_catalog WHERE csc_service_id IN ('Loan.ConciliationManagement.InsertFileInTemp', 'Loan.ConciliationManagement.SearchAllConciliations', 'Loan.ConciliationManagement.DeleteTemporary', 'Loan.ConciliationManagement.UploadFile', 'Loan.ConciliationManagement.SearchPaymentByFilter')
	DELETE ad_servicio_autorizado WHERE ts_servicio IN ('Loan.ConciliationManagement.InsertFileInTemp', 'Loan.ConciliationManagement.SearchAllConciliations', 'Loan.ConciliationManagement.DeleteTemporary', 'Loan.ConciliationManagement.UploadFile', 'Loan.ConciliationManagement.SearchPaymentByFilter')
	
	INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
	VALUES ('Loan.ConciliationManagement.InsertFileInTemp', @rol, 7, 'R', 0, getdate(), 'V', getdate())
	
	INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
	VALUES ('Loan.ConciliationManagement.SearchPaymentByFilter', @rol, 7, 'R', 0, getdate(), 'V', getdate())
	
	INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
	VALUES ('Loan.ConciliationManagement.DeleteTemporary', @rol, 7, 'R', 0, getdate(), 'V', getdate())
	
	INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
	VALUES ('Loan.ConciliationManagement.UploadFile', @rol, 7, 'R', 0, getdate(), 'V', getdate())
	
	INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
	VALUES ('Loan.GeneralInfo.GetCatalog', @rol, 7, 'R', 0, getdate(), 'V', getdate())
	
	INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
	VALUES ('Loan.ConciliationManagement.ManualConciliation', @rol, 7, 'R', 0, getdate(), 'V', getdate())
	
	insert into ad_servicio_autorizado   (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
    values('Loan.LoansQueries.ReadLoanSummary', 7, 'R', 0, getdate(), @rol, 'V', getdate())
	
	INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
	VALUES ('Loan.ConciliationManagement.InsertFileInTemp', 'cobiscorp.ecobis.assets.cloud.service.IConciliationManagement', 'insertFileInTemp', 'insertFileInTemp', 0, NULL, NULL, NULL)
		
	INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
	VALUES ('Loan.ConciliationManagement.SearchPaymentByFilter', 'cobiscorp.ecobis.assets.cloud.service.IConciliationManagement', 'searchPaymentByFilter', 'searchPaymentByFilter', 0, NULL, NULL, NULL)
		
	INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
	VALUES ('Loan.ConciliationManagement.DeleteTemporary', 'cobiscorp.ecobis.assets.cloud.service.IConciliationManagement', 'deleteTemporary', 'deleteTemporary', 0, NULL, NULL, NULL)
		
	INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
	VALUES ('Loan.ConciliationManagement.UploadFile', 'cobiscorp.ecobis.assets.cloud.service.IConciliationManagement', 'uploadFile', 'uploadFile', 0, NULL, NULL, NULL)
		
	INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
	VALUES ('Loan.GeneralInfo.GetCatalog', 'cobiscorp.ecobis.assets.cloud.service.IGeneralInfo', 'getCatalog', 'getCatalog', 0, NULL, NULL, NULL)
	
	INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
	VALUES ('Loan.ConciliationManagement.ManualConciliation', 'cobiscorp.ecobis.assets.cloud.service.IConciliationManagement', 'manualConciliation', 'manualConciliation', 0, NULL, NULL, NULL)
    
    insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
	values ('Loan.LoansQueries.ReadLoanSummary', 'cobiscorp.ecobis.assets.cloud.service.ILoansQueries', 'readLoanSummary', '', 7203)
	 
	  
--SERVICIO SearchPrecancellationReference
delete cts_serv_catalog where csc_service_id = 'Loan.LoanMaintenance.SearchPrecancellationReference'
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('Loan.LoanMaintenance.SearchPrecancellationReference', 'cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance', 'searchPrecancellationReference', '', 0)
go

delete ad_servicio_autorizado where ts_servicio = 'Loan.LoanMaintenance.SearchPrecancellationReference'
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
    values('Loan.LoanMaintenance.SearchPrecancellationReference',3, 7,'R',0,getdate(),'V',getdate())
go

--SERVICIO PdfPreCancellationReference
delete cts_serv_catalog where csc_service_id = 'Loan.LoanMaintenance.PdfPreCancellationReference'
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('Loan.LoanMaintenance.PdfPreCancellationReference', 'cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance', 'pdfPreCancellationReference', '', 0)
go

delete ad_servicio_autorizado where ts_servicio = 'Loan.LoanMaintenance.PdfPreCancellationReference'
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
    values('Loan.LoanMaintenance.PdfPreCancellationReference',3, 7,'R',0,getdate(),'V',getdate())
go

--SERVICIO PdfPreCancellationReference
delete cts_serv_catalog where csc_service_id = 'Loan.LoanMaintenance.MailPreCancellationReference'
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('Loan.LoanMaintenance.MailPreCancellationReference', 'cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance', 'mailPreCancellationReference', '', 0)
go

delete ad_servicio_autorizado where ts_servicio = 'Loan.LoanMaintenance.MailPreCancellationReference'
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
    values('Loan.LoanMaintenance.MailPreCancellationReference',3, 7,'R',0,getdate(),'V',getdate())

GO

/*------Para reporte de estado de cuenta*/
/*SearchDetailAmortizacion*/
delete ad_servicio_autorizado where ts_servicio = 'Loan.StateAccount.SearchDetailAmortizacion'
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
values ('Loan.StateAccount.SearchDetailAmortizacion','cobiscorp.ecobis.assets.cloud.service.IStateAccount','searchDetailAmortizacion', '',36005, null, null, null)
go
/*SearchDetailMovements*/	
delete ad_servicio_autorizado where ts_servicio = 'Loan.StateAccount.SearchDetailMovements'
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
values ('Loan.StateAccount.SearchDetailMovements','cobiscorp.ecobis.assets.cloud.service.IStateAccount','searchDetailMovements', '',36005, null, null, null)
go
/*SearchMovementsTotal*/
if not exists (select 1 from cts_serv_catalog where csc_service_id = 'Loan.StateAccount.SearchMovementsTotal')
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
values ('Loan.StateAccount.SearchMovementsTotal','cobiscorp.ecobis.assets.cloud.service.IStateAccount','searchMovementsTotal', '',36005, null, null, null)
go
	
/*SearchLoanInformation*/
delete ad_servicio_autorizado where ts_servicio = 'Loan.StateAccount.SearchLoanInformation'
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
values ('Loan.StateAccount.SearchLoanInformation','cobiscorp.ecobis.assets.cloud.service.IStateAccount','searchLoanInformation', '',36005, null, null, null)
go
/*SearchStateSccountHeadboard*/
delete ad_servicio_autorizado where ts_servicio = 'Loan.StateAccount.SearchStateSccountHeadboard'
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
values ('Loan.StateAccount.SearchStateSccountHeadboard','cobiscorp.ecobis.assets.cloud.service.IStateAccount','searchStateAccountHeadboard', '',36005, null, null, null)
go

/*ExecutionOptions*/
delete ad_servicio_autorizado where ts_servicio = 'Loan.StateAccount.ExecutionOptions'
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
values ('Loan.StateAccount.ExecutionOptions','cobiscorp.ecobis.assets.cloud.service.IStateAccount','executionOptions', '',36005, null, null, null)
go

/*------Para actualizar notificacion*/
/*CreateStateAccount*/
delete ad_servicio_autorizado where ts_servicio = 'Loan.LoanMaintenance.CreateStateAccount'
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
values ('Loan.LoanMaintenance.CreateStateAccount','cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance','createStateAccount', '',36006, null, null, null)
go
/*Loan.LoanMaintenance.SearchAccountStatus*/
delete ad_servicio_autorizado where ts_servicio = 'Loan.LoanMaintenance.SearchAccountStatus'
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
values ('Loan.LoanMaintenance.SearchAccountStatus','cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance','searchAccountStatus', '',36007, null, null, null)
go
/*Loan.QueryDocuments.QueryDocumentsInd*/
delete ad_servicio_autorizado where ts_servicio = 'Loan.QueryDocuments.QueryDocumentsInd'
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
values ('Loan.QueryDocuments.QueryDocumentsInd','cobiscorp.ecobis.assets.cloud.service.IQueryDocuments','queryDocumentsInd', '',21366, null, null, null)
go
/*Loan.QueryDocuments.QueryCycles*/
delete ad_servicio_autorizado where ts_servicio = 'Loan.QueryDocuments.QueryCycles'
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
values ('Loan.QueryDocuments.QueryCycles','cobiscorp.ecobis.assets.cloud.service.IQueryDocuments','queryCycles', '',21366, null, null, null)
go
/*Loan.QueryDocuments.QueryDocumentsCredit*/
delete ad_servicio_autorizado where ts_servicio = 'Loan.QueryDocuments.QueryDocumentsCredit'
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
values ('Loan.QueryDocuments.QueryDocumentsCredit','cobiscorp.ecobis.assets.cloud.service.IQueryDocuments','queryDocumentsCredit', '',21366, null, null, null)
go


-- Verificar que exista en base a:
-- Nombre de servicio + rol


------------------------------------------
------------ELAVON -----------------------
------------------------------------------


delete cts_serv_catalog where csc_service_id in (
'BusinessToBusiness.OperationManagement.SearchOperations', 'BusinessToBusiness.PaymentManagement.ApplyPayment', 
'BusinessToBusiness.QueryCustomerGroup.SearchCustomerGroupByName', 'BusinessToBusiness.SecurityManagement.SendOtp',
'BusinessToBusiness.SecurityManagement.ValidationOtp', 'BusinessToBusiness.SecurityManagement.SaveAcceptance')

--Buscar Y Consultar Operaciones
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('BusinessToBusiness.OperationManagement.SearchOperations', 'cobiscorp.ecobis.businesstobusiness.service.IOperationManagement', 'searchOperations', 'Buscar operaciones por cliente y tipo de cliente', 0, NULL, NULL, NULL)

--Aplicar Pago
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('BusinessToBusiness.PaymentManagement.ApplyPayment', 'cobiscorp.ecobis.businesstobusiness.service.IPaymentManagement', 'applyPayment', 'Aplicar pago: PG,PI,GL, CI o CG', 0, NULL, NULL, NULL)

--Buscar Cliente/Grupo por nombre
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('BusinessToBusiness.QueryCustomerGroup.SearchCustomerGroupByName', 'cobiscorp.ecobis.businesstobusiness.service.IQueryCustomerGroup', 'searchCustomerGroupByName', 'Consultar cliente o grupo por nombre parcial/total y tipo', 0, NULL, NULL, NULL)

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
VALUES ('BusinessToBusiness.SecurityManagement.SendOtp', 'cobiscorp.ecobis.businesstobusiness.service.ISecurityManagement', 'sendOtp', '', 0)

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
VALUES ('BusinessToBusiness.SecurityManagement.ValidationOtp', 'cobiscorp.ecobis.businesstobusiness.service.ISecurityManagement', 'validationOtp', '', 0)

--Guardado de Aceptacion - R193221 - B2B Grupal Digital
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
VALUES ('BusinessToBusiness.SecurityManagement.SaveAcceptance', 'cobiscorp.ecobis.businesstobusiness.service.ISecurityManagement', 'saveAcceptance', '', 0)

delete ad_servicio_autorizado where ts_servicio IN ('BusinessToBusiness.OperationManagement.SearchOperations', 'BusinessToBusiness.PaymentManagement.ApplyPayment', 'BusinessToBusiness.QueryCustomerGroup.SearchCustomerGroupByName', 'BusinessToBusiness.SecurityManagement.SaveAcceptance')

select @rol = ro_rol 
from cobis..ad_rol
where ro_descripcion = 'ADMINISTRADOR'

if @@rowcount <> 0 and @rol is not null begin
   --Buscar y consultar operaciones con su detalle
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.OperationManagement.SearchOperations', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
   --Aplicar Pago
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.PaymentManagement.ApplyPayment', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
   --Buscar Cliente/Grupo por nombre
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.QueryCustomerGroup.SearchCustomerGroupByName', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
   --Envio del codigo OTP
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.SecurityManagement.SendOtp', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
   --Validacion del codigo OTP
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.SecurityManagement.ValidationOtp', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
   --Guardado de Aceptacion - R193221 - B2B Grupal Digital
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.SecurityManagement.SaveAcceptance', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
end

select @rol = ro_rol 
from cobis..ad_rol
where ro_descripcion = 'ASESOR'

if @@rowcount <> 0 and @rol is not null begin
   --Buscar y consultar operaciones con su detalle
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.OperationManagement.SearchOperations', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
   --Aplicar Pago
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.PaymentManagement.ApplyPayment', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
   --Buscar Cliente/Grupo por nombre
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.QueryCustomerGroup.SearchCustomerGroupByName', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
   --Envio del codigo OTP
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.SecurityManagement.SendOtp', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
   --Validacion del codigo OTP
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.SecurityManagement.ValidationOtp', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
   --Guardado de Aceptacion - R193221 - B2B Grupal Digital
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.SecurityManagement.SaveAcceptance', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
end 

select @rol = ro_rol 
from cobis..ad_rol
where ro_descripcion = 'ASESOR MOVIL'

if @@rowcount <> 0 and @rol is not null begin

   --Buscar y consultar operaciones con su detalle
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.OperationManagement.SearchOperations', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
   --Aplicar Pago
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.PaymentManagement.ApplyPayment', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
   --Buscar Cliente/Grupo por nombre
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.QueryCustomerGroup.SearchCustomerGroupByName', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
	--Envio del codigo OTP
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.SecurityManagement.SendOtp', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
   --Validacion del codigo OTP
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.SecurityManagement.ValidationOtp', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate())   
   --Guardado de Aceptacion - - R193221 - B2B Grupal Digital
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.SecurityManagement.SaveAcceptance', @rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
end


------------------------- OXXO -----------------------------
use cobis
go

declare @w_rol integer, @w_producto int
select @w_rol = ro_rol from ad_rol where ro_descripcion='MENU POR PROCESOS' -- validar con el rol que va a disparar la ejecución desde el REST
SELECT @w_producto = pd_producto FROM cobis..cl_producto 
WHERE pd_descripcion = 'CARTERA'

--CONSULTA 
delete from cobis..cts_serv_catalog where csc_service_id='BankingCorrespondent.BankingCorrespondentPayment.ReadPayments'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('BankingCorrespondent.BankingCorrespondentPayment.ReadPayments','cobiscorp.ecobis.bankingcorrespondent.service.IBankingCorrespondentPayment','readPayments','obtiene el detalle de pago por corresponsal',0)

delete from ad_servicio_autorizado where ts_servicio = 'BankingCorrespondent.BankingCorrespondentPayment.ReadPayments' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('BankingCorrespondent.BankingCorrespondentPayment.ReadPayments', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

--PAGOS
delete from cobis..cts_serv_catalog where csc_service_id='BankingCorrespondent.BankingCorrespondentPayment.Pay'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('BankingCorrespondent.BankingCorrespondentPayment.Pay','cobiscorp.ecobis.bankingcorrespondent.service.IBankingCorrespondentPayment','pay','registra el pago del corresponsal en la tabla de tanqueo',0)

delete from ad_servicio_autorizado where ts_servicio = 'BankingCorrespondent.BankingCorrespondentPayment.Pay' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('BankingCorrespondent.BankingCorrespondentPayment.Pay', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

--REVERSA
delete from cobis..cts_serv_catalog where csc_service_id='BankingCorrespondent.BankingCorrespondentPayment.Reverse'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('BankingCorrespondent.BankingCorrespondentPayment.Reverse','cobiscorp.ecobis.bankingcorrespondent.service.IBankingCorrespondentPayment','reverse','registra la reversa del pago del corresponsal en la tabla de tanqueo',0)

delete from ad_servicio_autorizado where ts_servicio = 'BankingCorrespondent.BankingCorrespondentPayment.Reverse' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values(
'BankingCorrespondent.BankingCorrespondentPayment.Reverse', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

--PIE DE PAGINA
delete from cobis..cts_serv_catalog where csc_service_id='Loan.LoansQueries.ReadPageFooter'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.LoansQueries.ReadPageFooter','cobiscorp.ecobis.assets.cloud.service.ILoansQueries','readPageFooter','Lee pie de pagina por corresponsal',0)

delete from ad_servicio_autorizado where ts_servicio = 'Loan.LoansQueries.ReadPageFooter' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values(
'Loan.LoansQueries.ReadPageFooter', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())



--CANCELACION DE LCR ANTICIPADA
delete from cobis..ad_servicio_autorizado where ts_servicio = 'IndividualLoan.CancelManagement.CancelLCR' and ts_rol in (10,29)

--Funcionario de oficina
insert into cobis..ad_servicio_autorizado
values('IndividualLoan.CancelManagement.CancelLCR' ,10,7,'R',0,getDate(),'V',getDate())
--Mesa de operaciones
insert into cobis..ad_servicio_autorizado
values('IndividualLoan.CancelManagement.CancelLCR' ,29,7,'R',0,getDate(),'V',getDate())



select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'
----servivio¨Pantalla Alta Masiva de Cliente

if @w_rol is null    select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
delete from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.QueryCollective'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation )  
VALUES ('Collective.CollectiveEntity.QueryCollective', 'cobiscorp.ecobis.collective.service.ICollectiveEntity', 'queryCollective','queryCollective', null, 'N')
   
delete cobis..ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.QueryCollective'
insert into cobis..ad_servicio_autorizado values('Collective.CollectiveEntity.QueryCollective', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())

----servivio¨Pantalla ala masiva de Asesores
delete from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.ProcessAsesorEntity'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) values (
'Collective.CollectiveEntity.ProcessAsesorEntity','cobiscorp.ecobis.collective.service.ICollectiveEntity', 'processAsesorEntity', 
'processAsesorEntity', NULL, 'N')

delete cobis..ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.ProcessAsesorEntity'
insert into cobis..ad_servicio_autorizado values('Collective.CollectiveEntity.ProcessAsesorEntity', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())

go


-------------------------------------------
--- SERVICIO GENERIC PAYMENT SLIP     -----
-------------------------------------------
declare 
@w_producto              int

declare @w_roles table (
   rol       int
)

select @w_producto = pd_producto
from cl_producto
where pd_descripcion = 'CARTERA'

insert into @w_roles
select ro_rol
from ad_rol
where ro_descripcion in (
'FUNCIONARIO OFICINA',
'ASESOR'
)

delete cts_serv_catalog where csc_service_id = 'Loan.LoanMaintenance.PdfGenericPaymentSlip'

insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) values ('Loan.LoanMaintenance.PdfGenericPaymentSlip', 'cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance', 'pdfGenericPaymentSlip', '', 0)

delete ad_servicio_autorizado  where ts_servicio = 'Loan.LoanMaintenance.PdfGenericPaymentSlip'

insert into ad_servicio_autorizado 
select 'Loan.LoanMaintenance.PdfGenericPaymentSlip',rol, @w_producto, 'R', 0, getdate(), 'V', getdate()
from @w_roles
go

