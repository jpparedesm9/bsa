use cobis
go
if exists(select 1 from cl_errores where numero IN (103411,103412))
	delete from cobis..cl_errores where numero in (103411,103412)

go
