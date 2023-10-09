-- TABLA DE PARAMETRIA DE PROVISIONES EN cob_cuenta_super
IF OBJECT_ID ('cob_conta_super..sb_provisiones') IS NOT NULL
	DROP TABLE cob_conta_super..sb_provisiones
GO

CREATE TABLE cob_conta_super..sb_provisiones
(
	pr_clase_cartera    catalogo,
	pr_tipo_cartera	    catalogo NULL,
	pr_subtipo_cartera  catalogo NULL,
	pr_calificacion		CHAR(1) NULL,
	pr_dias_mora_ini	INT,
	pr_dias_mora_fin	INT,
	pr_periodo_mora		INT NULL,
	pr_periodo_cuota    catalogo NULL,
	pr_porcentaje	    FLOAT
)
GO

CREATE INDEX pr_cla_subtipo_Key
    ON cob_conta_super..sb_provisiones (pr_clase_cartera, pr_subtipo_cartera)
GO

CREATE INDEX pr_calificacion_Key
    ON cob_conta_super..sb_provisiones (pr_calificacion)
GO