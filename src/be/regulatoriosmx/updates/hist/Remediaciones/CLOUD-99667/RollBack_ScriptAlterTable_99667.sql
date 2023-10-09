
---------------------------------------------------------------------------------------
--------------------------AGREGAR CAMPO PARA REPORTES        --------------------------
---------------------------------------------------------------------------------------
use cobis
go

delete
from cobis..cl_parametro
where pa_nemonico = 'NDREPA'


use cob_externos
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_dividendo_ven' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion drop column do_fecha_dividendo_ven 
    
end

go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_min_vencida' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion  drop column do_cuota_min_vencida
    
end

go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_tplazo' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion drop column do_tplazo    
end

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_proceso' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion drop column do_fecha_proceso    
end


use cob_conta_super
go

go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_dividendo_ven' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion drop column do_fecha_dividendo_ven
    
end
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_operacion' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion drop column do_operacion    
end

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_min_vencida' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion drop column do_cuota_min_vencida    
end
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_tplazo' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion drop column do_tplazo
end

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_proceso' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion  drop column do_fecha_proceso 
    
end
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_dividendo_ven' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_fecha_dividendo_ven    
end
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_operacion' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_operacion
end
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_min_vencida' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_cuota_min_vencida    
end
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_tplazo' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_tplazo
    
end
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_proceso' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_fecha_proceso 
    
end



