------------->>>>>>>>>>>>>------------->>>>>>>>>>>>>------------->>>>>>>>>>>>>------------->>>>>>>>>>>>>------------->>>>>>>>>>>>>
------------->>>>>>>>>>>>>------------->>>>>>>>>>>>>------------->>>>>>>>>>>>>------------->>>>>>>>>>>>>------------->>>>>>>>>>>>>
use cob_cartera
go

IF OBJECT_ID ('dbo.lista_cliente_caso173308') IS NOT NULL
	DROP table dbo.lista_cliente_caso173308
GO

if exists(select 1 from sysobjects where name ='sp_crear_revolventes_caso_173308')
	drop proc sp_crear_revolventes_caso_173308
go
