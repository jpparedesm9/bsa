
use cobis
go


select * from  cobis..cl_parametro where pa_nemonico = 'CCALCR'

delete cobis..cl_parametro where pa_nemonico = 'CCALCR'

insert into cl_parametro (
        pa_parametro               , pa_nemonico, pa_tipo, pa_tinyint, pa_producto)
values ('CICLOS PARA CANDIDATO LCR', 'CCALCR'   , 'T'    , 4         , 'CCA')


select * from  cobis..cl_parametro where pa_nemonico = 'CCALCR'



select * from  cobis..cl_parametro where pa_nemonico = 'NPINLC'
delete cobis..cl_parametro where pa_nemonico = 'NPINLC'

insert into cl_parametro (
        pa_parametro               , pa_nemonico, pa_tipo, pa_tinyint, pa_producto)
values ('NUM PAGOS INCREMENTO LCR' , 'NPINLC'   , 'T'    , 4         , 'CCA')


select * from  cobis..cl_parametro where pa_nemonico = 'NPINLC'