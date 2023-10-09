
use cob_cartera
go

select * from cob_cartera..ca_garantia_liquida where gl_grupo = 893 and gl_tramite = 8870

update cob_cartera..ca_garantia_liquida  set
gl_pag_estado  = 'CB',
gl_dev_estado  = 'PD',
gl_pag_fecha   = '07/20/2018' , 
gl_pag_valor   = gl_monto_garantia
where gl_grupo = 893 
and gl_tramite = 8870

select * from ca_garantia_liquida where gl_grupo = 893 and gl_tramite = 8870

GO