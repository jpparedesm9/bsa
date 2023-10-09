use cob_cartera
go

if object_id ('ca_abono_can_bdi') is not null
	drop table ca_abono_can_bdi
go
create table ca_abono_can_bdi(
ac_fecha           datetime,
ac_operacion       int,
ac_secuencial_pag  int)

create index idx1 on ca_abono_can_bdi (ac_fecha)
create index idx2 on ca_abono_can_bdi (ac_operacion, ac_secuencial_pag)