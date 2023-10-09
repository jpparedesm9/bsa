DECLARE @w_tramite INT = NULL

SELECT @w_tramite = io_campo_3 FROM cob_workflow..wf_inst_proceso WHERE io_codigo_alterno = 'SOLCRGRSTD.3345.18.000001'

UPDATE cob_credito..cr_tramite_grupal 
SET tg_monto = 0,
tg_participa_ciclo = 'N'
WHERE tg_tramite = @w_tramite 
AND tg_cliente IN (32, 47, 51)
AND tg_grupo = 4

SELECT * FROM cob_credito..cr_tramite_grupal WHERE tg_tramite = @w_tramite

UPDATE cob_credito..cr_tramite 
SET tr_monto = 37500,
tr_monto_solicitado = 37500
WHERE tr_tramite = @w_tramite 


SELECT * FROM cob_credito..cr_tramite WHERE tr_tramite = @w_tramite

UPDATE cob_cartera..ca_operacion 
SET op_monto = 37500,
op_monto_aprobado = 37500
WHERE op_tramite = @w_tramite 


SELECT * FROM cob_cartera..ca_operacion WHERE op_tramite = @w_tramite