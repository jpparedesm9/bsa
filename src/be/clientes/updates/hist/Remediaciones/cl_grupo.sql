IF OBJECT_ID ('dbo.cl_grupo') IS NOT NULL
	DROP TABLE dbo.cl_grupo
GO

CREATE TABLE dbo.cl_grupo
	(
	gr_grupo               INT NOT NULL,
	gr_nombre              descripcion NOT NULL,
	gr_representante       INT NULL,
	gr_compania            INT NULL,
	gr_oficial             INT NULL,
	gr_fecha_registro      DATETIME NOT NULL,
	gr_fecha_modificacion  DATETIME NOT NULL,
	gr_ruc                 numero NULL,
	gr_vinculacion         CHAR (1) NULL,
	gr_tipo_vinculacion    catalogo NULL,
	gr_max_riesgo          MONEY NULL,
	gr_riesgo              MONEY NULL,
	gr_usuario             login NULL,
	gr_reservado           MONEY NULL,
	gr_tipo_grupo          catalogo NULL,
	gr_estado              catalogo NOT NULL,
	gr_dir_reunion         VARCHAR (125) NOT NULL,
	gr_dia_reunion         catalogo NOT NULL,
	gr_hora_reunion        DATETIME NOT NULL,
	gr_comportamiento_pago VARCHAR (10) NULL,
	gr_num_ciclo           INT NULL,
	gr_incluir             DATE NULL,
	gr_consec_tipo         VARCHAR (25) NULL,
	gr_suplente            VARCHAR (25) NULL,
	gr_tipo                CHAR (1) NULL,
	gr_cta_grupal          VARCHAR (30) NULL,
	gr_sucursal            INT NULL,
	gr_titular1            INT NULL,
	gr_titular2            INT NULL,
	gr_lugar_reunion       CHAR (10) NULL,
	gr_tiene_ctagr         CHAR (1) NULL,
	gr_tiene_ctain         CHAR (1) NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cl_grupo_Key
	ON dbo.cl_grupo (gr_grupo)
GO


