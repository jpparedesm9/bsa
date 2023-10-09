
USE cobis
GO
print 'cobis..cl_errores ' 

delete from cobis..cl_errores where numero in (701172,701173,701174,701175,701176)

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (701172, 0, 'No existen mas pr�stamos')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (701173, 0, 'Para b�squeda por oficina ingresar (fecha de desembolso) o pr�stamo migrada')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (701174, 0, 'Para b�squeda por regional ingresar (fecha desembolso)')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (701175, 0, 'Para b�squeda por ruta ingresar la fecha desembolso')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (701176, 0, 'Ingrese al menos un criterio de b�squeda principal')