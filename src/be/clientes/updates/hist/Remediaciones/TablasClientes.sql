
SELECT * FROM cts_interceptor

USE cobis GO

IF OBJECT_ID ('dbo.cl_telefono') IS NOT NULL
	DROP TABLE dbo.cl_telefono
GO

CREATE TABLE dbo.cl_telefono
	(
	te_ente               INT NOT NULL,
	te_direccion          TINYINT NOT NULL,
	te_secuencial         TINYINT NOT NULL,
	te_valor              VARCHAR (16) NULL,
	te_tipo_telefono      CHAR (1) NOT NULL,
	te_prefijo            VARCHAR (10) NULL,
	te_fecha_registro     DATETIME DEFAULT (getdate()) NULL,
	te_fecha_mod          DATETIME DEFAULT (getdate()) NULL,
	te_tipo_operador      VARCHAR (10) NULL,
	te_area               VARCHAR (10) NULL,
	te_telf_cobro         CHAR (1) NULL,
	te_funcionario        login NULL,
	te_verificado         CHAR (1) NULL,
	te_fecha_ver          DATETIME NULL,
	te_fecha_modificacion DATETIME NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cl_telefono_Key
	ON dbo.cl_telefono (te_ente,te_direccion,te_secuencial)
GO

CREATE NONCLUSTERED INDEX i_t_tipo_telefono
	ON dbo.cl_telefono (te_ente,te_tipo_telefono)
GO




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

CREATE UNIQUE CLUSTERED INDEX cl_cliente_grupo_Key
	ON dbo.cl_cliente_grupo (cg_grupo,cg_ente)
GO



IF OBJECT_ID ('dbo.cl_ente_aux') IS NOT NULL
	DROP TABLE dbo.cl_ente_aux
GO

CREATE TABLE dbo.cl_ente_aux
	(
	ea_ente                INT NOT NULL,
	ea_estado              catalogo NOT NULL,
	ea_observacion_aut     VARCHAR (255) NULL,
	ea_contrato_firmado    CHAR (1) NULL,
	ea_menor_edad          CHAR (1) NULL,
	ea_conocido_como       VARCHAR (255) NULL,
	ea_cliente_planilla    CHAR (1) NULL,
	ea_cod_risk            VARCHAR (20) NULL,
	ea_sector_eco          catalogo NULL,
	ea_actividad           catalogo NULL,
	ea_lin_neg             catalogo NULL,
	ea_seg_neg             catalogo NULL,
	ea_ejecutivo_con       INT NULL,
	ea_suc_gestion         SMALLINT NULL,
	ea_constitucion        SMALLINT NULL,
	ea_remp_legal          INT NULL,
	ea_apoderado_legal     INT NULL,
	ea_no_req_kyc_comp     CHAR (1) NULL,
	ea_fuente_ing          catalogo NULL,
	ea_act_prin            catalogo NULL,
	ea_detalle             VARCHAR (255) NULL,
	ea_act_dol             MONEY NULL,
	ea_cat_aml             catalogo NULL,
	ea_fecha_vincula       DATETIME NULL,
	ea_observacion_vincula VARCHAR (255) NULL,
	ea_ced_ruc             numero NULL,
	ea_discapacidad        CHAR (1) NULL,
	ea_tipo_discapacidad   catalogo NULL,
	ea_ced_discapacidad    VARCHAR (30) NULL,
	ea_id_prefijo          catalogo NULL,
	ea_id_sufijo           catalogo NULL,
	ea_duplicado           CHAR (1) NULL,
	ea_nivel_egresos       catalogo NULL,
	ea_ifi                 CHAR (1) NULL,
	ea_asfi                CHAR (1) NULL,
	ea_path_foto           VARCHAR (50) NULL,
	ea_nit                 numero NULL,
	ea_nit_venc            DATETIME NULL,
	ea_num_testimonio      VARCHAR (10) NULL,
	ea_indefinido          CHAR (1) NULL,
	ea_fecha_vigencia      DATETIME NULL,
	ea_nombre_notaria      VARCHAR (64) NULL,
	ea_nombre_notario      VARCHAR (64) NULL,
	ea_safie               VARCHAR (20) NULL,
	ea_sigaf               VARCHAR (20) NULL,
	ea_tipo_creacion       CHAR (1) NULL,
	ea_ventas              MONEY NULL,
	ea_ot_ingresos         MONEY NULL,
	ea_ct_ventas           MONEY NULL,
	ea_ct_operativo        MONEY NULL,
	ea_ant_nego            INT NULL,
	ea_cta_banco           VARCHAR (45) NULL,
	ea_nro_ciclo_oi        INT NULL
	)
GO

CREATE NONCLUSTERED INDEX iea_estado
	ON dbo.cl_ente_aux (ea_ente,ea_estado)
GO

CREATE UNIQUE NONCLUSTERED INDEX cl_ente_aux_Key
	ON dbo.cl_ente_aux (ea_ente)
GO

