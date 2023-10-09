USE cob_pac
GO

IF OBJECT_ID ('dbo.ca_qr_rubro_tmp') IS NOT NULL
	DROP TABLE dbo.ca_qr_rubro_tmp
GO

CREATE TABLE dbo.ca_qr_rubro_tmp
	(
	qrt_id    INT IDENTITY NOT NULL,
	qrt_pid   INT NOT NULL,
	qrt_rubro catalogo NOT NULL
	)
GO