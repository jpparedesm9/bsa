

DECLARE @w_fecha_proceso DATETIME,
@w_error INT,
@w_secuencial INT,
@w_secuencial_pag INT,
@w_secuencial_ing INT,
@w_banco   VARCHAR(32),
@w_grupo   INT,
@w_oficina INT,
@w_ab_estado VARCHAR(10)

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso


   
    
SELECT @w_secuencial = 0
SELECT @w_banco = '', @w_oficina = 0


WHILE 1=1
BEGIN

   SELECT TOP 1 
    @w_banco = re_banco,
    @w_oficina = re_oficina,
    @w_secuencial = re_secuencial,
    @w_ab_estado  = re_ab_estado,
    @w_secuencial_pag = re_secuencial_pag,
    @w_secuencial_ing = re_secuencial_ing
   FROM mta_111795_rev 
   WHERE re_secuencial > @w_secuencial
   AND re_procesado = 'N'
   ORDER BY re_secuencial ASC 
   
   IF @@ROWCOUNT = 0
   BEGIN
      break   
   END


   --BEGIN TRY
    IF @w_ab_estado = 'A'
    BEGIN
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

      exec @w_error      = sp_eliminar_pagos
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
			
				UPDATE  mta_111795_rev SET re_procesado = 'E1'
				WHERE re_secuencial = @w_secuencial
			END
				UPDATE  mta_111795_rev SET re_procesado = 'S'
				WHERE re_secuencial = @w_secuencial
			
    /*END TRY
	BEGIN CATCH   
			UPDATE  mta_111795_rev SET re_procesado = 'E2'
			WHERE re_secuencial = @w_secuencial
	END CATCH*/
	           
    
END
PRINT 'fin'