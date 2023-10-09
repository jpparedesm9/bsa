use cobis
go

declare @w_rol integer

select @w_rol = ro_rol from ad_rol
where ro_descripcion='MENU POR PROCESOS'

DELETE FROM cobis..cts_serv_catalog WHERE csc_service_id = 'Loan.OperationDataQuery.SearchPayment'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.OperationDataQuery.SearchPayment','cobiscorp.ecobis.assets.cloud.service.IOperationDataQuery','searchPayment','searchPayment',	7020)

--Autoriza el servicio realizado
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.OperationDataQuery.SearchPayment'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.OperationDataQuery.SearchPayment',1,'R',0,getdate(),@w_rol ,'V',getdate())

DELETE FROM cobis..cts_serv_catalog WHERE csc_service_id = 'Loan.OperationDataQuery.SearchPaymentDetail'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.OperationDataQuery.SearchPaymentDetail','cobiscorp.ecobis.assets.cloud.service.IOperationDataQuery','searchPaymentDetail','searchPaymentDetail',	7020)

--Autoriza el servicio realizado
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.OperationDataQuery.SearchPaymentDetail'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.OperationDataQuery.SearchPaymentDetail',1,'R',0,getdate(),@w_rol ,'V',getdate())

DELETE FROM cobis..cts_serv_catalog WHERE csc_service_id = 'Loan.OperationDataQuery.SearchRefinanceLoan'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.OperationDataQuery.SearchRefinanceLoan','cobiscorp.ecobis.assets.cloud.service.IOperationDataQuery','searchRefinanceLoan','searchRefinanceLoan',	7020)

--Autoriza el servicio realizado
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.OperationDataQuery.SearchRefinanceLoan'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.OperationDataQuery.SearchRefinanceLoan',1,'R',0,getdate(),@w_rol ,'V',getdate())


DELETE FROM cobis..cts_serv_catalog WHERE csc_service_id = 'Loan.OperationDataQuery.QueryEntry'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.OperationDataQuery.QueryEntry','cobiscorp.ecobis.assets.cloud.service.IOperationDataQuery','QueryEntry','QueryEntry',	7020)

--Autoriza el servicio realizado
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.OperationDataQuery.QueryEntry'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.OperationDataQuery.QueryEntry',1,'R',0,getdate(),@w_rol ,'V',getdate())


DELETE FROM cobis..cts_serv_catalog WHERE csc_service_id = 'Loan.OperationDataQuery.QueryRate'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.OperationDataQuery.QueryRate','cobiscorp.ecobis.assets.cloud.service.IOperationDataQuery','QueryRate','QueryRate',	7020)

--Autoriza el servicio realizado
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.OperationDataQuery.QueryRate'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.OperationDataQuery.QueryRate',1,'R',0,getdate(),@w_rol ,'V',getdate())


DELETE FROM cobis..cts_serv_catalog WHERE csc_service_id = 'Loan.OperationDataQuery.QueryWarranty'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.OperationDataQuery.QueryWarranty','cobiscorp.ecobis.assets.cloud.service.IOperationDataQuery','QueryWarranty','QueryWarranty',	7020)

--Autoriza el servicio realizado
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.OperationDataQuery.QueryWarranty'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.OperationDataQuery.QueryWarranty',1,'R',0,getdate(),@w_rol ,'V',getdate())


DELETE FROM cobis..cts_serv_catalog WHERE csc_service_id = 'Loan.OperationDataQuery.QueryDebtor'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.OperationDataQuery.QueryDebtor','cobiscorp.ecobis.assets.cloud.service.IOperationDataQuery','QueryDebtor','QueryDebtor',	7020)

--Autoriza el servicio realizado
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.OperationDataQuery.QueryDebtor'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.OperationDataQuery.QueryDebtor',1,'R',0,getdate(),@w_rol ,'V',getdate())

--Autoriza el servicio realizado GeneralLoanData
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.LoansQueries.GeneralLoanData'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.LoansQueries.GeneralLoanData',1,'R',0,getdate(),@w_rol ,'V',getdate())

DELETE FROM cobis..cts_serv_catalog WHERE csc_service_id = 'Loan.LoansQueries.GeneralLoanData'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.LoansQueries.GeneralLoanData','cobiscorp.ecobis.assets.cloud.service.ILoansQueries','generalLoanData','generalLoanData',	714500)

--Autoriza el servicio realizado QueryPaymentConditions
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.OperationDataQuery.QueryPaymentConditions'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.OperationDataQuery.QueryPaymentConditions',1,'R',0,getdate(),@w_rol ,'V',getdate())

DELETE FROM cobis..cts_serv_catalog WHERE csc_service_id = 'Loan.OperationDataQuery.QueryPaymentConditions'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.OperationDataQuery.QueryPaymentConditions','cobiscorp.ecobis.assets.cloud.service.IOperationDataQuery','queryPaymentConditions','queryPaymentConditions',	7020)

--Autoriza el servicio realizado QueryCurrentState
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.OperationDataQuery.QueryCurrentState'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.OperationDataQuery.QueryCurrentState',1,'R',0,getdate(),@w_rol ,'V',getdate())

DELETE FROM cobis..cts_serv_catalog WHERE csc_service_id = 'Loan.OperationDataQuery.QueryCurrentState'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.OperationDataQuery.QueryCurrentState','cobiscorp.ecobis.assets.cloud.service.IOperationDataQuery','queryCurrentState','queryCurrentState',	7015)

go
