use cob_cartera
go
DROP TABLE #pagos_det
go
create table #pagos_det (
banco     VARCHAR(32), 
operacion int, 
sec_ing   INT
)

GO
PRINT 'inicio'
SELECT getdate()



declare
@w_grupo int,
@w_operacionca int,
@w_error int,
@w_fecha_proceso datetime,
@w_referencia varchar(64),
@w_banco varchar(24),
@w_secuencial_pag int,
@w_secuencial int,
@w_fult_proceso datetime,
@w_fecha_nueva datetime,
@w_sec_ing INT,
@w_op_oficina int

select 
@w_grupo = 0,
@w_secuencial = 0,
/* FECHA VALOR DEL H2H */
/*******************************************************************************/
@w_fecha_nueva = '02/01/2019'
---SELECT @w_fecha_nueva = '11/30/2018'
/*******************************************************************************/

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

while 1=1 
begin

	select top 1
		@w_grupo      = bo_grupo,
		@w_secuencial = bo_secuencial
	from lgu_112887_borrar
	where bo_secuencial > @w_secuencial
	AND bo_procesado = 'N'
----------   AND bo_grupo = 2776 --331 --***************************
	order by bo_secuencial
	
	if @@rowcount = 0 break
	
	select 
	@w_operacionca = 0,
	@w_sec_ing = 0
	
	print 'REVERSANDO PAGO DEL GRUPO:'+convert(varchar,@w_grupo)+' SECUENCIAL:'+convert(varchar,@w_secuencial)
	
	truncate table #pagos_det
	/******************************/
	
	INSERT INTO lgu_112887_det_borrar (
	bod_banco     ,	bod_operacion ,	bod_sec_ing   ,
	bod_fult_pro  ,	bod_fvalor    ,	bod_error     ,
	bod_procesado ,	bod_mensaje   ,   bod_grupo)
	select 
	cd_banco, cd_operacion,   cd_sec_ing,
	NULL,     @w_fecha_nueva, 0,
	'N',      '',             @w_grupo
	from ca_corresponsal_det
	where cd_secuencial = @w_secuencial

	
	insert into #pagos_det
	select cd_banco, cd_operacion, cd_sec_ing
	from ca_corresponsal_det
	where cd_secuencial = @w_secuencial
	
	if @@rowcount = 0 begin 
		print 'NO SE ENCONTRO DETALLE DE PAGO PARA EL SECUENCIAL:'+convert(varchar,@w_secuencial)
		
		UPDATE lgu_112887_borrar SET 
			bo_procesado   = 'E1',
			bo_error       = 999,
			bo_mensaje     = 'GR:'+convert(VARCHAR, @w_grupo)+' '+ ' BCO: NO HAY DATOS'
		WHERE bo_grupo    = @w_grupo     
		AND bo_secuencial = @w_secuencial
		AND bo_procesado = 'N'

		goto SIGUIENTE_GRUPO
	end
	
