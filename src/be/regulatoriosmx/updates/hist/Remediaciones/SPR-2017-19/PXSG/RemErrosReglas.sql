/**********************************************************************************************************************/
--No Bug                     : NO
--T�tulo de la Historia      : Incidencia
--Fecha                      : 06/10/2017
--Descripci�n del Problema   : creacion de errores para reglas grupales  e individuales
--Descripci�n de la Soluci�n : creacion de errores para reglas grupales  e individuales
--Autor                      : Patricio Samueza
--Instalador                 : cr_errores.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
/**********************************************************************************************************************/

use cobis
GO

delete cobis..cl_errores
where numero in (208927,208928,208929,208930,208931)

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (208927, 0, 'Existen pr�stamos  que superan el incremento permitido')


INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (208928, 0, 'Existen pr�stamos con monto superior al monto M�ximo')



INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (208929, 0, 'Existen pr�stamos con monto inferior al monto M�nimo')


INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (208930, 0, 'Monto del pr�stamo es superior al monto M�ximo')


INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (208931, 0, 'Monto del pr�stamo es inferior al monto M�nimo')
GO


