set nocount on

use cobis
go

declare @w_transaccion int = 1500 -- TRANSACCION UTILIZADA PARA EL INICIO DE SESION

if exists (select 1 from cl_ttransaccion where tn_trn_code = @w_transaccion) begin
	delete cl_ttransaccion where tn_trn_code = @w_transaccion
	if @@ROWCOUNT != 0 begin
		print 'Se elimina la transacción existente: ' + convert(varchar, @w_transaccion)
	end
end

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico) values (1500, 'CONEXION DEL SISTEMA - LOGIN', 'STARLG')

if @@ROWCOUNT != 0 begin
	print 'Se crea la transacción: ' + convert(varchar, @w_transaccion)
end