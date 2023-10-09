/********************************************************************************/
/* Archivo:                IENConciliacionAuto.sql                              */
/* Base de datos:          cob_ien                                              */
/* Producto:               Crédito                                              */
/* Creado por:             Jose Sanchez                                         */
/********************************************************************************/
/*                                 IMPORTANTE                                   */
/* Este programa es parte de los paquetes bancarios propiedad de Cobis.         */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier         */
/* alteracion o agregado hecho por alguno de usuarios sin el debido             */
/* consentimiento por escrito de la Presidencia Ejecutiva de Cobis              */
/* o su representante.                                                          */
/********************************************************************************/
/*                                PROPOSITO                                     */
/*			Creación de estructuras para recibir información de Conciliacion    */
/*									Santander                                   */
/********************************************************************************/
/*                              MODIFICACIONES                                  */
/* FECHA      VERSION     AUTOR             RAZON                               */
/********************************************************************************/

USE cob_ien
GO

SET NOCOUNT ON
GO

PRINT '-------------------------------------------------------------------------------------------------------------------'
PRINT 'ACTUALIZACION DE SEQNOS E INSERCION DE DATOS'
PRINT '-------------------------------------------------------------------------------------------------------------------'

DECLARE
    @w_ftd_id     INT,
    @w_cftd_id    INT,
    @w_jo_id      INT

--------------------
PRINT 'ree_ien_jobs'
--------------------

SELECT @w_jo_id = MAX(jo_id)
FROM cob_ien..ree_ien_jobs

SELECT @w_jo_id = ISNULL(@w_jo_id, 0)

UPDATE cobis..cl_seqnos
SET siguiente = @w_jo_id
WHERE tabla = 'ree_ien_jobs'

If @@ROWCOUNT = 0
    PRINT 'Error al actualizar cl_seqnos para tabla ree_ien_jobs'

-------------------------------
PRINT 'ree_ien_column_file_def'
-------------------------------

SELECT @w_cftd_id = MAX(cftd_id)
FROM cob_ien..ree_ien_column_file_def

SELECT @w_cftd_id = ISNULL(@w_cftd_id, 0)

UPDATE cobis..cl_seqnos
SET siguiente = @w_cftd_id
WHERE tabla = 'ree_ien_column_file_def'

IF @@ROWCOUNT = 0
    PRINT 'Error al actualizar cl_seqnos para tabla ree_ien_column_file_def'

---------------------------------
PRINT 'ree_ien_file_transfer_def'
---------------------------------

SELECT @w_ftd_id = MAX(ftd_id)
FROM cob_ien..ree_ien_file_transfer_def

SELECT @w_ftd_id = ISNULL(@w_ftd_id, 0)

UPDATE cobis..cl_seqnos
SET siguiente = @w_ftd_id
WHERE tabla = 'ree_ien_file_transfer_def'

IF @@ROWCOUNT = 0
    PRINT 'Error al actualizar cl_seqnos para tabla ree_ien_file_transfer_def'

--------------------
PRINT 'ree_ien_agent_file_def'
--------------------

SELECT @w_jo_id = MAX(afd_id)
FROM cob_ien..ree_ien_agent_file_def

SELECT @w_jo_id = ISNULL(@w_jo_id, 0)

UPDATE cobis..cl_seqnos
SET siguiente = @w_jo_id
WHERE tabla = 'ree_ien_agent_file_def'

If @@ROWCOUNT = 0
    PRINT 'Error al actualizar cl_seqnos para tabla ree_ien_agent_file_def'

GO


DECLARE
    @w_ente       INT,
    @w_sf_id      INT,
    @w_ins_id     INT,
    @w_ftsq_id    INT,
    @w_obj_id     INT,
    @w_ftd_id     INT,
    @w_cftd_id    INT,
    @w_co_id      INT,
    @w_jo_id      INT,
    @w_afd_id     INT,
    @w_cftd_order INT



PRINT '**********************************'
PRINT '*** CONFIGURACION DE RECEPCION ***'
PRINT '**********************************'

-----------------------------------------------------------------------------
PRINT 'ree_ien_service_factory'
-----------------------------------------------------------------------------

IF EXISTS (SELECT 1 FROM cob_ien..ree_ien_service_factory
           WHERE sf_type_service = 'APCDT' AND sf_in_out = 'IN')
BEGIN
    PRINT 'YA EXISTE LA CONFIGURACION DEL SERVICIO >> ITransactionDetailProcess << IN'
