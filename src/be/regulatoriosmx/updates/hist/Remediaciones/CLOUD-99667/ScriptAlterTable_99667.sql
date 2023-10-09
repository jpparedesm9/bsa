
---------------------------------------------------------------------------------------
--------------------------AGREGAR CAMPO PARA REPORTES        --------------------------
---------------------------------------------------------------------------------------
use cobis
go


select *
from cobis..cl_parametro
where pa_nemonico = 'NDREPA'


if not exists(select 1
              from cobis..cl_parametro
              where pa_nemonico = 'NDREPA')
begin
    insert into cobis..cl_parametro (pa_parametro                  , pa_nemonico, pa_tipo, pa_int, pa_producto)
                         values ('NUMERO DIAS REPORTE PARCIAL BURO', 'NDREPA'   , 'I'    , 6     , 'CCA')
end                                                

select *
from cobis..cl_parametro
where pa_nemonico = 'NDREPA'

use cob_externos
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_dividendo_ven' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion add do_fecha_dividendo_ven datetime null 
    
end
else
begin
	alter table cob_externos..ex_dato_operacion alter column do_fecha_dividendo_ven datetime null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_min_vencida' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion add do_cuota_min_vencida money null 
    
end
else
begin
	alter table cob_externos..ex_dato_operacion alter column do_cuota_min_vencida money null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_tplazo' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion add do_tplazo varchar(10) null 
    
end
else
begin
	alter table cob_externos..ex_dato_operacion alter column do_tplazo varchar(10) null
end
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_proceso' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion add do_fecha_proceso datetime null 
    
end
else
begin
	alter table cob_externos..ex_dato_operacion alter column do_fecha_proceso datetime null
end
go

use cob_conta_super
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_dividendo_ven' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion add do_fecha_dividendo_ven datetime null 
    
end
else
begin
	alter table cob_conta_super..sb_dato_operacion alter column do_fecha_dividendo_ven datetime null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_operacion' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion add do_operacion int null 
    
end
else
begin
	alter table cob_conta_super..sb_dato_operacion alter column do_operacion int null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_min_vencida' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion add do_cuota_min_vencida money null 
    
end
else
begin
	alter table cob_conta_super..sb_dato_operacion alter column do_cuota_min_vencida money null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_tplazo' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion add do_tplazo varchar(10) null 
    
end
else
begin
	alter table cob_conta_super..sb_dato_operacion alter column do_tplazo varchar(10) null
end
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_proceso' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion add do_fecha_proceso datetime null 
    
end
else
begin
	alter table cob_conta_super..sb_dato_operacion alter column do_fecha_proceso datetime null
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_dividendo_ven' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp add do_fecha_dividendo_ven datetime null 
    
end
else
begin
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_fecha_dividendo_ven datetime null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_operacion' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp add do_operacion int null     
end
else
begin
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_operacion int null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_min_vencida' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp add do_cuota_min_vencida money null     
end
else
begin
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_cuota_min_vencida money null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_tplazo' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp add do_tplazo varchar(10) null 
    
end
else
begin
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_tplazo varchar(10) null
end
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_proceso' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp add do_fecha_proceso datetime null 
    
end
else
begin
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_fecha_proceso datetime null
end
go


use cob_conta_super
go

declare @w_registro_min  int,
        @w_registro_max  int,
        @w_max_bloque    int

select @w_max_bloque = 60        

create table #tmp_fechas
(secuencial  int identity,
 fecha       datetime    )

insert into #tmp_fechas(
       fecha
       )
select distinct do_fecha
from sb_dato_operacion
order by do_fecha


select @w_registro_min = min(secuencial),
       @w_registro_max = max(secuencial)
from #tmp_fechas

while @w_registro_min <= @w_registro_max
begin
      
      print 'Min ' + convert(varchar,@w_registro_min) + ' Bloque ' + convert(varchar,@w_max_bloque)
      update sb_dato_operacion
      set    do_operacion = op_operacion,
             do_tplazo    = op_tplazo
      from   #tmp_fechas,
             cob_cartera..ca_operacion
      where  secuencial>= @w_registro_min
      and    secuencial<= @w_max_bloque
      and    do_fecha   = fecha
      and    do_banco   = op_banco 
      
      select @w_registro_min = @w_max_bloque,
             @w_max_bloque   = @w_max_bloque + @w_max_bloque      
      
            
end



