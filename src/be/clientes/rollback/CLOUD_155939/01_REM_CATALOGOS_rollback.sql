use cobis
go

declare @w_tabla   int

select @w_tabla = codigo FROM cobis..cl_tabla WHERE tabla = 'cl_modulo_cliente'

if @w_tabla is not null
   update cobis..cl_catalogo set estado = 'V' where tabla = @w_tabla and valor = 'REFERENCIAS'

go