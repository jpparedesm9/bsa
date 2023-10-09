use cob_ien
go

SET NOCOUNT ON
GO

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


print 'RECEPCION'
-----------------------------------------------------------------------------
print 'ree_ien_service_factory'
-----------------------------------------------------------------------------
--PREREQUISITO
--

if exists (select 1 from cob_ien..ree_ien_service_factory
           where sf_type_service = 'DSMBLCK' and sf_in_out = 'IN')

begin
  print 'YA EXISTE LA CONFIGURACION DEL SERVICIO >> IDisbursementCheckProcess << IN'
end
else
begin
    select @w_sf_id = isnull(max(sf_id),0) + 1 from cob_ien..ree_ien_service_factory

    INSERT INTO ree_ien_service_factory (sf_id, sf_package, sf_class, sf_filter, sf_name, sf_type_service, sf_app, sf_en_code, sf_in_out)
    VALUES (@w_sf_id, 'com.cobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.process', 'IDisbursementCheckProcess', 'transactionType=DSMBLCK', 'Validación de desembolso de crédito', 'DSMBLCK', 'DSBCK', NULL, 'IN')

end


--------------------------------
print 'ree_ien_file_transfer_def'
--------------------------------
if exists (select 1 from cob_ien..ree_ien_file_transfer_def
           where ftd_description = 'RESULTADO CHECK DESEMBOLSO SANTANDER')
begin
  print 'YA EXISTE ARCHIVO DE CONFIGURACION >>RESULTADO CHECK DESEMBOLSO SANTANDER<<'
end
else
begin
    EXEC cobis..sp_cseqnos
        @i_tabla = 'ree_ien_file_transfer_def',
        @o_siguiente = @w_ftd_id out

INSERT INTO ree_ien_file_transfer_def (ftd_id, ftd_description, ftd_file_format, ftd_column_separator, ftd_row_separator, ftd_status, ftd_xslt_file, ftd_num_details, ftd_column_transaction_type, ftd_schema, ftd_num_header, ftd_num_footer, ftd_column_valid_row, ftd_is_template)
VALUES (@w_ftd_id, 'RESULTADO CHECK DESEMBOLSO SANTANDER', 'TXT', NULL, NULL, 'A', '', 0, 0, NULL, 1, 1, 0, 0)

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
where ftd_description = 'RESULTADO CHECK DESEMBOLSO SANTANDER'

select @w_cftd_order = 0

select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'TIPO REGISTRO', 'TIPO DE REGISTRO', 'STRING', 2, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%recordType]', 1, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'NUMERO SECUENCIA', 'NUMERO DE SECUENCIA', 'STRING', 7, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%sequenceNumber]', 2, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'CODIGO OPERACION', 'CODIGO DE OPERACION', 'STRING', 2, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%transactionCode]', 3, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'CODIGO DIVISA', 'CODIGO DE DIVISA', 'STRING', 2, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%currencyCode]', 4, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'FECHA TRANSFERENCIA', 'FECHA DE TRANSFERENCIA', 'STRING', 8, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationalservicescheck.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%transferDate]', 5, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'BANCO PRESENTADOR', 'BANCO PRESENTADOR', 'STRING', 3, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%hostBank]', 6, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'BANCO RECEPTOR', 'BANCO RECEPTOR', 'STRING', 3, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%recipientBank]', 7, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'IMPORTE', 'IMPORTE', 'STRING', 15, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%amount]', 8, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'CCEN', 'USO FUTURO CCEN', 'STRING', 16, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%cCEN]', 9, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'TIPO OPERACION', 'TIPO DE OPERACION', 'STRING', 2, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%transactionType]', 10, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'FECHA APLICACION', 'FECHA DE APLICACION', 'STRING', 8, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%implementationDate]', 11, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'TIPO CUENTA ORDENANTE', 'TIPO CUENTA ORDENANTE', 'STRING', 2, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%payerAccountType]', 12, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'NUMERO CUENTA ORDENANTE', 'NUMERO DE CUENTA DE ORDENANTE', 'STRING', 20, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationalservicescheck.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payerAccountNumber]', 13, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'NOMBRE ORDENANTE', 'NOMBRE ORDENANTE', 'STRING', 40, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationalservicescheck.operationalservices.batch.dto][Disbursement%ns1.DisbursementResponse%payerName]', 14, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'RFC ORDENANTE', 'RFC ORDENANTE', 'STRING', 18, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%payerRFC]', 15, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'TIPO CUENTA RECEPTOR', 'TIPO CUENTA RECEPTOR', 'STRING', 2, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%payeeAccountType]', 16, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'NUMERO CUENTA RECEPTOR', 'NUMERO CUENTA RECEPTOR', 'STRING', 20, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%payeeAccountNumber]', 17, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'NOMBRE BENEFICIARIO', 'NOMBRE DEL BENEFICIARIO', 'STRING', 40, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%payeeName]', 18, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'RFC BENEFICIARIO', 'RFC DEL BENEFICIARIO', 'STRING', 18, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%payeeRFC]', 19, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'REFERENCIA SERVICIO EMISOR', 'REFERENCIA SERVICIO EMISOR', 'STRING', 40, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%serviceReference]', 20, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'NOMBRE TITULAR SERVICIO', 'NOMBRE TITULAR SERVICIO', 'STRING', 40, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%serviceOwnerName]', 21, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'IMPORTE IVA OPERACION', 'IMPORTE DE IVA DE OPERACION', 'STRING', 15, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%taxAmount]', 22, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'REFERENCIA NUMERO ORDENANTE', 'REFERENCIA NUMERO DE ORDENANTE', 'STRING', 7, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%payerReferenceNumber]', 23, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'REFERENCIA LEYENDA ORDENANTE', 'REFERENCIA LEYENDA DEL ORDENANTE', 'STRING', 40, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%payerReferenceLegend]', 24, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'CLAVE RASTREO', 'CLAVE DE RASTREO', 'STRING', 30, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%traceKey]', 25, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'MOTIVO DEVOLUCION', 'MOTIVO DE DEVOLUCION', 'STRING', 2, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%refundReason]', 26, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'FECHA PRESENTACION INICIAL', 'FECHA DE PRESENTACION INICIAL', 'STRING', 8, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%initialPresentationDate]', 27, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'USO FUTURO', 'USO FUTURO', 'STRING', 12, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%futureUse]', 28, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'REFERENCIA CLIENTE', 'REFERENCIA CLIENTE', 'STRING', 30, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%customerReference]', 29, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'DESCRIPCION REFERENCIA PAGO', 'DESCRIPCION REFERENCIA PAGO', 'STRING', 30, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%paymentReferenceDescription]', 30, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'EMAIL BENEFICIARIOS', 'EMAIL A BENEFICIARIOS', 'STRING', 500, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%payeeEmail]', 31, 0)


