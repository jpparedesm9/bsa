--Remediacion caso 108105
--Grupo 71
update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = 'PD'
where  gl_grupo      = 71 
and    gl_tramite    = 4479
and    gl_pag_valor  != 0

   