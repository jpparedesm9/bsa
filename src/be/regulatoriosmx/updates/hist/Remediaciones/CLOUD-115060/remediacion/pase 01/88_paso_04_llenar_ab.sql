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
@w_error INT,
@w_debug  CHAR(1)


TRUNCATE TABLE #abono

SELECT @w_debug = 'S'

DECLARE @s_date DATETIME

SELECT @s_date = fp_fecha FROM cobis..ba_fecha_proceso

SELECT @w_grupo  = 0

WHILE 1= 1
BEGIN
	SELECT @w_tramite = 0
	
	select 
		TOP 1 
		@w_grupo = gr_grupo,
		@w_tramite = gr_tramite
	from #grupo
	WHERE gr_grupo > @w_grupo
	AND gr_procesado = 'I'  -- INGRESADOS
	ORDER BY gr_grupo ASC
	
	IF @@ROWCOUNT = 0 break
	

	--select 'Grupo' = @w_grupo, 'Tramite' = @w_tramite
	
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
		WHERE gd_grupo    = @w_grupo
		AND gd_tramite    = @w_tramite
		AND gd_operacion  > @w_operacionca
   	AND gd_procesado  = 'I'  -- INGRESADOS
		ORDER BY gd_operacion ASC

		IF @@ROWCOUNT = 0 break

		/*SELECT 
			'',
			'OP ' = @w_operacionca ,
			'BCO ' = @w_banco       ,
			'CL ' = @w_cliente     ,
			'EST ' = @w_estado      ,
			'OF ' = @w_oficina     
			*/

 -- verificar abonos con sobrantes

		INSERT INTO #abono
		SELECT DISTINCT 
			@w_grupo,
			@w_tramite,
			@w_banco,
			ab_operacion, 
			ab_secuencial_ing, 
			ab_secuencial_rpa, 
			ab_secuencial_pag,
			ab_fecha_pag,
			'X', -- referencia
			@w_operacionca_p,
			-1, -- secuencial corresponsal_trn
			'I'
		FROM ca_abono, ca_abono_det
		WHERE ab_operacion = abd_operacion
		AND ab_secuencial_ing = abd_secuencial_ing 
		AND ab_estado = 'A'
		AND ab_tipo = 'PAG'
		AND abd_concepto = 'SOBRANTE'
		AND ab_operacion = @w_operacionca
		ORDER BY ab_fecha_pag DESC, ab_secuencial_pag DESC

		PRINT 'BCO  :  ' + convert(VARCHAR,@w_banco)
		PRINT 'OP   :  ' + convert(VARCHAR,@w_operacionca)
		PRINT 'FVAL :  ' + convert(VARCHAR,@w_fecha_valor, 101)
		
		
		UPDATE #abono SET 
			ab_referencia = cd_referencia,
			ab_secuencial = cd_secuencial
		FROM ca_corresponsal_det
		WHERE ab_operacion = @w_operacionca
		AND cd_operacion = ab_operacion
		AND cd_sec_ing   = ab_secuencial_ing
		

	END -- lazo operaciones

SIGUIENTE_GRUPO:
/*
	IF @w_error = 0
	BEGIN
		UPDATE #grupo SET 
			gr_procesado = 'P1'
		WHERE gr_grupo  = @w_grupo 
	END
	ELSE
	BEGIN
		UPDATE #grupo SET 
			gr_procesado = 'E3'
		WHERE gr_grupo  = @w_grupo 
	END
*/
END -- lazo grupos

SELECT * FROM #abono

IF EXISTS(SELECT 1 FROM #abono WHERE ab_referencia = 'X' OR ab_secuencial = -1)
   PRINT ' ERROR, EXISTEN PAGOS SIN ATAR AL PAGO CORRESPONSAL '
ELSE
   PRINT ' OK, TODOS LOS PAGOS ESTAN ATADOS AL PAGO CORRESPONSAL '
GO






