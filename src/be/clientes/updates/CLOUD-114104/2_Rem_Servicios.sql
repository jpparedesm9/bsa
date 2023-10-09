USE cobis
go
declare @w_rol int, @w_producto INT,@w_moneda TINYINT

	select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
	select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
	select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'
	

    if not exists (select 1 from cts_serv_catalog where csc_service_id = 'LoanGroup.ScannedDocuments.ValidateUploadedFI')	
    insert into cts_serv_catalog
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
    values('LoanGroup.ScannedDocuments.ValidateUploadedFI',  'cobiscorp.ecobis.loangroup.service.IScannedDocuments', 'validateUploadedFI', '', 0, null, null, 'N')

    if not exists (select 1 from ad_servicio_autorizado where 
    ts_servicio = 'LoanGroup.ScannedDocuments.ValidateUploadedFI' and ts_rol = @w_rol and ts_producto = @w_producto and ts_moneda = @w_moneda)    
    insert into ad_servicio_autorizado
    (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
    values('LoanGroup.ScannedDocuments.ValidateUploadedFI', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())
go