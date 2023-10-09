Use cob_conta
go

declare @w_empresa	int

if exists (select 1 from cob_conta..sysobjects where name = 'cb_nivel_cuenta')
begin
	select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'
	
	delete from cob_conta..cb_nivel_cuenta where nc_empresa = @w_empresa
	
	insert into cob_conta..cb_nivel_cuenta (nc_empresa, nc_nivel_cuenta, nc_longitud, nc_descripcion) values (@w_empresa, 1, 1, 'CLASE')
	insert into cob_conta..cb_nivel_cuenta (nc_empresa, nc_nivel_cuenta, nc_longitud, nc_descripcion) values (@w_empresa, 2, 1, 'GRUPO')
	insert into cob_conta..cb_nivel_cuenta (nc_empresa, nc_nivel_cuenta, nc_longitud, nc_descripcion) values (@w_empresa, 3, 2, 'CUENTA')
	insert into cob_conta..cb_nivel_cuenta (nc_empresa, nc_nivel_cuenta, nc_longitud, nc_descripcion) values (@w_empresa, 4, 2, 'SUBCUENTA')
	insert into cob_conta..cb_nivel_cuenta (nc_empresa, nc_nivel_cuenta, nc_longitud, nc_descripcion) values (@w_empresa, 5, 2, 'AUXILIAR1')
	insert into cob_conta..cb_nivel_cuenta (nc_empresa, nc_nivel_cuenta, nc_longitud, nc_descripcion) values (@w_empresa, 6, 2, 'AUXILIAR2')
    insert into cob_conta..cb_nivel_cuenta (nc_empresa, nc_nivel_cuenta, nc_longitud, nc_descripcion) values (@w_empresa, 7, 2, 'AUXILIAR3')
end
else
	print 'NO EXISTE TABLA cb_nivel_cuenta'
go
