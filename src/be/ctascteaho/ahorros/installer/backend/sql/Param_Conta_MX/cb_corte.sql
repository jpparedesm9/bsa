use cob_conta
go

declare	@w_fecha 	datetime,
		@w_fec_day 	datetime,
		@w_fec_ini 	datetime,
		@w_fec_fin 	datetime,
		@w_estado	char(1),
		@w_empresa	int,
		@w_ano		int,
		@w_mes		int,
		@w_corte	int

if exists (select 1 from cob_conta..sysobjects where name = 'cb_corte')
begin
	delete from cob_conta..cb_corte where co_periodo = @w_ano and co_empresa = @w_empresa
	
	select @w_corte = isnull(max(co_corte), 0) + 1 from cob_conta..cb_corte
	select @w_fecha = fp_fecha from cobis..ba_fecha_proceso
		
	select @w_ano = year(@w_fecha)
	select @w_mes = month(@w_fecha)
	select @w_fec_ini = convert(varchar, year(@w_fecha)) + '/' +  convert(varchar, @w_mes) + '/01' 
	select @w_fec_fin = dateadd(dd, -1, dateadd(MM, 1, @w_fec_ini))
	
	select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'
		
	while @w_fec_ini <= @w_fec_fin
	begin
		if (@w_fec_ini = @w_fecha)
			select @w_estado = 'A'
		else
			select @w_estado = 'V'
		
		INSERT INTO cob_conta..cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
		VALUES (@w_corte, @w_ano, @w_empresa, @w_fec_ini, @w_fec_ini, @w_estado, 1)
		
		if (@@error > 0)
		begin
			print 'ERROR EN LA CREACION DE CORTE'
			break
		end
		
		select @w_corte = @w_corte + 1
		select @w_fec_ini = dateadd(dd, 1, @w_fec_ini)
	end
end
else
	print 'NO EXISTE TABLA cb_corte'
go