use cobis
go

declare @w_rol integer

select @w_rol = ro_rol from ad_rol
where ro_descripcion='MENU POR PROCESOS'

--creacion de servicio Loan.ProductListCredit.CondonableItemList
delete from cobis..cts_serv_catalog where csc_service_id='Loan.ProductListCredit.CondonableItemList'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.ProductListCredit.CondonableItemList','cobiscorp.ecobis.assets.cloud.service.IProductListCredit','condonableItemList','condonableItemList',7276)

--autorizacion al Loan.ProductListCredit.CondonableItemList
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.ProductListCredit.CondonableItemList'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.ProductListCredit.CondonableItemList',7,'R',0,getdate(),@w_rol ,'V',getdate())

--creacion de servicio Loan.ProductListCredit.CalculateValueToCondone
delete from cobis..cts_serv_catalog where csc_service_id='Loan.ProductListCredit.CalculateValueToCondone'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.ProductListCredit.CalculateValueToCondone','cobiscorp.ecobis.assets.cloud.service.IProductListCredit','calculateValueToCondone','calculateValueToCondone',7276)
                                                                                
--autorizacion al Loan.ProductListCredit.CalculateValueToCondone
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.ProductListCredit.CalculateValueToCondone'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.ProductListCredit.CalculateValueToCondone',7,'R',0,getdate(),@w_rol ,'V',getdate())


--creacion de servicio Loan.ProductListCredit.PaymentsEntry
delete from cobis..cts_serv_catalog where csc_service_id='Loan.ProductListCredit.PaymentsEntry'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.ProductListCredit.PaymentsEntry','cobiscorp.ecobis.assets.cloud.service.IProductListCredit','paymentsEntry','paymentsEntry',7058)
                                                                                
--autorizacion al Loan.ProductListCredit.PaymentsEntry
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.ProductListCredit.PaymentsEntry'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.ProductListCredit.PaymentsEntry',7,'R',0,getdate(),@w_rol ,'V',getdate())


--creacion de servicio Loan.ProductListCredit.ProductListCredit
delete from cobis..cts_serv_catalog where csc_service_id='Loan.ProductListCredit.ProductListCredit'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.ProductListCredit.ProductListCredit','cobiscorp.ecobis.assets.cloud.service.IProductListCredit','productListCredit','productListCredit',7076)

--autorizacion al Loan.ProductListCredit.ProductListCredit
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.ProductListCredit.ProductListCredit'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.ProductListCredit.ProductListCredit',7,'R',0,getdate(),@w_rol ,'V',getdate())


--creacion de servicio Loan.ProductListCredit.CreditDetail
delete from cobis..cts_serv_catalog where csc_service_id='Loan.ProductListCredit.CreditDetail'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.ProductListCredit.CreditDetail','cobiscorp.ecobis.assets.cloud.service.IProductListCredit','creditDetail','creditDetail',7059)

--autorizacion al Loan.ProductListCredit.ProductListCredit
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.ProductListCredit.CreditDetail'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.ProductListCredit.CreditDetail',7,'R',0,getdate(),@w_rol ,'V',getdate())






