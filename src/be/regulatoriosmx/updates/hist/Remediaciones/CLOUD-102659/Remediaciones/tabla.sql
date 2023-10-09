use cob_conta_super
go

if object_id ('sb_ods_bdi') is not null
	drop table sb_ods_bdi
go
create table sb_ods_bdi(
FEC_DATA             varchar(10),
COD_ENTIDAD          varchar(4),
COD_CENTRO           varchar(10),
COD_PRODUCTO         varchar(2),
COD_SUBPRODU         varchar(4),
NUM_CUENTA           cuenta,
NUM_SECUENCIA_CTO    varchar(3),
COD_ORIGEN           varchar(10),
COD_SIGNO_MOVIMIENTO varchar(1),
COD_TIPO_MOVIMIENTO  varchar(10),
COD_DIVISA           varchar(3),
IMP_MOVIMIENTO_MO    varchar(24)
)
create index idx1 on sb_ods_bdi (FEC_DATA)
