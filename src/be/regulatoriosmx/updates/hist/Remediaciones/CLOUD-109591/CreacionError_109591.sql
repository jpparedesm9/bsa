use cobis
go

if not exists(select 1 from cobis..cl_errores where numero = 2108051)
begin
     insert into cobis..cl_errores(numero, severidad, mensaje)
     values(2108051,0,'LOS INTEGRANTES DEL COMITE DEBEN PARTICIPAR')
end

if not exists(select 1 from cobis..cl_errores where numero = 21008)
begin
    insert into cobis..cl_errores(numero, severidad, mensaje)
    values(21008,0,'ERROR AL EJECUTAR LAS VALIDACIONES DE GRUPO')
end