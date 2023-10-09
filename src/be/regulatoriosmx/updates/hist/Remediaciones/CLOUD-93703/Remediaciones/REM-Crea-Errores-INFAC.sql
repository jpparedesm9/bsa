----Errores para Interfactura

USE cobis
go

delete cobis..cl_errores where numero IN (70200,70201)

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (70200, 0, 'ERROR EN INGRESO DE INTERFACTURA')


INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (70201, 0, 'ERROR EN INGRESO DE ESTADO DE CUENTA')
GO