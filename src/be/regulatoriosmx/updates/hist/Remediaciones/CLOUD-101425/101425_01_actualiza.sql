USE cob_cartera
go

SELECT ' ------ DATOS ANTES ------ '
SELECT * FROM cob_cartera..ca_santander_orden_deposito 
where sod_operacion = -3
and sod_secuencial  = 5448
and sod_tipo = 'GAR'

SELECT ' ------ ACTUALIZANDO ------ '

UPDATE cob_cartera..ca_santander_orden_deposito SET sod_secuencial = -1*sod_secuencial
where sod_operacion = -3
and sod_secuencial  = 5448
and sod_tipo = 'GAR'


SELECT ' ------ DATOS DESPUES ------ '

SELECT * FROM cob_cartera..ca_santander_orden_deposito 
where sod_operacion = -3
and abs(sod_secuencial)  = 5448
and sod_tipo = 'GAR'


GO


