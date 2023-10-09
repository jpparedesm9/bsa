

use cob_cartera 
go 


delete ca_corresponsal_tipo_ref where  ctr_id in ( 17,18,19,20,21,22,23,24,25)

--FORMA DE PAGO SANTANDER

INSERT INTO dbo.ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
VALUES (17, '70', 'PG', 'PAGO GENERICO GRUPAL SANTANDER', '1', 9744)
GO

INSERT INTO dbo.ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
VALUES (18, '71', 'PI', 'PAGO GENERICO LCR SANTANDER', '1', 9744)
GO

INSERT INTO dbo.ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
VALUES (19, '72', 'PI', 'PAGO GENERICO SIMPLE SANTANDER', '1', 9744)
GO

--FORMA DE PAGO ELAVON

INSERT INTO dbo.ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
VALUES (20, '70', 'PG', 'PAGO GENERICO GRUPAL ELAVON', '3', null)
GO

INSERT INTO dbo.ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
VALUES (21, '71', 'PI', 'PAGO GENERICO LCR ELAVON', '3', null)
GO

INSERT INTO dbo.ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
VALUES (22, '72', 'PI', 'PAGO GENERICO SIMPLE ELAVON', '3', null)
GO

--FORMA DE PAGO OXXO

INSERT INTO dbo.ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
VALUES (23, '70', 'PG', 'PAGO GENERICO GRUPAL OXXO', '10', null)
GO

INSERT INTO dbo.ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
VALUES (24, '71', 'PI', 'PAGO GENERICO LCR OXXO', '10', null)
GO

INSERT INTO dbo.ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
VALUES (25, '72', 'PI', 'PAGO GENERICO SIMPLE OXXO', '10', null)
GO







use cob_cartera
go 


IF OBJECT_ID ('dbo.ca_referencia_generica') IS NOT NULL
	DROP TABLE dbo.ca_referencia_generica
GO


CREATE TABLE dbo.ca_referencia_generica
	(
  
	rg_corresponsal          VARCHAR (16) NULL,
	rg_tipo                  CHAR (2) NULL,
	rg_codigo_interno        INT NULL,
	rg_fecha_proceso         DATETIME NULL,
	rg_fecha_valor           DATETIME NULL,
	rg_referencia            VARCHAR (64) NULL,
	rg_moneda                TINYINT NULL,
	rg_monto                 MONEY NULL,
	rg_status_srv            VARCHAR (64) NULL,
	rg_estado                CHAR (1) NULL,
	rg_error_id              INT NULL,
	rg_error_msg             VARCHAR (254) NULL,
	rg_archivo_ref           VARCHAR (64) NULL,
	rg_archivo_fecha_corte   DATETIME NULL,
	rg_archivo_carga_usuario VARCHAR (30) NULL,
	rg_concil_est            CHAR (1) NULL,
	rg_concil_motivo         CHAR (2) NULL,
	rg_concil_user           VARCHAR (64) NULL,
	rg_concil_fecha          DATETIME NULL,
	rg_concil_obs            VARCHAR (255) NULL,
	rg_trn_id_corresp        VARCHAR (25) NULL,
	rg_accion                CHAR (1) NULL,
	rg_login                 login NULL,
	rg_terminal              VARCHAR (30) NULL,
	rg_fecha_real            DATETIME NULL,
	rg_linea                 INT NULL
	)
GO

CREATE NONCLUSTERED INDEX ca_referencia_generica1
	ON dbo.ca_referencia_generica (rg_referencia)
GO




