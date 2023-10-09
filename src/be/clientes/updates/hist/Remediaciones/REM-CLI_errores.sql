/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : N/A
--Fecha                      : 26/06/2017
--Descripción del Problema   : Agregar codigos de error
--Descripción de la Solución : Agregar codigos de error
--Autor                      : Maria Jose Taco
--Instalador                 : cl_errores.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/
use cobis
go

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149053, 0, 'EL INTEGRANTE TIENE OPERACIONES PENDIENTES')

go