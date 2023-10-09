Use cob_conta
go

declare @w_empresa	int

IF exists (select 1 from cob_conta..sysobjects where name = 'cb_empresa')
begin
	delete from cob_conta..cb_empresa
	select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'
	
	INSERT INTO cob_conta..cb_empresa (em_empresa, em_ruc, em_descripcion, em_replegal, em_contgen, em_moneda_base, em_abreviatura, em_direccion, em_matcontgen, em_revisor, em_matrevisor, em_emp_revisor, em_nit_emprev, em_mat_revisor)
		VALUES (@w_empresa, '9002150711', 'BANCO MX', 'COBISCORP', 'COBISCORP', 0, 'BANCO MX', 'COBISCORP', '22016 -T', 'COBISCORP', '88877-T', 'COBISCORP', '8600005813', '2340')
end
else
	print 'NO EXISTE TABLA cb_empresa'

GO
