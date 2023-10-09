Use cob_conta
go


IF OBJECT_ID ('dbo.cb_area') IS NOT NULL
	DROP TABLE dbo.cb_area
GO

CREATE TABLE dbo.cb_area
	(
	ar_empresa      TINYINT NOT NULL,
	ar_area         SMALLINT NOT NULL,
	ar_descripcion  descripcion NOT NULL,
	ar_area_padre   SMALLINT NULL,
	ar_estado       CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
	ar_fecha_estado DATETIME NULL,
	ar_nivel_area   TINYINT NOT NULL,
	ar_consolida    CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
	ar_movimiento   CHAR (1) COLLATE Latin1_General_BIN NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_area_Key
	ON dbo.cb_area (ar_empresa,ar_area)
GO

CREATE NONCLUSTERED INDEX i_ar_area_padre
	ON dbo.cb_area (ar_area_padre,ar_empresa)
GO

CREATE NONCLUSTERED INDEX i_ar_nivel
	ON dbo.cb_area (ar_empresa,ar_nivel_area)
GO



INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 1, 'PRESIDENCIA', 1001, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 2, 'SECRETARIA GENERAL Y JURIDICA', 1002, 'C', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 3, 'CUMPLIMIENTO NORMATIVO', 1002, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 4, 'DIRECCION JURIDICA BANCARIA E INSTITUIONAL', 1002, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 5, 'VICEPRESIDENCIA DE RIESGO', 1003, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 6, 'RIESGO DE CREDITO', 1003, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 7, 'RIESGO OPERACIONAL', 1003, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 8, 'RIESGOS DE MERCADO SARM', 1003, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 9, 'AUDITORIA INTERNA', 1004, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 10, 'AUDITORIA DE RED Y FINANCIERA', 1004, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 11, 'AUDITORIA DE SISTEMAS', 1004, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 12, 'AUDITORIA DE RIESGOS', 1004, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 13, 'PLANEACION CORPORATIVA', 1005, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 14, 'COMUNICACION E IMAGEN', 1006, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 15, 'VICEPRESIDENCIA EJECUTIVA', 1007, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 16, 'VICEPRESIDENCIA DE MEDIOS', 1008, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 17, 'GERENCIA ADMINISTRATIVA TERRITORIAL', 1008, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 18, 'COMPRAS INMUEBLES Y SERVICIOS-CIS', 1008, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 19, 'OPERACIONES', 1008, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 20, 'TECNOLOGIA EXPLOTACION Y SOPORTE', 1008, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 21, 'PROYECTOS ORGANIZACION Y PROCESOS', 1008, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 22, 'VICEPRESIDENCIA DE DESARROLLO HUMANO', 1009, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 23, 'GESTION Y DESARROLLO', 1009, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 24, 'SELECCION Y FORMACION', 1009, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 25, 'ADMINISTRACION DE DESARROLLO HUMANO', 1009, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 26, 'VICEPRESIDENCIA FINANCIERA', 1010, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 27, 'PLANEACION Y GESTION FINANCIERA', 1010, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 28, 'TESORERIA', 1010, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 29, 'CONTABILIDAD', 1010, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 30, 'IMPUESTOS', 1010, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 31, 'RED DE OFICINAS', 1011, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 32, 'MERCADEO', 1011, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 33, 'CALIDAD Y SERVICIO AL CLIENTE', 1011, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 34, 'SERVICIOS CENTRALES', 255, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 35, 'TERRITORIAL DE NEGOCIOS OCCIDENTE', 1011, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 36, 'TERRITORIAL DE NEGOCIOS CENTRO', 1011, 'V', '2008-10-10', 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 37, 'ORGANIZACION Y TECNOLOGIA', 1008, 'V', NULL, 3, 'N', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 46, 'TRAVESIA', 1005, 'V', NULL, 3, 'S', 'S')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 255, 'BANCO DE LAS MICROFINANZAS BANCAMIA S.A', NULL, 'V', '2008-10-10', 1, 'S', 'N')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 1001, 'PRESIDENCIA', 255, 'V', '2008-10-10', 2, 'S', 'N')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 1002, 'SECRETARIA GENERAL Y JURIDICA', 255, 'V', '2008-10-10', 2, 'S', 'N')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 1003, 'RIESGOS', 255, 'V', '2008-10-10', 2, 'S', 'N')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 1004, 'AUDITORIA INTERNA', 255, 'V', '2008-10-10', 2, 'S', 'N')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 1005, 'PLANEACION CORPORATIVA', 255, 'V', '2008-10-10', 2, 'S', 'N')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 1006, 'COMUNICACION E IMAGEN', 255, 'V', '2008-10-10', 2, 'S', 'N')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 1007, 'VICEPRESIDENCIA EJECUTIVA', 255, 'V', '2008-10-10', 2, 'S', 'N')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 1008, 'MEDIOS', 255, 'V', '2008-10-10', 2, 'S', 'N')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 1009, 'DESARROLLO HUMANO', 255, 'V', '2008-10-10', 2, 'S', 'N')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 1010, 'FINANCIERA', 255, 'V', '2008-10-10', 2, 'S', 'N')
GO

INSERT INTO dbo.cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 1011, 'COMERCIAL', 255, 'V', '2008-10-10', 2, 'S', 'N')
GO


