use cob_interfase
go

IF OBJECT_ID ('dbo.in_numlet') IS NOT NULL
	DROP TABLE dbo.in_numlet
GO

CREATE TABLE dbo.in_numlet
	(
	nl_tipo        CHAR (1) NOT NULL,
	nl_numero      TINYINT NOT NULL,
	nl_letras_esp  VARCHAR (24) NOT NULL,
	nl_letras_otro VARCHAR (24) NOT NULL
	)
GO
