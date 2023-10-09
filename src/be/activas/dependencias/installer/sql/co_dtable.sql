use cob_compensacion
go

if exists(select 1 from sysobjects
           where name = 'cr_dato_operacion_rep')
   drop table cr_dato_operacion_rep
go
		   
