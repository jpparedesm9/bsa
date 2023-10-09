--Remediacion caso 108839
--Grupo 205
update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = 'PD'
where  gl_grupo      = 205
and    gl_tramite    = 1530
and    gl_pag_valor  != 0

