Use cob_conta
go

IF OBJECT_ID ('dbo.cb_corte') IS NOT NULL
	DROP TABLE dbo.cb_corte
GO

CREATE TABLE dbo.cb_corte
	(
	co_corte      INT NOT NULL,
	co_periodo    INT NOT NULL,
	co_empresa    TINYINT NOT NULL,
	co_fecha_ini  DATETIME NOT NULL,
	co_fecha_fin  DATETIME NOT NULL,
	co_estado     CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
	co_tipo_corte TINYINT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_corte_Key
	ON dbo.cb_corte (co_corte,co_periodo,co_empresa)
GO

CREATE NONCLUSTERED INDEX cb_corte_Key_fecha
	ON dbo.cb_corte (co_fecha_ini)
GO




INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (1, 2008, 1, '2008-01-01', '2008-01-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (1, 2009, 1, '2009-01-01', '2009-01-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (1, 2010, 1, '2010-01-01', '2010-01-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (1, 2011, 1, '2011-01-01', '2011-01-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (1, 2012, 1, '2012-01-01', '2012-01-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (1, 2013, 1, '2013-01-01', '2013-01-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (1, 2014, 1, '2014-01-01', '2014-01-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (1, 2015, 1, '2015-01-01', '2015-01-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (2, 2008, 1, '2008-01-02', '2008-01-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (2, 2009, 1, '2009-01-02', '2009-01-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (2, 2010, 1, '2010-01-02', '2010-01-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (2, 2011, 1, '2011-01-02', '2011-01-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (2, 2012, 1, '2012-01-02', '2012-01-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (2, 2013, 1, '2013-01-02', '2013-01-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (2, 2014, 1, '2014-01-02', '2014-01-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (2, 2015, 1, '2015-01-02', '2015-01-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (3, 2008, 1, '2008-01-03', '2008-01-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (3, 2009, 1, '2009-01-03', '2009-01-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (3, 2010, 1, '2010-01-03', '2010-01-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (3, 2011, 1, '2011-01-03', '2011-01-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (3, 2012, 1, '2012-01-03', '2012-01-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (3, 2013, 1, '2013-01-03', '2013-01-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (3, 2014, 1, '2014-01-03', '2014-01-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (3, 2015, 1, '2015-01-03', '2015-01-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (4, 2008, 1, '2008-01-04', '2008-01-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (4, 2009, 1, '2009-01-04', '2009-01-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (4, 2010, 1, '2010-01-04', '2010-01-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (4, 2011, 1, '2011-01-04', '2011-01-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (4, 2012, 1, '2012-01-04', '2012-01-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (4, 2013, 1, '2013-01-04', '2013-01-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (4, 2014, 1, '2014-01-04', '2014-01-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (4, 2015, 1, '2015-01-04', '2015-01-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (5, 2008, 1, '2008-01-05', '2008-01-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (5, 2009, 1, '2009-01-05', '2009-01-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (5, 2010, 1, '2010-01-05', '2010-01-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (5, 2011, 1, '2011-01-05', '2011-01-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (5, 2012, 1, '2012-01-05', '2012-01-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (5, 2013, 1, '2013-01-05', '2013-01-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (5, 2014, 1, '2014-01-05', '2014-01-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (5, 2015, 1, '2015-01-05', '2015-01-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (6, 2008, 1, '2008-01-06', '2008-01-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (6, 2009, 1, '2009-01-06', '2009-01-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (6, 2010, 1, '2010-01-06', '2010-01-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (6, 2011, 1, '2011-01-06', '2011-01-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (6, 2012, 1, '2012-01-06', '2012-01-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (6, 2013, 1, '2013-01-06', '2013-01-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (6, 2014, 1, '2014-01-06', '2014-01-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (6, 2015, 1, '2015-01-06', '2015-01-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (7, 2008, 1, '2008-01-07', '2008-01-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (7, 2009, 1, '2009-01-07', '2009-01-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (7, 2010, 1, '2010-01-07', '2010-01-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (7, 2011, 1, '2011-01-07', '2011-01-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (7, 2012, 1, '2012-01-07', '2012-01-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (7, 2013, 1, '2013-01-07', '2013-01-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (7, 2014, 1, '2014-01-07', '2014-01-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (7, 2015, 1, '2015-01-07', '2015-01-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (8, 2008, 1, '2008-01-08', '2008-01-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (8, 2009, 1, '2009-01-08', '2009-01-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (8, 2010, 1, '2010-01-08', '2010-01-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (8, 2011, 1, '2011-01-08', '2011-01-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (8, 2012, 1, '2012-01-08', '2012-01-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (8, 2013, 1, '2013-01-08', '2013-01-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (8, 2014, 1, '2014-01-08', '2014-01-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (8, 2015, 1, '2015-01-08', '2015-01-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (9, 2008, 1, '2008-01-09', '2008-01-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (9, 2009, 1, '2009-01-09', '2009-01-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (9, 2010, 1, '2010-01-09', '2010-01-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (9, 2011, 1, '2011-01-09', '2011-01-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (9, 2012, 1, '2012-01-09', '2012-01-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (9, 2013, 1, '2013-01-09', '2013-01-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (9, 2014, 1, '2014-01-09', '2014-01-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (9, 2015, 1, '2015-01-09', '2015-01-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (10, 2008, 1, '2008-01-10', '2008-01-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (10, 2009, 1, '2009-01-10', '2009-01-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (10, 2010, 1, '2010-01-10', '2010-01-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (10, 2011, 1, '2011-01-10', '2011-01-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (10, 2012, 1, '2012-01-10', '2012-01-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (10, 2013, 1, '2013-01-10', '2013-01-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (10, 2014, 1, '2014-01-10', '2014-01-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (10, 2015, 1, '2015-01-10', '2015-01-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (11, 2008, 1, '2008-01-11', '2008-01-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (11, 2009, 1, '2009-01-11', '2009-01-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (11, 2010, 1, '2010-01-11', '2010-01-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (11, 2011, 1, '2011-01-11', '2011-01-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (11, 2012, 1, '2012-01-11', '2012-01-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (11, 2013, 1, '2013-01-11', '2013-01-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (11, 2014, 1, '2014-01-11', '2014-01-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (11, 2015, 1, '2015-01-11', '2015-01-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (12, 2008, 1, '2008-01-12', '2008-01-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (12, 2009, 1, '2009-01-12', '2009-01-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (12, 2010, 1, '2010-01-12', '2010-01-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (12, 2011, 1, '2011-01-12', '2011-01-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (12, 2012, 1, '2012-01-12', '2012-01-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (12, 2013, 1, '2013-01-12', '2013-01-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (12, 2014, 1, '2014-01-12', '2014-01-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (12, 2015, 1, '2015-01-12', '2015-01-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (13, 2008, 1, '2008-01-13', '2008-01-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (13, 2009, 1, '2009-01-13', '2009-01-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (13, 2010, 1, '2010-01-13', '2010-01-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (13, 2011, 1, '2011-01-13', '2011-01-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (13, 2012, 1, '2012-01-13', '2012-01-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (13, 2013, 1, '2013-01-13', '2013-01-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (13, 2014, 1, '2014-01-13', '2014-01-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (13, 2015, 1, '2015-01-13', '2015-01-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (14, 2008, 1, '2008-01-14', '2008-01-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (14, 2009, 1, '2009-01-14', '2009-01-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (14, 2010, 1, '2010-01-14', '2010-01-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (14, 2011, 1, '2011-01-14', '2011-01-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (14, 2012, 1, '2012-01-14', '2012-01-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (14, 2013, 1, '2013-01-14', '2013-01-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (14, 2014, 1, '2014-01-14', '2014-01-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (14, 2015, 1, '2015-01-14', '2015-01-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (15, 2008, 1, '2008-01-15', '2008-01-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (15, 2009, 1, '2009-01-15', '2009-01-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (15, 2010, 1, '2010-01-15', '2010-01-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (15, 2011, 1, '2011-01-15', '2011-01-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (15, 2012, 1, '2012-01-15', '2012-01-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (15, 2013, 1, '2013-01-15', '2013-01-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (15, 2014, 1, '2014-01-15', '2014-01-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (15, 2015, 1, '2015-01-15', '2015-01-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (16, 2008, 1, '2008-01-16', '2008-01-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (16, 2009, 1, '2009-01-16', '2009-01-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (16, 2010, 1, '2010-01-16', '2010-01-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (16, 2011, 1, '2011-01-16', '2011-01-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (16, 2012, 1, '2012-01-16', '2012-01-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (16, 2013, 1, '2013-01-16', '2013-01-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (16, 2014, 1, '2014-01-16', '2014-01-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (16, 2015, 1, '2015-01-16', '2015-01-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (17, 2008, 1, '2008-01-17', '2008-01-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (17, 2009, 1, '2009-01-17', '2009-01-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (17, 2010, 1, '2010-01-17', '2010-01-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (17, 2011, 1, '2011-01-17', '2011-01-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (17, 2012, 1, '2012-01-17', '2012-01-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (17, 2013, 1, '2013-01-17', '2013-01-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (17, 2014, 1, '2014-01-17', '2014-01-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (17, 2015, 1, '2015-01-17', '2015-01-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (18, 2008, 1, '2008-01-18', '2008-01-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (18, 2009, 1, '2009-01-18', '2009-01-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (18, 2010, 1, '2010-01-18', '2010-01-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (18, 2011, 1, '2011-01-18', '2011-01-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (18, 2012, 1, '2012-01-18', '2012-01-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (18, 2013, 1, '2013-01-18', '2013-01-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (18, 2014, 1, '2014-01-18', '2014-01-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (18, 2015, 1, '2015-01-18', '2015-01-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (19, 2008, 1, '2008-01-19', '2008-01-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (19, 2009, 1, '2009-01-19', '2009-01-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (19, 2010, 1, '2010-01-19', '2010-01-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (19, 2011, 1, '2011-01-19', '2011-01-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (19, 2012, 1, '2012-01-19', '2012-01-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (19, 2013, 1, '2013-01-19', '2013-01-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (19, 2014, 1, '2014-01-19', '2014-01-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (19, 2015, 1, '2015-01-19', '2015-01-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (20, 2008, 1, '2008-01-20', '2008-01-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (20, 2009, 1, '2009-01-20', '2009-01-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (20, 2010, 1, '2010-01-20', '2010-01-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (20, 2011, 1, '2011-01-20', '2011-01-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (20, 2012, 1, '2012-01-20', '2012-01-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (20, 2013, 1, '2013-01-20', '2013-01-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (20, 2014, 1, '2014-01-20', '2014-01-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (20, 2015, 1, '2015-01-20', '2015-01-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (21, 2008, 1, '2008-01-21', '2008-01-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (21, 2009, 1, '2009-01-21', '2009-01-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (21, 2010, 1, '2010-01-21', '2010-01-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (21, 2011, 1, '2011-01-21', '2011-01-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (21, 2012, 1, '2012-01-21', '2012-01-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (21, 2013, 1, '2013-01-21', '2013-01-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (21, 2014, 1, '2014-01-21', '2014-01-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (21, 2015, 1, '2015-01-21', '2015-01-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (22, 2008, 1, '2008-01-22', '2008-01-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (22, 2009, 1, '2009-01-22', '2009-01-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (22, 2010, 1, '2010-01-22', '2010-01-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (22, 2011, 1, '2011-01-22', '2011-01-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (22, 2012, 1, '2012-01-22', '2012-01-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (22, 2013, 1, '2013-01-22', '2013-01-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (22, 2014, 1, '2014-01-22', '2014-01-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (22, 2015, 1, '2015-01-22', '2015-01-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (23, 2008, 1, '2008-01-23', '2008-01-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (23, 2009, 1, '2009-01-23', '2009-01-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (23, 2010, 1, '2010-01-23', '2010-01-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (23, 2011, 1, '2011-01-23', '2011-01-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (23, 2012, 1, '2012-01-23', '2012-01-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (23, 2013, 1, '2013-01-23', '2013-01-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (23, 2014, 1, '2014-01-23', '2014-01-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (23, 2015, 1, '2015-01-23', '2015-01-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (24, 2008, 1, '2008-01-24', '2008-01-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (24, 2009, 1, '2009-01-24', '2009-01-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (24, 2010, 1, '2010-01-24', '2010-01-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (24, 2011, 1, '2011-01-24', '2011-01-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (24, 2012, 1, '2012-01-24', '2012-01-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (24, 2013, 1, '2013-01-24', '2013-01-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (24, 2014, 1, '2014-01-24', '2014-01-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (24, 2015, 1, '2015-01-24', '2015-01-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (25, 2008, 1, '2008-01-25', '2008-01-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (25, 2009, 1, '2009-01-25', '2009-01-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (25, 2010, 1, '2010-01-25', '2010-01-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (25, 2011, 1, '2011-01-25', '2011-01-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (25, 2012, 1, '2012-01-25', '2012-01-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (25, 2013, 1, '2013-01-25', '2013-01-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (25, 2014, 1, '2014-01-25', '2014-01-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (25, 2015, 1, '2015-01-25', '2015-01-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (26, 2008, 1, '2008-01-26', '2008-01-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (26, 2009, 1, '2009-01-26', '2009-01-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (26, 2010, 1, '2010-01-26', '2010-01-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (26, 2011, 1, '2011-01-26', '2011-01-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (26, 2012, 1, '2012-01-26', '2012-01-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (26, 2013, 1, '2013-01-26', '2013-01-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (26, 2014, 1, '2014-01-26', '2014-01-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (26, 2015, 1, '2015-01-26', '2015-01-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (27, 2008, 1, '2008-01-27', '2008-01-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (27, 2009, 1, '2009-01-27', '2009-01-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (27, 2010, 1, '2010-01-27', '2010-01-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (27, 2011, 1, '2011-01-27', '2011-01-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (27, 2012, 1, '2012-01-27', '2012-01-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (27, 2013, 1, '2013-01-27', '2013-01-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (27, 2014, 1, '2014-01-27', '2014-01-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (27, 2015, 1, '2015-01-27', '2015-01-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (28, 2008, 1, '2008-01-28', '2008-01-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (28, 2009, 1, '2009-01-28', '2009-01-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (28, 2010, 1, '2010-01-28', '2010-01-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (28, 2011, 1, '2011-01-28', '2011-01-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (28, 2012, 1, '2012-01-28', '2012-01-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (28, 2013, 1, '2013-01-28', '2013-01-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (28, 2014, 1, '2014-01-28', '2014-01-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (28, 2015, 1, '2015-01-28', '2015-01-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (29, 2008, 1, '2008-01-29', '2008-01-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (29, 2009, 1, '2009-01-29', '2009-01-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (29, 2010, 1, '2010-01-29', '2010-01-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (29, 2011, 1, '2011-01-29', '2011-01-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (29, 2012, 1, '2012-01-29', '2012-01-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (29, 2013, 1, '2013-01-29', '2013-01-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (29, 2014, 1, '2014-01-29', '2014-01-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (29, 2015, 1, '2015-01-29', '2015-01-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (30, 2008, 1, '2008-01-30', '2008-01-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (30, 2009, 1, '2009-01-30', '2009-01-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (30, 2010, 1, '2010-01-30', '2010-01-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (30, 2011, 1, '2011-01-30', '2011-01-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (30, 2012, 1, '2012-01-30', '2012-01-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (30, 2013, 1, '2013-01-30', '2013-01-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (30, 2014, 1, '2014-01-30', '2014-01-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (30, 2015, 1, '2015-01-30', '2015-01-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (31, 2008, 1, '2008-01-31', '2008-01-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (31, 2009, 1, '2009-01-31', '2009-01-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (31, 2010, 1, '2010-01-31', '2010-01-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (31, 2011, 1, '2011-01-31', '2011-01-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (31, 2012, 1, '2012-01-31', '2012-01-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (31, 2013, 1, '2013-01-31', '2013-01-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (31, 2014, 1, '2014-01-31', '2014-01-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (31, 2015, 1, '2015-01-31', '2015-01-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (32, 2008, 1, '2008-02-01', '2008-02-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (32, 2009, 1, '2009-02-01', '2009-02-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (32, 2010, 1, '2010-02-01', '2010-02-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (32, 2011, 1, '2011-02-01', '2011-02-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (32, 2012, 1, '2012-02-01', '2012-02-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (32, 2013, 1, '2013-02-01', '2013-02-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (32, 2014, 1, '2014-02-01', '2014-02-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (32, 2015, 1, '2015-02-01', '2015-02-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (33, 2008, 1, '2008-02-02', '2008-02-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (33, 2009, 1, '2009-02-02', '2009-02-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (33, 2010, 1, '2010-02-02', '2010-02-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (33, 2011, 1, '2011-02-02', '2011-02-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (33, 2012, 1, '2012-02-02', '2012-02-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (33, 2013, 1, '2013-02-02', '2013-02-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (33, 2014, 1, '2014-02-02', '2014-02-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (33, 2015, 1, '2015-02-02', '2015-02-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (34, 2008, 1, '2008-02-03', '2008-02-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (34, 2009, 1, '2009-02-03', '2009-02-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (34, 2010, 1, '2010-02-03', '2010-02-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (34, 2011, 1, '2011-02-03', '2011-02-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (34, 2012, 1, '2012-02-03', '2012-02-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (34, 2013, 1, '2013-02-03', '2013-02-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (34, 2014, 1, '2014-02-03', '2014-02-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (34, 2015, 1, '2015-02-03', '2015-02-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (35, 2008, 1, '2008-02-04', '2008-02-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (35, 2009, 1, '2009-02-04', '2009-02-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (35, 2010, 1, '2010-02-04', '2010-02-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (35, 2011, 1, '2011-02-04', '2011-02-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (35, 2012, 1, '2012-02-04', '2012-02-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (35, 2013, 1, '2013-02-04', '2013-02-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (35, 2014, 1, '2014-02-04', '2014-02-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (35, 2015, 1, '2015-02-04', '2015-02-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (36, 2008, 1, '2008-02-05', '2008-02-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (36, 2009, 1, '2009-02-05', '2009-02-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (36, 2010, 1, '2010-02-05', '2010-02-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (36, 2011, 1, '2011-02-05', '2011-02-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (36, 2012, 1, '2012-02-05', '2012-02-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (36, 2013, 1, '2013-02-05', '2013-02-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (36, 2014, 1, '2014-02-05', '2014-02-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (36, 2015, 1, '2015-02-05', '2015-02-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (37, 2008, 1, '2008-02-06', '2008-02-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (37, 2009, 1, '2009-02-06', '2009-02-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (37, 2010, 1, '2010-02-06', '2010-02-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (37, 2011, 1, '2011-02-06', '2011-02-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (37, 2012, 1, '2012-02-06', '2012-02-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (37, 2013, 1, '2013-02-06', '2013-02-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (37, 2014, 1, '2014-02-06', '2014-02-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (37, 2015, 1, '2015-02-06', '2015-02-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (38, 2008, 1, '2008-02-07', '2008-02-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (38, 2009, 1, '2009-02-07', '2009-02-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (38, 2010, 1, '2010-02-07', '2010-02-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (38, 2011, 1, '2011-02-07', '2011-02-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (38, 2012, 1, '2012-02-07', '2012-02-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (38, 2013, 1, '2013-02-07', '2013-02-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (38, 2014, 1, '2014-02-07', '2014-02-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (38, 2015, 1, '2015-02-07', '2015-02-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (39, 2008, 1, '2008-02-08', '2008-02-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (39, 2009, 1, '2009-02-08', '2009-02-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (39, 2010, 1, '2010-02-08', '2010-02-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (39, 2011, 1, '2011-02-08', '2011-02-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (39, 2012, 1, '2012-02-08', '2012-02-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (39, 2013, 1, '2013-02-08', '2013-02-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (39, 2014, 1, '2014-02-08', '2014-02-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (39, 2015, 1, '2015-02-08', '2015-02-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (40, 2008, 1, '2008-02-09', '2008-02-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (40, 2009, 1, '2009-02-09', '2009-02-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (40, 2010, 1, '2010-02-09', '2010-02-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (40, 2011, 1, '2011-02-09', '2011-02-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (40, 2012, 1, '2012-02-09', '2012-02-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (40, 2013, 1, '2013-02-09', '2013-02-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (40, 2014, 1, '2014-02-09', '2014-02-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (40, 2015, 1, '2015-02-09', '2015-02-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (41, 2008, 1, '2008-02-10', '2008-02-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (41, 2009, 1, '2009-02-10', '2009-02-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (41, 2010, 1, '2010-02-10', '2010-02-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (41, 2011, 1, '2011-02-10', '2011-02-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (41, 2012, 1, '2012-02-10', '2012-02-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (41, 2013, 1, '2013-02-10', '2013-02-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (41, 2014, 1, '2014-02-10', '2014-02-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (41, 2015, 1, '2015-02-10', '2015-02-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (42, 2008, 1, '2008-02-11', '2008-02-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (42, 2009, 1, '2009-02-11', '2009-02-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (42, 2010, 1, '2010-02-11', '2010-02-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (42, 2011, 1, '2011-02-11', '2011-02-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (42, 2012, 1, '2012-02-11', '2012-02-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (42, 2013, 1, '2013-02-11', '2013-02-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (42, 2014, 1, '2014-02-11', '2014-02-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (42, 2015, 1, '2015-02-11', '2015-02-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (43, 2008, 1, '2008-02-12', '2008-02-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (43, 2009, 1, '2009-02-12', '2009-02-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (43, 2010, 1, '2010-02-12', '2010-02-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (43, 2011, 1, '2011-02-12', '2011-02-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (43, 2012, 1, '2012-02-12', '2012-02-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (43, 2013, 1, '2013-02-12', '2013-02-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (43, 2014, 1, '2014-02-12', '2014-02-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (43, 2015, 1, '2015-02-12', '2015-02-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (44, 2008, 1, '2008-02-13', '2008-02-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (44, 2009, 1, '2009-02-13', '2009-02-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (44, 2010, 1, '2010-02-13', '2010-02-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (44, 2011, 1, '2011-02-13', '2011-02-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (44, 2012, 1, '2012-02-13', '2012-02-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (44, 2013, 1, '2013-02-13', '2013-02-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (44, 2014, 1, '2014-02-13', '2014-02-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (44, 2015, 1, '2015-02-13', '2015-02-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (45, 2008, 1, '2008-02-14', '2008-02-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (45, 2009, 1, '2009-02-14', '2009-02-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (45, 2010, 1, '2010-02-14', '2010-02-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (45, 2011, 1, '2011-02-14', '2011-02-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (45, 2012, 1, '2012-02-14', '2012-02-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (45, 2013, 1, '2013-02-14', '2013-02-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (45, 2014, 1, '2014-02-14', '2014-02-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (45, 2015, 1, '2015-02-14', '2015-02-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (46, 2008, 1, '2008-02-15', '2008-02-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (46, 2009, 1, '2009-02-15', '2009-02-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (46, 2010, 1, '2010-02-15', '2010-02-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (46, 2011, 1, '2011-02-15', '2011-02-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (46, 2012, 1, '2012-02-15', '2012-02-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (46, 2013, 1, '2013-02-15', '2013-02-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (46, 2014, 1, '2014-02-15', '2014-02-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (46, 2015, 1, '2015-02-15', '2015-02-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (47, 2008, 1, '2008-02-16', '2008-02-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (47, 2009, 1, '2009-02-16', '2009-02-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (47, 2010, 1, '2010-02-16', '2010-02-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (47, 2011, 1, '2011-02-16', '2011-02-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (47, 2012, 1, '2012-02-16', '2012-02-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (47, 2013, 1, '2013-02-16', '2013-02-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (47, 2014, 1, '2014-02-16', '2014-02-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (47, 2015, 1, '2015-02-16', '2015-02-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (48, 2008, 1, '2008-02-17', '2008-02-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (48, 2009, 1, '2009-02-17', '2009-02-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (48, 2010, 1, '2010-02-17', '2010-02-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (48, 2011, 1, '2011-02-17', '2011-02-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (48, 2012, 1, '2012-02-17', '2012-02-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (48, 2013, 1, '2013-02-17', '2013-02-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (48, 2014, 1, '2014-02-17', '2014-02-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (48, 2015, 1, '2015-02-17', '2015-02-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (49, 2008, 1, '2008-02-18', '2008-02-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (49, 2009, 1, '2009-02-18', '2009-02-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (49, 2010, 1, '2010-02-18', '2010-02-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (49, 2011, 1, '2011-02-18', '2011-02-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (49, 2012, 1, '2012-02-18', '2012-02-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (49, 2013, 1, '2013-02-18', '2013-02-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (49, 2014, 1, '2014-02-18', '2014-02-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (49, 2015, 1, '2015-02-18', '2015-02-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (50, 2008, 1, '2008-02-19', '2008-02-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (50, 2009, 1, '2009-02-19', '2009-02-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (50, 2010, 1, '2010-02-19', '2010-02-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (50, 2011, 1, '2011-02-19', '2011-02-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (50, 2012, 1, '2012-02-19', '2012-02-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (50, 2013, 1, '2013-02-19', '2013-02-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (50, 2014, 1, '2014-02-19', '2014-02-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (50, 2015, 1, '2015-02-19', '2015-02-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (51, 2008, 1, '2008-02-20', '2008-02-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (51, 2009, 1, '2009-02-20', '2009-02-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (51, 2010, 1, '2010-02-20', '2010-02-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (51, 2011, 1, '2011-02-20', '2011-02-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (51, 2012, 1, '2012-02-20', '2012-02-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (51, 2013, 1, '2013-02-20', '2013-02-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (51, 2014, 1, '2014-02-20', '2014-02-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (51, 2015, 1, '2015-02-20', '2015-02-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (52, 2008, 1, '2008-02-21', '2008-02-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (52, 2009, 1, '2009-02-21', '2009-02-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (52, 2010, 1, '2010-02-21', '2010-02-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (52, 2011, 1, '2011-02-21', '2011-02-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (52, 2012, 1, '2012-02-21', '2012-02-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (52, 2013, 1, '2013-02-21', '2013-02-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (52, 2014, 1, '2014-02-21', '2014-02-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (52, 2015, 1, '2015-02-21', '2015-02-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (53, 2008, 1, '2008-02-22', '2008-02-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (53, 2009, 1, '2009-02-22', '2009-02-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (53, 2010, 1, '2010-02-22', '2010-02-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (53, 2011, 1, '2011-02-22', '2011-02-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (53, 2012, 1, '2012-02-22', '2012-02-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (53, 2013, 1, '2013-02-22', '2013-02-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (53, 2014, 1, '2014-02-22', '2014-02-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (53, 2015, 1, '2015-02-22', '2015-02-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (54, 2008, 1, '2008-02-23', '2008-02-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (54, 2009, 1, '2009-02-23', '2009-02-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (54, 2010, 1, '2010-02-23', '2010-02-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (54, 2011, 1, '2011-02-23', '2011-02-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (54, 2012, 1, '2012-02-23', '2012-02-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (54, 2013, 1, '2013-02-23', '2013-02-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (54, 2014, 1, '2014-02-23', '2014-02-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (54, 2015, 1, '2015-02-23', '2015-02-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (55, 2008, 1, '2008-02-24', '2008-02-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (55, 2009, 1, '2009-02-24', '2009-02-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (55, 2010, 1, '2010-02-24', '2010-02-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (55, 2011, 1, '2011-02-24', '2011-02-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (55, 2012, 1, '2012-02-24', '2012-02-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (55, 2013, 1, '2013-02-24', '2013-02-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (55, 2014, 1, '2014-02-24', '2014-02-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (55, 2015, 1, '2015-02-24', '2015-02-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (56, 2008, 1, '2008-02-25', '2008-02-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (56, 2009, 1, '2009-02-25', '2009-02-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (56, 2010, 1, '2010-02-25', '2010-02-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (56, 2011, 1, '2011-02-25', '2011-02-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (56, 2012, 1, '2012-02-25', '2012-02-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (56, 2013, 1, '2013-02-25', '2013-02-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (56, 2014, 1, '2014-02-25', '2014-02-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (56, 2015, 1, '2015-02-25', '2015-02-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (57, 2008, 1, '2008-02-26', '2008-02-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (57, 2009, 1, '2009-02-26', '2009-02-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (57, 2010, 1, '2010-02-26', '2010-02-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (57, 2011, 1, '2011-02-26', '2011-02-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (57, 2012, 1, '2012-02-26', '2012-02-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (57, 2013, 1, '2013-02-26', '2013-02-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (57, 2014, 1, '2014-02-26', '2014-02-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (57, 2015, 1, '2015-02-26', '2015-02-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (58, 2008, 1, '2008-02-27', '2008-02-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (58, 2009, 1, '2009-02-27', '2009-02-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (58, 2010, 1, '2010-02-27', '2010-02-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (58, 2011, 1, '2011-02-27', '2011-02-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (58, 2012, 1, '2012-02-27', '2012-02-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (58, 2013, 1, '2013-02-27', '2013-02-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (58, 2014, 1, '2014-02-27', '2014-02-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (58, 2015, 1, '2015-02-27', '2015-02-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (59, 2008, 1, '2008-02-28', '2008-02-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (59, 2009, 1, '2009-02-28', '2009-02-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (59, 2010, 1, '2010-02-28', '2010-02-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (59, 2011, 1, '2011-02-28', '2011-02-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (59, 2012, 1, '2012-02-28', '2012-02-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (59, 2013, 1, '2013-02-28', '2013-02-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (59, 2014, 1, '2014-02-28', '2014-02-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (59, 2015, 1, '2015-02-28', '2015-02-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (60, 2008, 1, '2008-02-29', '2008-02-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (60, 2009, 1, '2009-03-01', '2009-03-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (60, 2010, 1, '2010-03-01', '2010-03-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (60, 2011, 1, '2011-03-01', '2011-03-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (60, 2012, 1, '2012-02-29', '2012-02-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (60, 2013, 1, '2013-03-01', '2013-03-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (60, 2014, 1, '2014-03-01', '2014-03-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (60, 2015, 1, '2015-03-01', '2015-03-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (61, 2008, 1, '2008-03-01', '2008-03-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (61, 2009, 1, '2009-03-02', '2009-03-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (61, 2010, 1, '2010-03-02', '2010-03-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (61, 2011, 1, '2011-03-02', '2011-03-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (61, 2012, 1, '2012-03-01', '2012-03-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (61, 2013, 1, '2013-03-02', '2013-03-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (61, 2014, 1, '2014-03-02', '2014-03-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (61, 2015, 1, '2015-03-02', '2015-03-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (62, 2008, 1, '2008-03-02', '2008-03-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (62, 2009, 1, '2009-03-03', '2009-03-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (62, 2010, 1, '2010-03-03', '2010-03-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (62, 2011, 1, '2011-03-03', '2011-03-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (62, 2012, 1, '2012-03-02', '2012-03-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (62, 2013, 1, '2013-03-03', '2013-03-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (62, 2014, 1, '2014-03-03', '2014-03-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (62, 2015, 1, '2015-03-03', '2015-03-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (63, 2008, 1, '2008-03-03', '2008-03-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (63, 2009, 1, '2009-03-04', '2009-03-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (63, 2010, 1, '2010-03-04', '2010-03-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (63, 2011, 1, '2011-03-04', '2011-03-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (63, 2012, 1, '2012-03-03', '2012-03-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (63, 2013, 1, '2013-03-04', '2013-03-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (63, 2014, 1, '2014-03-04', '2014-03-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (63, 2015, 1, '2015-03-04', '2015-03-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (64, 2008, 1, '2008-03-04', '2008-03-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (64, 2009, 1, '2009-03-05', '2009-03-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (64, 2010, 1, '2010-03-05', '2010-03-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (64, 2011, 1, '2011-03-05', '2011-03-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (64, 2012, 1, '2012-03-04', '2012-03-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (64, 2013, 1, '2013-03-05', '2013-03-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (64, 2014, 1, '2014-03-05', '2014-03-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (64, 2015, 1, '2015-03-05', '2015-03-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (65, 2008, 1, '2008-03-05', '2008-03-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (65, 2009, 1, '2009-03-06', '2009-03-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (65, 2010, 1, '2010-03-06', '2010-03-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (65, 2011, 1, '2011-03-06', '2011-03-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (65, 2012, 1, '2012-03-05', '2012-03-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (65, 2013, 1, '2013-03-06', '2013-03-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (65, 2014, 1, '2014-03-06', '2014-03-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (65, 2015, 1, '2015-03-06', '2015-03-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (66, 2008, 1, '2008-03-06', '2008-03-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (66, 2009, 1, '2009-03-07', '2009-03-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (66, 2010, 1, '2010-03-07', '2010-03-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (66, 2011, 1, '2011-03-07', '2011-03-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (66, 2012, 1, '2012-03-06', '2012-03-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (66, 2013, 1, '2013-03-07', '2013-03-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (66, 2014, 1, '2014-03-07', '2014-03-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (66, 2015, 1, '2015-03-07', '2015-03-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (67, 2008, 1, '2008-03-07', '2008-03-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (67, 2009, 1, '2009-03-08', '2009-03-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (67, 2010, 1, '2010-03-08', '2010-03-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (67, 2011, 1, '2011-03-08', '2011-03-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (67, 2012, 1, '2012-03-07', '2012-03-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (67, 2013, 1, '2013-03-08', '2013-03-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (67, 2014, 1, '2014-03-08', '2014-03-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (67, 2015, 1, '2015-03-08', '2015-03-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (68, 2008, 1, '2008-03-08', '2008-03-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (68, 2009, 1, '2009-03-09', '2009-03-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (68, 2010, 1, '2010-03-09', '2010-03-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (68, 2011, 1, '2011-03-09', '2011-03-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (68, 2012, 1, '2012-03-08', '2012-03-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (68, 2013, 1, '2013-03-09', '2013-03-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (68, 2014, 1, '2014-03-09', '2014-03-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (68, 2015, 1, '2015-03-09', '2015-03-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (69, 2008, 1, '2008-03-09', '2008-03-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (69, 2009, 1, '2009-03-10', '2009-03-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (69, 2010, 1, '2010-03-10', '2010-03-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (69, 2011, 1, '2011-03-10', '2011-03-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (69, 2012, 1, '2012-03-09', '2012-03-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (69, 2013, 1, '2013-03-10', '2013-03-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (69, 2014, 1, '2014-03-10', '2014-03-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (69, 2015, 1, '2015-03-10', '2015-03-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (70, 2008, 1, '2008-03-10', '2008-03-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (70, 2009, 1, '2009-03-11', '2009-03-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (70, 2010, 1, '2010-03-11', '2010-03-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (70, 2011, 1, '2011-03-11', '2011-03-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (70, 2012, 1, '2012-03-10', '2012-03-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (70, 2013, 1, '2013-03-11', '2013-03-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (70, 2014, 1, '2014-03-11', '2014-03-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (70, 2015, 1, '2015-03-11', '2015-03-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (71, 2008, 1, '2008-03-11', '2008-03-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (71, 2009, 1, '2009-03-12', '2009-03-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (71, 2010, 1, '2010-03-12', '2010-03-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (71, 2011, 1, '2011-03-12', '2011-03-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (71, 2012, 1, '2012-03-11', '2012-03-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (71, 2013, 1, '2013-03-12', '2013-03-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (71, 2014, 1, '2014-03-12', '2014-03-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (71, 2015, 1, '2015-03-12', '2015-03-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (72, 2008, 1, '2008-03-12', '2008-03-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (72, 2009, 1, '2009-03-13', '2009-03-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (72, 2010, 1, '2010-03-13', '2010-03-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (72, 2011, 1, '2011-03-13', '2011-03-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (72, 2012, 1, '2012-03-12', '2012-03-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (72, 2013, 1, '2013-03-13', '2013-03-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (72, 2014, 1, '2014-03-13', '2014-03-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (72, 2015, 1, '2015-03-13', '2015-03-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (73, 2008, 1, '2008-03-13', '2008-03-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (73, 2009, 1, '2009-03-14', '2009-03-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (73, 2010, 1, '2010-03-14', '2010-03-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (73, 2011, 1, '2011-03-14', '2011-03-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (73, 2012, 1, '2012-03-13', '2012-03-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (73, 2013, 1, '2013-03-14', '2013-03-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (73, 2014, 1, '2014-03-14', '2014-03-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (73, 2015, 1, '2015-03-14', '2015-03-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (74, 2008, 1, '2008-03-14', '2008-03-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (74, 2009, 1, '2009-03-15', '2009-03-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (74, 2010, 1, '2010-03-15', '2010-03-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (74, 2011, 1, '2011-03-15', '2011-03-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (74, 2012, 1, '2012-03-14', '2012-03-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (74, 2013, 1, '2013-03-15', '2013-03-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (74, 2014, 1, '2014-03-15', '2014-03-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (74, 2015, 1, '2015-03-15', '2015-03-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (75, 2008, 1, '2008-03-15', '2008-03-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (75, 2009, 1, '2009-03-16', '2009-03-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (75, 2010, 1, '2010-03-16', '2010-03-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (75, 2011, 1, '2011-03-16', '2011-03-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (75, 2012, 1, '2012-03-15', '2012-03-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (75, 2013, 1, '2013-03-16', '2013-03-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (75, 2014, 1, '2014-03-16', '2014-03-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (75, 2015, 1, '2015-03-16', '2015-03-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (76, 2008, 1, '2008-03-16', '2008-03-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (76, 2009, 1, '2009-03-17', '2009-03-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (76, 2010, 1, '2010-03-17', '2010-03-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (76, 2011, 1, '2011-03-17', '2011-03-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (76, 2012, 1, '2012-03-16', '2012-03-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (76, 2013, 1, '2013-03-17', '2013-03-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (76, 2014, 1, '2014-03-17', '2014-03-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (76, 2015, 1, '2015-03-17', '2015-03-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (77, 2008, 1, '2008-03-17', '2008-03-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (77, 2009, 1, '2009-03-18', '2009-03-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (77, 2010, 1, '2010-03-18', '2010-03-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (77, 2011, 1, '2011-03-18', '2011-03-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (77, 2012, 1, '2012-03-17', '2012-03-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (77, 2013, 1, '2013-03-18', '2013-03-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (77, 2014, 1, '2014-03-18', '2014-03-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (77, 2015, 1, '2015-03-18', '2015-03-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (78, 2008, 1, '2008-03-18', '2008-03-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (78, 2009, 1, '2009-03-19', '2009-03-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (78, 2010, 1, '2010-03-19', '2010-03-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (78, 2011, 1, '2011-03-19', '2011-03-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (78, 2012, 1, '2012-03-18', '2012-03-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (78, 2013, 1, '2013-03-19', '2013-03-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (78, 2014, 1, '2014-03-19', '2014-03-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (78, 2015, 1, '2015-03-19', '2015-03-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (79, 2008, 1, '2008-03-19', '2008-03-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (79, 2009, 1, '2009-03-20', '2009-03-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (79, 2010, 1, '2010-03-20', '2010-03-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (79, 2011, 1, '2011-03-20', '2011-03-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (79, 2012, 1, '2012-03-19', '2012-03-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (79, 2013, 1, '2013-03-20', '2013-03-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (79, 2014, 1, '2014-03-20', '2014-03-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (79, 2015, 1, '2015-03-20', '2015-03-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (80, 2008, 1, '2008-03-20', '2008-03-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (80, 2009, 1, '2009-03-21', '2009-03-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (80, 2010, 1, '2010-03-21', '2010-03-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (80, 2011, 1, '2011-03-21', '2011-03-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (80, 2012, 1, '2012-03-20', '2012-03-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (80, 2013, 1, '2013-03-21', '2013-03-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (80, 2014, 1, '2014-03-21', '2014-03-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (80, 2015, 1, '2015-03-21', '2015-03-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (81, 2008, 1, '2008-03-21', '2008-03-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (81, 2009, 1, '2009-03-22', '2009-03-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (81, 2010, 1, '2010-03-22', '2010-03-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (81, 2011, 1, '2011-03-22', '2011-03-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (81, 2012, 1, '2012-03-21', '2012-03-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (81, 2013, 1, '2013-03-22', '2013-03-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (81, 2014, 1, '2014-03-22', '2014-03-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (81, 2015, 1, '2015-03-22', '2015-03-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (82, 2008, 1, '2008-03-22', '2008-03-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (82, 2009, 1, '2009-03-23', '2009-03-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (82, 2010, 1, '2010-03-23', '2010-03-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (82, 2011, 1, '2011-03-23', '2011-03-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (82, 2012, 1, '2012-03-22', '2012-03-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (82, 2013, 1, '2013-03-23', '2013-03-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (82, 2014, 1, '2014-03-23', '2014-03-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (82, 2015, 1, '2015-03-23', '2015-03-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (83, 2008, 1, '2008-03-23', '2008-03-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (83, 2009, 1, '2009-03-24', '2009-03-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (83, 2010, 1, '2010-03-24', '2010-03-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (83, 2011, 1, '2011-03-24', '2011-03-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (83, 2012, 1, '2012-03-23', '2012-03-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (83, 2013, 1, '2013-03-24', '2013-03-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (83, 2014, 1, '2014-03-24', '2014-03-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (83, 2015, 1, '2015-03-24', '2015-03-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (84, 2008, 1, '2008-03-24', '2008-03-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (84, 2009, 1, '2009-03-25', '2009-03-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (84, 2010, 1, '2010-03-25', '2010-03-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (84, 2011, 1, '2011-03-25', '2011-03-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (84, 2012, 1, '2012-03-24', '2012-03-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (84, 2013, 1, '2013-03-25', '2013-03-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (84, 2014, 1, '2014-03-25', '2014-03-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (84, 2015, 1, '2015-03-25', '2015-03-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (85, 2008, 1, '2008-03-25', '2008-03-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (85, 2009, 1, '2009-03-26', '2009-03-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (85, 2010, 1, '2010-03-26', '2010-03-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (85, 2011, 1, '2011-03-26', '2011-03-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (85, 2012, 1, '2012-03-25', '2012-03-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (85, 2013, 1, '2013-03-26', '2013-03-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (85, 2014, 1, '2014-03-26', '2014-03-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (85, 2015, 1, '2015-03-26', '2015-03-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (86, 2008, 1, '2008-03-26', '2008-03-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (86, 2009, 1, '2009-03-27', '2009-03-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (86, 2010, 1, '2010-03-27', '2010-03-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (86, 2011, 1, '2011-03-27', '2011-03-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (86, 2012, 1, '2012-03-26', '2012-03-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (86, 2013, 1, '2013-03-27', '2013-03-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (86, 2014, 1, '2014-03-27', '2014-03-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (86, 2015, 1, '2015-03-27', '2015-03-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (87, 2008, 1, '2008-03-27', '2008-03-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (87, 2009, 1, '2009-03-28', '2009-03-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (87, 2010, 1, '2010-03-28', '2010-03-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (87, 2011, 1, '2011-03-28', '2011-03-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (87, 2012, 1, '2012-03-27', '2012-03-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (87, 2013, 1, '2013-03-28', '2013-03-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (87, 2014, 1, '2014-03-28', '2014-03-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (87, 2015, 1, '2015-03-28', '2015-03-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (88, 2008, 1, '2008-03-28', '2008-03-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (88, 2009, 1, '2009-03-29', '2009-03-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (88, 2010, 1, '2010-03-29', '2010-03-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (88, 2011, 1, '2011-03-29', '2011-03-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (88, 2012, 1, '2012-03-28', '2012-03-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (88, 2013, 1, '2013-03-29', '2013-03-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (88, 2014, 1, '2014-03-29', '2014-03-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (88, 2015, 1, '2015-03-29', '2015-03-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (89, 2008, 1, '2008-03-29', '2008-03-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (89, 2009, 1, '2009-03-30', '2009-03-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (89, 2010, 1, '2010-03-30', '2010-03-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (89, 2011, 1, '2011-03-30', '2011-03-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (89, 2012, 1, '2012-03-29', '2012-03-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (89, 2013, 1, '2013-03-30', '2013-03-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (89, 2014, 1, '2014-03-30', '2014-03-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (89, 2015, 1, '2015-03-30', '2015-03-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (90, 2008, 1, '2008-03-30', '2008-03-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (90, 2009, 1, '2009-03-31', '2009-03-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (90, 2010, 1, '2010-03-31', '2010-03-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (90, 2011, 1, '2011-03-31', '2011-03-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (90, 2012, 1, '2012-03-30', '2012-03-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (90, 2013, 1, '2013-03-31', '2013-03-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (90, 2014, 1, '2014-03-31', '2014-03-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (90, 2015, 1, '2015-03-31', '2015-03-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (91, 2008, 1, '2008-03-31', '2008-03-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (91, 2009, 1, '2009-04-01', '2009-04-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (91, 2010, 1, '2010-04-01', '2010-04-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (91, 2011, 1, '2011-04-01', '2011-04-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (91, 2012, 1, '2012-03-31', '2012-03-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (91, 2013, 1, '2013-04-01', '2013-04-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (91, 2014, 1, '2014-04-01', '2014-04-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (91, 2015, 1, '2015-04-01', '2015-04-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (92, 2008, 1, '2008-04-01', '2008-04-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (92, 2009, 1, '2009-04-02', '2009-04-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (92, 2010, 1, '2010-04-02', '2010-04-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (92, 2011, 1, '2011-04-02', '2011-04-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (92, 2012, 1, '2012-04-01', '2012-04-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (92, 2013, 1, '2013-04-02', '2013-04-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (92, 2014, 1, '2014-04-02', '2014-04-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (92, 2015, 1, '2015-04-02', '2015-04-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (93, 2008, 1, '2008-04-02', '2008-04-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (93, 2009, 1, '2009-04-03', '2009-04-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (93, 2010, 1, '2010-04-03', '2010-04-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (93, 2011, 1, '2011-04-03', '2011-04-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (93, 2012, 1, '2012-04-02', '2012-04-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (93, 2013, 1, '2013-04-03', '2013-04-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (93, 2014, 1, '2014-04-03', '2014-04-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (93, 2015, 1, '2015-04-03', '2015-04-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (94, 2008, 1, '2008-04-03', '2008-04-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (94, 2009, 1, '2009-04-04', '2009-04-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (94, 2010, 1, '2010-04-04', '2010-04-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (94, 2011, 1, '2011-04-04', '2011-04-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (94, 2012, 1, '2012-04-03', '2012-04-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (94, 2013, 1, '2013-04-04', '2013-04-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (94, 2014, 1, '2014-04-04', '2014-04-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (94, 2015, 1, '2015-04-04', '2015-04-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (95, 2008, 1, '2008-04-04', '2008-04-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (95, 2009, 1, '2009-04-05', '2009-04-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (95, 2010, 1, '2010-04-05', '2010-04-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (95, 2011, 1, '2011-04-05', '2011-04-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (95, 2012, 1, '2012-04-04', '2012-04-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (95, 2013, 1, '2013-04-05', '2013-04-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (95, 2014, 1, '2014-04-05', '2014-04-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (95, 2015, 1, '2015-04-05', '2015-04-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (96, 2008, 1, '2008-04-05', '2008-04-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (96, 2009, 1, '2009-04-06', '2009-04-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (96, 2010, 1, '2010-04-06', '2010-04-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (96, 2011, 1, '2011-04-06', '2011-04-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (96, 2012, 1, '2012-04-05', '2012-04-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (96, 2013, 1, '2013-04-06', '2013-04-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (96, 2014, 1, '2014-04-06', '2014-04-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (96, 2015, 1, '2015-04-06', '2015-04-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (97, 2008, 1, '2008-04-06', '2008-04-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (97, 2009, 1, '2009-04-07', '2009-04-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (97, 2010, 1, '2010-04-07', '2010-04-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (97, 2011, 1, '2011-04-07', '2011-04-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (97, 2012, 1, '2012-04-06', '2012-04-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (97, 2013, 1, '2013-04-07', '2013-04-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (97, 2014, 1, '2014-04-07', '2014-04-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (97, 2015, 1, '2015-04-07', '2015-04-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (98, 2008, 1, '2008-04-07', '2008-04-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (98, 2009, 1, '2009-04-08', '2009-04-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (98, 2010, 1, '2010-04-08', '2010-04-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (98, 2011, 1, '2011-04-08', '2011-04-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (98, 2012, 1, '2012-04-07', '2012-04-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (98, 2013, 1, '2013-04-08', '2013-04-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (98, 2014, 1, '2014-04-08', '2014-04-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (98, 2015, 1, '2015-04-08', '2015-04-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (99, 2008, 1, '2008-04-08', '2008-04-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (99, 2009, 1, '2009-04-09', '2009-04-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (99, 2010, 1, '2010-04-09', '2010-04-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (99, 2011, 1, '2011-04-09', '2011-04-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (99, 2012, 1, '2012-04-08', '2012-04-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (99, 2013, 1, '2013-04-09', '2013-04-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (99, 2014, 1, '2014-04-09', '2014-04-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (99, 2015, 1, '2015-04-09', '2015-04-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (100, 2008, 1, '2008-04-09', '2008-04-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (100, 2009, 1, '2009-04-10', '2009-04-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (100, 2010, 1, '2010-04-10', '2010-04-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (100, 2011, 1, '2011-04-10', '2011-04-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (100, 2012, 1, '2012-04-09', '2012-04-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (100, 2013, 1, '2013-04-10', '2013-04-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (100, 2014, 1, '2014-04-10', '2014-04-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (100, 2015, 1, '2015-04-10', '2015-04-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (101, 2008, 1, '2008-04-10', '2008-04-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (101, 2009, 1, '2009-04-11', '2009-04-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (101, 2010, 1, '2010-04-11', '2010-04-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (101, 2011, 1, '2011-04-11', '2011-04-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (101, 2012, 1, '2012-04-10', '2012-04-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (101, 2013, 1, '2013-04-11', '2013-04-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (101, 2014, 1, '2014-04-11', '2014-04-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (101, 2015, 1, '2015-04-11', '2015-04-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (102, 2008, 1, '2008-04-11', '2008-04-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (102, 2009, 1, '2009-04-12', '2009-04-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (102, 2010, 1, '2010-04-12', '2010-04-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (102, 2011, 1, '2011-04-12', '2011-04-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (102, 2012, 1, '2012-04-11', '2012-04-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (102, 2013, 1, '2013-04-12', '2013-04-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (102, 2014, 1, '2014-04-12', '2014-04-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (102, 2015, 1, '2015-04-12', '2015-04-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (103, 2008, 1, '2008-04-12', '2008-04-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (103, 2009, 1, '2009-04-13', '2009-04-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (103, 2010, 1, '2010-04-13', '2010-04-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (103, 2011, 1, '2011-04-13', '2011-04-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (103, 2012, 1, '2012-04-12', '2012-04-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (103, 2013, 1, '2013-04-13', '2013-04-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (103, 2014, 1, '2014-04-13', '2014-04-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (103, 2015, 1, '2015-04-13', '2015-04-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (104, 2008, 1, '2008-04-13', '2008-04-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (104, 2009, 1, '2009-04-14', '2009-04-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (104, 2010, 1, '2010-04-14', '2010-04-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (104, 2011, 1, '2011-04-14', '2011-04-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (104, 2012, 1, '2012-04-13', '2012-04-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (104, 2013, 1, '2013-04-14', '2013-04-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (104, 2014, 1, '2014-04-14', '2014-04-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (104, 2015, 1, '2015-04-14', '2015-04-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (105, 2008, 1, '2008-04-14', '2008-04-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (105, 2009, 1, '2009-04-15', '2009-04-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (105, 2010, 1, '2010-04-15', '2010-04-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (105, 2011, 1, '2011-04-15', '2011-04-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (105, 2012, 1, '2012-04-14', '2012-04-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (105, 2013, 1, '2013-04-15', '2013-04-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (105, 2014, 1, '2014-04-15', '2014-04-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (105, 2015, 1, '2015-04-15', '2015-04-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (106, 2008, 1, '2008-04-15', '2008-04-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (106, 2009, 1, '2009-04-16', '2009-04-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (106, 2010, 1, '2010-04-16', '2010-04-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (106, 2011, 1, '2011-04-16', '2011-04-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (106, 2012, 1, '2012-04-15', '2012-04-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (106, 2013, 1, '2013-04-16', '2013-04-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (106, 2014, 1, '2014-04-16', '2014-04-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (106, 2015, 1, '2015-04-16', '2015-04-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (107, 2008, 1, '2008-04-16', '2008-04-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (107, 2009, 1, '2009-04-17', '2009-04-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (107, 2010, 1, '2010-04-17', '2010-04-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (107, 2011, 1, '2011-04-17', '2011-04-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (107, 2012, 1, '2012-04-16', '2012-04-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (107, 2013, 1, '2013-04-17', '2013-04-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (107, 2014, 1, '2014-04-17', '2014-04-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (107, 2015, 1, '2015-04-17', '2015-04-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (108, 2008, 1, '2008-04-17', '2008-04-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (108, 2009, 1, '2009-04-18', '2009-04-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (108, 2010, 1, '2010-04-18', '2010-04-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (108, 2011, 1, '2011-04-18', '2011-04-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (108, 2012, 1, '2012-04-17', '2012-04-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (108, 2013, 1, '2013-04-18', '2013-04-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (108, 2014, 1, '2014-04-18', '2014-04-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (108, 2015, 1, '2015-04-18', '2015-04-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (109, 2008, 1, '2008-04-18', '2008-04-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (109, 2009, 1, '2009-04-19', '2009-04-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (109, 2010, 1, '2010-04-19', '2010-04-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (109, 2011, 1, '2011-04-19', '2011-04-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (109, 2012, 1, '2012-04-18', '2012-04-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (109, 2013, 1, '2013-04-19', '2013-04-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (109, 2014, 1, '2014-04-19', '2014-04-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (109, 2015, 1, '2015-04-19', '2015-04-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (110, 2008, 1, '2008-04-19', '2008-04-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (110, 2009, 1, '2009-04-20', '2009-04-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (110, 2010, 1, '2010-04-20', '2010-04-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (110, 2011, 1, '2011-04-20', '2011-04-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (110, 2012, 1, '2012-04-19', '2012-04-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (110, 2013, 1, '2013-04-20', '2013-04-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (110, 2014, 1, '2014-04-20', '2014-04-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (110, 2015, 1, '2015-04-20', '2015-04-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (111, 2008, 1, '2008-04-20', '2008-04-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (111, 2009, 1, '2009-04-21', '2009-04-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (111, 2010, 1, '2010-04-21', '2010-04-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (111, 2011, 1, '2011-04-21', '2011-04-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (111, 2012, 1, '2012-04-20', '2012-04-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (111, 2013, 1, '2013-04-21', '2013-04-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (111, 2014, 1, '2014-04-21', '2014-04-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (111, 2015, 1, '2015-04-21', '2015-04-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (112, 2008, 1, '2008-04-21', '2008-04-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (112, 2009, 1, '2009-04-22', '2009-04-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (112, 2010, 1, '2010-04-22', '2010-04-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (112, 2011, 1, '2011-04-22', '2011-04-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (112, 2012, 1, '2012-04-21', '2012-04-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (112, 2013, 1, '2013-04-22', '2013-04-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (112, 2014, 1, '2014-04-22', '2014-04-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (112, 2015, 1, '2015-04-22', '2015-04-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (113, 2008, 1, '2008-04-22', '2008-04-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (113, 2009, 1, '2009-04-23', '2009-04-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (113, 2010, 1, '2010-04-23', '2010-04-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (113, 2011, 1, '2011-04-23', '2011-04-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (113, 2012, 1, '2012-04-22', '2012-04-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (113, 2013, 1, '2013-04-23', '2013-04-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (113, 2014, 1, '2014-04-23', '2014-04-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (113, 2015, 1, '2015-04-23', '2015-04-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (114, 2008, 1, '2008-04-23', '2008-04-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (114, 2009, 1, '2009-04-24', '2009-04-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (114, 2010, 1, '2010-04-24', '2010-04-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (114, 2011, 1, '2011-04-24', '2011-04-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (114, 2012, 1, '2012-04-23', '2012-04-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (114, 2013, 1, '2013-04-24', '2013-04-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (114, 2014, 1, '2014-04-24', '2014-04-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (114, 2015, 1, '2015-04-24', '2015-04-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (115, 2008, 1, '2008-04-24', '2008-04-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (115, 2009, 1, '2009-04-25', '2009-04-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (115, 2010, 1, '2010-04-25', '2010-04-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (115, 2011, 1, '2011-04-25', '2011-04-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (115, 2012, 1, '2012-04-24', '2012-04-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (115, 2013, 1, '2013-04-25', '2013-04-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (115, 2014, 1, '2014-04-25', '2014-04-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (115, 2015, 1, '2015-04-25', '2015-04-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (116, 2008, 1, '2008-04-25', '2008-04-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (116, 2009, 1, '2009-04-26', '2009-04-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (116, 2010, 1, '2010-04-26', '2010-04-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (116, 2011, 1, '2011-04-26', '2011-04-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (116, 2012, 1, '2012-04-25', '2012-04-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (116, 2013, 1, '2013-04-26', '2013-04-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (116, 2014, 1, '2014-04-26', '2014-04-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (116, 2015, 1, '2015-04-26', '2015-04-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (117, 2008, 1, '2008-04-26', '2008-04-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (117, 2009, 1, '2009-04-27', '2009-04-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (117, 2010, 1, '2010-04-27', '2010-04-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (117, 2011, 1, '2011-04-27', '2011-04-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (117, 2012, 1, '2012-04-26', '2012-04-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (117, 2013, 1, '2013-04-27', '2013-04-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (117, 2014, 1, '2014-04-27', '2014-04-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (117, 2015, 1, '2015-04-27', '2015-04-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (118, 2008, 1, '2008-04-27', '2008-04-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (118, 2009, 1, '2009-04-28', '2009-04-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (118, 2010, 1, '2010-04-28', '2010-04-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (118, 2011, 1, '2011-04-28', '2011-04-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (118, 2012, 1, '2012-04-27', '2012-04-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (118, 2013, 1, '2013-04-28', '2013-04-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (118, 2014, 1, '2014-04-28', '2014-04-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (118, 2015, 1, '2015-04-28', '2015-04-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (119, 2008, 1, '2008-04-28', '2008-04-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (119, 2009, 1, '2009-04-29', '2009-04-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (119, 2010, 1, '2010-04-29', '2010-04-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (119, 2011, 1, '2011-04-29', '2011-04-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (119, 2012, 1, '2012-04-28', '2012-04-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (119, 2013, 1, '2013-04-29', '2013-04-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (119, 2014, 1, '2014-04-29', '2014-04-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (119, 2015, 1, '2015-04-29', '2015-04-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (120, 2008, 1, '2008-04-29', '2008-04-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (120, 2009, 1, '2009-04-30', '2009-04-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (120, 2010, 1, '2010-04-30', '2010-04-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (120, 2011, 1, '2011-04-30', '2011-04-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (120, 2012, 1, '2012-04-29', '2012-04-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (120, 2013, 1, '2013-04-30', '2013-04-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (120, 2014, 1, '2014-04-30', '2014-04-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (120, 2015, 1, '2015-04-30', '2015-04-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (121, 2008, 1, '2008-04-30', '2008-04-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (121, 2009, 1, '2009-05-01', '2009-05-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (121, 2010, 1, '2010-05-01', '2010-05-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (121, 2011, 1, '2011-05-01', '2011-05-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (121, 2012, 1, '2012-04-30', '2012-04-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (121, 2013, 1, '2013-05-01', '2013-05-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (121, 2014, 1, '2014-05-01', '2014-05-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (121, 2015, 1, '2015-05-01', '2015-05-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (122, 2008, 1, '2008-05-01', '2008-05-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (122, 2009, 1, '2009-05-02', '2009-05-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (122, 2010, 1, '2010-05-02', '2010-05-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (122, 2011, 1, '2011-05-02', '2011-05-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (122, 2012, 1, '2012-05-01', '2012-05-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (122, 2013, 1, '2013-05-02', '2013-05-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (122, 2014, 1, '2014-05-02', '2014-05-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (122, 2015, 1, '2015-05-02', '2015-05-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (123, 2008, 1, '2008-05-02', '2008-05-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (123, 2009, 1, '2009-05-03', '2009-05-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (123, 2010, 1, '2010-05-03', '2010-05-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (123, 2011, 1, '2011-05-03', '2011-05-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (123, 2012, 1, '2012-05-02', '2012-05-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (123, 2013, 1, '2013-05-03', '2013-05-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (123, 2014, 1, '2014-05-03', '2014-05-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (123, 2015, 1, '2015-05-03', '2015-05-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (124, 2008, 1, '2008-05-03', '2008-05-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (124, 2009, 1, '2009-05-04', '2009-05-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (124, 2010, 1, '2010-05-04', '2010-05-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (124, 2011, 1, '2011-05-04', '2011-05-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (124, 2012, 1, '2012-05-03', '2012-05-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (124, 2013, 1, '2013-05-04', '2013-05-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (124, 2014, 1, '2014-05-04', '2014-05-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (124, 2015, 1, '2015-05-04', '2015-05-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (125, 2008, 1, '2008-05-04', '2008-05-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (125, 2009, 1, '2009-05-05', '2009-05-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (125, 2010, 1, '2010-05-05', '2010-05-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (125, 2011, 1, '2011-05-05', '2011-05-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (125, 2012, 1, '2012-05-04', '2012-05-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (125, 2013, 1, '2013-05-05', '2013-05-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (125, 2014, 1, '2014-05-05', '2014-05-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (125, 2015, 1, '2015-05-05', '2015-05-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (126, 2008, 1, '2008-05-05', '2008-05-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (126, 2009, 1, '2009-05-06', '2009-05-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (126, 2010, 1, '2010-05-06', '2010-05-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (126, 2011, 1, '2011-05-06', '2011-05-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (126, 2012, 1, '2012-05-05', '2012-05-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (126, 2013, 1, '2013-05-06', '2013-05-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (126, 2014, 1, '2014-05-06', '2014-05-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (126, 2015, 1, '2015-05-06', '2015-05-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (127, 2008, 1, '2008-05-06', '2008-05-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (127, 2009, 1, '2009-05-07', '2009-05-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (127, 2010, 1, '2010-05-07', '2010-05-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (127, 2011, 1, '2011-05-07', '2011-05-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (127, 2012, 1, '2012-05-06', '2012-05-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (127, 2013, 1, '2013-05-07', '2013-05-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (127, 2014, 1, '2014-05-07', '2014-05-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (127, 2015, 1, '2015-05-07', '2015-05-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (128, 2008, 1, '2008-05-07', '2008-05-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (128, 2009, 1, '2009-05-08', '2009-05-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (128, 2010, 1, '2010-05-08', '2010-05-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (128, 2011, 1, '2011-05-08', '2011-05-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (128, 2012, 1, '2012-05-07', '2012-05-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (128, 2013, 1, '2013-05-08', '2013-05-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (128, 2014, 1, '2014-05-08', '2014-05-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (128, 2015, 1, '2015-05-08', '2015-05-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (129, 2008, 1, '2008-05-08', '2008-05-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (129, 2009, 1, '2009-05-09', '2009-05-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (129, 2010, 1, '2010-05-09', '2010-05-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (129, 2011, 1, '2011-05-09', '2011-05-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (129, 2012, 1, '2012-05-08', '2012-05-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (129, 2013, 1, '2013-05-09', '2013-05-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (129, 2014, 1, '2014-05-09', '2014-05-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (129, 2015, 1, '2015-05-09', '2015-05-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (130, 2008, 1, '2008-05-09', '2008-05-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (130, 2009, 1, '2009-05-10', '2009-05-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (130, 2010, 1, '2010-05-10', '2010-05-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (130, 2011, 1, '2011-05-10', '2011-05-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (130, 2012, 1, '2012-05-09', '2012-05-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (130, 2013, 1, '2013-05-10', '2013-05-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (130, 2014, 1, '2014-05-10', '2014-05-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (130, 2015, 1, '2015-05-10', '2015-05-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (131, 2008, 1, '2008-05-10', '2008-05-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (131, 2009, 1, '2009-05-11', '2009-05-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (131, 2010, 1, '2010-05-11', '2010-05-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (131, 2011, 1, '2011-05-11', '2011-05-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (131, 2012, 1, '2012-05-10', '2012-05-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (131, 2013, 1, '2013-05-11', '2013-05-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (131, 2014, 1, '2014-05-11', '2014-05-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (131, 2015, 1, '2015-05-11', '2015-05-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (132, 2008, 1, '2008-05-11', '2008-05-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (132, 2009, 1, '2009-05-12', '2009-05-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (132, 2010, 1, '2010-05-12', '2010-05-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (132, 2011, 1, '2011-05-12', '2011-05-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (132, 2012, 1, '2012-05-11', '2012-05-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (132, 2013, 1, '2013-05-12', '2013-05-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (132, 2014, 1, '2014-05-12', '2014-05-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (132, 2015, 1, '2015-05-12', '2015-05-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (133, 2008, 1, '2008-05-12', '2008-05-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (133, 2009, 1, '2009-05-13', '2009-05-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (133, 2010, 1, '2010-05-13', '2010-05-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (133, 2011, 1, '2011-05-13', '2011-05-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (133, 2012, 1, '2012-05-12', '2012-05-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (133, 2013, 1, '2013-05-13', '2013-05-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (133, 2014, 1, '2014-05-13', '2014-05-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (133, 2015, 1, '2015-05-13', '2015-05-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (134, 2008, 1, '2008-05-13', '2008-05-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (134, 2009, 1, '2009-05-14', '2009-05-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (134, 2010, 1, '2010-05-14', '2010-05-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (134, 2011, 1, '2011-05-14', '2011-05-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (134, 2012, 1, '2012-05-13', '2012-05-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (134, 2013, 1, '2013-05-14', '2013-05-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (134, 2014, 1, '2014-05-14', '2014-05-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (134, 2015, 1, '2015-05-14', '2015-05-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (135, 2008, 1, '2008-05-14', '2008-05-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (135, 2009, 1, '2009-05-15', '2009-05-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (135, 2010, 1, '2010-05-15', '2010-05-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (135, 2011, 1, '2011-05-15', '2011-05-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (135, 2012, 1, '2012-05-14', '2012-05-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (135, 2013, 1, '2013-05-15', '2013-05-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (135, 2014, 1, '2014-05-15', '2014-05-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (135, 2015, 1, '2015-05-15', '2015-05-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (136, 2008, 1, '2008-05-15', '2008-05-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (136, 2009, 1, '2009-05-16', '2009-05-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (136, 2010, 1, '2010-05-16', '2010-05-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (136, 2011, 1, '2011-05-16', '2011-05-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (136, 2012, 1, '2012-05-15', '2012-05-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (136, 2013, 1, '2013-05-16', '2013-05-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (136, 2014, 1, '2014-05-16', '2014-05-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (136, 2015, 1, '2015-05-16', '2015-05-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (137, 2008, 1, '2008-05-16', '2008-05-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (137, 2009, 1, '2009-05-17', '2009-05-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (137, 2010, 1, '2010-05-17', '2010-05-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (137, 2011, 1, '2011-05-17', '2011-05-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (137, 2012, 1, '2012-05-16', '2012-05-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (137, 2013, 1, '2013-05-17', '2013-05-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (137, 2014, 1, '2014-05-17', '2014-05-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (137, 2015, 1, '2015-05-17', '2015-05-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (138, 2008, 1, '2008-05-17', '2008-05-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (138, 2009, 1, '2009-05-18', '2009-05-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (138, 2010, 1, '2010-05-18', '2010-05-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (138, 2011, 1, '2011-05-18', '2011-05-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (138, 2012, 1, '2012-05-17', '2012-05-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (138, 2013, 1, '2013-05-18', '2013-05-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (138, 2014, 1, '2014-05-18', '2014-05-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (138, 2015, 1, '2015-05-18', '2015-05-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (139, 2008, 1, '2008-05-18', '2008-05-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (139, 2009, 1, '2009-05-19', '2009-05-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (139, 2010, 1, '2010-05-19', '2010-05-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (139, 2011, 1, '2011-05-19', '2011-05-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (139, 2012, 1, '2012-05-18', '2012-05-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (139, 2013, 1, '2013-05-19', '2013-05-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (139, 2014, 1, '2014-05-19', '2014-05-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (139, 2015, 1, '2015-05-19', '2015-05-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (140, 2008, 1, '2008-05-19', '2008-05-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (140, 2009, 1, '2009-05-20', '2009-05-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (140, 2010, 1, '2010-05-20', '2010-05-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (140, 2011, 1, '2011-05-20', '2011-05-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (140, 2012, 1, '2012-05-19', '2012-05-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (140, 2013, 1, '2013-05-20', '2013-05-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (140, 2014, 1, '2014-05-20', '2014-05-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (140, 2015, 1, '2015-05-20', '2015-05-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (141, 2008, 1, '2008-05-20', '2008-05-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (141, 2009, 1, '2009-05-21', '2009-05-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (141, 2010, 1, '2010-05-21', '2010-05-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (141, 2011, 1, '2011-05-21', '2011-05-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (141, 2012, 1, '2012-05-20', '2012-05-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (141, 2013, 1, '2013-05-21', '2013-05-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (141, 2014, 1, '2014-05-21', '2014-05-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (141, 2015, 1, '2015-05-21', '2015-05-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (142, 2008, 1, '2008-05-21', '2008-05-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (142, 2009, 1, '2009-05-22', '2009-05-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (142, 2010, 1, '2010-05-22', '2010-05-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (142, 2011, 1, '2011-05-22', '2011-05-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (142, 2012, 1, '2012-05-21', '2012-05-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (142, 2013, 1, '2013-05-22', '2013-05-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (142, 2014, 1, '2014-05-22', '2014-05-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (142, 2015, 1, '2015-05-22', '2015-05-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (143, 2008, 1, '2008-05-22', '2008-05-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (143, 2009, 1, '2009-05-23', '2009-05-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (143, 2010, 1, '2010-05-23', '2010-05-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (143, 2011, 1, '2011-05-23', '2011-05-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (143, 2012, 1, '2012-05-22', '2012-05-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (143, 2013, 1, '2013-05-23', '2013-05-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (143, 2014, 1, '2014-05-23', '2014-05-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (143, 2015, 1, '2015-05-23', '2015-05-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (144, 2008, 1, '2008-05-23', '2008-05-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (144, 2009, 1, '2009-05-24', '2009-05-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (144, 2010, 1, '2010-05-24', '2010-05-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (144, 2011, 1, '2011-05-24', '2011-05-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (144, 2012, 1, '2012-05-23', '2012-05-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (144, 2013, 1, '2013-05-24', '2013-05-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (144, 2014, 1, '2014-05-24', '2014-05-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (144, 2015, 1, '2015-05-24', '2015-05-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (145, 2008, 1, '2008-05-24', '2008-05-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (145, 2009, 1, '2009-05-25', '2009-05-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (145, 2010, 1, '2010-05-25', '2010-05-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (145, 2011, 1, '2011-05-25', '2011-05-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (145, 2012, 1, '2012-05-24', '2012-05-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (145, 2013, 1, '2013-05-25', '2013-05-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (145, 2014, 1, '2014-05-25', '2014-05-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (145, 2015, 1, '2015-05-25', '2015-05-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (146, 2008, 1, '2008-05-25', '2008-05-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (146, 2009, 1, '2009-05-26', '2009-05-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (146, 2010, 1, '2010-05-26', '2010-05-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (146, 2011, 1, '2011-05-26', '2011-05-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (146, 2012, 1, '2012-05-25', '2012-05-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (146, 2013, 1, '2013-05-26', '2013-05-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (146, 2014, 1, '2014-05-26', '2014-05-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (146, 2015, 1, '2015-05-26', '2015-05-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (147, 2008, 1, '2008-05-26', '2008-05-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (147, 2009, 1, '2009-05-27', '2009-05-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (147, 2010, 1, '2010-05-27', '2010-05-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (147, 2011, 1, '2011-05-27', '2011-05-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (147, 2012, 1, '2012-05-26', '2012-05-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (147, 2013, 1, '2013-05-27', '2013-05-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (147, 2014, 1, '2014-05-27', '2014-05-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (147, 2015, 1, '2015-05-27', '2015-05-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (148, 2008, 1, '2008-05-27', '2008-05-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (148, 2009, 1, '2009-05-28', '2009-05-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (148, 2010, 1, '2010-05-28', '2010-05-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (148, 2011, 1, '2011-05-28', '2011-05-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (148, 2012, 1, '2012-05-27', '2012-05-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (148, 2013, 1, '2013-05-28', '2013-05-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (148, 2014, 1, '2014-05-28', '2014-05-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (148, 2015, 1, '2015-05-28', '2015-05-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (149, 2008, 1, '2008-05-28', '2008-05-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (149, 2009, 1, '2009-05-29', '2009-05-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (149, 2010, 1, '2010-05-29', '2010-05-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (149, 2011, 1, '2011-05-29', '2011-05-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (149, 2012, 1, '2012-05-28', '2012-05-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (149, 2013, 1, '2013-05-29', '2013-05-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (149, 2014, 1, '2014-05-29', '2014-05-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (149, 2015, 1, '2015-05-29', '2015-05-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (150, 2008, 1, '2008-05-29', '2008-05-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (150, 2009, 1, '2009-05-30', '2009-05-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (150, 2010, 1, '2010-05-30', '2010-05-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (150, 2011, 1, '2011-05-30', '2011-05-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (150, 2012, 1, '2012-05-29', '2012-05-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (150, 2013, 1, '2013-05-30', '2013-05-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (150, 2014, 1, '2014-05-30', '2014-05-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (150, 2015, 1, '2015-05-30', '2015-05-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (151, 2008, 1, '2008-05-30', '2008-05-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (151, 2009, 1, '2009-05-31', '2009-05-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (151, 2010, 1, '2010-05-31', '2010-05-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (151, 2011, 1, '2011-05-31', '2011-05-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (151, 2012, 1, '2012-05-30', '2012-05-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (151, 2013, 1, '2013-05-31', '2013-05-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (151, 2014, 1, '2014-05-31', '2014-05-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (151, 2015, 1, '2015-05-31', '2015-05-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (152, 2008, 1, '2008-05-31', '2008-05-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (152, 2009, 1, '2009-06-01', '2009-06-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (152, 2010, 1, '2010-06-01', '2010-06-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (152, 2011, 1, '2011-06-01', '2011-06-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (152, 2012, 1, '2012-05-31', '2012-05-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (152, 2013, 1, '2013-06-01', '2013-06-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (152, 2014, 1, '2014-06-01', '2014-06-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (152, 2015, 1, '2015-06-01', '2015-06-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (153, 2008, 1, '2008-06-01', '2008-06-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (153, 2009, 1, '2009-06-02', '2009-06-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (153, 2010, 1, '2010-06-02', '2010-06-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (153, 2011, 1, '2011-06-02', '2011-06-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (153, 2012, 1, '2012-06-01', '2012-06-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (153, 2013, 1, '2013-06-02', '2013-06-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (153, 2014, 1, '2014-06-02', '2014-06-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (153, 2015, 1, '2015-06-02', '2015-06-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (154, 2008, 1, '2008-06-02', '2008-06-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (154, 2009, 1, '2009-06-03', '2009-06-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (154, 2010, 1, '2010-06-03', '2010-06-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (154, 2011, 1, '2011-06-03', '2011-06-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (154, 2012, 1, '2012-06-02', '2012-06-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (154, 2013, 1, '2013-06-03', '2013-06-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (154, 2014, 1, '2014-06-03', '2014-06-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (154, 2015, 1, '2015-06-03', '2015-06-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (155, 2008, 1, '2008-06-03', '2008-06-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (155, 2009, 1, '2009-06-04', '2009-06-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (155, 2010, 1, '2010-06-04', '2010-06-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (155, 2011, 1, '2011-06-04', '2011-06-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (155, 2012, 1, '2012-06-03', '2012-06-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (155, 2013, 1, '2013-06-04', '2013-06-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (155, 2014, 1, '2014-06-04', '2014-06-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (155, 2015, 1, '2015-06-04', '2015-06-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (156, 2008, 1, '2008-06-04', '2008-06-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (156, 2009, 1, '2009-06-05', '2009-06-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (156, 2010, 1, '2010-06-05', '2010-06-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (156, 2011, 1, '2011-06-05', '2011-06-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (156, 2012, 1, '2012-06-04', '2012-06-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (156, 2013, 1, '2013-06-05', '2013-06-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (156, 2014, 1, '2014-06-05', '2014-06-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (156, 2015, 1, '2015-06-05', '2015-06-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (157, 2008, 1, '2008-06-05', '2008-06-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (157, 2009, 1, '2009-06-06', '2009-06-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (157, 2010, 1, '2010-06-06', '2010-06-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (157, 2011, 1, '2011-06-06', '2011-06-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (157, 2012, 1, '2012-06-05', '2012-06-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (157, 2013, 1, '2013-06-06', '2013-06-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (157, 2014, 1, '2014-06-06', '2014-06-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (157, 2015, 1, '2015-06-06', '2015-06-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (158, 2008, 1, '2008-06-06', '2008-06-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (158, 2009, 1, '2009-06-07', '2009-06-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (158, 2010, 1, '2010-06-07', '2010-06-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (158, 2011, 1, '2011-06-07', '2011-06-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (158, 2012, 1, '2012-06-06', '2012-06-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (158, 2013, 1, '2013-06-07', '2013-06-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (158, 2014, 1, '2014-06-07', '2014-06-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (158, 2015, 1, '2015-06-07', '2015-06-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (159, 2008, 1, '2008-06-07', '2008-06-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (159, 2009, 1, '2009-06-08', '2009-06-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (159, 2010, 1, '2010-06-08', '2010-06-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (159, 2011, 1, '2011-06-08', '2011-06-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (159, 2012, 1, '2012-06-07', '2012-06-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (159, 2013, 1, '2013-06-08', '2013-06-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (159, 2014, 1, '2014-06-08', '2014-06-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (159, 2015, 1, '2015-06-08', '2015-06-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (160, 2008, 1, '2008-06-08', '2008-06-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (160, 2009, 1, '2009-06-09', '2009-06-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (160, 2010, 1, '2010-06-09', '2010-06-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (160, 2011, 1, '2011-06-09', '2011-06-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (160, 2012, 1, '2012-06-08', '2012-06-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (160, 2013, 1, '2013-06-09', '2013-06-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (160, 2014, 1, '2014-06-09', '2014-06-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (160, 2015, 1, '2015-06-09', '2015-06-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (161, 2008, 1, '2008-06-09', '2008-06-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (161, 2009, 1, '2009-06-10', '2009-06-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (161, 2010, 1, '2010-06-10', '2010-06-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (161, 2011, 1, '2011-06-10', '2011-06-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (161, 2012, 1, '2012-06-09', '2012-06-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (161, 2013, 1, '2013-06-10', '2013-06-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (161, 2014, 1, '2014-06-10', '2014-06-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (161, 2015, 1, '2015-06-10', '2015-06-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (162, 2008, 1, '2008-06-10', '2008-06-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (162, 2009, 1, '2009-06-11', '2009-06-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (162, 2010, 1, '2010-06-11', '2010-06-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (162, 2011, 1, '2011-06-11', '2011-06-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (162, 2012, 1, '2012-06-10', '2012-06-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (162, 2013, 1, '2013-06-11', '2013-06-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (162, 2014, 1, '2014-06-11', '2014-06-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (162, 2015, 1, '2015-06-11', '2015-06-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (163, 2008, 1, '2008-06-11', '2008-06-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (163, 2009, 1, '2009-06-12', '2009-06-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (163, 2010, 1, '2010-06-12', '2010-06-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (163, 2011, 1, '2011-06-12', '2011-06-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (163, 2012, 1, '2012-06-11', '2012-06-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (163, 2013, 1, '2013-06-12', '2013-06-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (163, 2014, 1, '2014-06-12', '2014-06-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (163, 2015, 1, '2015-06-12', '2015-06-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (164, 2008, 1, '2008-06-12', '2008-06-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (164, 2009, 1, '2009-06-13', '2009-06-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (164, 2010, 1, '2010-06-13', '2010-06-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (164, 2011, 1, '2011-06-13', '2011-06-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (164, 2012, 1, '2012-06-12', '2012-06-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (164, 2013, 1, '2013-06-13', '2013-06-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (164, 2014, 1, '2014-06-13', '2014-06-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (164, 2015, 1, '2015-06-13', '2015-06-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (165, 2008, 1, '2008-06-13', '2008-06-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (165, 2009, 1, '2009-06-14', '2009-06-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (165, 2010, 1, '2010-06-14', '2010-06-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (165, 2011, 1, '2011-06-14', '2011-06-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (165, 2012, 1, '2012-06-13', '2012-06-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (165, 2013, 1, '2013-06-14', '2013-06-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (165, 2014, 1, '2014-06-14', '2014-06-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (165, 2015, 1, '2015-06-14', '2015-06-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (166, 2008, 1, '2008-06-14', '2008-06-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (166, 2009, 1, '2009-06-15', '2009-06-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (166, 2010, 1, '2010-06-15', '2010-06-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (166, 2011, 1, '2011-06-15', '2011-06-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (166, 2012, 1, '2012-06-14', '2012-06-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (166, 2013, 1, '2013-06-15', '2013-06-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (166, 2014, 1, '2014-06-15', '2014-06-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (166, 2015, 1, '2015-06-15', '2015-06-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (167, 2008, 1, '2008-06-15', '2008-06-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (167, 2009, 1, '2009-06-16', '2009-06-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (167, 2010, 1, '2010-06-16', '2010-06-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (167, 2011, 1, '2011-06-16', '2011-06-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (167, 2012, 1, '2012-06-15', '2012-06-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (167, 2013, 1, '2013-06-16', '2013-06-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (167, 2014, 1, '2014-06-16', '2014-06-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (167, 2015, 1, '2015-06-16', '2015-06-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (168, 2008, 1, '2008-06-16', '2008-06-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (168, 2009, 1, '2009-06-17', '2009-06-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (168, 2010, 1, '2010-06-17', '2010-06-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (168, 2011, 1, '2011-06-17', '2011-06-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (168, 2012, 1, '2012-06-16', '2012-06-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (168, 2013, 1, '2013-06-17', '2013-06-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (168, 2014, 1, '2014-06-17', '2014-06-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (168, 2015, 1, '2015-06-17', '2015-06-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (169, 2008, 1, '2008-06-17', '2008-06-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (169, 2009, 1, '2009-06-18', '2009-06-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (169, 2010, 1, '2010-06-18', '2010-06-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (169, 2011, 1, '2011-06-18', '2011-06-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (169, 2012, 1, '2012-06-17', '2012-06-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (169, 2013, 1, '2013-06-18', '2013-06-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (169, 2014, 1, '2014-06-18', '2014-06-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (169, 2015, 1, '2015-06-18', '2015-06-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (170, 2008, 1, '2008-06-18', '2008-06-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (170, 2009, 1, '2009-06-19', '2009-06-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (170, 2010, 1, '2010-06-19', '2010-06-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (170, 2011, 1, '2011-06-19', '2011-06-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (170, 2012, 1, '2012-06-18', '2012-06-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (170, 2013, 1, '2013-06-19', '2013-06-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (170, 2014, 1, '2014-06-19', '2014-06-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (170, 2015, 1, '2015-06-19', '2015-06-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (171, 2008, 1, '2008-06-19', '2008-06-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (171, 2009, 1, '2009-06-20', '2009-06-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (171, 2010, 1, '2010-06-20', '2010-06-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (171, 2011, 1, '2011-06-20', '2011-06-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (171, 2012, 1, '2012-06-19', '2012-06-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (171, 2013, 1, '2013-06-20', '2013-06-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (171, 2014, 1, '2014-06-20', '2014-06-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (171, 2015, 1, '2015-06-20', '2015-06-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (172, 2008, 1, '2008-06-20', '2008-06-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (172, 2009, 1, '2009-06-21', '2009-06-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (172, 2010, 1, '2010-06-21', '2010-06-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (172, 2011, 1, '2011-06-21', '2011-06-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (172, 2012, 1, '2012-06-20', '2012-06-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (172, 2013, 1, '2013-06-21', '2013-06-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (172, 2014, 1, '2014-06-21', '2014-06-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (172, 2015, 1, '2015-06-21', '2015-06-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (173, 2008, 1, '2008-06-21', '2008-06-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (173, 2009, 1, '2009-06-22', '2009-06-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (173, 2010, 1, '2010-06-22', '2010-06-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (173, 2011, 1, '2011-06-22', '2011-06-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (173, 2012, 1, '2012-06-21', '2012-06-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (173, 2013, 1, '2013-06-22', '2013-06-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (173, 2014, 1, '2014-06-22', '2014-06-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (173, 2015, 1, '2015-06-22', '2015-06-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (174, 2008, 1, '2008-06-22', '2008-06-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (174, 2009, 1, '2009-06-23', '2009-06-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (174, 2010, 1, '2010-06-23', '2010-06-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (174, 2011, 1, '2011-06-23', '2011-06-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (174, 2012, 1, '2012-06-22', '2012-06-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (174, 2013, 1, '2013-06-23', '2013-06-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (174, 2014, 1, '2014-06-23', '2014-06-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (174, 2015, 1, '2015-06-23', '2015-06-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (175, 2008, 1, '2008-06-23', '2008-06-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (175, 2009, 1, '2009-06-24', '2009-06-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (175, 2010, 1, '2010-06-24', '2010-06-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (175, 2011, 1, '2011-06-24', '2011-06-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (175, 2012, 1, '2012-06-23', '2012-06-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (175, 2013, 1, '2013-06-24', '2013-06-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (175, 2014, 1, '2014-06-24', '2014-06-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (175, 2015, 1, '2015-06-24', '2015-06-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (176, 2008, 1, '2008-06-24', '2008-06-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (176, 2009, 1, '2009-06-25', '2009-06-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (176, 2010, 1, '2010-06-25', '2010-06-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (176, 2011, 1, '2011-06-25', '2011-06-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (176, 2012, 1, '2012-06-24', '2012-06-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (176, 2013, 1, '2013-06-25', '2013-06-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (176, 2014, 1, '2014-06-25', '2014-06-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (176, 2015, 1, '2015-06-25', '2015-06-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (177, 2008, 1, '2008-06-25', '2008-06-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (177, 2009, 1, '2009-06-26', '2009-06-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (177, 2010, 1, '2010-06-26', '2010-06-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (177, 2011, 1, '2011-06-26', '2011-06-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (177, 2012, 1, '2012-06-25', '2012-06-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (177, 2013, 1, '2013-06-26', '2013-06-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (177, 2014, 1, '2014-06-26', '2014-06-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (177, 2015, 1, '2015-06-26', '2015-06-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (178, 2008, 1, '2008-06-26', '2008-06-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (178, 2009, 1, '2009-06-27', '2009-06-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (178, 2010, 1, '2010-06-27', '2010-06-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (178, 2011, 1, '2011-06-27', '2011-06-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (178, 2012, 1, '2012-06-26', '2012-06-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (178, 2013, 1, '2013-06-27', '2013-06-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (178, 2014, 1, '2014-06-27', '2014-06-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (178, 2015, 1, '2015-06-27', '2015-06-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (179, 2008, 1, '2008-06-27', '2008-06-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (179, 2009, 1, '2009-06-28', '2009-06-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (179, 2010, 1, '2010-06-28', '2010-06-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (179, 2011, 1, '2011-06-28', '2011-06-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (179, 2012, 1, '2012-06-27', '2012-06-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (179, 2013, 1, '2013-06-28', '2013-06-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (179, 2014, 1, '2014-06-28', '2014-06-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (179, 2015, 1, '2015-06-28', '2015-06-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (180, 2008, 1, '2008-06-28', '2008-06-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (180, 2009, 1, '2009-06-29', '2009-06-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (180, 2010, 1, '2010-06-29', '2010-06-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (180, 2011, 1, '2011-06-29', '2011-06-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (180, 2012, 1, '2012-06-28', '2012-06-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (180, 2013, 1, '2013-06-29', '2013-06-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (180, 2014, 1, '2014-06-29', '2014-06-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (180, 2015, 1, '2015-06-29', '2015-06-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (181, 2008, 1, '2008-06-29', '2008-06-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (181, 2009, 1, '2009-06-30', '2009-06-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (181, 2010, 1, '2010-06-30', '2010-06-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (181, 2011, 1, '2011-06-30', '2011-06-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (181, 2012, 1, '2012-06-29', '2012-06-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (181, 2013, 1, '2013-06-30', '2013-06-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (181, 2014, 1, '2014-06-30', '2014-06-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (181, 2015, 1, '2015-06-30', '2015-06-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (182, 2008, 1, '2008-06-30', '2008-06-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (182, 2009, 1, '2009-07-01', '2009-07-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (182, 2010, 1, '2010-07-01', '2010-07-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (182, 2011, 1, '2011-07-01', '2011-07-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (182, 2012, 1, '2012-06-30', '2012-06-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (182, 2013, 1, '2013-07-01', '2013-07-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (182, 2014, 1, '2014-07-01', '2014-07-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (182, 2015, 1, '2015-07-01', '2015-07-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (183, 2008, 1, '2008-07-01', '2008-07-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (183, 2009, 1, '2009-07-02', '2009-07-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (183, 2010, 1, '2010-07-02', '2010-07-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (183, 2011, 1, '2011-07-02', '2011-07-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (183, 2012, 1, '2012-07-01', '2012-07-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (183, 2013, 1, '2013-07-02', '2013-07-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (183, 2014, 1, '2014-07-02', '2014-07-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (183, 2015, 1, '2015-07-02', '2015-07-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (184, 2008, 1, '2008-07-02', '2008-07-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (184, 2009, 1, '2009-07-03', '2009-07-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (184, 2010, 1, '2010-07-03', '2010-07-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (184, 2011, 1, '2011-07-03', '2011-07-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (184, 2012, 1, '2012-07-02', '2012-07-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (184, 2013, 1, '2013-07-03', '2013-07-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (184, 2014, 1, '2014-07-03', '2014-07-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (184, 2015, 1, '2015-07-03', '2015-07-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (185, 2008, 1, '2008-07-03', '2008-07-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (185, 2009, 1, '2009-07-04', '2009-07-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (185, 2010, 1, '2010-07-04', '2010-07-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (185, 2011, 1, '2011-07-04', '2011-07-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (185, 2012, 1, '2012-07-03', '2012-07-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (185, 2013, 1, '2013-07-04', '2013-07-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (185, 2014, 1, '2014-07-04', '2014-07-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (185, 2015, 1, '2015-07-04', '2015-07-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (186, 2008, 1, '2008-07-04', '2008-07-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (186, 2009, 1, '2009-07-05', '2009-07-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (186, 2010, 1, '2010-07-05', '2010-07-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (186, 2011, 1, '2011-07-05', '2011-07-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (186, 2012, 1, '2012-07-04', '2012-07-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (186, 2013, 1, '2013-07-05', '2013-07-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (186, 2014, 1, '2014-07-05', '2014-07-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (186, 2015, 1, '2015-07-05', '2015-07-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (187, 2008, 1, '2008-07-05', '2008-07-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (187, 2009, 1, '2009-07-06', '2009-07-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (187, 2010, 1, '2010-07-06', '2010-07-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (187, 2011, 1, '2011-07-06', '2011-07-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (187, 2012, 1, '2012-07-05', '2012-07-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (187, 2013, 1, '2013-07-06', '2013-07-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (187, 2014, 1, '2014-07-06', '2014-07-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (187, 2015, 1, '2015-07-06', '2015-07-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (188, 2008, 1, '2008-07-06', '2008-07-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (188, 2009, 1, '2009-07-07', '2009-07-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (188, 2010, 1, '2010-07-07', '2010-07-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (188, 2011, 1, '2011-07-07', '2011-07-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (188, 2012, 1, '2012-07-06', '2012-07-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (188, 2013, 1, '2013-07-07', '2013-07-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (188, 2014, 1, '2014-07-07', '2014-07-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (188, 2015, 1, '2015-07-07', '2015-07-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (189, 2008, 1, '2008-07-07', '2008-07-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (189, 2009, 1, '2009-07-08', '2009-07-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (189, 2010, 1, '2010-07-08', '2010-07-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (189, 2011, 1, '2011-07-08', '2011-07-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (189, 2012, 1, '2012-07-07', '2012-07-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (189, 2013, 1, '2013-07-08', '2013-07-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (189, 2014, 1, '2014-07-08', '2014-07-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (189, 2015, 1, '2015-07-08', '2015-07-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (190, 2008, 1, '2008-07-08', '2008-07-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (190, 2009, 1, '2009-07-09', '2009-07-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (190, 2010, 1, '2010-07-09', '2010-07-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (190, 2011, 1, '2011-07-09', '2011-07-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (190, 2012, 1, '2012-07-08', '2012-07-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (190, 2013, 1, '2013-07-09', '2013-07-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (190, 2014, 1, '2014-07-09', '2014-07-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (190, 2015, 1, '2015-07-09', '2015-07-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (191, 2008, 1, '2008-07-09', '2008-07-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (191, 2009, 1, '2009-07-10', '2009-07-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (191, 2010, 1, '2010-07-10', '2010-07-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (191, 2011, 1, '2011-07-10', '2011-07-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (191, 2012, 1, '2012-07-09', '2012-07-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (191, 2013, 1, '2013-07-10', '2013-07-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (191, 2014, 1, '2014-07-10', '2014-07-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (191, 2015, 1, '2015-07-10', '2015-07-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (192, 2008, 1, '2008-07-10', '2008-07-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (192, 2009, 1, '2009-07-11', '2009-07-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (192, 2010, 1, '2010-07-11', '2010-07-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (192, 2011, 1, '2011-07-11', '2011-07-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (192, 2012, 1, '2012-07-10', '2012-07-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (192, 2013, 1, '2013-07-11', '2013-07-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (192, 2014, 1, '2014-07-11', '2014-07-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (192, 2015, 1, '2015-07-11', '2015-07-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (193, 2008, 1, '2008-07-11', '2008-07-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (193, 2009, 1, '2009-07-12', '2009-07-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (193, 2010, 1, '2010-07-12', '2010-07-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (193, 2011, 1, '2011-07-12', '2011-07-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (193, 2012, 1, '2012-07-11', '2012-07-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (193, 2013, 1, '2013-07-12', '2013-07-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (193, 2014, 1, '2014-07-12', '2014-07-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (193, 2015, 1, '2015-07-12', '2015-07-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (194, 2008, 1, '2008-07-12', '2008-07-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (194, 2009, 1, '2009-07-13', '2009-07-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (194, 2010, 1, '2010-07-13', '2010-07-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (194, 2011, 1, '2011-07-13', '2011-07-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (194, 2012, 1, '2012-07-12', '2012-07-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (194, 2013, 1, '2013-07-13', '2013-07-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (194, 2014, 1, '2014-07-13', '2014-07-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (194, 2015, 1, '2015-07-13', '2015-07-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (195, 2008, 1, '2008-07-13', '2008-07-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (195, 2009, 1, '2009-07-14', '2009-07-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (195, 2010, 1, '2010-07-14', '2010-07-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (195, 2011, 1, '2011-07-14', '2011-07-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (195, 2012, 1, '2012-07-13', '2012-07-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (195, 2013, 1, '2013-07-14', '2013-07-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (195, 2014, 1, '2014-07-14', '2014-07-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (195, 2015, 1, '2015-07-14', '2015-07-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (196, 2008, 1, '2008-07-14', '2008-07-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (196, 2009, 1, '2009-07-15', '2009-07-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (196, 2010, 1, '2010-07-15', '2010-07-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (196, 2011, 1, '2011-07-15', '2011-07-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (196, 2012, 1, '2012-07-14', '2012-07-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (196, 2013, 1, '2013-07-15', '2013-07-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (196, 2014, 1, '2014-07-15', '2014-07-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (196, 2015, 1, '2015-07-15', '2015-07-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (197, 2008, 1, '2008-07-15', '2008-07-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (197, 2009, 1, '2009-07-16', '2009-07-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (197, 2010, 1, '2010-07-16', '2010-07-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (197, 2011, 1, '2011-07-16', '2011-07-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (197, 2012, 1, '2012-07-15', '2012-07-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (197, 2013, 1, '2013-07-16', '2013-07-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (197, 2014, 1, '2014-07-16', '2014-07-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (197, 2015, 1, '2015-07-16', '2015-07-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (198, 2008, 1, '2008-07-16', '2008-07-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (198, 2009, 1, '2009-07-17', '2009-07-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (198, 2010, 1, '2010-07-17', '2010-07-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (198, 2011, 1, '2011-07-17', '2011-07-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (198, 2012, 1, '2012-07-16', '2012-07-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (198, 2013, 1, '2013-07-17', '2013-07-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (198, 2014, 1, '2014-07-17', '2014-07-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (198, 2015, 1, '2015-07-17', '2015-07-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (199, 2008, 1, '2008-07-17', '2008-07-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (199, 2009, 1, '2009-07-18', '2009-07-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (199, 2010, 1, '2010-07-18', '2010-07-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (199, 2011, 1, '2011-07-18', '2011-07-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (199, 2012, 1, '2012-07-17', '2012-07-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (199, 2013, 1, '2013-07-18', '2013-07-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (199, 2014, 1, '2014-07-18', '2014-07-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (199, 2015, 1, '2015-07-18', '2015-07-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (200, 2008, 1, '2008-07-18', '2008-07-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (200, 2009, 1, '2009-07-19', '2009-07-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (200, 2010, 1, '2010-07-19', '2010-07-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (200, 2011, 1, '2011-07-19', '2011-07-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (200, 2012, 1, '2012-07-18', '2012-07-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (200, 2013, 1, '2013-07-19', '2013-07-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (200, 2014, 1, '2014-07-19', '2014-07-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (200, 2015, 1, '2015-07-19', '2015-07-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (201, 2008, 1, '2008-07-19', '2008-07-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (201, 2009, 1, '2009-07-20', '2009-07-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (201, 2010, 1, '2010-07-20', '2010-07-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (201, 2011, 1, '2011-07-20', '2011-07-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (201, 2012, 1, '2012-07-19', '2012-07-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (201, 2013, 1, '2013-07-20', '2013-07-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (201, 2014, 1, '2014-07-20', '2014-07-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (201, 2015, 1, '2015-07-20', '2015-07-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (202, 2008, 1, '2008-07-20', '2008-07-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (202, 2009, 1, '2009-07-21', '2009-07-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (202, 2010, 1, '2010-07-21', '2010-07-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (202, 2011, 1, '2011-07-21', '2011-07-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (202, 2012, 1, '2012-07-20', '2012-07-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (202, 2013, 1, '2013-07-21', '2013-07-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (202, 2014, 1, '2014-07-21', '2014-07-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (202, 2015, 1, '2015-07-21', '2015-07-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (203, 2008, 1, '2008-07-21', '2008-07-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (203, 2009, 1, '2009-07-22', '2009-07-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (203, 2010, 1, '2010-07-22', '2010-07-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (203, 2011, 1, '2011-07-22', '2011-07-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (203, 2012, 1, '2012-07-21', '2012-07-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (203, 2013, 1, '2013-07-22', '2013-07-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (203, 2014, 1, '2014-07-22', '2014-07-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (203, 2015, 1, '2015-07-22', '2015-07-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (204, 2008, 1, '2008-07-22', '2008-07-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (204, 2009, 1, '2009-07-23', '2009-07-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (204, 2010, 1, '2010-07-23', '2010-07-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (204, 2011, 1, '2011-07-23', '2011-07-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (204, 2012, 1, '2012-07-22', '2012-07-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (204, 2013, 1, '2013-07-23', '2013-07-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (204, 2014, 1, '2014-07-23', '2014-07-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (204, 2015, 1, '2015-07-23', '2015-07-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (205, 2008, 1, '2008-07-23', '2008-07-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (205, 2009, 1, '2009-07-24', '2009-07-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (205, 2010, 1, '2010-07-24', '2010-07-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (205, 2011, 1, '2011-07-24', '2011-07-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (205, 2012, 1, '2012-07-23', '2012-07-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (205, 2013, 1, '2013-07-24', '2013-07-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (205, 2014, 1, '2014-07-24', '2014-07-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (205, 2015, 1, '2015-07-24', '2015-07-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (206, 2008, 1, '2008-07-24', '2008-07-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (206, 2009, 1, '2009-07-25', '2009-07-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (206, 2010, 1, '2010-07-25', '2010-07-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (206, 2011, 1, '2011-07-25', '2011-07-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (206, 2012, 1, '2012-07-24', '2012-07-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (206, 2013, 1, '2013-07-25', '2013-07-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (206, 2014, 1, '2014-07-25', '2014-07-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (206, 2015, 1, '2015-07-25', '2015-07-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (207, 2008, 1, '2008-07-25', '2008-07-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (207, 2009, 1, '2009-07-26', '2009-07-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (207, 2010, 1, '2010-07-26', '2010-07-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (207, 2011, 1, '2011-07-26', '2011-07-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (207, 2012, 1, '2012-07-25', '2012-07-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (207, 2013, 1, '2013-07-26', '2013-07-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (207, 2014, 1, '2014-07-26', '2014-07-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (207, 2015, 1, '2015-07-26', '2015-07-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (208, 2008, 1, '2008-07-26', '2008-07-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (208, 2009, 1, '2009-07-27', '2009-07-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (208, 2010, 1, '2010-07-27', '2010-07-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (208, 2011, 1, '2011-07-27', '2011-07-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (208, 2012, 1, '2012-07-26', '2012-07-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (208, 2013, 1, '2013-07-27', '2013-07-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (208, 2014, 1, '2014-07-27', '2014-07-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (208, 2015, 1, '2015-07-27', '2015-07-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (209, 2008, 1, '2008-07-27', '2008-07-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (209, 2009, 1, '2009-07-28', '2009-07-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (209, 2010, 1, '2010-07-28', '2010-07-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (209, 2011, 1, '2011-07-28', '2011-07-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (209, 2012, 1, '2012-07-27', '2012-07-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (209, 2013, 1, '2013-07-28', '2013-07-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (209, 2014, 1, '2014-07-28', '2014-07-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (209, 2015, 1, '2015-07-28', '2015-07-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (210, 2008, 1, '2008-07-28', '2008-07-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (210, 2009, 1, '2009-07-29', '2009-07-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (210, 2010, 1, '2010-07-29', '2010-07-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (210, 2011, 1, '2011-07-29', '2011-07-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (210, 2012, 1, '2012-07-28', '2012-07-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (210, 2013, 1, '2013-07-29', '2013-07-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (210, 2014, 1, '2014-07-29', '2014-07-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (210, 2015, 1, '2015-07-29', '2015-07-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (211, 2008, 1, '2008-07-29', '2008-07-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (211, 2009, 1, '2009-07-30', '2009-07-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (211, 2010, 1, '2010-07-30', '2010-07-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (211, 2011, 1, '2011-07-30', '2011-07-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (211, 2012, 1, '2012-07-29', '2012-07-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (211, 2013, 1, '2013-07-30', '2013-07-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (211, 2014, 1, '2014-07-30', '2014-07-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (211, 2015, 1, '2015-07-30', '2015-07-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (212, 2008, 1, '2008-07-30', '2008-07-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (212, 2009, 1, '2009-07-31', '2009-07-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (212, 2010, 1, '2010-07-31', '2010-07-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (212, 2011, 1, '2011-07-31', '2011-07-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (212, 2012, 1, '2012-07-30', '2012-07-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (212, 2013, 1, '2013-07-31', '2013-07-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (212, 2014, 1, '2014-07-31', '2014-07-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (212, 2015, 1, '2015-07-31', '2015-07-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (213, 2008, 1, '2008-07-31', '2008-07-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (213, 2009, 1, '2009-08-01', '2009-08-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (213, 2010, 1, '2010-08-01', '2010-08-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (213, 2011, 1, '2011-08-01', '2011-08-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (213, 2012, 1, '2012-07-31', '2012-07-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (213, 2013, 1, '2013-08-01', '2013-08-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (213, 2014, 1, '2014-08-01', '2014-08-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (213, 2015, 1, '2015-08-01', '2015-08-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (214, 2008, 1, '2008-08-01', '2008-08-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (214, 2009, 1, '2009-08-02', '2009-08-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (214, 2010, 1, '2010-08-02', '2010-08-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (214, 2011, 1, '2011-08-02', '2011-08-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (214, 2012, 1, '2012-08-01', '2012-08-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (214, 2013, 1, '2013-08-02', '2013-08-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (214, 2014, 1, '2014-08-02', '2014-08-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (214, 2015, 1, '2015-08-02', '2015-08-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (215, 2008, 1, '2008-08-02', '2008-08-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (215, 2009, 1, '2009-08-03', '2009-08-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (215, 2010, 1, '2010-08-03', '2010-08-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (215, 2011, 1, '2011-08-03', '2011-08-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (215, 2012, 1, '2012-08-02', '2012-08-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (215, 2013, 1, '2013-08-03', '2013-08-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (215, 2014, 1, '2014-08-03', '2014-08-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (215, 2015, 1, '2015-08-03', '2015-08-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (216, 2008, 1, '2008-08-03', '2008-08-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (216, 2009, 1, '2009-08-04', '2009-08-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (216, 2010, 1, '2010-08-04', '2010-08-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (216, 2011, 1, '2011-08-04', '2011-08-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (216, 2012, 1, '2012-08-03', '2012-08-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (216, 2013, 1, '2013-08-04', '2013-08-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (216, 2014, 1, '2014-08-04', '2014-08-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (216, 2015, 1, '2015-08-04', '2015-08-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (217, 2008, 1, '2008-08-04', '2008-08-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (217, 2009, 1, '2009-08-05', '2009-08-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (217, 2010, 1, '2010-08-05', '2010-08-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (217, 2011, 1, '2011-08-05', '2011-08-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (217, 2012, 1, '2012-08-04', '2012-08-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (217, 2013, 1, '2013-08-05', '2013-08-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (217, 2014, 1, '2014-08-05', '2014-08-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (217, 2015, 1, '2015-08-05', '2015-08-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (218, 2008, 1, '2008-08-05', '2008-08-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (218, 2009, 1, '2009-08-06', '2009-08-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (218, 2010, 1, '2010-08-06', '2010-08-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (218, 2011, 1, '2011-08-06', '2011-08-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (218, 2012, 1, '2012-08-05', '2012-08-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (218, 2013, 1, '2013-08-06', '2013-08-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (218, 2014, 1, '2014-08-06', '2014-08-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (218, 2015, 1, '2015-08-06', '2015-08-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (219, 2008, 1, '2008-08-06', '2008-08-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (219, 2009, 1, '2009-08-07', '2009-08-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (219, 2010, 1, '2010-08-07', '2010-08-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (219, 2011, 1, '2011-08-07', '2011-08-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (219, 2012, 1, '2012-08-06', '2012-08-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (219, 2013, 1, '2013-08-07', '2013-08-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (219, 2014, 1, '2014-08-07', '2014-08-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (219, 2015, 1, '2015-08-07', '2015-08-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (220, 2008, 1, '2008-08-07', '2008-08-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (220, 2009, 1, '2009-08-08', '2009-08-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (220, 2010, 1, '2010-08-08', '2010-08-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (220, 2011, 1, '2011-08-08', '2011-08-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (220, 2012, 1, '2012-08-07', '2012-08-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (220, 2013, 1, '2013-08-08', '2013-08-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (220, 2014, 1, '2014-08-08', '2014-08-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (220, 2015, 1, '2015-08-08', '2015-08-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (221, 2008, 1, '2008-08-08', '2008-08-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (221, 2009, 1, '2009-08-09', '2009-08-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (221, 2010, 1, '2010-08-09', '2010-08-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (221, 2011, 1, '2011-08-09', '2011-08-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (221, 2012, 1, '2012-08-08', '2012-08-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (221, 2013, 1, '2013-08-09', '2013-08-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (221, 2014, 1, '2014-08-09', '2014-08-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (221, 2015, 1, '2015-08-09', '2015-08-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (222, 2008, 1, '2008-08-09', '2008-08-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (222, 2009, 1, '2009-08-10', '2009-08-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (222, 2010, 1, '2010-08-10', '2010-08-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (222, 2011, 1, '2011-08-10', '2011-08-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (222, 2012, 1, '2012-08-09', '2012-08-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (222, 2013, 1, '2013-08-10', '2013-08-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (222, 2014, 1, '2014-08-10', '2014-08-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (222, 2015, 1, '2015-08-10', '2015-08-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (223, 2008, 1, '2008-08-10', '2008-08-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (223, 2009, 1, '2009-08-11', '2009-08-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (223, 2010, 1, '2010-08-11', '2010-08-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (223, 2011, 1, '2011-08-11', '2011-08-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (223, 2012, 1, '2012-08-10', '2012-08-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (223, 2013, 1, '2013-08-11', '2013-08-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (223, 2014, 1, '2014-08-11', '2014-08-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (223, 2015, 1, '2015-08-11', '2015-08-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (224, 2008, 1, '2008-08-11', '2008-08-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (224, 2009, 1, '2009-08-12', '2009-08-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (224, 2010, 1, '2010-08-12', '2010-08-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (224, 2011, 1, '2011-08-12', '2011-08-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (224, 2012, 1, '2012-08-11', '2012-08-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (224, 2013, 1, '2013-08-12', '2013-08-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (224, 2014, 1, '2014-08-12', '2014-08-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (224, 2015, 1, '2015-08-12', '2015-08-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (225, 2008, 1, '2008-08-12', '2008-08-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (225, 2009, 1, '2009-08-13', '2009-08-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (225, 2010, 1, '2010-08-13', '2010-08-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (225, 2011, 1, '2011-08-13', '2011-08-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (225, 2012, 1, '2012-08-12', '2012-08-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (225, 2013, 1, '2013-08-13', '2013-08-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (225, 2014, 1, '2014-08-13', '2014-08-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (225, 2015, 1, '2015-08-13', '2015-08-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (226, 2008, 1, '2008-08-13', '2008-08-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (226, 2009, 1, '2009-08-14', '2009-08-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (226, 2010, 1, '2010-08-14', '2010-08-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (226, 2011, 1, '2011-08-14', '2011-08-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (226, 2012, 1, '2012-08-13', '2012-08-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (226, 2013, 1, '2013-08-14', '2013-08-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (226, 2014, 1, '2014-08-14', '2014-08-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (226, 2015, 1, '2015-08-14', '2015-08-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (227, 2008, 1, '2008-08-14', '2008-08-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (227, 2009, 1, '2009-08-15', '2009-08-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (227, 2010, 1, '2010-08-15', '2010-08-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (227, 2011, 1, '2011-08-15', '2011-08-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (227, 2012, 1, '2012-08-14', '2012-08-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (227, 2013, 1, '2013-08-15', '2013-08-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (227, 2014, 1, '2014-08-15', '2014-08-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (227, 2015, 1, '2015-08-15', '2015-08-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (228, 2008, 1, '2008-08-15', '2008-08-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (228, 2009, 1, '2009-08-16', '2009-08-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (228, 2010, 1, '2010-08-16', '2010-08-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (228, 2011, 1, '2011-08-16', '2011-08-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (228, 2012, 1, '2012-08-15', '2012-08-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (228, 2013, 1, '2013-08-16', '2013-08-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (228, 2014, 1, '2014-08-16', '2014-08-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (228, 2015, 1, '2015-08-16', '2015-08-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (229, 2008, 1, '2008-08-16', '2008-08-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (229, 2009, 1, '2009-08-17', '2009-08-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (229, 2010, 1, '2010-08-17', '2010-08-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (229, 2011, 1, '2011-08-17', '2011-08-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (229, 2012, 1, '2012-08-16', '2012-08-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (229, 2013, 1, '2013-08-17', '2013-08-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (229, 2014, 1, '2014-08-17', '2014-08-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (229, 2015, 1, '2015-08-17', '2015-08-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (230, 2008, 1, '2008-08-17', '2008-08-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (230, 2009, 1, '2009-08-18', '2009-08-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (230, 2010, 1, '2010-08-18', '2010-08-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (230, 2011, 1, '2011-08-18', '2011-08-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (230, 2012, 1, '2012-08-17', '2012-08-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (230, 2013, 1, '2013-08-18', '2013-08-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (230, 2014, 1, '2014-08-18', '2014-08-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (230, 2015, 1, '2015-08-18', '2015-08-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (231, 2008, 1, '2008-08-18', '2008-08-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (231, 2009, 1, '2009-08-19', '2009-08-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (231, 2010, 1, '2010-08-19', '2010-08-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (231, 2011, 1, '2011-08-19', '2011-08-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (231, 2012, 1, '2012-08-18', '2012-08-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (231, 2013, 1, '2013-08-19', '2013-08-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (231, 2014, 1, '2014-08-19', '2014-08-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (231, 2015, 1, '2015-08-19', '2015-08-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (232, 2008, 1, '2008-08-19', '2008-08-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (232, 2009, 1, '2009-08-20', '2009-08-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (232, 2010, 1, '2010-08-20', '2010-08-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (232, 2011, 1, '2011-08-20', '2011-08-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (232, 2012, 1, '2012-08-19', '2012-08-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (232, 2013, 1, '2013-08-20', '2013-08-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (232, 2014, 1, '2014-08-20', '2014-08-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (232, 2015, 1, '2015-08-20', '2015-08-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (233, 2008, 1, '2008-08-20', '2008-08-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (233, 2009, 1, '2009-08-21', '2009-08-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (233, 2010, 1, '2010-08-21', '2010-08-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (233, 2011, 1, '2011-08-21', '2011-08-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (233, 2012, 1, '2012-08-20', '2012-08-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (233, 2013, 1, '2013-08-21', '2013-08-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (233, 2014, 1, '2014-08-21', '2014-08-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (233, 2015, 1, '2015-08-21', '2015-08-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (234, 2008, 1, '2008-08-21', '2008-08-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (234, 2009, 1, '2009-08-22', '2009-08-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (234, 2010, 1, '2010-08-22', '2010-08-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (234, 2011, 1, '2011-08-22', '2011-08-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (234, 2012, 1, '2012-08-21', '2012-08-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (234, 2013, 1, '2013-08-22', '2013-08-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (234, 2014, 1, '2014-08-22', '2014-08-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (234, 2015, 1, '2015-08-22', '2015-08-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (235, 2008, 1, '2008-08-22', '2008-08-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (235, 2009, 1, '2009-08-23', '2009-08-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (235, 2010, 1, '2010-08-23', '2010-08-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (235, 2011, 1, '2011-08-23', '2011-08-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (235, 2012, 1, '2012-08-22', '2012-08-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (235, 2013, 1, '2013-08-23', '2013-08-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (235, 2014, 1, '2014-08-23', '2014-08-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (235, 2015, 1, '2015-08-23', '2015-08-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (236, 2008, 1, '2008-08-23', '2008-08-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (236, 2009, 1, '2009-08-24', '2009-08-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (236, 2010, 1, '2010-08-24', '2010-08-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (236, 2011, 1, '2011-08-24', '2011-08-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (236, 2012, 1, '2012-08-23', '2012-08-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (236, 2013, 1, '2013-08-24', '2013-08-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (236, 2014, 1, '2014-08-24', '2014-08-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (236, 2015, 1, '2015-08-24', '2015-08-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (237, 2008, 1, '2008-08-24', '2008-08-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (237, 2009, 1, '2009-08-25', '2009-08-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (237, 2010, 1, '2010-08-25', '2010-08-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (237, 2011, 1, '2011-08-25', '2011-08-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (237, 2012, 1, '2012-08-24', '2012-08-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (237, 2013, 1, '2013-08-25', '2013-08-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (237, 2014, 1, '2014-08-25', '2014-08-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (237, 2015, 1, '2015-08-25', '2015-08-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (238, 2008, 1, '2008-08-25', '2008-08-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (238, 2009, 1, '2009-08-26', '2009-08-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (238, 2010, 1, '2010-08-26', '2010-08-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (238, 2011, 1, '2011-08-26', '2011-08-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (238, 2012, 1, '2012-08-25', '2012-08-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (238, 2013, 1, '2013-08-26', '2013-08-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (238, 2014, 1, '2014-08-26', '2014-08-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (238, 2015, 1, '2015-08-26', '2015-08-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (239, 2008, 1, '2008-08-26', '2008-08-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (239, 2009, 1, '2009-08-27', '2009-08-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (239, 2010, 1, '2010-08-27', '2010-08-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (239, 2011, 1, '2011-08-27', '2011-08-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (239, 2012, 1, '2012-08-26', '2012-08-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (239, 2013, 1, '2013-08-27', '2013-08-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (239, 2014, 1, '2014-08-27', '2014-08-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (239, 2015, 1, '2015-08-27', '2015-08-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (240, 2008, 1, '2008-08-27', '2008-08-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (240, 2009, 1, '2009-08-28', '2009-08-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (240, 2010, 1, '2010-08-28', '2010-08-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (240, 2011, 1, '2011-08-28', '2011-08-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (240, 2012, 1, '2012-08-27', '2012-08-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (240, 2013, 1, '2013-08-28', '2013-08-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (240, 2014, 1, '2014-08-28', '2014-08-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (240, 2015, 1, '2015-08-28', '2015-08-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (241, 2008, 1, '2008-08-28', '2008-08-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (241, 2009, 1, '2009-08-29', '2009-08-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (241, 2010, 1, '2010-08-29', '2010-08-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (241, 2011, 1, '2011-08-29', '2011-08-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (241, 2012, 1, '2012-08-28', '2012-08-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (241, 2013, 1, '2013-08-29', '2013-08-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (241, 2014, 1, '2014-08-29', '2014-08-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (241, 2015, 1, '2015-08-29', '2015-08-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (242, 2008, 1, '2008-08-29', '2008-08-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (242, 2009, 1, '2009-08-30', '2009-08-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (242, 2010, 1, '2010-08-30', '2010-08-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (242, 2011, 1, '2011-08-30', '2011-08-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (242, 2012, 1, '2012-08-29', '2012-08-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (242, 2013, 1, '2013-08-30', '2013-08-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (242, 2014, 1, '2014-08-30', '2014-08-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (242, 2015, 1, '2015-08-30', '2015-08-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (243, 2008, 1, '2008-08-30', '2008-08-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (243, 2009, 1, '2009-08-31', '2009-08-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (243, 2010, 1, '2010-08-31', '2010-08-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (243, 2011, 1, '2011-08-31', '2011-08-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (243, 2012, 1, '2012-08-30', '2012-08-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (243, 2013, 1, '2013-08-31', '2013-08-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (243, 2014, 1, '2014-08-31', '2014-08-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (243, 2015, 1, '2015-08-31', '2015-08-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (244, 2008, 1, '2008-08-31', '2008-08-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (244, 2009, 1, '2009-09-01', '2009-09-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (244, 2010, 1, '2010-09-01', '2010-09-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (244, 2011, 1, '2011-09-01', '2011-09-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (244, 2012, 1, '2012-08-31', '2012-08-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (244, 2013, 1, '2013-09-01', '2013-09-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (244, 2014, 1, '2014-09-01', '2014-09-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (244, 2015, 1, '2015-09-01', '2015-09-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (245, 2008, 1, '2008-09-01', '2008-09-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (245, 2009, 1, '2009-09-02', '2009-09-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (245, 2010, 1, '2010-09-02', '2010-09-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (245, 2011, 1, '2011-09-02', '2011-09-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (245, 2012, 1, '2012-09-01', '2012-09-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (245, 2013, 1, '2013-09-02', '2013-09-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (245, 2014, 1, '2014-09-02', '2014-09-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (245, 2015, 1, '2015-09-02', '2015-09-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (246, 2008, 1, '2008-09-02', '2008-09-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (246, 2009, 1, '2009-09-03', '2009-09-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (246, 2010, 1, '2010-09-03', '2010-09-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (246, 2011, 1, '2011-09-03', '2011-09-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (246, 2012, 1, '2012-09-02', '2012-09-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (246, 2013, 1, '2013-09-03', '2013-09-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (246, 2014, 1, '2014-09-03', '2014-09-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (246, 2015, 1, '2015-09-03', '2015-09-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (247, 2008, 1, '2008-09-03', '2008-09-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (247, 2009, 1, '2009-09-04', '2009-09-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (247, 2010, 1, '2010-09-04', '2010-09-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (247, 2011, 1, '2011-09-04', '2011-09-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (247, 2012, 1, '2012-09-03', '2012-09-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (247, 2013, 1, '2013-09-04', '2013-09-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (247, 2014, 1, '2014-09-04', '2014-09-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (247, 2015, 1, '2015-09-04', '2015-09-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (248, 2008, 1, '2008-09-04', '2008-09-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (248, 2009, 1, '2009-09-05', '2009-09-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (248, 2010, 1, '2010-09-05', '2010-09-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (248, 2011, 1, '2011-09-05', '2011-09-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (248, 2012, 1, '2012-09-04', '2012-09-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (248, 2013, 1, '2013-09-05', '2013-09-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (248, 2014, 1, '2014-09-05', '2014-09-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (248, 2015, 1, '2015-09-05', '2015-09-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (249, 2008, 1, '2008-09-05', '2008-09-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (249, 2009, 1, '2009-09-06', '2009-09-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (249, 2010, 1, '2010-09-06', '2010-09-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (249, 2011, 1, '2011-09-06', '2011-09-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (249, 2012, 1, '2012-09-05', '2012-09-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (249, 2013, 1, '2013-09-06', '2013-09-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (249, 2014, 1, '2014-09-06', '2014-09-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (249, 2015, 1, '2015-09-06', '2015-09-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (250, 2008, 1, '2008-09-06', '2008-09-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (250, 2009, 1, '2009-09-07', '2009-09-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (250, 2010, 1, '2010-09-07', '2010-09-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (250, 2011, 1, '2011-09-07', '2011-09-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (250, 2012, 1, '2012-09-06', '2012-09-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (250, 2013, 1, '2013-09-07', '2013-09-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (250, 2014, 1, '2014-09-07', '2014-09-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (250, 2015, 1, '2015-09-07', '2015-09-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (251, 2008, 1, '2008-09-07', '2008-09-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (251, 2009, 1, '2009-09-08', '2009-09-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (251, 2010, 1, '2010-09-08', '2010-09-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (251, 2011, 1, '2011-09-08', '2011-09-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (251, 2012, 1, '2012-09-07', '2012-09-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (251, 2013, 1, '2013-09-08', '2013-09-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (251, 2014, 1, '2014-09-08', '2014-09-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (251, 2015, 1, '2015-09-08', '2015-09-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (252, 2008, 1, '2008-09-08', '2008-09-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (252, 2009, 1, '2009-09-09', '2009-09-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (252, 2010, 1, '2010-09-09', '2010-09-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (252, 2011, 1, '2011-09-09', '2011-09-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (252, 2012, 1, '2012-09-08', '2012-09-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (252, 2013, 1, '2013-09-09', '2013-09-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (252, 2014, 1, '2014-09-09', '2014-09-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (252, 2015, 1, '2015-09-09', '2015-09-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (253, 2008, 1, '2008-09-09', '2008-09-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (253, 2009, 1, '2009-09-10', '2009-09-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (253, 2010, 1, '2010-09-10', '2010-09-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (253, 2011, 1, '2011-09-10', '2011-09-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (253, 2012, 1, '2012-09-09', '2012-09-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (253, 2013, 1, '2013-09-10', '2013-09-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (253, 2014, 1, '2014-09-10', '2014-09-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (253, 2015, 1, '2015-09-10', '2015-09-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (254, 2008, 1, '2008-09-10', '2008-09-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (254, 2009, 1, '2009-09-11', '2009-09-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (254, 2010, 1, '2010-09-11', '2010-09-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (254, 2011, 1, '2011-09-11', '2011-09-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (254, 2012, 1, '2012-09-10', '2012-09-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (254, 2013, 1, '2013-09-11', '2013-09-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (254, 2014, 1, '2014-09-11', '2014-09-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (254, 2015, 1, '2015-09-11', '2015-09-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (255, 2008, 1, '2008-09-11', '2008-09-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (255, 2009, 1, '2009-09-12', '2009-09-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (255, 2010, 1, '2010-09-12', '2010-09-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (255, 2011, 1, '2011-09-12', '2011-09-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (255, 2012, 1, '2012-09-11', '2012-09-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (255, 2013, 1, '2013-09-12', '2013-09-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (255, 2014, 1, '2014-09-12', '2014-09-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (255, 2015, 1, '2015-09-12', '2015-09-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (256, 2008, 1, '2008-09-12', '2008-09-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (256, 2009, 1, '2009-09-13', '2009-09-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (256, 2010, 1, '2010-09-13', '2010-09-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (256, 2011, 1, '2011-09-13', '2011-09-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (256, 2012, 1, '2012-09-12', '2012-09-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (256, 2013, 1, '2013-09-13', '2013-09-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (256, 2014, 1, '2014-09-13', '2014-09-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (256, 2015, 1, '2015-09-13', '2015-09-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (257, 2008, 1, '2008-09-13', '2008-09-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (257, 2009, 1, '2009-09-14', '2009-09-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (257, 2010, 1, '2010-09-14', '2010-09-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (257, 2011, 1, '2011-09-14', '2011-09-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (257, 2012, 1, '2012-09-13', '2012-09-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (257, 2013, 1, '2013-09-14', '2013-09-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (257, 2014, 1, '2014-09-14', '2014-09-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (257, 2015, 1, '2015-09-14', '2015-09-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (258, 2008, 1, '2008-09-14', '2008-09-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (258, 2009, 1, '2009-09-15', '2009-09-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (258, 2010, 1, '2010-09-15', '2010-09-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (258, 2011, 1, '2011-09-15', '2011-09-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (258, 2012, 1, '2012-09-14', '2012-09-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (258, 2013, 1, '2013-09-15', '2013-09-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (258, 2014, 1, '2014-09-15', '2014-09-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (258, 2015, 1, '2015-09-15', '2015-09-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (259, 2008, 1, '2008-09-15', '2008-09-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (259, 2009, 1, '2009-09-16', '2009-09-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (259, 2010, 1, '2010-09-16', '2010-09-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (259, 2011, 1, '2011-09-16', '2011-09-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (259, 2012, 1, '2012-09-15', '2012-09-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (259, 2013, 1, '2013-09-16', '2013-09-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (259, 2014, 1, '2014-09-16', '2014-09-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (259, 2015, 1, '2015-09-16', '2015-09-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (260, 2008, 1, '2008-09-16', '2008-09-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (260, 2009, 1, '2009-09-17', '2009-09-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (260, 2010, 1, '2010-09-17', '2010-09-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (260, 2011, 1, '2011-09-17', '2011-09-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (260, 2012, 1, '2012-09-16', '2012-09-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (260, 2013, 1, '2013-09-17', '2013-09-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (260, 2014, 1, '2014-09-17', '2014-09-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (260, 2015, 1, '2015-09-17', '2015-09-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (261, 2008, 1, '2008-09-17', '2008-09-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (261, 2009, 1, '2009-09-18', '2009-09-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (261, 2010, 1, '2010-09-18', '2010-09-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (261, 2011, 1, '2011-09-18', '2011-09-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (261, 2012, 1, '2012-09-17', '2012-09-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (261, 2013, 1, '2013-09-18', '2013-09-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (261, 2014, 1, '2014-09-18', '2014-09-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (261, 2015, 1, '2015-09-18', '2015-09-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (262, 2008, 1, '2008-09-18', '2008-09-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (262, 2009, 1, '2009-09-19', '2009-09-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (262, 2010, 1, '2010-09-19', '2010-09-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (262, 2011, 1, '2011-09-19', '2011-09-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (262, 2012, 1, '2012-09-18', '2012-09-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (262, 2013, 1, '2013-09-19', '2013-09-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (262, 2014, 1, '2014-09-19', '2014-09-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (262, 2015, 1, '2015-09-19', '2015-09-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (263, 2008, 1, '2008-09-19', '2008-09-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (263, 2009, 1, '2009-09-20', '2009-09-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (263, 2010, 1, '2010-09-20', '2010-09-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (263, 2011, 1, '2011-09-20', '2011-09-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (263, 2012, 1, '2012-09-19', '2012-09-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (263, 2013, 1, '2013-09-20', '2013-09-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (263, 2014, 1, '2014-09-20', '2014-09-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (263, 2015, 1, '2015-09-20', '2015-09-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (264, 2008, 1, '2008-09-20', '2008-09-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (264, 2009, 1, '2009-09-21', '2009-09-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (264, 2010, 1, '2010-09-21', '2010-09-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (264, 2011, 1, '2011-09-21', '2011-09-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (264, 2012, 1, '2012-09-20', '2012-09-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (264, 2013, 1, '2013-09-21', '2013-09-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (264, 2014, 1, '2014-09-21', '2014-09-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (264, 2015, 1, '2015-09-21', '2015-09-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (265, 2008, 1, '2008-09-21', '2008-09-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (265, 2009, 1, '2009-09-22', '2009-09-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (265, 2010, 1, '2010-09-22', '2010-09-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (265, 2011, 1, '2011-09-22', '2011-09-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (265, 2012, 1, '2012-09-21', '2012-09-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (265, 2013, 1, '2013-09-22', '2013-09-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (265, 2014, 1, '2014-09-22', '2014-09-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (265, 2015, 1, '2015-09-22', '2015-09-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (266, 2008, 1, '2008-09-22', '2008-09-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (266, 2009, 1, '2009-09-23', '2009-09-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (266, 2010, 1, '2010-09-23', '2010-09-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (266, 2011, 1, '2011-09-23', '2011-09-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (266, 2012, 1, '2012-09-22', '2012-09-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (266, 2013, 1, '2013-09-23', '2013-09-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (266, 2014, 1, '2014-09-23', '2014-09-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (266, 2015, 1, '2015-09-23', '2015-09-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (267, 2008, 1, '2008-09-23', '2008-09-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (267, 2009, 1, '2009-09-24', '2009-09-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (267, 2010, 1, '2010-09-24', '2010-09-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (267, 2011, 1, '2011-09-24', '2011-09-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (267, 2012, 1, '2012-09-23', '2012-09-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (267, 2013, 1, '2013-09-24', '2013-09-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (267, 2014, 1, '2014-09-24', '2014-09-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (267, 2015, 1, '2015-09-24', '2015-09-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (268, 2008, 1, '2008-09-24', '2008-09-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (268, 2009, 1, '2009-09-25', '2009-09-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (268, 2010, 1, '2010-09-25', '2010-09-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (268, 2011, 1, '2011-09-25', '2011-09-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (268, 2012, 1, '2012-09-24', '2012-09-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (268, 2013, 1, '2013-09-25', '2013-09-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (268, 2014, 1, '2014-09-25', '2014-09-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (268, 2015, 1, '2015-09-25', '2015-09-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (269, 2008, 1, '2008-09-25', '2008-09-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (269, 2009, 1, '2009-09-26', '2009-09-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (269, 2010, 1, '2010-09-26', '2010-09-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (269, 2011, 1, '2011-09-26', '2011-09-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (269, 2012, 1, '2012-09-25', '2012-09-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (269, 2013, 1, '2013-09-26', '2013-09-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (269, 2014, 1, '2014-09-26', '2014-09-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (269, 2015, 1, '2015-09-26', '2015-09-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (270, 2008, 1, '2008-09-26', '2008-09-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (270, 2009, 1, '2009-09-27', '2009-09-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (270, 2010, 1, '2010-09-27', '2010-09-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (270, 2011, 1, '2011-09-27', '2011-09-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (270, 2012, 1, '2012-09-26', '2012-09-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (270, 2013, 1, '2013-09-27', '2013-09-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (270, 2014, 1, '2014-09-27', '2014-09-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (270, 2015, 1, '2015-09-27', '2015-09-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (271, 2008, 1, '2008-09-27', '2008-09-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (271, 2009, 1, '2009-09-28', '2009-09-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (271, 2010, 1, '2010-09-28', '2010-09-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (271, 2011, 1, '2011-09-28', '2011-09-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (271, 2012, 1, '2012-09-27', '2012-09-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (271, 2013, 1, '2013-09-28', '2013-09-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (271, 2014, 1, '2014-09-28', '2014-09-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (271, 2015, 1, '2015-09-28', '2015-09-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (272, 2008, 1, '2008-09-28', '2008-09-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (272, 2009, 1, '2009-09-29', '2009-09-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (272, 2010, 1, '2010-09-29', '2010-09-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (272, 2011, 1, '2011-09-29', '2011-09-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (272, 2012, 1, '2012-09-28', '2012-09-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (272, 2013, 1, '2013-09-29', '2013-09-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (272, 2014, 1, '2014-09-29', '2014-09-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (272, 2015, 1, '2015-09-29', '2015-09-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (273, 2008, 1, '2008-09-29', '2008-09-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (273, 2009, 1, '2009-09-30', '2009-09-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (273, 2010, 1, '2010-09-30', '2010-09-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (273, 2011, 1, '2011-09-30', '2011-09-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (273, 2012, 1, '2012-09-29', '2012-09-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (273, 2013, 1, '2013-09-30', '2013-09-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (273, 2014, 1, '2014-09-30', '2014-09-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (273, 2015, 1, '2015-09-30', '2015-09-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (274, 2008, 1, '2008-09-30', '2008-09-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (274, 2009, 1, '2009-10-01', '2009-10-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (274, 2010, 1, '2010-10-01', '2010-10-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (274, 2011, 1, '2011-10-01', '2011-10-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (274, 2012, 1, '2012-09-30', '2012-09-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (274, 2013, 1, '2013-10-01', '2013-10-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (274, 2014, 1, '2014-10-01', '2014-10-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (274, 2015, 1, '2015-10-01', '2015-10-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (275, 2008, 1, '2008-10-01', '2008-10-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (275, 2009, 1, '2009-10-02', '2009-10-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (275, 2010, 1, '2010-10-02', '2010-10-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (275, 2011, 1, '2011-10-02', '2011-10-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (275, 2012, 1, '2012-10-01', '2012-10-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (275, 2013, 1, '2013-10-02', '2013-10-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (275, 2014, 1, '2014-10-02', '2014-10-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (275, 2015, 1, '2015-10-02', '2015-10-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (276, 2008, 1, '2008-10-02', '2008-10-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (276, 2009, 1, '2009-10-03', '2009-10-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (276, 2010, 1, '2010-10-03', '2010-10-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (276, 2011, 1, '2011-10-03', '2011-10-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (276, 2012, 1, '2012-10-02', '2012-10-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (276, 2013, 1, '2013-10-03', '2013-10-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (276, 2014, 1, '2014-10-03', '2014-10-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (276, 2015, 1, '2015-10-03', '2015-10-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (277, 2008, 1, '2008-10-03', '2008-10-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (277, 2009, 1, '2009-10-04', '2009-10-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (277, 2010, 1, '2010-10-04', '2010-10-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (277, 2011, 1, '2011-10-04', '2011-10-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (277, 2012, 1, '2012-10-03', '2012-10-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (277, 2013, 1, '2013-10-04', '2013-10-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (277, 2014, 1, '2014-10-04', '2014-10-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (277, 2015, 1, '2015-10-04', '2015-10-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (278, 2008, 1, '2008-10-04', '2008-10-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (278, 2009, 1, '2009-10-05', '2009-10-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (278, 2010, 1, '2010-10-05', '2010-10-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (278, 2011, 1, '2011-10-05', '2011-10-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (278, 2012, 1, '2012-10-04', '2012-10-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (278, 2013, 1, '2013-10-05', '2013-10-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (278, 2014, 1, '2014-10-05', '2014-10-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (278, 2015, 1, '2015-10-05', '2015-10-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (279, 2008, 1, '2008-10-05', '2008-10-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (279, 2009, 1, '2009-10-06', '2009-10-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (279, 2010, 1, '2010-10-06', '2010-10-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (279, 2011, 1, '2011-10-06', '2011-10-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (279, 2012, 1, '2012-10-05', '2012-10-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (279, 2013, 1, '2013-10-06', '2013-10-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (279, 2014, 1, '2014-10-06', '2014-10-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (279, 2015, 1, '2015-10-06', '2015-10-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (280, 2008, 1, '2008-10-06', '2008-10-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (280, 2009, 1, '2009-10-07', '2009-10-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (280, 2010, 1, '2010-10-07', '2010-10-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (280, 2011, 1, '2011-10-07', '2011-10-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (280, 2012, 1, '2012-10-06', '2012-10-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (280, 2013, 1, '2013-10-07', '2013-10-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (280, 2014, 1, '2014-10-07', '2014-10-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (280, 2015, 1, '2015-10-07', '2015-10-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (281, 2008, 1, '2008-10-07', '2008-10-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (281, 2009, 1, '2009-10-08', '2009-10-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (281, 2010, 1, '2010-10-08', '2010-10-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (281, 2011, 1, '2011-10-08', '2011-10-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (281, 2012, 1, '2012-10-07', '2012-10-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (281, 2013, 1, '2013-10-08', '2013-10-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (281, 2014, 1, '2014-10-08', '2014-10-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (281, 2015, 1, '2015-10-08', '2015-10-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (282, 2008, 1, '2008-10-08', '2008-10-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (282, 2009, 1, '2009-10-09', '2009-10-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (282, 2010, 1, '2010-10-09', '2010-10-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (282, 2011, 1, '2011-10-09', '2011-10-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (282, 2012, 1, '2012-10-08', '2012-10-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (282, 2013, 1, '2013-10-09', '2013-10-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (282, 2014, 1, '2014-10-09', '2014-10-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (282, 2015, 1, '2015-10-09', '2015-10-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (283, 2008, 1, '2008-10-09', '2008-10-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (283, 2009, 1, '2009-10-10', '2009-10-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (283, 2010, 1, '2010-10-10', '2010-10-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (283, 2011, 1, '2011-10-10', '2011-10-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (283, 2012, 1, '2012-10-09', '2012-10-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (283, 2013, 1, '2013-10-10', '2013-10-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (283, 2014, 1, '2014-10-10', '2014-10-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (283, 2015, 1, '2015-10-10', '2015-10-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (284, 2008, 1, '2008-10-10', '2008-10-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (284, 2009, 1, '2009-10-11', '2009-10-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (284, 2010, 1, '2010-10-11', '2010-10-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (284, 2011, 1, '2011-10-11', '2011-10-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (284, 2012, 1, '2012-10-10', '2012-10-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (284, 2013, 1, '2013-10-11', '2013-10-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (284, 2014, 1, '2014-10-11', '2014-10-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (284, 2015, 1, '2015-10-11', '2015-10-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (285, 2008, 1, '2008-10-11', '2008-10-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (285, 2009, 1, '2009-10-12', '2009-10-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (285, 2010, 1, '2010-10-12', '2010-10-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (285, 2011, 1, '2011-10-12', '2011-10-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (285, 2012, 1, '2012-10-11', '2012-10-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (285, 2013, 1, '2013-10-12', '2013-10-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (285, 2014, 1, '2014-10-12', '2014-10-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (285, 2015, 1, '2015-10-12', '2015-10-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (286, 2008, 1, '2008-10-12', '2008-10-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (286, 2009, 1, '2009-10-13', '2009-10-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (286, 2010, 1, '2010-10-13', '2010-10-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (286, 2011, 1, '2011-10-13', '2011-10-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (286, 2012, 1, '2012-10-12', '2012-10-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (286, 2013, 1, '2013-10-13', '2013-10-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (286, 2014, 1, '2014-10-13', '2014-10-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (286, 2015, 1, '2015-10-13', '2015-10-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (287, 2008, 1, '2008-10-13', '2008-10-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (287, 2009, 1, '2009-10-14', '2009-10-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (287, 2010, 1, '2010-10-14', '2010-10-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (287, 2011, 1, '2011-10-14', '2011-10-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (287, 2012, 1, '2012-10-13', '2012-10-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (287, 2013, 1, '2013-10-14', '2013-10-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (287, 2014, 1, '2014-10-14', '2014-10-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (287, 2015, 1, '2015-10-14', '2015-10-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (288, 2008, 1, '2008-10-14', '2008-10-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (288, 2009, 1, '2009-10-15', '2009-10-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (288, 2010, 1, '2010-10-15', '2010-10-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (288, 2011, 1, '2011-10-15', '2011-10-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (288, 2012, 1, '2012-10-14', '2012-10-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (288, 2013, 1, '2013-10-15', '2013-10-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (288, 2014, 1, '2014-10-15', '2014-10-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (288, 2015, 1, '2015-10-15', '2015-10-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (289, 2008, 1, '2008-10-15', '2008-10-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (289, 2009, 1, '2009-10-16', '2009-10-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (289, 2010, 1, '2010-10-16', '2010-10-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (289, 2011, 1, '2011-10-16', '2011-10-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (289, 2012, 1, '2012-10-15', '2012-10-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (289, 2013, 1, '2013-10-16', '2013-10-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (289, 2014, 1, '2014-10-16', '2014-10-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (289, 2015, 1, '2015-10-16', '2015-10-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (290, 2008, 1, '2008-10-16', '2008-10-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (290, 2009, 1, '2009-10-17', '2009-10-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (290, 2010, 1, '2010-10-17', '2010-10-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (290, 2011, 1, '2011-10-17', '2011-10-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (290, 2012, 1, '2012-10-16', '2012-10-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (290, 2013, 1, '2013-10-17', '2013-10-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (290, 2014, 1, '2014-10-17', '2014-10-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (290, 2015, 1, '2015-10-17', '2015-10-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (291, 2008, 1, '2008-10-17', '2008-10-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (291, 2009, 1, '2009-10-18', '2009-10-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (291, 2010, 1, '2010-10-18', '2010-10-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (291, 2011, 1, '2011-10-18', '2011-10-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (291, 2012, 1, '2012-10-17', '2012-10-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (291, 2013, 1, '2013-10-18', '2013-10-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (291, 2014, 1, '2014-10-18', '2014-10-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (291, 2015, 1, '2015-10-18', '2015-10-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (292, 2008, 1, '2008-10-18', '2008-10-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (292, 2009, 1, '2009-10-19', '2009-10-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (292, 2010, 1, '2010-10-19', '2010-10-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (292, 2011, 1, '2011-10-19', '2011-10-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (292, 2012, 1, '2012-10-18', '2012-10-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (292, 2013, 1, '2013-10-19', '2013-10-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (292, 2014, 1, '2014-10-19', '2014-10-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (292, 2015, 1, '2015-10-19', '2015-10-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (293, 2008, 1, '2008-10-19', '2008-10-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (293, 2009, 1, '2009-10-20', '2009-10-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (293, 2010, 1, '2010-10-20', '2010-10-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (293, 2011, 1, '2011-10-20', '2011-10-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (293, 2012, 1, '2012-10-19', '2012-10-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (293, 2013, 1, '2013-10-20', '2013-10-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (293, 2014, 1, '2014-10-20', '2014-10-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (293, 2015, 1, '2015-10-20', '2015-10-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (294, 2008, 1, '2008-10-20', '2008-10-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (294, 2009, 1, '2009-10-21', '2009-10-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (294, 2010, 1, '2010-10-21', '2010-10-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (294, 2011, 1, '2011-10-21', '2011-10-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (294, 2012, 1, '2012-10-20', '2012-10-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (294, 2013, 1, '2013-10-21', '2013-10-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (294, 2014, 1, '2014-10-21', '2014-10-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (294, 2015, 1, '2015-10-21', '2015-10-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (295, 2008, 1, '2008-10-21', '2008-10-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (295, 2009, 1, '2009-10-22', '2009-10-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (295, 2010, 1, '2010-10-22', '2010-10-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (295, 2011, 1, '2011-10-22', '2011-10-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (295, 2012, 1, '2012-10-21', '2012-10-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (295, 2013, 1, '2013-10-22', '2013-10-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (295, 2014, 1, '2014-10-22', '2014-10-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (295, 2015, 1, '2015-10-22', '2015-10-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (296, 2008, 1, '2008-10-22', '2008-10-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (296, 2009, 1, '2009-10-23', '2009-10-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (296, 2010, 1, '2010-10-23', '2010-10-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (296, 2011, 1, '2011-10-23', '2011-10-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (296, 2012, 1, '2012-10-22', '2012-10-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (296, 2013, 1, '2013-10-23', '2013-10-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (296, 2014, 1, '2014-10-23', '2014-10-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (296, 2015, 1, '2015-10-23', '2015-10-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (297, 2008, 1, '2008-10-23', '2008-10-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (297, 2009, 1, '2009-10-24', '2009-10-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (297, 2010, 1, '2010-10-24', '2010-10-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (297, 2011, 1, '2011-10-24', '2011-10-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (297, 2012, 1, '2012-10-23', '2012-10-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (297, 2013, 1, '2013-10-24', '2013-10-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (297, 2014, 1, '2014-10-24', '2014-10-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (297, 2015, 1, '2015-10-24', '2015-10-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (298, 2008, 1, '2008-10-24', '2008-10-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (298, 2009, 1, '2009-10-25', '2009-10-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (298, 2010, 1, '2010-10-25', '2010-10-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (298, 2011, 1, '2011-10-25', '2011-10-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (298, 2012, 1, '2012-10-24', '2012-10-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (298, 2013, 1, '2013-10-25', '2013-10-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (298, 2014, 1, '2014-10-25', '2014-10-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (298, 2015, 1, '2015-10-25', '2015-10-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (299, 2008, 1, '2008-10-25', '2008-10-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (299, 2009, 1, '2009-10-26', '2009-10-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (299, 2010, 1, '2010-10-26', '2010-10-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (299, 2011, 1, '2011-10-26', '2011-10-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (299, 2012, 1, '2012-10-25', '2012-10-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (299, 2013, 1, '2013-10-26', '2013-10-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (299, 2014, 1, '2014-10-26', '2014-10-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (299, 2015, 1, '2015-10-26', '2015-10-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (300, 2008, 1, '2008-10-26', '2008-10-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (300, 2009, 1, '2009-10-27', '2009-10-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (300, 2010, 1, '2010-10-27', '2010-10-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (300, 2011, 1, '2011-10-27', '2011-10-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (300, 2012, 1, '2012-10-26', '2012-10-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (300, 2013, 1, '2013-10-27', '2013-10-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (300, 2014, 1, '2014-10-27', '2014-10-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (300, 2015, 1, '2015-10-27', '2015-10-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (301, 2008, 1, '2008-10-27', '2008-10-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (301, 2009, 1, '2009-10-28', '2009-10-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (301, 2010, 1, '2010-10-28', '2010-10-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (301, 2011, 1, '2011-10-28', '2011-10-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (301, 2012, 1, '2012-10-27', '2012-10-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (301, 2013, 1, '2013-10-28', '2013-10-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (301, 2014, 1, '2014-10-28', '2014-10-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (301, 2015, 1, '2015-10-28', '2015-10-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (302, 2008, 1, '2008-10-28', '2008-10-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (302, 2009, 1, '2009-10-29', '2009-10-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (302, 2010, 1, '2010-10-29', '2010-10-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (302, 2011, 1, '2011-10-29', '2011-10-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (302, 2012, 1, '2012-10-28', '2012-10-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (302, 2013, 1, '2013-10-29', '2013-10-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (302, 2014, 1, '2014-10-29', '2014-10-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (302, 2015, 1, '2015-10-29', '2015-10-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (303, 2008, 1, '2008-10-29', '2008-10-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (303, 2009, 1, '2009-10-30', '2009-10-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (303, 2010, 1, '2010-10-30', '2010-10-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (303, 2011, 1, '2011-10-30', '2011-10-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (303, 2012, 1, '2012-10-29', '2012-10-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (303, 2013, 1, '2013-10-30', '2013-10-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (303, 2014, 1, '2014-10-30', '2014-10-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (303, 2015, 1, '2015-10-30', '2015-10-30', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (304, 2008, 1, '2008-10-30', '2008-10-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (304, 2009, 1, '2009-10-31', '2009-10-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (304, 2010, 1, '2010-10-31', '2010-10-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (304, 2011, 1, '2011-10-31', '2011-10-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (304, 2012, 1, '2012-10-30', '2012-10-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (304, 2013, 1, '2013-10-31', '2013-10-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (304, 2014, 1, '2014-10-31', '2014-10-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (304, 2015, 1, '2015-10-31', '2015-10-31', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (305, 2008, 1, '2008-10-31', '2008-10-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (305, 2009, 1, '2009-11-01', '2009-11-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (305, 2010, 1, '2010-11-01', '2010-11-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (305, 2011, 1, '2011-11-01', '2011-11-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (305, 2012, 1, '2012-10-31', '2012-10-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (305, 2013, 1, '2013-11-01', '2013-11-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (305, 2014, 1, '2014-11-01', '2014-11-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (305, 2015, 1, '2015-11-01', '2015-11-01', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (306, 2008, 1, '2008-11-01', '2008-11-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (306, 2009, 1, '2009-11-02', '2009-11-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (306, 2010, 1, '2010-11-02', '2010-11-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (306, 2011, 1, '2011-11-02', '2011-11-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (306, 2012, 1, '2012-11-01', '2012-11-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (306, 2013, 1, '2013-11-02', '2013-11-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (306, 2014, 1, '2014-11-02', '2014-11-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (306, 2015, 1, '2015-11-02', '2015-11-02', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (307, 2008, 1, '2008-11-02', '2008-11-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (307, 2009, 1, '2009-11-03', '2009-11-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (307, 2010, 1, '2010-11-03', '2010-11-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (307, 2011, 1, '2011-11-03', '2011-11-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (307, 2012, 1, '2012-11-02', '2012-11-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (307, 2013, 1, '2013-11-03', '2013-11-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (307, 2014, 1, '2014-11-03', '2014-11-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (307, 2015, 1, '2015-11-03', '2015-11-03', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (308, 2008, 1, '2008-11-03', '2008-11-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (308, 2009, 1, '2009-11-04', '2009-11-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (308, 2010, 1, '2010-11-04', '2010-11-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (308, 2011, 1, '2011-11-04', '2011-11-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (308, 2012, 1, '2012-11-03', '2012-11-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (308, 2013, 1, '2013-11-04', '2013-11-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (308, 2014, 1, '2014-11-04', '2014-11-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (308, 2015, 1, '2015-11-04', '2015-11-04', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (309, 2008, 1, '2008-11-04', '2008-11-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (309, 2009, 1, '2009-11-05', '2009-11-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (309, 2010, 1, '2010-11-05', '2010-11-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (309, 2011, 1, '2011-11-05', '2011-11-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (309, 2012, 1, '2012-11-04', '2012-11-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (309, 2013, 1, '2013-11-05', '2013-11-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (309, 2014, 1, '2014-11-05', '2014-11-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (309, 2015, 1, '2015-11-05', '2015-11-05', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (310, 2008, 1, '2008-11-05', '2008-11-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (310, 2009, 1, '2009-11-06', '2009-11-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (310, 2010, 1, '2010-11-06', '2010-11-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (310, 2011, 1, '2011-11-06', '2011-11-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (310, 2012, 1, '2012-11-05', '2012-11-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (310, 2013, 1, '2013-11-06', '2013-11-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (310, 2014, 1, '2014-11-06', '2014-11-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (310, 2015, 1, '2015-11-06', '2015-11-06', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (311, 2008, 1, '2008-11-06', '2008-11-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (311, 2009, 1, '2009-11-07', '2009-11-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (311, 2010, 1, '2010-11-07', '2010-11-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (311, 2011, 1, '2011-11-07', '2011-11-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (311, 2012, 1, '2012-11-06', '2012-11-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (311, 2013, 1, '2013-11-07', '2013-11-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (311, 2014, 1, '2014-11-07', '2014-11-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (311, 2015, 1, '2015-11-07', '2015-11-07', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (312, 2008, 1, '2008-11-07', '2008-11-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (312, 2009, 1, '2009-11-08', '2009-11-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (312, 2010, 1, '2010-11-08', '2010-11-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (312, 2011, 1, '2011-11-08', '2011-11-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (312, 2012, 1, '2012-11-07', '2012-11-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (312, 2013, 1, '2013-11-08', '2013-11-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (312, 2014, 1, '2014-11-08', '2014-11-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (312, 2015, 1, '2015-11-08', '2015-11-08', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (313, 2008, 1, '2008-11-08', '2008-11-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (313, 2009, 1, '2009-11-09', '2009-11-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (313, 2010, 1, '2010-11-09', '2010-11-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (313, 2011, 1, '2011-11-09', '2011-11-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (313, 2012, 1, '2012-11-08', '2012-11-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (313, 2013, 1, '2013-11-09', '2013-11-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (313, 2014, 1, '2014-11-09', '2014-11-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (313, 2015, 1, '2015-11-09', '2015-11-09', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (314, 2008, 1, '2008-11-09', '2008-11-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (314, 2009, 1, '2009-11-10', '2009-11-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (314, 2010, 1, '2010-11-10', '2010-11-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (314, 2011, 1, '2011-11-10', '2011-11-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (314, 2012, 1, '2012-11-09', '2012-11-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (314, 2013, 1, '2013-11-10', '2013-11-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (314, 2014, 1, '2014-11-10', '2014-11-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (314, 2015, 1, '2015-11-10', '2015-11-10', 'A', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (315, 2008, 1, '2008-11-10', '2008-11-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (315, 2009, 1, '2009-11-11', '2009-11-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (315, 2010, 1, '2010-11-11', '2010-11-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (315, 2011, 1, '2011-11-11', '2011-11-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (315, 2012, 1, '2012-11-10', '2012-11-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (315, 2013, 1, '2013-11-11', '2013-11-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (315, 2014, 1, '2014-11-11', '2014-11-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (315, 2015, 1, '2015-11-11', '2015-11-11', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (316, 2008, 1, '2008-11-11', '2008-11-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (316, 2009, 1, '2009-11-12', '2009-11-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (316, 2010, 1, '2010-11-12', '2010-11-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (316, 2011, 1, '2011-11-12', '2011-11-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (316, 2012, 1, '2012-11-11', '2012-11-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (316, 2013, 1, '2013-11-12', '2013-11-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (316, 2014, 1, '2014-11-12', '2014-11-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (316, 2015, 1, '2015-11-12', '2015-11-12', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (317, 2008, 1, '2008-11-12', '2008-11-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (317, 2009, 1, '2009-11-13', '2009-11-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (317, 2010, 1, '2010-11-13', '2010-11-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (317, 2011, 1, '2011-11-13', '2011-11-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (317, 2012, 1, '2012-11-12', '2012-11-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (317, 2013, 1, '2013-11-13', '2013-11-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (317, 2014, 1, '2014-11-13', '2014-11-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (317, 2015, 1, '2015-11-13', '2015-11-13', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (318, 2008, 1, '2008-11-13', '2008-11-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (318, 2009, 1, '2009-11-14', '2009-11-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (318, 2010, 1, '2010-11-14', '2010-11-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (318, 2011, 1, '2011-11-14', '2011-11-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (318, 2012, 1, '2012-11-13', '2012-11-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (318, 2013, 1, '2013-11-14', '2013-11-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (318, 2014, 1, '2014-11-14', '2014-11-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (318, 2015, 1, '2015-11-14', '2015-11-14', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (319, 2008, 1, '2008-11-14', '2008-11-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (319, 2009, 1, '2009-11-15', '2009-11-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (319, 2010, 1, '2010-11-15', '2010-11-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (319, 2011, 1, '2011-11-15', '2011-11-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (319, 2012, 1, '2012-11-14', '2012-11-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (319, 2013, 1, '2013-11-15', '2013-11-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (319, 2014, 1, '2014-11-15', '2014-11-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (319, 2015, 1, '2015-11-15', '2015-11-15', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (320, 2008, 1, '2008-11-15', '2008-11-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (320, 2009, 1, '2009-11-16', '2009-11-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (320, 2010, 1, '2010-11-16', '2010-11-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (320, 2011, 1, '2011-11-16', '2011-11-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (320, 2012, 1, '2012-11-15', '2012-11-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (320, 2013, 1, '2013-11-16', '2013-11-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (320, 2014, 1, '2014-11-16', '2014-11-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (320, 2015, 1, '2015-11-16', '2015-11-16', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (321, 2008, 1, '2008-11-16', '2008-11-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (321, 2009, 1, '2009-11-17', '2009-11-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (321, 2010, 1, '2010-11-17', '2010-11-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (321, 2011, 1, '2011-11-17', '2011-11-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (321, 2012, 1, '2012-11-16', '2012-11-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (321, 2013, 1, '2013-11-17', '2013-11-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (321, 2014, 1, '2014-11-17', '2014-11-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (321, 2015, 1, '2015-11-17', '2015-11-17', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (322, 2008, 1, '2008-11-17', '2008-11-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (322, 2009, 1, '2009-11-18', '2009-11-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (322, 2010, 1, '2010-11-18', '2010-11-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (322, 2011, 1, '2011-11-18', '2011-11-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (322, 2012, 1, '2012-11-17', '2012-11-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (322, 2013, 1, '2013-11-18', '2013-11-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (322, 2014, 1, '2014-11-18', '2014-11-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (322, 2015, 1, '2015-11-18', '2015-11-18', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (323, 2008, 1, '2008-11-18', '2008-11-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (323, 2009, 1, '2009-11-19', '2009-11-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (323, 2010, 1, '2010-11-19', '2010-11-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (323, 2011, 1, '2011-11-19', '2011-11-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (323, 2012, 1, '2012-11-18', '2012-11-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (323, 2013, 1, '2013-11-19', '2013-11-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (323, 2014, 1, '2014-11-19', '2014-11-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (323, 2015, 1, '2015-11-19', '2015-11-19', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (324, 2008, 1, '2008-11-19', '2008-11-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (324, 2009, 1, '2009-11-20', '2009-11-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (324, 2010, 1, '2010-11-20', '2010-11-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (324, 2011, 1, '2011-11-20', '2011-11-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (324, 2012, 1, '2012-11-19', '2012-11-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (324, 2013, 1, '2013-11-20', '2013-11-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (324, 2014, 1, '2014-11-20', '2014-11-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (324, 2015, 1, '2015-11-20', '2015-11-20', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (325, 2008, 1, '2008-11-20', '2008-11-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (325, 2009, 1, '2009-11-21', '2009-11-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (325, 2010, 1, '2010-11-21', '2010-11-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (325, 2011, 1, '2011-11-21', '2011-11-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (325, 2012, 1, '2012-11-20', '2012-11-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (325, 2013, 1, '2013-11-21', '2013-11-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (325, 2014, 1, '2014-11-21', '2014-11-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (325, 2015, 1, '2015-11-21', '2015-11-21', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (326, 2008, 1, '2008-11-21', '2008-11-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (326, 2009, 1, '2009-11-22', '2009-11-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (326, 2010, 1, '2010-11-22', '2010-11-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (326, 2011, 1, '2011-11-22', '2011-11-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (326, 2012, 1, '2012-11-21', '2012-11-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (326, 2013, 1, '2013-11-22', '2013-11-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (326, 2014, 1, '2014-11-22', '2014-11-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (326, 2015, 1, '2015-11-22', '2015-11-22', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (327, 2008, 1, '2008-11-22', '2008-11-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (327, 2009, 1, '2009-11-23', '2009-11-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (327, 2010, 1, '2010-11-23', '2010-11-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (327, 2011, 1, '2011-11-23', '2011-11-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (327, 2012, 1, '2012-11-22', '2012-11-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (327, 2013, 1, '2013-11-23', '2013-11-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (327, 2014, 1, '2014-11-23', '2014-11-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (327, 2015, 1, '2015-11-23', '2015-11-23', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (328, 2008, 1, '2008-11-23', '2008-11-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (328, 2009, 1, '2009-11-24', '2009-11-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (328, 2010, 1, '2010-11-24', '2010-11-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (328, 2011, 1, '2011-11-24', '2011-11-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (328, 2012, 1, '2012-11-23', '2012-11-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (328, 2013, 1, '2013-11-24', '2013-11-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (328, 2014, 1, '2014-11-24', '2014-11-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (328, 2015, 1, '2015-11-24', '2015-11-24', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (329, 2008, 1, '2008-11-24', '2008-11-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (329, 2009, 1, '2009-11-25', '2009-11-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (329, 2010, 1, '2010-11-25', '2010-11-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (329, 2011, 1, '2011-11-25', '2011-11-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (329, 2012, 1, '2012-11-24', '2012-11-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (329, 2013, 1, '2013-11-25', '2013-11-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (329, 2014, 1, '2014-11-25', '2014-11-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (329, 2015, 1, '2015-11-25', '2015-11-25', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (330, 2008, 1, '2008-11-25', '2008-11-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (330, 2009, 1, '2009-11-26', '2009-11-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (330, 2010, 1, '2010-11-26', '2010-11-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (330, 2011, 1, '2011-11-26', '2011-11-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (330, 2012, 1, '2012-11-25', '2012-11-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (330, 2013, 1, '2013-11-26', '2013-11-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (330, 2014, 1, '2014-11-26', '2014-11-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (330, 2015, 1, '2015-11-26', '2015-11-26', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (331, 2008, 1, '2008-11-26', '2008-11-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (331, 2009, 1, '2009-11-27', '2009-11-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (331, 2010, 1, '2010-11-27', '2010-11-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (331, 2011, 1, '2011-11-27', '2011-11-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (331, 2012, 1, '2012-11-26', '2012-11-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (331, 2013, 1, '2013-11-27', '2013-11-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (331, 2014, 1, '2014-11-27', '2014-11-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (331, 2015, 1, '2015-11-27', '2015-11-27', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (332, 2008, 1, '2008-11-27', '2008-11-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (332, 2009, 1, '2009-11-28', '2009-11-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (332, 2010, 1, '2010-11-28', '2010-11-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (332, 2011, 1, '2011-11-28', '2011-11-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (332, 2012, 1, '2012-11-27', '2012-11-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (332, 2013, 1, '2013-11-28', '2013-11-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (332, 2014, 1, '2014-11-28', '2014-11-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (332, 2015, 1, '2015-11-28', '2015-11-28', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (333, 2008, 1, '2008-11-28', '2008-11-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (333, 2009, 1, '2009-11-29', '2009-11-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (333, 2010, 1, '2010-11-29', '2010-11-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (333, 2011, 1, '2011-11-29', '2011-11-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (333, 2012, 1, '2012-11-28', '2012-11-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (333, 2013, 1, '2013-11-29', '2013-11-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (333, 2014, 1, '2014-11-29', '2014-11-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (333, 2015, 1, '2015-11-29', '2015-11-29', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (334, 2008, 1, '2008-11-29', '2008-11-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (334, 2009, 1, '2009-11-30', '2009-11-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (334, 2010, 1, '2010-11-30', '2010-11-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (334, 2011, 1, '2011-11-30', '2011-11-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (334, 2012, 1, '2012-11-29', '2012-11-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (334, 2013, 1, '2013-11-30', '2013-11-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (334, 2014, 1, '2014-11-30', '2014-11-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (334, 2015, 1, '2015-11-30', '2015-11-30', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (335, 2008, 1, '2008-11-30', '2008-11-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (335, 2009, 1, '2009-12-01', '2009-12-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (335, 2010, 1, '2010-12-01', '2010-12-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (335, 2011, 1, '2011-12-01', '2011-12-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (335, 2012, 1, '2012-11-30', '2012-11-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (335, 2013, 1, '2013-12-01', '2013-12-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (335, 2014, 1, '2014-12-01', '2014-12-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (335, 2015, 1, '2015-12-01', '2015-12-01', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (336, 2008, 1, '2008-12-01', '2008-12-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (336, 2009, 1, '2009-12-02', '2009-12-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (336, 2010, 1, '2010-12-02', '2010-12-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (336, 2011, 1, '2011-12-02', '2011-12-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (336, 2012, 1, '2012-12-01', '2012-12-01', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (336, 2013, 1, '2013-12-02', '2013-12-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (336, 2014, 1, '2014-12-02', '2014-12-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (336, 2015, 1, '2015-12-02', '2015-12-02', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (337, 2008, 1, '2008-12-02', '2008-12-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (337, 2009, 1, '2009-12-03', '2009-12-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (337, 2010, 1, '2010-12-03', '2010-12-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (337, 2011, 1, '2011-12-03', '2011-12-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (337, 2012, 1, '2012-12-02', '2012-12-02', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (337, 2013, 1, '2013-12-03', '2013-12-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (337, 2014, 1, '2014-12-03', '2014-12-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (337, 2015, 1, '2015-12-03', '2015-12-03', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (338, 2008, 1, '2008-12-03', '2008-12-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (338, 2009, 1, '2009-12-04', '2009-12-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (338, 2010, 1, '2010-12-04', '2010-12-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (338, 2011, 1, '2011-12-04', '2011-12-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (338, 2012, 1, '2012-12-03', '2012-12-03', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (338, 2013, 1, '2013-12-04', '2013-12-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (338, 2014, 1, '2014-12-04', '2014-12-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (338, 2015, 1, '2015-12-04', '2015-12-04', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (339, 2008, 1, '2008-12-04', '2008-12-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (339, 2009, 1, '2009-12-05', '2009-12-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (339, 2010, 1, '2010-12-05', '2010-12-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (339, 2011, 1, '2011-12-05', '2011-12-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (339, 2012, 1, '2012-12-04', '2012-12-04', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (339, 2013, 1, '2013-12-05', '2013-12-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (339, 2014, 1, '2014-12-05', '2014-12-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (339, 2015, 1, '2015-12-05', '2015-12-05', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (340, 2008, 1, '2008-12-05', '2008-12-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (340, 2009, 1, '2009-12-06', '2009-12-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (340, 2010, 1, '2010-12-06', '2010-12-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (340, 2011, 1, '2011-12-06', '2011-12-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (340, 2012, 1, '2012-12-05', '2012-12-05', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (340, 2013, 1, '2013-12-06', '2013-12-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (340, 2014, 1, '2014-12-06', '2014-12-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (340, 2015, 1, '2015-12-06', '2015-12-06', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (341, 2008, 1, '2008-12-06', '2008-12-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (341, 2009, 1, '2009-12-07', '2009-12-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (341, 2010, 1, '2010-12-07', '2010-12-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (341, 2011, 1, '2011-12-07', '2011-12-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (341, 2012, 1, '2012-12-06', '2012-12-06', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (341, 2013, 1, '2013-12-07', '2013-12-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (341, 2014, 1, '2014-12-07', '2014-12-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (341, 2015, 1, '2015-12-07', '2015-12-07', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (342, 2008, 1, '2008-12-07', '2008-12-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (342, 2009, 1, '2009-12-08', '2009-12-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (342, 2010, 1, '2010-12-08', '2010-12-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (342, 2011, 1, '2011-12-08', '2011-12-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (342, 2012, 1, '2012-12-07', '2012-12-07', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (342, 2013, 1, '2013-12-08', '2013-12-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (342, 2014, 1, '2014-12-08', '2014-12-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (342, 2015, 1, '2015-12-08', '2015-12-08', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (343, 2008, 1, '2008-12-08', '2008-12-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (343, 2009, 1, '2009-12-09', '2009-12-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (343, 2010, 1, '2010-12-09', '2010-12-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (343, 2011, 1, '2011-12-09', '2011-12-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (343, 2012, 1, '2012-12-08', '2012-12-08', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (343, 2013, 1, '2013-12-09', '2013-12-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (343, 2014, 1, '2014-12-09', '2014-12-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (343, 2015, 1, '2015-12-09', '2015-12-09', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (344, 2008, 1, '2008-12-09', '2008-12-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (344, 2009, 1, '2009-12-10', '2009-12-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (344, 2010, 1, '2010-12-10', '2010-12-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (344, 2011, 1, '2011-12-10', '2011-12-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (344, 2012, 1, '2012-12-09', '2012-12-09', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (344, 2013, 1, '2013-12-10', '2013-12-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (344, 2014, 1, '2014-12-10', '2014-12-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (344, 2015, 1, '2015-12-10', '2015-12-10', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (345, 2008, 1, '2008-12-10', '2008-12-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (345, 2009, 1, '2009-12-11', '2009-12-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (345, 2010, 1, '2010-12-11', '2010-12-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (345, 2011, 1, '2011-12-11', '2011-12-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (345, 2012, 1, '2012-12-10', '2012-12-10', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (345, 2013, 1, '2013-12-11', '2013-12-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (345, 2014, 1, '2014-12-11', '2014-12-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (345, 2015, 1, '2015-12-11', '2015-12-11', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (346, 2008, 1, '2008-12-11', '2008-12-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (346, 2009, 1, '2009-12-12', '2009-12-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (346, 2010, 1, '2010-12-12', '2010-12-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (346, 2011, 1, '2011-12-12', '2011-12-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (346, 2012, 1, '2012-12-11', '2012-12-11', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (346, 2013, 1, '2013-12-12', '2013-12-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (346, 2014, 1, '2014-12-12', '2014-12-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (346, 2015, 1, '2015-12-12', '2015-12-12', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (347, 2008, 1, '2008-12-12', '2008-12-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (347, 2009, 1, '2009-12-13', '2009-12-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (347, 2010, 1, '2010-12-13', '2010-12-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (347, 2011, 1, '2011-12-13', '2011-12-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (347, 2012, 1, '2012-12-12', '2012-12-12', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (347, 2013, 1, '2013-12-13', '2013-12-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (347, 2014, 1, '2014-12-13', '2014-12-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (347, 2015, 1, '2015-12-13', '2015-12-13', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (348, 2008, 1, '2008-12-13', '2008-12-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (348, 2009, 1, '2009-12-14', '2009-12-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (348, 2010, 1, '2010-12-14', '2010-12-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (348, 2011, 1, '2011-12-14', '2011-12-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (348, 2012, 1, '2012-12-13', '2012-12-13', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (348, 2013, 1, '2013-12-14', '2013-12-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (348, 2014, 1, '2014-12-14', '2014-12-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (348, 2015, 1, '2015-12-14', '2015-12-14', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (349, 2008, 1, '2008-12-14', '2008-12-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (349, 2009, 1, '2009-12-15', '2009-12-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (349, 2010, 1, '2010-12-15', '2010-12-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (349, 2011, 1, '2011-12-15', '2011-12-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (349, 2012, 1, '2012-12-14', '2012-12-14', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (349, 2013, 1, '2013-12-15', '2013-12-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (349, 2014, 1, '2014-12-15', '2014-12-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (349, 2015, 1, '2015-12-15', '2015-12-15', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (350, 2008, 1, '2008-12-15', '2008-12-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (350, 2009, 1, '2009-12-16', '2009-12-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (350, 2010, 1, '2010-12-16', '2010-12-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (350, 2011, 1, '2011-12-16', '2011-12-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (350, 2012, 1, '2012-12-15', '2012-12-15', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (350, 2013, 1, '2013-12-16', '2013-12-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (350, 2014, 1, '2014-12-16', '2014-12-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (350, 2015, 1, '2015-12-16', '2015-12-16', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (351, 2008, 1, '2008-12-16', '2008-12-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (351, 2009, 1, '2009-12-17', '2009-12-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (351, 2010, 1, '2010-12-17', '2010-12-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (351, 2011, 1, '2011-12-17', '2011-12-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (351, 2012, 1, '2012-12-16', '2012-12-16', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (351, 2013, 1, '2013-12-17', '2013-12-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (351, 2014, 1, '2014-12-17', '2014-12-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (351, 2015, 1, '2015-12-17', '2015-12-17', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (352, 2008, 1, '2008-12-17', '2008-12-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (352, 2009, 1, '2009-12-18', '2009-12-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (352, 2010, 1, '2010-12-18', '2010-12-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (352, 2011, 1, '2011-12-18', '2011-12-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (352, 2012, 1, '2012-12-17', '2012-12-17', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (352, 2013, 1, '2013-12-18', '2013-12-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (352, 2014, 1, '2014-12-18', '2014-12-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (352, 2015, 1, '2015-12-18', '2015-12-18', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (353, 2008, 1, '2008-12-18', '2008-12-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (353, 2009, 1, '2009-12-19', '2009-12-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (353, 2010, 1, '2010-12-19', '2010-12-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (353, 2011, 1, '2011-12-19', '2011-12-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (353, 2012, 1, '2012-12-18', '2012-12-18', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (353, 2013, 1, '2013-12-19', '2013-12-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (353, 2014, 1, '2014-12-19', '2014-12-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (353, 2015, 1, '2015-12-19', '2015-12-19', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (354, 2008, 1, '2008-12-19', '2008-12-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (354, 2009, 1, '2009-12-20', '2009-12-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (354, 2010, 1, '2010-12-20', '2010-12-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (354, 2011, 1, '2011-12-20', '2011-12-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (354, 2012, 1, '2012-12-19', '2012-12-19', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (354, 2013, 1, '2013-12-20', '2013-12-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (354, 2014, 1, '2014-12-20', '2014-12-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (354, 2015, 1, '2015-12-20', '2015-12-20', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (355, 2008, 1, '2008-12-20', '2008-12-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (355, 2009, 1, '2009-12-21', '2009-12-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (355, 2010, 1, '2010-12-21', '2010-12-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (355, 2011, 1, '2011-12-21', '2011-12-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (355, 2012, 1, '2012-12-20', '2012-12-20', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (355, 2013, 1, '2013-12-21', '2013-12-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (355, 2014, 1, '2014-12-21', '2014-12-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (355, 2015, 1, '2015-12-21', '2015-12-21', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (356, 2008, 1, '2008-12-21', '2008-12-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (356, 2009, 1, '2009-12-22', '2009-12-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (356, 2010, 1, '2010-12-22', '2010-12-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (356, 2011, 1, '2011-12-22', '2011-12-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (356, 2012, 1, '2012-12-21', '2012-12-21', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (356, 2013, 1, '2013-12-22', '2013-12-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (356, 2014, 1, '2014-12-22', '2014-12-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (356, 2015, 1, '2015-12-22', '2015-12-22', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (357, 2008, 1, '2008-12-22', '2008-12-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (357, 2009, 1, '2009-12-23', '2009-12-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (357, 2010, 1, '2010-12-23', '2010-12-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (357, 2011, 1, '2011-12-23', '2011-12-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (357, 2012, 1, '2012-12-22', '2012-12-22', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (357, 2013, 1, '2013-12-23', '2013-12-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (357, 2014, 1, '2014-12-23', '2014-12-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (357, 2015, 1, '2015-12-23', '2015-12-23', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (358, 2008, 1, '2008-12-23', '2008-12-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (358, 2009, 1, '2009-12-24', '2009-12-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (358, 2010, 1, '2010-12-24', '2010-12-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (358, 2011, 1, '2011-12-24', '2011-12-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (358, 2012, 1, '2012-12-23', '2012-12-23', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (358, 2013, 1, '2013-12-24', '2013-12-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (358, 2014, 1, '2014-12-24', '2014-12-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (358, 2015, 1, '2015-12-24', '2015-12-24', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (359, 2008, 1, '2008-12-24', '2008-12-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (359, 2009, 1, '2009-12-25', '2009-12-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (359, 2010, 1, '2010-12-25', '2010-12-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (359, 2011, 1, '2011-12-25', '2011-12-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (359, 2012, 1, '2012-12-24', '2012-12-24', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (359, 2013, 1, '2013-12-25', '2013-12-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (359, 2014, 1, '2014-12-25', '2014-12-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (359, 2015, 1, '2015-12-25', '2015-12-25', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (360, 2008, 1, '2008-12-25', '2008-12-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (360, 2009, 1, '2009-12-26', '2009-12-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (360, 2010, 1, '2010-12-26', '2010-12-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (360, 2011, 1, '2011-12-26', '2011-12-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (360, 2012, 1, '2012-12-25', '2012-12-25', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (360, 2013, 1, '2013-12-26', '2013-12-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (360, 2014, 1, '2014-12-26', '2014-12-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (360, 2015, 1, '2015-12-26', '2015-12-26', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (361, 2008, 1, '2008-12-26', '2008-12-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (361, 2009, 1, '2009-12-27', '2009-12-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (361, 2010, 1, '2010-12-27', '2010-12-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (361, 2011, 1, '2011-12-27', '2011-12-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (361, 2012, 1, '2012-12-26', '2012-12-26', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (361, 2013, 1, '2013-12-27', '2013-12-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (361, 2014, 1, '2014-12-27', '2014-12-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (361, 2015, 1, '2015-12-27', '2015-12-27', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (362, 2008, 1, '2008-12-27', '2008-12-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (362, 2009, 1, '2009-12-28', '2009-12-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (362, 2010, 1, '2010-12-28', '2010-12-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (362, 2011, 1, '2011-12-28', '2011-12-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (362, 2012, 1, '2012-12-27', '2012-12-27', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (362, 2013, 1, '2013-12-28', '2013-12-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (362, 2014, 1, '2014-12-28', '2014-12-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (362, 2015, 1, '2015-12-28', '2015-12-28', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (363, 2008, 1, '2008-12-28', '2008-12-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (363, 2009, 1, '2009-12-29', '2009-12-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (363, 2010, 1, '2010-12-29', '2010-12-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (363, 2011, 1, '2011-12-29', '2011-12-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (363, 2012, 1, '2012-12-28', '2012-12-28', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (363, 2013, 1, '2013-12-29', '2013-12-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (363, 2014, 1, '2014-12-29', '2014-12-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (363, 2015, 1, '2015-12-29', '2015-12-29', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (364, 2008, 1, '2008-12-29', '2008-12-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (364, 2009, 1, '2009-12-30', '2009-12-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (364, 2010, 1, '2010-12-30', '2010-12-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (364, 2011, 1, '2011-12-30', '2011-12-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (364, 2012, 1, '2012-12-29', '2012-12-29', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (364, 2013, 1, '2013-12-30', '2013-12-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (364, 2014, 1, '2014-12-30', '2014-12-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (364, 2015, 1, '2015-12-30', '2015-12-30', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (365, 2008, 1, '2008-12-30', '2008-12-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (365, 2009, 1, '2009-12-31', '2009-12-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (365, 2010, 1, '2010-12-31', '2010-12-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (365, 2011, 1, '2011-12-31', '2011-12-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (365, 2012, 1, '2012-12-30', '2012-12-30', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (365, 2013, 1, '2013-12-31', '2013-12-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (365, 2014, 1, '2014-12-31', '2014-12-31', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (365, 2015, 1, '2015-12-31', '2015-12-31', 'N', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (366, 2008, 1, '2008-12-31', '2008-12-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (366, 2012, 1, '2012-12-31', '2012-12-31', 'C', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (366, 2016, 1, '2016-06-24', '2016-06-24', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (367, 2016, 1, '2016-06-30', '2016-06-30', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (368, 2016, 1, '2016-07-01', '2016-07-01', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (369, 2016, 1, '2016-07-02', '2016-07-02', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (370, 2016, 1, '2016-07-03', '2016-07-03', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (371, 2016, 1, '2016-07-04', '2016-07-04', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (372, 2016, 1, '2016-07-05', '2016-07-05', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (373, 2016, 1, '2016-07-06', '2016-07-06', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (374, 2016, 1, '2016-07-07', '2016-07-07', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (375, 2016, 1, '2016-07-08', '2016-07-08', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (376, 2016, 1, '2016-07-09', '2016-07-09', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (377, 2016, 1, '2016-07-10', '2016-07-10', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (378, 2016, 1, '2016-07-11', '2016-07-11', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (379, 2016, 1, '2016-07-12', '2016-07-12', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (380, 2016, 1, '2016-07-13', '2016-07-13', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (381, 2016, 1, '2016-07-15', '2016-07-15', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (382, 2016, 1, '2016-07-30', '2016-07-30', 'A', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (383, 2016, 1, '2016-08-01', '2016-08-01', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (384, 2016, 1, '2016-08-02', '2016-08-02', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (385, 2016, 1, '2016-08-03', '2016-08-03', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (386, 2016, 1, '2016-08-04', '2016-08-04', 'A', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (387, 2016, 1, '2016-08-05', '2016-08-05', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (388, 2016, 1, '2016-08-06', '2016-08-06', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (389, 2016, 1, '2016-08-07', '2016-08-07', 'V', 1)
GO

INSERT INTO dbo.cb_corte (co_corte, co_periodo, co_empresa, co_fecha_ini, co_fecha_fin, co_estado, co_tipo_corte)
VALUES (390, 2016, 1, '2016-08-08', '2016-08-08', 'V', 1)
GO
