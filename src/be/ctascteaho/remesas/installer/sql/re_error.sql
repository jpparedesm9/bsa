
use cobis
go
-- ----------------------------------------------------------------------------------------------------------------------
----- ---------------------------------------------------- ERRORRES -----------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------
delete from cl_errores 
 where numero in (352004, 701065,201333,357580,357581,357582,357583,357584,357585,357586, 201008)

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (352004, 0, ' La Oficina ya posee tipo de canje')

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (701065, 1, 'No existe Cupo asociado')

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (201333, 1, 'Fecha de Proximo Pago debe ser menor o igual a la Fecha Hasta')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (357580, 0, 'RANGO DE FECHA YA EXISTE')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (357581, 0, 'ERROR AL OBTENER SECUENCIAL PE_PRO_RANGO_EDAD')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (357582, 0, 'ERROR AL INGRESAR RANGO EDAD')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (357583, 0, 'ERROR AL ACTUALIZAR RANGO EDAD')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (357584, 0, 'ERROR AL ELIMINAR RANGO EDAD')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (357585, 0, 'RANGO EDAD ESTA SIENDO USANDO EN UN PRODUCTO FINAL')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (357586, 0, 'Tipo de cheque enviado no es local')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (201008, 0, 'Cuenta Bloqueada')

go

