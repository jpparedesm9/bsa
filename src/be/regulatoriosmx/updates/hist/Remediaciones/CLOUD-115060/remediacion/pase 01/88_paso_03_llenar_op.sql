use cob_cartera
go
declare 
@w_grupo INT,
@w_tramite INT

SELECT @w_grupo  = 0

TRUNCATE TABLE #grupo_det

WHILE 1= 1
BEGIN
	SELECT @w_tramite = 0
	
	select 
		TOP 1 
		@w_grupo = gr_grupo,
		@w_tramite = gr_tramite
	from #grupo
	WHERE gr_grupo > @w_grupo
	ORDER BY gr_grupo ASC
	
	IF @@ROWCOUNT = 0 break
	
	IF @w_tramite = 0
		select @w_tramite = tg_tramite
		from cob_credito..cr_tramite_grupal, ca_operacion, ca_estado
		where tg_grupo = @w_grupo
		and tg_operacion = op_operacion
		and tg_prestamo <> tg_referencia_grupal
		and tg_monto > 0
		and op_estado = es_codigo
		and es_procesa ='S'
	
	INSERT INTO #grupo_det
	select 
		tg_grupo,    @w_tramite, tg_operacion , 
		tg_prestamo, tg_cliente, op_estado, 
		op_oficina,
		tg_referencia_grupal, 0,
		'I', '', op_fecha_ult_proceso
	from cob_credito..cr_tramite_grupal, ca_operacion 
	where tg_grupo = @w_grupo
	and tg_operacion = op_operacion
	and tg_prestamo <> tg_referencia_grupal
	and tg_monto > 0
	AND tg_tramite = @w_tramite
	
	UPDATE #grupo_det SET gd_operacion_p = op_operacion
	FROM ca_operacion
	WHERE gd_referencia_grupal = op_banco
	
	UPDATE #grupo SET gr_tramite = @w_tramite
	WHERE gr_grupo = @w_grupo
	
END

	SELECT * FROM #grupo_det
	SELECT * FROM #grupo
