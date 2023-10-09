
USE cobis
go

delete cobis..cl_errores where numero IN (103161)

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103161, 0, 'El Segundo Nombre es requerido')

GO