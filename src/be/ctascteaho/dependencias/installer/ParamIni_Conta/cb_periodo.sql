use cob_cuenta
go


IF OBJECT_ID ('dbo.cb_periodo') IS NOT NULL
	DROP TABLE dbo.cb_periodo
GO

CREATE TABLE dbo.cb_periodo
	(
	pe_periodo      INT NOT NULL,
	pe_empresa      TINYINT NOT NULL,
	pe_fecha_inicio DATETIME NOT NULL,
	pe_fecha_fin    DATETIME NOT NULL,
	pe_estado       CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
	pe_tipo_periodo CHAR (10) COLLATE Latin1_General_BIN NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_periodo_Key
	ON dbo.cb_periodo (pe_empresa,pe_periodo)
GO




INSERT INTO dbo.cb_periodo (pe_periodo, pe_empresa, pe_fecha_inicio, pe_fecha_fin, pe_estado, pe_tipo_periodo)
VALUES (2008, 1, '2008-01-01', '2008-12-31', 'C', 'D')
GO

INSERT INTO dbo.cb_periodo (pe_periodo, pe_empresa, pe_fecha_inicio, pe_fecha_fin, pe_estado, pe_tipo_periodo)
VALUES (2009, 1, '2009-01-01', '2009-12-31', 'C', 'D')
GO

INSERT INTO dbo.cb_periodo (pe_periodo, pe_empresa, pe_fecha_inicio, pe_fecha_fin, pe_estado, pe_tipo_periodo)
VALUES (2010, 1, '2010-01-01', '2010-12-31', 'C', 'D')
GO

INSERT INTO dbo.cb_periodo (pe_periodo, pe_empresa, pe_fecha_inicio, pe_fecha_fin, pe_estado, pe_tipo_periodo)
VALUES (2011, 1, '2011-01-01', '2011-12-31', 'C', 'D')
GO

INSERT INTO dbo.cb_periodo (pe_periodo, pe_empresa, pe_fecha_inicio, pe_fecha_fin, pe_estado, pe_tipo_periodo)
VALUES (2012, 1, '2012-01-01', '2012-12-31', 'C', 'D')
GO

INSERT INTO dbo.cb_periodo (pe_periodo, pe_empresa, pe_fecha_inicio, pe_fecha_fin, pe_estado, pe_tipo_periodo)
VALUES (2013, 1, '2013-01-01', '2013-12-31', 'C', 'D')
GO

INSERT INTO dbo.cb_periodo (pe_periodo, pe_empresa, pe_fecha_inicio, pe_fecha_fin, pe_estado, pe_tipo_periodo)
VALUES (2014, 1, '2014-01-01', '2014-12-31', 'V', 'D')
GO

INSERT INTO dbo.cb_periodo (pe_periodo, pe_empresa, pe_fecha_inicio, pe_fecha_fin, pe_estado, pe_tipo_periodo)
VALUES (2015, 1, '2015-01-01', '2015-12-31', 'V', 'D')
GO
