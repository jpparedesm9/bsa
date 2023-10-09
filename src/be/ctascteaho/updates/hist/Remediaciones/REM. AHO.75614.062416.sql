use cobis
go

if exists (select 1 from cobis..cl_errores where numero = 141195)
    delete cobis..cl_errores where numero = 141195
go

insert into cobis..cl_errores values (141195, 0, 'No existen registros que cumplan la(s) condición(es) dada(s)')