--Grupo 37
update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = 'PD'
where  gl_grupo      = 37 
and    gl_tramite    = 4415
and    gl_pag_valor  != 0
and    gl_pag_valor  is not null

   




