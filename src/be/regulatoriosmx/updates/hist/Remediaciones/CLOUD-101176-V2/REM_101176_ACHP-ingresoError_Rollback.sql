use cobis
go

if exists (select 1 from cobis..cl_errores where numero = 208935)
    delete from cobis..cl_errores where numero = 208935
go
