update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = NULL
where  gl_grupo = 157
and    gl_id in (7563,7564,7565,7566,7567,7568,7569,7570)
AND    gl_cliente IN (4166,4184,4350,4373,4508,4511,4984,19410)
AND    gl_tramite = 6957

print 'Fin'
go