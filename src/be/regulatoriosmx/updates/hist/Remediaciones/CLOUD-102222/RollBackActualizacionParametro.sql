use cobis
go

declare  @w_pais  int

select @w_pais = 68

select  *
from 	cobis..cl_parametro
where pa_nemonico = 'PAIS'

update  cobis..cl_parametro
set pa_smallint   =  @w_pais
where pa_nemonico = 'PAIS'

select  *
from 	cobis..cl_parametro
where pa_nemonico = 'PAIS'


