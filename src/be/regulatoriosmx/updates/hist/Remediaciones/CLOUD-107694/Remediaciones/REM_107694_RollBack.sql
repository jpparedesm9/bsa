use cobis
go

if exists (SELECT 1 FROM cobis..cl_errores WHERE numero = 2108051)
    delete cobis..cl_errores WHERE numero = 2108051
go
