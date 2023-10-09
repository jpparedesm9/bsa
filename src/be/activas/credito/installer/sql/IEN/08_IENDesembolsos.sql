/********************************************************************************/
/* Archivo:                IENDesembolsos.sql                                   */
/* Base de datos:          cobis                                                */
/* Producto:               IEN                                                  */
/* Disenado por:           Andres Cusme                                         */
/* Fecha de re-escritura:  14/08/2017                                           */
/********************************************************************************/
/*                                 IMPORTANTE                                   */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.     */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier         */
/* alteracion o agregado hecho por alguno de usuarios sin el debido             */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp          */
/* o su representante.                                                          */
/********************************************************************************/
/*                                PROPOSITO                                     */
/*  Este programa actualiza la cl_seqnos para las tablas de IEN en las que se   */
/*  ingresó parametrizacion para ATM Compensacion de FIE.                       */
/********************************************************************************/
/*                              MODIFICACIONES                                  */
/*    FECHA      VERSION     AUTOR             RAZON                            */
/* 14/08/2017    1.0         Andres Cusme      Versión Base                     */
/* 2017/09/13                Paúl Clavijo      Arreglo app                      */
/********************************************************************************/


print '-------------------------------------------------------------------------------------------------------------------'
print 'ACTUALIZACION DE  SECUENCIALES PARA  TABLAS IEN .............................'
print '-------------------------------------------------------------------------------------------------------------------'

SET NOCOUNT ON
GO

use cob_ien
go

declare
@w_ins_id     int,
@w_ftsq_id    int,
@w_afd_id     int,
@w_ftd_id     int,
@w_cftd_id    int,
@w_co_id      int,
@w_jo_id      int,
@w_eve_id     int,
@w_ftf_id     int


--------------------
Print 'ree_ien_jobs'
--------------------

select @w_jo_id = max(jo_id)
from cob_ien..ree_ien_jobs

select @w_jo_id = isnull (@w_jo_id,0)

update cobis..cl_seqnos
set siguiente = @w_jo_id
where tabla = 'ree_ien_jobs'

If @@rowcount = 0
  Print 'Error al actualizar cl_seqnos para tabla ree_ien_jobs'

-------------------------------
Print 'ree_ien_column_file_def'
-------------------------------

select @w_cftd_id = max(cftd_id)
from cob_ien..ree_ien_column_file_def

select @w_cftd_id = isnull (@w_cftd_id,0)

update cobis..cl_seqnos
set siguiente = @w_cftd_id
where tabla = 'ree_ien_column_file_def'

if @@rowcount = 0
  Print 'Error al actualizar cl_seqnos para tabla ree_ien_column_file_def'

---------------------------------
Print 'ree_ien_file_transfer_def'
---------------------------------

select @w_ftd_id = max(ftd_id)
from cob_ien..ree_ien_file_transfer_def

select @w_ftd_id = isnull (@w_ftd_id,0)

update cobis..cl_seqnos
set siguiente = @w_ftd_id
where tabla = 'ree_ien_file_transfer_def'

if @@rowcount = 0
  Print 'Error al actualizar cl_seqnos para tabla ree_ien_file_transfer_def'

--------------------
Print 'ree_ien_agent_file_def'
--------------------

select @w_jo_id = max(afd_id)
from cob_ien..ree_ien_agent_file_def

select @w_jo_id = isnull (@w_jo_id,0)

update cobis..cl_seqnos
set siguiente = @w_jo_id
where tabla = 'ree_ien_agent_file_def'

If @@rowcount = 0
  Print 'Error al actualizar cl_seqnos para tabla ree_ien_agent_file_def'

GO


declare
@w_codigo     smallint,
@w_ente       int,
@w_sf_id      int,
@w_ins_id     int,
@w_ftsq_id    int,
@w_obj_id     int,
@w_transaction_type smallint,
@w_ftd_id     int,
@w_cftd_id    int,
@w_co_id      int,
@w_jo_id      int,
@w_afd_id     int,
@w_cftd_order int

