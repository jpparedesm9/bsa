use cobis
go


select *
from cobis..cl_parametro
where pa_nemonico = 'HAPRAN'


if not exists(select 1 from cobis..cl_parametro where pa_nemonico = 'HAPRAN')
begin
   insert into cl_parametro (pa_parametro                , pa_nemonico, pa_tipo, pa_char,  pa_producto)
                     values ('HABILITAR PRODUCTO ANIMATE', 'HAPRAN'   , 'C'    , 'N'    ,  'CCA'      )
end

select *
from cobis..cl_parametro
where pa_nemonico = 'HAPRAN'
