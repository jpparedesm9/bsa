/********************************************************************************/
/* Archivo:                IENCobros.sql                                        */
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
/* 2017/09/13    1.0.0       Paúl Clavijo      Arreglo app                      */
/* 2018/03/23    1.0.1       Paúl Clavijo      Domiciliación                    */
/********************************************************************************/

print '-------------------------------------------------------------------------------------------------------------------'
print 'ACTUALIZACION DE SEQNOS E INSERCION DE DATOS'
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
  Print 'Error al actualizar cl_seqnos para tabla ree_ien_jobs'

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
           where sf_type_service = 'COBRO' and sf_in_out = 'OUT')

begin
  print 'YA EXISTE LA CONFIGURACION DEL SERVICIO >>COBRO<< OUT'
end
else
begin
    select @w_sf_id = isnull(max(sf_id),0) + 1 from cob_ien..ree_ien_service_factory

    INSERT INTO ree_ien_service_factory (sf_id, sf_package, sf_class, sf_filter, sf_name, sf_type_service, sf_app, sf_en_code, sf_in_out)
    VALUES (@w_sf_id, 'cobiscorp.ecobis.integrationengine.process.notification', 'IServicesIntegration', 'transactionType=COBRO', 'Cobro de cuota de crédito', 'COBRO', 'COBRO', NULL, 'OUT')
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
               where obj_namespace = 'Direct Debit Mandate Request')
begin
  print 'YA EXISTE LA CONFIGURACION DEL OBJETO >>Direct Debit Mandate Request<<'
end
else
begin
    select @w_obj_id = isnull(max(obj_id),0) from cob_ien..ree_ien_object_conf

    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id + 1, 'Detalle', '[ns1:com.cobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateRequest%detail]', 'Direct Debit Mandate Request')

end


-----------------------------------------------------------------------------
print 'ree_ien_file_transfer_def'
-----------------------------------------------------------------------------

if exists (select 1 from cob_ien..ree_ien_file_transfer_def
           where ftd_description = 'COBRO CUOTA SANTANDER')
begin
  print 'YA EXISTE ARCHIVO DE CONFIGURACION >>COBRO CUOTA SANTANDER<<'
end
else
begin
    EXEC cobis..sp_cseqnos
        @i_tabla = 'ree_ien_file_transfer_def',
        @o_siguiente = @w_ftd_id out

INSERT INTO ree_ien_file_transfer_def (ftd_id, ftd_description, ftd_file_format, ftd_column_separator, ftd_row_separator, ftd_status, ftd_xslt_file, ftd_num_details, ftd_column_transaction_type, ftd_schema, ftd_num_header, ftd_num_footer, ftd_column_valid_row, ftd_is_template)
VALUES (@w_ftd_id, 'COBRO CUOTA SANTANDER', 'TXT', ',', NULL, 'A', '', 0, 0, NULL, 0, 0, 0, 0)

end

-----------------------------------------------------------------------------
print 'ree_ien_column_file_def'
-----------------------------------------------------------------------------

if exists (select 1 from cob_ien..ree_ien_column_file_def where ftd_id = (select ftd_id from cob_ien..ree_ien_file_transfer_def where ftd_description = 'COBRO CUOTA SANTANDER'))
begin
  print 'YA EXISTEN COLUMNAS DEL ARCHIVO DE CONFIGURACION >>PLANTILLA_GENARCHIVO<<'
end
else
begin

    EXEC cobis..sp_cseqnos
        @i_tabla = 'ree_ien_column_file_def',
        @o_siguiente = @w_cftd_id out

 select @w_ftd_id = ftd_id from ree_ien_file_transfer_def
 where ftd_description = 'COBRO CUOTA SANTANDER'

 select @w_cftd_order =1

INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'DETALLE', 'DETALLE COBRO CUOTA CREDITO', 'STRING', 300, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 1, NULL, '[ns1:com.cobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateRequest%detail]', @w_cftd_order, 0)

end


--------------------------------
print 'ree_ien_jobs'
--------------------------------
--PREREQUISITO
--

