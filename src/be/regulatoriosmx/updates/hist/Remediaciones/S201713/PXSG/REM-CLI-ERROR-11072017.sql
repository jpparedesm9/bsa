
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : N/A
--Fecha                      : 30/06/2017
--Descripción del Problema   : Agregar codigos de error
--Descripción de la Solución : Agregar codigos de error
--Autor                      : PATRICIO SAMUEZA
--Instalador                 : ca_error.sql
--Ruta Instalador            : $/COB/Test/TEST_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/

USE cobis 
GO

delete cl_errores where numero=149054

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149054, 0, 'MIEMBRO A MODIFICAR ES PARTE DE UNA DIRECTIVA EXISTENTE MODIFIQUE LOS MIEMBROS')
go

