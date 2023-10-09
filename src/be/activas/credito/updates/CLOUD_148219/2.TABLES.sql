use cob_cartera
go

if object_id ('dbo.ca_lcr_autoriza_bloqueo') is not null
	drop table dbo.ca_lcr_autoriza_bloqueo
go

create table ca_lcr_autoriza_bloqueo
(	
	ab_operacion 	int,
	ab_autorizado	char(1) null,
	ab_fecha_aut	datetime null,
	ab_usuario_aut	varchar(15)
)

create index idx1 on dbo.ca_lcr_autoriza_bloqueo (ab_operacion,ab_autorizado,ab_fecha_aut)
go
