/***********************************************************************/
--No Bug:
--T�tulo del Bug: crear campos en tabla de oficiales
--Fecha:2017-06-15
--Descripci�n del Problema:
--crear nuevo campo para ingreso del email del oficial
--Descripci�n de la Soluci�n: crear campos
--Autor:LGU
/***********************************************************************/

use cobis
go

PRINT 'creacion del indice sobre el rfc'
go
IF EXISTS(SELECT 1 FROM sysindexes WHERE id = object_id('cl_ente')
	AND first        IS NOT NULL AND name = 'idx_rfc')
begin
	print' eliminando indice'
	DROP INDEX cl_ente.idx_rfc
end
go
	print' creando indice'
	CREATE INDEX idx_rfc ON cl_ente(en_rfc)


GO

go



