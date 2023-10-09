SELECT afd_status AS st, afd_transaction_type, afd_in_out, afd_cron_expression, * 
FROM cob_ien..ree_ien_agent_file_def
ORDER BY afd_status

SELECT jo_status AS st, jo_transaction_type, jo_in_out, jo_cron_expression, * 
FROM cob_ien..ree_ien_jobs
ORDER BY jo_status

/****** PARA ACTIVAR TAREAS ESPECÍFICAS ******/

UPDATE cob_ien..ree_ien_agent_file_def
SET afd_status = 'A'
, afd_cron_expression = '0 0/2 * 1/1 * ? *'
--, afd_cron_expression = '0 47 9-17/1 ? * MON-FRI *'
--, afd_cron_expression = '0 17 17 ? * MON-FRI *'
WHERE afd_transaction_type = 'DSMBL'
--AND afd_in_out = 'IN'
AND afd_in_out = 'OUT'

UPDATE cob_ien..ree_ien_jobs
SET jo_status = 'A'
, jo_cron_expression = '0 0/3 * 1/1 * ? *'
--, jo_cron_expression = '0 44 9-17/1 ? * MON-FRI *'
--, jo_cron_expression = '0 14 17 ? * MON-FRI *'
WHERE jo_transaction_type = 'DSMBL'
--AND jo_type = 'DOWNLOAD'
AND jo_type = 'SERVICE'

UPDATE cob_ien..ree_ien_jobs
SET jo_status = 'A'
WHERE jo_transaction_type = 'DSMBL'
--AND jo_type = 'PROCESS'
AND jo_type = 'UPLOAD'



UPDATE cob_ien..ree_ien_agent_file_def
SET afd_status = 'A'
UPDATE cob_ien..ree_ien_agent_file_def
SET afd_status = 'B'
WHERE afd_transaction_type <> 'PGRFR'

UPDATE cob_ien..ree_ien_jobs
SET jo_status = 'A'
UPDATE cob_ien..ree_ien_jobs
SET jo_status = 'B'
WHERE jo_transaction_type <> 'PGRFR'