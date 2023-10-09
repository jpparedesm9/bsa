use cobis
go

delete from cobis..cl_errores where numero in (103411,103412)

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103411, 0, 'CODIGO DE TIPO DE MERCADO INCORRECTO')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103412, 0, 'CODIGO DE NIVEL DE CLIENTE INCORRECTO')

go
