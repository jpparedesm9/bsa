/********************************************************************************/
/* Archivo:                IENListasNegras.sql                                  */
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
/* 															                    */
/********************************************************************************/

print '-------------------------------------------------------------------------------------------------------------------'
print 'BORRADO TABLAS IEN'
print '-------------------------------------------------------------------------------------------------------------------'

SET NOCOUNT ON
GO
use cob_ien
go

declare
@w_ente       INT,
@w_transaction_type VARCHAR(10),
@w_object	VARCHAR(40)

select @w_transaction_type='LSTNG'
select @w_object ='REGULATORYCOMPLIANCERESPONSE'

if exists(SELECT 1 FROM ree_ien_transactions_files WHERE ftr_id IN (SELECT ftr_id FROM ree_ien_file_transfer WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type = @w_transaction_type)))
begin
DELETE FROM ree_ien_transactions_files WHERE ftr_id IN (SELECT ftr_id FROM ree_ien_file_transfer WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type = @w_transaction_type))
end

if exists(SELECT 1 FROM ree_ien_file_transfer WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type = @w_transaction_type))
begin
 DELETE FROM ree_ien_file_transfer WHERE afd_id IN (SELECT afd_id FROM ree_ien_agent_file_def where afd_transaction_type = @w_transaction_type)
end

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

if exists(select 1 from cob_ien..ree_ien_entities_groups where en_name = 'SANTANDER')
begin
print 'DELETE-ree_ien_entities_groups-LSTNG'
delete from cob_ien..ree_ien_entities_groups where en_name = 'SANTANDER'
end
go

SET NOCOUNT OFF
GO


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

----------------------------------
Print 'ree_ien_integration_server'
----------------------------------

select @w_ins_id = max(ins_id) 
from cob_ien..ree_ien_integration_server

select @w_ins_id = isnull (@w_ins_id,0)

update cobis..cl_seqnos
set siguiente = @w_ins_id
where tabla = 'ree_ien_integration_server'

if @@rowcount = 0
  Print 'Error al actualizar cl_seqnos para tabla ree_ien_integration_server'
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

--------------------------
Print 'ree_ien_conf_group'
--------------------------

select @w_co_id = max(co_id)
from cob_ien..ree_ien_conf_group

select @w_co_id = isnull (@w_co_id,0)

update cobis..cl_seqnos
set siguiente = @w_co_id
where tabla = 'ree_ien_conf_group'

if @@rowcount = 0
  Print 'Error al actualizar cl_seqnos para tabla ree_ien_conf_group'
  
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


  
SET NOCOUNT OFF
GO 
  
print '--------ENVIO------'

if exists(select 1 from cobis..cl_seqnos where tabla ='cr_lista_negra')
begin
    print '---ACTUALIZA SEQNOS----'
    update cobis..cl_seqnos
    set siguiente = 0
    where tabla ='cr_lista_negra'
END
ELSE
BEGIN
    print '---INSERTA SEQNOS----'
    insert into cobis..cl_seqnos values ('cob_credito','cr_lista_negra',0,'cr_lista_negra_key')
end

SET NOCOUNT ON
GO
use cob_ien
go

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
@w_cftd_order int,
@w_transaction_nm VARCHAR(20)

SELECT @w_transaction_nm='LSTNG'


if exists (Select 1 from cobis..cl_ente where en_nombre = 'SANTANDER')
 begin
	select @w_ente = en_ente from cobis..cl_ente where en_nombre = 'SANTANDER'
 end
 else 
 begin
	declare @w_secuencial int

	exec sp_cseqnos 
	@i_tabla = 'cl_ente', 
	@o_siguiente = @w_secuencial out

	insert into cobis.dbo.cl_ente (en_ente,en_nombre,en_subtipo,en_filial,en_oficina,en_fecha_mod,en_retencion,en_mala_referencia,en_tipo_ced)
	values (@w_secuencial,'SANTANDER','C',1,1,getdate(),'S','N','CI')
	select @w_ente = en_ente from cobis..cl_ente where en_nombre = 'SANTANDER'
 end
 
-----------------------------------------------------------------------------
print 'ree_ien_service_factory'
-----------------------------------------------------------------------------
--PREREQUISITO
--

