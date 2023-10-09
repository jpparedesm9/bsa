

use cob_externos 
go 



if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ex_dato_operacion' and COLUMN_NAME = 'do_meses_primer_op') 
begin
   print 'creando campo ex_dato_operacion'
   alter table ex_dato_operacion add  do_meses_primer_op int   null 
end

use cob_conta_super 
go 

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'sb_dato_operacion_tmp' and COLUMN_NAME = 'do_meses_primer_op') 
begin 
   print 'creando campo sb_dato_operacion_tmp'
   alter table sb_dato_operacion_tmp add  do_meses_primer_op int  null 
end


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'sb_dato_operacion' and COLUMN_NAME = 'do_meses_primer_op') 
begin 
   print 'creando campo sb_dato_operacion'
   alter table sb_dato_operacion add  do_meses_primer_op  int null 
end 

use cob_conta_super 
go 
alter table sb_banxico_lcr alter column  sb_mesantig varchar(4) null