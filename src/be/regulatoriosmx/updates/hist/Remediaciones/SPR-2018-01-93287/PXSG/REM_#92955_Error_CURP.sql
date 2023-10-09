/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : 
--Descripción del Problema   : Error al crear un cliente con un rfc ya existente
--Responsable                : Patricio Samueza
--Ruta TFS                   : Descripción abajo
--Nombre Archivo             : Descripción abajo
/*----------------------------------------------------------------------------------------------------------------*/

--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql/cl_error.sql
--Nombre Archivo             : cl_error.sql

USE cobis
GO 

delete cobis..cl_errores where numero IN (70011007,70011008)

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (70011007, 0, 'Ya existe una persona con esta identificación. CURP')



INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (70011008, 0, 'Ya existe una persona con esta identificación. RFC')
GO