print 'ree_ien_service_factory'

if exists (select 1 from cob_ien..ree_ien_service_factory
           where sf_type_service = @w_transaction_nm and sf_in_out = 'IN')
		                      
begin
  print 'YA EXISTE LA CONFIGURACION DEL SERVICIO >> LSTNG<< IN'
end
else
begin
	select @w_sf_id = isnull(max(sf_id),0) + 1 from cob_ien..ree_ien_service_factory
	
	INSERT INTO ree_ien_service_factory (sf_id, sf_package, sf_class, sf_filter, sf_name, sf_type_service, sf_app, sf_en_code, sf_in_out)
	VALUES (@w_sf_id, 'com.cobis.cloud.sofom.riskcompliance.regulationscompliance.batch.process', 'IRegulatoryComplianceProcess', 'transactionType=LSTNG', 'PROCESAMIENTO DE LISTAS NEGRAS', 'LSTNG', 'IEN', NULL, 'IN')
end


--------------------------------
print 'ree_ien_object_conf'
--------------------------------
--PREREQUISITO
--

if exists (select 1 from cob_ien..ree_ien_object_conf
               where obj_namespace = 'REGULATORYCOMPLIANCERESPONSE')
begin
  print 'YA EXISTE LA CONFIGURACION DEL OBJETO >>REGULATORYCOMPLIANCERESPONSE<<'
end
else
begin
	select @w_obj_id = isnull(max(obj_id),0) + 1 from cob_ien..ree_ien_object_conf

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id, 'idList', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%idList]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id +2, 'name', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%name]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id +3, 'lastName', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%lastName]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id +4, 'motherLastName', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%motherLastName]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id + 5, 'curp', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%curp]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id + 6, 'rfc', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%rfc]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id + 7, 'birthDate', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%birthDate]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id + 8, 'listType', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%listType]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id + 9, 'status', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%status]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id + 10, 'dependency', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%dependency]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id + 11, 'position', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%position]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id + 12, 'iddispo', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%iddispo]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id + 13, 'curpOk', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%curpOk]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id + 14, 'idRelation', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%idRelation]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id + 15, 'relationship', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%relationship]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id + 16, 'businessName', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%businessName]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id + 17, 'moralRfc', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%moralRfc]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id + 18, 'socialSecurityNumber', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%socialSecurityNumber]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id + 19, 'imss', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%imss]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id + 20, 'incomes', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%incomes]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id + 21, 'largeName', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%largeName]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id + 22, 'completeLastName', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%completeLastName]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id + 23, 'entity', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%entity]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id + 24, 'sex', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%sex]', 'REGULATORYCOMPLIANCERESPONSE' )

	INSERT INTO cob_ien..ree_ien_object_conf ( obj_id, obj_name, obj_property, obj_namespace ) 
	VALUES ( @w_obj_id + 25, 'area', '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%area]', 'REGULATORYCOMPLIANCERESPONSE' )
			   
end

-------------------------------
print 'ree_ien_integration_server'
-------------------------------
--PREREQUISITO
--

if exists (select 1 from cob_ien..ree_ien_integration_server where ins_name = 'SANTANDER')
begin
  print 'YA EXISTE SERVIDOR DE FTP >>SANTANDER<<'
end
else
begin
  select @w_ins_id = isnull(siguiente,0) + 1
  from cobis..cl_seqnos
  where tabla = 'ree_ien_integration_server'
  
	INSERT INTO ree_ien_integration_server (ins_id, ins_name, ins_description, ins_login, ins_password, ins_server, ins_type_server, ins_port_number, ins_key_store_file, ins_key_store_password, ins_private_key, ins_private_key_pass)
	VALUES (@w_ins_id, 'SANTANDER', 'SANTANDER', 'usuarioftp1', 'liEuYJCG5HlmyF8hxzgQoA==', '192.168.64.255', 'FTP_ACT', 21, NULL, NULL, NULL, NULL)
end

-----------------------------------------------------------------------------
print 'ree_ien_file_transfer_def'
-----------------------------------------------------------------------------

if exists (select 1 from cob_ien..ree_ien_file_transfer_def
           where ftd_description = 'LISTAS NEGRAS')
