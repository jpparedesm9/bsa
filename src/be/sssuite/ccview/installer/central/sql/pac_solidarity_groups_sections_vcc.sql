USE cob_pac
GO

DECLARE @w_prd_id INT,
		@w_parent_prd_id INT,
		@w_parent_root_prd_id INT,
		@w_dto_id int, 
		@w_pr_id int,
		@w_co_id int
		
delete vcc_properties where dto_id_fk in (select dto_id from vcc_dtos where dto_name in ('groupOtherInfromation'))
delete vcc_properties where dto_id_fk in (select dto_id from vcc_dtos where dto_name='dataSourceGroup' and dto_description = 'Miembros de Grupo Solidario')
delete vcc_product_admin where prd_id in (select prd_id from vcc_pro_admin_default where prd_mnemonic in ('GSMB', 'GSMD', 'GSDIR', 'OTRGS', 'INFGS'))
delete vcc_pro_admin_default where prd_mnemonic in ('GSMB', 'GSMD', 'GSDIR', 'OTRGS', 'INFGS')
delete vcc_dtos where dto_name in ('solidarityGroupMembers','groupOtherInfromation')
delete vcc_dtos where dto_name='dataSourceGroup' and dto_description = 'Miembros de Grupo Solidario'

--INSERT DTO SOLIDARITY GROUP MEMBERS
SELECT 	@w_dto_id =   isnull(max(dto_id), 1) + 1 FROM vcc_dtos

INSERT INTO dbo.vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (@w_dto_id, 'InformacionCliente', 'dataSourceGroup', 'CLIENTVIEWER.LABELS.LBL_MEMBERS', 'Miembros de Grupo Solidario', NULL, 0, NULL, NULL)

--INSERT PROPERTIES
select @w_pr_id = isnull(max(pr_id), 1) +1 FROM vcc_properties

INSERT INTO dbo.vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_style, pr_order, pr_type)
VALUES (@w_pr_id, @w_dto_id, 'identificationType', 'COMMONS.LABELS.LBL_TYPE_IDENTIFICATION', 0, 0, 1, 0, 0, 0, '110px', NULL, NULL, NULL, 'LABEL')

select @w_pr_id = @w_pr_id + 1
INSERT INTO dbo.vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_style, pr_order, pr_type)
VALUES (@w_pr_id, @w_dto_id, 'code', 'CLIENTVIEWER.LABELS.LBL_CODE', 1, 0, 1, 0, 0, 0, '110px', NULL, NULL, NULL, 'LABEL')

select @w_pr_id = @w_pr_id + 1
INSERT INTO dbo.vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_style, pr_order, pr_type)
VALUES (@w_pr_id, @w_dto_id, 'composedName', 'COMMONS.HEADERS.HDR_NAME', 0, 0, 1, 0, 0, 0, '110px', NULL, NULL, NULL, 'LABEL')

select @w_pr_id = @w_pr_id + 1
INSERT INTO dbo.vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_style, pr_order, pr_type)
VALUES (@w_pr_id, @w_dto_id, 'documentId', 'COMMONS.HEADERS.HDR_DOCUMENT_NUMBER', 0, 0, 1, 0, 0, 0, '110px', NULL, NULL, NULL, 'LABEL')

select @w_pr_id = @w_pr_id + 1
INSERT INTO dbo.vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_style, pr_order, pr_type)
VALUES (@w_pr_id, @w_dto_id, 'subtype', 'CLIENTVIEWER.LABELS.LBL_OPERATION_SUBTYPE', 0, 0, 1, 0, 0, 0, '110px', NULL, NULL, NULL, 'LABEL')

select @w_pr_id = @w_pr_id + 1
INSERT INTO dbo.vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_style, pr_order, pr_type)
VALUES (@w_pr_id, @w_dto_id, 'passport', 'COMMONS.HEADERS.HDR_PASSPORT', 0, 0, 0, 0, 0, 0, '110px', NULL, NULL, NULL, 'LABEL')

