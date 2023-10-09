DECLARE @w_fecha_proceso DATETIME, @w_fecha_regresa DATETIME, @w_banco VARCHAR(20), 
        @w_operacion INT, @w_contador      INT
        
SELECT @w_fecha_proceso = fp_fecha FROM cobis..ba_fecha_proceso
SELECT @w_fecha_regresa = '06/10/2020'

update cobis..cl_parametro set 
pa_char = 'N'
where pa_nemonico = 'PAVACA'
and pa_producto = 'CCA'

--SELECT * FROM cob_credito..cr_tramite_grupal WHERE tg_grupo = 13496 AND tg_prestamo <> tg_referencia_grupal---tramite: 224459
SELECT operacion = tg_operacion, 
       banco = tg_prestamo
INTO #operaciones
FROM cob_credito..cr_tramite_grupal 
WHERE tg_grupo = 13496 AND tg_tramite = 224459 
--AND tg_operacion = 1070274 -- borrar

SELECT @w_contador = 0, @w_operacion = 0
WHILE (exists(select 1 from #operaciones where operacion > @w_operacion))
BEGIN
   
    SELECT @w_contador = @w_contador + 1

    select top 1
	      @w_operacion  = operacion,
	      @w_banco = banco
	 from #operaciones
	where operacion > @w_operacion
	order by operacion
	
    if (@@rowcount = 0)
	BREAK

	print '--INI REVERSA Operacion----:' + convert(VARCHAR,@w_operacion) +
	                    '----@w_banco:' + @w_banco

    ---Llevar operaciones a fecha de inicio    
 --BEGIN tran  ---borrar-achp
    BEGIN TRY
       exec sp_fecha_valor 
            @s_date        = @w_fecha_proceso,
            @s_user        = 'usrbatch',
            @s_term        = 'consola',
            @s_ofi         = 1037,
            @t_trn         = 7049,
            @i_fecha_mov   = @w_fecha_proceso,
            @i_fecha_valor = @w_fecha_regresa,
            @i_banco       = @w_banco,
            @i_operacion   = 'F'
            
       SELECT 'antes' = 'antes', op_fecha_ult_proceso, op_estado, * FROM cob_cartera..ca_operacion WHERE op_operacion = @w_operacion    
       --SELECT 'antes' = 'antes', di_estado, * FROM cob_cartera..ca_dividendo WHERE di_operacion = @w_operacion
       --SELECT 'antes' = 'antes', am_estado, * FROM cob_cartera..ca_amortizacion WHERE am_operacion = @w_operacion
    
       --SELECT 'antes' = 'antes', * FROM cob_cartera..ca_abono WHERE ab_operacion = @w_operacion AND ab_secuencial_ing IN (99,103)--(95)--,99,(103)
       UPDATE cob_cartera..ca_abono SET ab_estado = 'E' WHERE ab_operacion = @w_operacion AND ab_secuencial_ing IN (99,103)
    
       exec sp_fecha_valor 
            @s_date        = @w_fecha_proceso,
            @s_user        = 'usrbatch',
            @s_term        = 'consola',
            @s_ofi         = 1037,
            @t_trn         = 7049,
            @i_fecha_mov   = @w_fecha_proceso,
            @i_fecha_valor = @w_fecha_proceso,
            @i_banco       = @w_banco,
            @i_operacion   = 'F' 
    
       SELECT 'despues' = 'despues', op_fecha_ult_proceso, op_estado, * FROM cob_cartera..ca_operacion WHERE op_operacion = @w_operacion    
       --SELECT 'despues' = 'despues', di_estado, * FROM cob_cartera..ca_dividendo WHERE di_operacion = @w_operacion
       --SELECT 'despues' = 'despues', am_estado, * FROM cob_cartera..ca_amortizacion WHERE am_operacion = @w_operacion
    END TRY
    BEGIN CATCH 	    
    	select 'FALLA  REVERSA Operacion:----' = convert(VARCHAR,@w_operacion), 
               '----@w_banco:' = @w_banco
    END  CATCH	 
    
--  ROLLBACK   ----borrar-achp
END 


DROP TABLE #operaciones

--validar si tiene sobrantes
/*SELECT * FROM  cob_cartera..ca_abono, cob_cartera..ca_abono_det
WHERE ab_operacion = abd_operacion 
AND ab_secuencial_ing = abd_secuencial_ing---'usrcond'
AND ab_operacion = 1070274
AND abd_concepto = 'SOBRANTE' (95)--,99,(103), ver para cada pago, en este ejemplo coinicen*/

update cobis..cl_parametro set 
pa_char = 'S'
where pa_nemonico = 'PAVACA'
and pa_producto = 'CCA'
GO

PRINT 'TERMINO script 1'