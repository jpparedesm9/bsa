use cob_conta_super
go

IF OBJECT_ID ('dbo.sb_operacion_cancelada') IS NOT NULL
	DROP table dbo.sb_operacion_cancelada
go