END
ELSE
BEGIN
    SELECT @w_sf_id = ISNULL(MAX(sf_id),0) + 1
    FROM cob_ien..ree_ien_service_factory
	
	INSERT INTO cob_ien..ree_ien_service_factory (sf_id, sf_package, sf_class, sf_filter, sf_name, sf_type_service, sf_app, sf_en_code, sf_in_out)
	VALUES (@w_sf_id,'cobiscorp.ecobis.integrationengine.conciliation.service.process','ITransactionDetailProcess','transactionType=APCDT','Conciliacion Automatica','APCDT','CDT',null, 'IN')

END


--------------------------------
PRINT 'ree_ien_object_conf'
--------------------------------

IF EXISTS (SELECT 1 FROM cob_ien..ree_ien_object_conf
           WHERE obj_namespace = 'CDT')
BEGIN
    PRINT 'YA EXISTE LA CONFIGURACION DEL OBJETO >> CDT <<'
END
ELSE
BEGIN
    SELECT @w_obj_id = ISNULL(MAX(obj_id), 0)
    FROM cob_ien..ree_ien_object_conf

    SELECT @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'idTransaction', '[ns1:cobiscorp.ecobis.integrationengine.conciliation.service.dto][TransactionDetail%ns1.TransactionDetailDTO%idTransaction]', 'CDT')


    SELECT @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'correspondent', '[ns1:cobiscorp.ecobis.integrationengine.conciliation.service.dto][TransactionDetail%ns1.TransactionDetailDTO%correspondent]', 'CDT')


    SELECT @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'trnCorrespondent', '[ns1:cobiscorp.ecobis.integrationengine.conciliation.service.dto][TransactionDetail%ns1.TransactionDetailDTO%trnCorrespondent]', 'CDT')


    SELECT @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'payReference', '[ns1:cobiscorp.ecobis.integrationengine.conciliation.service.dto][TransactionDetail%ns1.TransactionDetailDTO%payReference]', 'CDT')


    SELECT @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'executionDate', '[ns1:cobiscorp.ecobis.integrationengine.conciliation.service.dto][TransactionDetail%ns1.TransactionDetailDTO%executionDate]', 'CDT')


    SELECT @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'amount', '[ns1:cobiscorp.ecobis.integrationengine.conciliation.service.dto][TransactionDetail%ns1.TransactionDetailDTO%amount]', 'CDT')


    SELECT @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'reverse', '[ns1:cobiscorp.ecobis.integrationengine.conciliation.service.dto][TransactionDetail%ns1.TransactionDetailDTO%reverse]', 'CDT')


    SELECT @w_obj_id = @w_obj_id + 1
    INSERT INTO ree_ien_object_conf (obj_id, obj_name, obj_property, obj_namespace)
    VALUES (@w_obj_id, 'trnReverse', '[ns1:cobiscorp.ecobis.integrationengine.conciliation.service.dto][TransactionDetail%ns1.TransactionDetailDTO%trnReverse]', 'CDT')

END


--------------------------------
PRINT 'ree_ien_file_transfer_def'
--------------------------------

IF EXISTS (SELECT 1 FROM cob_ien..ree_ien_file_transfer_def
           WHERE ftd_description = 'CONCILIACION AUTOMATICA SANTANDER')
BEGIN
    PRINT 'YA EXISTE ARCHIVO DE CONFIGURACION >> CONCILIACION AUTOMATICA SANTANDER <<'
END
ELSE
BEGIN
    EXEC cobis..sp_cseqnos
        @i_tabla = 'ree_ien_file_transfer_def',
        @o_siguiente = @w_ftd_id out

    INSERT INTO ree_ien_file_transfer_def (ftd_id, ftd_description, ftd_file_format, ftd_column_separator, ftd_row_separator, ftd_status, ftd_xslt_file, ftd_num_details, ftd_column_transaction_type, ftd_schema, ftd_num_header, ftd_num_footer, ftd_column_valid_row, ftd_is_template)
    VALUES (@w_ftd_id, 'CONCILIACION AUTOMATICA SANTANDER', 'TXT', NULL, NULL, 'A', '', 0, 0, NULL, 0, 1, 0, 0)
END


--------------------------------
PRINT 'ree_ien_column_file_def'
--------------------------------

IF EXISTS (SELECT 1 FROM cob_ien..ree_ien_column_file_def
           WHERE ftd_id = (SELECT ftd_id FROM cob_ien..ree_ien_file_transfer_def WHERE ftd_description = 'CONCILIACION AUTOMATICA SANTANDER'))
BEGIN
    PRINT 'YA EXISTEN COLUMNAS DEL ARCHIVO DE CONFIGURACION >> CONCILIACION AUTOMATICA SANTANDER <<'
