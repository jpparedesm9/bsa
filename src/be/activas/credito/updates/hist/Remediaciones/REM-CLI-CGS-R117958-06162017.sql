/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : CGS-R117958 Optimización en creación de Grupales
--Descripción del Problema   : Cambios para la pantalla de gruppos monto
--Responsable                : Adriana Chiluisa
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_errores.sql
/*----------------------------------------------------------------------------------------------------------------*/

use cobis
go

DELETE cl_errores WHERE numero = 2103058

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (2103058, 1, 'Debe Ingresar los Montos')
GO