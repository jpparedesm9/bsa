USE cob_credito
GO
SELECT 'antes'
SELECT * from cob_credito..cr_verifica_datos where vd_cliente = 2324234 and vd_tramite = 555
SELECT 'borro'
delete from cob_credito..cr_verifica_datos where vd_cliente = 2324234 and vd_tramite = 555
SELECT 'despues '
SELECT * from cob_credito..cr_verifica_datos where vd_cliente = 2324234 and vd_tramite = 555

go