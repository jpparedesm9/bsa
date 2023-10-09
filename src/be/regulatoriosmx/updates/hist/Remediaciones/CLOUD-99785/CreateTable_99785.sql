use cob_conta_super
go

IF OBJECT_ID ('dbo.sb_mov_diario_tmp') IS NOT NULL
	DROP table dbo.sb_mov_diario_tmp
go

create table dbo.sb_mov_diario_tmp
	(
	mdt_concepto     varchar (160),
	mdt_fecha_tran   varchar (10),
	mdt_comprobante  varchar (20),
	mdt_cuenta       varchar (32),
	mdt_oficina_dest varchar (20),
	mdt_area_dest    varchar (20),
	mdt_debito       varchar (20),
	mdt_credito      varchar (20)
	)
go

