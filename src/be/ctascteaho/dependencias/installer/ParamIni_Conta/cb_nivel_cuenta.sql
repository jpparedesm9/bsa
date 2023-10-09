Use cob_conta
go

IF OBJECT_ID ('dbo.cb_nivel_cuenta') IS NOT NULL
	DROP TABLE dbo.cb_nivel_cuenta
GO

CREATE TABLE dbo.cb_nivel_cuenta
	(
	nc_empresa      TINYINT NOT NULL,
	nc_nivel_cuenta TINYINT NOT NULL,
	nc_longitud     TINYINT NOT NULL,
	nc_descripcion  descripcion NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_nivel_cuenta_Key
	ON dbo.cb_nivel_cuenta (nc_empresa,nc_nivel_cuenta)
GO



INSERT INTO dbo.cb_nivel_cuenta (nc_empresa, nc_nivel_cuenta, nc_longitud, nc_descripcion)
VALUES (1, 1, 1, 'CLASE')
GO

INSERT INTO dbo.cb_nivel_cuenta (nc_empresa, nc_nivel_cuenta, nc_longitud, nc_descripcion)
VALUES (1, 2, 1, 'GRUPO')
GO

INSERT INTO dbo.cb_nivel_cuenta (nc_empresa, nc_nivel_cuenta, nc_longitud, nc_descripcion)
VALUES (1, 3, 2, 'CUENTA')
GO

INSERT INTO dbo.cb_nivel_cuenta (nc_empresa, nc_nivel_cuenta, nc_longitud, nc_descripcion)
VALUES (1, 4, 2, 'SUBCUENTA')
GO

INSERT INTO dbo.cb_nivel_cuenta (nc_empresa, nc_nivel_cuenta, nc_longitud, nc_descripcion)
VALUES (1, 5, 2, 'MONEDA')
GO

INSERT INTO dbo.cb_nivel_cuenta (nc_empresa, nc_nivel_cuenta, nc_longitud, nc_descripcion)
VALUES (1, 6, 2, 'AUXILIAR')
GO

INSERT INTO dbo.cb_nivel_cuenta (nc_empresa, nc_nivel_cuenta, nc_longitud, nc_descripcion)
VALUES (1, 7, 2, 'AUXILIAR 2')
GO
