USE cobis
go

declare 
@w_tabla int

select @w_tabla = codigo from cobis..cl_tabla where tabla = 'ns_bloque_sms'

delete
from cobis..cl_catalogo 
where tabla = @w_tabla 
and valor = 'OTP-GENERICO'

go

