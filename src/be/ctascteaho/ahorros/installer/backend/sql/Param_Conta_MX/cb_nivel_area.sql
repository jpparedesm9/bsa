Use cob_conta
go

declare @w_empresa	int

if exists (select 1 from cob_conta..sysobjects where name = 'cb_nivel_area')
begin
	select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'

	delete from cob_conta..cb_nivel_area where na_empresa = @w_empresa
	
	INSERT INTO cob_conta..cb_nivel_area (na_empresa, na_nivel_area, na_descripcion)
	VALUES (@w_empresa, 1, 'Banco')

	INSERT INTO cob_conta..cb_nivel_area (na_empresa, na_nivel_area, na_descripcion)
	VALUES (@w_empresa, 2, 'Area')

	INSERT INTO cob_conta..cb_nivel_area (na_empresa, na_nivel_area, na_descripcion)
	VALUES (@w_empresa, 3, 'Sub-Area')
end
else
	print 'NO EXISTE TABLA cb_nivel_area'
GO
