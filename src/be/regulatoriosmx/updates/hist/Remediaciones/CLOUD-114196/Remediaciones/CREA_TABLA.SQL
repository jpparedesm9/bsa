use cob_conta_super
go

IF OBJECT_ID ('dbo.sb_lcr_riesgo_provision') IS NOT NULL
	DROP TABLE dbo.sb_lcr_riesgo_provision
GO

CREATE TABLE dbo.sb_lcr_riesgo_provision
	(
	Num_cred              VARCHAR (24) NULL,
	Num_cliente           VARCHAR (20) NULL,
	Num_grupo             VARCHAR (4) NULL,
	Cod_producto          VARCHAR (2) NULL,
	Cod_subproducto       VARCHAR (4) NULL,
	Cod_periodo_capital   VARCHAR (1) NULL,
	Cod_periodo_intereses VARCHAR (1) NULL,
	Exig_T1               VARCHAR (20) NULL,
	Pago_T1               VARCHAR (20) NULL,
	Fec_Exig_T1           VARCHAR (20) NULL,
	Fec_Pago_T1           VARCHAR (20) NULL,
	Exig_T2               VARCHAR (20) NULL,
	Pago_T2               VARCHAR (20) NULL,
	Fec_Exig_T2           VARCHAR (20) NULL,
	Fec_Pago_T2           VARCHAR (20) NULL,
	Exig_T3               VARCHAR (20) NULL,
	Pago_T3               VARCHAR (20) NULL,
	Fec_Exig_T3           VARCHAR (20) NULL,
	Fec_Pago_T3           VARCHAR (20) NULL,
	Exig_T4               VARCHAR (20) NULL,
	Pago_T4               VARCHAR (20) NULL,
	Fec_Exig_T4           VARCHAR (20) NULL,
	Fec_Pago_T4           VARCHAR (20) NULL,
	Exig_T5               VARCHAR (20) NULL,
	Pago_T5               VARCHAR (20) NULL,
	Fec_Exig_T5           VARCHAR (20) NULL,
	Fec_Pago_T5           VARCHAR (20) NULL,
	Exig_T6               VARCHAR (20) NULL,
	Pago_T6               VARCHAR (20) NULL,
	Fec_Exig_T6           VARCHAR (20) NULL,
	Fec_Pago_T6           VARCHAR (20) NULL,
	Exig_T7               VARCHAR (20) NULL,
	Pago_T7               VARCHAR (20) NULL,
	Fec_Exig_T7           VARCHAR (20) NULL,
	Fec_Pago_T7           VARCHAR (20) NULL,
	Exig_T8               VARCHAR (20) NULL,
	Pago_T8               VARCHAR (20) NULL,
	Fec_Exig_T8           VARCHAR (20) NULL,
	Fec_Pago_T8           VARCHAR (20) NULL,
	Exig_T9               VARCHAR (20) NULL,
	Pago_T9               VARCHAR (20) NULL,
	Fec_Exig_T9           VARCHAR (20) NULL,
	Fec_Pago_T9           VARCHAR (20) NULL,
	Exig_T10              VARCHAR (20) NULL,
	Pago_T10              VARCHAR (20) NULL,
	Fec_Exig_T10          VARCHAR (20) NULL,
	Fec_Pago_T10          VARCHAR (20) NULL,
	Exig_T11              VARCHAR (20) NULL,
	Pago_T11              VARCHAR (20) NULL,
	Fec_Exig_T11          VARCHAR (20) NULL,
	Fec_Pago_T11          VARCHAR (20) NULL,
	Exig_T12              VARCHAR (20) NULL,
	Pago_T12              VARCHAR (20) NULL,
	Fec_Exig_T12          VARCHAR (20) NULL,
	Fec_Pago_T12          VARCHAR (20) NULL,
	Exig_T13              VARCHAR (20) NULL,
	Pago_T13              VARCHAR (20) NULL,
	Fec_Exig_T13          VARCHAR (20) NULL,
	Fec_Pago_T13          VARCHAR (20) NULL,
	Exig_T14              VARCHAR (20) NULL,
	Pago_T14              VARCHAR (20) NULL,
	Fec_Exig_T14          VARCHAR (20) NULL,
	Fec_Pago_T14          VARCHAR (20) NULL,
	Exig_T15              VARCHAR (20) NULL,
	Pago_T15              VARCHAR (20) NULL,
	Fec_Exig_T15          VARCHAR (20) NULL,
	Fec_Pago_T15          VARCHAR (20) NULL,
	Exig_T16              VARCHAR (20) NULL,
	Pago_T16              VARCHAR (20) NULL,
	Fec_Exig_T16          VARCHAR (20) NULL,
	Fec_Pago_T16          VARCHAR (20) NULL,
	Imp_total_riesgo      VARCHAR (20) NULL,
	Integrantes           VARCHAR (4) NULL,
	Ciclos                VARCHAR (4) NULL
	)
GO

CREATE NONCLUSTERED INDEX idx1
	ON dbo.sb_lcr_riesgo_provision (Num_cred)
GO

CREATE NONCLUSTERED INDEX idx2
	ON dbo.sb_lcr_riesgo_provision (Num_cliente)
GO

