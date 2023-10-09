
use cobis
go

DECLARE @w_tabla INT

select @w_tabla = codigo
from cobis..cl_tabla 
where tabla = 'cr_tplazo_ind'

update cobis..cl_catalogo set estado = 'B' where tabla = @w_tabla AND codigo = 'Q'
update cobis..cl_catalogo set valor = 'MENSUAL' where tabla = @w_tabla AND codigo = 'M'


IF NOT EXISTS (SELECT 1 FROM cl_catalogo WHERE tabla = @w_tabla AND codigo = 'BW') begin
   insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
   values (@w_tabla, 'BW', 'CATORCENAL', 'V', NULL, NULL, NULL)
end
go