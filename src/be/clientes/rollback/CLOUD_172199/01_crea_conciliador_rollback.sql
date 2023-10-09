
use cobis
GO

if exists(select 1 from sysobjects
           where name = 'cl_principal_notificador')
   drop table cl_principal_notificador
go

if exists(select 1 from sysobjects
           where name = 'cl_detalle_notificador')
   drop table cl_detalle_notificador
go


if exists(select 1 from sysobjects
           where name = 'cl_log_notificador')
   drop table cl_log_notificador
go