-----------------------------------------------------------------------------
print 'ree_ien_service_factory'
-----------------------------------------------------------------------------
--PREREQUISITO
--

if exists (select 1 from cob_ien..ree_ien_service_factory
           where sf_type_service = 'DSMBL' and sf_in_out = 'OUT')

begin
  print 'YA EXISTE LA CONFIGURACION DEL SERVICIO >> DSMBL<< OUT'
end
else
begin
    select @w_sf_id = isnull(max(sf_id),0) + 1 from cob_ien..ree_ien_service_factory

    INSERT INTO ree_ien_service_factory (sf_id, sf_package, sf_class, sf_filter, sf_name, sf_type_service, sf_app, sf_en_code, sf_in_out)
    VALUES (@w_sf_id, 'cobiscorp.ecobis.integrationengine.process.notification', 'IServicesIntegration', 'transactionType=DSMBL', 'Desembolso crédito', 'DSMBL', 'DSMBL', NULL, 'OUT')

end


--------------------------------
print 'ree_ien_object_conf'
--------------------------------
--PREREQUISITO
--

/*
delete from cob_ien..ree_ien_object_conf where obj_namespace = 'GARCHF'
*/
if exists (select 1 from cob_ien..ree_ien_object_conf
               where obj_namespace = 'Disbursement Request')
begin
  print 'YA EXISTE LA CONFIGURACION DEL OBJETO >>GARCHF<<'
end
else
begin
    select @w_obj_id = isnull(max(obj_id),0) + 1 from cob_ien..ree_ien_object_conf

    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'Detalle', '[ns1:com.cobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementRequest%detail]', 'Disbursement Request')

    select @w_obj_id = @w_obj_id+1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'Cabecera', '[ns1:com.cobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][DisbursementHeader%ns1.DisbursementHeaderRequest%header]', 'Disbursement Request')

    select @w_obj_id = @w_obj_id+1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'Sumario', '[ns1:com.cobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][DisbursementSummary%ns1.DisbursementSummaryRequest%summary]', 'Disbursement Request')


end


-----------------------------------------------------------------------------
print 'ree_ien_file_transfer_def'
-----------------------------------------------------------------------------

if exists (select 1 from cob_ien..ree_ien_file_transfer_def
           where ftd_description = 'DESEMBOLSO SANTANDER')
begin
  print 'YA EXISTE ARCHIVO DE CONFIGURACION >>PLANTILLA_GENARCHIVO<<'
end
else
begin
    EXEC cobis..sp_cseqnos
        @i_tabla = 'ree_ien_file_transfer_def',
        @o_siguiente = @w_ftd_id out

INSERT INTO ree_ien_file_transfer_def (ftd_id, ftd_description, ftd_file_format, ftd_column_separator, ftd_row_separator, ftd_status, ftd_xslt_file, ftd_num_details, ftd_column_transaction_type, ftd_schema, ftd_num_header, ftd_num_footer, ftd_column_valid_row, ftd_is_template)
VALUES (@w_ftd_id, 'DESEMBOLSO SANTANDER', 'TXT', NULL, NULL, 'A', '', 0, 0, NULL, 0, 0, 0, 0)


end

-----------------------------------------------------------------------------
print 'ree_ien_column_file_def'
-----------------------------------------------------------------------------

if exists (select 1 from cob_ien..ree_ien_column_file_def where ftd_id = @w_ftd_id)
begin
  print 'YA EXISTEN COLUMNAS DEL ARCHIVO DE CONFIGURACION >>PLANTILLA_GENARCHIVO<<'
end
else
begin

select @w_cftd_id = isnull(siguiente,0)
  from cobis..cl_seqnos
  where tabla = 'ree_ien_column_file_def'

 select @w_ftd_id = ftd_id from ree_ien_file_transfer_def
 where ftd_description = 'DESEMBOLSO SANTANDER'

