update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = NULL
where  gl_grupo = 117
and    gl_id in (6837,6838,6839,6840,6841,6842,6843,6844)
AND    gl_cliente IN (2700,2708,2712,2718,3279,3280,3286,14632)
AND    gl_tramite = 5420

print 'Fin'
go