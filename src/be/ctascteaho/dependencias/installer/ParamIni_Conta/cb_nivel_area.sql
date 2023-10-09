Use cob_conta
go

IF OBJECT_ID ('dbo.cb_nivel_area') IS NOT NULL
	DROP TABLE dbo.cb_nivel_area
GO

CREATE TABLE dbo.cb_nivel_area
	(
	na_empresa     TINYINT NOT NULL,
	na_nivel_area  TINYINT NOT NULL,
	na_descripcion descripcion NOT NULL
	)
GO




INSERT INTO dbo.cb_nivel_area (na_empresa, na_nivel_area, na_descripcion)
VALUES (1, 1, 'Banco')
GO

INSERT INTO dbo.cb_nivel_area (na_empresa, na_nivel_area, na_descripcion)
VALUES (1, 2, 'Area')
GO

INSERT INTO dbo.cb_nivel_area (na_empresa, na_nivel_area, na_descripcion)
VALUES (1, 3, 'Sub-Area')
GO

INSERT INTO dbo.cb_nivel_area (na_empresa, na_nivel_area, na_descripcion)
VALUES (1, 4, 'HH')
GO

INSERT INTO dbo.cb_nivel_area (na_empresa, na_nivel_area, na_descripcion)
VALUES (1, 5, 'F')
GO
