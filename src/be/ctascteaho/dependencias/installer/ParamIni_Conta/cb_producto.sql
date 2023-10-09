
Use cob_conta
go

IF OBJECT_ID ('dbo.cb_producto') IS NOT NULL
	DROP TABLE dbo.cb_producto
GO

CREATE TABLE dbo.cb_producto
	(
	pr_empresa   TINYINT NOT NULL,
	pr_producto  TINYINT NOT NULL,
	pr_online    CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
	pr_estado    CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
	pr_resumen   CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
	pr_fecha_mod DATETIME NOT NULL
	)
GO




INSERT INTO dbo.cb_producto (pr_empresa, pr_producto, pr_online, pr_estado, pr_resumen, pr_fecha_mod)
VALUES (1, 3, 'N', 'V', 'S', '2008-10-14 05:52:06')
GO

INSERT INTO dbo.cb_producto (pr_empresa, pr_producto, pr_online, pr_estado, pr_resumen, pr_fecha_mod)
VALUES (1, 6, 'N', 'V', 'S', '2008-10-14 05:52:06')
GO

INSERT INTO dbo.cb_producto (pr_empresa, pr_producto, pr_online, pr_estado, pr_resumen, pr_fecha_mod)
VALUES (1, 7, 'S', 'V', 'S', '2008-10-14 05:52:06')
GO

INSERT INTO dbo.cb_producto (pr_empresa, pr_producto, pr_online, pr_estado, pr_resumen, pr_fecha_mod)
VALUES (1, 9, 'N', 'V', 'N', '2008-10-14 05:52:06')
GO

INSERT INTO dbo.cb_producto (pr_empresa, pr_producto, pr_online, pr_estado, pr_resumen, pr_fecha_mod)
VALUES (1, 14, 'N', 'V', 'N', '2010-02-20 20:55:32')
GO

INSERT INTO dbo.cb_producto (pr_empresa, pr_producto, pr_online, pr_estado, pr_resumen, pr_fecha_mod)
VALUES (1, 16, 'N', 'V', 'S', '2008-10-14 05:52:06')
GO

INSERT INTO dbo.cb_producto (pr_empresa, pr_producto, pr_online, pr_estado, pr_resumen, pr_fecha_mod)
VALUES (1, 19, 'S', 'V', 'S', '2008-10-14 05:52:06')
GO

INSERT INTO dbo.cb_producto (pr_empresa, pr_producto, pr_online, pr_estado, pr_resumen, pr_fecha_mod)
VALUES (1, 21, 'S', 'V', 'S', '2008-10-14 05:52:06')
GO

INSERT INTO dbo.cb_producto (pr_empresa, pr_producto, pr_online, pr_estado, pr_resumen, pr_fecha_mod)
VALUES (1, 42, 'N', 'V', 'S', '2008-10-14 05:52:06')
GO

INSERT INTO dbo.cb_producto (pr_empresa, pr_producto, pr_online, pr_estado, pr_resumen, pr_fecha_mod)
VALUES (1, 48, 'N', 'V', 'S', '2008-10-14 05:52:06')
GO

INSERT INTO dbo.cb_producto (pr_empresa, pr_producto, pr_online, pr_estado, pr_resumen, pr_fecha_mod)
VALUES (1, 150, 'N', 'V', 'S', '2008-10-14 05:52:06')
GO

INSERT INTO dbo.cb_producto (pr_empresa, pr_producto, pr_online, pr_estado, pr_resumen, pr_fecha_mod)
VALUES (1, 252, 'N', 'V', 'S', '2008-10-14 05:52:06')
GO

INSERT INTO dbo.cb_producto (pr_empresa, pr_producto, pr_online, pr_estado, pr_resumen, pr_fecha_mod)
VALUES (1, 10, 'N', 'V', 'N', '2008-10-14 05:52:06')
GO

INSERT INTO dbo.cb_producto (pr_empresa, pr_producto, pr_online, pr_estado, pr_resumen, pr_fecha_mod)
VALUES (1, 200, 'S', 'V', 'S', '2009-05-19 12:24:16')
GO

INSERT INTO dbo.cb_producto (pr_empresa, pr_producto, pr_online, pr_estado, pr_resumen, pr_fecha_mod)
VALUES (1, 4, 'N', 'V', 'S', '2010-10-17 15:31:34')
GO
