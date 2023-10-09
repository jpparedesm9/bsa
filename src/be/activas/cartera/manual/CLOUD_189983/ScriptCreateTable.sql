use cob_cartera
go

if OBJECT_ID ('dbo.ca_operacion_proy') IS NOT NULL
	drop table dbo.ca_operacion_proy
go

create table dbo.ca_operacion_proy
	(
	op_operacion_real int    null,
    op_ficticia       int    null
	)
go

create clustered index ca_operacion_proy_Key on dbo.ca_operacion_proy (op_operacion_real, op_ficticia)
go
