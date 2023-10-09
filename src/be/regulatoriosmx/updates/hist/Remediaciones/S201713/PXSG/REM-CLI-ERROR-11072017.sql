
/**********************************************************************************************************************/
--No Bug                     : NA
--T�tulo de la Historia      : N/A
--Fecha                      : 30/06/2017
--Descripci�n del Problema   : Agregar codigos de error
--Descripci�n de la Soluci�n : Agregar codigos de error
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

