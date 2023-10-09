Use cob_conta
go

declare @w_empresa	int,
		@w_fecha 	datetime

if exists (select 1 from cob_conta..sysobjects where name = 'cb_area')
begin
	select @w_fecha = fp_fecha from cobis..ba_fecha_proceso
	select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'

	delete from cob_conta..cb_area where ar_empresa = @w_empresa

	INSERT INTO cob_conta..cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
	VALUES (@w_empresa, 255, 'BANCO DE LAS MICROFINANZAS BANCAMIA S.A', NULL, 'V', @w_fecha, 1, 'S', 'N')

	INSERT INTO cob_conta..cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
	VALUES (@w_empresa, 1010, 'FINANCIERA', 255, 'V', @w_fecha, 2, 'S', 'N')

	INSERT INTO cob_conta..cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
	VALUES (@w_empresa, 1011, 'COMERCIAL', 255, 'V', @w_fecha, 2, 'S', 'N')

	INSERT INTO cob_conta..cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
	VALUES (@w_empresa, 30, 'IMPUESTOS', 1010, 'V', @w_fecha, 3, 'N', 'S')

	INSERT INTO cob_conta..cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
	VALUES (@w_empresa, 31, 'RED DE OFICINAS', 1011, 'V', @w_fecha, 3, 'N', 'S')
end
else
	print 'NO EXISTE TABLA cb_area'

go