-------------------------------------------------------------
-- cob_conta_tercero
-------------------------------------------------------------

use cob_conta_tercero
go


IF OBJECT_ID ('ct_conciliacion') IS NOT NULL
	DROP TABLE ct_conciliacion
GO


CREATE TABLE dbo.ct_conciliacion
	(
	cl_producto          TINYINT NOT NULL,
	cl_comprobante       INT NOT NULL,
	cl_empresa           TINYINT NOT NULL,
	cl_fecha_tran        DATETIME NOT NULL,
	cl_asiento           INT NOT NULL,
	cl_cuenta            VARCHAR (30) NULL,
	cl_oficina_dest      INT NOT NULL,
	cl_area_dest         INT NOT NULL,
	cl_debcred           CHAR (1) NOT NULL,
	cl_valor             MONEY NOT NULL,
	cl_oper_banco        CHAR (4) NOT NULL,
	cl_doc_banco         CHAR (20) NULL,
	cl_banco             CHAR (3) NULL,
	cl_fecha_est         DATETIME NULL,
	cl_cuenta_cte        VARCHAR (20) NULL,
	cl_detalle           INT NULL,
	cl_relacionado       CHAR (1) NOT NULL,
	cl_modulo            SMALLINT NULL,
	cl_cheque            VARCHAR (64) NULL,
	cl_refinterna        INT NULL,
	cl_fecha_conc        DATETIME NULL,
	cl_tipo_conciliacion CHAR (1) NULL
	)
GO

CREATE NONCLUSTERED INDEX i_ct_conciliacion1
	ON dbo.ct_conciliacion (cl_fecha_tran,cl_comprobante,cl_asiento)
GO

CREATE NONCLUSTERED INDEX i_ct_conciliacion2
	ON dbo.ct_conciliacion (cl_oper_banco,cl_comprobante,cl_asiento)
GO

IF OBJECT_ID ('ct_sasiento') IS NOT NULL
	DROP TABLE ct_sasiento
GO


CREATE TABLE dbo.ct_sasiento
	(
	sa_producto               TINYINT NOT NULL,
	sa_comprobante            INT NOT NULL,
	sa_empresa                TINYINT NOT NULL,
	sa_fecha_tran             DATETIME NOT NULL,
	sa_asiento                INT NOT NULL,
	sa_cuenta                 CHAR (14) NOT NULL,
	sa_oficina_dest           SMALLINT NOT NULL,
	sa_area_dest              SMALLINT NOT NULL,
	sa_credito                MONEY NULL,
	sa_debito                 MONEY NULL,
	sa_concepto               VARCHAR (160) NOT NULL,
	sa_credito_me             MONEY NULL,
	sa_debito_me              MONEY NULL,
	sa_cotizacion             MONEY NULL,
	sa_tipo_doc               CHAR (1) NOT NULL,
	sa_tipo_tran              CHAR (1) NOT NULL,
	sa_moneda                 TINYINT NULL,
	sa_opcion                 TINYINT NULL,
	sa_ente                   INT NULL,
	sa_con_rete               CHAR (4) NULL,
	sa_base                   MONEY NULL,
	sa_valret                 MONEY NULL,
	sa_con_iva                CHAR (4) NULL,
	sa_valor_iva              MONEY NULL,
	sa_iva_retenido           MONEY NULL,
	sa_con_ica                CHAR (4) NULL,
	sa_valor_ica              MONEY NULL,
	sa_con_timbre             CHAR (4) NULL,
	sa_valor_timbre           MONEY NULL,
	sa_con_iva_reten          CHAR (4) NULL,
	sa_con_ivapagado          CHAR (4) NULL,
	sa_valor_ivapagado        MONEY NULL,
	sa_documento              CHAR (24) NULL,
	sa_mayorizado             CHAR (1) NOT NULL,
	sa_origen_mvto            VARCHAR (20) NULL,
	sa_con_dptales            CHAR (4) NULL,
	sa_valor_dptales          MONEY NULL,
	sa_posicion               CHAR (1) NULL,
	sa_debcred                CHAR (1) NULL,
	sa_oper_banco             CHAR (4) NULL,
	sa_cheque                 VARCHAR (64) NULL,
	sa_doc_banco              CHAR (20) NULL,
	sa_fecha_est              DATETIME NULL,
	sa_detalle                SMALLINT NULL,
	sa_error                  CHAR (1) NULL,
	sa_fecha_fin_difer        DATETIME NULL,
	sa_plazo_difer            INT NULL,
	sa_desc_difer             VARCHAR (160) NULL,
	sa_fecha_fin_difer_fiscal DATETIME NULL,
	sa_plazo_difer_fiscal     INT NULL
	)
