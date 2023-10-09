

declare @w_valor varchar(64), @w_tabla int

select @w_tabla = codigo from cobis..cl_tabla where tabla = 'cr_txt_documento'

select * from cobis..cl_catalogo where tabla = @w_tabla and codigo = 'RIXCT01'

update cobis..cl_catalogo set valor = 'CRÉDITO INDIVIDUAL “TU CRÉDITO AL CLIC”' where tabla = @w_tabla and codigo = 'RIXCT01'

select * from cobis..cl_catalogo where tabla = @w_tabla and codigo = 'RIXCT01'

go