select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'DETALLE', 'DETALLE DESEMBOLSO', 'STRING', 1082, '', 'RIGHT', NULL, @w_cftd_order, 'DETAIL', 1, NULL, '[ns1:com.cobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementRequest%detail]', 1, 0)

select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'CABECERA', 'CABECERA', 'STRING', 482, '', 'RIGHT', NULL, @w_cftd_order, 'HEADER', 1, NULL, '[ns1:com.cobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][DisbursementHeader%ns1.DisbursementHeaderRequest%header]', 1, 0)

select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'SUMARIO', 'SUMARIO', 'STRING', 482, '', 'RIGHT', NULL, @w_cftd_order, 'FOOTER', 1, NULL, '[ns1:com.cobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][DisbursementSummary%ns1.DisbursementSummaryRequest%summary]', 1, 0)

    update cobis..cl_seqnos
    set siguiente = @w_cftd_id
    where tabla = 'ree_ien_column_file_def'

end


--------------------------------
print 'ree_ien_jobs'
--------------------------------
--PREREQUISITO
--

if exists (select 1 from cob_ien..ree_ien_jobs
               where jo_transaction_type = 'DSMBL' and jo_status = 'A' AND jo_in_out = 'OUT')
begin
  print 'YA EXISTE JOB >>DSMBL<< OUT'
end
else
begin
    select @w_co_id = (select co_id from ree_ien_conf_group where co_name = 'SANTANDER')

    select @w_jo_id = isnull(siguiente,0)
    from cobis..cl_seqnos
    where tabla = 'ree_ien_jobs'

    select @w_jo_id = @w_jo_id +1
    INSERT INTO ree_ien_jobs (jo_id, co_id, jo_description, jo_type, jo_cron_expression, jo_service_id, jo_type_cron, jo_has_template, jo_status, jo_in_out, jo_transaction_type)
    VALUES (@w_jo_id, @w_co_id, 'Generacion de Desembolsos', 'SERVICE', '0 25 11,16 ? * MON-FRI *', '1', 'JOB', 1, 'B', 'OUT', 'DSMBL')

    select @w_jo_id = @w_jo_id +1
    INSERT INTO ree_ien_jobs (jo_id, co_id, jo_description, jo_type, jo_cron_expression, jo_service_id, jo_type_cron, jo_has_template, jo_status, jo_in_out, jo_transaction_type)
    VALUES (@w_jo_id, @w_co_id, 'Envio de Desembolsos', 'UPLOAD', NULL, '1', 'ENTITY', 1, 'B', 'OUT', 'DSMBL')

    update cobis..cl_seqnos
    set siguiente = @w_jo_id
    where tabla = 'ree_ien_jobs'
end

--------------------------------
print 'CONFIGURACION DE ENTIDAD'
--------------------------------
--PREREQUISITO
--Tener creado el parámetro ENTIEND en la cobis..cl_parametro

print 'ree_ien_agent_file_def'

if exists (select 1 from cob_ien..ree_ien_agent_file_def where afd_transaction_type = 'DSMBL' and afd_status = 'A'
            and ftd_id = (select ftd_id from ree_ien_file_transfer_def
            where ftd_description = 'DESEMBOLSO SANTANDER'))
begin
    print 'Existe registro en ree_ien_agent_file_def >>DESEMBOLSO SANTANDER<<'
