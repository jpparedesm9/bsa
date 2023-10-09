USE cobis
GO

CREATE TABLE dbo.ws_tran_servicio
	(
	ts_ssn            INT NOT NULL,
	ts_usuario        login NOT NULL,
	ts_terminal       VARCHAR (16) COLLATE Latin1_General_BIN NOT NULL,
	ts_oficina        SMALLINT NULL,
	ts_fecha          DATETIME NOT NULL,
	ts_hora           DATETIME NOT NULL,
	ts_tipo_tran      SMALLINT NOT NULL,
	ts_estado         CHAR (1) COLLATE Latin1_General_BIN NULL,
	ts_correccion     CHAR (1) COLLATE Latin1_General_BIN NULL,
	ts_sec_corr       VARCHAR (36) COLLATE Latin1_General_BIN NULL,
	ts_sec_ext        VARCHAR (36) COLLATE Latin1_General_BIN NULL,
	ts_hora_est       DATETIME NULL,
	ts_codcorr        INT NULL,
	ts_monto          MONEY NULL,
	ts_num_tarjeta    VARCHAR (24) COLLATE Latin1_General_BIN NULL,
	ts_prod_orig      TINYINT NULL,
	ts_banco_orig     VARCHAR (24) COLLATE Latin1_General_BIN NULL,
	ts_prod_dest      TINYINT NULL,
	ts_banco_dest     VARCHAR (24) COLLATE Latin1_General_BIN NULL,
	ts_convenio       VARCHAR (24) COLLATE Latin1_General_BIN NULL,
	ts_banco          VARCHAR (24) COLLATE Latin1_General_BIN NULL,
	ts_gcomision      CHAR (1) COLLATE Latin1_General_BIN NULL,
	ts_comision       MONEY NULL,
	ts_campo1         VARCHAR (60) COLLATE Latin1_General_BIN NULL,
	ts_campo2         VARCHAR (60) COLLATE Latin1_General_BIN NULL,
	ts_campo3         VARCHAR (60) COLLATE Latin1_General_BIN NULL,
	ts_campo4         VARCHAR (60) COLLATE Latin1_General_BIN NULL,
	ts_campo5         VARCHAR (60) COLLATE Latin1_General_BIN NULL,
	ts_campo6         VARCHAR (60) COLLATE Latin1_General_BIN NULL,
	ts_campo7         VARCHAR (60) COLLATE Latin1_General_BIN NULL,
	ts_campo8         VARCHAR (60) COLLATE Latin1_General_BIN NULL,
	ts_campo9         VARCHAR (60) COLLATE Latin1_General_BIN NULL,
	ts_campo10        VARCHAR (254) COLLATE Latin1_General_BIN NULL,
	ts_valor1         MONEY NULL,
	ts_valor2         MONEY NULL,
	ts_valor3         MONEY NULL,
	ts_valor4         MONEY NULL,
	ts_valor5         MONEY NULL,
	ts_valor6         MONEY NULL,
	ts_valor7         MONEY NULL,
	ts_valor8         MONEY NULL,
	ts_valor9         MONEY NULL,
	ts_valor10        MONEY NULL,
	ts_retorno        INT NOT NULL,
	ts_conciliado     CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
	ts_fecha_conc     DATETIME NULL,
	ts_adquiriente    BIGINT NULL,
	ts_cod_alterno    INT NULL,
	ts_autorizacion   VARCHAR (6) COLLATE Latin1_General_BIN NULL,
	ts_canal          INT NULL,
	ts_login_ext      login NULL,
	ts_ref_monetaria1 MONEY NULL,
	ts_ref_monetaria2 MONEY NULL,
	ts_ref_monetaria3 MONEY NULL,
	ts_ref_monetaria4 MONEY NULL,
	ts_ref_monetaria5 MONEY NULL,
	ts_ref_numerica1  INT NULL,
	ts_ref_numerica2  INT NULL,
	ts_ref_numerica3  INT NULL,
	ts_ref_numerica4  INT NULL,
	ts_ref_numerica5  INT NULL,
	ts_ref_texto1     descripcion NULL,
	ts_ref_texto2     descripcion NULL,
	ts_ref_texto3     descripcion NULL,
	ts_ref_texto4     descripcion NULL,
	ts_ref_texto5     descripcion NULL
	)
GO

CREATE NONCLUSTERED INDEX idx_fechaTrn
	ON dbo.ws_tran_servicio (ts_fecha,ts_tipo_tran)
GO

CREATE NONCLUSTERED INDEX idx_secext
	ON dbo.ws_tran_servicio (ts_sec_ext)
GO

CREATE UNIQUE NONCLUSTERED INDEX idx_ssn
	ON dbo.ws_tran_servicio (ts_ssn,ts_cod_alterno)
GO

CREATE NONCLUSTERED INDEX ws_tran_servicio_idx4
	ON dbo.ws_tran_servicio (ts_sec_ext,ts_adquiriente,ts_fecha)
GO



