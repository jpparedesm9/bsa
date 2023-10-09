declare @w_tabla_cod int

SELECT @w_tabla_cod = codigo from cobis..cl_tabla where tabla = 'ca_tdividendo'

select * from cobis..cl_catalogo where tabla = @w_tabla_cod and codigo = 'BW'

delete from cobis..cl_catalogo where tabla = @w_tabla_cod and codigo = 'BW'

select * from cobis..cl_catalogo where tabla = @w_tabla_cod and codigo = 'BW'
go
