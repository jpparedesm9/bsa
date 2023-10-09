use cob_cartera
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
@w_error        INT,
@w_debug        CHAR(1),
@w_id           INT,
@w_sec_pag      INT,
@w_monto_sob    MONEY



SELECT @w_debug = 'S'

DECLARE @s_date DATETIME

SELECT @s_date = fp_fecha FROM cobis..ba_fecha_proceso

SELECT @w_id  = 0,
@w_monto_sob = 0

WHILE 1= 1
BEGIN
	SELECT 
		@w_tramite = 0,
		@w_grupo = 0
	
	select 
		TOP 1 
		@w_id          = ab_id,
		@w_grupo       = ab_grupo,
		@w_tramite     = ab_tramite,
		@w_banco       = ab_banco,
		@w_operacionca = ab_operacion,
		@w_sec_pag     = ab_secuencial_pag
	from #abono
	WHERE ab_id > @w_id
	AND ab_procesado = 'I'  -- INGRESADOS
	ORDER BY ab_id ASC
	
	IF @@ROWCOUNT = 0 break
	

	select 
		'Grupo' = @w_grupo, 'Tramite' = @w_tramite ,
		'BCO' = @w_banco,       'Sec Pag' = @w_sec_pag
/*
	SELECT 'ANTES----',*
	FROM ca_transaccion, ca_det_trn
	WHERE tr_operacion = dtr_operacion
	AND tr_secuencial = dtr_secuencial
	AND tr_operacion = @w_operacionca
	AND tr_secuencial= @w_sec_pag
	AND dtr_concepto = 'SOBRANTE'
*/
	SELECT @w_monto_sob = dtr_monto
	FROM ca_transaccion, ca_det_trn
	WHERE tr_operacion = dtr_operacion
	AND tr_secuencial = dtr_secuencial
	AND tr_operacion = @w_operacionca
	AND tr_secuencial= @w_sec_pag
	AND dtr_concepto = 'SOBRANTE'
/*
	SELECT dtr_concepto, dtr_monto, 'SOBRANTE', 'SOB' = @w_monto_sob
	FROM ca_transaccion, ca_det_trn
	WHERE tr_operacion = dtr_operacion
	AND tr_secuencial = dtr_secuencial
	AND tr_operacion = @w_operacionca
	AND tr_secuencial= @w_sec_pag
	AND dtr_concepto = 'VAC0'
*/	


	UPDATE ca_det_trn SET 
		dtr_monto    = dtr_monto    - @w_monto_sob,
		dtr_monto_mn = dtr_monto_mn - @w_monto_sob
	WHERE dtr_operacion = @w_operacionca
	AND dtr_secuencial= @w_sec_pag
	AND dtr_concepto = 'VAC0'


	DELETE FROM ca_det_trn
	WHERE dtr_operacion = @w_operacionca
	AND dtr_secuencial= @w_sec_pag
	AND dtr_concepto = 'SOBRANTE'


	/**
	SELECT 'DESPUES----',*
	FROM ca_transaccion, ca_det_trn
	WHERE tr_operacion = dtr_operacion
	AND tr_secuencial = dtr_secuencial
	AND tr_operacion = @w_operacionca
	AND tr_secuencial= @w_sec_pag
	**/

END -- lazo grupos






