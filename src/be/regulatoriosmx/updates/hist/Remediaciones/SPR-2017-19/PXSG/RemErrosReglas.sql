/**********************************************************************************************************************/
--No Bug                     : NO
--Título de la Historia      : Incidencia
--Fecha                      : 06/10/2017
--Descripción del Problema   : creacion de errores para reglas grupales  e individuales
--Descripción de la Solución : creacion de errores para reglas grupales  e individuales
--Autor                      : Patricio Samueza
--Instalador                 : cr_errores.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
/**********************************************************************************************************************/

use cobis
GO

delete cobis..cl_errores
where numero in (208927,208928,208929,208930,208931)

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (208927, 0, 'Existen préstamos  que superan el incremento permitido')


INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (208928, 0, 'Existen préstamos con monto superior al monto Máximo')



INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (208929, 0, 'Existen préstamos con monto inferior al monto Mínimo')


INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (208930, 0, 'Monto del préstamo es superior al monto Máximo')


INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (208931, 0, 'Monto del préstamo es inferior al monto Mínimo')
GO


