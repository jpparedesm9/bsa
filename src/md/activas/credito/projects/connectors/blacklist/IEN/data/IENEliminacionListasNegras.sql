/********************************************************************************/
/* Archivo:                IENEliminacionListasNegras.sql                       */
/* Base de datos:          cob_ien                                              */
/* Producto:               IEN                                                  */
/* Disenado por:           Pedro Romero                                         */
/* Fecha de re-escritura:  15/08/2017                                           */
/********************************************************************************/
/*                                 IMPORTANTE                                   */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.     */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier         */
/* alteracion o agregado hecho por alguno de usuarios sin el debido             */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp          */
/* o su representante.                                                          */
/********************************************************************************/
/*                                PROPOSITO                                     */
/*  Instala la parametrizacion para la carga de Listas Negras   				*/
/********************************************************************************/
/*                              MODIFICACIONES                                  */
/*    FECHA      VERSION     AUTOR             RAZON                            */
/* 2017/09/13				 Paúl Clavijo	   Objetos faltantes a limpiar      */
/********************************************************************************/
print '-------------------------------------------------------------------------------------------------------------------'
print 'BORRADO TABLAS IEN'
print '-------------------------------------------------------------------------------------------------------------------'

use cob_ien
go

declare
@w_ente       INT,
@w_transaction_type VARCHAR(10),
@w_object	VARCHAR(40)

select @w_transaction_type='LSTNG'
select @w_object ='REGULATORYCOMPLIANCERESPONSE'

print 'DELETE-ree_ien_events-LSTNG'
DELETE FROM cob_ien..ree_ien_events
WHERE ftr_id IN (SELECT ftr_id FROM ree_ien_file_transfer WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type = @w_transaction_type))

if exists(SELECT 1 FROM ree_ien_transactions_files WHERE ftr_id IN (SELECT ftr_id FROM ree_ien_file_transfer WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type = @w_transaction_type)))
begin
print 'DELETE-ree_ien_transactions_files-LSTNG'
DELETE FROM ree_ien_transactions_files WHERE ftr_id IN (SELECT ftr_id FROM ree_ien_file_transfer WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type = @w_transaction_type))
end

if exists(SELECT 1 FROM ree_ien_file_transfer WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type = @w_transaction_type))
begin
print 'DELETE-ree_ien_file_transfer-LSTNG'
 DELETE FROM ree_ien_file_transfer WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type = @w_transaction_type)
end

print 'DELETE-ree_ien_transactions_files_his-LSTNG'
DELETE FROM cob_ien..ree_ien_transactions_files_his
WHERE fth_id IN (SELECT fth_id FROM cob_ien..ree_ien_file_transfer_his WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type = @w_transaction_type))

print 'DELETE-ree_ien_file_transfer_his-LSTNG'
DELETE FROM cob_ien..ree_ien_file_transfer_his
WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type = @w_transaction_type)


if exists (select 1  from cob_ien..ree_ien_agent_file_def where afd_transaction_type = @w_transaction_type)
begin
print 'DELETE-ree_ien_agent_file_def-LSTNG'
delete from cob_ien..ree_ien_agent_file_def where afd_transaction_type = @w_transaction_type
end

if exists(select 1 from cob_ien..ree_ien_column_file_def where ftd_id in (select ftd_id from cob_ien..ree_ien_file_transfer_def where ftd_description ='LISTAS NEGRAS'))
begin
print 'DELETE-ree_ien_column_file_def-LSTNG'
delete from cob_ien..ree_ien_column_file_def where ftd_id in (select ftd_id from cob_ien..ree_ien_file_transfer_def where ftd_description ='LISTAS NEGRAS')
end

if exists(select 1 from cob_ien..ree_ien_file_transfer_def where ftd_description ='LISTAS NEGRAS')
begin
print 'DELETE-ree_ien_file_transfer_def-LSTNG'
delete from cob_ien..ree_ien_file_transfer_def where ftd_description ='LISTAS NEGRAS'
end

if exists(select 1 from cob_ien..ree_ien_service_factory where sf_type_service = @w_transaction_type)
begin
print 'DELETE-ree_ien_service_factory-LSTNG'
delete from cob_ien..ree_ien_service_factory where sf_type_service = @w_transaction_type
end

if exists(select 1 from cob_ien..ree_ien_object_conf where obj_namespace =@w_object)
begin
print 'DELETE-ree_ien_object_conf-LSTNG'
delete from cob_ien..ree_ien_object_conf where obj_namespace =@w_object
end

if exists(select 1 from cob_ien..ree_ien_jobs where jo_transaction_type = @w_transaction_type)
begin
print 'DELETE-ree_ien_jobs-LSTNG'
delete from cob_ien..ree_ien_jobs where jo_transaction_type = @w_transaction_type --and jo_status = 'A'
end
GO