IF OBJECT_ID ('dbo.ws_tran_servicio_his') IS NOT NULL
	DROP TABLE dbo.ws_tran_servicio_his
GO

CREATE TABLE dbo.ws_tran_servicio_his
	(
	tsh_ssn            INT NOT NULL,
	tsh_usuario        login NOT NULL,
	tsh_terminal       VARCHAR (16) COLLATE Latin1_General_BIN NOT NULL,
	tsh_oficina        SMALLINT NULL,
	tsh_fecha          DATETIME NOT NULL,
	tsh_hora           DATETIME NOT NULL,
	tsh_tipo_tran      SMALLINT NOT NULL,
	tsh_estado         CHAR (1) COLLATE Latin1_General_BIN NULL,
	tsh_correccion     CHAR (1) COLLATE Latin1_General_BIN NULL,
	tsh_sec_corr       VARCHAR (36) COLLATE Latin1_General_BIN NULL,
	tsh_sec_ext        VARCHAR (36) COLLATE Latin1_General_BIN NULL,
	tsh_hora_est       DATETIME NULL,
	tsh_codcorr        INT NULL,
	tsh_monto          MONEY NULL,
	tsh_num_tarjeta    VARCHAR (24) COLLATE Latin1_General_BIN NULL,
	tsh_prod_orig      TINYINT NULL,
	tsh_banco_orig     VARCHAR (24) COLLATE Latin1_General_BIN NULL,
	tsh_prod_dest      TINYINT NULL,
	tsh_banco_dest     VARCHAR (24) COLLATE Latin1_General_BIN NULL,
	tsh_convenio       VARCHAR (24) COLLATE Latin1_General_BIN NULL,
	tsh_banco          VARCHAR (24) COLLATE Latin1_General_BIN NULL,
	tsh_gcomision      CHAR (1) COLLATE Latin1_General_BIN NULL,
	tsh_comision       MONEY NULL,
	tsh_campo1         VARCHAR (60) COLLATE Latin1_General_BIN NULL,
	tsh_campo2         VARCHAR (60) COLLATE Latin1_General_BIN NULL,
	tsh_campo3         VARCHAR (60) COLLATE Latin1_General_BIN NULL,
	tsh_campo4         VARCHAR (60) COLLATE Latin1_General_BIN NULL,
	tsh_campo5         VARCHAR (60) COLLATE Latin1_General_BIN NULL,
	tsh_campo6         VARCHAR (60) COLLATE Latin1_General_BIN NULL,
	tsh_campo7         VARCHAR (60) COLLATE Latin1_General_BIN NULL,
	tsh_campo8         VARCHAR (60) COLLATE Latin1_General_BIN NULL,
	tsh_campo9         VARCHAR (60) COLLATE Latin1_General_BIN NULL,
	tsh_campo10        VARCHAR (254) COLLATE Latin1_General_BIN NULL,
	tsh_valor1         MONEY NULL,
	tsh_valor2         MONEY NULL,
	tsh_valor3         MONEY NULL,
	tsh_valor4         MONEY NULL,
	tsh_valor5         MONEY NULL,
	tsh_valor6         MONEY NULL,
	tsh_valor7         MONEY NULL,
	tsh_valor8         MONEY NULL,
	tsh_valor9         MONEY NULL,
	tsh_valor10        MONEY NULL,
	tsh_retorno        INT NOT NULL,
	tsh_conciliado     CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
	tsh_fecha_conc     DATETIME NULL,
	tsh_adquiriente    BIGINT NULL,
	tsh_cod_alterno    INT NULL,
	tsh_autorizacion   VARCHAR (6) COLLATE Latin1_General_BIN NULL,
	tsh_canal          INT NULL,
	tsh_login_ext      login NULL,
	tsh_ref_monetaria1 MONEY NULL,
	tsh_ref_monetaria2 MONEY NULL,
	tsh_ref_monetaria3 MONEY NULL,
	tsh_ref_monetaria4 MONEY NULL,
	tsh_ref_monetaria5 MONEY NULL,
	tsh_ref_numerica1  INT NULL,
	tsh_ref_numerica2  INT NULL,
	tsh_ref_numerica3  INT NULL,
	tsh_ref_numerica4  INT NULL,
	tsh_ref_numerica5  INT NULL,
	tsh_ref_texto1     descripcion NULL,
	tsh_ref_texto2     descripcion NULL,
	tsh_ref_texto3     descripcion NULL,
	tsh_ref_texto4     descripcion NULL,
	tsh_ref_texto5     descripcion NULL
	)
GO

CREATE NONCLUSTERED INDEX idx_hfechaTran
	ON dbo.ws_tran_servicio_his (tsh_fecha,tsh_tipo_tran)
GO

CREATE NONCLUSTERED INDEX idx_hsecext
	ON dbo.ws_tran_servicio_his (tsh_sec_ext)
GO

CREATE NONCLUSTERED INDEX idx_hssn
	ON dbo.ws_tran_servicio_his (tsh_ssn,tsh_cod_alterno)
GO


