use cob_conta
go

IF OBJECT_ID ('dbo.cb_boc') IS NOT NULL
	DROP TABLE dbo.cb_boc
GO

CREATE TABLE dbo.cb_boc
	(
	bo_fecha      SMALLDATETIME NOT NULL,
	bo_cuenta     cuenta NOT NULL,
	bo_oficina    INT NOT NULL,
	bo_cliente    INT NOT NULL,
	bo_val_opera  MONEY NOT NULL,
	bo_val_conta  MONEY NOT NULL,
	bo_diferencia MONEY NOT NULL,
	bo_producto   INT
	)
GO

CREATE INDEX idx1
	ON dbo.cb_boc (bo_cliente, bo_cuenta, bo_oficina, bo_fecha)
	WITH (FILLFACTOR = 75)
GO

CREATE INDEX idx2
	ON dbo.cb_boc (bo_producto)
	WITH (FILLFACTOR = 85)
GO

CREATE INDEX idx3
	ON dbo.cb_boc (bo_cuenta)
	WITH (FILLFACTOR = 85)
GO


IF OBJECT_ID ('dbo.cb_boc_det') IS NOT NULL
	DROP TABLE dbo.cb_boc_det
GO

CREATE TABLE dbo.cb_boc_det
	(
	bod_fecha         SMALLDATETIME NOT NULL,
	bod_cuenta        cuenta NOT NULL,
	bod_oficina       INT NOT NULL,
	bod_cliente       INT NOT NULL,
	bod_banco         cuenta NOT NULL,
	bod_concepto      catalogo NOT NULL,
	bod_admisible     CHAR (1) NOT NULL,
	bod_calificacion  catalogo NOT NULL,
	bod_clase_cartera catalogo NOT NULL,
	bod_val_opera     MONEY NOT NULL,
	bod_producto      INT
	)
GO


IF OBJECT_ID ('dbo.cb_boc_respaldo') IS NOT NULL
	DROP TABLE dbo.cb_boc_respaldo
GO

CREATE TABLE dbo.cb_boc_respaldo
	(
	bo_secuencial INT,
	bo_fecha      SMALLDATETIME NOT NULL,
	bo_cuenta     cuenta NOT NULL,
	bo_oficina    INT NOT NULL,
	bo_cliente    INT NOT NULL,
	bo_val_opera  MONEY NOT NULL,
	bo_val_conta  MONEY NOT NULL,
	bo_diferencia MONEY NOT NULL,
	bo_producto   INT
	)
GO

CREATE INDEX boc_res_idx
	ON dbo.cb_boc_respaldo (bo_fecha, bo_producto)
	WITH (FILLFACTOR = 90)
GO

CREATE INDEX cb_boc_respaldo_idx4
	ON dbo.cb_boc_respaldo (bo_secuencial, bo_fecha, bo_producto)
	WITH (FILLFACTOR = 90)
GO

CREATE UNIQUE INDEX idx1
	ON dbo.cb_boc_respaldo (bo_cliente, bo_fecha, bo_cuenta, bo_oficina, bo_secuencial)
	WITH (FILLFACTOR = 90)
GO

CREATE INDEX idx2
	ON dbo.cb_boc_respaldo (bo_fecha, bo_cuenta, bo_oficina, bo_secuencial)
	WITH (FILLFACTOR = 90)
GO

CREATE INDEX cb_boc_respaldo_idx5
	ON dbo.cb_boc_respaldo (bo_secuencial, bo_fecha, bo_cuenta, bo_oficina, bo_cliente, bo_val_opera, bo_val_conta, bo_diferencia, bo_producto)
	WITH (FILLFACTOR = 90)
GO

IF OBJECT_ID ('dbo.cb_boc_det_respaldo') IS NOT NULL
	DROP TABLE dbo.cb_boc_det_respaldo
GO

CREATE TABLE dbo.cb_boc_det_respaldo
	(
	bod_secuencial    INT,
	bod_fecha         SMALLDATETIME NOT NULL,
	bod_cuenta        cuenta NOT NULL,
	bod_oficina       INT NOT NULL,
	bod_cliente       INT NOT NULL,
	bod_banco         cuenta NOT NULL,
	bod_concepto      catalogo NOT NULL,
	bod_admisible     CHAR (1) NOT NULL,
	bod_calificacion  catalogo NOT NULL,
	bod_clase_cartera catalogo NOT NULL,
	bod_val_opera     MONEY NOT NULL,
	bod_producto      INT
	)
GO

CREATE INDEX idxbod_fecha_sec
	ON dbo.cb_boc_det_respaldo (bod_fecha, bod_secuencial)
	WITH (FILLFACTOR = 90)
GO


IF OBJECT_ID ('dbo.cb_boc_log_respaldo') IS NOT NULL
	DROP TABLE dbo.cb_boc_log_respaldo
GO

CREATE TABLE dbo.cb_boc_log_respaldo
	(
	bl_secuencial INT,
	bl_fecha      SMALLDATETIME NOT NULL,
	bl_error      VARCHAR (255) NOT NULL,
	bl_producto   INT
	)
GO

CREATE INDEX idx1
	ON dbo.cb_boc_log_respaldo (bl_fecha, bl_secuencial)
	WITH (FILLFACTOR = 75)
GO


IF OBJECT_ID ('dbo.cb_boc_log') IS NOT NULL
	DROP TABLE dbo.cb_boc_log
GO

CREATE TABLE dbo.cb_boc_log
	(
	bl_fecha    SMALLDATETIME NOT NULL,
	bl_error    VARCHAR (255) NOT NULL,
	bl_producto INT
	)
GO

CREATE INDEX cb_boc_log_key
	ON dbo.cb_boc_log (bl_fecha)
GO


