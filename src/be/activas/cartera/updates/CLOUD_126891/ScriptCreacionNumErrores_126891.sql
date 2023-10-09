use cobis
go



if not exists(select top 1 * from cobis..cl_errores where numero = 724681)
        insert into cl_errores (numero, severidad, mensaje) values (724681, 0, 'ERROR EN ACUALIZAR LOS SEGUROS')
go


if not exists(select top 1 * from cobis..cl_errores where numero = 724682)
        insert into cl_errores (numero, severidad, mensaje) values (724682, 0, 'ERROR EN INSERTAR LOS SEGUROS')
go

