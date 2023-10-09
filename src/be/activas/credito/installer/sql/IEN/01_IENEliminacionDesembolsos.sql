use cob_ien
go

print '-------------------------------------------------------------------------------------------------------------------'
print 'BORRADO TABLAS IEN PARA DESEMBOLSOS'
print '-------------------------------------------------------------------------------------------------------------------'


print 'DELETE-ree_ien_events-DSMBL'
DELETE FROM cob_ien..ree_ien_events
WHERE ftr_id IN (SELECT ftr_id FROM ree_ien_file_transfer WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type in ('DSMBL','DSMBLCK')))

if exists(SELECT 1 FROM ree_ien_transactions_files WHERE ftr_id IN (SELECT ftr_id FROM ree_ien_file_transfer WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type in ('DSMBL','DSMBLCK'))))
begin
print 'DELETE-ree_ien_transactions_files-DSMBL'
DELETE FROM ree_ien_transactions_files WHERE ftr_id IN (SELECT ftr_id FROM ree_ien_file_transfer WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type in ('DSMBL','DSMBLCK')))
end

if exists(SELECT 1 FROM ree_ien_file_transfer WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type in ('DSMBL','DSMBLCK')))
begin
print 'DELETE-ree_ien_file_transfer-DSMBL'
 DELETE FROM ree_ien_file_transfer WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type in ('DSMBL','DSMBLCK'))
end

print 'DELETE-ree_ien_transactions_files_his-DSMBL'
DELETE FROM cob_ien..ree_ien_transactions_files_his
WHERE fth_id IN (SELECT fth_id FROM cob_ien..ree_ien_file_transfer_his WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type in ('DSMBL','DSMBLCK')))

print 'DELETE-ree_ien_file_transfer_his-DSMBL'
DELETE FROM cob_ien..ree_ien_file_transfer_his
WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type in ('DSMBL','DSMBLCK'))

if exists(select 1 from cob_ien..ree_ien_agent_file_def where afd_transaction_type in ('DSMBL','DSMBLCK'))
begin
print 'DELETE-ree_ien_agent_file_def-DSMBL'
delete from cob_ien..ree_ien_agent_file_def where afd_transaction_type in ('DSMBL','DSMBLCK')
end

if exists(select 1 from cob_ien..ree_ien_column_file_def where ftd_id in (select ftd_id from cob_ien..ree_ien_file_transfer_def where ftd_description in ('DESEMBOLSO SANTANDER','RESULTADO DESEMBOLSO SANTANDER')))
begin
print 'DELETE-ree_ien_column_file_def-DSMBL'
delete from cob_ien..ree_ien_column_file_def where ftd_id in (select ftd_id from cob_ien..ree_ien_file_transfer_def where ftd_description in ('DESEMBOLSO SANTANDER','RESULTADO DESEMBOLSO SANTANDER'))
end

if exists(select 1 from cob_ien..ree_ien_column_file_def where ftd_id in (select ftd_id from cob_ien..ree_ien_file_transfer_def where ftd_description = 'RESULTADO CHECK DESEMBOLSO SANTANDER'))
begin
print 'DELETE-ree_ien_column_file_def-DSMBLCK'
delete from cob_ien..ree_ien_column_file_def where ftd_id in (select ftd_id from cob_ien..ree_ien_file_transfer_def where ftd_description = 'RESULTADO CHECK DESEMBOLSO SANTANDER')
end


if exists(select 1 from cob_ien..ree_ien_file_transfer_def where ftd_description in ('DESEMBOLSO SANTANDER','RESULTADO DESEMBOLSO SANTANDER'))
begin
print 'DELETE-ree_ien_file_transfer_def-DSMBL'
delete from cob_ien..ree_ien_file_transfer_def where ftd_description in ('DESEMBOLSO SANTANDER','RESULTADO DESEMBOLSO SANTANDER') 
end

if exists(select 1 from cob_ien..ree_ien_file_transfer_def where ftd_description = 'RESULTADO CHECK DESEMBOLSO SANTANDER')
begin
print 'DELETE-ree_ien_file_transfer_def-DSMBL'
delete from cob_ien..ree_ien_file_transfer_def where ftd_description = 'RESULTADO CHECK DESEMBOLSO SANTANDER' 
end

if exists(select 1 from cob_ien..ree_ien_service_factory where sf_type_service in ('DSMBL','DSMBLCK'))
begin
print 'DELETE-ree_ien_service_factory-DSMBL'
delete from cob_ien..ree_ien_service_factory where sf_type_service in ('DSMBL','DSMBLCK')
end

if exists(select 1 from cob_ien..ree_ien_object_conf where obj_namespace in ('Disbursement Request','Disbursement Response'))
begin
print 'DELETE-ree_ien_object_conf-DSMBL'
delete from cob_ien..ree_ien_object_conf where obj_namespace in ('Disbursement Request','Disbursement Response')
end


if exists(select 1 from cob_ien..ree_ien_jobs where jo_transaction_type in ('DSMBL','DSMBLCK'))
begin
print 'DELETE-ree_ien_jobs-DSMBL'
delete from cob_ien..ree_ien_jobs where jo_transaction_type in ('DSMBL','DSMBLCK') --and jo_status = 'A'
end

go