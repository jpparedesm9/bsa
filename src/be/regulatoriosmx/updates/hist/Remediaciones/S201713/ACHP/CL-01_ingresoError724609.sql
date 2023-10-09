/**********************************************************************************************************************/
--No Bug                     : NA
--T�tulo de la Historia      : N/A
--Fecha                      : 30/06/2017
--Descripci�n del Problema   : Agregar codigos de error
--Descripci�n de la Soluci�n : Agregar codigos de error
--Autor                      : Adriana Chiluisa
--Instalador                 : ca_error.sql
--Ruta Instalador            : $/COB/Test/TEST_SaaSMX/Activas/Cartera/Backend/sql
/**********************************************************************************************************************/
use cobis
go

if not exists (select 1 from cl_errores where numero = 107351)
	insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724609, 0, 'MONTO APROBADO ES MENOR O SUPERIOR AL PERMITIDO')
go