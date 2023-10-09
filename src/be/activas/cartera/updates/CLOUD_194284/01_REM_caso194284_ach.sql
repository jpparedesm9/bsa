declare @w_tabla_cod int

SELECT @w_tabla_cod = codigo from cobis..cl_tabla where tabla = 'ca_tdividendo'

select * from cobis..cl_catalogo where tabla = @w_tabla_cod and codigo = 'BW'

delete from cobis..cl_catalogo where tabla = @w_tabla_cod and codigo = 'BW'

insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla_cod, 'BW', 'CATORCENAL', 'V', NULL, NULL, NULL)
go
