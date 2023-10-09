/*************************************************/
-- Fecha Creación del Script:  28/06/2016
-- Historial  Dependencias:
-- KME    28/06/2016   Se añade mensaje de error para corrección de errores de versión
--
/*************************************************/ 
use cobis
go

delete cl_errores where numero in (258003)
go
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (258003, 0, 'CLIENTE NO TIENE CUENTAS O ESTAN ACTIVAS')
GO