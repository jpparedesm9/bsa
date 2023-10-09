
use cob_cartera
go

select * from cob_cartera..ca_garantia_liquida where gl_grupo = 893 and gl_tramite = 8870

update cob_cartera..ca_garantia_liquida  set
gl_pag_estado  = 'PC',
gl_dev_estado  = NULL,
gl_pag_fecha   = NULL , 
gl_pag_valor   = NULL
where gl_grupo = 893 
and gl_tramite = 8870

select * from ca_garantia_liquida where gl_grupo = 893 and gl_tramite = 8870

GO