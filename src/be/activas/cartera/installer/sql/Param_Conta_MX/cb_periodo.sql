use cob_conta
go

declare	@w_fecha 	datetime,
		@w_fec_ini 	datetime,
		@w_fec_fin 	datetime,
		@w_empresa	int,
		@w_ano		int

if exists (select 1 from cob_conta..sysobjects where name = 'cb_periodo')
begin
	select @w_fecha = isnull(fp_fecha,getdate()) from cobis..ba_fecha_proceso
		
	if @w_fecha is null
		select @w_fecha = getdate()
		
	select @w_fec_ini = convert(varchar, year(@w_fecha)) + '/01/01'
	select @w_fec_fin = dateadd(dd, -1, dateadd(yyyy, 1, @w_fec_ini))		
	select @w_ano = year(@w_fecha)	
	select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'

	delete from cob_conta..cb_periodo where pe_empresa = @w_empresa
	
	INSERT INTO dbo.cb_periodo (pe_periodo, pe_empresa, pe_fecha_inicio, pe_fecha_fin, pe_estado, pe_tipo_periodo)
	VALUES (@w_ano, @w_empresa, @w_fec_ini, @w_fec_fin, 'V', 'D')

	--2018
	select @w_fecha = dateadd(yyyy,1,@w_fecha)		
	select @w_fec_ini = convert(varchar, year(@w_fecha)) + '/01/01'
	select @w_fec_fin = dateadd(dd, -1, dateadd(yyyy, 1, @w_fec_ini))		
	select @w_ano = year(@w_fecha)	
	select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'
	
	INSERT INTO dbo.cb_periodo (pe_periodo, pe_empresa, pe_fecha_inicio, pe_fecha_fin, pe_estado, pe_tipo_periodo)
	VALUES (@w_ano, @w_empresa, @w_fec_ini, @w_fec_fin, 'V', 'D')



end
else
	print 'NO EXISTE TABLA cb_periodo'
go