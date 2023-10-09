use cobis
go

--antes
select * from cobis..cl_errores where numero in (70011020)

delete from cobis..cl_errores where numero in (70011020)
insert into  cobis..cl_errores values (70011020, 0, 'CLIENTE NO CUENTA CON DIRECCION DE DOMICILIO')

--despues
select * from cobis..cl_errores where numero in (70011020)

go

