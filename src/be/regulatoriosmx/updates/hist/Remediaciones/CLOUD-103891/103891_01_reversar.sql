USE cob_cartera
GO

update ca_det_trn set dtr_monto = dtr_monto  -3.69, dtr_monto_mn = dtr_monto_mn - 3.69 where dtr_operacion = 9046 and dtr_secuencial = 143 and dtr_concepto in ('VAC0')
update ca_det_trn set dtr_monto = dtr_monto  -3.69, dtr_monto_mn = dtr_monto_mn - 3.69 where dtr_operacion = 9049 and dtr_secuencial = 143 and dtr_concepto in ('VAC0')
update ca_det_trn set dtr_monto = dtr_monto  -3.06, dtr_monto_mn = dtr_monto_mn - 3.06 where dtr_operacion = 9052 and dtr_secuencial = 183 and dtr_concepto in ('VAC0')
update ca_det_trn set dtr_monto = dtr_monto  -2.45, dtr_monto_mn = dtr_monto_mn - 2.45 where dtr_operacion = 9055 and dtr_secuencial = 183 and dtr_concepto in ('VAC0')
update ca_det_trn set dtr_monto = dtr_monto  -3.69, dtr_monto_mn = dtr_monto_mn - 3.69 where dtr_operacion = 9058 and dtr_secuencial = 143 and dtr_concepto in ('VAC0')
update ca_det_trn set dtr_monto = dtr_monto  -2.45, dtr_monto_mn = dtr_monto_mn - 2.45 where dtr_operacion = 9061 and dtr_secuencial = 183 and dtr_concepto in ('VAC0')
update ca_det_trn set dtr_monto = dtr_monto  -3.69, dtr_monto_mn = dtr_monto_mn - 3.69 where dtr_operacion = 9064 and dtr_secuencial = 143 and dtr_concepto in ('VAC0')
update ca_det_trn set dtr_monto = dtr_monto  -3.06, dtr_monto_mn = dtr_monto_mn - 3.06 where dtr_operacion = 9067 and dtr_secuencial = 183 and dtr_concepto in ('VAC0')

delete from ca_det_trn  where dtr_operacion = 9046 and dtr_secuencial = 143 and dtr_concepto = 'SOBRANTE'
delete from ca_det_trn  where dtr_operacion = 9049 and dtr_secuencial = 143 and dtr_concepto = 'SOBRANTE'
delete from ca_det_trn  where dtr_operacion = 9052 and dtr_secuencial = 183 and dtr_concepto = 'SOBRANTE'
delete from ca_det_trn  where dtr_operacion = 9055 and dtr_secuencial = 183 and dtr_concepto = 'SOBRANTE'
delete from ca_det_trn  where dtr_operacion = 9058 and dtr_secuencial = 143 and dtr_concepto = 'SOBRANTE'
delete from ca_det_trn  where dtr_operacion = 9061 and dtr_secuencial = 183 and dtr_concepto = 'SOBRANTE'
delete from ca_det_trn  where dtr_operacion = 9064 and dtr_secuencial = 143 and dtr_concepto = 'SOBRANTE'
delete from ca_det_trn  where dtr_operacion = 9067 and dtr_secuencial = 183 and dtr_concepto = 'SOBRANTE'

go



DECLARE
@s_date  DATETIME

SELECT @s_date = fp_fecha FROM cobis..ba_fecha_proceso
SELECT @s_date 

   exec  sp_fecha_valor 
   @s_date        = @s_date,
   @s_user        = 'OPERADOR',
   @s_term        = 'CONSOLA',
   @t_trn         = 7049,
   @i_banco       = '223790000209',
   @i_secuencial  = 143,
   @i_observacion = 'OAB: pago duplicado caso 103891',
   @i_operacion   = 'R'

GO
DECLARE
@s_date  DATETIME

SELECT @s_date = fp_fecha FROM cobis..ba_fecha_proceso
SELECT @s_date 

   exec  sp_fecha_valor 
   @s_date        = @s_date,
   @s_user        = 'OPERADOR',
   @s_term        = 'CONSOLA',
   @t_trn         = 7049,
   @i_banco       = '223790000217',
   @i_secuencial  = 143,
   @i_observacion = 'OAB: pago duplicado caso 103891',
   @i_operacion   = 'R'


GO
DECLARE
@s_date  DATETIME