if exists (select 1 from cob_ien..ree_ien_jobs
               where jo_transaction_type = 'COBRO' and jo_status = 'A' AND jo_in_out = 'OUT')
begin
  print 'YA EXISTE JOB >>COBRO<< OUT'
end
else
begin
    select @w_co_id = (select co_id from ree_ien_conf_group where co_name = 'SANTANDER')

    select @w_jo_id = isnull(siguiente,0)
    from cobis..cl_seqnos
    where tabla = 'ree_ien_jobs'

    select @w_jo_id = @w_jo_id +1
    INSERT INTO ree_ien_jobs (jo_id, co_id, jo_description, jo_type, jo_cron_expression, jo_service_id, jo_type_cron, jo_has_template, jo_status, jo_in_out, jo_transaction_type)
    VALUES (@w_jo_id, @w_co_id, 'Generacion de Cobros', 'SERVICE', '0 32 7-17 ? * MON-FRI *', '1', 'JOB', 1, 'A', 'OUT', 'COBRO')

    select @w_jo_id = @w_jo_id +1
    INSERT INTO ree_ien_jobs (jo_id, co_id, jo_description, jo_type, jo_cron_expression, jo_service_id, jo_type_cron, jo_has_template, jo_status, jo_in_out, jo_transaction_type)
    VALUES (@w_jo_id, @w_co_id, 'Envio de Cobros', 'UPLOAD', NULL, '1', 'ENTITY', 1, 'A', 'OUT', 'COBRO')

    update cobis..cl_seqnos
    set siguiente = @w_jo_id
    where tabla = 'ree_ien_jobs'
end

--------------------------------
print 'CONFIGURACION DE ENTIDAD'
--------------------------------
--PREREQUISITO
--Tener creado el parametro ENTIEND en la cobis..cl_parametro

print 'ree_ien_agent_file_def'

if exists (select 1 from cob_ien..ree_ien_agent_file_def where afd_transaction_type = 'COBRO' and afd_status = 'A'
            and ftd_id = (select ftd_id from ree_ien_file_transfer_def
            where ftd_description = 'COBRO CUOTA SANTANDER'))
begin
    print 'Existe registro en ree_ien_agent_file_def >>COBRO CUOTA SANTANDER<<'
end
else
begin
    EXEC cobis..sp_cseqnos
        @i_tabla = 'ree_ien_agent_file_def',
        @o_siguiente = @w_afd_id out

    select @w_ins_id = ins_id from cob_ien..ree_ien_integration_server
    where ins_name = 'TUIIO INTERNET'

    select @w_ftsq_id = null

    SELECT @w_sf_id = sf_id
	FROM cob_ien..ree_ien_service_factory
    WHERE sf_type_service = 'COBRO' AND sf_in_out = 'OUT'

    select @w_ftd_id = ftd_id from ree_ien_file_transfer_def
    where ftd_description = 'COBRO CUOTA SANTANDER'

    select @w_ente = en_ente from cobis..cl_ente where en_nombre = 'SANTANDER'

    INSERT INTO ree_ien_agent_file_def
    (
        afd_id, ins_id, ftd_id, ftsq_id, sf_id,
        ag_code, ag_name, afd_ftp_folder, afd_local_folder, afd_allow_encription,
        afd_allow_compression, afd_cron_expression, afd_name_expression, afd_in_out, afd_status,
        afd_optional_parameters, afd_retry_number, afd_only_last_process, afd_transaction_type, afd_allow_confirmation,
        afd_one_file_by_day, afd_allow_old_confirmation, afd_public_key, afd_private_key, afd_private_password,
        afd_type_access, afd_app, afd_allow_reprocess, afd_type_reprocess, afd_allow_statistics,
		afd_allow_process_header, afd_allow_process_footer, afd_encryption_type, afd_allow_retry_ftp, afd_retry_number_ftp,
		afd_milliseconds_interval_ftp
    )
    VALUES
    (
        @w_afd_id, @w_ins_id, @w_ftd_id, @w_ftsq_id, @w_sf_id,
        @w_ente, NULL, '\\192.168.31.20\COBRO_OUT', 'send_COBRO', 0,
        0, '0 36 7-17 ? * MON-FRI *', 'CONCAT(''CH20001'',GETDATE(''yyyyMMddHH''),''.TXT'')', 'OUT', 'A',
        'CFP=3', 0, 0, 'COBRO', 0,
        0, 0, NULL, NULL, NULL,
        'FTP', 'COBRO', 0, NULL, 0,
		0, 0, 'CUSTOM', 0, 0,
		0
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
           where sf_type_service = 'COBRO' and sf_in_out = 'IN')

