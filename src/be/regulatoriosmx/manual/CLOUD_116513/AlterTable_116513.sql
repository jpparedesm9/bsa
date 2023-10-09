use cob_externos
go

if not exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'dc_fecha_ini'
              and  c1.table_name = 'ex_dato_cuota_pry')
begin 
    alter table ex_dato_cuota_pry
	 add dc_fecha_ini datetime null
end


use cob_conta_super
go

if not exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'dc_fecha_ini'
              and  c1.table_name = 'sb_dato_cuota_pry')
begin 
	alter table sb_dato_cuota_pry
	add dc_fecha_ini datetime null
end
