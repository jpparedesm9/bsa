
use cob_externos
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS  where  table_name = 'ex_dato_operacion' and column_name = 'do_cuota_int_esp'   ) begin
	alter table ex_dato_operacion add do_cuota_int_esp    money
end 
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS  where  table_name = 'ex_dato_operacion' and column_name = 'do_cuota_iva_esp'   ) begin
	alter table ex_dato_operacion add do_cuota_iva_esp    money
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS  where  table_name = 'ex_dato_operacion' and column_name = 'do_fecha_ini_desp'   ) begin
	alter table ex_dato_operacion add do_fecha_ini_desp   datetime
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS  where  table_name = 'ex_dato_operacion' and column_name = 'do_fecha_fin_desp'   ) begin
	alter table ex_dato_operacion add do_fecha_fin_desp   datetime
end

go

use cob_conta_super
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS  where  table_name = 'sb_dato_operacion' and column_name = 'do_cuota_int_esp'   ) begin
	alter table sb_dato_operacion add do_cuota_int_esp    money
end 
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS  where  table_name = 'sb_dato_operacion' and column_name = 'do_cuota_iva_esp'   ) begin
	alter table sb_dato_operacion add do_cuota_iva_esp    money
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS  where  table_name = 'sb_dato_operacion' and column_name = 'do_fecha_ini_desp'   ) begin
	alter table sb_dato_operacion add do_fecha_ini_desp   datetime
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS  where  table_name = 'sb_dato_operacion' and column_name = 'do_fecha_fin_desp'   ) begin
	alter table sb_dato_operacion add do_fecha_fin_desp   datetime
end


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS  where  table_name = 'sb_dato_operacion_tmp' and column_name = 'do_cuota_int_esp'   ) begin
	alter table sb_dato_operacion_tmp add do_cuota_int_esp    money
end 
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS  where  table_name = 'sb_dato_operacion_tmp' and column_name = 'do_cuota_iva_esp'   ) begin
	alter table sb_dato_operacion_tmp add do_cuota_iva_esp    money
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS  where  table_name = 'sb_dato_operacion_tmp' and column_name = 'do_fecha_ini_desp'   ) begin
	alter table sb_dato_operacion_tmp add do_fecha_ini_desp   datetime
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS  where  table_name = 'sb_dato_operacion_tmp' and column_name = 'do_fecha_fin_desp'   ) begin
	alter table sb_dato_operacion_tmp add do_fecha_fin_desp   datetime
end

go
