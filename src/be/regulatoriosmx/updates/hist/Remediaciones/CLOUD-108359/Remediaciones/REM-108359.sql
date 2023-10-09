--Remediacion caso 108359
--Grupo 240
update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = 'PD'
where  gl_grupo      = 240
and    gl_tramite    = 9336
and    gl_pag_valor  != 0

