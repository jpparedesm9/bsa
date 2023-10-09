use cob_conta
go

declare	@w_fecha 	datetime,
		@w_fec_ini 	datetime,
		@w_fec_fin 	datetime,
		@w_moneda	int

IF exists (select 1 from cob_conta..sysobjects where name = 'cb_cotizacion')
begin
	delete from cob_conta..cb_cotizacion 
	
	select @w_fecha = fp_fecha from cobis..ba_fecha_proceso
	select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
	
	select @w_fec_ini = '01/01/' + convert(varchar, year(@w_fecha))
	select @w_fec_fin = dateadd(dd, -1, dateadd(yyyy, 1, @w_fec_ini))
	
	while @w_fec_ini <= @w_fec_fin
	begin
		INSERT INTO cob_conta..cb_cotizacion 
				(ct_moneda, ct_fecha, ct_valor, ct_compra, ct_venta, ct_factor1, ct_factor2)
			VALUES 
				(@w_moneda, @w_fec_ini, 1, 1, 1, 1, 1)
				
		if (@@error > 0)
		begin
			print 'Error al ingresar las cotizaciones'
			break
		end
		
		select @w_fec_ini = dateadd(dd, 1, @w_fec_ini)
	end
end
else
	print 'NO EXISTE TABLA cb_cotizacion'

GO
