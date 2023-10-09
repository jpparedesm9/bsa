USE cob_cartera
GO

SELECT 
operacion = op_operacion
INTO #prestamos
FROM ca_operacion 
WHERE op_estado NOT IN (0,3)
and op_operacion = 2861

SELECT
operacion = am_operacion, 
dividendo = am_dividendo, 
cuota = sum(am_cuota)
INTO #cuotas
FROM ca_amortizacion
WHERE am_operacion IN (SELECT operacion FROM #prestamos)
AND   am_concepto  IN ('CAP','INT', 'IVA_INT')
AND   am_dividendo < 16
GROUP BY am_operacion, am_dividendo


SELECT 
operacion = operacion, 
max_cuota = max(cuota), 
min_cuota = min(cuota) 
INTO #prestamos_ajustar
FROM #cuotas
GROUP BY operacion
HAVING abs(max(cuota) - min(cuota)) >= 0.01 


SELECT op_banco, op_nombre, #prestamos_ajustar.* 
FROM #prestamos_ajustar, ca_operacion
WHERE op_operacion = operacion


/**********************************/
/* AJUSTAR PRESTAMOS E HISTORICOS */
/**********************************/

--comentado ya que fue ejecutado la primera vez
/*UPDATE ca_operacion                      SET op_tipo_reduccion  = 'N'
UPDATE ca_operacion_his                  SET oph_tipo_reduccion = 'N'
UPDATE cob_cartera_his..ca_operacion_his SET oph_tipo_reduccion = 'N'
                                                                                                                                                                                                                       
update cobis..cl_parametro set pa_money = 0
where  pa_producto = 'CCA'
and    pa_nemonico = 'SALMIN'
*/	

/**********************************/
/*     REAPLICAR PAGOS            */
/**********************************/

DECLARE 
@w_operacionca  INT,
@w_fecha_valor  DATETIME,
@w_banco        cuenta,
@w_fecha_proc   DATETIME,
@w_error        int


SELECT @w_fecha_proc = fp_fecha
FROM cobis..ba_fecha_proceso


SELECT @w_operacionca = 0, @w_error = 0

WHILE 1=1 BEGIN

   SET ROWCOUNT 1
   
   SELECT @w_operacionca = operacion
   FROM #prestamos_ajustar
   WHERE operacion > @w_operacionca
   ORDER BY operacion
   
   IF @@ROWCOUNT = 0 BEGIN
      SET rowcount 0
      break
   END 
   
   SET ROWCOUNT 0
   
   
   SELECT @w_banco = op_banco,@w_fecha_valor = dateadd(dd,1,op_fecha_ini) FROM ca_operacion WHERE op_operacion = @w_operacionca
   
   PRINT 'PROCESANDO OPERACION: ' + @w_banco 
   
   /*
   SELECT @w_fecha_valor = isnull((min(tr_fecha_ref)-1), '01/01/1900') --un dia antes del pago
   FROM ca_transaccion
   WHERE  tr_operacion = @w_operacionca
   AND    tr_tran = 'PAG'
   AND    tr_estado IN ('ING','CON')
   */
   
   IF @w_fecha_valor = '01/01/1900' BEGIN
      PRINT '---> NO SE ENCONTRO PAGOS QUE REAPLICAR '
      CONTINUE
   END 
   
   PRINT '---> REGRESANDO AL: '+ convert(varchar, @w_fecha_valor, 103)
   
   exec @w_error = sp_fecha_valor 
   @s_date        = @w_fecha_proc,
   @s_user        = 'OPERADOR',
   @s_term        = 'CONSOLA',
   @t_trn         = 7049,
   @i_fecha_mov   = @w_fecha_proc,
   @i_fecha_valor = @w_fecha_valor,
   @i_banco       = @w_banco,
   @i_secuencial  = 1,
   @i_operacion   = 'F'
   
   IF @w_error <> 0 BEGIN
      PRINT '---> ERROR AL REGRESAR A LA FECHA DEL PRIMER PAGO'
      continue
   end
   
   UPDATE ca_abono SET ab_tipo_reduccion = 'N'
   WHERE ab_operacion = @w_operacionca
   
   PRINT '---> AVANZANDO AL: '+ convert(varchar, @w_fecha_proc, 103)
   
   exec @w_error = sp_fecha_valor 
   @s_date        = @w_fecha_proc,
   @s_user        = 'OPERADOR',
   @s_term        = 'CONSOLA',
   @t_trn         = 7049,
   @i_fecha_mov   = @w_fecha_proc,
   @i_fecha_valor = @w_fecha_proc,
   @i_banco       = @w_banco,
   @i_secuencial  = 1,
   @i_operacion   = 'F'
   
   IF @w_error <> 0 BEGIN
      PRINT '---> ERROR AL IR A LA FECHA DE PROCESO'
      continue
   END
   
   PRINT ''
   PRINT ''
   
   
END

go

DROP TABLE #prestamos
DROP TABLE #cuotas
DROP TABLE #prestamos_ajustar


go




