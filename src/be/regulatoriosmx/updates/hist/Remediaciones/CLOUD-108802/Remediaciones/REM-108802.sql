--Remediacion caso 108802
--Grupo 182
update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = 'PD'
where  gl_grupo      = 182
and    gl_tramite    = 7699
and    gl_pag_valor  != 0

