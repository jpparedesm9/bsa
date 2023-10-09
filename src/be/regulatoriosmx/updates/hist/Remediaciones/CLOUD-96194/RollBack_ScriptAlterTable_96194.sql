
---------------------------------------------------------------------------------------
--------------------------AGREGAR CAMPO PARA REPORTES        --------------------------
---------------------------------------------------------------------------------------
use cobis
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'gr_dias_atraso' and TABLE_NAME = 'cl_grupo')
begin
    alter table cobis..cl_grupo drop column gr_dias_atraso
end
go


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ea_experiencia' and TABLE_NAME = 'cl_ente_aux')
begin
    alter table cobis..cl_ente_aux drop column ea_experiencia
end

go

use cob_externos
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_cap' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion drop column do_cuota_cap
end

go


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_int' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion drop column do_cuota_int
end

go


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_iva' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion drop column do_cuota_iva
end
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_suspenso' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion drop column do_fecha_suspenso
end
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuenta' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion drop column do_cuenta
end

go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_venc_dividendo' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion drop column do_venc_dividendo
end
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_plazo' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion drop column do_plazo    
end
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_aprob_tramite' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion drop column do_fecha_aprob_tramite
    
end
go


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_subtipo_producto' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion drop column do_subtipo_producto    
end
go


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_atraso_grupal' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion drop column do_atraso_grupal    
end
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

go


use cob_conta_super
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_cap' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion drop column do_cuota_cap
end
go


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_int' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion drop column do_cuota_int
end
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_iva' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion drop column do_cuota_iva
end
go


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_suspenso ' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion drop column do_fecha_suspenso
end

go


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuenta ' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion drop column do_cuenta
end
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_venc_dividendo' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion drop column do_venc_dividendo
end
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_plazo' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion drop column do_plazo
    
end
go


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_aprob_tramite' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion drop column do_fecha_aprob_tramite    
end
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_subtipo_producto' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion drop column do_subtipo_producto    
end
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_atraso_grupal' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion drop column do_atraso_grupal
    
end
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


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_cap' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_cuota_cap
end
go


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_int' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_cuota_int
end
go


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_iva' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_cuota_iva
end
go



if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_suspenso ' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_fecha_suspenso
end

go


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuenta ' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_cuenta
end

go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_venc_dividendo' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp  drop column do_venc_dividendo
end
go


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_plazo' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_plazo
end
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_aprob_tramite' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_fecha_aprob_tramite 
    
end
go


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_subtipo_producto' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_subtipo_producto 
    
end
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_atraso_grupal' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp drop column do_atraso_grupal
    
end

go

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


