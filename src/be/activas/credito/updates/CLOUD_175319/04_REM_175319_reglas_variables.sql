----->>>>>>1
SELECT * FROM cob_pac..bpl_rule WHERE rl_acronym = 'VERIACTNAC'
UPDATE cob_pac..bpl_rule SET rl_name = 'Verifica Documento Probatorio' WHERE rl_acronym = 'VERIACTNAC'

----->>>>>>2
SELECT * FROM cob_workflow..wf_variable WHERE vb_abrev_variable = 'ACTNACIM'
UPDATE cob_workflow..wf_variable SET vb_nombre_variable = 'Documento Probatorio', vb_desc_variable = 'Documento Probatorio' WHERE vb_abrev_variable = 'ACTNACIM'
go
