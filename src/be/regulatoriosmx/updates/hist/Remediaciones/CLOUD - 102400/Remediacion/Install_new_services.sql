    use cobis
    GO
    
    declare @w_rol integer
    
    select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'
    
	delete ad_servicio_autorizado where ts_servicio = 'Loan.ProductListCredit.QueryPendingPayment'
	delete cts_serv_catalog WHERE csc_service_id = 'Loan.ProductListCredit.QueryPendingPayment'

	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
	VALUES ('Loan.ProductListCredit.QueryPendingPayment', 'cobiscorp.ecobis.assets.cloud.service.IProductListCredit', 'queryPendingPayment', '', 7058)

	insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values('Loan.ProductListCredit.QueryPendingPayment', @w_rol, 7, 'R', 0, getdate(), 'V', getdate()) 

	go
