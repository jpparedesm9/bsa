--Remediacion caso 108311
--Grupo 192
update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = 'PD'
where  gl_grupo      = 192
and    gl_tramite    = 23763
and    gl_pag_valor  != 0