select @w_pr_id = @w_pr_id + 1
INSERT INTO dbo.vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_style, pr_order, pr_type)
VALUES (@w_pr_id, @w_dto_id, 'cycleNumber', 'CLIENTVIEWER.LABELS.LBL_CYCLE_NUMBER', 0, 0, 1, 0, 0, 0, '110px', NULL, NULL, NULL, 'LABEL')

select @w_pr_id = @w_pr_id + 1
INSERT INTO dbo.vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_style, pr_order, pr_type)
VALUES (@w_pr_id, @w_dto_id, 'roleDescription', 'CLIENTVIEWER.LABELS.LBL_ROLE', 0, 0, 1, 0, 0, 0, '110px', NULL, NULL, NULL, 'LABEL')

select @w_pr_id = @w_pr_id + 1
INSERT INTO dbo.vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_style, pr_order, pr_type)
VALUES (@w_pr_id, @w_dto_id, 'image', 'CLIENTVIEWER.LABELS.LBL_BLANK', 0, 0, 1, 0, 0, 0, '110px', 'glyphicon glyphicon-search', NULL, NULL, 'BUTTON')

--INSERT DTO INFORMATION SOLIDARITY GROUP
SELECT 	@w_dto_id =   isnull(max(dto_id), 1) + 1 FROM vcc_dtos

INSERT INTO dbo.vcc_dtos (dto_id, ser_id_fk, dto_name, dto_text, dto_description, dto_parent, dto_is_list, dto_mnemonic, dto_order)
VALUES (@w_dto_id, 'InformacionCliente', 'groupOtherInfromation', 'CLIENTVIEWER.LABELS.LBL_SOLIDARITY_GROUP_INFORMATION', 'Información del Grupo', NULL, 1, NULL, NULL)

--INSERT PROPERTIES
select @w_pr_id = isnull(max(pr_id), 1) +1 FROM vcc_properties

INSERT INTO dbo.vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_style, pr_order, pr_type)
VALUES (@w_pr_id, @w_dto_id, 'state', 'CLIENTVIEWER.LABELS.LBL_STATE', 0, 0, 1, 1, 0, 0, '110px', NULL, NULL, NULL, 'LABEL')

select @w_pr_id = @w_pr_id + 1
INSERT INTO dbo.vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_style, pr_order, pr_type)
VALUES (@w_pr_id, @w_dto_id, 'cycleNumber', 'CLIENTVIEWER.LABELS.LBL_CYCLE_NUMBER', 0, 0, 1, 1, 0, 0, '110px', NULL, NULL, NULL, 'LABEL')

select @w_pr_id = @w_pr_id + 1
INSERT INTO dbo.vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_style, pr_order, pr_type)
VALUES (@w_pr_id, @w_dto_id, 'meetingAddress', 'CLIENTVIEWER.LABELS.LBL_MEETING_ADDRESS', 0, 0, 1, 1, 0, 0, '110px', NULL, NULL, NULL, 'LABEL')

select @w_pr_id = @w_pr_id + 1
INSERT INTO dbo.vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_style, pr_order, pr_type)
VALUES (@w_pr_id, @w_dto_id, 'meetingDay', 'CLIENTVIEWER.LABELS.LBL_MEETING_DAY', 0, 0, 1, 1, 0, 0, '110px', NULL, NULL, NULL, 'LABEL')

select @w_pr_id = @w_pr_id + 1
INSERT INTO dbo.vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_style, pr_order, pr_type)
VALUES (@w_pr_id, @w_dto_id, 'meetingHour', 'CLIENTVIEWER.LABELS.LBL_MEETING_HOUR', 0, 0, 1, 1, 0, 0, '110px', NULL, NULL, NULL, 'LABEL')

select @w_pr_id = @w_pr_id + 1
INSERT INTO dbo.vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_style, pr_order, pr_type)
VALUES (@w_pr_id, @w_dto_id, 'branchOfficeDescription', 'CLIENTVIEWER.LABELS.LBL_BRANCH_OFFICE', 0, 0, 1, 1, 0, 0, '110px', NULL, NULL, NULL, 'LABEL')

