/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : N/A
--Fecha                      : 30/06/2017
--Descripción del Problema   : Agregar codigos de error
--Descripción de la Solución : Agregar codigos de error
--Autor                      : Adriana Chiluisa
--Instalador                 : ca_error.sql
--Ruta Instalador            : $/COB/Test/TEST_SaaSMX/Activas/Cartera/Backend/sql
/**********************************************************************************************************************/
use cobis
go

if not exists (select 1 from cl_errores where numero = 107351)
	insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724609, 0, 'MONTO APROBADO ES MENOR O SUPERIOR AL PERMITIDO')
go