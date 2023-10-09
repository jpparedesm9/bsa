
use cobis
go

if exists (select 1 from cobis..cl_errores where numero = 208935)
    delete from cobis..cl_errores where numero = 208935
else
    insert into cobis..cl_errores values (208935, 0, 'SECRETARIO YA EXISTE EN EL GRUPO')
go
