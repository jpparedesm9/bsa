USE cob_ien
GO

SET NOCOUNT ON
GO

PRINT '-------------------------------------------------------------------------------------------------------------------'
PRINT 'BORRADO TABLAS IEN PARA PAGOS REFERENCIADOS'
PRINT '-------------------------------------------------------------------------------------------------------------------'

PRINT 'DELETE-ree_ien_events-PGRFR'
DELETE FROM cob_ien..ree_ien_events
WHERE ftr_id IN (SELECT ftr_id FROM ree_ien_file_transfer WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def WHERE afd_transaction_type = 'PGRFR'))

PRINT 'DELETE-ree_ien_transactions_files-PGRFR'
DELETE FROM ree_ien_transactions_files 
WHERE ftr_id IN (SELECT ftr_id FROM ree_ien_file_transfer WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def WHERE afd_transaction_type = 'PGRFR'))

PRINT 'DELETE-ree_ien_file_transfer-PGRFR'
DELETE FROM ree_ien_file_transfer 
WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def WHERE afd_transaction_type = 'PGRFR')

PRINT 'DELETE-ree_ien_transactions_files_his-PGRFR'
DELETE FROM cob_ien..ree_ien_transactions_files_his
WHERE fth_id IN (SELECT fth_id FROM cob_ien..ree_ien_file_transfer_his WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def WHERE afd_transaction_type = 'PGRFR'))

PRINT 'DELETE-ree_ien_file_transfer_his-PGRFR'
DELETE FROM cob_ien..ree_ien_file_transfer_his
WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def WHERE afd_transaction_type = 'PGRFR')

PRINT 'DELETE-ree_ien_agent_file_def-PGRFR'
DELETE FROM cob_ien..ree_ien_agent_file_def 
WHERE afd_transaction_type = 'PGRFR'

PRINT 'DELETE-ree_ien_column_file_def-PGRFR'
DELETE FROM cob_ien..ree_ien_column_file_def 
WHERE ftd_id IN (SELECT ftd_id FROM cob_ien..ree_ien_file_transfer_def WHERE ftd_description = 'RESULTADO PAGOS REFERENCIADOS SANTANDER')

PRINT 'DELETE-ree_ien_file_transfer_def-PGRFR'
DELETE FROM cob_ien..ree_ien_file_transfer_def 
WHERE ftd_description = 'RESULTADO PAGOS REFERENCIADOS SANTANDER'

PRINT 'DELETE-ree_ien_service_factory-PGRFR'
DELETE FROM cob_ien..ree_ien_service_factory 
WHERE sf_type_service = 'PGRFR'

PRINT 'DELETE-ree_ien_object_conf-PGRFR'
DELETE FROM cob_ien..ree_ien_object_conf 
WHERE obj_namespace = 'Accounts Receivable Response'

PRINT 'DELETE-ree_ien_jobs-PGRFR'
DELETE FROM cob_ien..ree_ien_jobs 
WHERE jo_transaction_type = 'PGRFR'

GO

SET NOCOUNT OFF
GO
