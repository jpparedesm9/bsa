use cob_conta_super
go

select top 1 * from sb_dato_operacion
if not exists (select 1
               from INFORMATION_SCHEMA.COLUMNS
               where COLUMN_NAME = 'do_dia_pago' AND TABLE_NAME = 'sb_dato_operacion')
begin
    ALTER TABLE sb_dato_operacion ADD do_dia_pago varchar(20) null
end

select top 1 * from sb_dato_operacion
go

------>>>>>
use cob_conta_super
go

select top 1 * from sb_dato_operacion_tmp
if not exists (select 1
               from INFORMATION_SCHEMA.COLUMNS
               where COLUMN_NAME = 'do_dia_pago' AND TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    ALTER TABLE sb_dato_operacion_tmp ADD do_dia_pago varchar(20) null
end

select top 1 * from sb_dato_operacion_tmp
go

------>>>>>

use cob_externos
go

select top 1 * from ex_dato_operacion
if not exists (select 1
               from INFORMATION_SCHEMA.COLUMNS
               where COLUMN_NAME = 'do_dia_pago' AND TABLE_NAME = 'ex_dato_operacion')
begin
    ALTER TABLE ex_dato_operacion ADD do_dia_pago varchar(20) null
end

select top 1 * from ex_dato_operacion
go

