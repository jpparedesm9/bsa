Use cob_conta
go

declare @w_empresa	int,
		@w_fecha	datetime

if exists (select 1 from cob_conta..sysobjects where name = 'cb_oficina')
begin
	select @w_fecha = fp_fecha from cobis..ba_fecha_proceso
	select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'
		
	delete from cob_conta..cb_oficina where of_empresa = @w_empresa
	
	INSERT INTO cob_conta..cb_oficina (of_empresa, of_oficina, of_descripcion, of_oficina_padre, of_estado, of_fecha_estado, of_organizacion, of_consolida, of_movimiento, of_codigo)
	VALUES (@w_empresa, 255, 'BANCO DE LAS MICROFINANZAS BANCAMIA S.A', NULL, 'V', @w_fecha, 1, 'S', 'N', ' ')

	INSERT INTO cob_conta..cb_oficina (of_empresa, of_oficina, of_descripcion, of_oficina_padre, of_estado, of_fecha_estado, of_organizacion, of_consolida, of_movimiento, of_codigo)
		select @w_empresa, of_oficina, of_nombre, 255, 'V', @w_fecha, ROW_NUMBER() OVER(ORDER BY of_oficina ASC) + 1, 'N', 'S', ' '
			from cobis..cl_oficina
end
else
	print 'NO EXISTE TABLA cb_oficina'
go
