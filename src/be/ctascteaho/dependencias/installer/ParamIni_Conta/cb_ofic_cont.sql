Use cob_conta
go

IF OBJECT_ID ('dbo.cb_ofic_cont') IS NOT NULL
	DROP TABLE dbo.cb_ofic_cont
GO

CREATE TABLE dbo.cb_ofic_cont
	(
	oc_empresa   TINYINT NULL,
	oc_oficina   SMALLINT NULL,
	oc_area      SMALLINT NULL,
	oc_ofi_cons  SMALLINT NULL,
	oc_ofi_padre SMALLINT NULL,
	oc_ofi_reg   SMALLINT NULL,
	oc_ofi_cob   SMALLINT NULL,
	oc_ofi_zona  SMALLINT NULL,
	oc_ofi_age   SMALLINT NULL
	)
GO




INSERT INTO dbo.cb_ofic_cont (oc_empresa, oc_oficina, oc_area, oc_ofi_cons, oc_ofi_padre, oc_ofi_reg, oc_ofi_cob, oc_ofi_zona, oc_ofi_age)
VALUES (1, 4069, 29, 255, 1, 2, 3, 4, 5)
GO
