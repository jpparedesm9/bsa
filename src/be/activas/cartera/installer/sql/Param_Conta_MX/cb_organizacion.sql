USE cob_conta
GO

declare @w_empresa	int

if exists (select 1 from cob_conta..sysobjects where name = 'cb_organizacion')
begin
	select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'
	
	delete from cob_conta..cb_organizacion where or_empresa = @w_empresa
	
	INSERT INTO cob_conta..cb_organizacion (or_empresa, or_organizacion, or_descripcion)
	VALUES (@w_empresa, 1, 'SOFOM SANTANDER')
	INSERT INTO cob_conta..cb_organizacion (or_empresa, or_organizacion, or_descripcion)
	VALUES (@w_empresa, 2, 'DIVISION')
	INSERT INTO cob_conta..cb_organizacion (or_empresa, or_organizacion, or_descripcion)
	VALUES (@w_empresa, 3, 'REGIONAL')	
	INSERT INTO cob_conta..cb_organizacion (or_empresa, or_organizacion, or_descripcion)
	VALUES (@w_empresa, 4, 'AGENCIA')
   
end
else
	print 'NO EXISTE TABLA cb_organizacion'
go