END
ELSE
BEGIN
    SELECT @w_cftd_id = ISNULL(siguiente, 0)
    FROM cobis..cl_seqnos
    WHERE tabla = 'ree_ien_column_file_def'

    SELECT @w_ftd_id = ftd_id FROM ree_ien_file_transfer_def
    WHERE ftd_description = 'CONCILIACION AUTOMATICA SANTANDER'

    SELECT @w_cftd_id = @w_cftd_id + 1
    SELECT @w_cftd_order = 1
    INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
    VALUES (@w_cftd_id, NULL, @w_ftd_id, 'NUMERO CUENTA', 'NUMERO DE CUENTA', 'STRING', 16, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, null, @w_cftd_order, 0)


    SELECT @w_cftd_id = @w_cftd_id + 1
    SELECT @w_cftd_order = @w_cftd_order + 1
    INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
    VALUES (@w_cftd_id, NULL, @w_ftd_id, 'FECHA MOVIMIENTO', 'FECHA DEL MOVIMIENTO', 'STRING', 8, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.integrationengine.conciliation.service.dto][TransactionDetail%ns1.TransactionDetailDTO%executionDate]', @w_cftd_order, 0)


    SELECT @w_cftd_id = @w_cftd_id + 1
    SELECT @w_cftd_order = @w_cftd_order + 1
    INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
    VALUES (@w_cftd_id, NULL, @w_ftd_id, 'HORA MOVIMIENTO', 'HORA DEL MOVIMIENTO', 'STRING', 4, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, null, @w_cftd_order, 0)


    SELECT @w_cftd_id = @w_cftd_id + 1
    SELECT @w_cftd_order = @w_cftd_order + 1
    INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
    VALUES (@w_cftd_id, NULL, @w_ftd_id, 'CANAL', 'CANAL', 'STRING', 4, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, null, @w_cftd_order, 0)


    SELECT @w_cftd_id = @w_cftd_id + 1
    SELECT @w_cftd_order = @w_cftd_order + 1
    INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
    VALUES (@w_cftd_id, NULL, @w_ftd_id, 'CLACON', 'CLAVE DE CONCEPTO', 'STRING', 4, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, null, @w_cftd_order, 0)


    SELECT @w_cftd_id = @w_cftd_id + 1
    SELECT @w_cftd_order = @w_cftd_order + 1
    INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
    VALUES (@w_cftd_id, NULL, @w_ftd_id, 'CONCEPTO', 'CONCEPTO', 'STRING', 40, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.integrationengine.conciliation.service.dto][TransactionDetail%ns1.TransactionDetailDTO%payReference]', @w_cftd_order, 0)


    SELECT @w_cftd_id = @w_cftd_id + 1
    SELECT @w_cftd_order = @w_cftd_order + 1
    INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
    VALUES (@w_cftd_id, NULL, @w_ftd_id, 'SIGNO', 'SIGNO', 'STRING', 1, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.integrationengine.conciliation.service.dto][TransactionDetail%ns1.TransactionDetailDTO%reverse]', @w_cftd_order, 0)


    SELECT @w_cftd_id = @w_cftd_id + 1
    SELECT @w_cftd_order = @w_cftd_order + 1
    INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
    VALUES (@w_cftd_id, NULL, @w_ftd_id, 'IMPORTE', 'IMPORTE', 'STRING', 14, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.integrationengine.conciliation.service.dto][TransactionDetail%ns1.TransactionDetailDTO%amount]', @w_cftd_order, 0)


    SELECT @w_cftd_id = @w_cftd_id + 1
    SELECT @w_cftd_order = @w_cftd_order + 1
    INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
    VALUES (@w_cftd_id, NULL, @w_ftd_id, 'SALDO', 'SALDO', 'STRING', 14, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, null, @w_cftd_order, 0)


    SELECT @w_cftd_id = @w_cftd_id + 1
    SELECT @w_cftd_order = @w_cftd_order + 1
    INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
    VALUES (@w_cftd_id, NULL, @w_ftd_id, 'FOLIO BANCO', 'FOLIO BANCO', 'STRING', 8, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, '[ns1:cobiscorp.ecobis.integrationengine.conciliation.service.dto][TransactionDetail%ns1.TransactionDetailDTO%trnCorrespondent]', null, @w_cftd_order, 0)


    SELECT @w_cftd_id = @w_cftd_id + 1
    SELECT @w_cftd_order = @w_cftd_order + 1
    INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
    VALUES (@w_cftd_id, NULL, @w_ftd_id, 'DESCRIPCION CLACON', 'DESCRIPCION DE CLAVE DE CONCEPTO', 'STRING', 40, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, null, @w_cftd_order, 0)


    SELECT @w_cftd_id = @w_cftd_id + 1
    SELECT @w_cftd_order = @w_cftd_order + 1
    INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
    VALUES (@w_cftd_id, NULL, @w_ftd_id, 'LEYENDA REF', 'LEYENDA REFERENCIA', 'STRING', 5, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, null, @w_cftd_order, 0)


    SELECT @w_cftd_id = @w_cftd_id + 1
    SELECT @w_cftd_order = @w_cftd_order + 1
    INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
    VALUES (@w_cftd_id, NULL, @w_ftd_id, 'REFERENCIA INTERBANCARIA', 'REFERENCIA INTERBANCARIA', 'STRING', 7, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, NULL, @w_cftd_order, 0)


    SELECT @w_cftd_id = @w_cftd_id + 1
    SELECT @w_cftd_order = @w_cftd_order + 1
    INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
    VALUES (@w_cftd_id, NULL, @w_ftd_id, 'EN BLANCO', 'ESPACIO EN BLANCO', 'STRING', 1, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, null, @w_cftd_order, 0)


    SELECT @w_cftd_id = @w_cftd_id + 1
    SELECT @w_cftd_order = @w_cftd_order + 1
    INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
    VALUES (@w_cftd_id, NULL, @w_ftd_id, 'SALDO INICIAL', 'SALDO INICIAL', 'STRING', 14, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, null, @w_cftd_order, 0)


    SELECT @w_cftd_id = @w_cftd_id + 1
    SELECT @w_cftd_order = @w_cftd_order + 1
    INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
    VALUES (@w_cftd_id, NULL, @w_ftd_id, 'SALDO FINAL', 'SALDO FINAL', 'STRING', 14, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, null, @w_cftd_order, 0)


    SELECT @w_cftd_id = @w_cftd_id + 1
    SELECT @w_cftd_order = @w_cftd_order + 1
    INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
    VALUES (@w_cftd_id, NULL, @w_ftd_id, 'REFERENCIA CLIENTE', 'REFERENCIA CLIENTE', 'STRING', 20, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, null, @w_cftd_order, 0)


    SELECT @w_cftd_id = @w_cftd_id + 1
    SELECT @w_cftd_order = @w_cftd_order + 1
    INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
    VALUES (@w_cftd_id, NULL, @w_ftd_id, 'MONEDA', 'MONEDA', 'STRING', 3, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, null, @w_cftd_order, 0)


    SELECT @w_cftd_id = @w_cftd_id + 1
    SELECT @w_cftd_order = @w_cftd_order + 1
    INSERT INTO ree_ien_column_file_def (cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden)
    VALUES (@w_cftd_id, NULL, @w_ftd_id, 'NUMERO MOVIMIENTO', 'NUMERO DE MOVIMIENTO', 'STRING', 10, '', 'NONE', NULL, @w_cftd_order, 'DETAIL', 0, NULL, null, @w_cftd_order, 0)

    UPDATE cobis..cl_seqnos
    SET siguiente = @w_cftd_id
    WHERE tabla = 'ree_ien_column_file_def'