end
else
begin
    EXEC cobis..sp_cseqnos
        @i_tabla = 'ree_ien_agent_file_def',
        @o_siguiente = @w_afd_id out

    select @w_ins_id = ins_id from cob_ien..ree_ien_integration_server
    where ins_name = 'SANTANDER H2H'

    select @w_ftsq_id = null

    select @w_sf_id = min(sf_id) from cob_ien..ree_ien_service_factory
    where sf_type_service = 'DSMBL' and sf_in_out = 'OUT'

    select @w_ftd_id = ftd_id from ree_ien_file_transfer_def
    where ftd_description = 'DESEMBOLSO SANTANDER'

    select @w_ente = en_ente from cobis..cl_ente where en_nombre = 'SANTANDER'

    INSERT INTO ree_ien_agent_file_def
    (
        afd_id, ins_id, ftd_id, ftsq_id, sf_id,
        ag_code, ag_name, afd_ftp_folder, afd_local_folder, afd_allow_encription,
        afd_allow_compression, afd_cron_expression, afd_name_expression, afd_in_out, afd_status,
        afd_optional_parameters, afd_retry_number, afd_only_last_process, afd_transaction_type, afd_allow_confirmation,
        afd_one_file_by_day, afd_allow_old_confirmation, afd_public_key, afd_private_key, afd_private_password,
        afd_type_access, afd_app, afd_allow_reprocess, afd_type_reprocess, afd_allow_statistics,
        afd_allow_process_header, afd_allow_process_footer, afd_encryption_type,
		afd_allow_retry_ftp, afd_retry_number_ftp, afd_milliseconds_interval_ftp
    )
    VALUES
    (
        @w_afd_id, @w_ins_id, @w_ftd_id, @w_ftsq_id, @w_sf_id,
        @w_ente, NULL, 'Inbound', 'send_DSMBL', 1,
        0, '0 35 11,16 ? * MON-FRI *', 'CONCAT(''TRAN'',GETDATE(''yyyyMMdd''),''_CBDS_'',GETDATE(''HHmmss''),''.in2'')', 'OUT', 'B',
        'CFP=3', 0, 0, 'DSMBL', 0,
        0, 0, 'xxx.pgp', 'xxx.pgp', 'xxx',
        'FTP', 'DSMBL', 0, NULL, 0,
        0, 0, 'CUSTOM',
		1, 3, 1000
    )

end




--Recepcion
print 'RECEPCION'
-----------------------------------------------------------------------------
print 'ree_ien_service_factory'
-----------------------------------------------------------------------------
--PREREQUISITO
--

if exists (select 1 from cob_ien..ree_ien_service_factory
           where sf_type_service = 'DSMBL' and sf_in_out = 'IN')

begin
  print 'YA EXISTE LA CONFIGURACION DEL SERVICIO >> IDisbursementProcess << IN'
end
else
begin
    select @w_sf_id = isnull(max(sf_id),0) + 1 from cob_ien..ree_ien_service_factory

    INSERT INTO ree_ien_service_factory (sf_id, sf_package, sf_class, sf_filter, sf_name, sf_type_service, sf_app, sf_en_code, sf_in_out)
    VALUES (@w_sf_id, 'com.cobis.cloud.sofom.operationsexecution.operationalservices.batch.process', 'IDisbursementProcess', 'transactionType=DSMBL', 'Procesamiento de desembolso de crédito', 'DSMBL', 'DSMBL', NULL, 'IN')

end


--------------------------------
print 'ree_ien_object_conf'
--------------------------------
--PREREQUISITO
--


if exists (select 1 from cob_ien..ree_ien_object_conf
               where obj_namespace = 'Disbursement Response' AND obj_property LIKE '%cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto%')
begin
  print 'YA EXISTE LA CONFIGURACION DEL OBJETO >>Disbursement Response<<'
