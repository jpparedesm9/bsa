/**********************************************************************************************************************/
--No Bug                     : NA
--T�tulo de la Historia      : CGS-S119681 Impresi�n de Documentos - Documentos (3) - II Parte - Flujo Grupal
--Fecha                      : 20/07/2017
--Descripci�n del Problema   : nuevos reportes Individuales
--Descripci�n de la Soluci�n : Registrar el servicio para la consulta de info de prestamos individuales
--Autor                      : Walther Toledo
--Instalador                 : cl_services_authorization.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/


-- AUTORIZACION DE LOS SERVICIOS SG
use cobis
go
declare @w_rol integer, @w_producto int, @w_fecha datetime

select @w_rol = ro_rol from ad_rol where ro_descripcion='MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CREDITO'
select @w_fecha = getdate()

-- REMEDIACION DE AUTORIZACION REPORTES INDIVIDUALES
delete from ad_servicio_autorizado where ts_servicio in ('LoanProcess.LoanReportQuery.SearchIndivCreditCover',
'LoanProcess.LoanReportQuery.SearchIndivCreditPaymentList','LoanProcess.LoanReportQuery.GetCustomerData',
'LoanProcess.LoanReportQuery.SearchLoanRecurringCharge')
insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanProcess.LoanReportQuery.SearchIndivCreditCover', @w_rol, @w_producto, 'R', 0, @w_fecha, 'V', @w_fecha)
insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanProcess.LoanReportQuery.SearchIndivCreditPaymentList', @w_rol, @w_producto, 'R', 0, @w_fecha, 'V', @w_fecha)
insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanProcess.LoanReportQuery.GetCustomerData', @w_rol, @w_producto, 'R', 0, @w_fecha, 'V', @w_fecha)
insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanProcess.LoanReportQuery.SearchLoanRecurringCharge', @w_rol, @w_producto, 'R', 0, @w_fecha, 'V', @w_fecha)

delete from cobis..cts_serv_catalog where csc_service_id in ('LoanProcess.LoanReportQuery.SearchIndivCreditCover',
'LoanProcess.LoanReportQuery.SearchIndivCreditPaymentList','LoanProcess.LoanReportQuery.GetCustomerData',
'LoanProcess.LoanReportQuery.SearchLoanRecurringCharge')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanProcess.LoanReportQuery.SearchIndivCreditCover',  'cobiscorp.ecobis.loanprocess.service.ILoanReportQuery', 'searchIndivCreditCover','searchIndivCreditCover', 21275, null, null, 'N')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanProcess.LoanReportQuery.SearchIndivCreditPaymentList',  'cobiscorp.ecobis.loanprocess.service.ILoanReportQuery', 'searchIndivCreditPaymentList','searchIndivCreditPaymentList', 21275, null, null, 'N')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanProcess.LoanReportQuery.GetCustomerData',  'cobiscorp.ecobis.loanprocess.service.ILoanReportQuery', 'getCustomerData','getCustomerData', 21275, null, null, 'N')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanProcess.LoanReportQuery.SearchLoanRecurringCharge',  'cobiscorp.ecobis.loanprocess.service.ILoanReportQuery', 'searchLoanRecurringCharge','searchLoanRecurringCharge', 21275, null, null, 'N')

-- REMEDIACION DE AUTORIZACION REPORTES GRUPALES
delete from ad_servicio_autorizado where ts_servicio in (
'LoanGroup.ReportMaintenance.SearchRecurringCharge', 'LoanGroup.ReportMaintenance.SearchGroupCreditCover',
'LoanGroup.ReportMaintenance.SearchPromissoryNoteInf','LoanGroup.ReportMaintenance.SearchGroupCreditPaymentList')
insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.ReportMaintenance.SearchRecurringCharge', @w_rol, @w_producto, 'R', 0, @w_fecha, 'V', @w_fecha)
insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.ReportMaintenance.SearchGroupCreditCover', @w_rol, @w_producto, 'R', 0, @w_fecha, 'V', @w_fecha)
insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.ReportMaintenance.SearchPromissoryNoteInf', @w_rol, @w_producto, 'R', 0, @w_fecha, 'V', @w_fecha)
insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.ReportMaintenance.SearchGroupCreditPaymentList', @w_rol, @w_producto, 'R', 0, @w_fecha, 'V', @w_fecha)

delete from cobis..cts_serv_catalog where csc_service_id in (
'LoanGroup.ReportMaintenance.SearchRecurringCharge', 'LoanGroup.ReportMaintenance.SearchGroupCreditCover',
'LoanGroup.ReportMaintenance.SearchPromissoryNoteInf','LoanGroup.ReportMaintenance.SearchGroupCreditPaymentList')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanGroup.ReportMaintenance.SearchRecurringCharge',  'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'searchRecurringCharge','searchRecurringCharge', 21274, null, null, 'N')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanGroup.ReportMaintenance.SearchGroupCreditCover',  'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'searchGroupCreditCover','searchGroupCreditCover', 21274, null, null, 'N')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanGroup.ReportMaintenance.SearchPromissoryNoteInf',  'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'searchPromissoryNoteInf','searchPromissoryNoteInf', 21274, null, null, 'N')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanGroup.ReportMaintenance.SearchGroupCreditPaymentList',  'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'searchGroupCreditPaymentList','searchGroupCreditPaymentList', 21274, null, null, 'N')

go