GO

CREATE UNIQUE NONCLUSTERED INDEX ct_sasiento_AKey0
	ON dbo.ct_sasiento (sa_comprobante,sa_fecha_tran,sa_producto,sa_asiento)
GO

CREATE NONCLUSTERED INDEX ct_sasiento_AKey1
	ON dbo.ct_sasiento (sa_ente,sa_cuenta,sa_fecha_tran,sa_oficina_dest)
GO


CREATE NONCLUSTERED INDEX ct_sasiento_AKey2
	ON dbo.ct_sasiento (sa_cuenta,sa_fecha_tran,sa_oficina_dest)
GO

IF OBJECT_ID ('ct_sasiento_tmp') IS NOT NULL
	DROP TABLE ct_sasiento_tmp
GO

CREATE TABLE dbo.ct_sasiento_tmp
	(
	sa_producto               TINYINT NOT NULL,
	sa_comprobante            INT NOT NULL,
	sa_empresa                TINYINT NOT NULL,
	sa_fecha_tran             DATETIME NOT NULL,
	sa_asiento                INT NOT NULL,
	sa_cuenta                 VARCHAR (30) NULL,
	sa_oficina_dest           SMALLINT NOT NULL,
	sa_area_dest              SMALLINT NOT NULL,
	sa_credito                MONEY NULL,
	sa_debito                 MONEY NULL,
	sa_concepto               VARCHAR (160) NOT NULL,
	sa_credito_me             MONEY NULL,
	sa_debito_me              MONEY NULL,
	sa_cotizacion             MONEY NULL,
	sa_tipo_doc               CHAR (1) NOT NULL,
	sa_tipo_tran              CHAR (1) NOT NULL,
	sa_moneda                 TINYINT NULL,
	sa_opcion                 TINYINT NULL,
	sa_ente                   INT NULL,
	sa_con_rete               CHAR (4) NULL,
	sa_base                   MONEY NULL,
	sa_valret                 MONEY NULL,
	sa_con_iva                CHAR (4) NULL,
	sa_valor_iva              MONEY NULL,
	sa_iva_retenido           MONEY NULL,
	sa_con_ica                CHAR (4) NULL,
	sa_valor_ica              MONEY NULL,
	sa_con_timbre             CHAR (4) NULL,
	sa_valor_timbre           MONEY NULL,
	sa_con_iva_reten          CHAR (4) NULL,
	sa_con_ivapagado          CHAR (4) NULL,
	sa_valor_ivapagado        MONEY NULL,
	sa_documento              CHAR (24) NULL,
	sa_mayorizado             CHAR (1) NOT NULL,
	sa_origen_mvto            VARCHAR (20) NULL,
	sa_con_dptales            CHAR (4) NULL,
	sa_valor_dptales          MONEY NULL,
	sa_posicion               CHAR (1) NULL,
	sa_debcred                CHAR (1) NULL,
	sa_oper_banco             CHAR (4) NULL,
	sa_cheque                 VARCHAR (64) NULL,
	sa_doc_banco              CHAR (20) NULL,
	sa_fecha_est              DATETIME NULL,
	sa_detalle                SMALLINT NULL,
	sa_error                  CHAR (1) NULL,
	sa_fecha_fin_difer        DATETIME NULL,
	sa_plazo_difer            INT NULL,
	sa_desc_difer             VARCHAR (160) NULL,
	sa_fecha_fin_difer_fiscal DATETIME NULL,
	sa_plazo_difer_fiscal     INT NULL
	)
GO

CREATE NONCLUSTERED INDEX ct_sasiento_tmp_Key
	ON dbo.ct_sasiento_tmp (sa_fecha_tran,sa_producto,sa_comprobante,sa_asiento,sa_empresa)
GO

IF OBJECT_ID ('ct_scomprobante') IS NOT NULL
	DROP TABLE ct_scomprobante
GO


