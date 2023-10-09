Use cob_conta
go

IF OBJECT_ID ('dbo.cb_relparam') IS NOT NULL
	DROP TABLE dbo.cb_relparam
GO

CREATE TABLE dbo.cb_relparam
	(
	re_empresa     TINYINT NOT NULL,
	re_parametro   VARCHAR (10) COLLATE Latin1_General_BIN NOT NULL,
	re_clave       VARCHAR (20) COLLATE Latin1_General_BIN NOT NULL,
	re_substring   cuenta NOT NULL,
	re_producto    TINYINT NULL,
	re_tipo_area   VARCHAR (10) COLLATE Latin1_General_BIN NULL,
	re_origen_dest CHAR (1) COLLATE Latin1_General_BIN NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_relparam_Key
	ON dbo.cb_relparam (re_empresa,re_parametro,re_clave)
GO



INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.2.A', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.2.C', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.2.I', '21200800010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.2.T', '21200800020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.3.A', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.3.C', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.3.I', '21200800010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.3.T', '21200800020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.4.A', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.4.C', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.4.I', '21200800010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.4.T', '21200800020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.5.A', '25959500811', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.O.5.C', '25959500811', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.2.A', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.2.C', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.2.G', '21200500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.2.I', '21200800005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.2.T', '21200800015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.3.A', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.3.C', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.3.I', '21200800005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.3.T', '21200800015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.4.A', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.4.C', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.4.I', '21200800005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.4.T', '21200800015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.5.A', '25959500811', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '0.P.5.C', '25959500811', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.2.A', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.2.C', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.2.I', '21200801010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.2.T', '21200501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.3.A', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.3.C', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.3.I', '21200801010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.3.T', '21200501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.4.A', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.4.C', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.4.I', '21200801010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.O.4.T', '21200501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.2.A', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.2.C', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.2.I', '21200801005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.2.T', '21200801015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.3.A', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.3.C', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.3.I', '21200801005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.3.T', '21200801015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.4.A', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.4.C', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.4.I', '21200801005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, '2120_AHO', '1.P.4.T', '21200801015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AD', 'I', '13', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AD', 'O', '14', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.2.A.CAP', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.2.A.INT', '28050500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.2.C.CAP', '27702000005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.2.I.CAP', '21200800010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.2.I.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.2.T.CAP', '21200800020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.2.T.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.2.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.3.A.CAP', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.3.A.INT', '28050500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.3.C.CAP', '27702000005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.3.I.CAP', '21200800010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.3.I.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.3.T.CAP', '21200800020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.3.T.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.3.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.4.A.CAP', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.4.A.INT', '28050500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.4.C.CAP', '27702000005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.4.I.CAP', '21200800010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.4.I.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.4.T.CAP', '21200800020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.4.T.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.4.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.5.A.CAP', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.5.A.INT', '28050500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.5.C.CAP', '27702000005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.5.I.CAP', '21200800010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.5.I.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.5.T.CAP', '21200800020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.5.T.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.O.5.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.2.A.CAP', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.2.A.INT', '28050500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.2.C.CAP', '27702000005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.2.I.CAP', '21200800005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.2.I.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.2.T.CAP', '21200800015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.2.T.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.2.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.3.A.CAP', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.3.A.INT', '28050500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.3.C.CAP', '27702000005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.3.I.CAP', '21200800005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.3.I.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.3.T.CAP', '21200800015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.3.T.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.3.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.4.A.CAP', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.4.A.INT', '28050500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.4.C.CAP', '27702000005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.4.I.CAP', '21200800005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.4.I.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.4.T.CAP', '21200800015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.4.T.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.4.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.5.A.CAP', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.5.A.INT', '28050500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.5.C.CAP', '27702000005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.5.I.CAP', '21200800005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.5.I.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.5.T.CAP', '21200800015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.5.T.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '0.P.5.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.2.A.CAP', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.2.A.INT', '28050501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.2.C.CAP', '27702001005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.2.I.CAP', '21200801010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.2.I.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.2.T.CAP', '21200801020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.2.T.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.2.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.3.A.CAP', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.3.C.CAP', '27702001005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.3.I.CAP', '21200801010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.3.I.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.3.T.CAP', '21200801020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.3.T.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.3.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.4.A.CAP', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.4.A.INT', '28050501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.4.C.CAP', '27702001005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.4.I.CAP', '21200801010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.4.I.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.4.T.CAP', '21200801020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.4.T.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.4.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.5.A.CAP', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.5.A.INT', '28050501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.5.C.CAP', '27702001005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.5.I.CAP', '21200801010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.5.I.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.5.T.CAP', '21200801020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.5.T.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.O.5.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.2.A.CAP', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.2.A.INT', '28050501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.2.C.CAP', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.2.I.CAP', '21200801005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.2.I.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.2.T.CAP', '21200801015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.2.T.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.2.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.3.A.CAP', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.3.A.INT', '28050501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.3.C.CAP', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.3.I.CAP', '21200801005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.3.I.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.3.T.CAP', '21200801015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.3.T.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.3.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.4.A.CAP', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.4.A.INT', '28050501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.4.C.CAP', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.4.I.CAP', '21200801005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.4.I.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.4.T.CAP', '21200801015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.4.T.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.4.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.5.A.CAP', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.5.A.INT', '28050501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.5.C.CAP', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.5.I.CAP', '21200801005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.5.I.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.5.T.CAP', '21200801015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.5.T.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AHO_EST', '1.P.5.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_RBM_TRN', '0.CMPANUPOSI', '25959500110', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_RBM_TRN', '0.CMPANUPOSN', '25959500105', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_RBM_TRN', '0.CMPRETATMI', '25959500100', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_RBM_TRN', '0.CMPRETATMN', '25959500095', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_RBM_TRN', '0.CMPRETPOSI', '25959500110', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_RBM_TRN', '0.CMPRETPOSN', '25959500105', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_RBM_TRN', 'CMPRETATMI', '25959500100', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_RBM_TRN', 'CMPRETATMN', '25959500095', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_RBM_TRN', 'CMPRETPOSI', '25959500110', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_RBM_TRN', 'CMPRETPOSN', '25959500105', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.2.A.CAP', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.2.A.INT', '28050500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.2.C.CAP', '27702000005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.2.I.CAP', '21200800010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.2.I.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.2.T.CAP', '21200800020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.2.T.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.2.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.3.A.CAP', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.3.A.INT', '28050500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.3.C.CAP', '27702000005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.3.I.CAP', '21200800010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.3.I.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.3.T.CAP', '21200800020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.3.T.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.3.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.4.A.CAP', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.4.A.INT', '28050500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.4.C.CAP', '27702000005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.4.I.CAP', '21200800010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.4.I.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.4.T.CAP', '21200800020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.4.T.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.4.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.5.A.CAP', '21200500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.5.A.INT', '28050500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.5.C.CAP', '27702000005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.5.I.CAP', '21200800010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.5.I.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.5.T.CAP', '21200800020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.5.T.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.O.5.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.2.A.CAP', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.2.A.INT', '28050500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.2.C.CAP', '27702000005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.2.I.CAP', '21200800005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.2.I.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.2.T.CAP', '21200800015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.2.T.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.2.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.3.A.CAP', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.3.A.INT', '28050500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.3.C.CAP', '27702000005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.3.I.CAP', '21200800005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.3.I.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.3.T.CAP', '21200800015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.3.T.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.3.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.4.A.CAP', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.4.A.INT', '28050500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.4.C.CAP', '27702000005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.4.I.CAP', '21200800005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.4.I.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.4.T.CAP', '21200800015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.4.T.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.4.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.5.A.CAP', '21200500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.5.A.INT', '28050500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.5.C.CAP', '27702000005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.5.I.CAP', '21200800005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.5.I.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.5.T.CAP', '21200800015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.5.T.INT', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '0.P.5.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.2.A.CAP', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.2.A.INT', '28050501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.2.C.CAP', '27702001005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.2.I.CAP', '21200801010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.2.I.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.2.T.CAP', '21200801020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.2.T.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.2.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.3.A.CAP', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.3.C.CAP', '27702001005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.3.I.CAP', '21200801010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.3.I.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.3.T.CAP', '21200801020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.3.T.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.3.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.4.A.CAP', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.4.A.INT', '28050501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.4.C.CAP', '27702001005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.4.I.CAP', '21200801010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.4.I.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.4.T.CAP', '21200801020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.4.T.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.4.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.5.A.CAP', '21200501010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.5.A.INT', '28050501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.5.C.CAP', '27702001005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.5.I.CAP', '21200801010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.5.I.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.5.T.CAP', '21200801020', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.5.T.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.O.5.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.2.A.CAP', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.2.A.INT', '28050501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.2.C.CAP', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.2.I.CAP', '21200801005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.2.I.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.2.T.CAP', '21200801015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.2.T.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.2.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.3.A.CAP', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.3.A.INT', '28050501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.3.C.CAP', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.3.I.CAP', '21200801005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.3.I.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.3.T.CAP', '21200801015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.3.T.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.3.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.4.A.CAP', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.4.A.INT', '28050501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.4.C.CAP', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.4.I.CAP', '21200801005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.4.I.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.4.T.CAP', '21200801015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.4.T.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.4.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.5.A.CAP', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.5.A.INT', '28050501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.5.C.CAP', '21200501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.5.I.CAP', '21200801005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.5.I.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.5.T.CAP', '21200801015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.5.T.INT', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASDES', '1.P.5.X.CAP', '27702000015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.2.A.CAP', '21200500010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.2.A.INT', '28050500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.2.C.CAP', '27702000005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.2.I.CAP', '21200800010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.2.I.INT', '28050500015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.2.T.CAP', '21200800020', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.2.T.INT', '28050500015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.2.X.CAP', '27702000015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.3.A.CAP', '21200500010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.3.A.INT', '28050500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.3.C.CAP', '27702000005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.3.I.CAP', '21200800010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.3.I.INT', '28050500015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.3.T.CAP', '21200800020', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.3.T.INT', '28050500015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.3.X.CAP', '27702000015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.4.A.CAP', '21200500010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.4.A.INT', '28050500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.4.C.CAP', '27702000005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.4.I.CAP', '21200800010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.4.I.INT', '28050500015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.4.T.CAP', '21200800020', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.4.T.INT', '28050500015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.4.X.CAP', '27702000015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.5.A.CAP', '21200500010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.5.A.INT', '28050500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.5.C.CAP', '27702000005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.5.I.CAP', '21200800010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.5.I.INT', '28050500015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.5.T.CAP', '21200800020', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.5.T.INT', '28050500015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.O.5.X.CAP', '27702000015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.2.A.CAP', '21200500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.2.A.INT', '28050500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.2.C.CAP', '27702000005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.2.I.CAP', '21200800005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.2.I.INT', '28050500015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.2.T.CAP', '21200800015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.2.T.INT', '28050500015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.2.X.CAP', '27702000015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.3.A.CAP', '21200500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.3.A.INT', '28050500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.3.C.CAP', '27702000005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.3.I.CAP', '21200800005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.3.I.INT', '28050500015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.3.T.CAP', '21200800015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.3.T.INT', '28050500015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.3.X.CAP', '27702000015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.4.A.CAP', '21200500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.4.A.INT', '28050500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.4.C.CAP', '27702000005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.4.I.CAP', '21200800005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.4.I.INT', '28050500015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.4.T.CAP', '21200800015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.4.T.INT', '28050500015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.4.X.CAP', '27702000015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.5.A.CAP', '21200500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.5.A.INT', '28050500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.5.C.CAP', '27702000005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.5.I.CAP', '21200800005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.5.I.INT', '28050500015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.5.T.CAP', '21200800015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.5.T.INT', '28050500015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '0.P.5.X.CAP', '27702000015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.2.A.CAP', '21200501010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.2.A.INT', '28050501005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.2.C.CAP', '27702001005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.2.I.CAP', '21200801010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.2.I.INT', '28050501015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.2.T.CAP', '21200801020', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.2.T.INT', '28050501015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.2.X.CAP', '27702000015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.3.A.CAP', '21200501010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.3.C.CAP', '27702001005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.3.I.CAP', '21200801010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.3.I.INT', '28050501015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.3.T.CAP', '21200801020', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.3.T.INT', '28050501015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.3.X.CAP', '27702000015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.4.A.CAP', '21200501010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.4.A.INT', '28050501005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.4.C.CAP', '27702001005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.4.I.CAP', '21200801010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.4.I.INT', '28050501015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.4.T.CAP', '21200801020', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.4.T.INT', '28050501015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.4.X.CAP', '27702000015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.5.A.CAP', '21200501010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.5.A.INT', '28050501005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.5.C.CAP', '27702001005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.5.I.CAP', '21200801010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.5.I.INT', '28050501015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.5.T.CAP', '21200801020', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.5.T.INT', '28050501015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.O.5.X.CAP', '27702000015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.2.A.CAP', '21200501005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.2.A.INT', '28050501005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.2.C.CAP', '21200501005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.2.I.CAP', '21200801005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.2.I.INT', '28050501015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.2.T.CAP', '21200801015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.2.T.INT', '28050501015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.2.X.CAP', '27702000015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.3.A.CAP', '21200501005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.3.A.INT', '28050501005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.3.C.CAP', '21200501005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.3.I.CAP', '21200801005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.3.I.INT', '28050501015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.3.T.CAP', '21200801015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.3.T.INT', '28050501015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.3.X.CAP', '27702000015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.4.A.CAP', '21200501005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.4.A.INT', '28050501005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.4.C.CAP', '21200501005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.4.I.CAP', '21200801005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.4.I.INT', '28050501015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.4.T.CAP', '21200801015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.4.T.INT', '28050501015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.4.X.CAP', '27702000015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.5.A.CAP', '21200501005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.5.A.INT', '28050501005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.5.C.CAP', '21200501005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.5.I.CAP', '21200801005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.5.I.INT', '28050501015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.5.T.CAP', '21200801015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.5.T.INT', '28050501015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AH_TRASOR', '1.P.5.X.CAP', '27702000015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AJ_PRO_16', 'A.I.1.0.0', '16946200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AJ_PRO_16', 'A.I.4.0.0', '16923000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AJ_PRO_16', 'A.O.1.0.0', '16946200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AJ_PRO_16', 'A.O.4.0.0', '16923000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AJ_PRO_16', 'B.I.1.0.0', '16946300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AJ_PRO_16', 'B.I.4.0.0', '16923500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AJ_PRO_16', 'B.O.1.0.0', '16946300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AJ_PRO_16', 'B.O.4.0.0', '16923500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AJ_PRO_16', 'C.I.1.0.0', '16946400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AJ_PRO_16', 'C.I.4.0.0', '16924000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AJ_PRO_16', 'C.O.1.0.0', '16946400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AJ_PRO_16', 'C.O.4.0.0', '16924000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AJ_PRO_16', 'D.I.1.0.0', '16946600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AJ_PRO_16', 'D.I.4.0.0', '16924500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AJ_PRO_16', 'D.O.1.0.0', '16946600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AJ_PRO_16', 'D.O.4.0.0', '16924500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AJ_PRO_16', 'E.I.1.0.0', '16946700005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AJ_PRO_16', 'E.I.4.0.0', '16925000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AJ_PRO_16', 'E.O.1.0.0', '16946700005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'AJ_PRO_16', 'E.O.4.0.0', '16925000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'APE_VIG_41', '0', '41159500030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'BA', 'B', '005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'BA', 'C', '005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'BA', 'F', '005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CA', '1', '05', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CA', '2', '10', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CA', '3', '15', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CA', '4', '20', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAJA_AHO', '0.CH_OTR', '11051000005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAJA_AHO', '1.CH_OTR', '11051000110', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAL', 'A', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAL', 'B', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAL', 'C', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAL', 'D', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAL', 'E', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_CAS_81', '1.0', '81201000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_CAS_81', '2.0', '81201100005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_CAS_81', '4.0', '81201300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_CIC_14', 'A.I.1.0.0', '14871500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_CIC_14', 'A.O.1.0.0', '14871500007', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_CIC_14', 'B.I.1.0.0', '14871500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_CIC_14', 'B.O.1.0.0', '14871500012', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_CIC_14', 'C.I.1.0.0', '14871500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_CIC_14', 'C.O.1.0.0', '14871500017', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_CIC_14', 'D.I.1.0.0', '14871500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_CIC_14', 'D.O.1.0.0', '14871500022', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_CIC_14', 'D.O.2.0.0', '14870500022', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_CIC_14', 'E.I.1.0.0', '14871500025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_CIC_14', 'E.O.1.0.0', '14871500027', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_CONT', 'SLCCUPO', '62250500010', 200, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_CONT', 'SOL_APRO', '62200000010', 200, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_DIF_27', '0', '27203500005', 7, '', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_FAG_61', '1.0', '61959500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_FAG_61', '4.0', '61959500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_FAG_62', '1.0', '62959500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_FAG_62', '4.0', '62959500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_FAG_81', '1.0', '81959500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_FAG_81', '4.0', '81959500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_FAG_83', '1.0', '83050000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_FAG_83', '4.0', '83050000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_FNG_61', '1.0', '61959500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_FNG_61', '4.0', '61959500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_FNG_62', '1.0', '62959500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_FNG_62', '4.0', '62959500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_FNG_81', '1.0', '81959500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_FNG_81', '4.0', '81959500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_FNG_83', '1.0', '83050000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_FNG_83', '4.0', '83050000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'A.I.1.0.30.0', '24101000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'A.I.1.0.35.0', '24130000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'A.I.4.0.30.0', '24101000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'A.I.4.0.35.0', '24130000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'A.O.1.0.30.0', '24101000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'A.O.1.0.35.0', '24130000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'A.O.4.0.30.0', '24101000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'A.O.4.0.35.0', '24130000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'B.I.1.0.30.0', '24101000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'B.I.1.0.35.0', '24130000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'B.I.4.0.30.0', '24101000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'B.I.4.0.35.0', '24130000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'B.O.1.0.30.0', '24101000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'B.O.1.0.35.0', '24130000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'B.O.4.0.30.0', '24101000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'B.O.4.0.35.0', '24130000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'C.I.1.0.30.0', '24101000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'C.I.1.0.35.0', '24130000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'C.I.4.0.30.0', '24101000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'C.I.4.0.35.0', '24130000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'C.O.1.0.30.0', '24101000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'C.O.1.0.35.0', '24130000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'C.O.4.0.30.0', '24101000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'C.O.4.0.35.0', '24130000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'D.I.1.0.30.0', '24101000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'D.I.1.0.35.0', '24130000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'D.I.4.0.30.0', '24101000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'D.I.4.0.35.0', '24130000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'D.O.1.0.30.0', '24101000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'D.O.1.0.35.0', '24130000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'D.O.4.0.30.0', '24101000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'D.O.4.0.35.0', '24130000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'E.I.1.0.30.0', '24101000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'E.I.1.0.35.0', '24130000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'E.I.4.0.30.0', '24101000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'E.I.4.0.35.0', '24130000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'E.O.1.0.30.0', '24101000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'E.O.1.0.35.0', '24130000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'E.O.4.0.30.0', '24101000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PAS_24', 'E.O.4.0.35.0', '24130000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'A.I.1.0.0', '14950500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'A.I.4.0.0', '14930500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'A.O.1.0.0', '14950700005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'A.O.4.0.0', '14930700005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'B.I.1.0.0', '14951000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'B.I.4.0.0', '14931000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'B.O.1.0.0', '14951200005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'B.O.4.0.0', '14931200005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'C.I.1.0.0', '14951500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'C.I.4.0.0', '14931500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'C.O.1.0.0', '14951700005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'C.O.4.0.0', '14931700005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'D.I.1.0.0', '14952000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'D.I.4.0.0', '14932000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'D.O.1.0.0', '14952200005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'D.O.2.0.0', '14912200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'D.O.4.0.0', '14932200005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'E.I.1.0.0', '14952500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'E.I.4.0.0', '14932500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'E.O.1.0.0', '14952700005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'E.O.2.0.0', '14912700005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_PRO_14', 'E.O.4.0.0', '14932700005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_REC_42', '1.0', '42250500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_REC_42', '2.0', '42250500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_REC_42', '3.0', '42250500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_REC_42', '4.0', '42250500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_REC_82', '1.0', '82241000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_REC_82', '2.0', '82241100005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_REC_82', '3.0', '82241200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_REC_82', '4.0', '82241300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_RED_24', '1.0.30.0', '24101000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_RED_24', '1.0.35.0', '24130000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_RED_24', '4.0.30.0', '24101000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_RED_24', '4.0.35.0', '24130000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'A.I.1.0.15.0', '14598200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'A.I.1.0.30.0', '14593000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'A.I.1.0.35.0', '14593000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'A.I.2.0.15.0', '14111500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'A.I.2.0.15.1', '19503000006', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'A.I.3.0.15.0', '14040500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'A.I.3.0.15.1', '19502000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'A.I.4.0.15.0', '14560500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'A.I.4.0.30.0', '14560500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'A.I.4.0.35.0', '14560500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'A.O.1.0.15.0', '14668200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'A.O.1.0.30.0', '14663000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'A.O.1.0.35.0', '14663000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'A.O.2.0.15.0', '14411500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'A.O.2.0.15.1', '19503000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'A.O.3.0.15.0', '14040500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'A.O.3.0.15.1', '19502000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'A.O.4.0.15.0', '14570500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'A.O.4.0.30.0', '14570500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'A.O.4.0.35.0', '14570500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'B.I.1.0.15.0', '14608200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'B.I.1.0.30.0', '14603000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'B.I.1.0.35.0', '14603000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'B.I.2.0.15.0', '14191500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'B.I.2.0.15.1', '19503200006', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'B.I.3.0.15.0', '14041000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'B.I.3.0.15.1', '19502200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'B.I.4.0.15.0', '14561000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'B.I.4.0.30.0', '14561000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'B.I.4.0.35.0', '14561000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'B.O.1.0.15.0', '14678200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'B.O.1.0.30.0', '14673000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'B.O.1.0.35.0', '14673000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'B.O.2.0.15.0', '14421500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'B.O.2.0.15.1', '19503200010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'B.O.3.0.15.0', '14041000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'B.O.3.0.15.1', '19502200010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'B.O.4.0.15.0', '14571000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'B.O.4.0.30.0', '14571000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'B.O.4.0.35.0', '14571000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'C.I.1.0.15.0', '14628200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'C.I.1.0.30.0', '14623000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'C.I.1.0.35.0', '14623000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'C.I.2.0.15.0', '14321500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'C.I.2.0.15.1', '19503400006', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'C.I.3.0.15.0', '14041500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'C.I.3.0.15.1', '19502400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'C.I.4.0.15.0', '14561500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'C.I.4.0.30.0', '14561500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'C.I.4.0.35.0', '14561500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'C.O.1.0.15.0', '14688200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'C.O.1.0.30.0', '14683000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'C.O.1.0.35.0', '14683000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'C.O.2.0.15.0', '14441500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'C.O.2.0.15.1', '19503400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'C.O.3.0.15.0', '14041500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'C.O.3.0.15.1', '19502400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'C.O.4.0.15.0', '14571500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'C.O.4.0.30.0', '14571500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'C.O.4.0.35.0', '14571500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'D.I.1.0.15.0', '14638200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'D.I.1.0.30.0', '14633000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'D.I.1.0.35.0', '14633000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'D.I.2.0.15.0', '14331500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'D.I.2.0.15.1', '19503600006', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'D.I.3.0.15.0', '14042000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'D.I.3.0.15.1', '19502600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'D.I.4.0.15.0', '14562000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'D.I.4.0.30.0', '14562000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'D.I.4.0.35.0', '14562000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'D.O.1.0.15.0', '14698200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'D.O.1.0.30.0', '14693000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'D.O.1.0.35.0', '14693000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'D.O.2.0.15.0', '14451500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'D.O.2.0.15.1', '19503600010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'D.O.3.0.15.0', '14042000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'D.O.3.0.15.1', '19502600010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'D.O.4.0.15.0', '14572000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'D.O.4.0.30.0', '14572000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'D.O.4.0.35.0', '14572000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'E.I.1.0.15.0', '14658200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'E.I.1.0.30.0', '14653000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'E.I.1.0.35.0', '14653000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'E.I.2.0.15.0', '14361500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'E.I.2.0.15.1', '19503800006', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'E.I.3.0.15.0', '14042500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'E.I.3.0.15.1', '19502800005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'E.I.4.0.15.0', '14562500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'E.I.4.0.30.0', '14562500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'E.I.4.0.35.0', '14562500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'E.O.1.0.15.0', '14708200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'E.O.1.0.30.0', '14703000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'E.O.1.0.35.0', '14703000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'E.O.2.0.15.0', '14501500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'E.O.2.0.15.1', '19503800010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'E.O.3.0.15.0', '14042500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'E.O.3.0.15.1', '19502800010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'E.O.4.0.15.0', '14572500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'E.O.4.0.30.0', '14572500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CAP_VIG_14', 'E.O.4.0.35.0', '14572500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '000829390', '11150500245', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '005602022864', '11150500225', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '04305674476', '11150500050', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '04846913136', '11150500180', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '059000166', '11150500120', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '060031903', '11150500125', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '07009290730', '11150500060', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '09144480711', '11150500065', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '09798552203', '11150500055', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '10332654658', '11150500110', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '13050187020001100', '11150500175', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '202033171', '11150500170', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '21002631546', '11150500165', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '21500241120', '11150500220', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '224237578', '11150500265', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '22843334', '11150500270', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '26235451881', '11150500070', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '308200004791', '11150500280', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '309005569', '11150500160', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '309012060', '11150500150', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '313200000617', '11150500205', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '336181292', '11150500255', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '348086794', '11150500130', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '35235451828', '11150500075', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '37131383220', '11150500080', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '39223904719', '11150500085', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '449019272', '11150500250', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '449022219', '11150500260', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '525024113', '11150500200', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '596251116', '11150500135', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '616119566', '11150500140', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '64526036103', '11150500090', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '66124397', '11150500235', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '70625691878', '11150500100', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '716007067', '11150500115', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '74428487208', '11150500105', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '895000412', '11150500145', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CH_OTR_BAN', '9725971710', '11150500190', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL-GAS', '1', '005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL-GAS', '4', '010', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI-CXC', '1.A', '3905', 7, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI-CXC', '1.B', '3910', 7, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI-CXC', '1.C', '3915', 7, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI-CXC', '1.D', '3920', 7, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI-CXC', '1.E', '3925', 7, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI-CXC', '2.A', '3705', 7, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI-CXC', '2.B', '3710', 7, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI-CXC', '2.C', '3715', 7, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI-CXC', '2.D', '3720', 7, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI-CXC', '2.E', '3725', 7, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI-CXC', '3.A', '3605', 7, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI-CXC', '3.B', '3610', 7, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI-CXC', '3.C', '3615', 7, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI-CXC', '3.D', '3620', 7, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI-CXC', '3.E', '3625', 7, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI-CXC', '4.A', '3805', 7, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI-CXC', '4.B', '3810', 7, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI-CXC', '4.C', '3815', 7, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI-CXC', '4.D', '3820', 7, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI-CXC', '4.E', '3825', 7, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '1.A.I', '9505', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '1.A.O', '9507', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '1.B.I', '9510', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '1.B.O', '9512', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '1.C.I', '9515', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '1.C.O', '9517', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '1.D.I', '9520', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '1.D.O', '9522', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '1.E.I', '9525', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '1.E.O', '9527', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '2.A.I', '9105', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '2.A.O', '9107', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '2.B.I', '9110', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '2.B.O', '9112', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '2.C.I', '9115', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '2.C.O', '9117', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '2.D.I', '9120', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '2.D.O', '9122', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '2.E.I', '9125', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '2.E.O', '9127', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '3.A.I', '8905', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '3.A.O', '8905', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '3.B.I', '8910', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '3.B.O', '8910', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '3.C.I', '8915', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '3.C.O', '8915', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '3.D.I', '8920', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '3.D.O', '8920', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '3.E.I', '8925', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '3.E.O', '8925', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '4.A.I', '9305', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '4.A.O', '9307', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '4.B.I', '9310', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '4.B.O', '9312', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '4.C.I', '9315', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '4.C.O', '9317', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '4.D.I', '9320', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '4.D.O', '9322', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '4.E.I', '9325', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_GA-P', '4.E.O', '9327', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.A.2', '9452', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.A.3', '9410', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.A.4', '9430', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.A.5', '9462', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.A.6', '9450', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.B.2', '9453', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.B.3', '9410', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.B.4', '9430', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.B.5', '9463', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.B.6', '9450', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.C.2', '9454', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.C.3', '9410', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.C.4', '9430', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.C.5', '9464', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.C.6', '9450', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.D.2', '9456', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.D.3', '9410', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.D.4', '9430', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.D.5', '9466', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.D.6', '9450', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.E.2', '9457', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.E.3', '9410', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.E.4', '9430', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.E.5', '9467', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '1.E.6', '9450', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.A.2', '9652', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.A.3', '9610', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.A.4', '9630', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.A.5', '9662', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.A.6', '9650', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.B.2', '9653', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.B.3', '9610', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.B.4', '9630', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.B.5', '9663', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.B.6', '9650', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.C.2', '9654', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.C.3', '9610', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.C.4', '9630', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.C.5', '9664', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.C.6', '9650', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.D.2', '9656', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.D.3', '9610', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.D.4', '9630', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.D.5', '9666', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.D.6', '9650', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.E.2', '9657', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.E.3', '9610', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.E.4', '9630', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.E.5', '9667', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '2.E.6', '9650', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '3.A.2', '9752', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '3.A.5', '9762', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '3.B.2', '9753', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '3.B.5', '9763', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '3.C.2', '9754', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '3.C.5', '9764', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '3.D.2', '9756', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '3.D.5', '9765', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '3.E.2', '9757', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '3.E.5', '9766', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '4.A.2', '9205', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '4.A.5', '9230', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '4.B.2', '9210', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '4.B.5', '9235', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '4.C.2', '9215', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '4.C.5', '9240', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '4.D.2', '9220', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '4.D.5', '9245', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '4.E.2', '9225', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CL_RI_RU', '4.E.5', '9250', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_27_ACT', '1.0', '51701500025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_27_ACT', '4.0', '51701500040', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_27_ANT', '1.0', '41600800025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_27_ANT', '4.0', '41600800040', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_BANCO', 'PAGOBALOTO', '41159500011', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_BANCO', 'PAGOEDATEL', '41159500016', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '000829390', '11150500245', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '005602022864', '11150500225', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '04305674476', '11150500050', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '04846913136', '11150500180', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '059000166', '11150500120', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '060031903', '11150500125', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '07009290730', '11150500060', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '09144480711', '11150500065', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '09798552203', '11150500055', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '10332654658', '11150500110', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '13050187020001100', '11150500175', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '202033171', '11150500170', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '21002631546', '11150500165', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '21500241120', '11150500220', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '26235451881', '11150500070', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '309005569', '11150500160', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '313200000617', '11150500205', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '348086794', '11150500130', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '35235451828', '11150500075', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '37131383220', '11150500080', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '39223904719', '11150500085', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '449019272', '11150500250', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '525024113', '11150500200', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '596251116', '11150500135', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '616119566', '11150500140', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '64526036103', '11150500090', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '66124397', '11150500235', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '70625691878', '11150500100', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '716007067', '11150500115', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '74428487208', '11150500105', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', '9725971710', '11150500190', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', 'PAGOBALOTO', '25100500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CANAL', 'PAGOEDATEL', '41159500016', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CAS_81', '1.0', '81201500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CAS_81', '4.0', '81201800015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CIC_16', 'A.I.1.0.0', '16991500062', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CIC_16', 'A.O.1.0.0', '16991500062', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CIC_16', 'B.I.1.0.0', '16991500063', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CIC_16', 'B.O.1.0.0', '16991500063', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CIC_16', 'C.I.1.0.0', '16991500064', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CIC_16', 'C.O.1.0.0', '16991500064', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CIC_16', 'D.I.1.0.0', '16991500066', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CIC_16', 'D.O.1.0.0', '16991500066', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CIC_16', 'E.I.1.0.0', '16991500067', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_CIC_16', 'E.O.1.0.0', '16991500067', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'A.I.1.0.0', '16946200005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'A.I.4.0.0', '16923000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'A.O.1.0.0', '16946200005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'A.O.4.0.0', '16923000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'B.I.1.0.0', '16946300005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'B.I.4.0.0', '16923500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'B.O.1.0.0', '16946300005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'B.O.4.0.0', '16923500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'C.I.1.0.0', '16946400005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'C.I.4.0.0', '16924000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'C.O.1.0.0', '16946400005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'C.O.4.0.0', '16924000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'D.I.1.0.0', '16946600005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'D.I.4.0.0', '16924500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'D.O.1.0.0', '16946600005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'D.O.2.0.0', '16966600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'D.O.4.0.0', '16924500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'E.I.1.0.0', '16946700005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'E.I.4.0.0', '16925000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'E.O.1.0.0', '16946700005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'E.O.2.0.0', '16966700010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_PRO_16', 'E.O.4.0.0', '16925000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_REC_42', '1.0', '42250500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_REC_42', '4.0', '42250500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_REC_82', '1.0', '82241500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_REC_82', '4.0', '82241800015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_SUS_63', '1.0', '63050000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_SUS_63', '4.0', '63050000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_SUS_64', '1.0', '64959500010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_SUS_64', '4.0', '64959500010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_VEN_16', '0', '16109500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_VEN_27', '0', '27203500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COM_VIG_41', '0', '41159500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_CXC', '0.CNDCOMATMI', '16879500012', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_CXC', '0.CNDCOMATMN', '16879500012', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_CXC', '0.CNDCSAATMI', '16879500012', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_CXC', '0.CNDCSAATMN', '16879500012', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_CXC', '0.CNDCUOMAN', '16879500012', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_CXC', '0.CNDFINSU', '16879500012', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_CXC', '0.CNDPDTARJ', '16879500012', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_CXC', '0.CNDPININV', '16879500012', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_CXC', '0.CNDROTARJ', '16879500012', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_SUS', '0.CNDCOMATMI', '52959500045', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_SUS', '0.CNDCOMATMN', '52959500045', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_SUS', '0.CNDCSAATMI', '52959500045', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_SUS', '0.CNDCSAATMN', '52959500045', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_SUS', '0.CNDCUOMAN', '52959500045', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_SUS', '0.CNDFINSU', '52959500045', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_SUS', '0.CNDPDTARJ', '52959500045', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_SUS', '0.CNDPININV', '52959500045', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'COND_SUS', '0.CNDROTARJ', '52959500045', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CONTRA8305', '0', '83050000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.CCCUPOCB', '19049500805', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.CH_LOC', '11051000005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.CH_PRO', '11051000005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.CONCHREM', '51152000901', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.DEVCOMREM', '41152500041', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.DEVGMF', '25309500500', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.DEVRTEFTE', '25550500016', 4, 'CTB_IMP', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.EFECTIVO', '11050500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.INT', '28050500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.INTA', '28050500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.INTI', '28050500015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCABNOEM', '27049500915', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCABONOPAG', '25959500800', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCABPAVI', '27049500910', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCAJ50RBM', '16879500161', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCAJ56RBM', '16879500161', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCAJTRNATM', '25959500095', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCAJTRNPOS', '25959500105', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCDEVCMTD', '41159500075', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCDTN', '25959500085', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCPAGOINCE', '25959500080', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRACMMOV', '27049500920', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRCCCBP', '11150500050', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRCCMMOV', '27049500920', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRCOMCB', '27049500810', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRCORDEP', '27049500908', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRCTAEMP', '27049500909', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRDEPCB', '19049500800', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRDESPRE', '19049500934', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRDPF', '27049500903', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCREINPAGC', '19049500932', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRENTMMI', '27049500904', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRGMFCBCO', '51403500050', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRINTREC', '51020200005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRMANOPE', '27049500908', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRPAGMOV', '25959500130', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRPAGPROV', '27049500998', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRRCMMOV', '27049500920', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRREACTA', '19909500992', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRRECMOV', '25959500130', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRREFERI', '25959500130', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRRETPOS', '25959500105', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRRETPOSI', '25959500110', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRRVAPDPF', '27049500903', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRTRANS', '27049500912', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRTRSMOV', '27049500920', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCRWU', '16879500200', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NCTRDCTOB', '27049500912', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.NDAJ57RBM', '25959500100', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '0.REVCOMCHG', '41159500064', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '1.EFECTIVO', '11050501005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', '1.INT', '28050501005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', 'NCAJ50RBM', '25959500100', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_AHO', 'NCAJ56RBM', '25959500100', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_CUP', '0.CORAUCCB', '62250500805', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_CUP', '0.CORDICCB', '62250500805', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_CUP', '0.CORRGCCB', '62250500805', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCAUMCB', '19049500805', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCCMRMOV', '25959500130', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCCMUMOV', '41159500100', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCCOMATMI', '41159500085', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCCOMATMN', '41159500085', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCCSAATMI', '41159500085', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCCSAATMN', '41159500085', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCCUOMAN', '41159500075', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCDICCB', '19049500805', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCFINSU', '41159500085', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCPDTARJ', '41159500085', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCPININV', '41159500085', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_CR_SUS', '0.CXCROTARJ', '41159500085', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.AUTRETINE', '27049500904', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.CCCUPOCB', '19049500805', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.CXCEXCMONT', '41159500085', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.CXCEXCNUMU', '41159500085', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.EFECTIVO', '11050500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDAJ51RBM', '25959500125', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDCOMDISP', '41159500055', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEACMMOV', '27049500920', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEAJUCHL', '11051000005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEAUMDPF', '27049500903', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEAUTFLI', '27049500906', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECANCIN', '27702000010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECCCBP', '11150500050', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECCMMOV', '27049500920', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECCSMOV', '25959500130', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECHQGER', '27049500902', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECHQREM', '41152500041', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECIECHG', '21651500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECIECON', '27702000005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECIECTA', '19909500992', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECIEEFE', '27049500905', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECMOMOV', '25959500130', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECMRMOV', '25959500130', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECMUMOV', '41159500100', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMATMI', '41159500085', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMATMN', '41159500085', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMCB', '41159500061', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMCHD', '42259500011', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMCHGE', '41159500064', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMECT', '41159500060', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMOFI', '41152500011', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMREM', '41152500041', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMRETV', '41159500066', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECOMTRF', '41152500060', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECONCTA', '41152500041', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECONDPF', '27049500903', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECORDEP', '27049500908', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECSAATMI', '41159500085', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECSAATMN', '41159500085', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDECUOMAN', '41159500075', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEDEVEFE', '19049500931', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEDEVLOC', '19049500931', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEEMBARG', '27049500901', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEESTCTA', '41159500060', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEFINSU', '41159500085', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEGMF', '25301000005', 4, 'CTB_IMP', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEIVA', '25350000015', 4, 'CTB_IMP', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEMANOPE', '27049500908', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPAGCAR', '19049500932', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPAGMOV', '19049500932', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPCARMAS', '19049500932', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPDTARJ', '41159500085', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPININV', '41159500085', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPORREM', '41152500041', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPORTDEV', '41152500041', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEPROVEED', '19909500991', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERCMMOV', '27049500920', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERECINT', '51020200005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERECMOV', '25959500130', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEREFBAN', '41159500062', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEREIDESC', '19049500934', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEREM', '19909500996', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERETATMI', '25959500100', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERETATMN', '25959500095', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERETCB', '19049500800', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERETCHGE', '21651500010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERETPOS', '25959500105', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERETPOSI', '25959500110', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDEROTARJ', '41159500085', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERTEFTE', '25550500016', 4, 'CTB_IMP', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDERTEICA', '25550500420', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDETRANS', '27049500912', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDETRASLD', '27049500907', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDETRNNAL', '25959500125', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDETRSMOV', '27049500920', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDRVCANDPF', '27049500903', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.NDTRACTOB', '27049500912', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '0.RET', '11050500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', '1.EFECTIVO', '11050501005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', 'NDAJ51RBM', '25959500100', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_AHO', 'NDAJ57RBM', '25959500100', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_CUP', '0.CORAUCCB', '61250500805', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_CUP', '0.CORDICCB', '61250500805', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_CUP', '0.CORRGCCB', '61250500805', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCAUMCB', '16879500810', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCCMRMOV', '16879500165', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCCMUMOV', '16879500165', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCCOMATMI', '16879500012', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCCOMATMN', '16879500012', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCCSAATMI', '16879500012', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCCSAATMN', '16879500012', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCCUOMAN', '16879500012', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCDICCB', '16879500810', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCFINSU', '16879500012', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCPDTARJ', '16879500012', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCPININV', '16879500012', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_DB_SUS', '0.CXCROTARJ', '16879500012', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_GMFAHO', '0.NCABNOEM', '25309500030', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_GMFAHO', '0.NCABONOPAG', '25301500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_GMFAHO', '0.NCABPAVI', '25309500035', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_GMFAHO', '0.NCDTN', '25309500050', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_GMFAHO', '0.NCPAGOINCE', '25309500045', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CON_GMFAHO', '0.NCRPAGPROV', '25309500040', 4, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CRE_APR_61', '0', '61200500010', 21, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CRE_APR_62', '0', '62200000010', 21, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-CR-CO', '1.A.I', '59', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-CR-CO', '1.A.O', '66', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-CR-CO', '1.B.I', '60', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-CR-CO', '1.B.O', '67', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-CR-CO', '1.C.I', '62', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-CR-CO', '1.C.O', '68', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-CR-CO', '1.D.I', '63', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-CR-CO', '1.D.O', '69', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-CR-CO', '1.E.I', '65', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-CR-CO', '1.E.O', '70', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-CR-MC', '4.A', '05', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-CR-MC', '4.B', '10', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-CR-MC', '4.C', '15', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-CR-MC', '4.D', '20', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-CR-MC', '4.E', '25', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-TC-CONT', '1.A', '50', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-TC-CONT', '1.B', '52', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-TC-CONT', '1.C', '54', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-TC-CONT', '1.D', '56', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-TC-CONT', '1.E', '58', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-TC-CONT', '2.A', '30', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-TC-CONT', '2.B', '32', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-TC-CONT', '2.C', '34', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-TC-CONT', '2.D', '36', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-TC-CONT', '2.E', '38', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-TC-CONT', '3.A', '20', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-TC-CONT', '3.B', '22', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-TC-CONT', '3.C', '24', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-TC-CONT', '3.D', '26', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-TC-CONT', '3.E', '28', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-TC-CONT', '4.A', '40', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-TC-CONT', '4.B', '42', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-TC-CONT', '4.C', '44', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-TC-CONT', '4.D', '46', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CT-TC-CONT', '4.E', '48', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPACTACLI', '1.A', '05', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPACTACLI', '1.B', '10', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPACTACLI', '1.C', '15', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPACTACLI', '1.D', '20', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPACTACLI', '1.E', '25', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPACTACLI', '4.A', '05', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPACTACLI', '4.B', '10', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPACTACLI', '4.C', '15', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPACTACLI', '4.D', '20', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPACTACLI', '4.E', '25', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVCTA', '1.A', '62', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVCTA', '1.B', '63', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVCTA', '1.C', '64', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVCTA', '1.D', '66', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVCTA', '1.E', '67', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVCTA', '4.A', '30', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVCTA', '4.B', '35', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVCTA', '4.C', '40', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVCTA', '4.D', '45', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVCTA', '4.E', '50', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVCTACO', 'A', '62', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVCTACO', 'B', '63', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVCTACO', 'C', '64', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVCTACO', 'D', '66', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVCTACO', 'E', '67', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVCTAMI', 'A', '30', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVCTAMI', 'B', '35', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVCTAMI', 'C', '40', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVCTAMI', 'D', '45', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVCTAMI', 'E', '50', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVINT', '1.A', '52', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVINT', '1.B', '53', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVINT', '1.C', '54', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVINT', '1.D', '56', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVINT', '1.E', '57', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVINT', '4.A', '05', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVINT', '4.B', '10', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVINT', '4.C', '15', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVINT', '4.D', '20', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVINT', '4.E', '25', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVINTCO', '1.A', '52', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVINTCO', '1.B', '53', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVINTCO', '1.C', '54', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVINTCO', '1.D', '56', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVINTCO', '1.E', '57', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVINTMI', '4.A', '05', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVINTMI', '4.B', '10', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVINTMI', '4.C', '15', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVINTMI', '4.D', '20', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CTPVINTMI', '4.E', '25', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CUP_CRE_61', '0', '61250500010', 21, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CUP_CRE_62', '0', '62250500010', 21, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CUS_8205', 'I.0', '82050500005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CUS_8205', 'O.0', '82050500005', 19, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CUS_8405', '0', '84050000005', 19, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_CAS_82', '1.0', '82241000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_CAS_82', '2.0', '82241600020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_CAS_82', '3.0', '82241700020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_CAS_82', '4.0', '82241300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_CAS_MI', 'A.1.0.0', '81201500040', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_CAS_MI', 'A.4.0.0', '81201800040', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_CAS_MI', 'B.1.0.0', '81201500040', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_CAS_MI', 'B.4.0.0', '81201800040', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_CAS_MI', 'C.1.0.0', '81201500040', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_CAS_MI', 'C.4.0.0', '81201800040', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_CAS_MI', 'D.1.0.0', '81201500040', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_CAS_MI', 'D.4.0.0', '81201800040', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_CAS_MI', 'E.1.0.0', '81201500040', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_CAS_MI', 'E.2.0.0', '81201600020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_CAS_MI', 'E.4.0.0', '81201800040', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_16', 'A.1.0.0', '16390500900', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_16', 'A.2.0.1', '19503000035', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_16', 'A.3.0.0', '16360500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_16', 'A.3.0.1', '19502000030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_16', 'A.4.0.0', '16380500900', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_16', 'B.1.0.0', '16391000900', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_16', 'B.3.0.0', '16361000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_16', 'B.4.0.0', '16381000900', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_16', 'C.1.0.0', '16391500900', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_16', 'C.3.0.0', '16361500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_16', 'C.4.0.0', '16381500900', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_16', 'D.1.0.0', '16392000900', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_16', 'D.3.0.0', '16362000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_16', 'D.4.0.0', '16382000900', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_16', 'E.1.0.0', '16392500900', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_16', 'E.3.0.0', '16362500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_16', 'E.4.0.0', '16382500900', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_81', 'A.1.0.0', '81201500045', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_81', 'A.4.0.0', '81201500045', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_81', 'B.1.0.0', '81201500045', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_81', 'B.4.0.0', '81201500045', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_81', 'C.1.0.0', '81201500045', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_81', 'C.4.0.0', '81201500045', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_81', 'D.1.0.0', '81201500045', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_81', 'D.4.0.0', '81201500045', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_81', 'E.1.0.0', '81201500045', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_MIG_81', 'E.4.0.0', '81201500045', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'A.1.0.0', '16390500901', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'A.2.0.0', '16370500901', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'A.2.0.1', '19503000035', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'A.3.0.0', '16360500901', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'A.3.0.1', '19502000030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'A.4.0.0', '16380500901', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'B.1.0.0', '16391000901', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'B.2.0.0', '16371000901', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'B.2.0.1', '19503000035', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'B.3.0.0', '16361000901', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'B.3.0.1', '19502000030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'B.4.0.0', '16381000901', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'C.1.0.0', '16391500901', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'C.2.0.0', '16371500901', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'C.2.0.1', '19503000035', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'C.3.0.0', '16361500901', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'C.3.0.1', '19502000030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'C.4.0.0', '16381500901', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'D.1.0.0', '16392000901', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'D.2.0.0', '16372000901', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'D.2.0.1', '19503000035', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'D.3.0.0', '16362000901', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'D.3.0.1', '19502000030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'D.4.0.0', '16382000901', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'E.1.0.0', '16392500901', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'E.2.0.0', '16372500901', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'E.2.0.1', '19503000035', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'E.3.0.0', '16362500901', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'E.3.0.1', '19502000030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'CXC_VEN_MI', 'E.4.0.0', '16382500901', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DMT_PAG_25', '0', '25957000017', 7, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_CAP_21', '+540D.0.OF', '21153000010', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_CAP_21', '+540D.0.PA', '21153000005', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_CAP_21', '-180D.0.OF', '21150500010', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_CAP_21', '-180D.0.PA', '21150500005', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_CAP_21', '-360D.0.OF', '21151500010', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_CAP_21', '-360D.0.PA', '21151500005', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_CAP_21', '-540D.0.OF', '21152500010', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_CAP_21', '-540D.0.PA', '21152500005', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'AHO.0.0', '27049500903', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.000829390', '11150500245', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.005602022864', '11150500225', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.04305674476', '11150500050', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.04846913136', '11150500180', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.059000166', '11150500120', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.060031903', '11150500125', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.07009290730', '11150500060', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.09144480711', '11150500065', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.09798552203', '11150500055', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.10332654658', '11150500110', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.13050187020000', '11150500175', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.202033171', '11150500170', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.21002631546', '11150500165', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.21500241120', '11150500220', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.26235451881', '11150500070', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.309005569', '11150500160', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.313200000617', '11150500205', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.336181292', '11150500255', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.348086794', '11150500130', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.35235451828', '11150500075', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.37131383220', '11150500080', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.39223904719', '11150500085', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.449019272', '11150500250', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.449022219', '11150500260', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.525024113', '11150500200', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.596251116', '11150500135', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.616119566', '11150500140', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.64526036103', '11150500090', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.66124397', '11150500235', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.70625691878', '11150500100', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.716007067', '11150500115', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.74428487208', '11150500105', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.895000412', '11150500145', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.9725971710', '11150500190', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHG.0.0', '21651500010', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHQL.0.0', '11051000005', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'EFEC.0.0', '11050500005', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'FFR.0.0', '19909500604', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'OTROS.0.0', '19909500600', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'PCHC.0.0', '19909500603', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'RENINC.0.0', '27049500903', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'SEBRA.0.0', '27049500954', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'SEBRA.0.0000000000', '27049500954', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'VXP.0.0', '25050500050', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_GMF_25', '0', '25301500015', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_GMF_51', '0', '51403500015', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_ICA_25', '0', '25550500410', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_25', '+540D.0.OF', '25050500026', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_25', '+540D.0.PA', '25050500025', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_25', '-180D.0.OF', '25050500012', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_25', '-180D.0.PA', '25050500011', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_25', '-360D.0.OF', '25050500016', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_25', '-360D.0.PA', '25050500015', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_25', '-540D.0.OF', '25050500021', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_25', '-540D.0.PA', '25050500020', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_51', '+540D.0.OF', '51020700010', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_51', '+540D.0.PA', '51020700005', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_51', '-180D.0.OF', '51020500010', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_51', '-180D.0.PA', '51020500005', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_51', '-360D.0.OF', '51020600010', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_51', '-360D.0.PA', '51020600005', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_51', '-540D.0.OF', '51020700010', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_51', '-540D.0.PA', '51020700005', 14, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_ORPAGO', '0', '25050500050', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_PCA_42', '0', '42959500005', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_PIN_42', '0', '42959500005', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_RET_25', '0', '25550500018', 14, 'CTB_OP', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.I.CAP.17.0.0', '82870200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.I.CAP.18.0.0', '82870400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.I.CAP.19.0.0', '82870600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.I.CAP.20.0.0', '82870800005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.I.CAP.21.0.0', '82871000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.I.IMO.17.0.0', '82871200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.I.IMO.18.0.0', '82871400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.I.IMO.19.0.0', '82871600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.I.IMO.20.0.0', '82871800005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.I.IMO.21.0.0', '82872000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.I.INT.17.0.0', '82871200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.I.INT.18.0.0', '82871400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.I.INT.19.0.0', '82871600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.I.INT.20.0.0', '82871800005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.I.INT.21.0.0', '82872000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.I.OTR.17.0.0', '82872200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.I.OTR.18.0.0', '82872400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.I.OTR.19.0.0', '82872600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.I.OTR.20.0.0', '82872800005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.I.OTR.21.0.0', '82873000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.O.CAP.17.0.0', '82880200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.O.CAP.18.0.0', '82880400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.O.CAP.19.0.0', '82880600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.O.CAP.20.0.0', '82880800005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.O.CAP.21.0.0', '82881000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.O.IMO.17.0.0', '82881200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.O.IMO.18.0.0', '82881400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.O.IMO.19.0.0', '82881600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.O.IMO.20.0.0', '82881800005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.O.IMO.21.0.0', '82882000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.O.INT.17.0.0', '82881200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.O.INT.18.0.0', '82881400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.O.INT.19.0.0', '82881600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.O.INT.20.0.0', '82881800005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.O.INT.21.0.0', '82882000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.O.OTR.17.0.0', '82882200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.O.OTR.18.0.0', '82882400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.O.OTR.19.0.0', '82882600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.O.OTR.20.0.0', '82882800005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '1.O.OTR.21.0.0', '82883000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.I.CAP.10.0.0', '82830800005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.I.CAP.11.0.0', '82831000005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.I.CAP.7.0.0', '82830200005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.I.CAP.8.0.0', '82830400005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.I.CAP.9.0.0', '82830600005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.I.IMO.10.0.0', '82831800005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.I.IMO.11.0.0', '82832000005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.I.IMO.7.0.0', '82831200005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.I.IMO.8.0.0', '82831400005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.I.IMO.9.0.0', '82831600005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.I.INT.10.0.0', '82831800005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.I.INT.11.0.0', '82832000005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.I.INT.7.0.0', '82831200005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.I.INT.8.0.0', '82831400005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.I.INT.9.0.0', '82831600005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.I.OTR.10.0.0', '82832800005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.I.OTR.11.0.0', '82833000005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.I.OTR.7.0.0', '82832200005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.I.OTR.8.0.0', '82832400005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.I.OTR.9.0.0', '82832600005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.O.CAP.10.0.0', '82840800005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.O.CAP.11.0.0', '82841000005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.O.CAP.7.0.0', '82840200005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.O.CAP.8.0.0', '82840400005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.O.CAP.9.0.0', '82840600005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.O.IMO.10.0.0', '82841800005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.O.IMO.11.0.0', '82842000005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.O.IMO.7.0.0', '82841200005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.O.IMO.8.0.0', '82841400005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.O.IMO.9.0.0', '82841600005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.O.INT.10.0.0', '82841800005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.O.INT.11.0.0', '82842000005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.O.INT.7.0.0', '82841200005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.O.INT.8.0.0', '82841400005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.O.INT.9.0.0', '82841600005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.O.OTR.10.0.0', '82842800005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.O.OTR.11.0.0', '82843000005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.O.OTR.7.0.0', '82842200005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.O.OTR.8.0.0', '82842400005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '2.O.OTR.9.0.0', '82842600005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.CAP.1.0.0', '82810200005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.CAP.2.0.0', '82810300005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.CAP.3.0.0', '82810500005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.CAP.4.0.0', '82810600005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.CAP.5.0.0', '82810800005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.CAP.6.0.0', '82811000005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.IMO.1.0.0', '82811200005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.IMO.2.0.0', '82811300005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.IMO.3.0.0', '82811400005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.IMO.4.0.0', '82811600005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.IMO.5.0.0', '82811800005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.IMO.6.0.0', '82812000005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.INT.1.0.0', '82811200005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.INT.2.0.0', '82811300005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.INT.3.0.0', '82811400005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.INT.4.0.0', '82811600005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.INT.5.0.0', '82811800005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.INT.6.0.0', '82812000005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.OTR.1.0.0', '82812200005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.OTR.2.0.0', '82812300005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.OTR.3.0.0', '82812400005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.OTR.4.0.0', '82812600005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.OTR.5.0.0', '82812800005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.I.OTR.6.0.0', '82813000005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.CAP.1.0.0', '82820200005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.CAP.2.0.0', '82820300005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.CAP.3.0.0', '82820400005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.CAP.4.0.0', '82820600005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.CAP.5.0.0', '82820800005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.CAP.6.0.0', '82821000005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.IMO.1.0.0', '82821200005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.IMO.2.0.0', '82821300005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.IMO.3.0.0', '82821400005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.IMO.4.0.0', '82821600005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.IMO.5.0.0', '82821800005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.IMO.6.0.0', '82822000005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.INT.1.0.0', '82821200005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.INT.2.0.0', '82821300005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.INT.3.0.0', '82821400005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.INT.4.0.0', '82821600005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.INT.5.0.0', '82821800005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.INT.6.0.0', '82822000005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.OTR.1.0.0', '82822200005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.OTR.2.0.0', '82822300005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.OTR.3.0.0', '82822400005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.OTR.4.0.0', '82822600005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.OTR.5.0.0', '82822800005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '3.O.OTR.6.0.0', '82823000005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.I.CAP.12.0.0', '82850200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.I.CAP.13.0.0', '82850400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.I.CAP.14.0.0', '82850600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.I.CAP.15.0.0', '82850800005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.I.CAP.16.0.0', '82851000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.I.IMO.12.0.0', '82851200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.I.IMO.13.0.0', '82851400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.I.IMO.14.0.0', '82851600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.I.IMO.15.0.0', '82851800005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.I.IMO.16.0.0', '82852000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.I.INT.12.0.0', '82851200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.I.INT.13.0.0', '82851400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.I.INT.14.0.0', '82851600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.I.INT.15.0.0', '82851800005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.I.INT.16.0.0', '82852000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.I.OTR.12.0.0', '82852200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.I.OTR.13.0.0', '82852400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.I.OTR.14.0.0', '82852600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.I.OTR.15.0.0', '82852800005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.I.OTR.16.0.0', '82853000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.O.CAP.12.0.0', '82860200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.O.CAP.13.0.0', '82860400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.O.CAP.14.0.0', '82860600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.O.CAP.15.0.0', '82860800005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.O.CAP.16.0.0', '82861000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.O.IMO.12.0.0', '82861200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.O.IMO.13.0.0', '82861400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.O.IMO.14.0.0', '82861600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.O.IMO.15.0.0', '82861800005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.O.IMO.16.0.0', '82862000008', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.O.INT.12.0.0', '82861200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.O.INT.13.0.0', '82861400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.O.INT.14.0.0', '82861600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.O.INT.15.0.0', '82861800005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.O.INT.16.0.0', '82862000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.O.OTR.12.0.0', '82862200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.O.OTR.13.0.0', '82862400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.O.OTR.14.0.0', '82862600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.O.OTR.15.0.0', '82862800005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_82', '4.O.OTR.16.0.0', '82863000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EDADES_84', '0', '84050000005', 21, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EFECT_11', '0', '11050500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'ES', 'F', '11', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'ES', 'V', '13', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'ES', 'X', '12', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EST_CRE_41', '0', '41159500025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EXE_PAG_25', '0', '25957000018', 7, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'EXQ_PAG_25', '0', '25957000010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_CAS_81', '1.0', '81201500050', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_CAS_81', '4.0', '81201800030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_PAG_25', '0', '25100500030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_PRO_16', 'A.I.1.0.0', '16946200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_PRO_16', 'A.I.4.0.0', '16923000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_PRO_16', 'A.O.1.0.0', '16946200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_PRO_16', 'A.O.4.0.0', '16923000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_PRO_16', 'B.I.1.0.0', '16946300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_PRO_16', 'B.I.4.0.0', '16923500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_PRO_16', 'B.O.1.0.0', '16946300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_PRO_16', 'B.O.4.0.0', '16923500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_PRO_16', 'C.I.1.0.0', '16946400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_PRO_16', 'C.I.4.0.0', '16924000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_PRO_16', 'C.O.1.0.0', '16946400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_PRO_16', 'C.O.4.0.0', '16924000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_PRO_16', 'D.I.1.0.0', '16946600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_PRO_16', 'D.I.4.0.0', '16924500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_PRO_16', 'D.O.1.0.0', '16946600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_PRO_16', 'D.O.4.0.0', '16924500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_PRO_16', 'E.I.1.0.0', '16946700005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_PRO_16', 'E.I.4.0.0', '16925000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_PRO_16', 'E.O.1.0.0', '16946700005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_PRO_16', 'E.O.4.0.0', '16925000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_REC_42', '1.0', '42250500028', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_REC_42', '4.0', '42250500028', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_REC_82', '1.0', '82241500030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_REC_82', '4.0', '82241800030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_SUS_63', '1.0', '63050000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_SUS_63', '4.0', '63050000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_SUS_64', '1.0', '64959500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_SUS_64', '4.0', '64959500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_VEN_16', 'A.I.1.0.0', '16390500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_VEN_16', 'A.I.4.0.0', '16380500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_VEN_16', 'A.O.1.0.0', '16390500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_VEN_16', 'A.O.4.0.0', '16380500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_VEN_16', 'B.I.1.0.0', '16391000020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_VEN_16', 'B.I.4.0.0', '16381000020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_VEN_16', 'B.O.1.0.0', '16391000020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_VEN_16', 'B.O.4.0.0', '16381000020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_VEN_16', 'C.I.1.0.0', '16391500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_VEN_16', 'C.I.4.0.0', '16381500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_VEN_16', 'C.O.1.0.0', '16391500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_VEN_16', 'C.O.4.0.0', '16381500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_VEN_16', 'D.I.1.0.0', '16392000020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_VEN_16', 'D.O.1.0.0', '16392000020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_VEN_16', 'D.O.4.0.0', '16382000020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_VEN_16', 'E.I.1.0.0', '16392500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_VEN_16', 'E.I.4.0.0', '16382500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_VEN_16', 'E.O.1.0.0', '16392500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FAG_VEN_16', 'E.O.4.0.0', '16382500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FGA_PAG_25', '0', '25100500025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_CAS_81', '1.0', '81201500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_CAS_81', '4.0', '81201800020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_CAU_51', '0', '51158000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_IVA_51', '0', '51409500010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_PAG_25', '0', '25100500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_PRO_16', 'A.I.1.0.0', '16946200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_PRO_16', 'A.I.4.0.0', '16923000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_PRO_16', 'A.O.1.0.0', '16946200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_PRO_16', 'A.O.4.0.0', '16923000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_PRO_16', 'B.I.1.0.0', '16946300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_PRO_16', 'B.I.4.0.0', '16923500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_PRO_16', 'B.O.1.0.0', '16946300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_PRO_16', 'B.O.4.0.0', '16923500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_PRO_16', 'C.I.1.0.0', '16946400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_PRO_16', 'C.I.4.0.0', '16924000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_PRO_16', 'C.O.1.0.0', '16946400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_PRO_16', 'C.O.4.0.0', '16924000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_PRO_16', 'D.I.1.0.0', '16946600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_PRO_16', 'D.I.4.0.0', '16924500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_PRO_16', 'D.O.1.0.0', '16946600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_PRO_16', 'D.O.4.0.0', '16924500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_PRO_16', 'E.I.1.0.0', '16946700005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_PRO_16', 'E.I.4.0.0', '16925000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_PRO_16', 'E.O.1.0.0', '16946700005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_PRO_16', 'E.O.4.0.0', '16925000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_REC_42', '1.0', '42250500025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_REC_42', '4.0', '42250500025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_REC_82', '1.0', '82241500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_REC_82', '4.0', '82241800020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_SUS_63', '1.0', '63050000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_SUS_63', '4.0', '63050000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_SUS_64', '1.0', '64959500020', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_SUS_64', '4.0', '64959500020', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_VEN_16', 'A.I.1.0.0', '16390500010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_VEN_16', 'A.I.4.0.0', '16380500010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_VEN_16', 'A.O.1.0.0', '16390500010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_VEN_16', 'A.O.4.0.0', '16380500010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_VEN_16', 'B.I.1.0.0', '16391000010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_VEN_16', 'B.I.4.0.0', '16381000010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_VEN_16', 'B.O.1.0.0', '16391000010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_VEN_16', 'B.O.4.0.0', '16381000010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_VEN_16', 'C.I.1.0.0', '16391500010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_VEN_16', 'C.I.4.0.0', '16381500010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_VEN_16', 'C.O.1.0.0', '16391500010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_VEN_16', 'C.O.4.0.0', '16381500010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_VEN_16', 'D.I.1.0.0', '16392000010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_VEN_16', 'D.I.4.0.0', '16382000010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_VEN_16', 'D.O.1.0.0', '16392000010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_VEN_16', 'D.O.4.0.0', '16382000010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_VEN_16', 'E.I.1.0.0', '16392500010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_VEN_16', 'E.I.4.0.0', '16382500010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_VEN_16', 'E.O.1.0.0', '16392500010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'FNG_VEN_16', 'E.O.4.0.0', '16382500010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GAR_821X', 'I.1.0', '82130500005', 19, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GAR_821X', 'I.4.0', '82132000005', 19, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GAR_821X', 'O.1.0', '82140500005', 19, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GAR_821X', 'O.4.0', '82142000005', 19, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GAR_8405', '0', '84050000005', 19, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_AHO', '0.O.A', '51020200010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_AHO', '0.O.C', '51020200010', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_AHO', '0.O.I', '51020200020', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_AHO', '0.O.T', '51020200020', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_AHO', '0.P.A', '51020200005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_AHO', '0.P.C', '51020200005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_AHO', '0.P.I', '51020200015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_AHO', '0.P.T', '51020200015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '000829390', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '005602022864', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '04305674476', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '04846913136', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '059000166', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '060031903', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '07009290730', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '09144480711', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '09798552203', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '10332654658', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '13050187020001100', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '202033171', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '21002631546', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '21500241120', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '26235451881', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '309005569', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '313200000617', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '348086794', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '35235451828', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '37131383220', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '39223904719', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '449019272', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '525024113', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '596251116', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '616119566', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '64526036103', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '66124397', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '70625691878', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '716007067', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '74428487208', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_COM', '9725971710', '51152000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_GMF', '0.NCABNOEM', '51403500010', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_GMF', '0.NCABONOPAG', '51403500020', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_GMF', '0.NCABPAVI', '51403500035', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_GMF', '0.NCDTN', '16879500130', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_GMF', '0.NCPAGOINCE', '51403500045', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'GASTO_GMF', '0.NCRPAGPROV', '51403500040', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_ABO_25', '0', '25957000025', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_CAS_81', '1.0', '81201500030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_CAS_81', '4.0', '81201800030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_PRO_16', 'A.I.1.0.0', '16946200900', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_PRO_16', 'A.I.4.0.0', '16923000900', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_PRO_16', 'A.O.1.0.0', '16946200900', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_PRO_16', 'A.O.4.0.0', '16923000900', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_PRO_16', 'B.I.1.0.0', '16946300900', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_PRO_16', 'B.I.4.0.0', '16923500900', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_PRO_16', 'B.O.1.0.0', '16946300900', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_PRO_16', 'B.O.4.0.0', '16923500900', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_PRO_16', 'C.I.1.0.0', '16946400900', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_PRO_16', 'C.I.4.0.0', '16924000900', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_PRO_16', 'C.O.1.0.0', '16946400900', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_PRO_16', 'C.O.4.0.0', '16924000900', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_PRO_16', 'D.I.1.0.0', '16946600900', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_PRO_16', 'D.I.4.0.0', '16924500900', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_PRO_16', 'D.O.1.0.0', '16946600900', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_PRO_16', 'D.O.4.0.0', '16924500900', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_PRO_16', 'E.I.1.0.0', '16946700900', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_PRO_16', 'E.I.4.0.0', '16925000900', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_PRO_16', 'E.O.1.0.0', '16946700900', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_PRO_16', 'E.O.4.0.0', '16925000900', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_REC_25', '1.0', '25957000025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_REC_25', '4.0', '25957000025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_REC_42', '1.0', '42250500035', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_REC_42', '4.0', '42250500035', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_REC_82', '1.0', '82241500030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_REC_82', '4.0', '82241800030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_VEN_16', 'A.1.0.0', '16390500200', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_VEN_16', 'A.4.0.0', '16380500200', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_VEN_16', 'B.1.0.0', '16391000200', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_VEN_16', 'B.4.0.0', '16381000200', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_VEN_16', 'C.1.0.0', '16391500200', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_VEN_16', 'C.4.0.0', '16381500200', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_VEN_16', 'D.1.0.0', '16392000200', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_VEN_16', 'D.4.0.0', '16382000200', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_VEN_16', 'E.1.0.0', '16392500200', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'HON_VEN_16', 'E.4.0.0', '16382500200', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_27_ACT', '1.0', '51701500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_27_ACT', '4.0', '51701500030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_27_ANT', '1.0', '41600800020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_27_ANT', '4.0', '41600800030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_CAS_42', '1.0', '42250500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_CAS_42', '2.0', '42250500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_CAS_42', '3.0', '42250500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_CAS_42', '4.0', '42250500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_CAS_81', '1.0', '81201500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_CAS_81', '2.0', '81201600010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_CAS_81', '4.0', '81201800010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_CAS_82', '1.0', '82241500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_CAS_82', '2.0', '82241600010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_CAS_82', '3.0', '82241700010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_CAS_82', '4.0', '82241800010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_FAG_25', '1.0', '25100500030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_FAG_25', '4.0', '25100500030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_FAG_81', '1.0', '81959500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_FAG_81', '4.0', '81959500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_FNG_25', '1.0', '25957000035', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_FNG_25', '4.0', '25957000035', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_FNG_81', '1.0', '81959500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_FNG_81', '4.0', '81959500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_FNG_83', '1.0', '82959500010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_FNG_83', '4.0', '82959500010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_PRO_16', 'A.I.1.0.0', '16945200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_PRO_16', 'A.I.4.0.0', '16920500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_PRO_16', 'A.O.1.0.0', '16945200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_PRO_16', 'A.O.4.0.0', '16920500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_PRO_16', 'B.I.1.0.0', '16945300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_PRO_16', 'B.I.4.0.0', '16921000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_PRO_16', 'B.O.1.0.0', '16945300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_PRO_16', 'B.O.4.0.0', '16921000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_PRO_16', 'C.I.1.0.0', '16945400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_PRO_16', 'C.I.4.0.0', '16921500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_PRO_16', 'C.O.1.0.0', '16945400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_PRO_16', 'C.O.4.0.0', '16921500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_PRO_16', 'D.I.1.0.0', '16945600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_PRO_16', 'D.I.4.0.0', '16922000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_PRO_16', 'D.O.1.0.0', '16945600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_PRO_16', 'D.O.2.0.0', '16965600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_PRO_16', 'D.O.4.0.0', '16922000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_PRO_16', 'E.I.1.0.0', '16945700005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_PRO_16', 'E.I.4.0.0', '16922500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_PRO_16', 'E.O.1.0.0', '16945700005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_PRO_16', 'E.O.4.0.0', '16922500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_41', '1.0', '41021000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_41', '2.0', '41024100005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_41', '4.0', '41024300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_63', '1.0', '63300500010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_63', '2.0', '63301000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_63', '3.0', '63301500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_63', '4.0', '63301900010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'A.1.0.0', '64305000010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'A.2.0.0', '64303000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'A.2.0.1', '64303000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'A.3.0.0', '64302000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'A.3.0.1', '64302000010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'A.4.0.0', '64304000010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'B.1.0.0', '64305200010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'B.2.0.0', '64303200010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'B.2.0.1', '64303200010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'B.3.0.0', '64302200010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'B.3.0.1', '64302200010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'B.4.0.0', '64304200010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'C.1.0.0', '64305400010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'C.2.0.0', '64303400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'C.2.0.1', '64303400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'C.3.0.0', '64302400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'C.3.0.1', '64302400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'C.4.0.0', '64304400010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'D.1.0.0', '64305600010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'D.2.0.0', '64303600010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'D.2.0.1', '64303600010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'D.3.0.0', '64302600010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'D.3.0.1', '64302600010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'D.4.0.0', '64304600010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'E.1.0.0', '64305800010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'E.2.0.0', '64303800010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'E.2.0.1', '64303800010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'E.3.0.0', '64302800010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'E.3.0.1', '64302800010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_SUS_64', 'E.4.0.0', '64304800010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'A.1.0.0', '41021000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'A.2.0.0', '41024100010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'A.2.0.1', '41024100005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'A.3.0.0', '41024200010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'A.3.0.1', '41024200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'A.4.0.0', '41024300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'B.1.0.0', '41021000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'B.2.0.0', '41024100010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'B.2.0.1', '41024100005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'B.3.0.0', '41024200010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'B.3.0.1', '41024200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'B.4.0.0', '41024300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'C.1.0.0', '41021000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'C.2.0.0', '41024100010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'C.2.0.1', '41024100005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'C.3.0.0', '41024200010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'C.3.0.1', '41024200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'C.4.0.0', '41024300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'D.1.0.0', '41021000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'D.2.0.0', '41024100010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'D.2.0.1', '41024100005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'D.3.0.0', '41024200010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'D.3.0.1', '41024200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'D.4.0.0', '41024300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'E.1.0.0', '41021000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'E.2.0.0', '41024100010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'E.2.0.1', '41024100005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'E.3.0.0', '41024200010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'E.3.0.1', '41024200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VEN_41', 'E.4.0.0', '41024300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'A.I.1.0.0', '16054200010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'A.I.2.0.0', '16051800010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'A.I.2.0.1', '19503000025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'A.I.3.0.0', '16050600010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'A.I.3.0.1', '19502000020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'A.I.4.0.0', '16053200010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'A.O.1.0.0', '16054200010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'A.O.2.0.0', '16051800010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'A.O.2.0.1', '19503000025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'A.O.3.0.0', '16050600010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'A.O.3.0.1', '19502000020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'A.O.4.0.0', '16053200010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'B.I.1.0.0', '16054400010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'B.I.2.0.0', '16052200010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'B.I.2.0.1', '19503200025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'B.I.3.0.0', '16050800010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'B.I.3.0.1', '19502200020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'B.I.4.0.0', '16053400010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'B.O.1.0.0', '16054400010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'B.O.2.0.0', '16052200010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'B.O.2.0.1', '19503200025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'B.O.3.0.0', '16050800010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'B.O.3.0.1', '19502200020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'B.O.4.0.0', '16053400010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'C.I.1.0.0', '16054600010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'C.I.2.0.0', '16052400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'C.I.2.0.1', '19503400025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'C.I.3.0.0', '16051200010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'C.I.3.0.1', '19502400020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'C.I.4.0.0', '16053600010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'C.O.1.0.0', '16054600010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'C.O.2.0.0', '16052400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'C.O.2.0.1', '19503400025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'C.O.3.0.0', '16051200010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'C.O.3.0.1', '19502400020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'C.O.4.0.0', '16053600010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'D.I.1.0.0', '16054800010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'D.I.2.0.0', '16052600010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'D.I.2.0.1', '19503600025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'D.I.3.0.0', '16051400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'D.I.3.0.1', '19502600020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'D.I.4.0.0', '16053800010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'D.O.1.0.0', '16054800010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'D.O.2.0.0', '16052600010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'D.O.2.0.1', '19503600025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'D.O.3.0.0', '16051400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'D.O.3.0.1', '19502600020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'D.O.4.0.0', '16053800010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'E.I.1.0.0', '16054900010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'E.I.2.0.0', '16052800010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'E.I.2.0.1', '19503800025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'E.I.3.0.0', '16051600010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'E.I.3.0.1', '19502800020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'E.I.4.0.0', '16054000010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'E.O.1.0.0', '16054900010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'E.O.2.0.0', '16052800010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'E.O.2.0.1', '19503800025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'E.O.3.0.0', '16051600010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'E.O.3.0.1', '19502800020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_16', 'E.O.4.0.0', '16054000010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IMO_VIG_27', '0', '27203500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IND_PAG_25', '0', '25957000051', 7, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INTXP_AHO', '0.A', '28050500005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INTXP_AHO', '0.C', '28050500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INTXP_AHO', '0.I', '28050500015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INTXP_AHO', '0.T', '28050500015', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INTXP_AHO', '1.A', '28050501005', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INTXP_AHO', '1.I', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INTXP_AHO', '1.T', '28050501015', 4, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_27_ACT', '1.0', '51701500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_27_ACT', '4.0', '51701500030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_27_ANT', '1.0', '41600800020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_27_ANT', '4.0', '41600800030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_CAS_42', '1.0', '42250500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_CAS_42', '2.0', '42250500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_CAS_42', '3.0', '42250500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_CAS_42', '4.0', '42250500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_CAS_81', '1.0', '81201500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_CAS_81', '2.0', '81201600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_CAS_81', '4.0', '81201800005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_CAS_82', '1.0', '82241500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_CAS_82', '2.0', '82241600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_CAS_82', '3.0', '82241700005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_CAS_82', '4.0', '82241800005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_CIC_16', 'A.I.1.0.0', '16991500052', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_CIC_16', 'A.O.1.0.0', '16991500052', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_CIC_16', 'B.I.1.0.0', '16991500053', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_CIC_16', 'B.O.1.0.0', '16991500053', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_CIC_16', 'C.I.1.0.0', '16991500054', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_CIC_16', 'C.O.1.0.0', '16991500054', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_CIC_16', 'D.I.1.0.0', '16991500056', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_CIC_16', 'D.O.1.0.0', '16991500056', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_CIC_16', 'E.I.1.0.0', '16991500057', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_CIC_16', 'E.O.1.0.0', '16991500057', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'A.I.1.0.30.0', '25051500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'A.I.1.0.35.0', '25051500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'A.I.4.0.30.0', '25051500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'A.I.4.0.35.0', '25051500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'A.O.1.0.30.0', '25051500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'A.O.1.0.35.0', '25051500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'A.O.4.0.30.0', '25051500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'A.O.4.0.35.0', '25051500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'B.I.1.0.30.0', '25051500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'B.I.1.0.35.0', '25051500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'B.I.4.0.30.0', '25051500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'B.I.4.0.35.0', '25051500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'B.O.1.0.30.0', '25051500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'B.O.1.0.35.0', '25051500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'B.O.4.0.30.0', '25051500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'B.O.4.0.35.0', '25051500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'C.I.1.0.30.0', '25051500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'C.I.1.0.35.0', '25051500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'C.I.4.0.30.0', '25051500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'C.I.4.0.35.0', '25051500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'C.O.1.0.30.0', '25051500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'C.O.1.0.35.0', '25051500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'C.O.4.0.30.0', '25051500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'C.O.4.0.35.0', '25051500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'D.I.1.0.30.0', '25051500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'D.I.1.0.35.0', '25051500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'D.I.4.0.30.0', '25051500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'D.I.4.0.35.0', '25051500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'D.O.1.0.30.0', '25051500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'D.O.1.0.35.0', '25051500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'D.O.4.0.30.0', '25051500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'D.O.4.0.35.0', '25051500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'E.I.1.0.30.0', '25051500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'E.I.1.0.35.0', '25051500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'E.I.4.0.30.0', '25051500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'E.I.4.0.35.0', '25051500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'E.O.1.0.30.0', '25051500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'E.O.1.0.35.0', '25051500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'E.O.4.0.30.0', '25051500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_25', 'E.O.4.0.35.0', '25051500015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'A.I.1.0.30.0', '51030400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'A.I.1.0.35.0', '51030400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'A.I.4.0.30.0', '51030400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'A.I.4.0.35.0', '51030400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'A.O.1.0.30.0', '51030400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'A.O.1.0.35.0', '51030400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'A.O.4.0.30.0', '51030400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'A.O.4.0.35.0', '51030400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'B.I.1.0.30.0', '51030400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'B.I.1.0.35.0', '51030400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'B.I.4.0.30.0', '51030400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'B.I.4.0.35.0', '51030400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'B.O.1.0.30.0', '51030400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'B.O.1.0.35.0', '51030400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'B.O.4.0.30.0', '51030400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'B.O.4.0.35.0', '51030400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'C.I.1.0.30.0', '51030400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'C.I.1.0.35.0', '51030400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'C.I.4.0.30.0', '51030400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'C.I.4.0.35.0', '51030400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'C.O.1.0.30.0', '51030400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'C.O.1.0.35.0', '51030400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'C.O.4.0.30.0', '51030400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'C.O.4.0.35.0', '51030400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'D.I.1.0.30.0', '51030400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'D.I.1.0.35.0', '51030400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'D.I.4.0.30.0', '51030400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'D.I.4.0.35.0', '51030400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'D.O.1.0.30.0', '51030400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'D.O.1.0.35.0', '51030400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'D.O.4.0.30.0', '51030400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'D.O.4.0.35.0', '51030400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'E.I.1.0.30.0', '51030400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'E.I.1.0.35.0', '51030400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'E.I.4.0.30.0', '51030400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'E.I.4.0.35.0', '51030400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'E.O.1.0.30.0', '51030400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'E.O.1.0.35.0', '51030400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'E.O.4.0.30.0', '5030400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PAS_51', 'E.O.4.0.35.0', '51030400010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'A.I.1.0.0', '16945200005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'A.I.4.0.0', '16920500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'A.O.1.0.0', '16945200005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'A.O.4.0.0', '16920500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'B.I.1.0.0', '16945300005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'B.I.4.0.0', '16921000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'B.O.1.0.0', '16945300005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'B.O.4.0.0', '16921000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'C.I.1.0.0', '16945400005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'C.I.4.0.0', '16921500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'C.O.1.0.0', '16945400005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'C.O.4.0.0', '16921500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'D.I.1.0.0', '16945600005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'D.I.4.0.0', '16922000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'D.O.1.0.0', '16945600005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'D.O.2.0.0', '16965600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'D.O.4.0.0', '16922000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'E.I.1.0.0', '16945700005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'E.I.4.0.0', '16922500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'E.O.1.0.0', '16945700005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'E.O.2.0.0', '16965700005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_PRO_16', 'E.O.4.0.0', '16922500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_41', '1.0', '41020200005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_41', '4.0', '41020900005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_63', '1.0', '63300500005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_63', '2.0', '63301000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_63', '3.0', '63301500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_63', '4.0', '63301900005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'A.1.0.0', '64305000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'A.2.0.0', '64303000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'A.2.0.1', '64303000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'A.3.0.0', '64302000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'A.3.0.1', '64302000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'A.4.0.0', '64304000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'B.1.0.0', '64305200005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'B.2.0.0', '64303200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'B.2.0.1', '64303200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'B.3.0.0', '64302200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'B.3.0.1', '64302200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'B.4.0.0', '64304200005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'C.1.0.0', '64305400005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'C.2.0.0', '64303400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'C.2.0.1', '64303400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'C.3.0.0', '64302400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'C.3.0.1', '64302400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'C.4.0.0', '64304400005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'D.1.0.0', '64305600005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'D.2.0.0', '64303600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'D.2.0.1', '64303600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'D.3.0.0', '64302600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'D.3.0.1', '64302600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'D.4.0.0', '64304600005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'E.1.0.0', '64305800005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'E.2.0.0', '64303800005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'E.2.0.1', '64303800005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'E.3.0.0', '64302800005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'E.3.0.1', '64302800005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_SUS_64', 'E.4.0.0', '64304800005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'A.I.1.0.0', '16054200005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'A.I.2.0.0', '16051800005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'A.I.2.0.1', '19503000020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'A.I.3.0.0', '16050600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'A.I.3.0.1', '19502000015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'A.I.4.0.0', '16053200005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'A.O.1.0.0', '16054200005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'A.O.2.0.0', '16051800005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'A.O.2.0.1', '19503000020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'A.O.3.0.0', '16050600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'A.O.3.0.1', '19502000015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'A.O.4.0.0', '16053200005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'B.I.1.0.0', '16054400005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'B.I.2.0.0', '16052200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'B.I.2.0.1', '19503200020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'B.I.3.0.0', '16050800005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'B.I.3.0.1', '19502200015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'B.I.4.0.0', '16053400005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'B.O.1.0.0', '16054400005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'B.O.2.0.0', '16052200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'B.O.2.0.1', '19503200020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'B.O.3.0.0', '16050800005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'B.O.3.0.1', '19502200015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'B.O.4.0.0', '16053400005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'C.I.1.0.0', '16054600005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'C.I.2.0.0', '16052400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'C.I.2.0.1', '19503400020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'C.I.3.0.0', '16051200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'C.I.3.0.1', '19502400015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'C.I.4.0.0', '16053600005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'C.O.1.0.0', '16054600005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'C.O.2.0.0', '16052400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'C.O.2.0.1', '19503400020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'C.O.3.0.0', '16051200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'C.O.3.0.1', '19502400015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'C.O.4.0.0', '16053600005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'D.I.1.0.0', '16054800005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'D.I.2.0.0', '16052600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'D.I.2.0.1', '19503600020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'D.I.3.0.0', '16051400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'D.I.3.0.1', '19502600015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'D.I.4.0.0', '16053800005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'D.O.1.0.0', '16054800005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'D.O.2.0.0', '16052600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'D.O.2.0.1', '19503600020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'D.O.3.0.0', '16051400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'D.O.3.0.1', '19502600015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'D.O.4.0.0', '16053800005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'E.I.1.0.0', '16054900005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'E.I.2.0.0', '16052800005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'E.I.2.0.1', '19503800020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'E.I.3.0.0', '16051600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'E.I.3.0.1', '19502800015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'E.I.4.0.0', '16054000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'E.O.1.0.0', '16054900005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'E.O.2.0.0', '16052800005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'E.O.2.0.1', '19503800020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'E.O.3.0.0', '16051600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'E.O.3.0.1', '19502800015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_16', 'E.O.4.0.0', '16054000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_27', '0', '27203500010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_41', '1.0.15.0', '41020200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_41', '1.0.30.0', '41020700005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_41', '1.0.35.0', '41020700010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_41', '2.0.15.0', '41020300010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_41', '2.0.15.1', '41020300020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_41', '3.0.15.0', '41020800010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_41', '3.0.15.1', '41020800005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_41', '4.0.15.0', '41020900005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_41', '4.0.30.0', '41020900005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'INT_VIG_41', '4.0.35.0', '41020900005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IVA_27_ACT', '1.0', '51701500025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IVA_27_ACT', '4.0', '51701500040', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IVA_27_ANT', '1.0', '41600800025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IVA_27_ANT', '4.0', '41600800040', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IVA_PAG_25', '0', '25350000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'IVA_VEN_27', '0', '27203500025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_CAS_81', '0', '81201500035', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_PRO_16', 'A.I.1.0.0', '16946200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_PRO_16', 'A.I.4.0.0', '16923000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_PRO_16', 'A.O.1.0.0', '16946200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_PRO_16', 'A.O.4.0.0', '16923000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_PRO_16', 'B.I.1.0.0', '16946300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_PRO_16', 'B.I.4.0.0', '16923500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_PRO_16', 'B.O.1.0.0', '16946300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_PRO_16', 'B.O.4.0.0', '16923500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_PRO_16', 'C.I.1.0.0', '16946400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_PRO_16', 'C.I.4.0.0', '16924000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_PRO_16', 'C.O.1.0.0', '16946400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_PRO_16', 'C.O.4.0.0', '16924000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_PRO_16', 'D.I.1.0.0', '16946600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_PRO_16', 'D.I.4.0.0', '16924500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_PRO_16', 'D.O.1.0.0', '16946600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_PRO_16', 'D.O.4.0.0', '16924500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_PRO_16', 'E.I.1.0.0', '16946700005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_PRO_16', 'E.I.4.0.0', '16925000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_PRO_16', 'E.O.1.0.0', '16946700005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_PRO_16', 'E.O.4.0.0', '16925000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_REC_42', '0', '42259500010', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_VEN_16', 'A.1.0.0', '16390500205', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_VEN_16', 'A.4.0.0', '16380500205', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_VEN_16', 'B.1.0.0', '16391000205', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_VEN_16', 'B.4.0.0', '16381000205', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_VEN_16', 'C.1.0.0', '16391500205', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_VEN_16', 'C.4.0.0', '16381500205', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_VEN_16', 'D.1.0.0', '16392000205', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_VEN_16', 'D.4.0.0', '16382000205', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_VEN_16', 'E.1.0.0', '16392500205', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'JUD_VEN_16', 'E.4.0.0', '16382500205', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'KTC-TG-CA', '1.A.I', '5982', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'KTC-TG-CA', '1.A.O', '6682', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'KTC-TG-CA', '1.B.I', '6082', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'KTC-TG-CA', '1.B.O', '6782', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'KTC-TG-CA', '1.C.I', '6282', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'KTC-TG-CA', '1.C.O', '6882', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'KTC-TG-CA', '1.D.I', '6382', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'KTC-TG-CA', '1.D.O', '6982', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'KTC-TG-CA', '1.E.I', '6582', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'KTC-TG-CA', '1.E.O', '7082', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'KTC-TG-CA', '4.A.I', '5605', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'KTC-TG-CA', '4.A.O', '5705', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'KTC-TG-CA', '4.B.I', '5610', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'KTC-TG-CA', '4.B.O', '5710', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'KTC-TG-CA', '4.C.I', '5615', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'KTC-TG-CA', '4.C.O', '5715', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'KTC-TG-CA', '4.D.I', '5620', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'KTC-TG-CA', '4.D.O', '5720', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'KTC-TG-CA', '4.E.I', '5625', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'KTC-TG-CA', '4.E.O', '5725', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'MC-TG', '4.I', '56', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'MC-TG', '4.O', '57', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'MD', '0', '00', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'MD', '1', '01', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'MIC_PAG_SE', '0', '25957000016', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'MO', '0', '00', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'MO', '1', '01', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'OP', '11', '005', 21, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'OP', '12', '005', 21, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'OP', '16', '010', 21, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'PRI_PAG_25', '0', '25957000051', 7, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG', '1.A.I', '05', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG', '1.A.O', '07', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG', '1.B.I', '10', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG', '1.B.O', '12', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG', '1.C.I', '15', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG', '1.C.O', '17', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG', '1.D.I', '20', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG', '1.D.O', '22', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG', '1.E.I', '25', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG', '1.E.O', '27', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG', '4.A.I', '05', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG', '4.A.O', '07', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG', '4.B.I', '10', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG', '4.B.O', '12', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG', '4.C.I', '15', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG', '4.C.O', '17', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG', '4.D.I', '20', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG', '4.D.O', '22', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG', '4.E.I', '25', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG', '4.E.O', '27', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG-CO', '1.A.I', '05', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG-CO', '1.A.O', '07', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG-CO', '1.B.I', '10', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG-CO', '1.B.O', '12', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG-CO', '1.C.I', '15', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG-CO', '1.C.O', '17', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG-CO', '1.D.I', '20', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG-CO', '1.D.O', '22', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG-CO', '1.E.I', '25', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG-CO', '1.E.O', '27', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG-MI', '4.A.I', '05', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG-MI', '4.A.O', '07', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG-MI', '4.B.I', '10', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG-MI', '4.B.O', '12', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG-MI', '4.C.I', '15', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG-MI', '4.C.O', '17', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG-MI', '4.D.I', '20', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG-MI', '4.D.O', '22', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG-MI', '4.E.I', '25', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RC-TG-MI', '4.E.O', '27', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RECTACLITC', '1', '39', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RECTACLITC', '2', '37', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RECTACLITC', '3', '36', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RECTACLITC', '4', '38', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'CSGAGRA617', '205', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'CSGBBVA067', '115', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'CSGBCOL203', '055', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'CSGBOGO903', '125', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBBVA569', '160', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBCOL103', '090', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBCOL136', '180', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBCOL208', '105', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBCOL220', '080', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBCOL476', '050', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBCOL658', '110', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBCOL711', '065', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBCOL719', '085', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBCOL730', '060', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBCOL828', '075', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBCOL878', '100', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBCOL881', '070', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBCSC120', '220', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBCSC546', '165', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBOGO116', '135', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBOGO166', '120', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBOGO272', '250', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBOGO292', '255', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBOGO390', '245', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBOGO412', '145', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBOGO566', '140', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBOGO578', '265', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRBOGO794', '130', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRCOLP864', '225', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REFE', 'GIRPOPU397', '235', 3, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REM_AHO', '0.CH_OTR', '11300500005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'REM_AHO', '1.CH_OTR', '11301001005', 4, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RI-CAT-TC', '1.A', '42', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RI-CAT-TC', '1.B', '44', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RI-CAT-TC', '1.C', '46', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RI-CAT-TC', '1.D', '48', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RI-CAT-TC', '1.E', '49', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RI-CAT-TC', '2.A', '18', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RI-CAT-TC', '2.B', '22', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RI-CAT-TC', '2.C', '24', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RI-CAT-TC', '2.D', '26', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RI-CAT-TC', '2.E', '28', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RI-CAT-TC', '3.A', '06', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RI-CAT-TC', '3.B', '08', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RI-CAT-TC', '3.C', '12', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RI-CAT-TC', '3.D', '14', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RI-CAT-TC', '3.E', '16', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RI-CAT-TC', '4.A', '32', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RI-CAT-TC', '4.B', '34', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RI-CAT-TC', '4.C', '36', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RI-CAT-TC', '4.D', '38', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RI-CAT-TC', '4.E', '40', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RP-CART', 'CAP.4', '0800005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-CXC', '10', '005', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-CXC', '11', '010', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-CXC', '12', '005', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-CXC', '16', '010', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-CXC', '17', '025', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-CXC', '19', '005', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-CXC', '20', '035', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-CXC', '21', '010', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-CXC', '22', '005', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-CXC', '23', '710', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-CXC', '24', '715', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-CXC', '25', '720', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-CXC', '26', '725', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-CXC', '3', '025', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-CXC', '4', '005', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-CXC', '6', '005', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-CXC', '7', '795', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-CXC', '8', '595', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-CXC', '9', '005', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-GAS', '10', '120', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-GAS', '11', '140', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-GAS', '12', '150', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-GAS', '16', '150', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-GAS', '17', '110', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-GAS', '19', '115', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-GAS', '2', '005', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-GAS', '20', '110', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-GAS', '21', '120', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-GAS', '22', '140', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-GAS', '23', '165', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-GAS', '24', '165', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-GAS', '25', '165', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-GAS', '26', '165', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-GAS', '3', '110', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-GAS', '4', '125', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-GAS', '5', '120', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-GAS', '6', '145', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-GAS', '7', '165', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-GAS', '8', '130', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-GAS', '9', '115', 21, 'CTB_OF', 'D')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-ING', '1', '09', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-ING', '12', '08', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-ING', '16', '08', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-ING', '2', '08', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-ING', '3', '08', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-ING', '4', '08', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-ING', '5', '08', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-ING', '6', '08', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU-ING', '7', '08', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.1.I', '8102', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.1.O', '8202', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.10.I', '8308', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.10.O', '8408', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.11.I', '8310', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.11.O', '8410', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.12.I', '8502', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.12.O', '8602', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.13.I', '8504', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.13.O', '8604', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.14.I', '8506', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.14.O', '8606', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.15.I', '8508', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.15.O', '8608', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.16.I', '8510', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.16.O', '8610', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.17.I', '8702', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.17.O', '8802', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.18.I', '8704', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.18.O', '8804', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.19.I', '8706', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.19.O', '8806', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.2.I', '8103', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.2.O', '8203', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.20.I', '8708', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.20.O', '8808', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.21.I', '8710', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.21.O', '8810', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.3.I', '8105', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.3.O', '8204', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.4.I', '8106', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.4.O', '8206', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.5.I', '8108', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.5.O', '8208', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.6.I', '8110', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.6.O', '8210', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.7.I', '8302', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.7.O', '8402', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.8.I', '8304', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.8.O', '8404', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.9.I', '8306', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '1.9.O', '8406', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.1.I', '8112', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.1.O', '8212', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.10.I', '8318', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.10.O', '8418', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.11.I', '8320', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.11.O', '8420', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.12.I', '8512', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.12.O', '8612', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.13.I', '8514', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.13.O', '8614', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.14.I', '8516', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.14.O', '8616', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.15.I', '8518', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.15.O', '8618', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.16.I', '8520', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.16.O', '8620', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.17.I', '8712', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.17.O', '8812', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.18.I', '8714', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.18.O', '8814', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.19.I', '8716', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.19.O', '8816', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.2.I', '8113', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.2.O', '8213', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.20.I', '8718', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.20.O', '8818', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.21.I', '8720', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.21.O', '8820', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.3.I', '8114', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.3.O', '8214', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.4.I', '8116', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.4.O', '8216', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.5.I', '8118', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.5.O', '8218', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.6.I', '8120', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.6.O', '8220', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.7.I', '8312', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.7.O', '8412', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.8.I', '8314', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.8.O', '8414', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.9.I', '8316', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '2.9.O', '8416', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.1.I', '8122', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.1.O', '8222', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.10.I', '8328', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.10.O', '8428', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.11.I', '8330', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.11.O', '8430', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.12.I', '8522', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.12.O', '8622', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.13.I', '8524', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.13.O', '8624', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.14.I', '8526', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.14.O', '8626', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.15.I', '8528', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.15.O', '8628', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.16.I', '8530', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.16.O', '8630', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.17.I', '8722', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.17.O', '8822', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.18.I', '8724', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.18.O', '8824', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.19.I', '8726', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.19.O', '8826', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.2.I', '8123', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.2.O', '8223', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.20.I', '8728', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.20.O', '8828', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.21.I', '8730', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.21.O', '8830', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.3.I', '8124', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.3.O', '8224', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.4.I', '8126', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.4.O', '8226', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.5.I', '8128', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.5.O', '8228', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.6.I', '8130', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.6.O', '8230', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.7.I', '8322', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.7.O', '8422', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.8.I', '8324', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.8.O', '8424', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.9.I', '8326', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '5.9.O', '8426', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.1.I', '8122', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.1.O', '8222', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.10.I', '8328', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.10.O', '8428', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.11.I', '8330', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.11.O', '8430', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.12.I', '8522', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.12.O', '8622', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.13.I', '8524', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.13.O', '8624', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.14.I', '8526', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.14.O', '8626', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.15.I', '8528', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.15.O', '8628', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.16.I', '8530', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.16.O', '8630', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.17.I', '8722', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.17.O', '8822', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.18.I', '8724', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.18.O', '8824', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.19.I', '8726', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.19.O', '8826', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.2.I', '8123', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.2.O', '8223', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.20.I', '8728', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.20.O', '8828', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.21.I', '8730', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.21.O', '8830', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.3.I', '8124', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.3.O', '8224', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.4.I', '8126', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.4.O', '8226', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.5.I', '8128', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.5.O', '8228', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.6.I', '8130', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.6.O', '8230', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.7.I', '8322', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.7.O', '8422', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.8.I', '8324', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.8.O', '8424', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.9.I', '8326', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '6.9.O', '8426', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.1.I', '8122', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.1.O', '8222', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.10.I', '8328', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.10.O', '8428', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.11.I', '8330', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.11.O', '8430', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.12.I', '8522', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.12.O', '8622', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.13.I', '8524', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.13.O', '8624', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.14.I', '8526', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.14.O', '8626', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.15.I', '8528', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.15.O', '8628', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.16.I', '8530', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.16.O', '8630', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.17.I', '8722', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.17.O', '8822', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.18.I', '8724', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.18.O', '8824', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.19.I', '8726', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.19.O', '8826', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.2.I', '8123', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.2.O', '8223', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.20.I', '8728', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.20.O', '8828', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.21.I', '8730', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.21.O', '8830', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.3.I', '8124', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.3.O', '8224', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.4.I', '8126', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.4.O', '8226', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.5.I', '8128', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.5.O', '8228', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.6.I', '8130', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.6.O', '8230', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.7.I', '8322', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.7.O', '8422', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.8.I', '8324', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.8.O', '8424', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.9.I', '8326', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'RU_ED_GA', '7.9.O', '8426', 21, 'CTB_OF', '')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SCTA_MO_AU', '0', '0500005', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SCTA_MO_AU', '1', '1001010', 21, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_CAS_81', '1.0', '81201500025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_CAS_81', '2.0', '81201600015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_CAS_81', '4.0', '81201800025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_CAU_51', '0', '51552000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_PAG_25', '0', '25957000007', 7, 'CTB_OF', 'C')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_PRO_16', 'A.I.1.0.0', '16946200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_PRO_16', 'A.I.4.0.0', '16923000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_PRO_16', 'A.O.1.0.0', '16946200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_PRO_16', 'A.O.4.0.0', '16923000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_PRO_16', 'B.I.1.0.0', '16946300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_PRO_16', 'B.I.4.0.0', '16923500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_PRO_16', 'B.O.1.0.0', '16946300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_PRO_16', 'B.O.4.0.0', '16923500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_PRO_16', 'C.I.1.0.0', '16946400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_PRO_16', 'C.I.4.0.0', '16924000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_PRO_16', 'C.O.1.0.0', '16946400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_PRO_16', 'C.O.4.0.0', '16924000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_PRO_16', 'D.I.1.0.0', '16946600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_PRO_16', 'D.I.4.0.0', '16924500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_PRO_16', 'D.O.1.0.0', '16946600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_PRO_16', 'D.O.4.0.0', '16924500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_PRO_16', 'E.I.1.0.0', '16946700005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_PRO_16', 'E.I.4.0.0', '16925000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_PRO_16', 'E.O.1.0.0', '16946700005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_PRO_16', 'E.O.4.0.0', '16925000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_REC_42', '1.0', '42250500030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_REC_42', '2.0', '42250500030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_REC_42', '3.0', '42250500030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_REC_42', '4.0', '42250500030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_REC_82', '1.0', '82241500025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_REC_82', '2.0', '82241600015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_REC_82', '3.0', '82241700015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_REC_82', '4.0', '82241800025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_SUS_63', '1.0', '63050000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_SUS_63', '4.0', '63050000005', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_SUS_64', '1.0', '64959500025', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_SUS_64', '4.0', '64959500025', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'A.1.0.0', '16390500105', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'A.2.0.0', '16370500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'A.2.0.1', '19503000030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'A.3.0.0', '16360500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'A.3.0.1', '19502000025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'A.4.0.0', '16380500105', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'B.1.0.0', '16391000105', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'B.2.0.0', '16371000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'B.2.0.1', '19503200030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'B.3.0.0', '16361000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'B.3.0.1', '19502200025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'B.4.0.0', '16381000105', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'C.1.0.0', '16391500105', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'C.2.0.0', '16371500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'C.2.0.1', '19503400030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'C.3.0.0', '16361500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'C.3.0.1', '19502400025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'C.4.0.0', '16381500105', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'D.1.0.0', '16392000105', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'D.2.0.0', '16372000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'D.2.0.1', '19503600030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'D.3.0.0', '16362000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'D.3.0.1', '19502600025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'D.4.0.0', '16382000105', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'E.1.0.0', '16392500105', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'E.2.0.0', '16372500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'E.2.0.1', '19503800030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'E.3.0.0', '16362500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'E.3.0.1', '19502800025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SEG_VEN_16', 'E.4.0.0', '16382500105', 7, NULL, NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SM_PRO_16', 'A.I.1.0.0', '16946200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SM_PRO_16', 'A.I.4.0.0', '16923000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SM_PRO_16', 'A.O.1.0.0', '16946200005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SM_PRO_16', 'A.O.4.0.0', '16923000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SM_PRO_16', 'B.I.1.0.0', '16946300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SM_PRO_16', 'B.I.4.0.0', '16923500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SM_PRO_16', 'B.O.1.0.0', '16946300005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SM_PRO_16', 'B.O.4.0.0', '16923500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SM_PRO_16', 'C.I.1.0.0', '16946400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SM_PRO_16', 'C.I.4.0.0', '16924000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SM_PRO_16', 'C.O.1.0.0', '16946400005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SM_PRO_16', 'C.O.4.0.0', '16924000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SM_PRO_16', 'D.I.1.0.0', '16946600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SM_PRO_16', 'D.I.4.0.0', '16924500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SM_PRO_16', 'D.O.1.0.0', '16946600005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SM_PRO_16', 'D.O.4.0.0', '16924500005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SM_PRO_16', 'E.I.1.0.0', '16946700005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SM_PRO_16', 'E.I.4.0.0', '16925000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SM_PRO_16', 'E.O.1.0.0', '16946700005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'SM_PRO_16', 'E.O.4.0.0', '16925000005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TB', 'O', '11', 42, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TB', 'P', '06', 42, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TBC', 'O', '005', 42, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TBC', 'P', '005', 42, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TBN', 'E', '20', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TBN', 'I', '05', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TBN', 'M', '10', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TBN', 'N', '05', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TBN', 'O', '15', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-CO', '15', '15', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-CO', '25', '25', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-CO', '30', '30', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-CO', '40', '40', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-CO', '43', '43', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-CO', '45', '45', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-CO', '55', '55', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-CO', '60', '60', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-CO', '65', '65', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-CO', '72', '72', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-CO', '80', '80', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-CO', '82', '82', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-CONT', '1.0', '05', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-CONT', '4.0', '19', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-IM', '1', '005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-IM', '4', '010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-ING', '1', '02', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-ING', '2', '03', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-ING', '3', '08', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-ING', '4', '09', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-P-INT', '1', '94', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-P-INT', '4', '92', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-PG', 'CAP.1', '005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-PG', 'CAP.4', '010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-RP', 'CAP.1', '005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TC-RP', 'CAP.4', '010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TCRECTACLI', '1', '39', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TCRECTACLI', '4', '38', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TG-PV', 'CAP', '10', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TG-PV', 'CXCINTES', '15', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TI-RP', 'IMO', '010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TI-RP', 'INT', '005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '2000', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '2100', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '2200', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '2210', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '2220', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '2230', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '2300', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '3000', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '4000', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '4100', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '4200', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '4300', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '5000', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '5100', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '5200', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '6000', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '6100', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '6200', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '6300', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '6400', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '6500', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '7000', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '7100', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '7110', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '7120', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '7130', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TIP', '7200', '005', 19, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TO-IC', 'COBCENRIE', '005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-CA', '1', '95', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-CA', '4', '93', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-CC', '4.1', '005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-CC', '4.4', '010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-CP-C', 'CAP.1', '005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-CP-C', 'CAP.4', '010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-IC', '4.IMO', '010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-IC', '4.INT', '005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-INT-CAR', 'IMO.1', '010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-INT-CAR', 'IMO.2', '010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-INT-CAR', 'IMO.4', '010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-INT-CAR', 'INT.1', '005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-INT-CAR', 'INT.2', '005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-INT-CAR', 'INT.4', '005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-REC', 'COMFNGANU', '030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-REC', 'COMFNGDES', '020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-REC', 'EXEQUIAL', '010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-REC', 'HONORABOGA', '025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-REC', 'IVACOMIFNG', '030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-REC', 'MICROSEG', '015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-REC', 'SEGDEUANT', '005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP-REC', 'SEGDEUVEN', '005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TPG', 'CAP', '05', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TPPACTACL', 'COMFNGANU', '010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TPPACTACL', 'COMFNGDES', '010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TPPACTACL', 'COMISIOFNG', '010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TPPACTACL', 'EXEQUIAL', '110', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TPPACTACL', 'GASTOSJUDI', '205', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TPPACTACL', 'HONABO', '200', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TPPACTACL', 'IVACOMIFNG', '010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TPPACTACL', 'MICROSEG', '115', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TPPACTACL', 'SEGDEUANT', '105', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TPPACTACL', 'SEGDEUVEN', '105', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TPPACTACLI', 'EXEQUIAL', '110', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TPPACTACLI', 'FNG', '010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TPPACTACLI', 'HONABO', '200', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TPPACTACLI', 'MICROSEG', '115', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TPPACTACLI', 'SEGDEUVEN', '105', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP_FNG', 'COMISIOFNG', '005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TP_FNG', 'FNG', '010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TR-CC', '4.CAP', '005', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TR-CC', '4.COMFNGANU', '025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TR-CC', '4.COMISIOFNG', '025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TR-CC', '4.COMISMPYME', '020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TR-CC', '4.EXEQUIAL', '030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TR-CC', '4.FNG', '025', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TR-CC', '4.HONORABOGA', '035', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TR-CC', '4.IMO', '015', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TR-CC', '4.INT', '010', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TR-CC', '4.MICROSEG', '030', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'TR-CC', '4.MIPYMES', '020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'USA_PAG_25', '0', '41159500020', 7, 'CTB_OF', 'O')
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.A.I.1.0', '14871500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.A.I.2.0', '16991500052', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.A.I.5.0', '16991500062', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.A.O.1.0', '14871500007', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.A.O.2.0', '16991500052', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.A.O.5.0', '16991500062', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.B.I.1.0', '14871500010', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.B.I.2.0', '16991500053', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.B.I.5.0', '16991500063', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.B.O.1.0', '14871500012', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.B.O.2.0', '16991500053', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.B.O.5.0', '16991500063', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.C.I.1.0', '14871500015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.C.I.2.0', '16991500054', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.C.I.5.0', '16991500064', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.C.O.1.0', '14871500017', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.C.O.2.0', '16991500054', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.C.O.5.0', '16991500064', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.D.I.1.0', '14871500020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.D.I.2.0', '16991500056', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.D.I.5.0', '16991500066', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.D.O.1.0', '14871500022', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.D.O.2.0', '16991500056', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.D.O.5.0', '16991500066', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.E.I.1.0', '14871500025', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.E.I.2.0', '16991500057', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.E.I.5.0', '16991500067', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.E.O.1.0', '14871500027', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.E.O.2.0', '16991500057', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '1.E.O.5.0', '16991500067', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.A.I.1.0', '14870500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.A.I.1.1', '19993400025', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.A.I.2.0', '16990500052', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.A.I.2.1', '19993400030', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.A.I.5.0', '16990500062', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.A.I.5.1', '19993400035', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.A.O.1.0', '14870500007', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.A.O.1.1', '19993400025', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.A.O.2.0', '16990500052', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.A.O.2.1', '19993400030', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.A.O.5.0', '16990500062', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.A.O.5.1', '19993400035', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.B.I.1.0', '14870500010', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.B.I.1.1', '19993600025', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.B.I.2.0', '16990500053', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.B.I.2.1', '19993600030', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.B.I.5.0', '16990500063', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.B.I.5.1', '19993600035', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.B.O.1.0', '14870500012', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.B.O.1.1', '19993600025', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.B.O.2.0', '16990500053', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.B.O.2.1', '19993600030', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.B.O.5.0', '16990500063', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.B.O.5.1', '19993600035', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.C.I.1.0', '14870500015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.C.I.1.1', '19993800025', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.C.I.2.0', '16990500054', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.C.I.2.1', '19993800030', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.C.I.5.0', '16990500064', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.C.I.5.1', '19993800035', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.C.O.1.0', '14870500017', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.C.O.1.1', '19993800025', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.C.O.2.0', '16990500054', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.C.O.2.1', '19993800030', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.C.O.5.0', '16990500064', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.C.O.5.1', '19993800035', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.D.I.1.0', '14870500020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.D.I.1.1', '19994200025', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.D.I.2.0', '16990500056', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.D.I.2.1', '19994200030', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.D.I.5.0', '16990500066', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.D.I.5.1', '19994200035', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.D.O.1.0', '14870500022', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.D.O.1.1', '19994200025', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.D.O.2.0', '16990500056', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.D.O.2.1', '19994200030', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.D.O.5.0', '16990500066', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.D.O.5.1', '19994200035', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.E.I.1.0', '14870500025', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.E.I.1.1', '19994400025', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.E.I.2.0', '16990500057', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.E.I.2.1', '19994400030', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.E.I.5.0', '16990500067', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.E.I.5.1', '19994400035', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.E.O.1.0', '14870500027', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.E.O.1.1', '19994400025', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.E.O.2.0', '16990500057', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.E.O.2.1', '19994400030', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.E.O.5.0', '16990500067', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_cr', '2.E.O.5.1', '19994400035', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_db', '1.1.0', '51711500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_db', '1.2.0', '51713000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_db', '1.5.0', '51713000010', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_db', '2.1.0', '51710500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_db', '2.1.1', '51704000130', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_db', '2.2.0', '51713000050', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_db', '2.2.1', '51704000135', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_db', '2.5.0', '51713000055', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_db', '2.5.1', '51704000140', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_pa', '1.1.0', '41604500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_pa', '1.2.0', '41606000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_pa', '1.5.0', '41606000010', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_pa', '2.1.0', '41603500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_pa', '2.1.1', '42251300130', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_pa', '2.2.0', '41606000025', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_pa', '2.2.1', '42251300135', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_pa', '2.5.0', '41606000030', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_cic_pa', '2.5.1', '42251300140', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_gen_cr', '4.1', '14980500010', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_gen_db', '4.1', '51701000110', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_gen_pa', '4.1', '41600900015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.A.I.1.0', '14950500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.A.I.2.0', '16945200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.A.I.5.0', '16946200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.A.O.1.0', '14950700005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.A.O.2.0', '16945200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.A.O.5.0', '16946200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.B.I.1.0', '14951000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.B.I.2.0', '16945300005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.B.I.5.0', '16946300005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.B.O.1.0', '14951200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.B.O.2.0', '16945300005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.B.O.5.0', '16946300005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.C.I.1.0', '14951500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.C.I.2.0', '16945400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.C.I.5.0', '16946400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.C.O.1.0', '14951700005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.C.O.2.0', '16945400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.C.O.5.0', '16946400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.D.I.1.0', '14952000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.D.I.2.0', '16945600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.D.I.5.0', '16946600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.D.O.1.0', '14952200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.D.O.2.0', '16945600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.D.O.5.0', '16946600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.E.I.1.0', '14952500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.E.I.2.0', '16945700005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.E.I.5.0', '16946700005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.E.O.1.0', '14952700005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.E.O.2.0', '16945700005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '1.E.O.5.0', '16946700005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.A.I.1.0', '14910500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.A.I.1.1', '19993400006', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.A.I.2.0', '16965200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.A.I.2.1', '19993400015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.A.I.5.0', '16966200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.A.I.5.1', '19993400020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.A.O.1.0', '14910700005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.A.O.1.1', '19993400010', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.A.O.2.0', '16965200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.A.O.2.1', '19993400015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.A.O.5.0', '16966200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.A.O.5.1', '19993400020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.B.I.1.0', '14911000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.B.I.1.1', '19993600006', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.B.I.2.0', '16965300005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.B.I.2.1', '19993600015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.B.I.5.0', '16966300005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.B.I.5.1', '19993600020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.B.O.1.0', '14911200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.B.O.1.1', '19993600010', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.B.O.2.0', '16965300005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.B.O.2.1', '19993600015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.B.O.5.0', '16966300005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.B.O.5.1', '19993600020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.C.I.1.0', '14911500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.C.I.1.1', '19993800006', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.C.I.2.0', '16965400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.C.I.2.1', '19993800015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.C.I.5.0', '16966400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.C.I.5.1', '19993800020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.C.O.1.0', '14911700005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.C.O.1.1', '19993800010', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.C.O.2.0', '16965400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.C.O.2.1', '19993800015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.C.O.5.0', '16966400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.C.O.5.1', '19993800020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.D.I.1.0', '14912000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.D.I.1.1', '19994200006', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.D.I.2.0', '16965600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.D.I.2.1', '19994200015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.D.I.5.0', '16966600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.D.I.5.1', '19994200020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.D.O.1.0', '14912200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.D.O.1.1', '19994200010', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.D.O.2.0', '16965600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.D.O.2.1', '19994200015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.D.O.5.0', '16966600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.D.O.5.1', '19994200020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.E.I.1.0', '14912500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.E.I.1.1', '19994400006', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.E.I.2.0', '16965700005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.E.I.2.1', '19994400015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.E.I.5.0', '16966700010', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.E.I.5.1', '19994400020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.E.O.1.0', '14912700005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.E.O.1.1', '19994400010', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.E.O.2.0', '16965700005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.E.O.2.1', '19994400015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.E.O.5.0', '16966700010', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '2.E.O.5.1', '19994400020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.A.I.1.0', '14890500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.A.I.1.1', '19992300005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.A.I.2.0', '16975200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.A.I.2.1', '19992300015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.A.I.5.0', '16976200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.A.I.5.1', '19992300020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.A.O.1.1', '19992300010', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.A.O.2.1', '19992300015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.A.O.5.1', '19992300020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.B.I.1.0', '14891000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.B.I.1.1', '19992400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.B.I.2.0', '16975300005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.B.I.2.1', '19992400015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.B.I.5.0', '16976300005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.B.I.5.1', '19992400020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.B.O.1.1', '19992400010', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.B.O.2.1', '19992400015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.B.O.5.1', '19992400020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.C.I.1.0', '14891500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.C.I.1.1', '19992600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.C.I.2.0', '16975400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.C.I.2.1', '19992600015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.C.I.5.0', '16976400005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.C.I.5.1', '19992600020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.C.O.1.1', '19992600010', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.C.O.2.1', '19992600015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.C.O.5.1', '19992600020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.D.I.1.0', '14892000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.D.I.1.1', '19992800005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.D.I.2.0', '16975600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.D.I.2.1', '19992800015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.D.I.5.0', '16976500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.D.I.5.1', '19992800020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.D.O.1.1', '19992800010', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.D.O.2.1', '19992800015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.D.O.5.1', '19992800020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.E.I.1.0', '14892500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.E.I.1.1', '19993200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.E.I.2.0', '16975700005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.E.I.2.1', '19993200015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.E.I.5.0', '16976600005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.E.I.5.1', '19993200020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.E.O.1.1', '19993200010', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.E.O.2.1', '19993200015', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '3.E.O.5.1', '19993200020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.A.I.1.0', '14930500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.A.I.2.0', '16920500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.A.I.5.0', '16923000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.A.O.1.0', '14930700005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.A.O.2.0', '16920500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.A.O.5.0', '16923000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.B.I.1.0', '14931000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.B.I.2.0', '16921000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.B.I.5.0', '16923500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.B.O.1.0', '14931200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.B.O.2.0', '16921000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.B.O.5.0', '16923500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.C.I.1.0', '14931500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.C.I.2.0', '16921500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.C.I.5.0', '16924000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.C.O.1.0', '14931700005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.C.O.2.0', '16921500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.C.O.5.0', '16924000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.D.I.1.0', '14932000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.D.I.2.0', '16922000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.D.I.5.0', '16924500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.D.O.1.0', '14932200005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.D.O.2.0', '16922000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.D.O.5.0', '16924500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.E.I.1.0', '14932500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.E.I.2.0', '16922500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.E.I.5.0', '16925000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.E.O.1.0', '14932700005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.E.O.2.0', '16922500005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_cr', '4.E.O.5.0', '16925000005', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_db', '1.1.0', '51701000020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_db', '1.2.0', '51701500020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_db', '1.5.0', '51701500025', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_db', '2.1.0', '51701000045', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_db', '2.1.1', '51704000100', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_db', '2.2.0', '51701500080', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_db', '2.2.1', '51704000110', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_db', '2.5.0', '51701500085', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_db', '2.5.1', '51704000120', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_db', '3.1.0', '51701000040', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_db', '3.1.1', '51704000200', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_db', '3.2.0', '51701500070', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_db', '3.2.1', '51704000210', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_db', '3.5.0', '51701500075', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_db', '3.5.1', '51704000220', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_db', '4.1.0', '51701000030', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_db', '4.2.0', '51701500030', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_db', '4.5.0', '51701500040', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_pa', '1.1.0', '41600900020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_pa', '1.2.0', '41600800020', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_pa', '1.5.0', '41600800025', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_pa', '2.1.0', '41600900065', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_pa', '2.1.1', '42251300100', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_pa', '2.2.0', '41600800080', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_pa', '2.2.1', '42251300110', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_pa', '2.5.0', '41600800081', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_pa', '2.5.1', '42251300120', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_pa', '3.1.0', '41600900060', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_pa', '3.1.1', '42251300200', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_pa', '3.2.0', '41600800070', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_pa', '3.2.1', '42251300210', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_pa', '3.5.0', '41600800071', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_pa', '3.5.1', '42251300220', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_pa', '4.1.0', '41600900030', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_pa', '4.2.0', '41600800030', 21, 'CTB_OF', NULL)
GO

INSERT INTO dbo.cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'prv_ind_pa', '4.5.0', '41600800040', 21, 'CTB_OF', NULL)
GO
