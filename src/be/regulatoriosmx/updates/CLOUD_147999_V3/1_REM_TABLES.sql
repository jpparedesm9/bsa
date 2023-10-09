use cob_conta_super
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'sb_dato_operacion_abono_temp' and COLUMN_NAME = 'doa_fpago') 
alter table sb_dato_operacion_abono_temp add  doa_fpago varchar(32) null

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'sb_dato_operacion_abono_temp' and COLUMN_NAME = 'doa_op_anterior') 
alter table sb_dato_operacion_abono_temp add  doa_op_anterior varchar(32) null


go