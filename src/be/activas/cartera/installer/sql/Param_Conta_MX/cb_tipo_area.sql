Use cob_conta
go

declare @w_empresa	int,
		@w_modulo	int,
		@w_oficina	int,
		@w_area_def smallint

if exists (select 1 from cob_conta..sysobjects where name = 'cb_tipo_area')
begin
	select @w_modulo = 7
	select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'
	select @w_oficina = pa_smallint from cobis..cl_parametro where pa_nemonico = 'OMAT' and pa_producto = 'AHO'
	select @w_oficina = 1101
	
	/* SELECCION DEL AREA DE CARTERA */
    select @w_area_def = pa_smallint
    from cobis..cl_parametro with (nolock)
    where pa_producto = 'CCA'
    and pa_nemonico   = 'ARC'

	delete from cob_conta..cb_tipo_area where ta_empresa = @w_empresa and ta_producto = @w_modulo

   INSERT INTO cob_conta..cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
	VALUES (@w_empresa, @w_modulo, 'CTB_OF', 'S', @w_area_def, 'CARTERA', @w_oficina)
   
	/*INSERT INTO cob_conta..cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
	VALUES (@w_empresa, @w_modulo, 'CTB_OF', 'S', 31, 'AREA DE CONTABILIZACION DE AHORROS', @w_oficina)
	
	INSERT INTO cob_conta..cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
	VALUES (@w_empresa, @w_modulo, 'CTB_IMP', 'S', 30, 'IMPUESTOS AHORROS', @w_oficina)*/
end
else
	print 'NO EXISTE TABLA cb_tipo_area'
GO
