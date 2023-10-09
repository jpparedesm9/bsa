--Grupo 8
update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = 'PD'
where  gl_grupo      = 8 
and    gl_tramite    = 2534
and    gl_cliente    in (299, 310, 311, 318, 324, 327, 333, 7883)
and    gl_pag_valor  != 0

--Grupo 10

update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = 'PD'
where  gl_grupo      = 10 
and    gl_tramite    = 2041
and    gl_cliente    in (107, 122, 128, 132, 178, 306, 385, 415)
and    gl_pag_valor  != 0

 
   