begin
  print 'YA EXISTE ARCHIVO DE CONFIGURACION >>LISTAS NEGRAS<<'
end
else
begin
  select @w_ftd_id =  isnull(siguiente,0) + 1
  from cobis..cl_seqnos
  where tabla = 'ree_ien_file_transfer_def'

INSERT INTO ree_ien_file_transfer_def (ftd_id, ftd_description, ftd_file_format, ftd_column_separator, ftd_row_separator, ftd_status, ftd_xslt_file, ftd_num_details, ftd_column_transaction_type, ftd_schema, ftd_num_header, ftd_num_footer, ftd_column_valid_row, ftd_is_template)
VALUES (@w_ftd_id, 'LISTAS NEGRAS', 'TXT', '|', NULL, 'A', '', 0, 0, NULL, 0, 0, 0, 0)

end

-----------------------------------------------------------------------------
print 'ree_ien_column_file_def'
-----------------------------------------------------------------------------

if exists (select 1 from cob_ien..ree_ien_column_file_def where ftd_id = (select ftd_id from cob_ien..ree_ien_file_transfer_def where ftd_description = 'LISTAS NEGRAS'))
begin
  print 'YA EXISTEN COLUMNAS DEL ARCHIVO DE CONFIGURACION >>LISTAS NEGRAS<<'
end
else
begin

