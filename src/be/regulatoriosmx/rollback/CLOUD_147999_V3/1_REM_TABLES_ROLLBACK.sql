use cob_conta_super
go

if exists (select 1 from sys.columns 
           where Name = N'doa_fpago'
           and Object_ID = Object_ID(N'sb_dato_operacion_abono_temp')) begin
   alter table sb_dato_operacion_abono_temp
   drop column doa_fpago
end   


if  exists (select 1 from sys.columns 
           where Name = N'doa_op_anterior'
           and Object_ID = Object_ID(N'sb_dato_operacion_abono_temp')) begin
   alter table sb_dato_operacion_abono_temp
   drop column doa_op_anterior  
end   