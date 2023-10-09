use cobis
go

select *
from cobis..cl_parametro
where pa_nemonico = 'VASOCO'

if not exists(select 1
             from cobis..cl_parametro
             where pa_nemonico = 'VASOCO')
begin
   insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
   values ('VALIDA SOCIO COMERCIAL', 'VASOCO', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'ADM')
end

select *
from cobis..cl_parametro
where pa_nemonico = 'VASOCO'