end
else
begin
    select @w_obj_id = isnull(max(obj_id),0) + 1 from cob_ien..ree_ien_object_conf

    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'RecordType', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%recordType]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'SequenceNumber', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%sequenceNumber]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'TransactionCode', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%transactionCode]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'CurrencyCode', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%currencyCode]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'TransferDate', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%transferDate]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'HostBank', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%hostBank]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'RecipientBank', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%recipientBank]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'Amount', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%amount]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'CCEN', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%cCEN]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'TransactionType', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%transactionType]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'ImplementationDate', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%implementationDate]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'PayerAccountType', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payerAccountType]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'PayerAccountNumber', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payerAccountNumber]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'PayerName', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payerName]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'PayerRFC', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payerRFC]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'PayeeAccountType', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payeeAccountType]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'PayeeAccountNumber', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payeeAccountNumber]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'PayeeName', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payeeName]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'PayeeRFC', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payeeRFC]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'ServiceReference', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%serviceReference]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'ServiceOwnerName', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%serviceOwnerName]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'TaxAmount', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%taxAmount]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'PayerReferenceNumber', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payerReferenceNumber]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'PayerReferenceLegend', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payerReferenceLegend]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'TraceKey', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%traceKey]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'RefundReason', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%refundReason]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'InitialPresentationDate', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%initialPresentationDate]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'FutureUse', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%futureUse]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'CustomerReference', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%customerReference]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'PaymentReferenceDescription', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%paymentReferenceDescription]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'PayeeEmail', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payeeEmail]', 'Disbursement Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'DetentionLine', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%detentionLine]', 'Disbursement Response')


end

--------------------------------
print 'ree_ien_file_transfer_def'
--------------------------------
if exists (select 1 from cob_ien..ree_ien_file_transfer_def
           where ftd_description = 'RESULTADO DESEMBOLSO SANTANDER')
begin
  print 'YA EXISTE ARCHIVO DE CONFIGURACION >> RESULTADO DESEMBOLSO SANTANDER <<'
end
else
begin
    EXEC cobis..sp_cseqnos
        @i_tabla = 'ree_ien_file_transfer_def',
        @o_siguiente = @w_ftd_id out

INSERT INTO ree_ien_file_transfer_def (ftd_id, ftd_description, ftd_file_format, ftd_column_separator, ftd_row_separator, ftd_status, ftd_xslt_file, ftd_num_details, ftd_column_transaction_type, ftd_schema, ftd_num_header, ftd_num_footer, ftd_column_valid_row, ftd_is_template)
VALUES (@w_ftd_id, 'RESULTADO DESEMBOLSO SANTANDER', 'TXT', NULL, NULL, 'A', '', 0, 0, NULL, 1, 1, 0, 0)


end


--------------------------------
print 'ree_ien_column_file_def'
--------------------------------
if exists (select 1 from cob_ien..ree_ien_column_file_def where ftd_id = @w_ftd_id)
begin
  print 'YA EXISTEN COLUMNAS DEL ARCHIVO DE CONFIGURACION >>PLANTILLA_GENARCHIVO<<'
end
else
begin

select @w_cftd_id = isnull(siguiente,0)
from cobis..cl_seqnos
where tabla = 'ree_ien_column_file_def'

select @w_ftd_id = ftd_id from ree_ien_file_transfer_def
where ftd_description = 'RESULTADO DESEMBOLSO SANTANDER'

