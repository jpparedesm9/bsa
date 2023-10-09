--------------------------------------------------------------------------------------------
-- Eliminar TABLA
--------------------------------------------------------------------------------------------
use cobis
go
IF OBJECT_ID ('dbo.cl_solicitud_traspaso_tmp') IS NOT NULL
	DROP TABLE dbo.cl_solicitud_traspaso_tmp
GO
IF OBJECT_ID ('dbo.cl_solicitud_traspaso') IS NOT NULL
	DROP TABLE dbo.cl_solicitud_traspaso
GO
IF OBJECT_ID ('dbo.cl_cli_sol_traspaso') IS NOT NULL
	DROP TABLE dbo.cl_cli_sol_traspaso
GO
IF OBJECT_ID ('dbo.cl_ns_traspaso') IS NOT NULL
	DROP TABLE dbo.cl_ns_traspaso
go
--------------------------------------------------------------------------------------------
-- Eliminar en tabla de secuenciales
--------------------------------------------------------------------------------------------
use cobis
go
DELETE cobis..cl_seqnos where bdatos = 'cobis' and tabla = 'cl_ns_traspaso'
--------------------------------------------------------------------------------------------
-- Eliminar SP
--------------------------------------------------------------------------------------------
IF OBJECT_ID ('dbo.sp_qr_ns_traspaso') IS NOT NULL
	DROP PROCEDURE dbo.sp_qr_ns_traspaso
GO
if exists(select 1 from sysobjects where name = 'sp_traspaso')
    drop proc sp_traspaso
go
use cob_credito
go
if exists(select 1 from sysobjects where name = 'sp_traslada_tramite')
    drop proc sp_traslada_tramite
go