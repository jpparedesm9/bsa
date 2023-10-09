use cobis
go

select *
from cobis..cl_parametro
where pa_nemonico = 'FEOLFE'

delete cobis..cl_parametro
where pa_nemonico = 'FEOLFE'

insert into cl_parametro (pa_parametro          , pa_nemonico, pa_tipo, pa_datetime , pa_producto)
                  values ('FECHA OLVIDO FERIADO', 'FEOLFE'   , 'D'    , '2022-11-02', 'ADM')

select *
from cobis..cl_parametro
where pa_nemonico = 'FEOLFE'

-----
select *
from cobis..cl_parametro
where pa_nemonico = 'NDICOM'

delete cobis..cl_parametro
where pa_nemonico = 'NDICOM'

insert into dbo.cl_parametro (pa_parametro               , pa_nemonico, pa_tipo, pa_tinyint, pa_producto)
                      values ('NUMERO DIAS COMPENSATORIO', 'NDICOM'   , 'T'    , 2         , 'ADM')


select *
from cobis..cl_parametro
where pa_nemonico = 'NDICOM'