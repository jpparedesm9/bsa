update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = null
where  gl_grupo = 128
and    gl_id in (7649, 7650, 7651, 7652, 7653, 7654, 7655, 7656)
print 'Fin'
go
