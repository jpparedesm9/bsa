
use cob_conta_super
go


if not object_id('sb_detalle_impuesto') is null
drop table sb_detalle_impuesto
go

create table sb_detalle_impuesto 
(
di_banco      varchar(24),
di_concepto   varchar(100),
di_base       numeric(10,2),
di_porcentaje float,
di_valor      numeric(20,2)
)


create index sb_detalle_impuesto_idx on sb_detalle_impuesto(di_banco, di_concepto)
