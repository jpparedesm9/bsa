use cobis
go

delete from cl_errores where numero = 70011019
go

insert into cl_errores values (70011019, 0, 'El n�mero de celular ingresado ya existe, por favor ingrese un nuevo n�mero')
go