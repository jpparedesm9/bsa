USE cob_credito
GO
DECLARE
@w_p_tramite INT

SELECT @w_p_tramite = io_campo_3 FROM cob_workflow..wf_inst_proceso
WHERE io_campo_1= 2408


SELECT * FROM cr_tramite 
WHERE tr_tramite = @w_p_tramite


SELECT * FROM cob_cartera..ca_operacion
WHERE op_tramite = @w_p_tramite

--//////////////////////////////////////////////////////////////////
GO

DECLARE @w_tramite INT

SELECT @w_tramite = io_campo_3
FROM cob_workflow..wf_inst_proceso 
WHERE io_campo_1= 2408


update cob_credito..cr_tramite
SET tr_estado = 'X'
WHERE tr_tramite = @w_tramite

go