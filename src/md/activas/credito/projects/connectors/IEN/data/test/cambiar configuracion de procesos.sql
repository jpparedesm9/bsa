select * from cob_ien..ree_ien_agent_file_def
select * from cob_ien..ree_ien_jobs
select * from cob_ien..ree_ien_integration_server
select * from cob_ien..ree_ien_agent_notif_config

UPDATE cob_ien..ree_ien_agent_file_def
SET afd_ftp_folder = 'Inbound_dev'
WHERE afd_in_out = 'OUT'

UPDATE cob_ien..ree_ien_agent_file_def
SET afd_ftp_folder = 'Outbound_dev'
WHERE afd_in_out = 'IN'

UPDATE cob_ien..ree_ien_integration_server
SET ins_server = '192.168.64.255'
WHERE ins_description = 'SANTANDER H2H'

UPDATE cob_ien..ree_ien_agent_notif_config
set anc_email_address = 'paul.clavijo@cobiscorp.com'
WHERE ag_code = (SELECT en_ente FROM cobis..cl_ente 
					WHERE en_nombre = 'SANTANDER')
