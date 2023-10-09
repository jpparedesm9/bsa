update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = 'PD'
where  gl_grupo = 254
and    gl_id in (11255,11254,10997,10995,10994,10993,10991,10989)
go

update cob_cartera..ca_santander_orden_deposito
set sod_secuencial = -10990
where sod_secuencial = 10990 and sod_consecutivo = 10
go
