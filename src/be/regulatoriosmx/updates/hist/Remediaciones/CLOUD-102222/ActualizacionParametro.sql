use cobis
go

declare  @w_pais  int

select @w_pais = pa_pais
from cobis..cl_pais
where pa_descripcion = 'MEXICO'

select  *
from 	cobis..cl_parametro
where pa_nemonico = 'PAIS'

update  cobis..cl_parametro
set pa_smallint   =  	@w_pais
where pa_nemonico = 'PAIS'

select  *
from 	cobis..cl_parametro
where pa_nemonico = 'PAIS'



select en_nacionalidad,*
from cobis..cl_ente
where en_nacionalidad <> @w_pais


update cobis..cl_ente
set en_nacionalidad = @w_pais 
where en_nacionalidad <> @w_pais
