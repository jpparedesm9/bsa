use cob_cartera 
go

if OBJECT_ID ('ca_ns_corresponsal_pago') is not null
	drop table ca_ns_corresponsal_pago
go

create table ca_ns_corresponsal_pago
	(
	ncp_banco   cuenta,
  	ncp_estado  char(1)
	)
go