begin
  print 'YA EXISTE LA CONFIGURACION DEL SERVICIO >> IDirectDebitMandateProcess << IN'
end
else
begin
    select @w_sf_id = isnull(max(sf_id),0) + 1 from cob_ien..ree_ien_service_factory

    INSERT INTO ree_ien_service_factory (sf_id, sf_package, sf_class, sf_filter, sf_name, sf_type_service, sf_app, sf_en_code, sf_in_out)
    VALUES (@w_sf_id, 'com.cobis.cloud.sofom.operationsexecution.tradebanking.batch.process', 'IDirectDebitMandateProcess', 'transactionType=COBRO', 'Procesamiento de cobro de cuota de crédito', 'COBRO', 'COBRO', NULL, 'IN')

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
               where obj_namespace = 'Direct Debit Mandate Response')
begin
  print 'YA EXISTE LA CONFIGURACION DEL OBJETO >>Direct Debit Mandate Response<<'
end
else
begin
    select @w_obj_id = isnull(max(obj_id),0) + 1 from cob_ien..ree_ien_object_conf

    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'RecordType', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%recordType]', 'Direct Debit Mandate Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'SequenceNumber', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%sequenceNumber]', 'Direct Debit Mandate Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'TransactionCode', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%transactionCode]', 'Direct Debit Mandate Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'CurrencyCode', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%currencyCode]', 'Direct Debit Mandate Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'Amount', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%amount]', 'Direct Debit Mandate Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'FutureUse1', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%futureUse1]', 'Direct Debit Mandate Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'TransactionType', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%transactionType]', 'Direct Debit Mandate Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'CollectionDate', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%collectionDate]', 'Direct Debit Mandate Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'RecipientBank', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%recipientBank]', 'Direct Debit Mandate Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'CustomerAccountType', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%customerAccountType]', 'Direct Debit Mandate Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'CustomerAccountNumber', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%customerAccountNumber]', 'Direct Debit Mandate Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'CustomerName', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%customerName]', 'Direct Debit Mandate Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'ServiceReference', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%serviceReference]', 'Direct Debit Mandate Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'ServiceOwnerName', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%serviceOwnerName]', 'Direct Debit Mandate Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'TaxAmount', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%taxAmount]', 'Direct Debit Mandate Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'ReferenceNumber', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%referenceNumber]', 'Direct Debit Mandate Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'ReferenceLegend', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%referenceLegend]', 'Direct Debit Mandate Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'Result', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%result]', 'Direct Debit Mandate Response')


    select @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'FutureUse2', '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%futureUse2]', 'Direct Debit Mandate Response')


end

--------------------------------
print 'ree_ien_file_transfer_def'
--------------------------------
if exists (select 1 from cob_ien..ree_ien_file_transfer_def
           where ftd_description = 'RESULTADO COBRO SANTANDER')
begin
  print 'YA EXISTE ARCHIVO DE CONFIGURACION >>RESULTADO COBRO SANTANDER<<'
end
else
begin
    EXEC cobis..sp_cseqnos
        @i_tabla = 'ree_ien_file_transfer_def',
        @o_siguiente = @w_ftd_id out

INSERT INTO ree_ien_file_transfer_def (ftd_id, ftd_description, ftd_file_format, ftd_column_separator, ftd_row_separator, ftd_status, ftd_xslt_file, ftd_num_details, ftd_column_transaction_type, ftd_schema, ftd_num_header, ftd_num_footer, ftd_column_valid_row, ftd_is_template)
VALUES (@w_ftd_id, 'RESULTADO COBRO SANTANDER', 'TXT', NULL, NULL, 'A', '', 0, 0, NULL, 1, 1, 0, 0)


