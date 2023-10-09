print 'select ca_santander_orden_deposito'
select sod_secuencial, * from cob_cartera..ca_santander_orden_deposito where sod_linea = 29 and sod_banco = '7731' and sod_operacion = -3
select sod_secuencial, * from cob_cartera..ca_santander_orden_deposito where sod_linea = 30 and sod_banco = '7731' and sod_operacion = -3
select sod_secuencial, * from cob_cartera..ca_santander_orden_deposito where sod_linea = 31 and sod_banco = '7731' and sod_operacion = -3
select sod_secuencial, * from cob_cartera..ca_santander_orden_deposito where sod_linea = 32 and sod_banco = '7731' and sod_operacion = -3
select sod_secuencial, * from cob_cartera..ca_santander_orden_deposito where sod_linea = 33 and sod_banco = '7731' and sod_operacion = -3
select sod_secuencial, * from cob_cartera..ca_santander_orden_deposito where sod_linea = 34 and sod_banco = '7731' and sod_operacion = -3
select sod_secuencial, * from cob_cartera..ca_santander_orden_deposito where sod_linea = 35 and sod_banco = '7731' and sod_operacion = -3
select sod_secuencial, * from cob_cartera..ca_santander_orden_deposito where sod_linea = 36 and sod_banco = '7731' and sod_operacion = -3

print 'update ca_santander_orden_deposito'
update cob_cartera..ca_santander_orden_deposito set sod_secuencial = -8042 where sod_linea = 29 and sod_banco = '7731' and sod_operacion = -3
update cob_cartera..ca_santander_orden_deposito set sod_secuencial = -8043 where sod_linea = 30 and sod_banco = '7731' and sod_operacion = -3
update cob_cartera..ca_santander_orden_deposito set sod_secuencial = -8044 where sod_linea = 31 and sod_banco = '7731' and sod_operacion = -3
update cob_cartera..ca_santander_orden_deposito set sod_secuencial = -8045 where sod_linea = 32 and sod_banco = '7731' and sod_operacion = -3
update cob_cartera..ca_santander_orden_deposito set sod_secuencial = -8046 where sod_linea = 33 and sod_banco = '7731' and sod_operacion = -3
update cob_cartera..ca_santander_orden_deposito set sod_secuencial = -8047 where sod_linea = 34 and sod_banco = '7731' and sod_operacion = -3
update cob_cartera..ca_santander_orden_deposito set sod_secuencial = -8048 where sod_linea = 35 and sod_banco = '7731' and sod_operacion = -3
update cob_cartera..ca_santander_orden_deposito set sod_secuencial = -8049 where sod_linea = 36 and sod_banco = '7731' and sod_operacion = -3
go

declare @w_grupo int

select @w_grupo = 791

print 'select cl_grupo'
select * from cobis..cl_grupo where gr_grupo = @w_grupo

print 'update cl_grupo'
update cobis..cl_grupo set gr_nombre = 'INICORNIO' where gr_grupo = @w_grupo

print 'select ca_garantia_liquida'
select * from cob_cartera..ca_garantia_liquida where gl_grupo = @w_grupo and gl_id = 8042
select * from cob_cartera..ca_garantia_liquida where gl_grupo = @w_grupo and gl_id = 8043
select * from cob_cartera..ca_garantia_liquida where gl_grupo = @w_grupo and gl_id = 8044
select * from cob_cartera..ca_garantia_liquida where gl_grupo = @w_grupo and gl_id = 8045
select * from cob_cartera..ca_garantia_liquida where gl_grupo = @w_grupo and gl_id = 8046
select * from cob_cartera..ca_garantia_liquida where gl_grupo = @w_grupo and gl_id = 8047
select * from cob_cartera..ca_garantia_liquida where gl_grupo = @w_grupo and gl_id = 8048
select * from cob_cartera..ca_garantia_liquida where gl_grupo = @w_grupo and gl_id = 8049

print 'update ca_garantia_liquida'
update cob_cartera..ca_garantia_liquida
set    gl_dev_estado = 'PD',
       gl_dev_fecha  = null,
	   gl_pag_valor  = gl_monto_garantia,
	   gl_dev_valor  = 0
where  gl_grupo = @w_grupo
and    gl_id in (8042,8043,8044,8045,8046,8047,8048,8049)
go