select @w_cftd_order = 0


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'TIPO REGISTRO', 'TIPO DE REGISTRO', 'STRING', 2, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%recordType]', 1, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'NUMERO SECUENCIA', 'NUMERO DE SECUENCIA', 'STRING', 7, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%sequenceNumber]', 2, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'CODIGO OPERACION', 'CODIGO DE OPERACION', 'STRING', 2, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%transactionCode]', 3, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'CODIGO DIVISA', 'CODIGO DE DIVISA', 'STRING', 2, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%currencyCode]', 4, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'FECHA TRANSFERENCIA', 'FECHA DE TRANSFERENCIA', 'STRING', 8, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%transferDate]', 5, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'BANCO PRESENTADOR', 'BANCO PRESENTADOR', 'STRING', 3, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%hostBank]', 6, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'BANCO RECEPTOR', 'BANCO RECEPTOR', 'STRING', 3, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%recipientBank]', 7, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'IMPORTE', 'IMPORTE', 'STRING', 15, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%amount]', 8, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'CCEN', 'USO FUTURO CCEN', 'STRING', 16, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%cCEN]', 9, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'TIPO OPERACION', 'TIPO DE OPERACION', 'STRING', 2, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%transactionType]', 10, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'FECHA APLICACION', 'FECHA DE APLICACION', 'STRING', 8, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%implementationDate]', 11, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'TIPO CUENTA ORDENANTE', 'TIPO CUENTA ORDENANTE', 'STRING', 2, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payerAccountType]', 12, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'NUMERO CUENTA ORDENANTE', 'NUMERO DE CUENTA DE ORDENANTE', 'STRING', 20, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payerAccountNumber]', 13, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'NOMBRE ORDENANTE', 'NOMBRE ORDENANTE', 'STRING', 40, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payerName]', 14, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'RFC ORDENANTE', 'RFC ORDENANTE', 'STRING', 18, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payerRFC]', 15, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'TIPO CUENTA RECEPTOR', 'TIPO CUENTA RECEPTOR', 'STRING', 2, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payeeAccountType]', 16, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'NUMERO CUENTA RECEPTOR', 'NUMERO CUENTA RECEPTOR', 'STRING', 20, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payeeAccountNumber]', 17, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'NOMBRE BENEFICIARIO', 'NOMBRE DEL BENEFICIARIO', 'STRING', 40, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payeeName]', 18, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'RFC BENEFICIARIO', 'RFC DEL BENEFICIARIO', 'STRING', 18, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payeeRFC]', 19, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'REFERENCIA SERVICIO EMISOR', 'REFERENCIA SERVICIO EMISOR', 'STRING', 40, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%serviceReference]', 20, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'NOMBRE TITULAR SERVICIO', 'NOMBRE TITULAR SERVICIO', 'STRING', 40, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%serviceOwnerName]', 21, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'IMPORTE IVA OPERACION', 'IMPORTE DE IVA DE OPERACION', 'STRING', 15, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%taxAmount]', 22, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'REFERENCIA NUMERO ORDENANTE', 'REFERENCIA NUMERO DE ORDENANTE', 'STRING', 7, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payerReferenceNumber]', 23, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'REFERENCIA LEYENDA ORDENANTE', 'REFERENCIA LEYENDA DEL ORDENANTE', 'STRING', 40, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payerReferenceLegend]', 24, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'CLAVE RASTREO', 'CLAVE DE RASTREO', 'STRING', 30, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%traceKey]', 25, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'MOTIVO DEVOLUCION', 'MOTIVO DE DEVOLUCION', 'STRING', 2, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%refundReason]', 26, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'FECHA PRESENTACION INICIAL', 'FECHA DE PRESENTACION INICIAL', 'STRING', 8, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%initialPresentationDate]', 27, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'USO FUTURO', 'USO FUTURO', 'STRING', 12, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%futureUse]', 28, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'REFERENCIA CLIENTE', 'REFERENCIA CLIENTE', 'STRING', 30, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%customerReference]', 29, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'DESCRIPCION REFERENCIA PAGO', 'DESCRIPCION REFERENCIA PAGO', 'STRING', 30, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%paymentReferenceDescription]', 30, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'EMAIL BENEFICIARIOS', 'EMAIL A BENEFICIARIOS', 'STRING', 500, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payeeEmail]', 31, 0)

select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'LINEA CAPTURA', 'LINEA CAPTURA', 'STRING', 100, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%detentionLine]', 32, 0)


    update cobis..cl_seqnos
    set siguiente = @w_cftd_id
    where tabla = 'ree_ien_column_file_def'

end

--------------------------------
print 'ree_ien_jobs'
--------------------------------
--PREREQUISITO
--

if exists (select 1 from cob_ien..ree_ien_jobs
               where jo_transaction_type = 'DSMBL' and jo_status = 'A' AND jo_in_out = 'IN')
begin
  print 'YA EXISTE JOB >>DSMBL IN<<'
