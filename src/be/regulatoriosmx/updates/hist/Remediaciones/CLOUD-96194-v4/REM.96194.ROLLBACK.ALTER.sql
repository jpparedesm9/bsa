--remediación

use cob_externos 
go 


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_max_vencida' and TABLE_NAME = 'ex_dato_operacion')
    alter table ex_dato_operacion drop column do_cuota_max_vencida  

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_atraso_gr_ant' and TABLE_NAME = 'ex_dato_operacion')
   alter table ex_dato_operacion drop column do_atraso_gr_ant  


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'dr_categoria' and TABLE_NAME = 'ex_dato_operacion_rubro')
   alter table ex_dato_operacion_rubro drop column dr_categoria 


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'dr_rubro_aso' and TABLE_NAME = 'ex_dato_operacion_rubro')
  alter table ex_dato_operacion_rubro drop column dr_rubro_aso
  
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'dr_cat_rub_aso' and TABLE_NAME = 'ex_dato_operacion_rubro')
   alter table ex_dato_operacion_rubro drop column   dr_cat_rub_aso catalogo null 
go


use cob_conta_super 
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_max_vencida' and TABLE_NAME = 'sb_dato_operacion_tmp')
    alter table sb_dato_operacion_tmp drop column do_cuota_max_vencida  


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_atraso_gr_ant' and TABLE_NAME = 'sb_dato_operacion_tmp')
   alter table sb_dato_operacion_tmp drop column do_atraso_gr_ant  


--
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_max_vencida' and TABLE_NAME = 'sb_dato_operacion')
    alter table sb_dato_operacion drop column do_cuota_max_vencida  


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_atraso_gr_ant' and TABLE_NAME = 'sb_dato_operacion')
    alter table sb_dato_operacion drop column do_atraso_gr_ant  

--

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'dr_categoria' and TABLE_NAME = 'sb_dato_operacion_rubro')
  alter table sb_dato_operacion_rubro drop column dr_categoria 


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'dr_rubro_aso' and TABLE_NAME = 'sb_dato_operacion_rubro')
  alter table sb_dato_operacion_rubro drop column dr_rubro_aso 
   
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'dr_cat_rub_aso' and TABLE_NAME = 'sb_dato_operacion_rubro')
   alter table sb_dato_operacion_rubro drop column   dr_cat_rub_aso catalogo null     

go