END


--------------------------------
PRINT 'ree_ien_jobs'
--------------------------------

IF EXISTS (SELECT 1 FROM cob_ien..ree_ien_jobs
           WHERE jo_transaction_type = 'APCDT' AND jo_status = 'A' AND jo_in_out = 'IN')
BEGIN
    PRINT 'YA EXISTE JOB >> APCDT IN <<'
END
ELSE
BEGIN
    SELECT @w_co_id = co_id
    FROM ree_ien_conf_group
    WHERE co_name = 'SANTANDER'

    SELECT @w_jo_id = ISNULL(siguiente, 0)
    FROM cobis..cl_seqnos
    WHERE tabla = 'ree_ien_jobs'

    SELECT @w_jo_id = @w_jo_id + 1
    INSERT INTO ree_ien_jobs (jo_id, co_id, jo_description, jo_type, jo_cron_expression, jo_service_id, jo_type_cron, jo_has_template, jo_status, jo_in_out, jo_transaction_type)
    VALUES (@w_jo_id, @w_co_id, 'Descarga de conciliacion santander', 'DOWNLOAD', '0 0/5 * ? * MON-FRI *', NULL, 'JOB', 1, 'A', 'IN', 'APCDT')

    SELECT @w_jo_id = @w_jo_id + 1
    INSERT INTO ree_ien_jobs (jo_id, co_id, jo_description, jo_type, jo_cron_expression, jo_service_id, jo_type_cron, jo_has_template, jo_status, jo_in_out, jo_transaction_type)
    VALUES (@w_jo_id, @w_co_id, 'Procesamiento de conciliacion santander', 'PROCESS', '0 0/5 * ? * MON-FRI *', NULL, 'ENTITY', 1, 'A', 'IN', 'APCDT')

    UPDATE cobis..cl_seqnos
    SET siguiente = @w_jo_id
    WHERE tabla = 'ree_ien_jobs'