CREATE TABLE dbo.ct_scomprobante
	(
	sc_producto       TINYINT NOT NULL,
	sc_comprobante    INT NOT NULL,
	sc_empresa        TINYINT NOT NULL,
	sc_fecha_tran     DATETIME NOT NULL,
	sc_oficina_orig   SMALLINT NOT NULL,
	sc_area_orig      SMALLINT NOT NULL,
	sc_fecha_gra      DATETIME NOT NULL,
	sc_digitador      VARCHAR (160) NOT NULL,
	sc_descripcion    VARCHAR (160) NOT NULL,
	sc_perfil         VARCHAR (20) NOT NULL,
	sc_detalles       INT NOT NULL,
	sc_tot_debito     MONEY NOT NULL,
	sc_tot_credito    MONEY NOT NULL,
	sc_tot_debito_me  MONEY NOT NULL,
	sc_tot_credito_me MONEY NOT NULL,
	sc_automatico     INT NULL,
	sc_reversado      CHAR (1) NOT NULL,
	sc_estado         CHAR (1) NOT NULL,
	sc_mayorizado     CHAR (1) NOT NULL,
	sc_observaciones  VARCHAR (160) NULL,
	sc_comp_definit   INT NULL,
	sc_usuario_modulo VARCHAR (160) NOT NULL,
	sc_causa_error    CHAR (30) NULL,
	sc_comp_origen    INT NULL,
	sc_tran_modulo    VARCHAR (20) NULL,
	sc_error          CHAR (1) NULL
	)
GO

CREATE NONCLUSTERED INDEX ct_scomprobante_AKey1
	ON dbo.ct_scomprobante (sc_estado,sc_fecha_tran)
GO

CREATE NONCLUSTERED INDEX ct_scomprobante_idx5
	ON dbo.ct_scomprobante (sc_estado,sc_fecha_tran)
GO

IF OBJECT_ID ('ct_scomprobante_tmp') IS NOT NULL
	DROP TABLE ct_scomprobante_tmp
GO


CREATE TABLE dbo.ct_scomprobante_tmp
	(
	sc_producto       TINYINT NOT NULL,
	sc_comprobante    INT NOT NULL,
	sc_empresa        TINYINT NOT NULL,
	sc_fecha_tran     DATETIME NOT NULL,
	sc_oficina_orig   SMALLINT NOT NULL,
	sc_area_orig      SMALLINT NOT NULL,
	sc_fecha_gra      DATETIME NOT NULL,
	sc_digitador      VARCHAR (160) NOT NULL,
	sc_descripcion    VARCHAR (160) NOT NULL,
	sc_perfil         VARCHAR (20) NOT NULL,
	sc_detalles       INT NOT NULL,
	sc_tot_debito     MONEY NOT NULL,
	sc_tot_credito    MONEY NOT NULL,
	sc_tot_debito_me  MONEY NOT NULL,
	sc_tot_credito_me MONEY NOT NULL,
	sc_automatico     INT NULL,
	sc_reversado      CHAR (1) NOT NULL,
	sc_estado         CHAR (1) NOT NULL,
	sc_mayorizado     CHAR (1) NOT NULL,
	sc_observaciones  VARCHAR (160) NULL,
	sc_comp_definit   INT NULL,
	sc_usuario_modulo VARCHAR (160) NOT NULL,
	sc_causa_error    CHAR (30) NULL,
	sc_comp_origen    INT NULL,
	sc_tran_modulo    VARCHAR (20) NULL,
	sc_error          CHAR (1) NULL
	)
GO

CREATE UNIQUE NONCLUSTERED INDEX ct_scomprobante_tmp_Key
	ON dbo.ct_scomprobante_tmp (sc_fecha_tran,sc_producto,sc_comprobante,sc_empresa)
GO

CREATE NONCLUSTERED INDEX idx2
	ON dbo.ct_scomprobante_tmp (sc_oficina_orig,sc_fecha_tran,sc_producto)
GO


CREATE UNIQUE NONCLUSTERED INDEX ct_scomprobante_Key
	ON dbo.ct_scomprobante (sc_fecha_tran,sc_producto,sc_comprobante,sc_empresa)
GO

CREATE NONCLUSTERED INDEX idx1
	ON dbo.ct_scomprobante (sc_fecha_tran,sc_mayorizado)
GO

CREATE NONCLUSTERED INDEX i_ct_scomp_1
	ON dbo.ct_scomprobante (sc_fecha_tran,sc_producto,sc_oficina_orig,sc_area_orig,sc_perfil)
GO
