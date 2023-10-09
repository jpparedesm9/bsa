use cob_conta_super
go

select top 1 * from sb_dato_operacion
if exists (select 1
               from INFORMATION_SCHEMA.COLUMNS
               where COLUMN_NAME = 'do_dia_pago' AND TABLE_NAME = 'sb_dato_operacion')
begin
    ALTER TABLE sb_dato_operacion drop column do_dia_pago
end

select top 1 * from sb_dato_operacion
go

------>>>>>
use cob_conta_super
go

select top 1 * from sb_dato_operacion_tmp
if exists (select 1
               from INFORMATION_SCHEMA.COLUMNS
               where COLUMN_NAME = 'do_dia_pago' AND TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    ALTER TABLE sb_dato_operacion_tmp drop column do_dia_pago
end

select top 1 * from sb_dato_operacion_tmp
go

------>>>>>

use cob_externos
go

select top 1 * from ex_dato_operacion
if exists (select 1
               from INFORMATION_SCHEMA.COLUMNS
               where COLUMN_NAME = 'do_dia_pago' AND TABLE_NAME = 'ex_dato_operacion')
begin
    ALTER TABLE ex_dato_operacion drop column do_dia_pago
end

select top 1 * from ex_dato_operacion
go