end


--------------------------------
print 'ree_ien_column_file_def'
--------------------------------
if exists (select 1 from cob_ien..ree_ien_column_file_def where ftd_id = (select ftd_id from cob_ien..ree_ien_file_transfer_def where ftd_description = 'RESULTADO COBRO SANTANDER'))
begin
  print 'YA EXISTEN COLUMNAS DEL ARCHIVO DE CONFIGURACION >>COBROS<<'
end
else
begin

select @w_cftd_id = isnull(siguiente,0)
from cobis..cl_seqnos
where tabla = 'ree_ien_column_file_def'

select @w_ftd_id = ftd_id from ree_ien_file_transfer_def
where ftd_description = 'RESULTADO COBRO SANTANDER'

select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order =1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'TIPO REGISTRO', 'TIPO DE REGISTRO', 'STRING', 2, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%recordType]', @w_cftd_order, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'NUMERO SECUENCIA', 'NUMERO SECUENCIA', 'STRING', 7, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%sequenceNumber]', @w_cftd_order, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'CODIGO OPERACION', 'CODIGO DE OPERACION', 'STRING', 2, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%transactionCode]', @w_cftd_order, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'CODIGO DIVISA', 'CODIGO DE DIVISA', 'STRING', 2, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%currencyCode]', @w_cftd_order, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'IMPORTE OPERACION', 'IMPORTE DE LA OPERACION', 'STRING', 15, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%amount]', @w_cftd_order, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'USO FUTURO 1', 'USO FUTURO 1', 'STRING', 32, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%futureUse1]', @w_cftd_order, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'TIPO OPERACION', 'TIPO DE OPERACION', 'STRING', 2, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%transactionType]', @w_cftd_order, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'FECHA COBRO', 'FECHA DE COBRO', 'STRING', 8, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%collectionDate]', @w_cftd_order, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'BANCO RECEPTOR', 'BANCO RECEPTOR DE CLIENTE USUARIO', 'STRING', 3, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%recipientBank]', @w_cftd_order, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'TIPO CUENTA CLIENTE', 'TIPO DE CUENTA DEL CLIENTE USUARIO', 'STRING', 2, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%customerAccountType]', @w_cftd_order, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'NUMERO CUENTA CLIENTE', 'NUMERO DE CUENTA DEL CLIENTE USUARIO', 'STRING', 20, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%customerAccountNumber]', @w_cftd_order, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'NOMBRE CLIENTE', 'NOMBRE DEL CLIENTE USUARIO', 'STRING', 40, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%customerName]', @w_cftd_order, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'REFERENCIA SERVICIO EMISOR', 'REFERENCIA DEL SERVICIO CON EL EMISOR', 'STRING', 40, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%serviceReference]', @w_cftd_order, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'NOMBRE TITULAR SERVICIO', 'NOMBRE DEL TITULAR DE SERVICIO', 'STRING', 40, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%serviceOwnerName]', @w_cftd_order, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'IMPORTE IVA OPERACION', 'IMPORTE DEL IVA DE LA OPERACION', 'STRING', 15, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%taxAmount]', @w_cftd_order, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'REFERENCIA NUMERICA EMISOR', 'REFERENCIA NUMERICA DEL EMISOR', 'STRING', 7, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%referenceNumber]', @w_cftd_order, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'REFERENCIA LEYENDA EMISOR', 'REFERENCIA LEYENDA DEL EMISOR', 'STRING', 40, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%referenceLegend]', @w_cftd_order, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'RESULTADO', 'RESULTADO', 'STRING', 2, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%result]', @w_cftd_order, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'USO FUTURO 2', 'USO FUTURO 2', 'STRING', 21, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.tradebanking.batch.dto][DirectDebitMandate%ns1.DirectDebitMandateResponse%futureUse2]', @w_cftd_order, 0)

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
               where jo_transaction_type = 'COBRO' and jo_status = 'A' AND jo_in_out = 'IN')
begin
  print 'YA EXISTE JOB >>COBRO IN<<'
