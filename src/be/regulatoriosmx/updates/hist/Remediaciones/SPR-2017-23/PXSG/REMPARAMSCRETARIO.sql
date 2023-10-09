/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : 
--Descripción del Problema   : Crear el reporte de solicitud de credito de inclusion
--Responsable                : Patricio Samueza
--Ruta TFS                   : Descripción abajo
--Nombre Archivo             : Descripción abajo
/*----------------------------------------------------------------------------------------------------------------*/

--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Test/TEST_SaaSMX/Clientes/Backend/sql/cl_error.sql
--Nombre Archivo             : cl_error.sql

use cobis
go

delete cl_errores where numero in (208926)

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (208926, 0, 'EL GRUPO DEBE TENER UN SECRETARIO')

go
