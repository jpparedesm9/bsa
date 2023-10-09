update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = 'PD'
where  gl_grupo = 235
and    gl_id in (7463,7464,7465,7466,7467,7468,7469,7470)
AND    gl_cliente IN (6208,6212,6214,6216,6218,6221,6223,6225)
AND    gl_tramite=7175

print 'Fin'
go