END

--------------------------------
PRINT 'ree_ien_agent_file_def'
--------------------------------
IF EXISTS (SELECT 1 FROM cob_ien..ree_ien_agent_file_def
           WHERE afd_transaction_type = 'APCDT' AND afd_status = 'A' AND ftd_id = (SELECT ftd_id FROM ree_ien_file_transfer_def
                                                                                   WHERE ftd_description = 'CONCILIACION AUTOMATICA SANTANDER'))
BEGIN
    PRINT 'YA EXISTE DEFINICION DE ARCHIVO >> APCDT IN <<'
END
ELSE
BEGIN
    EXEC cobis..sp_cseqnos
        @i_tabla = 'ree_ien_agent_file_def',
        @o_siguiente = @w_afd_id out

    SELECT @w_ins_id = ins_id
    FROM cob_ien..ree_ien_integration_server
    WHERE ins_name = 'TUIIO INTERNET'

    SELECT @w_ftsq_id = NULL

    SELECT @w_sf_id = sf_id
    FROM cob_ien..ree_ien_service_factory
    WHERE sf_type_service = 'APCDT' AND sf_in_out = 'IN'

    SELECT @w_ftd_id = ftd_id
    FROM ree_ien_file_transfer_def
    WHERE ftd_description = 'CONCILIACION AUTOMATICA SANTANDER'

    SELECT @w_ente = en_ente
    FROM cobis..cl_ente
    WHERE en_nombre = 'SANTANDER'
	AND en_subtipo = 'C'

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
        @w_ente, NULL, '\\192.168.66.138\testconciliation', 'receive_APCDT', 0,
        0, '0 0/5 * ? * MON-FRI *', 'H2H_43009668_\d{8}_\d{6}_\.edocta.copy', 'IN', 'A',
        'CFP=3', 0, 0, 'APCDT', 0,
        0, 0, NULL, NULL, NULL,
        'FTP', 'CDT', 0, NULL, 0,
        0, 0, 'CUSTOM', 0, 0,
		0
    )

END

--REGISTRO DEL SERVICIO EN EL CATALOGO IEN
declare 
@cod_cat int,
@ro_rol  int

select @ro_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'

select @cod_cat = codigo from cobis..cl_tabla where tabla ='ree_ien_transaction_type'
delete from cobis..cl_catalogo where tabla = @cod_cat and codigo = 'APCDT'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@cod_cat, 'APCDT', 'IEN_CONSOLIDATE', 'V')

delete from cobis..cts_serv_catalog where csc_service_id = 'IConciliationBusiness.beforeProcessFile'
insert into cobis..cts_serv_catalog (csc_service_id,csc_class_name,csc_method_name,csc_description,csc_trn,csc_support_offline,csc_procedure_validation,csc_component)
values('IConciliationBusiness.beforeProcessFile','cobiscorp.ecobis.integrationengine.conciliation.business.api.IConciliationBusiness','beforeProcessFile','Step before process file',null,null,null,null)

delete from cobis..ad_servicio_autorizado where ts_servicio = 'IConciliationBusiness.beforeProcessFile'
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('IConciliationBusiness.beforeProcessFile',@ro_rol,1,'R',0,getdate(),'V',getdate())
 
delete from cobis..cts_serv_catalog where csc_service_id = 'IConciliationBusiness.afterProcessFile'
insert into cobis..cts_serv_catalog (csc_service_id,csc_class_name,csc_method_name,csc_description,csc_trn,csc_support_offline,csc_procedure_validation,csc_component)
values('IConciliationBusiness.afterProcessFile','cobiscorp.ecobis.integrationengine.conciliation.business.api.IConciliationBusiness','afterProcessFile','Step after process file',null,null,null,null)

delete from cobis..ad_servicio_autorizado where ts_servicio = 'IConciliationBusiness.afterProcessFile'
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('IConciliationBusiness.afterProcessFile',@ro_rol,1,'R',0,getdate(),'V',getdate())

GO

SET NOCOUNT OFF
GO
