use cobis
GO
    
declare @w_rol tinyint,
		@w_moneda tinyint,
		@w_service varchar(100)
		      
SELECT @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ASESOR MOVIL'
	
IF EXISTS(select 1 from cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM')
BEGIN
	print 'Se ha encontrado codigo de moneda nacional en tabla de parametros'
	SELECT @w_moneda = isnull(pa_tinyint,0) from cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'
END
ELSE
BEGIN
	print 'No existe codigo de moneda nacional en tabla de parametros, se establece valor por defecto'
	SELECT @w_moneda = 0
END

-- /*************** Authorize Menu by Channel *******************/
SELECT @w_service = 'CEW.Container.Extended.Menu.GetMenuByChannel'
	
-- Register Service
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = @w_service)
	UPDATE cts_serv_catalog SET 
		csc_class_name = 'cobiscorp.ecobis.cew.container.extended.service.IMenu',
		csc_method_name = 'getMenuByChannel',
		csc_description = '',
		csc_trn = 0,
		csc_procedure_validation = NULL
	WHERE csc_service_id = @w_service
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation)
	VALUES (@w_service, 'cobiscorp.ecobis.cew.container.extended.service.IMenu', 'getMenuByChannel', '', 0, NULL)

-- Authorize Service
IF NOT EXISTS(SELECT * FROM ad_servicio_autorizado WHERE ts_servicio = @w_service AND ts_rol=@w_rol)
BEGIN
	INSERT INTO ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
	VALUES(@w_service, @w_rol, 1, 'R', @w_moneda, getdate(), 'V', getdate())
	PRINT 'Autorizando el servicio'
	PRINT @w_service
	PRINT 'para el rol:' 
	PRINT @w_rol 
END
ELSE
BEGIN
	UPDATE ad_servicio_autorizado SET 
		ts_producto = 1,
		ts_tipo = 'R',
		ts_moneda = @w_moneda,
		ts_fecha_aut = getdate(),
		ts_estado = 'V',
		ts_fecha_ult_mod = getdate()
	WHERE ts_servicio = @w_service AND ts_rol = @w_rol
		PRINT 'Actualizando el servicio'
		PRINT @w_service
		PRINT 'para el rol:'
		PRINT @w_rol
END

GO