--	select * from #pagos_det
	
	while 2=2 
	begin
	
		select top 1
			@w_banco       = banco, 
			@w_operacionca = operacion, 
			@w_sec_ing     = sec_ing
		from #pagos_det
		where operacion > @w_operacionca
		order by operacion
		
		if @@rowcount = 0 BREAK
		
		SELECT @w_op_oficina = op_oficina
		FROM ca_operacion 
		WHERE op_operacion = @w_operacionca
		
		select @w_secuencial_pag = ab_secuencial_pag
		from ca_abono 
		where ab_secuencial_ing = @w_sec_ing 
		and ab_operacion = @w_operacionca
		and ab_estado = 'A'
		
		if @@ROWCOUNT =0 continue
		
		
		--APLICAR REVERSOS 
		select 'REVERSANDO PAGO PRESTAMO:' = @w_banco , ' secuencial del pago:' = @w_secuencial_pag 
		
		BEGIN TRY 
			exec @w_error = sp_fecha_valor 
			@s_date       = @w_fecha_proceso,
			@s_user       = 'usrbatch',
			@s_term       = 'consola',
			@t_trn        = 7049,
			@i_fecha_mov  = @w_fecha_proceso,
			@i_banco      = @w_banco,
			@i_secuencial = @w_secuencial_pag,
			@i_operacion  = 'R',
			@s_ofi        = @w_op_oficina
			
			if @w_error <> 0 
			begin
				select 
					'Error al ejecutar sp_fecha_valor REVERSA ' = @w_error , 
					'Banco ' = @w_banco , 
					'SecPAG' = @w_secuencial_pag

				UPDATE lgu_112887_borrar SET 
					bo_procesado = 'E2',
					bo_mensaje   = 'GR:'+convert(VARCHAR, @w_grupo)+' '+ ' BCO:'+ @w_banco + ' PAG:' +convert(VARCHAR, @w_secuencial_pag)
				WHERE bo_grupo    = @w_grupo     
				AND bo_secuencial = @w_secuencial

				SELECT @w_fult_proceso = op_fecha_ult_proceso
				FROM ca_operacion
				where op_banco = @w_banco

				UPDATE lgu_112887_det_borrar set
				bod_fult_pro  = @w_fult_proceso,
				bod_error     = @w_error,
				bod_procesado = 'E1',
				bod_mensaje   = 'GR:'+convert(VARCHAR, @w_grupo)+' '+ ' BCO:'+ @w_banco + ' OP: '+convert(VARCHAR, @w_operacionca) +' PAG:' +convert(VARCHAR, @w_secuencial_pag)
		      WHERE bod_banco = @w_banco
		      AND bod_sec_ing = @w_sec_ing
					
				SELECT @w_fult_proceso = NULL
				goto SIGUIENTE_GRUPO
			END
			
			SELECT @w_fult_proceso = op_fecha_ult_proceso
			FROM ca_operacion
			where op_banco = @w_banco

			UPDATE lgu_112887_det_borrar set
			bod_fult_pro  = @w_fult_proceso,
			bod_error     = 0,
			bod_procesado = 'S',
			bod_mensaje   = 'GR:'+convert(VARCHAR, @w_grupo)+' '+ ' BCO:'+ @w_banco + ' OP: '+convert(VARCHAR, @w_operacionca) +' PAG:' +convert(VARCHAR, @w_secuencial_pag)
	      WHERE bod_banco = @w_banco
	      AND bod_sec_ing = @w_sec_ing

		END TRY
		BEGIN CATCH     
	        select @w_error = @@ERROR

				UPDATE lgu_112887_borrar SET 
					bo_procesado = 'E3',
					bo_error     = @w_error,
					bo_mensaje  = 'GR:'+convert(VARCHAR, @w_grupo)+' '+ ' BCO:'+ @w_banco + ' OP: '+convert(VARCHAR, @w_operacionca) +' PAG:' +convert(VARCHAR, @w_secuencial_pag)
				WHERE bo_grupo    = @w_grupo     
				AND bo_secuencial = @w_secuencial

			
				SELECT @w_fult_proceso = op_fecha_ult_proceso
				FROM ca_operacion
				where op_banco = @w_banco
	
				UPDATE lgu_112887_det_borrar set
				bod_fult_pro  = @w_fult_proceso,
				bod_error     = @w_error,
				bod_procesado = 'E2',
				bod_mensaje  = 'GR:'+convert(VARCHAR, @w_grupo)+' '+ ' BCO:'+ @w_banco + ' OP: '+convert(VARCHAR, @w_operacionca) +' PAG:' +convert(VARCHAR, @w_secuencial_pag)
		      WHERE bod_banco = @w_banco
		      AND bod_sec_ing = @w_sec_ing

		       goto SIGUIENTE_GRUPO
	    END CATCH

	END -- while
	
	--ACTUALIZAR ESTADO
	
	
	print 'ACTUALIZANDO CA_CORRESPONSAL_TRN'
	
	select 'ANTES',* from ca_corresponsal_trn where co_secuencial = @w_secuencial
	
	update ca_corresponsal_trn set 
		co_estado ='I', 
		co_error_msg ='' ,
        co_error_id = 0,
		co_fecha_valor = @w_fecha_nueva
	where co_secuencial = @w_secuencial
	
	select 'DESPUES',* from ca_corresponsal_trn where co_secuencial = @w_secuencial
	
	UPDATE lgu_112887_borrar SET 
		bo_procesado = 'S',
		bo_mensaje   = 'GR:'+convert(VARCHAR, @w_grupo)+' '+ ' BCO:'+ @w_banco + ' PAG:' +convert(VARCHAR, @w_secuencial_pag)
	WHERE bo_grupo    = @w_grupo     
	AND bo_secuencial = @w_secuencial
	AND bo_procesado = 'N'
	
	SIGUIENTE_GRUPO:
end


GO

PRINT 'fin'
SELECT getdate()
