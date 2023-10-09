print 'select ca_santander_orden_deposito'
select sod_secuencial, * from cob_cartera..ca_santander_orden_deposito where sod_linea = 38 and sod_banco = '6979' and sod_operacion = -3
select sod_secuencial, * from cob_cartera..ca_santander_orden_deposito where sod_linea = 39 and sod_banco = '6979' and sod_operacion = -3
select sod_secuencial, * from cob_cartera..ca_santander_orden_deposito where sod_linea = 40 and sod_banco = '6979' and sod_operacion = -3
select sod_secuencial, * from cob_cartera..ca_santander_orden_deposito where sod_linea = 41 and sod_banco = '6979' and sod_operacion = -3
select sod_secuencial, * from cob_cartera..ca_santander_orden_deposito where sod_linea = 42 and sod_banco = '6979' and sod_operacion = -3
select sod_secuencial, * from cob_cartera..ca_santander_orden_deposito where sod_linea = 43 and sod_banco = '6979' and sod_operacion = -3
select sod_secuencial, * from cob_cartera..ca_santander_orden_deposito where sod_linea = 44 and sod_banco = '6979' and sod_operacion = -3
select sod_secuencial, * from cob_cartera..ca_santander_orden_deposito where sod_linea = 45 and sod_banco = '6979' and sod_operacion = -3

print 'update ca_santander_orden_deposito'
update cob_cartera..ca_santander_orden_deposito set sod_secuencial = 7266 where sod_linea = 38 and sod_banco = '6979' and sod_operacion = -3
update cob_cartera..ca_santander_orden_deposito set sod_secuencial = 7267 where sod_linea = 39 and sod_banco = '6979' and sod_operacion = -3
update cob_cartera..ca_santander_orden_deposito set sod_secuencial = 7268 where sod_linea = 40 and sod_banco = '6979' and sod_operacion = -3
update cob_cartera..ca_santander_orden_deposito set sod_secuencial = 7269 where sod_linea = 41 and sod_banco = '6979' and sod_operacion = -3
update cob_cartera..ca_santander_orden_deposito set sod_secuencial = 7270 where sod_linea = 42 and sod_banco = '6979' and sod_operacion = -3
update cob_cartera..ca_santander_orden_deposito set sod_secuencial = 7271 where sod_linea = 43 and sod_banco = '6979' and sod_operacion = -3
update cob_cartera..ca_santander_orden_deposito set sod_secuencial = 7272 where sod_linea = 44 and sod_banco = '6979' and sod_operacion = -3
update cob_cartera..ca_santander_orden_deposito set sod_secuencial = 7273 where sod_linea = 45 and sod_banco = '6979' and sod_operacion = -3

print 'select cl_grupo'
select * from cobis..cl_grupo where gr_grupo = 723

print 'update cl_grupo'
update cobis..cl_grupo set gr_nombre = ' COLIBRI' where gr_grupo = 723
go

print 'select ca_garantia_liquida'
select * from cob_cartera..ca_garantia_liquida where gl_grupo = 723 and gl_id = 7266
select * from cob_cartera..ca_garantia_liquida where gl_grupo = 723 and gl_id = 7267
select * from cob_cartera..ca_garantia_liquida where gl_grupo = 723 and gl_id = 7268
select * from cob_cartera..ca_garantia_liquida where gl_grupo = 723 and gl_id = 7269
select * from cob_cartera..ca_garantia_liquida where gl_grupo = 723 and gl_id = 7270
select * from cob_cartera..ca_garantia_liquida where gl_grupo = 723 and gl_id = 7271
select * from cob_cartera..ca_garantia_liquida where gl_grupo = 723 and gl_id = 7272
select * from cob_cartera..ca_garantia_liquida where gl_grupo = 723 and gl_id = 7273

print 'update ca_garantia_liquida'
update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = 'D',
       gl_dev_fecha  = '10/17/2018',
	   gl_pag_valor  = 0,
	   gl_dev_valor  = 24.26
where  gl_grupo = 723
and    gl_id in (7266)

update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = 'D',
       gl_dev_fecha  = '10/17/2018',
	   gl_pag_valor  = 0,
	   gl_dev_valor  = 24.29
where  gl_grupo = 723
and    gl_id in (7267)

update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = 'D',
       gl_dev_fecha  = '10/17/2018',
	   gl_pag_valor  = 0,
	   gl_dev_valor  = 22.79
where  gl_grupo = 723
and    gl_id in (7268,7269,7270)

update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = 'D',
       gl_dev_fecha  = '10/17/2018',
	   gl_pag_valor  = 0,
	   gl_dev_valor  = 24.29
where  gl_grupo = 723
and    gl_id in (7271)

update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = 'D',
       gl_dev_fecha  = '10/17/2018',
	   gl_pag_valor  = 0,
	   gl_dev_valor  = 19.82
where  gl_grupo = 723
and    gl_id in (7272)

update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = 'D',
       gl_dev_fecha  = '10/17/2018',
	   gl_pag_valor  = 0,
	   gl_dev_valor  = 24.29
where  gl_grupo = 723
and    gl_id in (7273)

go