select @w_cftd_id = @w_cftd_id + 1
select @w_cftd_order = @w_cftd_order + 1
INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
VALUES (@w_cftd_id, NULL, @w_ftd_id, 'LINEA CAPTURA', 'LINEA CAPTURA', 'STRING', 100, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.operationsexecution.operationalservicescheck.batch.dto][Disbursement%ns1.DisbursementResponse%detentionLine]', 32, 0)


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
               where jo_transaction_type = 'DSMBLCK' and jo_status = 'A' AND jo_in_out = 'IN')
begin
  print 'YA EXISTE JOB >>DSMBLCK IN<<'
end
else
begin
    select @w_co_id = (select co_id from ree_ien_conf_group where co_name = 'SANTANDER')

    select @w_jo_id = isnull(siguiente,0)
    from cobis..cl_seqnos
    where tabla = 'ree_ien_jobs'

    select @w_jo_id = @w_jo_id +1
    INSERT INTO ree_ien_jobs (jo_id, co_id, jo_description, jo_type, jo_cron_expression, jo_service_id, jo_type_cron, jo_has_template, jo_status, jo_in_out, jo_transaction_type)
    VALUES (@w_jo_id, @w_co_id, 'Descarga de Chequeo de Desembolso', 'DOWNLOAD', '0 5 9-17/1 ? * MON-FRI *', NULL, 'JOB', 1, 'B', 'IN', 'DSMBLCK')

    select @w_jo_id = @w_jo_id +1
    INSERT INTO ree_ien_jobs (jo_id, co_id, jo_description, jo_type, jo_cron_expression, jo_service_id, jo_type_cron, jo_has_template, jo_status, jo_in_out, jo_transaction_type)
    VALUES (@w_jo_id, @w_co_id, 'Procesamiento de Chequeo de Desembolso', 'PROCESS', NULL, NULL, 'ENTITY', 1, 'B', 'IN', 'DSMBLCK')

    update cobis..cl_seqnos
    set siguiente = @w_jo_id
    where tabla = 'ree_ien_jobs'
end


--------------------------------
print 'ree_ien_agent_file_def'
--------------------------------
--PREREQUISITO
--Tener creado el parámetro ENTIEND en la cobis..cl_parametro
if exists (select 1 from cob_ien..ree_ien_agent_file_def where afd_transaction_type = 'DSMBLCK' and afd_status = 'A'
            and ftd_id = (select ftd_id from ree_ien_file_transfer_def
            where ftd_description = 'RESULTADO CHECK DESEMBOLSO SANTANDER'))
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
    where sf_type_service = 'DSMBLCK' and sf_in_out = 'IN'

    select @w_ftd_id = ftd_id from ree_ien_file_transfer_def
    where ftd_description = 'RESULTADO CHECK DESEMBOLSO SANTANDER'

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
        @w_ente, NULL, 'Outbound', 'receive_DSBCK', 1,
        0, '0 10 9-17/1 ? * MON-FRI *', 'TRAN\d{8}_CBDS_\d{6}\.out', 'IN', 'B',
        'CFP=3', 0, 0, 'DSMBLCK', 0,
        0, 0, 'xxx.pgp', 'xxx.pgp', 'xxx',
        'FTP', 'DSBCK', 0, NULL, 0,
        1, 1, 'CUSTOM',
		1, 3, 1000
    )

end

SET NOCOUNT OFF
GO
