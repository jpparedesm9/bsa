------------->>>>>>>>>>>>>script rollback
SELECT * FROM cob_credito..cr_imp_documento WHERE id_toperacion = 'INDIVIDUAL' AND 
id_mnemonico IN ('CCONCRE', 'CININD', 'TABIND', 'KYCIND')

update cob_credito..cr_imp_documento SET id_template = 'caratulaCreditoIndividual'
WHERE id_toperacion = 'INDIVIDUAL' AND id_mnemonico IN ('CCONCRE')

update cob_credito..cr_imp_documento SET id_template = 'contratoInclusionIndividual'
WHERE id_toperacion = 'INDIVIDUAL' AND id_mnemonico IN ('CININD')

update cob_credito..cr_imp_documento SET id_template = 'tablaAmortizacionInd'
WHERE id_toperacion = 'INDIVIDUAL' AND id_mnemonico IN ('TABIND')

update cob_credito..cr_imp_documento SET id_template = 'kYCSimplificado'
WHERE id_toperacion = 'INDIVIDUAL' AND id_mnemonico IN ('KYCIND')

SELECT * FROM cob_credito..cr_imp_documento WHERE id_toperacion = 'INDIVIDUAL' AND 
id_mnemonico IN ('CCONCRE', 'CININD', 'TABIND', 'KYCIND')
------------->>>>>>>>>>fin script
go
