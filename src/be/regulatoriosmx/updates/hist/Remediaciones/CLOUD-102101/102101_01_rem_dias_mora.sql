

UPDATE cob_conta_super..sb_dato_operacion SET
	do_dias_mora_365 = isnull(datediff (dd, do_fecha_dividendo_ven, '07/02/2018'),0)
WHERE do_fecha = '06/29/2018'
AND do_fecha_dividendo_ven IS NOT NULL


GO

EXEC cob_conta_super..sp_reporte_operativo
@i_param1 = '06/29/2018',
@i_param2 = 28793,
@i_param3 = 111

go

