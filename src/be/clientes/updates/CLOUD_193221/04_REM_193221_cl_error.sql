use cobis
go

delete from cl_errores where numero in (103416,70077, 70078)

insert into cl_errores (numero, severidad, mensaje)
values (103416, 0, 'ERROR AL GUARDAR TIPO DE AUTORIZACION')

insert into cl_errores(numero, severidad, mensaje)
values(70077,0,'Error al registrar información de la autorización')

-- \\src\be\basicas\mobileintegration\installer\sql\si_errores.sql
INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (70078, 0, 'Existe una sincronización en proceso.')


go

