use cob_pac
go

IF EXISTS(select 1 from vcc_section_management_content where sm_name =  'CLIENTVIEWER.LABELS.LBL_CUSTOMER_VISITS')
BEGIN
	delete from vcc_rol_content_management where rc_sm_id in (select sm_id from vcc_section_management_content where sm_name =  'CLIENTVIEWER.LABELS.LBL_CUSTOMER_VISITS')
    delete from vcc_section_management_content where sm_name =  'CLIENTVIEWER.LABELS.LBL_CUSTOMER_VISITS'
END
IF EXISTS(select 1 from vcc_section_management_content where sm_name =  'CLIENTVIEWER.LABELS.LBL_EXCEPTION_CLIENT')
BEGIN
	delete from vcc_rol_content_management where rc_sm_id in (select sm_id from vcc_section_management_content where sm_name =  'CLIENTVIEWER.LABELS.LBL_EXCEPTION_CLIENT')
    delete from vcc_section_management_content where sm_name =  'CLIENTVIEWER.LABELS.LBL_EXCEPTION_CLIENT'
END
IF EXISTS(select 1 from vcc_section_management_content where sm_name =  'CLIENTVIEWER.LABELS.LBL_CANCELLED_OPERATIONS')
BEGIN
	delete from vcc_rol_content_management where rc_sm_id in (select sm_id from vcc_section_management_content where sm_name =  'CLIENTVIEWER.LABELS.LBL_CANCELLED_OPERATIONS')
    delete from vcc_section_management_content where sm_name =  'CLIENTVIEWER.LABELS.LBL_CANCELLED_OPERATIONS'
END
go

declare @w_sm_id int,
		@w_rol int		

select 	@w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

select @w_sm_id = 1

IF NOT EXISTS(select max(sm_id) from cob_pac..vcc_section_management_content)
begin
	select @w_sm_id = max(sm_id) +1 from cob_pac..vcc_section_management_content
end

INSERT INTO vcc_section_management_content ( sm_id, sm_name, sm_description, sm_url_template, sm_type ) 
		 VALUES ( @w_sm_id, 'CLIENTVIEWER.LABELS.LBL_CUSTOMER_VISITS','Visitas realizadas al cliente', 'clientviewer/templates/customer-visits-tpl.html', NULL )
		 
		 
INSERT INTO vcc_rol_content_management ( rc_sm_id, rc_rol_id )  VALUES ( @w_sm_id, @w_rol  ) 


IF EXISTS(select max(sm_id) from cob_pac..vcc_section_management_content)
begin
	select @w_sm_id = max(sm_id) +1 from cob_pac..vcc_section_management_content
	PRINT 'ingreso'
end	

INSERT INTO dbo.vcc_section_management_content (sm_id, sm_name, sm_description, sm_url_template, sm_type)
VALUES (@w_sm_id, 'CLIENTVIEWER.LABELS.LBL_EXCEPTION_CLIENT', 'Consulta de Excepciones', 'clientviewer/templates/client-exception-tpl.html', 'NULL')

INSERT INTO vcc_rol_content_management ( rc_sm_id, rc_rol_id )  VALUES ( @w_sm_id, @w_rol  ) 

IF EXISTS(select max(sm_id) from cob_pac..vcc_section_management_content)
begin
	select @w_sm_id = max(sm_id) +1 from cob_pac..vcc_section_management_content
	PRINT 'ingreso'
end	

INSERT INTO vcc_section_management_content ( sm_id, sm_name, sm_description, sm_url_template, sm_type ) 
		 VALUES ( @w_sm_id, 'CLIENTVIEWER.LABELS.LBL_CANCELLED_OPERATIONS', 'Histórico de operaciones canceladas', 'clientviewer/templates/history-tpl.html', 'P_HIS' ) 

INSERT INTO vcc_rol_content_management ( rc_sm_id, rc_rol_id )  VALUES ( @w_sm_id, @w_rol  ) 
go


