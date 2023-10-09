------------------------------------
--GRUPO 1103
------------------------------------
/*CODIGO ACTIVIDAD APROBACION SOLICITUDES - Grupo 1103*/ -- GERENTE
--SELECT aa_id_destinatario, * FROM cob_workflow..wf_asig_actividad
--WHERE aa_id_inst_act IN (SELECT ia_id_inst_act FROM cob_workflow..wf_inst_actividad
--WHERE  ia_id_inst_proc = @w_proceso AND ia_codigo_act = @w_codigo_act_apr)
--GO

update cob_workflow..wf_asig_actividad
set    aa_id_destinatario = 81-- RESPALDO W 81 - rcardenashe
WHERE  aa_id_asig_act = 10318 and aa_id_inst_act = 20230

GO

--/*Analista - Grupo 1103*/ -- ANALISTA
--SELECT aa_id_destinatario, * FROM cob_workflow..wf_asig_actividad
--WHERE aa_id_inst_act IN (SELECT ia_id_inst_act FROM cob_workflow..wf_inst_actividad
--WHERE  ia_id_inst_proc = @w_proceso AND ia_codigo_act = @w_codigo_act_rev)
--GO

update cob_workflow..wf_asig_actividad
set    aa_id_destinatario = 52 --RESPALDO W 52 - mlopezvi
WHERE  aa_id_asig_act = 10295 and aa_id_inst_act = 20183
GO

--Gerente :Jose Alejandro Amaya Amador - jaamaya (W: 114)
--Analista: Dina Angelica Garcia Vazquez - dagarciava (W:131)
