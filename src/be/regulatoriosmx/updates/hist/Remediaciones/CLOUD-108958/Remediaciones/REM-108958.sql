--Remediacion caso 108958
--Grupo 268
update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = 'PD'
where  gl_grupo      = 268
and    gl_tramite    = 9678
and    gl_pag_valor  != 0

