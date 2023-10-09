USE cob_conta
GO


IF OBJECT_ID ('dbo.cb_organizacion') IS NOT NULL
	DROP TABLE dbo.cb_organizacion
GO

CREATE TABLE dbo.cb_organizacion
	(
	or_empresa      TINYINT NOT NULL,
	or_organizacion TINYINT NOT NULL,
	or_descripcion  descripcion NOT NULL
	)
GO



INSERT INTO dbo.cb_organizacion (or_empresa, or_organizacion, or_descripcion)
VALUES (1, 1, 'BANCAMIA')
GO

INSERT INTO dbo.cb_organizacion (or_empresa, or_organizacion, or_descripcion)
VALUES (1, 2, 'TERRITORIAL')
GO

INSERT INTO dbo.cb_organizacion (or_empresa, or_organizacion, or_descripcion)
VALUES (1, 3, 'CENTROS OPERATIVOS')
GO

INSERT INTO dbo.cb_organizacion (or_empresa, or_organizacion, or_descripcion)
VALUES (1, 4, 'ZONA')
GO

INSERT INTO dbo.cb_organizacion (or_empresa, or_organizacion, or_descripcion)
VALUES (1, 5, 'OFICINA')
GO
