--GRUPO 144
update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = null
where  gl_grupo = 144
and    gl_id in (8199, 8200, 8201, 8202, 8203, 8204, 8205, 8206)
print 'Fin grupo 144'
go

--GRUPO 255
update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = null
where  gl_grupo = 255
and    gl_id in (10285, 10286, 10287, 10288, 10289, 10290, 10291, 10292, 10293, 10294)
print 'Fin grupo 255'
go

