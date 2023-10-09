use cobis
go

select *
from cobis..cl_parametro
where pa_nemonico = 'DVLCR'

if not exists (select 1
               from cobis..cl_parametro
               where pa_nemonico = 'DVLCR')
begin
     insert into cobis..cl_parametro (pa_parametro          , pa_nemonico, pa_tipo,  pa_tinyint, pa_producto)
                              values ('DIAS VENCIMIENTO LCR', 'DVLCR'    , 'T'    ,  60        , 'CCA')

end


select *
from cobis..cl_parametro
where pa_nemonico = 'DVLCR'