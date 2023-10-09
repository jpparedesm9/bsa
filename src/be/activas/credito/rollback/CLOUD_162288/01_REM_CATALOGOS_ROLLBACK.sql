use cobis
go

declare @w_tabla INT

select @w_tabla = codigo
from cobis..cl_tabla 
where tabla = 'cr_tplazo_ind'

update cobis..cl_catalogo set estado = 'V' where tabla = @w_tabla AND codigo = 'Q'
update cobis..cl_catalogo set valor = 'MES(ES)' where tabla = @w_tabla AND codigo = 'M'

delete cl_catalogo WHERE tabla = @w_tabla AND codigo = 'BW'
go
