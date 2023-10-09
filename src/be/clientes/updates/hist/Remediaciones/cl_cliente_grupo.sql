use cobis
go

IF OBJECT_ID ('dbo.cl_cliente_grupo') IS NOT NULL
	DROP TABLE dbo.cl_cliente_grupo
GO

CREATE TABLE dbo.cl_cliente_grupo
	(
	cg_ente                INT NOT NULL,
	cg_grupo               INT NOT NULL,
	cg_usuario             login NOT NULL,
	cg_terminal            VARCHAR (32) NOT NULL,
	cg_oficial             SMALLINT NULL,
	cg_fecha_reg           DATETIME NOT NULL,
	cg_rol                 catalogo NULL,
	cg_estado              catalogo NULL,
	cg_calif_interna       catalogo NULL,
	cg_fecha_desasociacion DATETIME NULL,
	cg_tipo_relacion       catalogo NULL,
	cg_ahorro_voluntario   MONEY NULL,
	cg_lugar_reunion       VARCHAR (10) NULL,
	cg_nro_ciclo           INT NULL
	)
GO
print '=====> cl_cliente_grupo_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_cliente_grupo_Key ON cl_cliente_grupo
(
    cg_grupo ,
    cg_ente
) ON indexgroup
go