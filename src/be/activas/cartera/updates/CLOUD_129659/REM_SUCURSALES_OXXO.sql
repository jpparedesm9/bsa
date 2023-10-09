use cob_cartera
go


declare
@w_corresponsal            int

select @w_corresponsal = co_id
from ca_corresponsal
where co_nombre       = 'OXXO'

if @w_corresponsal is not null BEGIN
   update ca_corresponsal set 
   co_estado = 'A'
   where co_id = @w_corresponsal

   DELETE ca_corresponsal_err WHERE ce_error_cobis IN (70214,70215)
   INSERT INTO ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   VALUES (@w_corresponsal, 70214, '20', 'ERROR: LA SUCURSAL A LA QUE PERTENECE EL GRUPO NO ACEPTA PAGOS DE OXXO')
   INSERT INTO ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
   VALUES (@w_corresponsal, 70215, '20', 'ERROR: LA SUCURSAL A LA QUE PERTENECE EL CLIENTE NO ACEPTA PAGOS DE OXXO')
end


go

use cobis
go
delete cl_errores where numero in (70214,70215)

--Errores OXXO Sucursal
insert into cl_errores  (numero, severidad, mensaje)values (70214, 0, 'ERROR: LA SUCURSAL A LA QUE PERTENECE EL GRUPO NO ACEPTA PAGOS DE OXXO')
insert into cl_errores  (numero, severidad, mensaje)values (70215, 0, 'ERROR: LA SUCURSAL A LA QUE PERTENECE EL CLIENTE NO ACEPTA PAGOS DE OXXO')
go