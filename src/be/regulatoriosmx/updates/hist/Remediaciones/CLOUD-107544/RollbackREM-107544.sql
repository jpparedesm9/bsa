
use cob_cartera
go

select * from cob_cartera..ca_garantia_liquida where gl_grupo = 724 and gl_tramite = 6992

update cob_cartera..ca_garantia_liquida  set
gl_pag_estado  = 'PC',
gl_dev_estado  = NULL,
gl_pag_fecha   = NULL, 
gl_pag_valor   = NULL
where gl_grupo = 724 
and gl_tramite = 6992

select * from ca_garantia_liquida where gl_grupo = 724 and gl_tramite = 6992

GO