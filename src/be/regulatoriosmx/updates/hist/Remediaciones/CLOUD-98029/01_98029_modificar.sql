USE cob_cartera
GO

SELECT * FROM cob_credito..cr_tramite_grupal
where tg_tramite = 1509

UPDATE cob_credito..cr_tramite_grupal SET
	tg_operacion = 7618,
	tg_prestamo = '233450003971',
	tg_participa_ciclo = 'N'
where tg_tramite = 1509
AND tg_cliente IN (32, 47, 51)

SELECT * FROM cob_credito..cr_tramite_grupal
where tg_tramite = 1509

SELECT * FROM cob_cartera..ca_operacion WHERE op_operacion IN (9463, 9481, 9484)

UPDATE cob_cartera..ca_operacion SET
	op_operacion = -1*op_operacion,
	op_estado  = 6
WHERE op_operacion IN (9463, 9481, 9484)	

SELECT * FROM cob_cartera..ca_operacion WHERE abs(op_operacion) IN (9463, 9481, 9484)

GO

EXEC sp_actualiza_grupal
        @i_banco             = '233450003971',
        @i_desde_cca         = 'N'  	
        
GO
