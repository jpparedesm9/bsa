
USE cobis
GO
print 'cobis..cl_errores ' 

delete from cobis..cl_errores where numero in (701172,701173,701174,701175,701176)

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (701172, 0, 'No existen mas préstamos')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (701173, 0, 'Para búsqueda por oficina ingresar (fecha de desembolso) o préstamo migrada')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (701174, 0, 'Para búsqueda por regional ingresar (fecha desembolso)')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (701175, 0, 'Para búsqueda por ruta ingresar la fecha desembolso')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (701176, 0, 'Ingrese al menos un criterio de búsqueda principal')