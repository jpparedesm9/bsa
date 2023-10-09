USE [cob_interfase] 
GO


print '-->cco_error_conaut'
go
if exists(select 1 from sysobjects where name = 'cco_error_conaut' and type = 'U')
	DROP TABLE dbo.cco_error_conaut
GO

print '-->ct_scomprobante'
go
if exists(select 1 from sysobjects where name = 'ct_scomprobante' and type = 'U')
	DROP TABLE dbo.ct_scomprobante
GO

print '-->ct_sasiento'
go
if exists(select 1 from sysobjects where name = 'ct_sasiento' and type = 'U')
	DROP TABLE dbo.ct_sasiento
GO

print '-->cco_error_conaut_his'
go
if exists(select 1 from sysobjects where name = 'cco_error_conaut_his' and type = 'U')
	DROP TABLE dbo.cco_error_conaut_his
GO
