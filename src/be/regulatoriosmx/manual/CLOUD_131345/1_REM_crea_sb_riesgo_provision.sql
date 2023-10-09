use cob_conta_super
go

IF OBJECT_ID ('dbo.sb_riesgo_provision') IS NOT NULL
	DROP table dbo.sb_riesgo_provision
go

create table dbo.sb_riesgo_provision
	(
	Num_cred              varchar (24),
	Num_cliente           varchar (20),
	Num_grupo             varchar (10),
	Cod_producto          varchar (2),
	Cod_subproducto       varchar (4),
	Cod_periodo_capital   varchar (1),
	Cod_periodo_intereses varchar (1),
	Exig_T1               varchar (20),
	Pago_T1               varchar (20),
	Fec_Exig_T1           varchar (20),
	Fec_Pago_T1           varchar (20),
	Exig_T2               varchar (20),
	Pago_T2               varchar (20),
	Fec_Exig_T2           varchar (20),
	Fec_Pago_T2           varchar (20),
	Exig_T3               varchar (20),
	Pago_T3               varchar (20),
	Fec_Exig_T3           varchar (20),
	Fec_Pago_T3           varchar (20),
	Exig_T4               varchar (20),
	Pago_T4               varchar (20),
	Fec_Exig_T4           varchar (20),
	Fec_Pago_T4           varchar (20),
	Exig_T5               varchar (20),
	Pago_T5               varchar (20),
	Fec_Exig_T5           varchar (20),
	Fec_Pago_T5           varchar (20),
	Exig_T6               varchar (20),
	Pago_T6               varchar (20),
	Fec_Exig_T6           varchar (20),
	Fec_Pago_T6           varchar (20),
	Exig_T7               varchar (20),
	Pago_T7               varchar (20),
	Fec_Exig_T7           varchar (20),
	Fec_Pago_T7           varchar (20),
	Exig_T8               varchar (20),
	Pago_T8               varchar (20),
	Fec_Exig_T8           varchar (20),
	Fec_Pago_T8           varchar (20),
	Exig_T9               varchar (20),
	Pago_T9               varchar (20),
	Fec_Exig_T9           varchar (20),
	Fec_Pago_T9           varchar (20),
	Exig_T10              varchar (20),
	Pago_T10              varchar (20),
	Fec_Exig_T10          varchar (20),
	Fec_Pago_T10          varchar (20),
	Exig_T11              varchar (20),
	Pago_T11              varchar (20),
	Fec_Exig_T11          varchar (20),
	Fec_Pago_T11          varchar (20),
	Exig_T12              varchar (20),
	Pago_T12              varchar (20),
	Fec_Exig_T12          varchar (20),
	Fec_Pago_T12          varchar (20),
	Exig_T13              varchar (20),
	Pago_T13              varchar (20),
	Fec_Exig_T13          varchar (20),
	Fec_Pago_T13          varchar (20),
	Exig_T14              varchar (20),
	Pago_T14              varchar (20),
	Fec_Exig_T14          varchar (20),
	Fec_Pago_T14          varchar (20),
	Exig_T15              varchar (20),
	Pago_T15              varchar (20),
	Fec_Exig_T15          varchar (20),
	Fec_Pago_T15          varchar (20),
	Exig_T16              varchar (20),
	Pago_T16              varchar (20),
	Fec_Exig_T16          varchar (20),
	Fec_Pago_T16          varchar (20),
	Imp_total_riesgo      varchar (20),
	Integrantes           varchar (4),
	Ciclos                varchar (4)
	)
go

create index idx1
	on dbo.sb_riesgo_provision (Num_cred)
go

create index idx2
	on dbo.sb_riesgo_provision (Num_cliente)
go

