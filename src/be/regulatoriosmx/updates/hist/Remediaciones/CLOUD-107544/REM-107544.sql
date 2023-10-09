
use cob_cartera
go

select * from cob_cartera..ca_garantia_liquida where gl_grupo = 724 and gl_tramite = 6992

update cob_cartera..ca_garantia_liquida  set
gl_pag_estado  = 'CB',
gl_dev_estado  = 'PD',
gl_pag_fecha   = gl_fecha_vencimiento, 
gl_pag_valor   = gl_monto_garantia
where gl_grupo = 724 
and gl_tramite = 6992

select * from ca_garantia_liquida where gl_grupo = 724 and gl_tramite = 6992

GO