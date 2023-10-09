--******************************************************************************************* 
--**********************************Autorizacion servicio************************************
--*******************************************************************************************
use cobis
go

declare @w_rol int,
		@pd_producto int

select @w_rol = 0
select @pd_producto = pd_producto from cobis..cl_producto where pd_abreviatura = 'CCA'

select * 
into #rol
from cobis..ad_rol
where ro_descripcion not in ('FUNCIONARIO OFICINA')

while (exists (select 1 from #rol where ro_rol > @w_rol))
begin
    select TOP 1 @w_rol = ro_rol from #rol where ro_rol > @w_rol
    -----------------------------------------
    ---reporte de seguros consulta-----------
    --informacion  titular asegurado---------
    -----------------------------------------
    if  exists (select 1 from cobis..ad_pro_transaccion where pt_transaccion = 74007 ) 
    	delete from cobis..ad_pro_transaccion where pt_transaccion = 74007  
    
    insert into cobis..ad_pro_transaccion values(@pd_producto,'R',0,74007 ,'V',getDate(),74007 ,null) 
    
    if  exists (select 1 from cobis..cl_ttransaccion where   tn_trn_code = 74007 ) 
    	delete from cobis..cl_ttransaccion    where   tn_trn_code = 74007  
    
    insert into cobis..cl_ttransaccion      values(74007 ,'Reporte Consentimiento de seguros TUIIO Seguro ','74007','Reporte Consentimiento de seguros TUIIO Seguro') 
    
    if  exists (select 1 from cobis..ad_tr_autorizada   where ta_transaccion = 74007 and ta_rol=@w_rol) 
    	delete from cobis..ad_tr_autorizada   where ta_transaccion = 74007 and ta_rol=@w_rol 
    
    insert into cobis..ad_tr_autorizada    values(@pd_producto,'R',0,74007,@w_rol,getdate(),1,'V',getdate()) 
    
    if  exists (select 1   from cobis..ad_procedure where pd_stored_procedure = 'sp_conse_seguro') 
    	delete from cobis..ad_procedure       where pd_stored_procedure = 'sp_conse_seguro' 
    
    insert into cobis..ad_procedure values(74007,'sp_conse_seguro','cob_cartera','V',getdate(),'sp_conse_seg')
    
    ---------------------------------
    ---reporte de seguros + medico---
    ---------------------------------
    if  exists (select 1 from cobis..ad_pro_transaccion where pt_transaccion = 74008 ) 
    	delete from cobis..ad_pro_transaccion where pt_transaccion = 74008  
    
    insert into cobis..ad_pro_transaccion values(@pd_producto,'R',0,74008 ,'V',getDate(),74008 ,null) 
    
    if  exists (select 1 from cobis..cl_ttransaccion where   tn_trn_code = 74008 ) 
    	delete from cobis..cl_ttransaccion    where   tn_trn_code = 74008  
    
    insert into cobis..cl_ttransaccion      values(74008 ,'Reporte Consentimiento de seguros TUIIO Seguro + Médico','74008','2 Consentimiento de seguros TUIIO Seguro + Médico') 
    
    if  exists (select 1 from cobis..ad_tr_autorizada   where ta_transaccion = 74008 and ta_rol=@w_rol) 
    	delete from cobis..ad_tr_autorizada   where ta_transaccion = 74008 and ta_rol=@w_rol 
    
    insert into cobis..ad_tr_autorizada    values(@pd_producto,'R',0,74008,@w_rol,getdate(),1,'V',getdate()) 
    
    if  exists (select 1   from cobis..ad_procedure where pd_stored_procedure = 'sp_conse_seguro_medico') 
    	delete from cobis..ad_procedure       where pd_stored_procedure = 'sp_conse_seguro_medico' 
    
    insert into cobis..ad_procedure values(74008,'sp_conse_seguro_medico','cob_cartera','V',getdate(),'sp_conse_seg') 
    
    ---------------------------------
    ---rconsultar clientes 
    ---------------------------------
    if  exists (select 1 from cobis..ad_pro_transaccion where pt_transaccion = 74009 ) 
    	delete from cobis..ad_pro_transaccion where pt_transaccion = 74009  
    
    insert into cobis..ad_pro_transaccion values(@pd_producto,'R',0,74009 ,'V',getDate(),74009 ,null) 
    
    if  exists (select 1 from cobis..cl_ttransaccion where   tn_trn_code = 74009 ) 
    	delete from cobis..cl_ttransaccion    where   tn_trn_code = 74009  
    
    insert into cobis..cl_ttransaccion      values(74009 ,'consullta de clientes de un grupo','74009','consulta de clientes de un grupo') 
    
    if  exists (select 1 from cobis..ad_tr_autorizada   where ta_transaccion = 74009 and ta_rol=@w_rol) 
    	delete from cobis..ad_tr_autorizada   where ta_transaccion = 74009 and ta_rol=@w_rol 
    
    insert into cobis..ad_tr_autorizada    values(@pd_producto,'R',0,74009,@w_rol,getdate(),1,'V',getdate()) 
    
    if  exists (select 1   from cobis..ad_procedure where pd_stored_procedure = 'sp_clientes_grupo') 
    	delete from cobis..ad_procedure       where pd_stored_procedure = 'sp_clientes_grupo' 
    
    insert into cobis..ad_procedure values(74009,'sp_clientes_grupo','cob_cartera','V',getdate(),'sp_clientes') 
    
    -----------------------------------------
    ---consulta tipo seguro -----------------
    -----------------------------------------
    -----------------------------------------
    if  exists (select 1 from cobis..ad_pro_transaccion where pt_transaccion = 74010 ) 
    	delete from cobis..ad_pro_transaccion where pt_transaccion = 74010  
    
    insert into cobis..ad_pro_transaccion values(@pd_producto,'R',0,74010 ,'V',getDate(),74010 ,null) 
    
    if  exists (select 1 from cobis..cl_ttransaccion where   tn_trn_code = 74010 ) 
    	delete from cobis..cl_ttransaccion    where   tn_trn_code = 74010  
    
    insert into cobis..cl_ttransaccion      values(74010 ,'Consulta tipo de seguros ','74010','Consulta tipo de seguros ') 
    
    if  exists (select 1 from cobis..ad_tr_autorizada   where ta_transaccion = 74010 and ta_rol=@w_rol) 
    	delete from cobis..ad_tr_autorizada   where ta_transaccion = 74010 and ta_rol=@w_rol 
    
    insert into cobis..ad_tr_autorizada    values(@pd_producto,'R',0,74010,@w_rol,getdate(),1,'V',getdate()) 
    
    if  exists (select 1   from cobis..ad_procedure where pd_stored_procedure = 'sp_cons_tipo_seguro') 
    	delete from cobis..ad_procedure       where pd_stored_procedure = 'sp_cons_tipo_seguro' 
    
    insert into cobis..ad_procedure values(74010,'sp_cons_tipo_seguro','cob_cartera','V',getdate(),'sp_cons_tipo')
    
    --******************************************************************************************* 
    --*************************************insercion servicio************************************
    --*******************************************************************************************
    ----Servicio de seguros
        
     IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Sales.Cloud.ConsultingReportSales.ReportSafeBenefits')
        UPDATE cts_serv_catalog SET 
    	csc_class_name = 'cobiscorp.ecobis.sales.cloud.service.IConsultingReportSales', 
    	csc_method_name = 'reportSafeBenefits', csc_description = '', csc_trn = 74007, 
    	csc_procedure_validation = 'Y' 
    	WHERE csc_service_id = 'Sales.Cloud.ConsultingReportSales.ReportSafeBenefits'
    ELSE
    	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation)
    	VALUES ('Sales.Cloud.ConsultingReportSales.ReportSafeBenefits', 'cobiscorp.ecobis.sales.cloud.service.IConsultingReportSales', 'reportSafeBenefits', '', 74007, 'Y')
        
        
    IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Sales.Cloud.ConsultingReportSales.ReportSafeDeclaration')
        UPDATE cts_serv_catalog SET 
    		csc_class_name = 'cobiscorp.ecobis.sales.cloud.service.IConsultingReportSales', 
    		csc_method_name = 'reportSafeDeclaration', 
    		csc_description = '', 
    		csc_trn = 74007,
    		csc_procedure_validation = 'Y' 
    	WHERE csc_service_id = 'Sales.Cloud.ConsultingReportSales.ReportSafeDeclaration'
    ELSE
    	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) 
    	VALUES ('Sales.Cloud.ConsultingReportSales.ReportSafeDeclaration', 'cobiscorp.ecobis.sales.cloud.service.IConsultingReportSales', 'reportSafeDeclaration', '', 74007, 'Y')
    
    
    IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Sales.Cloud.ConsultingReportSales.ReportSafeInformation')
        UPDATE cts_serv_catalog SET 
    		csc_class_name = 'cobiscorp.ecobis.sales.cloud.service.IConsultingReportSales', 
    		csc_method_name = 'reportSafeInformation',
    		csc_description = '',
    		csc_trn = 74007, 
    		csc_procedure_validation = 'Y' 
    	WHERE csc_service_id = 'Sales.Cloud.ConsultingReportSales.ReportSafeInformation'
    ELSE
       INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) 
    	VALUES ('Sales.Cloud.ConsultingReportSales.ReportSafeInformation', 'cobiscorp.ecobis.sales.cloud.service.IConsultingReportSales', 'reportSafeInformation', '', 74007, 'Y')
    ---FIN
    -------------------------------
    --ad_servicio_autorizado-------
    -------------------------------
    IF EXISTS(SELECT 1 FROM cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportSales.ReportSafeBenefits' and ts_rol = @w_rol and ts_producto = @pd_producto )
    BEGIN
    	DELETE  cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportSales.ReportSafeBenefits' and ts_rol = @w_rol and ts_producto = @pd_producto
    END
     INSERT INTO cobis..ad_servicio_autorizado(ts_servicio   , ts_rol, ts_producto , ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
     VALUES('Sales.Cloud.ConsultingReportSales.ReportSafeBenefits', @w_rol, @pd_producto, 'R'    , 0        , getdate()   , 'V'       , getdate())  
     
    --
     IF EXISTS(SELECT 1 FROM cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportSales.ReportSafeDeclaration' and ts_rol = @w_rol and ts_producto = @pd_producto)
    BEGIN
    	DELETE  cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportSales.ReportSafeDeclaration' and ts_rol = @w_rol and ts_producto = @pd_producto
    END
     INSERT INTO cobis..ad_servicio_autorizado(ts_servicio   , ts_rol, ts_producto , ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
     VALUES('Sales.Cloud.ConsultingReportSales.ReportSafeDeclaration', @w_rol, @pd_producto, 'R'    , 0        , getdate()   , 'V'       , getdate())  
     
    --
     IF EXISTS(SELECT 1 FROM cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportSales.ReportSafeInformation' and ts_rol = @w_rol and ts_producto = @pd_producto)
    BEGIN
    	DELETE  cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportSales.ReportSafeInformation' and ts_rol = @w_rol and ts_producto = @pd_producto
    END
     INSERT INTO cobis..ad_servicio_autorizado(ts_servicio   , ts_rol, ts_producto , ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
     VALUES('Sales.Cloud.ConsultingReportSales.ReportSafeInformation', @w_rol, @pd_producto, 'R'    , 0        , getdate()   , 'V'       , getdate())  
    --FIN
    
    ------------------------------------
    ----Servicio de seguros +medicos----
    ------------------------------------
    IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalBenefits')
      UPDATE cts_serv_catalog SET 
    		csc_class_name = 'cobiscorp.ecobis.sales.cloud.service.IConsultingReportMedical',
    		csc_method_name = 'reportMedicalBenefits', 
    		csc_description = '', 
    		csc_trn = 74008, 
    		csc_procedure_validation = 'Y' 
      WHERE csc_service_id = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalBenefits'
    ELSE
      INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) 
      VALUES ('Sales.Cloud.ConsultingReportMedical.ReportMedicalBenefits', 'cobiscorp.ecobis.sales.cloud.service.IConsultingReportMedical', 'reportMedicalBenefits', '', 74008, 'Y')
    
    
    IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalDeclaration')
      UPDATE cts_serv_catalog SET 
    		csc_class_name = 'cobiscorp.ecobis.sales.cloud.service.IConsultingReportMedical',
    		csc_method_name = 'reportMedicalDeclaration', 
    		csc_description = '', 
    		csc_trn = 74008, 
    		csc_procedure_validation = 'Y' 
      WHERE csc_service_id = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalDeclaration'
    ELSE
      INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation)
      VALUES ('Sales.Cloud.ConsultingReportMedical.ReportMedicalDeclaration', 'cobiscorp.ecobis.sales.cloud.service.IConsultingReportMedical', 'reportMedicalDeclaration', '', 74008, 'Y')
    
    IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalInformation')
      UPDATE cts_serv_catalog SET 
    		csc_class_name = 'cobiscorp.ecobis.sales.cloud.service.IConsultingReportMedical', 
    		csc_method_name = 'reportMedicalInformation',
    		csc_description = '',
    		csc_trn = 74008,
    		csc_procedure_validation = 'Y' 
      WHERE csc_service_id = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalInformation'
    ELSE
      INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) 
      VALUES ('Sales.Cloud.ConsultingReportMedical.ReportMedicalInformation', 'cobiscorp.ecobis.sales.cloud.service.IConsultingReportMedical', 'reportMedicalInformation', '', 74008, 'Y')
    
    -------------------------------
    --ad_servicio_autorizado-------
    -------------------------------
    
    IF EXISTS(SELECT 1 FROM cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalBenefits' and ts_rol = @w_rol and ts_producto = @pd_producto)
    BEGIN
    	DELETE  cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalBenefits' and ts_rol = @w_rol and ts_producto = @pd_producto
    END
     INSERT INTO cobis..ad_servicio_autorizado(ts_servicio   , ts_rol, ts_producto , ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
     VALUES('Sales.Cloud.ConsultingReportMedical.ReportMedicalBenefits', @w_rol, @pd_producto, 'R'    , 0        , getdate()   , 'V'       , getdate())  
     
    --
     IF EXISTS(SELECT 1 FROM cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalDeclaration' and ts_rol = @w_rol and ts_producto = @pd_producto)
    BEGIN
    	DELETE  cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalDeclaration' and ts_rol = @w_rol and ts_producto = @pd_producto
    END
     INSERT INTO cobis..ad_servicio_autorizado(ts_servicio   , ts_rol, ts_producto , ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
     VALUES('Sales.Cloud.ConsultingReportMedical.ReportMedicalDeclaration', @w_rol, @pd_producto, 'R'    , 0        , getdate()   , 'V'       , getdate())  
     
    --
     IF EXISTS(SELECT 1 FROM cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalInformation' and ts_rol = @w_rol and ts_producto = @pd_producto)
    BEGIN
    	DELETE  cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalInformation' and ts_rol = @w_rol and ts_producto = @pd_producto
    END
     INSERT INTO cobis..ad_servicio_autorizado(ts_servicio   , ts_rol, ts_producto , ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
     VALUES('Sales.Cloud.ConsultingReportMedical.ReportMedicalInformation', @w_rol, @pd_producto, 'R'    , 0        , getdate()   , 'V'       , getdate())  
    --FIN
    
    ------------------------------------
    ----Servicio de seguros +medicos----
    ------------------------------------
    IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Sales.Cloud.ConsultingClientsTeams.ConsultingClients')
      UPDATE cts_serv_catalog SET 
      csc_class_name = 'cobiscorp.ecobis.sales.cloud.service.IConsultingClientsTeams', 
      csc_method_name = 'consultingClients', 
      csc_description = '', 
      csc_trn = 74009, 
      csc_procedure_validation = 'Y' 
      WHERE csc_service_id = 'Sales.Cloud.ConsultingClientsTeams.ConsultingClients'
    ELSE
      INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) VALUES ('Sales.Cloud.ConsultingClientsTeams.ConsultingClients', 'cobiscorp.ecobis.sales.cloud.service.IConsultingClientsTeams', 'consultingClients', '', 74009, 'Y')
      
    --
     IF EXISTS(SELECT 1 FROM cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingClientsTeams.ConsultingClients' and ts_rol = @w_rol and ts_producto = @pd_producto)
    BEGIN
    	DELETE  cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingClientsTeams.ConsultingClients' and ts_rol = @w_rol and ts_producto = @pd_producto
    END
     INSERT INTO cobis..ad_servicio_autorizado(ts_servicio   , ts_rol, ts_producto , ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
     VALUES('Sales.Cloud.ConsultingClientsTeams.ConsultingClients', @w_rol, @pd_producto, 'R'    , 0        , getdate()   , 'V'       , getdate())  
    --FIN
    -----------------------------------------
    ----Servicio de consulta tipo seguro ----
    -----------------------------------------
    ---
    IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'LoansBusiness.Insurance.QueryInsurance')
    	UPDATE cts_serv_catalog SET
    		csc_class_name = 'cobiscorp.ecobis.loansbusiness.service.IInsurance', 
    		csc_method_name = 'queryInsurance', 
    		csc_description = '', 
    		csc_trn = 74010, 
    		csc_procedure_validation = 'Y' 
    	WHERE csc_service_id = 'LoansBusiness.Insurance.QueryInsurance'
    ELSE
    	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn , csc_procedure_validation) 
    	VALUES ('LoansBusiness.Insurance.QueryInsurance', 'cobiscorp.ecobis.loansbusiness.service.IInsurance', 'queryInsurance', '', 74010, 'Y')
    --
     IF EXISTS(SELECT 1 FROM cobis..ad_servicio_autorizado where ts_servicio = 'LoansBusiness.Insurance.QueryInsurance' and ts_rol = @w_rol and ts_producto = @pd_producto)
    BEGIN
    	DELETE  cobis..ad_servicio_autorizado where ts_servicio = 'LoansBusiness.Insurance.QueryInsurance' and ts_rol = @w_rol and ts_producto = @pd_producto
    END
     INSERT INTO cobis..ad_servicio_autorizado(ts_servicio   , ts_rol, ts_producto , ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
     VALUES('LoansBusiness.Insurance.QueryInsurance', @w_rol, @pd_producto, 'R'    , 0        , getdate()   , 'V'       , getdate())  
     
END

DROP TABLE #rol

GO
