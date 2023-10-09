use cob_ien
go

print '-------------------------------------------------------------------------------------------------------------------'
print 'BORRADO TABLAS IEN PARA COBROS'
print '-------------------------------------------------------------------------------------------------------------------'

print 'DELETE-ree_ien_events-COBRO'
DELETE FROM cob_ien..ree_ien_events
WHERE ftr_id IN (SELECT ftr_id FROM ree_ien_file_transfer WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type = 'COBRO'))

if exists(SELECT 1 FROM ree_ien_transactions_files WHERE ftr_id IN (SELECT ftr_id FROM ree_ien_file_transfer WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type = 'COBRO')))
begin
print 'DELETE-ree_ien_transactions_files-COBRO'
DELETE FROM ree_ien_transactions_files WHERE ftr_id IN (SELECT ftr_id FROM ree_ien_file_transfer WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type = 'COBRO'))
end

if exists(SELECT 1 FROM ree_ien_file_transfer WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type = 'COBRO'))
begin
print 'DELETE-ree_ien_file_transfer-COBRO'
 DELETE FROM ree_ien_file_transfer WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type = 'COBRO')
end

print 'DELETE-ree_ien_transactions_files_his-COBRO'
DELETE FROM cob_ien..ree_ien_transactions_files_his
WHERE fth_id IN (SELECT fth_id FROM cob_ien..ree_ien_file_transfer_his WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type = 'COBRO'))

print 'DELETE-ree_ien_file_transfer_his-COBRO'
DELETE FROM cob_ien..ree_ien_file_transfer_his
WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type = 'COBRO')

if exists (select 1  from cob_ien..ree_ien_agent_file_def where afd_transaction_type = 'COBRO')
begin
print 'DELETE-ree_ien_agent_file_def-COBRO'
delete from cob_ien..ree_ien_agent_file_def where afd_transaction_type = 'COBRO'
end

if exists(select 1 from cob_ien..ree_ien_column_file_def where ftd_id in (select ftd_id from cob_ien..ree_ien_file_transfer_def where ftd_description in ('RESULTADO COBRO SANTANDER','COBRO CUOTA SANTANDER')))
begin
print 'DELETE-ree_ien_column_file_def-COBRO'
delete from cob_ien..ree_ien_column_file_def where ftd_id in (select ftd_id from cob_ien..ree_ien_file_transfer_def where ftd_description in ('RESULTADO COBRO SANTANDER','COBRO CUOTA SANTANDER'))
end

if exists(select 1 from cob_ien..ree_ien_file_transfer_def where ftd_description in ('COBRO CUOTA SANTANDER','RESULTADO COBRO SANTANDER'))
begin
print 'DELETE-ree_ien_file_transfer_def-COBRO'
delete from cob_ien..ree_ien_file_transfer_def where ftd_description in ('COBRO CUOTA SANTANDER','RESULTADO COBRO SANTANDER') ---> revisar campo tabla
end

if exists(select 1 from cob_ien..ree_ien_service_factory where sf_type_service = 'COBRO')
begin
print 'DELETE-ree_ien_service_factory-COBRO'
delete from cob_ien..ree_ien_service_factory where sf_type_service = 'COBRO'
end

if exists(select 1 from cob_ien..ree_ien_object_conf where obj_namespace in ('Direct Debit Mandate Request','Direct Debit Mandate Response'))
begin
print 'DELETE-ree_ien_object_conf-COBRO'
delete from cob_ien..ree_ien_object_conf where obj_namespace in ('Direct Debit Mandate Request','Direct Debit Mandate Response')--Preguntar antes de ejecutar
end


if exists(select 1 from cob_ien..ree_ien_jobs where jo_transaction_type = 'COBRO')
begin
print 'DELETE-ree_ien_jobs-COBRO'
delete from cob_ien..ree_ien_jobs where jo_transaction_type = 'COBRO' --and jo_status = 'A'
end

go