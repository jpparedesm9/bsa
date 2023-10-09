USE cob_cartera
GO


DECLARE 
@w_fecha_proceso  DATETIME,
@w_error          INT,
@w_secuencial     INT,
@w_secuencial_pag INT,
@w_secuencial_ing INT,
@w_banco          VARCHAR(32),
@w_grupo          INT,
@w_oficina        INT,
@w_ab_estado      VARCHAR(10)

SELECT GETDATE()


select @w_fecha_proceso = fp_fecha
  from cobis..ba_fecha_proceso
    
SELECT @w_secuencial = 0,
       @w_banco = '', 
       @w_oficina = 0

WHILE 1=1
BEGIN

   SELECT TOP 1 
          @w_banco          = to_banco,
          @w_oficina        = to_oficina,
          @w_secuencial     = to_secuencial,
          @w_ab_estado      = to_ab_estado,
          @w_secuencial_pag = to_secuencial_pag,
          @w_secuencial_ing = to_secuencial_ing
     FROM mta_112580_total 
    WHERE to_secuencial > @w_secuencial
      AND to_procesado = 'N'
    ORDER BY to_secuencial ASC 
   
   IF @@ROWCOUNT = 0
   BEGIN
      break   
   END

   BEGIN TRY
   IF @w_ab_estado = 'A'
   BEGIN
	      PRINT '@w_banco1 ' + @w_banco
	      PRINT '@w_secuencial_ing1 ' + convert(VARCHAR,@w_secuencial_ing) + '  PAG ' + convert(VARCHAR,@w_secuencial_pag)
	      exec @w_error = sp_fecha_valor 
		       @s_date       = @w_fecha_proceso,
			   @s_user       = 'usrbatch',
			   @s_term       = 'consola',
			   @t_trn        = 7049,
			   @i_fecha_mov  = @w_fecha_proceso,
			   @i_banco      = @w_banco,
			   @i_secuencial = @w_secuencial_pag,
			   @i_operacion  = 'R',
			   @s_ofi        = @w_oficina
   END
   ELSE
   BEGIN
	   PRINT '@w_banco2 ' + @w_banco
	   PRINT '@w_secuencial_ing2 ' + convert(VARCHAR,@w_secuencial_ing) + '  PAG ' + convert(VARCHAR,@w_secuencial_pag)
	   
	      exec @w_error           = sp_eliminar_pagos
	           @s_ssn             = 101,
	           @s_srv             = 'srv',
	           @s_date            = @w_fecha_proceso,
	           @s_user            = 'usrbatch',
	           @s_term            = 'consola',
	           @s_ofi             = @w_oficina,
	           @i_banco           = @w_banco,
	           @i_operacion       = 'D',
	           @i_secuencial_ing  = @w_secuencial_ing,
	           @i_en_linea        = 'N',
	           @i_pago_ext        = 'N'
   END
	   if @w_error <> 0 
	   BEGIN
	      UPDATE mta_112580_total 
	         SET to_procesado  = 'E1'
		   WHERE to_secuencial = @w_secuencial
	   END
	   ELSE
	      UPDATE mta_112580_total 
	         SET to_procesado = 'S'
	       WHERE to_secuencial = @w_secuencial
			
    END TRY
	BEGIN CATCH   
			UPDATE mta_112580_total 
			   SET to_procesado = 'E2'
			 WHERE to_secuencial = @w_secuencial
	END CATCH   
END -- while
PRINT 'FIN'

SELECT GETDATE()


--validacion
SELECT 'VALIDACION DE PAGOS'
SELECT ab_estado, * 
  from ca_abono,
       ca_abono_det,
       mta_112580_total
 where ab_operacion      = abd_operacion
   AND ab_operacion      = to_operacion 
   AND ab_secuencial_ing = to_secuencial_ing
   AND ab_secuencial_ing = abd_secuencial_ing 

go