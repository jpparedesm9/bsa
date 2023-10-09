update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = 'PD'
where  gl_grupo = 76
and    gl_id in (5503,5504,5505,5506,5507,5508,5509,5510)
print 'Fin'
go