end
else
begin
    select @w_co_id = (select co_id from ree_ien_conf_group where co_name = 'SANTANDER')

    select @w_jo_id = isnull(siguiente,0)
    from cobis..cl_seqnos
    where tabla = 'ree_ien_jobs'

    select @w_jo_id = @w_jo_id +1
    INSERT INTO ree_ien_jobs (jo_id, co_id, jo_description, jo_type, jo_cron_expression, jo_service_id, jo_type_cron, jo_has_template, jo_status, jo_in_out, jo_transaction_type)
    VALUES (@w_jo_id, @w_co_id, 'Descarga de Cobros', 'DOWNLOAD', '0 22 8-18 ? * MON-FRI *', NULL, 'JOB', 1, 'A', 'IN', 'COBRO')

    select @w_jo_id = @w_jo_id +1
    INSERT INTO ree_ien_jobs (jo_id, co_id, jo_description, jo_type, jo_cron_expression, jo_service_id, jo_type_cron, jo_has_template, jo_status, jo_in_out, jo_transaction_type)
    VALUES (@w_jo_id, @w_co_id, 'Procesamiento de Cobros', 'PROCESS', NULL, NULL, 'ENTITY', 1, 'A', 'IN', 'COBRO')

    update cobis..cl_seqnos
    set siguiente = @w_jo_id
    where tabla = 'ree_ien_jobs'
end

--------------------------------
print 'ree_ien_agent_file_def'
--------------------------------
--PREREQUISITO
--Tener creado el parametro ENTIEND en la cobis..cl_parametro
if exists(select 1 from cob_ien..ree_ien_agent_file_def where afd_transaction_type = 'COBRO' and afd_status = 'A' AND
            ftd_id = (select ftd_id from ree_ien_file_transfer_def where ftd_description = 'RESULTADO COBRO SANTANDER'))
begin
    print 'ree_ien_agent_file_def'
end
else
begin
    EXEC cobis..sp_cseqnos
        @i_tabla = 'ree_ien_agent_file_def',
        @o_siguiente = @w_afd_id out

select @w_ins_id = ins_id from cob_ien..ree_ien_integration_server
where ins_name = 'TUIIO INTERNET'

select @w_ftsq_id = null

select @w_sf_id = min(sf_id) from cob_ien..ree_ien_service_factory
where sf_type_service = 'COBRO' and sf_in_out = 'IN'

select @w_ftd_id = ftd_id from ree_ien_file_transfer_def
where ftd_description = 'RESULTADO COBRO SANTANDER'

    select @w_ente = en_ente from cobis..cl_ente where en_nombre = 'SANTANDER'

    INSERT INTO ree_ien_agent_file_def
    (
        afd_id, ins_id, ftd_id, ftsq_id, sf_id,
        ag_code, ag_name, afd_ftp_folder, afd_local_folder, afd_allow_encription,
        afd_allow_compression, afd_cron_expression, afd_name_expression, afd_in_out, afd_status,
        afd_optional_parameters, afd_retry_number, afd_only_last_process, afd_transaction_type, afd_allow_confirmation,
        afd_one_file_by_day, afd_allow_old_confirmation, afd_public_key, afd_private_key, afd_private_password,
        afd_type_access, afd_app, afd_allow_reprocess, afd_type_reprocess, afd_allow_statistics,
        afd_allow_process_header, afd_allow_process_footer, afd_encryption_type, afd_allow_retry_ftp, afd_retry_number_ftp,
		afd_milliseconds_interval_ftp
    )
    VALUES
    (
        @w_afd_id, @w_ins_id, @w_ftd_id, @w_ftsq_id, @w_sf_id,
        @w_ente, NULL, '\\192.168.31.20\COBRO_IN', 'receive_COBRO', 0,
        0, '0 26 8-18 ? * MON-FRI *', 'CH20001C\d{10}\.TXT', 'IN', 'A',
        'CFP=3', 0, 0, 'COBRO', 0,
        0, 0, NULL, NULL, NULL,
        'FTP', 'COBRO', 0, NULL, 0,
        1, 1, 'CUSTOM', 0, 0,
		0
    )

end
go

SET NOCOUNT OFF
GO
