
use cob_cartera
go

select * from cob_cartera..ca_garantia_liquida where gl_grupo = 600 and gl_tramite = 5713

update cob_cartera..ca_garantia_liquida  set
gl_pag_estado='CB',
gl_pag_fecha = '06/22/2018' , 
gl_pag_valor=gl_monto_garantia
where gl_grupo = 600 and gl_tramite = 5713

select * from ca_garantia_liquida where gl_grupo = 600 and gl_tramite = 5713

GO