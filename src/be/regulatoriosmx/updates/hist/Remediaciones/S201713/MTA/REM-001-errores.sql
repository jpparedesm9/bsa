/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : N/A
--Fecha                      : 29/06/2017
--Descripción del Problema   : Agregar codigos de error
--Descripción de la Solución : Agregar codigos de error
--Autor                      : Maria Jose Taco
--Instalador                 : cl_errores.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/
use cobis
go

if not exists (select 1 from cl_errores where numero = 107351)
	INSERT INTO cobis..cl_errores VALUES(107351,0, 'El cliente no tiene registrada una direccion')

go