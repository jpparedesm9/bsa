use cobis
go

delete cl_errores where numero =  103156

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103156, 0, ' Error el grupo tiene un trámite en ejecución. ')

go
