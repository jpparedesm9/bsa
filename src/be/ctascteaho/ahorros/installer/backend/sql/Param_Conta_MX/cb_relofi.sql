
Use cob_conta
go

declare @w_empresa	int,
		@w_filial	int

if exists (select 1 from cob_conta..sysobjects where name = 'cb_relofi')
begin
	select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'
	select @w_filial = 1
	
	delete from cob_conta..cb_relofi where re_empresa = @w_empresa

	INSERT INTO cob_conta..cb_relofi (re_filial, re_empresa, re_ofadmin, re_ofconta)	
	select @w_filial, @w_empresa, of_oficina, of_oficina
			from cobis..cl_oficina
	end
else
	print 'NO EXISTE TABLA cb_relofi'

go
