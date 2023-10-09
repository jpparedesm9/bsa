use cobis
go

if not exists (SELECT 1 FROM cobis..cl_errores WHERE numero = 2108051)
    insert into cl_errores (numero, severidad, mensaje)
    values (2108051, 0, 'LOS INTEGRANTES DEL COMITE DEBEN PARTICIPAR')
go
