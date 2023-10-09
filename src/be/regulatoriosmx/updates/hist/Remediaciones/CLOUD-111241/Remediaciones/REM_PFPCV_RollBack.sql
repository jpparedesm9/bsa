
use cobis
go


declare @w_tabla    int

select @w_tabla = codigo
from cl_tabla
where tabla = 'ca_param_notif'

if @@rowcount > 0 BEGIN

DELETE from cl_catalogo where codigo = 'PFPCV_NJAS' AND tabla=@w_tabla

DELETE from cl_catalogo where codigo = 'PFPCV_NPDF' AND tabla=@w_tabla

DELETE from cl_catalogo where codigo = 'PFPCV_NXML' AND tabla=@w_tabla

end

go