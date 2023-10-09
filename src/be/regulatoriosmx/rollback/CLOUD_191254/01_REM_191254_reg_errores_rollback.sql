use cobis
go

--antes
select * from cobis..cl_errores where numero in (70011020)

delete from cobis..cl_errores where numero in (70011020)

--despues
select * from cobis..cl_errores where numero in (70011020)

go

