use cob_cartera
GO

UPDATE cobis..cl_parametro SET pa_char = 'S'
where pa_nemonico = 'PAVACA'
AND pa_producto = 'CCA'
GO

DECLARE 
@w_grupo INT,
@w_tramite INT,
@w_fecha_valor DATETIME,
@w_operacionca INT,
@w_operacionca_p INT,
@w_banco       VARCHAR(32),
@w_cliente     INT,
@w_estado      INT,
@w_oficina     INT,
@w_fult_proceso DATETIME,
@w_error int

DECLARE @s_date DATETIME

SELECT @s_date = fp_fecha FROM cobis..ba_fecha_proceso

SELECT @w_grupo  = 0
SELECT @w_tramite = 0
	

WHILE 1= 1
BEGIN
	select 
		TOP 1 
		@w_grupo = gr_grupo,
		@w_tramite = gr_tramite 
	from #grupo
	WHERE gr_grupo > @w_grupo
	ORDER BY gr_grupo ASC
	
	IF @@ROWCOUNT = 0 break
	
	select 'Grupo' = @w_grupo, 'Tramite' = @w_tramite

	
	SELECT @w_operacionca = 0
	WHILE 1=1
	BEGIN

		SELECT @w_fult_proceso = NULL,
		 		 @w_error = 0

		SELECT 
			TOP 1 
			@w_operacionca = gd_operacion ,
			@w_banco       = gd_banco     ,
			@w_cliente     = gd_cliente   ,
			@w_estado      = gd_estado    ,
			@w_oficina     = gd_oficina,
			@w_operacionca_p = gd_operacion_p
		FROM #grupo_det
		WHERE gd_grupo = @w_grupo
		AND gd_tramite = @w_tramite
		AND gd_operacion > @w_operacionca
		ORDER BY gd_operacion ASC

		IF @@ROWCOUNT = 0 break

/*		SELECT 
			@w_operacionca ,
			@w_banco       ,
			@w_cliente     ,
			@w_estado      ,
			@w_oficina     
*/			

		SELECT 
			@w_fecha_valor = @s_date

		PRINT 'BCO  :  ' + convert(VARCHAR,@w_banco) +  
				'   OP   :  ' + convert(VARCHAR,@w_operacionca) + 
				'   FVAL :  ' + convert(VARCHAR,@w_fecha_valor, 101)

		-- fecha valor 
		BEGIN TRY 
 
			exec @w_error = sp_fecha_valor 
			@s_date        = @s_date,
	   	@s_ofi         = @w_oficina,
			@s_user        = 'OPERADOR',
			@s_term        = 'CONSOLA',
			@t_trn         = 7049,
			@i_fecha_mov   = @s_date,
			@i_fecha_valor = @w_fecha_valor  ,
			@i_banco       = @w_banco , 
			@i_secuencial  = 1,
			@i_operacion   = 'F'
		
 			
			if @w_error <> 0 
			begin
				select 
					'Error al ejecutar sp_fecha_valor ' = @w_error , 
					'Banco ' = @w_banco , 
               'FVAL :  ' + convert(VARCHAR,@w_fecha_valor, 101)

				SELECT @w_fult_proceso = op_fecha_ult_proceso
				FROM ca_operacion
				where op_banco = @w_banco

				UPDATE #grupo_det SET 
				   gd_fult_proc = @w_fult_proceso,
					gd_procesado = 'E20',
					gd_mensaje   = 'GR:'+convert(VARCHAR, @w_grupo)+' '+ ' BCO:'+ @w_banco + ' FECHA VALOR:' +convert(VARCHAR, @w_fecha_valor, 101)
				WHERE gd_grupo = @w_grupo     
				AND gd_tramite = @w_tramite
				AND gd_operacion = @w_operacionca


				UPDATE #grupo SET 
					gr_procesado = 'E20'
				WHERE gr_grupo  = @w_grupo 


				goto SIGUIENTE_GRUPO
			END
		END TRY
		BEGIN CATCH     
			select @w_error = @@ERROR

			SELECT @w_fult_proceso = op_fecha_ult_proceso
			FROM ca_operacion
			where op_banco = @w_banco
			
			UPDATE #grupo_det SET 
			   gd_fult_proc = @w_fult_proceso,
				gd_procesado = 'E10',
				gd_mensaje   = 'GR:'+convert(VARCHAR, @w_grupo)+' '+ ' BCO:'+ @w_banco + ' FECHA VALOR:' +convert(VARCHAR, @w_fecha_valor, 101)
			WHERE gd_grupo = @w_grupo     
			AND gd_tramite = @w_tramite
			AND gd_operacion = @w_operacionca

			UPDATE #grupo SET 
				gr_procesado = 'E10'
			WHERE gr_grupo  = @w_grupo 

	       goto SIGUIENTE_GRUPO

		END CATCH     

		UPDATE #grupo_det SET 
			gd_procesado = 'P10',
			gd_fult_proc = @w_fecha_valor
		WHERE gd_grupo = @w_grupo     
		AND gd_tramite = @w_tramite
		AND gd_operacion = @w_operacionca

	
	END -- lazo operaciones

SIGUIENTE_GRUPO:

	IF @w_error = 0
	BEGIN
		UPDATE #grupo SET 
			gr_procesado = 'P10'
		WHERE gr_grupo  = @w_grupo 
	END
	ELSE
	BEGIN
		UPDATE #grupo SET 
			gr_procesado = 'E30'
		WHERE gr_grupo  = @w_grupo 
	END

END -- lazo grupos




SELECT * FROM #grupo
SELECT * FROM #grupo_det



