use cobis
go

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
go