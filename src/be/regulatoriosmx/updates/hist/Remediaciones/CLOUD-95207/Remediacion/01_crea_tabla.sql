USE cobis
GO

IF OBJECT_ID ('dbo.ba_tablas_respaldo') IS NOT NULL
	DROP TABLE dbo.ba_tablas_respaldo
GO

CREATE TABLE dbo.ba_tablas_respaldo
	(
	tipo      CHAR (1) NULL,
	fecha_gen DATETIME NULL,
	clave     VARCHAR (1000) NULL,
	tabla1    VARCHAR (1000) NULL,
	tabla2    VARCHAR (1000) NULL
	)
GO

CREATE NONCLUSTERED INDEX idx_1
	ON dbo.ba_tablas_respaldo (fecha_gen)
GO

