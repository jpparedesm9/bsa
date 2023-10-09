use cobis
go

print 'Eliminacion de mensajes de error'
go
delete from cl_errores where numero in (190033)
go

print 'Creacion:  cl_errores'
go
insert into cl_errores values(190033, 0, 'NO EXISTE EL FUNCIONARIO')
go
