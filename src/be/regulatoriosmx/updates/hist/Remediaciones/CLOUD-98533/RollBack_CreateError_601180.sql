
if exists(select 1
              from cobis..cl_errores
              where numero = 601180)
begin
      delete
      from cobis..cl_errores
      where numero = 601180
end                               
