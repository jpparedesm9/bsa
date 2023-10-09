USE cob_cartera
GO

update ca_det_trn set dtr_monto = dtr_monto  -199.88, dtr_monto_mn = dtr_monto_mn - 199.88 where dtr_operacion = 9046 and dtr_secuencial = 79 and dtr_concepto in ('VAC0')
update ca_det_trn set dtr_monto = dtr_monto  -199.90, dtr_monto_mn = dtr_monto_mn - 199.90 where dtr_operacion = 9049 and dtr_secuencial = 79 and dtr_concepto in ('VAC0')
update ca_det_trn set dtr_monto = dtr_monto  -166.03, dtr_monto_mn = dtr_monto_mn - 166.03 where dtr_operacion = 9052 and dtr_secuencial = 93 and dtr_concepto in ('VAC0')
update ca_det_trn set dtr_monto = dtr_monto  -132.92, dtr_monto_mn = dtr_monto_mn - 132.92 where dtr_operacion = 9055 and dtr_secuencial = 93 and dtr_concepto in ('VAC0')
update ca_det_trn set dtr_monto = dtr_monto  -199.90, dtr_monto_mn = dtr_monto_mn - 199.90 where dtr_operacion = 9058 and dtr_secuencial = 79 and dtr_concepto in ('VAC0')
update ca_det_trn set dtr_monto = dtr_monto  -132.92, dtr_monto_mn = dtr_monto_mn - 132.92 where dtr_operacion = 9061 and dtr_secuencial = 93 and dtr_concepto in ('VAC0')
update ca_det_trn set dtr_monto = dtr_monto  -199.90, dtr_monto_mn = dtr_monto_mn - 199.90 where dtr_operacion = 9064 and dtr_secuencial = 79 and dtr_concepto in ('VAC0')
update ca_det_trn set dtr_monto = dtr_monto  -166.03, dtr_monto_mn = dtr_monto_mn - 166.03 where dtr_operacion = 9067 and dtr_secuencial = 93 and dtr_concepto in ('VAC0')

delete from ca_det_trn  where dtr_operacion = 9046 and dtr_secuencial = 79 and dtr_concepto = 'SOBRANTE'
delete from ca_det_trn  where dtr_operacion = 9049 and dtr_secuencial = 79 and dtr_concepto = 'SOBRANTE'
delete from ca_det_trn  where dtr_operacion = 9052 and dtr_secuencial = 93 and dtr_concepto = 'SOBRANTE'
delete from ca_det_trn  where dtr_operacion = 9055 and dtr_secuencial = 93 and dtr_concepto = 'SOBRANTE'
delete from ca_det_trn  where dtr_operacion = 9058 and dtr_secuencial = 79 and dtr_concepto = 'SOBRANTE'
delete from ca_det_trn  where dtr_operacion = 9061 and dtr_secuencial = 93 and dtr_concepto = 'SOBRANTE'
delete from ca_det_trn  where dtr_operacion = 9064 and dtr_secuencial = 79 and dtr_concepto = 'SOBRANTE'
delete from ca_det_trn  where dtr_operacion = 9067 and dtr_secuencial = 93 and dtr_concepto = 'SOBRANTE'

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
   @i_secuencial  = 7,
   @i_observacion = 'OAB: pago duplicado caso 103376',
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
   @i_secuencial  = 7,
   @i_observacion = 'OAB: pago duplicado caso 103376',
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
   @i_secuencial  = 7,
   @i_observacion = 'OAB: pago duplicado caso 103376',
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
   @i_secuencial  = 7,
   @i_observacion = 'OAB: pago duplicado caso 103376',
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
   @i_secuencial  = 7,
   @i_observacion = 'OAB: pago duplicado caso 103376',
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
   @i_secuencial  = 7,
   @i_observacion = 'OAB: pago duplicado caso 103376',
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
   @i_secuencial  = 7,
   @i_observacion = 'OAB: pago duplicado caso 103376',
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
   @i_secuencial  = 7,
   @i_observacion = 'OAB: pago duplicado caso 103376',
   @i_operacion   = 'R'


GO



--//////////////////////////////////////////////////////////////////





USE cob_cartera
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
   @i_banco       = '223790000209',
   @i_fecha_mov   = @s_date,
   @i_fecha_valor = @s_date,
   @i_secuencial  = 1,
   @i_operacion   = 'F'



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
   @i_fecha_mov   = @s_date,
   @i_fecha_valor = @s_date,
   @i_secuencial  = 1,
   @i_operacion   = 'F'


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
   @i_fecha_mov   = @s_date,
   @i_fecha_valor = @s_date,
   @i_secuencial  = 1,
   @i_operacion   = 'F'


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
   @i_fecha_mov   = @s_date,
   @i_fecha_valor = @s_date,
   @i_secuencial  = 1,
   @i_operacion   = 'F'


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
   @i_fecha_mov   = @s_date,
   @i_fecha_valor = @s_date,
   @i_secuencial  = 1,
   @i_operacion   = 'F'


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
   @i_fecha_mov   = @s_date,
   @i_fecha_valor = @s_date,
   @i_secuencial  = 1,
   @i_operacion   = 'F'


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
   @i_fecha_mov   = @s_date,
   @i_fecha_valor = @s_date,
   @i_secuencial  = 1,
   @i_operacion   = 'F'


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
   @i_fecha_mov   = @s_date,
   @i_fecha_valor = @s_date,
   @i_secuencial  = 1,
   @i_operacion   = 'F'


GO


