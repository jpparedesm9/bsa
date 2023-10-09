USE cob_cartera
GO

UPDATE ca_corresponsal_trn 
  SET co_estado    = 'I', 
      co_error_id  = 0,  
      co_error_msg = ''
where co_codigo_interno = 72119
  AND co_estado = 'P'
  AND co_accion = 'I'
  AND co_tipo   = 'PG'
   	
DELETE ca_corresponsal_det 
  from ca_corresponsal_trn 
 where cd_secuencial = co_secuencial 
   and co_codigo_interno = 72119
   AND co_estado = 'I'
   AND co_accion = 'I'
   AND co_tipo   = 'PG' 
      
         
   /*
SELECT getdate()

DROP TABLE #operaciones_padre
GO

DECLARE @w_operacion   INT
--temporal
 UPDATE ca_corresponsal_trn 
      SET co_estado    = 'P', 
          co_error_id  = 0,  
          co_error_msg = ''
    where co_codigo_interno =200204-- @w_operacion

--temporal	  
	  
SELECT DISTINCT 'operacion'  = to_operacion_padre
  INTO #operaciones_padre
  FROM mta_112580_total
  where to_operacion_padre<>200204
 order by to_operacion_padre 

SELECT @w_operacion = 0

WHILE 1=1
BEGIN
   SELECT top 1 @w_operacion   = operacion
     FROM #operaciones_padre
    WHERE operacion > @w_operacion
    ORDER BY operacion

   IF @@ROWCOUNT = 0
   BEGIN
      break   
   END

   UPDATE ca_corresponsal_trn 
      SET co_estado    = 'I', 
          co_error_id  = 0,  
          co_error_msg = ''
    where co_codigo_interno = @w_operacion
      AND co_estado = 'P'
      AND co_accion = 'I'
      AND co_tipo   = 'PG'

   SELECT * 
     from ca_corresponsal_trn 
    where co_codigo_interno = @w_operacion
   
   	
   DELETE ca_corresponsal_det 
     from ca_corresponsal_trn 
    where cd_secuencial = co_secuencial 
      and co_codigo_interno = @w_operacion
      AND co_estado = 'I'
      AND co_accion = 'I'
      AND co_tipo   = 'PG' 
   	
   SELECT DISTINCT cd.* 
     FROM ca_corresponsal_det cd, 
          ca_corresponsal_trn 
    where cd_secuencial = co_secuencial 
      AND co_codigo_interno = @w_operacion
      AND co_estado = 'I'
      AND co_accion = 'I'
      AND co_tipo   = 'PG'

END 
SELECT getdate()
*/
go



