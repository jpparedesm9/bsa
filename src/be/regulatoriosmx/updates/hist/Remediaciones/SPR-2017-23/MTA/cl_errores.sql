 /*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : 
--Descripción del Problema   : Crear el reporte de solicitud de credito de inclusion
--Responsable                : Maria Jose Taco
--Ruta TFS                   : Descripción abajo
--Nombre Archivo             : Descripción abajo
/*----------------------------------------------------------------------------------------------------------------*/

--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Cartera/Backend/sql/ca_error.sql
--Nombre Archivo             : ca_error.sql

use cobis
go

delete cl_errores where numero in (701221,701222,701223,701224)

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (701221, 0, 'No existen mas operaciones')

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (701222, 0, 'Para búsqueda por oficina ingresar (fecha de desembolso)')

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (701223, 0, 'Para búsqueda por oficial ingresar (fecha desembolso)')

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (701224, 0, 'Ingrese al menos un criterio de busqueda principal')
GO
