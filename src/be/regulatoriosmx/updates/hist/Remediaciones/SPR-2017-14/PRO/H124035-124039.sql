-- AUTORIZACION DE LOS SERVICIOS SG
use cobis
go

delete from ad_servicio_autorizado where ts_servicio in ('LoanProcess.LoanReportQuery.GetLoanData',
'LoanProcess.LoanReportQuery.GetCustomerData',
'LoanProcess.LoanReportQuery.SearchIndivCreditCover',
'LoanProcess.LoanReportQuery.SearchIndivCreditPaymentList',
'LoanProcess.LoanReportQuery.SearchLoanRecurringCharge')

delete from cobis..cts_serv_catalog where csc_service_id in ('LoanProcess.LoanReportQuery.GetLoanData',
'LoanProcess.LoanReportQuery.GetCustomerData',
'LoanProcess.LoanReportQuery.SearchIndivCreditCover',
'LoanProcess.LoanReportQuery.SearchIndivCreditPaymentList',
'LoanProcess.LoanReportQuery.SearchLoanRecurringCharge')

delete from cobis..cts_serv_catalog where csc_service_id in (
'LoanGroup.ReportMaintenance.SearchRecurringCharge', 'LoanGroup.ReportMaintenance.SearchGroupCreditCover',
'LoanGroup.ReportMaintenance.SearchPromissoryNoteInf','LoanGroup.ReportMaintenance.SearchGroupCreditPaymentList')

delete from ad_servicio_autorizado where ts_servicio in (
'LoanGroup.ReportMaintenance.SearchRecurringCharge', 'LoanGroup.ReportMaintenance.SearchGroupCreditCover',
'LoanGroup.ReportMaintenance.SearchPromissoryNoteInf','LoanGroup.ReportMaintenance.SearchGroupCreditPaymentList')

go

declare @w_rol integer, @w_producto int, @w_fecha datetime

select @w_rol = ro_rol from ad_rol where ro_descripcion='MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CREDITO'
select @w_fecha = getdate()
-----------------------------------
--SERVICIO GetLoanData
----------------------------------- 
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanProcess.LoanReportQuery.GetLoanData',  'cobiscorp.ecobis.loanprocess.service.ILoanReportQuery', 'getLoanData','getLoanData', 21275, null, null, 'N')

insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanProcess.LoanReportQuery.GetLoanData', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


-----------------------------------
--SERVICIO GetCustomerData
----------------------------------- 
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanProcess.LoanReportQuery.GetCustomerData',  'cobiscorp.ecobis.loanprocess.service.ILoanReportQuery', 'getCustomerData','getCustomerData', 21275, null, null, 'N')

insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanProcess.LoanReportQuery.GetCustomerData', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-----------------------------------
--SERVICIO SearchIndivCreditCover
----------------------------------- 
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanProcess.LoanReportQuery.SearchIndivCreditCover',  'cobiscorp.ecobis.loanprocess.service.ILoanReportQuery', 'searchIndivCreditCover','searchIndivCreditCover', 21275, null, null, 'N')

insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanProcess.LoanReportQuery.SearchIndivCreditCover', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-----------------------------------
--SERVICIO SearchIndivCreditPaymentList
----------------------------------- 
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanProcess.LoanReportQuery.SearchIndivCreditPaymentList',  'cobiscorp.ecobis.loanprocess.service.ILoanReportQuery', 'searchIndivCreditPaymentList','searchIndivCreditPaymentList', 21275, null, null, 'N')

insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanProcess.LoanReportQuery.SearchIndivCreditPaymentList', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-----------------------------------
--SERVICIO SearchLoanRecurringCharge
----------------------------------- 
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanProcess.LoanReportQuery.SearchLoanRecurringCharge',  'cobiscorp.ecobis.loanprocess.service.ILoanReportQuery', 'searchLoanRecurringCharge','searchLoanRecurringCharge', 21275, null, null, 'N')

insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanProcess.LoanReportQuery.SearchLoanRecurringCharge', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


-- REMEDIACION DE AUTORIZACION REPORTES GRUPALES

insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.ReportMaintenance.SearchRecurringCharge', @w_rol, @w_producto, 'R', 0, @w_fecha, 'V', @w_fecha)
insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.ReportMaintenance.SearchGroupCreditCover', @w_rol, @w_producto, 'R', 0, @w_fecha, 'V', @w_fecha)
insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.ReportMaintenance.SearchPromissoryNoteInf', @w_rol, @w_producto, 'R', 0, @w_fecha, 'V', @w_fecha)
insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.ReportMaintenance.SearchGroupCreditPaymentList', @w_rol, @w_producto, 'R', 0, @w_fecha, 'V', @w_fecha)


insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanGroup.ReportMaintenance.SearchRecurringCharge',  'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'searchRecurringCharge','searchRecurringCharge', 21274, null, null, 'N')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanGroup.ReportMaintenance.SearchGroupCreditCover',  'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'searchGroupCreditCover','searchGroupCreditCover', 21274, null, null, 'N')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanGroup.ReportMaintenance.SearchPromissoryNoteInf',  'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'searchPromissoryNoteInf','searchPromissoryNoteInf', 21274, null, null, 'N')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanGroup.ReportMaintenance.SearchGroupCreditPaymentList',  'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'searchGroupCreditPaymentList','searchGroupCreditPaymentList', 21274, null, null, 'N')

go
