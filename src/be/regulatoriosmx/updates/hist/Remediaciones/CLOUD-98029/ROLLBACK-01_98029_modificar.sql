USE cob_cartera
GO

SELECT * FROM cob_credito..cr_tramite_grupal
where tg_tramite = 1509

UPDATE cob_credito..cr_tramite_grupal SET
	tg_operacion = 9463,
	tg_prestamo = '233450004723',
	tg_participa_ciclo = 'N'
where tg_tramite = 1509
AND tg_cliente IN (32)

UPDATE cob_credito..cr_tramite_grupal SET
	tg_operacion = 9481,
	tg_prestamo = '233450004780',
	tg_participa_ciclo = 'N'
where tg_tramite = 1509
AND tg_cliente IN (47)

UPDATE cob_credito..cr_tramite_grupal SET
	tg_operacion = 9484,
	tg_prestamo = '233450004797',
	tg_participa_ciclo = 'N'
where tg_tramite = 1509
AND tg_cliente IN (51)

SELECT * FROM cob_credito..cr_tramite_grupal
where tg_tramite = 1509

SELECT * FROM cob_cartera..ca_operacion WHERE op_operacion IN (9463, 9481, 9484)

UPDATE cob_cartera..ca_operacion SET
	op_operacion = 9463,
	op_estado  = 0
WHERE abs(op_operacion) IN (9463)

UPDATE cob_cartera..ca_operacion SET
	op_operacion = 9481,
	op_estado  = 0
WHERE abs(op_operacion) IN (9481)

UPDATE cob_cartera..ca_operacion SET
	op_operacion = 9484,
	op_estado  = 0
WHERE abs(op_operacion) IN (9484)

SELECT * FROM cob_cartera..ca_operacion WHERE abs(op_operacion) IN (9463, 9481, 9484)

GO
