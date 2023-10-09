Use cob_conta
go

IF OBJECT_ID ('dbo.cb_paramdep') IS NOT NULL
	DROP TABLE dbo.cb_paramdep
GO

CREATE TABLE dbo.cb_paramdep
	(
	pd_empresa   TINYINT NOT NULL,
	pd_tabla     VARCHAR (50) COLLATE Latin1_General_BIN NOT NULL,
	pd_tipo      CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
	pd_campo     VARCHAR (50) COLLATE Latin1_General_BIN NOT NULL,
	pd_campo1    VARCHAR (50) COLLATE Latin1_General_BIN NULL,
	pd_basedatos VARCHAR (50) COLLATE Latin1_General_BIN NULL,
	pd_estado    CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
	pd_tipo_dep  CHAR (1) COLLATE Latin1_General_BIN NOT NULL
	)
GO




IF OBJECT_ID ('dbo.cb_ofpagadora') IS NOT NULL
	DROP TABLE dbo.cb_ofpagadora
GO

CREATE TABLE dbo.cb_ofpagadora
	(
	of_oficina_consolida SMALLINT NOT NULL,
	of_cod_declaracion   CHAR (2) COLLATE Latin1_General_BIN NOT NULL,
	of_declaracion       VARCHAR (60) COLLATE Latin1_General_BIN NOT NULL,
	of_icareteica        CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
	of_valadxofi         MONEY NULL,
	of_fpagobomberil     CHAR (2) COLLATE Latin1_General_BIN NULL,
	of_vlabomberil       INT NULL,
	of_porbomberil       FLOAT NULL,
	of_cuenta            VARCHAR (20) COLLATE Latin1_General_BIN NULL
	)
GO

CREATE UNIQUE NONCLUSTERED INDEX cb_ofpagadora_key
	ON dbo.cb_ofpagadora (of_oficina_consolida,of_cod_declaracion)
GO




INSERT INTO dbo.cb_paramdep (pd_empresa, pd_tabla, pd_tipo, pd_campo, pd_campo1, pd_basedatos, pd_estado, pd_tipo_dep)
VALUES (1, 'cob_ahorros..ah_apertura_cta', 'D', 'ac_fecha', NULL, 'cob_ahorros', 'V', 'T')
GO




INSERT INTO dbo.cb_ofpagadora (of_oficina_consolida, of_cod_declaracion, of_declaracion, of_icareteica, of_valadxofi, of_fpagobomberil, of_vlabomberil, of_porbomberil, of_cuenta)
VALUES (7003, '02', 'DECLARACION DE INDUSTRIA Y COMERCIO', 'N', 5000, '00', 1500, 0, NULL)
GO

INSERT INTO dbo.cb_ofpagadora (of_oficina_consolida, of_cod_declaracion, of_declaracion, of_icareteica, of_valadxofi, of_fpagobomberil, of_vlabomberil, of_porbomberil, of_cuenta)
VALUES (4003, '02', 'DECLARACION DE INDUSTRIA Y COMERCIO', 'N', 0, '00', 0, 0, NULL)
GO

INSERT INTO dbo.cb_ofpagadora (of_oficina_consolida, of_cod_declaracion, of_declaracion, of_icareteica, of_valadxofi, of_fpagobomberil, of_vlabomberil, of_porbomberil, of_cuenta)
VALUES (4003, '03', 'DECLARACION DEPARTAMENTAL DE ESTAMPILLAS', 'N', 0, '00', 0, 0, NULL)
GO

INSERT INTO dbo.cb_ofpagadora (of_oficina_consolida, of_cod_declaracion, of_declaracion, of_icareteica, of_valadxofi, of_fpagobomberil, of_vlabomberil, of_porbomberil, of_cuenta)
VALUES (7003, '03', 'DECLARACION DEPARTAMENTAL DE ESTAMPILLAS', 'N', 0, '00', 0, 0, NULL)
GO

INSERT INTO dbo.cb_ofpagadora (of_oficina_consolida, of_cod_declaracion, of_declaracion, of_icareteica, of_valadxofi, of_fpagobomberil, of_vlabomberil, of_porbomberil, of_cuenta)
VALUES (7006, '02', 'DECLARACION DE INDUSTRIA Y COMERCIO', 'N', 0, '00', 1, 0, NULL)
GO