select @w_cftd_id = isnull(siguiente,0) + 1
  from cobis..cl_seqnos
  where tabla = 'ree_ien_column_file_def'
  
 select @w_ftd_id = ftd_id from ree_ien_file_transfer_def
 where ftd_description = 'LISTAS NEGRAS'
 
 select @w_cftd_order =1

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id, NULL, @w_ftd_id, 'ID_PERSONA', 'ID PERSONA QUIEN ES QUIEN', 'STRING', 25, ' ', 'NONE', NULL, 1, 'DETAIL', 1, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%idList]', 1, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES (@w_cftd_id +2, NULL, @w_ftd_id, 'NOMBRE', 'NOMBRE DEL ENTE', 'STRING', 100, ' ', 'NONE', NULL, 2, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%name]', 2, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +3, NULL, @w_ftd_id, 'CURP', 'CURP', 'STRING', 20, ' ', 'NONE', NULL, 5, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%curp]', 5, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +4, NULL, @w_ftd_id, 'RFC', 'REGISTRO FEDERAL DE CONTRIBUYENTES', 'STRING', 15, ' ', 'NONE', NULL, 6, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%rfc]', 6, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +5, NULL, @w_ftd_id, 'FECHA_NACIMIENTO', 'FECHA DE NACIMIENTO', 'STRING', 10, ' ', 'NONE', NULL, 7, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%birthDate]', 7, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +6, NULL, @w_ftd_id, 'LISTA', 'INFORMACION ADICIONAL DE REGISTRO', 'STRING', 10, ' ', 'NONE', NULL, 8, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%listType]', 8, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +7, NULL, @w_ftd_id, 'ESTATUS', 'ESTADO DEL REGISTRO', 'STRING', 20, ' ', 'NONE', NULL, 9, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%status]', 9, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +8, NULL, @w_ftd_id, 'DEPENDENCIA', 'DEPENDENCIA DONDE LABORA LA PERSON', 'STRING', 200, ' ', 'NONE', NULL, 10, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%dependency]', 10, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +9, NULL, @w_ftd_id, 'PATERNO', 'APELLIDO PATERNO', 'STRING', 100, ' ', 'NONE', NULL, 3, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%lastName]', 3, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +10, NULL, @w_ftd_id, 'PUESTO', 'CAR DE LA PERSONA', 'STRING', 200, ' ', 'NONE', NULL, 11, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%position]', 11, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +11, NULL, @w_ftd_id, 'IDDISPO', 'HACE REFERENCIA A CUAL DE LAS DISPOSICIONES ENVIADAS POR SHCP ESTÁ VINCULADO EL REGISTRO. SÓLO SE ', 'STRING', 10, ' ', 'NONE', NULL, 12, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%iddispo]', 12, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +12, NULL, @w_ftd_id, 'CURP_OK', 'CURP OK', 'STRING', 0, ' ', 'NONE', NULL, 13, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%curpOk]', 13, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +13, NULL, @w_ftd_id, 'PARENTESCO', 'PARENTESCO', 'STRING', 20, ' ', 'NONE', NULL, 15, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%relationship]', 15, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +14, NULL, @w_ftd_id, 'RFC_MORAL', 'RFC MORAL', 'STRING', 15, ' ', 'NONE', NULL, 17, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%moralRfc]', 17, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +15, NULL, @w_ftd_id, 'ISSSTE', 'NUMERO DE SEGURO SOCIAL', 'STRING', 50, ' ', 'NONE', NULL, 18, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%socialSecurityNumber]', 18, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +16, NULL, @w_ftd_id, 'IMSS', 'IMSS', 'STRING', 50, ' ', 'NONE', NULL, 19, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%imss]', 19, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +17, NULL, @w_ftd_id, 'INGRESOS', 'INGRESOS', 'STRING', 20, ' ', 'NONE', NULL, 20, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%incomes]', 20, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +18, NULL, @w_ftd_id, 'NOMCOMP', 'NOMBRES COMPLETOS', 'STRING', 300, ' ', 'NONE', NULL, 21, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%largeName]', 21, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +19, NULL, @w_ftd_id, 'APELLIDOS', 'APELLIDOS COMPLETOS', 'STRING', 200, ' ', 'NONE', NULL, 22, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%completeLastName]', 22, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +20, NULL,@w_ftd_id, 'ENTIDAD', 'ENTIDAD', 'STRING', 50, ' ', 'NONE', NULL, 23, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%entity]', 23, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +21, NULL, @w_ftd_id, 'SEXO', 'SEXO', 'STRING', 10, ' ', 'NONE', NULL, 24, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%sex]', 24, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +22, NULL, @w_ftd_id, 'AREA', 'AREA', 'STRING', 100, ' ', 'NONE', NULL, 25, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%area]', 25, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +23, NULL, @w_ftd_id, 'MATERNO', 'APELLIDO MATERNO', 'STRING', 100, ' ', 'NONE', NULL, 4, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%motherLastName]', 4, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +24, NULL, @w_ftd_id, 'ID_REL', 'ID RELACION', 'STRING', 25, ' ', 'NONE', NULL, 14, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%idRelation]', 14, 0 )

	INSERT INTO cob_ien..ree_ien_column_file_def ( cftd_id, cftd_id_parent, ftd_id, cftd_name, cftd_description, cftd_data_type, cftd_maxlength, cftd_filling_character, cftd_justification, cftd_expression, cftd_order, cftd_section, cftd_mandatory, cftd_reg_exp_validation, cftd_property_name, cftd_order_file, cftd_is_hidden ) 
	VALUES ( @w_cftd_id +25, NULL, @w_ftd_id, 'RAZONSOC', 'RAZON SOCIAL', 'STRING', 250, ' ', 'NONE', NULL, 16, 'DETAIL', 0, NULL, '[ns1:cobiscorp.ecobis.cloud.sofom.riskcompliance.regulationscompliance.batch.dto][RegulatoryCompliance%ns1.RegulatoryComplianceResponseDTO%businessName]', 16, 0 )


end

--------------------------------
print 'ree_ien_conf_group'
--------------------------------
--PREREQUISITO
--

if exists (select 1 from cob_ien..ree_ien_conf_group
               where co_name = 'SANTANDER')
begin
  print 'YA EXISTE GRUPO >>SANTANDER<<'
end
else
begin
	select @w_co_id = isnull(siguiente,0) + 1
	from cobis..cl_seqnos
	where tabla = 'ree_ien_conf_group'
  
	INSERT INTO ree_ien_conf_group (co_id, co_is_group, co_name, co_value_entity)
	VALUES (@w_co_id, 0, 'SANTANDER', @w_ente)
 
end

if exists (select 1 from cob_ien..ree_ien_entities_groups
               where en_name = 'SANTANDER')
begin
  print 'YA EXISTE GRUPO >>SANTANDER<<'
end
else
begin
	select @w_co_id = (select co_id from ree_ien_conf_group where co_name = 'SANTANDER')

	INSERT INTO ree_ien_entities_groups (en_code, en_name, group_id, server)
	VALUES (@w_ente, 'SANTANDER', @w_co_id, NULL)