select @w_pr_id = @w_pr_id + 1
INSERT INTO dbo.vcc_properties (pr_id, dto_id_fk, pr_name, pr_text, pr_primarykey, pr_grouping, pr_detailsection, pr_visiblesumarydetail, pr_visiblesumarygroup, pr_filterinprocess, pr_width, pr_format, pr_style, pr_order, pr_type)
VALUES (@w_pr_id, @w_dto_id, 'score', 'CLIENTVIEWER.LABELS.LBL_RATING', 0, 0, 1, 1, 0, 0, '110px', NULL, NULL, NULL, 'LABEL')



--INSERT SECTIONS SOLIDARITY GROUP INFORMATION

SELECT @w_prd_id = isnull(max(prd_id), 1) +1 FROM vcc_pro_admin_default

SELECT @w_parent_root_prd_id =  prd_id FROM vcc_pro_admin_default WHERE prd_mnemonic = 'ROOT' and prd_name = 'VCC CLIENT'
IF  @w_parent_root_prd_id IS NOT NULL
begin
	--OTRA INFORMACION DEL GRUPO
	INSERT INTO vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
	VALUES (@w_prd_id, NULL, 'OTRGS', 'MENU.LABELS.LBL_GROUP_INFORMATION', 'Otra Información', @w_parent_root_prd_id, 'S', 3)
	
	SELECT @w_parent_prd_id = @w_prd_id
	select @w_dto_id = dto_id FROM cob_pac..vcc_dtos WHERE dto_name = 'groupOtherInfromation'
	SELECT @w_prd_id = @w_prd_id + 1
	
	if @w_dto_id is not null
	begin
	INSERT INTO dbo.vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
	VALUES (@w_prd_id, @w_dto_id, 'INFGS', 'MENU.LABELS.LBL_GROUP_INFORMATION', 'Información del Grupo', @w_parent_prd_id, 'S', 1)
	end
	
	SELECT @w_prd_id = @w_prd_id + 1
	select @w_dto_id = dto_id from vcc_dtos where dto_name = 'seriesDirectionsMain'
	--SELECT @w_co_id = co_id FROM cobis..an_component WHERE co_name = 'Mantenimiento Direcciones'
	
	if @w_dto_id is not null
	begin		
		INSERT INTO dbo.vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
		VALUES (@w_prd_id, @w_dto_id, 'GSDIR', 'ADDRESS.LABELS.LBL_ADDRESS_PRINCIPAL_MAIN', 'Direcciones Representante Principal Grupo Solidario', @w_parent_prd_id, 'S', 1)
	end 
	
	--MIEMBROS DEL GRUPO
	SELECT @w_prd_id = @w_prd_id + 1
	INSERT INTO dbo.vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
	VALUES (@w_prd_id, NULL, 'GSMB', 'CLIENTVIEWER.LABELS.LBL_MEMBERS', 'Miembros de Grupo Solidario', @w_parent_root_prd_id, 'S', NULL)
	
	
	SELECT @w_parent_prd_id = @w_prd_id
	SELECT @w_prd_id = @w_prd_id + 1
	select @w_dto_id = dto_id from vcc_dtos where dto_name = 'dataSourceGroup' and dto_description = 'Miembros de Grupo Solidario'
	if @w_dto_id is not null
	begin
		INSERT INTO dbo.vcc_pro_admin_default (prd_id, dto_id_fk, prd_mnemonic, prd_name, prd_description, prd_parent, prd_type_client, prd_order)
		VALUES (@w_prd_id, @w_dto_id, 'GSMD', 'CLIENTVIEWER.LABELS.LBL_MEMBERS', 'Miembros de Grupo Solidario', @w_parent_prd_id, 'S', 1)
	end

end


--DELETE SECTIONS OTHER INFORMATION


delete vcc_rol_content_management WHERE rc_sm_id IN (SELECT sm_id FROM vcc_section_management_content WHERE sm_description IN ('Visitas realizadas al cliente','Consulta de Excepciones'))

delete vcc_section_management_content WHERE sm_description IN ('Visitas realizadas al cliente','Consulta de Excepciones')


go
