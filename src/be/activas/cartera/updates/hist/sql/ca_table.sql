USE cob_cartera
GO


IF OBJECT_ID ('dbo.ca_qr_rubro_tmp') IS NOT NULL
	DROP TABLE dbo.ca_qr_rubro_tmp
GO

CREATE TABLE dbo.ca_qr_rubro_tmp
	(
	qrt_id    INT IDENTITY NOT NULL,
	qrt_pid   INT NULL,
	qrt_rubro catalogo NULL
	)
GO

CREATE NONCLUSTERED INDEX ca_qr_rubro_tmp1
	ON dbo.ca_qr_rubro_tmp (qrt_pid)
GO


IF OBJECT_ID ('dbo.ca_qr_amortiza_tmp') IS NOT NULL
	DROP TABLE dbo.ca_qr_amortiza_tmp
GO

CREATE TABLE dbo.ca_qr_amortiza_tmp
	(
	qat_pid        INT NULL,
	qat_dividendo  INT NULL,
	qat_fecha_ven  DATETIME NULL,
	qat_dias_cuota INT NULL,
	qat_saldo_cap  MONEY NULL,
	qat_rubro1     MONEY NULL,
	qat_rubro2     MONEY NULL,
	qat_rubro3     MONEY NULL,
	qat_rubro4     MONEY NULL,
	qat_rubro5     MONEY NULL,
	qat_rubro6     MONEY NULL,
	qat_rubro7     MONEY NULL,
	qat_rubro8     MONEY NULL,
	qat_rubro9     MONEY NULL,
	qat_rubro10    MONEY NULL,
	qat_rubro11    MONEY NULL,
	qat_rubro12    MONEY NULL,
	qat_rubro13    MONEY NULL,
	qat_rubro14    MONEY NULL,
	qat_rubro15    MONEY NULL,
	qat_cuota      MONEY NULL,
	qat_estado     VARCHAR (10) COLLATE Latin1_General_BIN NULL,
	qat_porroga    CHAR (2) COLLATE Latin1_General_BIN NULL
	)
GO

CREATE NONCLUSTERED INDEX ca_qr_amortiza_tmp1
	ON dbo.ca_qr_amortiza_tmp (qat_pid)
GO

