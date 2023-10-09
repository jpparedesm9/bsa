

use cobis
go


select *
from cobis..cl_parametro
where pa_nemonico = 'NCPPV'


if not exists(select 1
              from cobis..cl_parametro
              where pa_nemonico = 'NCPPV')
begin
     insert into cl_parametro (pa_parametro                    , pa_nemonico, pa_tipo,    pa_int,    pa_producto)
                       values ('NUM CUOTAS PARA PLAZO VENCIDOS', 'NCPPV'    , 'I'    ,    53    ,    'CCA')
end 
go

select *
from cobis..cl_parametro
where pa_nemonico = 'NCPPV'

