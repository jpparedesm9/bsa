
use cobis
GO

if exists(select 1 from sysobjects where name = 'cl_principal_notificador')

TRUNCATE TABLE cl_principal_notificador

go

if exists(select 1 from sysobjects where name = 'cl_detalle_notificador')
begin

TRUNCATE TABLE dbo.cl_detalle_notificador
go