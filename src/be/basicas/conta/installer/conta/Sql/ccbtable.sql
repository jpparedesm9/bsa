USE [cob_ccontable] 
GO

print '-->cco_error_conaut'
go
if exists(select 1 from sysobjects where name = 'cco_error_conaut' and type = 'U')
	DROP TABLE dbo.cco_error_conaut
GO

print '-->cco_error_conaut_his'
go
if exists(select 1 from sysobjects where name = 'cco_error_conaut_his' and type = 'U')
	DROP TABLE dbo.cco_error_conaut_his
GO