end

--------------------------------
print 'ree_ien_jobs'
--------------------------------
--PREREQUISITO
--

if exists (select 1 from cob_ien..ree_ien_jobs
               where jo_transaction_type = 'LSTNG' and jo_status = 'A' AND jo_in_out = 'IN')
begin
  print 'YA EXISTE JOB >>LSTNG<< IN'
end
else
begin
	select @w_co_id = (select co_id from ree_ien_conf_group where co_name = 'SANTANDER')
	select @w_jo_id = isnull(max(jo_id),0) + 1 from cob_ien..ree_ien_jobs
    
	INSERT INTO cob_ien..ree_ien_jobs ( jo_id, co_id, jo_description, jo_type, jo_cron_expression, jo_service_id, jo_type_cron, jo_has_template, jo_status, jo_in_out, jo_transaction_type ) 
	VALUES ( @w_jo_id, @w_co_id, 'Descarga Listas Negras', 'DOWNLOAD', '0 0/5 * * * ? *', NULL, 'JOB', 1, 'A', 'IN', 'LSTNG' )
	
	select @w_jo_id = @w_jo_id +1
	INSERT INTO cob_ien..ree_ien_jobs ( jo_id, co_id, jo_description, jo_type, jo_cron_expression, jo_service_id, jo_type_cron, jo_has_template, jo_status, jo_in_out, jo_transaction_type ) 
	VALUES (@w_jo_id, @w_co_id, 'Procesamiento Listas Negras', 'PROCESS', NULL, NULL, 'ENTITY', 1, 'A', 'IN', 'LSTNG' )


end

--------------------------------
print 'CONFIGURACION DE ENTIDAD'
--------------------------------
--PREREQUISITO
--Tener creado el par�metro ENTIEND en la cobis..cl_parametro

print 'ree_ien_agent_file_def'

if exists (select 1 from cob_ien..ree_ien_agent_file_def where afd_transaction_type = 'LSTNG' and afd_status = 'A' 
			and ftd_id = (select ftd_id from ree_ien_file_transfer_def
			where ftd_description = 'LISTAS NEGRAS'))
begin
	print 'Existe registro en ree_ien_agent_file_def >>LISTAS NEGRAS<<'
end
else
begin
	select @w_afd_id = isnull(siguiente,0) + 1
	from cobis..cl_seqnos
	where tabla = 'ree_ien_agent_file_def'

	select @w_ins_id = ins_id from cob_ien..ree_ien_integration_server
	where ins_name = 'SANTANDER'

	select @w_ftsq_id = null

	select @w_sf_id = sf_id 
    from cob_ien..ree_ien_service_factory
    where sf_type_service='LSTNG'
    and sf_class='IRegulatoryComplianceProcess'
	
	select @w_ftd_id = ftd_id from ree_ien_file_transfer_def
	where ftd_description = 'LISTAS NEGRAS'
	
	INSERT INTO ree_ien_agent_file_def (afd_id, ins_id, ftd_id, ftsq_id, sf_id, ag_code, ag_name, afd_ftp_folder, afd_local_folder, afd_allow_encription, afd_allow_compression, afd_cron_expression, afd_name_expression, afd_in_out, afd_status, afd_optional_parameters, afd_retry_number, afd_only_last_process, afd_transaction_type, afd_allow_confirmation, afd_one_file_by_day, afd_allow_old_confirmation, afd_public_key, afd_private_key, afd_private_password, afd_type_access, afd_app, afd_allow_reprocess, afd_type_reprocess, afd_allow_statistics)
	VALUES (@w_afd_id, @w_ins_id, @w_ftd_id, @w_ftsq_id, @w_sf_id, @w_ente, NULL, 'send','receive',  0, 0, '0 0/5 * * * ? *', 'SofomSantander.txt.zip', 'IN', 'A', 'CFP=3', 0, 0, 'LSTNG', 0, 0, 0, NULL, NULL, NULL, 'FTP', 'IEN', 0, NULL, 0)

end




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
--declare @w_ftd_id int
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


PRINT 'FIN'
SET NOCOUNT OFF
GO
