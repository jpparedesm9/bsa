USE cob_credito
GO
-------->>>>>>>>
SELECT 'LAS_Q_S_VA_ACT', I.* 
FROM cob_credito..cr_interface_buro I, cob_credito..cr_interface_buro_tmp_162199_resp E
WHERE I.ib_cliente = E.ib_cliente
AND I.ib_fecha = E.ib_fecha
AND I.ib_folio = E.ib_folio
AND I.ib_secuencial = E.ib_secuencial

UPDATE cob_credito..cr_interface_buro 
SET ib_estado = 'V'
FROM cob_credito..cr_interface_buro I, cob_credito..cr_interface_buro_tmp_162199_resp E
WHERE I.ib_cliente = E.ib_cliente
AND I.ib_fecha = E.ib_fecha
AND I.ib_folio = E.ib_folio
AND I.ib_secuencial = E.ib_secuencial

go
