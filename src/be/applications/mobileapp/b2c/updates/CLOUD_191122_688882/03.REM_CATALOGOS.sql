USE cobis
go

declare 
@w_tabla int

select * 
from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla = 'ns_bloque_sms')

select @w_tabla = codigo from cobis..cl_tabla where tabla = 'ns_bloque_sms'

INSERT INTO cobis..cl_catalogo 
(tabla,codigo,valor,estado,culture,equiv_code,type)
 VALUES(@w_tabla,'5','OTP-GENERICO','V',null,null,null)

select * 
from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla = 'ns_bloque_sms')

go

