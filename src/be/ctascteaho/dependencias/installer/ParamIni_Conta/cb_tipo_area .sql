Use cob_conta
go

IF OBJECT_ID ('dbo.cb_tipo_area') IS NOT NULL
	DROP TABLE dbo.cb_tipo_area
GO

CREATE TABLE dbo.cb_tipo_area
	(
	ta_empresa       TINYINT NOT NULL,
	ta_producto      TINYINT NOT NULL,
	ta_tiparea       VARCHAR (10) COLLATE Latin1_General_BIN NOT NULL,
	ta_utiliza_valor CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
	ta_area          SMALLINT NULL,
	ta_descripcion   descripcion NULL,
	ta_ofi_central   SMALLINT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_tipo_area_Key
	ON dbo.cb_tipo_area (ta_empresa,ta_producto,ta_tiparea)
GO



INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 3, 'CTB-CJ', 'S', 31, 'AREA CONTABILIZACION CAMARA', 4069)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 3, 'CTB_19_31', 'S', 31, 'AREA DE CONTABILIZACION OFICINA 19 AREA 31', 19)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 3, 'CTB_CE', 'S', 31, 'AREA DE CONTABILIZACION CENTRO DE EFECTIVO', 5000)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 3, 'CTB_IMP', 'S', 30, 'AREA DE CONTABILIZACION IMPUESTOS', 4069)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 3, 'CTB_NOM', 'S', 22, 'AREA DE CONTABILIZACION NOMINA', 4069)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 3, 'CTB_OBL', 'S', 28, 'AREA DE CONTABILIZACION OBLIGACIONES FINANCIERAS', 4069)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 3, 'CTB_OF', 'S', 31, 'AREA DE CONTABILIZACION BRANCH', 4069)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 4, 'CTB_IMP', 'S', 30, 'IMPUESTOS AHORROS', 4069)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 4, 'CTB_OF', 'S', 31, 'AREA DE CONTABILIZACION DE AHORROS', 4069)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 6, '26', 'N', NULL, 'TIPOS DE AREAS POR PRUEBAS', NULL)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 7, 'CTB_19_31', 'S', 31, 'AREA DE CONTABILIZACION OFICINA 19 AREA 31', 19)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 7, 'CTB_IMP', 'S', 31, 'AREA DE CONTABILIZACION IMPUESTOS', 4069)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 7, 'CTB_OF', 'S', 31, 'AREA DE CONTABILIZACION CARTERA', 4069)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 7, 'CTB_PAS', 'S', 31, 'AREA DE CONTABILIZACION REDESCUENTO', 4069)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 10, 'CTB-CJ', 'S', 31, 'AREA CONTABILIZACION CAMARA', 4069)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 10, 'CTB_OF', 'S', 31, 'AREA DE CONTABILIZACION CAMARA Y REMESAS', 4069)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 14, 'CTB_IMP', 'S', 31, 'IMPUESTOS PLAZO FIJO', 4069)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 14, 'CTB_OP', 'S', 31, 'CTB_OP', 4069)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 19, 'CTB_OF', 'S', 31, 'AREA DE CONTABILIZACION GARANTIA', 4069)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 21, 'CTB_IMP', 'S', 31, 'AREA DE CONTABILIZACION IMPUESTOS', 4069)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 21, 'CTB_OF', 'S', 31, 'AREA DE CONTABILIZACION CREDITO', 4069)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 42, 'CTB_CJ', 'S', 31, 'AREA SERVICIOS BANCARIOS', 4069)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 42, 'CTB_IMP', 'S', 31, 'SERVICIOS BANCARIOS IMPUESTOS', 4069)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 42, 'CTB_OF', 'S', 31, 'SERVICIOS BANCARIOS OFICINAS', 4069)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 200, 'CTB_IMP', 'S', 30, 'SICREDITO IMPUESTOS', 4069)
GO

INSERT INTO dbo.cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 200, 'CTB_OF', 'S', 31, 'CARTERA SICREDITO', 4069)
GO
