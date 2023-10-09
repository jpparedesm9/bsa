/**********************************************************************************************************************/
--No Bug                     : NO
--T�tulo de la Historia      : Incidencia
--Fecha                      : 10/11/2017
--Descripci�n del Problema   : correcion mensaje de error
--Descripci�n de la Soluci�n : correcion mensaje de error
--Autor                      : Patricio Samueza
--Instalador                 : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql/cr_errores.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql/cr_errores.sql
/*************************************************************************************************************************/

use cobis
GO

delete cobis..cl_errores
where numero =208924

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (208924, 0, 'Error de Conexi�n con Bur�')

