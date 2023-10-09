
select *
from cob_cartera..ca_garantia_liquida
where gl_grupo = 1377


update cob_cartera..ca_garantia_liquida
set gl_pag_valor  = gl_monto_garantia,
    gl_dev_estado = 'PD'  
where gl_grupo    = 1377
and   gl_tramite  = 14862


update cob_cartera..ca_garantia_liquida
set gl_dev_fecha = null,
    gl_dev_valor = null
where gl_grupo   = 1377 
and   gl_tramite = 14862

   
select *
from cob_cartera..ca_garantia_liquida
where gl_grupo = 1377

