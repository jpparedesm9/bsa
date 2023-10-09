update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = NULL
where  gl_grupo = 582
and    gl_id in (11337,11338,11339,11340,11341,11342,11343,11344,11345,11346)
AND    gl_tramite=11549

print 'Fin'
go



