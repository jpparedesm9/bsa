
/* 
BOMBONES BUGAMBILIAS ID: 1350 
*/
update cob_cartera..ca_garantia_liquida
set  gl_pag_valor  = gl_dev_valor ,
     gl_dev_estado = 'PD',
     gl_dev_fecha  = null 
where gl_grupo   = 1350
and   gl_tramite = 14441


update cob_cartera..ca_garantia_liquida
set  gl_dev_valor = null
where gl_grupo = 1350
and   gl_tramite = 14441
/* 
1234	MUJERES DIVINAS
*/

update cob_cartera..ca_garantia_liquida
set  gl_pag_valor  = gl_dev_valor ,
     gl_dev_estado = 'PD',
     gl_dev_fecha  = null 
where gl_grupo = 1234
and  gl_tramite= 13193



update cob_cartera..ca_garantia_liquida
set  gl_dev_valor = null
where gl_grupo = 1234
and  gl_tramite= 13193

/*
Grupo: ROSAS ROJAS
ID: 1304
*/

update cob_cartera..ca_garantia_liquida
set  gl_pag_valor  = gl_dev_valor ,
     gl_dev_estado = 'PD',
     gl_dev_fecha  = null 
where gl_grupo = 1304
and  gl_tramite= 13925



update cob_cartera..ca_garantia_liquida
set  gl_dev_valor = null
where gl_grupo = 1304
and  gl_tramite= 13925
