UPDATE cob_ien..ree_ien_agent_notif_config
SET anc_email_address = 'ejprado@santander.com.mx;erumoroso@santander.com.mx;edgar.miranda@nubaj.com'
WHERE ag_code = (SELECT co_value_entity FROM cob_ien..ree_ien_conf_group WHERE co_name = 'SANTANDER')

UPDATE cob_ien..ree_ien_jobs
SET jo_cron_expression = '0 15,45 6-20 ? * MON-FRI *'
WHERE co_id = (SELECT co_id FROM cob_ien..ree_ien_conf_group WHERE co_name = 'SANTANDER')
AND jo_transaction_type = 'PGRFR'
AND jo_type = 'DOWNLOAD'

UPDATE cob_ien..ree_ien_agent_file_def
SET afd_cron_expression = '0 20,50 6-20 ? * MON-FRI *'
WHERE ag_code = (SELECT co_value_entity FROM cob_ien..ree_ien_conf_group WHERE co_name = 'SANTANDER')
AND afd_transaction_type = 'PGRFR'
AND afd_in_out = 'IN'
