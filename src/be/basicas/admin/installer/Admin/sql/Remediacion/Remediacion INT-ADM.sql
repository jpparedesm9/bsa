USE cobis
go

If not exists(select 1 from cl_errores where numero = 107203)
                insert into cl_errores values (107203,0,'EL USUARIO NO TIENE SESION BLOQUEADA')
go

