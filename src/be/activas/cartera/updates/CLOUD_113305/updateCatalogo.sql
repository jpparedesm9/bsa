use cobis
go

declare @w_tabla smallint

select @w_tabla = codigo 
from cl_tabla
where  tabla = 'ca_tipo_prestamo'

update cl_catalogo 
set valor='NORMAL'
where tabla = @w_tabla
and codigo = 'O'