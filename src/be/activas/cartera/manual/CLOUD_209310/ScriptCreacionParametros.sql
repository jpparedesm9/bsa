use cobis
go

declare @w_fecha_proceso datetime

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select *
from cobis..cl_parametro
where pa_nemonico = 'HADESO'

if not exists(select 1 from cobis..cl_parametro where pa_nemonico = 'HADESO')
begin
   insert into cl_parametro (pa_parametro                   , pa_nemonico, pa_tipo, pa_char, pa_producto)
                     values ('HABILITAR DESEMBOLSO SOBRANTE', 'HADESO'   , 'C'    , 'N'    , 'CCA')
end 

select *
from cobis..cl_parametro
where pa_nemonico = 'HADESO'


select *
from cobis..cl_parametro
where pa_nemonico = 'FEINSO'

if not exists(select 1 from cobis..cl_parametro where pa_nemonico = 'FEINSO')
begin
   insert into cl_parametro (pa_parametro           , pa_nemonico, pa_tipo, pa_datetime     , pa_producto)
                     values ('FECHA INICIO SOBRANTE', 'FEINSO'   , 'D'    , @w_fecha_proceso, 'CCA')
end

select *
from cobis..cl_parametro
where pa_nemonico = 'FEINSO'
