

use cobis
go

declare @w_rol integer

select @w_rol = ro_rol from ad_rol
where ro_descripcion='MENU POR PROCESOS'

--creacion de servicio Loan.AmortizationDetail.AmortizationDetail
delete from cobis..cts_serv_catalog where csc_service_id='Loan.AmortizationDetail.AmortizationDetail'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.AmortizationDetail.AmortizationDetail','cobiscorp.ecobis.assets.cloud.service.IAmortizationDetail','amortizationDetail','amortizationDetail',7149)

--autorizacion al Loan.AmortizationDetail.AmortizationDetail
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.AmortizationDetail.AmortizationDetail'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.AmortizationDetail.AmortizationDetail',7,'R',0,getdate(),@w_rol ,'V',getdate())


--creacion de servicio Loan.ProductListCredit.QueryLoanPayment
delete from cobis..cts_serv_catalog where csc_service_id='Loan.ProductListCredit.QueryLoanPayment'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.ProductListCredit.QueryLoanPayment','cobiscorp.ecobis.assets.cloud.service.IProductListCredit','queryLoanPayment','queryLoanPayment',7144)

--autorizacion al Loan.ProductListCredit.QueryLoanPayment
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.ProductListCredit.QueryLoanPayment'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.ProductListCredit.QueryLoanPayment',7,'R',0,getdate(),@w_rol ,'V',getdate())


--creacion de servicio Loan.ProductListCredit.BankAccountList
delete from cobis..cts_serv_catalog where csc_service_id='Loan.ProductListCredit.BankAccountList'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.ProductListCredit.BankAccountList','cobiscorp.ecobis.assets.cloud.service.IProductListCredit','bankAccountList','bankAccountList',7003)

--autorizacion al Loan.ProductListCredit.BankAccountList
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.ProductListCredit.BankAccountList'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.ProductListCredit.BankAccountList',7,'R',0,getdate(),@w_rol ,'V',getdate())


--creacion de servicio Loan.ProductListCredit.ProductCredit
delete from cobis..cts_serv_catalog where csc_service_id='Loan.ProductListCredit.ProductCredit'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.ProductListCredit.ProductCredit','cobiscorp.ecobis.assets.cloud.service.IProductListCredit','productCredit','productCredit',7076)

--autorizacion al Loan.ProductListCredit.ProductCredit
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.ProductListCredit.ProductCredit'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.ProductListCredit.ProductCredit',7,'R',0,getdate(),@w_rol ,'V',getdate())


--creacion de servicio Loan.ProductListCredit.QueryCatalogBank
delete from cobis..cts_serv_catalog where csc_service_id='Loan.ProductListCredit.QueryCatalogBank'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.ProductListCredit.QueryCatalogBank','cobiscorp.ecobis.assets.cloud.service.IProductListCredit','queryCatalogBank','queryCatalogBank',1209)

--autorizacion al Loan.ProductListCredit.QueryCatalogBank
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.ProductListCredit.QueryCatalogBank'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.ProductListCredit.QueryCatalogBank',7,'R',0,getdate(),@w_rol ,'V',getdate())


--creacion de servicio Loan.CurrencyListCredit.CurrencyListCredit
delete from cobis..cts_serv_catalog where csc_service_id='Loan.CurrencyListCredit.CurrencyListCredit'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.CurrencyListCredit.CurrencyListCredit','cobiscorp.ecobis.assets.cloud.service.ICurrencyListCredit','currencyListCredit','currencyListCredit',1556)

--autorizacion al Loan.CurrencyListCredit.CurrencyListCredit
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.CurrencyListCredit.CurrencyListCredit'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.CurrencyListCredit.CurrencyListCredit',7,'R',0,getdate(),@w_rol ,'V',getdate())


--creacion de servicio Loan.ReadDisbursementForm.ReadGlobalVariablesSearch
delete from cobis..cts_serv_catalog where csc_service_id='Loan.ReadDisbursementForm.ReadGlobalVariablesSearch'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.ReadDisbursementForm.ReadGlobalVariablesSearch','cobiscorp.ecobis.assets.cloud.service.IReadDisbursementForm','readGlobalVariablesSearch','readGlobalVariablesSearch',7050)

--autorizacion al Loan.ReadDisbursementForm.ReadGlobalVariablesSearch
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.ReadDisbursementForm.ReadGlobalVariablesSearch'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.ReadDisbursementForm.ReadGlobalVariablesSearch',7,'R',0,getdate(),@w_rol ,'V',getdate())