SELECT @s_date = fp_fecha FROM cobis..ba_fecha_proceso
SELECT @s_date 

   exec  sp_fecha_valor 
   @s_date        = @s_date,
   @s_user        = 'OPERADOR',
   @s_term        = 'CONSOLA',
   @t_trn         = 7049,
   @i_banco       = '223790000225',
   @i_secuencial  = 183,
   @i_observacion = 'OAB: pago duplicado caso 103891',
   @i_operacion   = 'R'


GO

DECLARE
@s_date  DATETIME

SELECT @s_date = fp_fecha FROM cobis..ba_fecha_proceso
SELECT @s_date 

   exec  sp_fecha_valor 
   @s_date        = @s_date,
   @s_user        = 'OPERADOR',
   @s_term        = 'CONSOLA',
   @t_trn         = 7049,
   @i_banco       = '223790000233',
   @i_secuencial  = 183,
   @i_observacion = 'OAB: pago duplicado caso 103891',
   @i_operacion   = 'R'


GO

DECLARE
@s_date  DATETIME

SELECT @s_date = fp_fecha FROM cobis..ba_fecha_proceso
SELECT @s_date 

   exec  sp_fecha_valor 
   @s_date        = @s_date,
   @s_user        = 'OPERADOR',
   @s_term        = 'CONSOLA',
   @t_trn         = 7049,
   @i_banco       = '223790000241',
   @i_secuencial  = 143,
   @i_observacion = 'OAB: pago duplicado caso 103891',
   @i_operacion   = 'R'


GO

DECLARE
@s_date  DATETIME

SELECT @s_date = fp_fecha FROM cobis..ba_fecha_proceso
SELECT @s_date 

   exec  sp_fecha_valor 
   @s_date        = @s_date,
   @s_user        = 'OPERADOR',
   @s_term        = 'CONSOLA',
   @t_trn         = 7049,
   @i_banco       = '223790000258',
   @i_secuencial  = 183,
   @i_observacion = 'OAB: pago duplicado caso 103891',
   @i_operacion   = 'R'


GO

DECLARE
@s_date  DATETIME

SELECT @s_date = fp_fecha FROM cobis..ba_fecha_proceso
SELECT @s_date 

   exec  sp_fecha_valor 
   @s_date        = @s_date,
   @s_user        = 'OPERADOR',
   @s_term        = 'CONSOLA',
   @t_trn         = 7049,
   @i_banco       = '223790000266',
   @i_secuencial  = 143,
   @i_observacion = 'OAB: pago duplicado caso 103891',
   @i_operacion   = 'R'


GO

DECLARE
@s_date  DATETIME

SELECT @s_date = fp_fecha FROM cobis..ba_fecha_proceso
SELECT @s_date 

   exec  sp_fecha_valor 
   @s_date        = @s_date,
   @s_user        = 'OPERADOR',
   @s_term        = 'CONSOLA',
   @t_trn         = 7049,
   @i_banco       = '223790000274',
   @i_secuencial  = 183,
   @i_observacion = 'OAB: pago duplicado caso 103891',
   @i_operacion   = 'R'


GO



--//////////////////////////////////////////////////////////////////

-- CAMBIO FECHA DE APLICACION DE PAGO CORRESPONSAL

USE cob_cartera
GO


SELECT 'grupo'= convert(INT, substring(co_referencia,3,12)),* FROM ca_corresponsal_trn
WHERE co_referencia LIKE 'PG%'
AND co_secuencial	= 10942
AND co_corresponsal = 'SANTANDER'
AND co_fecha_proceso = '08/07/2018'
AND co_referencia = 'PG0000000002277'


UPDATE ca_corresponsal_trn SET 
	co_fecha_valor = '07/27/2018',
	co_estado = 'I'
WHERE co_referencia LIKE 'PG%'
AND co_secuencial	= 10942
AND co_corresponsal = 'SANTANDER'
AND co_fecha_proceso = '08/07/2018'
AND co_referencia = 'PG0000000002277'


SELECT 'grupo'= convert(INT, substring(co_referencia,3,12)),* FROM ca_corresponsal_trn
WHERE co_referencia LIKE 'PG%'
AND co_secuencial	= 10942
AND co_corresponsal = 'SANTANDER'
AND co_fecha_proceso = '08/07/2018'
AND co_referencia = 'PG0000000002277'


go


USE cob_cartera
GO


exec sp_pagos_corresponsal_batch
@i_param1         = 'B'

go






