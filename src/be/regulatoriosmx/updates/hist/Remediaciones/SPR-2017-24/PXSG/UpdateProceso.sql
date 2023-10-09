USE cob_workflow
go
UPDATE cob_workflow..wf_inst_proceso SET io_estado='TER' WHERE io_campo_1 = 406 AND io_codigo_alterno='SOLCRGRSTD.9001.17.000003'
go