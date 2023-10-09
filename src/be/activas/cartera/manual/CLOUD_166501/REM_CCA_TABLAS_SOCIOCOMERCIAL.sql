use cob_cartera
go 


IF OBJECT_ID ('dbo.ca_lcr_referencia_sc') IS NOT NULL
	DROP TABLE dbo.ca_lcr_referencia_sc
GO

CREATE TABLE dbo.ca_lcr_referencia_sc
	(
	co_secuencial            INT IDENTITY NOT NULL,
	co_corresponsal          VARCHAR (16) NULL,
	co_tipo                  CHAR (2) NULL,
	co_codigo_interno        INT NULL,
	co_fecha_proceso         DATETIME NULL,
	co_fecha_valor           DATETIME NULL,
	co_referencia            VARCHAR (64) NULL,
	co_moneda                TINYINT NULL,
	co_monto                 MONEY NULL,
	co_status_srv            VARCHAR (64) NULL,
	co_estado                CHAR (1) NULL,
	co_error_id              INT NULL,
	co_error_msg             VARCHAR (254) NULL,
	co_archivo_ref           VARCHAR (64) NULL,
	co_archivo_fecha_corte   DATETIME NULL,
	co_archivo_carga_usuario VARCHAR (30) NULL,
	co_concil_est            CHAR (1) NULL,
	co_concil_motivo         CHAR (2) NULL,
	co_concil_user           VARCHAR (64) NULL,
	co_concil_fecha          DATETIME NULL,
	co_concil_obs            VARCHAR (255) NULL,
	co_trn_id_corresp        VARCHAR (25) NULL,
	co_accion                CHAR (1) NULL,
	co_login                 login NULL,
	co_terminal              VARCHAR (30) NULL,
	co_fecha_real            DATETIME NULL,
	co_linea                 INT NULL,
	co_monto_cap             money  null,
	co_monto_com             money null,
	co_monto_iva             money null
	)
GO

CREATE NONCLUSTERED INDEX ca_corresponsal_trn_1
	ON dbo.ca_lcr_referencia_sc (co_referencia)
GO



CREATE NONCLUSTERED INDEX idx1_ca_corresponsal_trn_co_tipo
	ON dbo.ca_lcr_referencia_sc (co_tipo,co_codigo_interno,co_estado)
GO



delete ca_corresponsal where co_id = '11'
delete ca_corresponsal_tipo_ref where ctr_id = 16 



INSERT INTO dbo.ca_corresponsal (co_id, co_nombre, co_descripcion, co_token_validacion, co_sp_generacion_ref, co_sp_validacion_ref, co_estado, co_tiempo_aplicacion_pag_rev)
VALUES ('11', 'SOCIO', 'SOCIO COMERCIAL', NULL, 'cob_cartera..sp_lcr_gen_ref', 'cob_cartera..sp_lcr_gen_ref', 'I', 0)
GO


INSERT INTO dbo.ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
VALUES (16, '30', 'PI', 'REFERENCIA SOCIO COMERCIAL', '11', '9999')
GO



