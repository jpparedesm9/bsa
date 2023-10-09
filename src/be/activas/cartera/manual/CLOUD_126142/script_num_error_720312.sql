use cobis
go


select *
from cobis..cl_errores
where numero = 720312

if not exists (select 1 from cobis..cl_errores  where numero = 720312)
begin
     insert into cobis..cl_errores (numero, severidad, mensaje)
                            values (720312, 0        , 'ERROR PAGO DUPLICADO')
end                            
go


select *
from cobis..cl_errores
where numero = 720312