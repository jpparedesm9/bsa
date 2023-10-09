--remediación

use cob_externos 
go 


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_max_vencida' and TABLE_NAME = 'ex_dato_operacion')
    alter table ex_dato_operacion add  do_cuota_max_vencida  money  null


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_atraso_gr_ant' and TABLE_NAME = 'ex_dato_operacion')
   alter table ex_dato_operacion add  do_atraso_gr_ant  int  null


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'dr_categoria' and TABLE_NAME = 'ex_dato_operacion_rubro')
   alter table ex_dato_operacion_rubro add  dr_categoria catalogo null


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'dr_rubro_aso' and TABLE_NAME = 'ex_dato_operacion_rubro')
   alter table ex_dato_operacion_rubro add  dr_rubro_aso catalogo null
   
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'dr_cat_rub_aso' and TABLE_NAME = 'ex_dato_operacion_rubro')
   alter table ex_dato_operacion_rubro add  dr_cat_rub_aso catalogo null   

go




use cob_conta_super 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_max_vencida' and TABLE_NAME = 'sb_dato_operacion_tmp')
   alter table sb_dato_operacion_tmp add  do_cuota_max_vencida  money  null


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_atraso_gr_ant' and TABLE_NAME = 'sb_dato_operacion_tmp')
   alter table sb_dato_operacion_tmp add  do_atraso_gr_ant  int  null


--
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_max_vencida' and TABLE_NAME = 'sb_dato_operacion')
   alter table sb_dato_operacion add  do_cuota_max_vencida  money  null


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_atraso_gr_ant' and TABLE_NAME = 'sb_dato_operacion')
   alter table sb_dato_operacion add  do_atraso_gr_ant  int  null

--

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'dr_categoria' and TABLE_NAME = 'sb_dato_operacion_rubro')
   alter table sb_dato_operacion_rubro add  dr_categoria catalogo null


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'dr_rubro_aso' and TABLE_NAME = 'sb_dato_operacion_rubro')
   alter table sb_dato_operacion_rubro add  dr_rubro_aso catalogo null
   
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'dr_cat_rub_aso' and TABLE_NAME = 'sb_dato_operacion_rubro')
   alter table sb_dato_operacion_rubro add  dr_cat_rub_aso catalogo null   

go