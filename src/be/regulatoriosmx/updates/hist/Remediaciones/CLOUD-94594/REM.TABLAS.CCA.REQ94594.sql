
use cob_cartera_his 
go 


IF OBJECT_ID ('dbo.ca_comision_diferida_his') IS NOT NULL
	DROP TABLE dbo.ca_comision_diferida_his
GO

CREATE TABLE dbo.ca_comision_diferida_his
	(
	cdh_secuencial INT NOT NULL,
	cdh_operacion  INT NOT NULL,
	cdh_concepto   catalogo NOT NULL,
	cdh_cuota      MONEY NOT NULL,
	cdh_acumulado  MONEY NULL,
	cdh_estado     TINYINT NULL,
	cdh_cod_valor  INT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX ca_comision_diferida_his1
	ON dbo.ca_comision_diferida_his (cdh_operacion,cdh_secuencial,cdh_concepto)
GO


IF OBJECT_ID ('dbo.ca_seguros_his') IS NOT NULL
	DROP TABLE dbo.ca_seguros_his
GO

CREATE TABLE dbo.ca_seguros_his
	(
	seh_secuencial     INT NULL,
	seh_sec_seguro     INT NULL,
	seh_tipo_seguro    INT NULL,
	seh_sec_renovacion INT NULL,
	seh_tramite        INT NULL,
	seh_operacion      INT NULL,
	seh_fec_devolucion DATETIME NULL,
	seh_mto_devolucion MONEY NULL,
	seh_estado         CHAR (1) NULL
	)
GO

CREATE NONCLUSTERED INDEX idx_1
	ON dbo.ca_seguros_his (seh_operacion,seh_secuencial)
GO


IF OBJECT_ID ('dbo.ca_seguros_det_his') IS NOT NULL
	DROP TABLE dbo.ca_seguros_det_his
GO

CREATE TABLE dbo.ca_seguros_det_his
	(
	sedh_secuencial     INT NULL,
	sedh_operacion      INT NULL,
	sedh_sec_seguro     INT NULL,
	sedh_tipo_seguro    INT NULL,
	sedh_sec_renovacion INT NULL,
	sedh_tipo_asegurado INT NULL,
	sedh_estado         INT NULL,
	sedh_dividendo      INT NULL,
	sedh_cuota_cap      MONEY NULL,
	sedh_pago_cap       MONEY NULL,
	sedh_cuota_int      MONEY NULL,
	sedh_pago_int       MONEY NULL,
	sedh_cuota_mora     MONEY NULL,
	sedh_pago_mora      MONEY NULL,
	sedh_sec_asegurado  INT NULL
	)
GO

CREATE NONCLUSTERED INDEX idx_1
	ON dbo.ca_seguros_det_his (sedh_operacion,sedh_secuencial)
GO


IF OBJECT_ID ('dbo.ca_seguros_can_his') IS NOT NULL
	DROP TABLE dbo.ca_seguros_can_his
GO

CREATE TABLE dbo.ca_seguros_can_his
	(
	sech_secuencial     INT NULL,
	sech_sec_seguro     INT NULL,
	sech_tipo_seguro    INT NULL,
	sech_sec_renovacion INT NULL,
	sech_tramite        INT NULL,
	sech_operacion      INT NULL,
	sech_fec_can        DATETIME NULL,
	sech_sec_pag        INT NULL
	)
GO

CREATE NONCLUSTERED INDEX idx_1
	ON dbo.ca_seguros_can_his (sech_operacion,sech_secuencial)
GO




IF OBJECT_ID ('dbo.ca_operacion_ext_his') IS NOT NULL
	DROP TABLE dbo.ca_operacion_ext_his
GO

CREATE TABLE dbo.ca_operacion_ext_his
	(
	oeh_secuencial   INT NOT NULL,
	oeh_operacion    INT NOT NULL,
	oeh_columna      VARCHAR (30) NOT NULL,
	oeh_char         VARCHAR (30) NULL,
	oeh_tinyint      TINYINT NULL,
	oeh_smallint     SMALLINT NULL,
	oeh_int          INT NULL,
	oeh_money        MONEY NULL,
	oeh_datetime     DATETIME NULL,
	oeh_estado       VARCHAR (12) NULL,
	oeh_tinyInteger  TINYINT NULL,
	oeh_smallInteger INT NULL,
	oeh_integer      INT NULL,
	oeh_float        FLOAT NULL
	)
GO



IF OBJECT_ID ('dbo.ca_diferidos_his') IS NOT NULL
	DROP TABLE dbo.ca_diferidos_his
GO

CREATE TABLE dbo.ca_diferidos_his
	(
	difh_secuencial     INT NOT NULL,
	difh_operacion      INT NOT NULL,
	difh_valor_diferido MONEY NOT NULL,
	difh_valor_pagado   MONEY NOT NULL,
	difh_concepto       catalogo NOT NULL
	)
GO

CREATE NONCLUSTERED INDEX idxh1
	ON dbo.ca_diferidos_his (difh_operacion,difh_secuencial)
GO


