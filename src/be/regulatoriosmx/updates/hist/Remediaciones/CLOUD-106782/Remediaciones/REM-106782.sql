update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = 'PD'
where  gl_grupo = 43
and    gl_id in (5411,5412,5413,5414,5415,5416,5417,5418)
AND    gl_cliente IN (1418,1426,1431,1766,1793,1920,13260,14315)
AND    gl_tramite = 3841

print 'Fin'
go

