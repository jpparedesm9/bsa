use cob_conta
go
IF OBJECT_ID ('dbo.cb_perfil') IS NOT NULL
	DROP TABLE dbo.cb_perfil
GO

CREATE TABLE dbo.cb_perfil
	(
	pe_empresa     TINYINT NOT NULL,
	pe_producto    TINYINT NOT NULL,
	pe_perfil      VARCHAR (20) NOT NULL,
	pe_descripcion descripcion NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_perfil_Key
	ON dbo.cb_perfil (pe_empresa,pe_producto,pe_perfil)
GO

IF OBJECT_ID ('dbo.cb_det_perfil') IS NOT NULL
	DROP TABLE dbo.cb_det_perfil
GO

CREATE TABLE dbo.cb_det_perfil
	(
	dp_empresa     TINYINT NOT NULL,
	dp_producto    TINYINT NOT NULL,
	dp_perfil      VARCHAR (20) NOT NULL,
	dp_asiento     SMALLINT NOT NULL,
	dp_cuenta      VARCHAR (40) NULL,
	dp_area        VARCHAR (10) NOT NULL,
	dp_debcred     CHAR (1) NOT NULL,
	dp_codval      INT NOT NULL,
	dp_tipo_tran   CHAR (1) NOT NULL,
	dp_origen_dest CHAR (1) NULL,
	dp_constante   VARCHAR (3) NULL,
	dp_fuente      CHAR (1) NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_det_perfil_Key
	ON dbo.cb_det_perfil (dp_empresa,dp_producto,dp_perfil,dp_asiento)
GO

CREATE NONCLUSTERED INDEX cb_det_perfil_Key2
	ON dbo.cb_det_perfil (dp_perfil,dp_codval)
GO

IF OBJECT_ID ('dbo.cb_relparam') IS NOT NULL
	DROP TABLE dbo.cb_relparam
GO

CREATE TABLE dbo.cb_relparam
	(
	re_empresa     TINYINT NOT NULL,
	re_parametro   VARCHAR (10) NOT NULL,
	re_clave       VARCHAR (20) NOT NULL,
	re_substring   cuenta NOT NULL,
	re_producto    TINYINT NULL,
	re_tipo_area   VARCHAR (10) NULL,
	re_origen_dest CHAR (1) NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_relparam_Key
	ON dbo.cb_relparam (re_empresa,re_parametro,re_clave)
GO

IF OBJECT_ID ('dbo.cb_tipo_area') IS NOT NULL
	DROP TABLE dbo.cb_tipo_area
GO

CREATE TABLE dbo.cb_tipo_area
	(
	ta_empresa       TINYINT NOT NULL,
	ta_producto      TINYINT NOT NULL,
	ta_tiparea       VARCHAR (10) NOT NULL,
	ta_utiliza_valor CHAR (1) NOT NULL,
	ta_area          SMALLINT NULL,
	ta_descripcion   descripcion NULL,
	ta_ofi_central   SMALLINT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_tipo_area_Key
	ON dbo.cb_tipo_area (ta_empresa,ta_producto,ta_tiparea)
GO

IF OBJECT_ID ('dbo.cb_parametro') IS NOT NULL
	DROP TABLE dbo.cb_parametro
GO

CREATE TABLE dbo.cb_parametro
	(
	pa_empresa     TINYINT NOT NULL,
	pa_parametro   VARCHAR (10) NOT NULL,
	pa_descripcion descripcion NOT NULL,
	pa_stored      VARCHAR (20) NOT NULL,
	pa_transaccion INT NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_parametro_Key
	ON dbo.cb_parametro (pa_empresa,pa_parametro)
GO

IF OBJECT_ID ('dbo.cb_producto') IS NOT NULL
	DROP TABLE dbo.cb_producto
GO

CREATE TABLE dbo.cb_producto
	(
	pr_empresa   TINYINT NOT NULL,
	pr_producto  TINYINT NOT NULL,
	pr_online    CHAR (1) NOT NULL,
	pr_estado    CHAR (1) NOT NULL,
	pr_resumen   CHAR (1) NOT NULL,
	pr_fecha_mod DATETIME NOT NULL
	)
GO

