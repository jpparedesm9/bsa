
use cobis

go

select *
from cl_parametro
where pa_nemonico = 'POCODE'

if not exists (select 1 from cl_parametro where pa_nemonico = 'POCODE')
begin
   insert into cl_parametro (
            pa_parametro                          , pa_nemonico, pa_tipo, pa_float, pa_producto)
   values ('PORCENTAJE CONDONACION DESPLAZAMIENTO', 'POCODE'   , 'F'    , 0.5     , 'CCA')
end 

select *
from cl_parametro
where pa_nemonico = 'POCODE'