end
else
begin
    select @w_co_id = (select co_id from ree_ien_conf_group where co_name = 'SANTANDER')

    select @w_jo_id = isnull(siguiente,0)
    from cobis..cl_seqnos
    where tabla = 'ree_ien_jobs'

    select @w_jo_id = @w_jo_id +1
    INSERT INTO ree_ien_jobs (jo_id, co_id, jo_description, jo_type, jo_cron_expression, jo_service_id, jo_type_cron, jo_has_template, jo_status, jo_in_out, jo_transaction_type)
    VALUES (@w_jo_id, @w_co_id, 'Descarga de Desembolsos', 'DOWNLOAD', '0 45 9-17/1 ? * MON-FRI *', NULL, 'JOB', 1, 'B', 'IN', 'DSMBL')

    select @w_jo_id = @w_jo_id +1
    INSERT INTO ree_ien_jobs (jo_id, co_id, jo_description, jo_type, jo_cron_expression, jo_service_id, jo_type_cron, jo_has_template, jo_status, jo_in_out, jo_transaction_type)
    VALUES (@w_jo_id, @w_co_id, 'Procesamiento de Desembolsos', 'PROCESS', NULL, NULL, 'ENTITY', 1, 'B', 'IN', 'DSMBL')

    update cobis..cl_seqnos
    set siguiente = @w_jo_id
    where tabla = 'ree_ien_jobs'
end

--------------------------------
print 'ree_ien_agent_file_def'
--------------------------------
--PREREQUISITO
--Tener creado el parámetro ENTIEND en la cobis..cl_parametro
if exists (select 1 from cob_ien..ree_ien_agent_file_def where afd_transaction_type = 'DSMBL' and afd_status = 'A'
            and ftd_id = (select ftd_id from ree_ien_file_transfer_def
            where ftd_description = 'RESULTADO DESEMBOLSO SANTANDER'))
begin
print 'ree_ien_agent_file_def'
end
else
begin
    EXEC cobis..sp_cseqnos
        @i_tabla = 'ree_ien_agent_file_def',
        @o_siguiente = @w_afd_id out

    select @w_ins_id = ins_id from cob_ien..ree_ien_integration_server
    where ins_name = 'SANTANDER H2H'

    select @w_ftsq_id = null

    select @w_sf_id = min(sf_id) from cob_ien..ree_ien_service_factory
    where sf_type_service = 'DSMBL' and sf_in_out = 'IN'

    select @w_ftd_id = ftd_id from ree_ien_file_transfer_def
    where ftd_description = 'RESULTADO DESEMBOLSO SANTANDER'

    select @w_ente = en_ente from cobis..cl_ente where en_nombre = 'SANTANDER'

    INSERT INTO dbo.ree_ien_agent_file_def
    (
        afd_id, ins_id, ftd_id, ftsq_id, sf_id,
        ag_code, ag_name, afd_ftp_folder, afd_local_folder, afd_allow_encription,
        afd_allow_compression, afd_cron_expression, afd_name_expression, afd_in_out, afd_status,
        afd_optional_parameters, afd_retry_number, afd_only_last_process, afd_transaction_type, afd_allow_confirmation,
        afd_one_file_by_day, afd_allow_old_confirmation, afd_public_key, afd_private_key, afd_private_password,
        afd_type_access, afd_app, afd_allow_reprocess, afd_type_reprocess, afd_allow_statistics,
        afd_allow_process_header, afd_allow_process_footer, afd_encryption_type,
		afd_allow_retry_ftp, afd_retry_number_ftp, afd_milliseconds_interval_ftp
    )
    VALUES
    (
        @w_afd_id, @w_ins_id, @w_ftd_id, @w_ftsq_id, @w_sf_id,
        @w_ente, NULL, 'Outbound', 'receive_DSMBL', 1,
        0, '0 50 9-17/1 ? * MON-FRI *', 'TRAN\d{8}_CBDS_\d{6}\.98\.out', 'IN', 'B',
        'CFP=3', 0, 0, 'DSMBL', 0,
        0, 0, 'xxx.pgp', 'xxx.pgp', 'xxx',
        'FTP', 'DSMBL', 0, NULL, 0,
        1, 1, 'CUSTOM',
		1, 3, 1000
    )

end
SET NOCOUNT OFF
GO
