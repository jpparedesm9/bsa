
if not exists(select 1
              from cobis..cl_errores
              where numero = 601180)
begin
      insert into  cobis..cl_errores (numero, severidad, mensaje)
                               values(601180, 0        , 'Existen comprobantes pendientes de Aprobación/Anulación para la fecha del corte')
end                               
