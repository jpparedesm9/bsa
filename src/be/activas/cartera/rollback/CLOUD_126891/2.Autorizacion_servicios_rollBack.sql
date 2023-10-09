/* ************************************************************************** */
/*  Archivo:            1.autorization_services.sql                           */
/*  Base de datos:      1.autorization_services.sql                           */
/* ************************************************************************** */
/*              IMPORTANTE                                                    */
/*  Este programa es parte de los paquetes bancarios propiedad de             */
/*  "Cobiscorp".                                                              */
/*  Su uso no autorizado queda expresamente prohibido asi como                */
/*  cualquier alteracion o agregado hecho por alguno de sus                   */
/*  usuarios sin el debido consentimiento por escrito de la                   */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.                    */
/* ************************************************************************** */
/*              PROPOSITO                                                     */
/*  autorizacion de servicios para reporte ventas seguros                     */
/* ************************************************************************** */
/*              MODIFICACIONES                                                */
/* ************************************************************************** */
/* FECHA        VERSION       AUTOR              RAZON                        */
/* ************************************************************************** */
/* 12-AGO-2019                JHCH            Emision Inicial semaforo 123487 */
/* ************************************************************************** */	
	
--******************************************************************************************* 
--**********************************Autorizacion servicio************************************
--*******************************************************************************************
use cobis
go

declare @w_rol int,
		@pd_producto int		
select @w_rol =  ro_rol from cobis..ad_rol where ro_descripcion = 'CONSULTA'
select @pd_producto = pd_producto from cobis..cl_producto where pd_abreviatura = 'CCA'
	
-----------------------------------------
---reporte de seguros consulta-----------
--informacion  titular asegurado---------
-----------------------------------------
if  exists (select 1 from cobis..ad_pro_transaccion where pt_transaccion = 74007 ) 
	delete from cobis..ad_pro_transaccion where pt_transaccion = 74007  

if  exists (select 1 from cobis..cl_ttransaccion where   tn_trn_code = 74007 ) 
	delete from cobis..cl_ttransaccion    where   tn_trn_code = 74007  

if  exists (select 1 from cobis..ad_tr_autorizada   where ta_transaccion = 74007 and ta_rol=@w_rol) 
	delete from cobis..ad_tr_autorizada   where ta_transaccion = 74007 and ta_rol=@w_rol 

if  exists (select 1   from cobis..ad_procedure where pd_stored_procedure = 'sp_conse_seguro') 
	delete from cobis..ad_procedure       where pd_stored_procedure = 'sp_conse_seguro' 

---------------------------------
---reporte de seguros + medico---
---------------------------------
if  exists (select 1 from cobis..ad_pro_transaccion where pt_transaccion = 74008 ) 
	delete from cobis..ad_pro_transaccion where pt_transaccion = 74008  

if  exists (select 1 from cobis..cl_ttransaccion where   tn_trn_code = 74008 ) 
	delete from cobis..cl_ttransaccion    where   tn_trn_code = 74008  

if  exists (select 1 from cobis..ad_tr_autorizada   where ta_transaccion = 74008 and ta_rol=@w_rol) 
	delete from cobis..ad_tr_autorizada   where ta_transaccion = 74008 and ta_rol=@w_rol 

if  exists (select 1   from cobis..ad_procedure where pd_stored_procedure = 'sp_conse_seguro_medico') 
	delete from cobis..ad_procedure       where pd_stored_procedure = 'sp_conse_seguro_medico' 

---------------------------------
---rconsultar clientes 
---------------------------------
if  exists (select 1 from cobis..ad_pro_transaccion where pt_transaccion = 74009 ) 
	delete from cobis..ad_pro_transaccion where pt_transaccion = 74009  

if  exists (select 1 from cobis..cl_ttransaccion where   tn_trn_code = 74009 ) 
	delete from cobis..cl_ttransaccion    where   tn_trn_code = 74009  

if  exists (select 1 from cobis..ad_tr_autorizada   where ta_transaccion = 74009 and ta_rol=@w_rol) 
	delete from cobis..ad_tr_autorizada   where ta_transaccion = 74009 and ta_rol=@w_rol 


if  exists (select 1   from cobis..ad_procedure where pd_stored_procedure = 'sp_clientes_grupo') 
	delete from cobis..ad_procedure       where pd_stored_procedure = 'sp_clientes_grupo' 
-----------------------------------------
---consulta tipo seguro -----------------
-----------------------------------------
-----------------------------------------
if  exists (select 1 from cobis..ad_pro_transaccion where pt_transaccion = 74010 ) 
	delete from cobis..ad_pro_transaccion where pt_transaccion = 74010  

if  exists (select 1 from cobis..cl_ttransaccion where   tn_trn_code = 74010 ) 
	delete from cobis..cl_ttransaccion    where   tn_trn_code = 74010  

if  exists (select 1 from cobis..ad_tr_autorizada   where ta_transaccion = 74010 and ta_rol=@w_rol) 
	delete from cobis..ad_tr_autorizada   where ta_transaccion = 74010 and ta_rol=@w_rol 

if  exists (select 1   from cobis..ad_procedure where pd_stored_procedure = 'sp_cons_tipo_seguro') 
	delete from cobis..ad_procedure       where pd_stored_procedure = 'sp_cons_tipo_seguro' 

--******************************************************************************************* 
--*************************************insercion servicio************************************
--*******************************************************************************************
----Servicio de seguros
    
 IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Sales.Cloud.ConsultingReportSales.ReportSafeBenefits')
 BEGIN
  DELETE FROM  cts_serv_catalog WHERE csc_service_id = 'Sales.Cloud.ConsultingReportSales.ReportSafeBenefits'
END
   
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Sales.Cloud.ConsultingReportSales.ReportSafeDeclaration')
BEGIN
  DELETE FROM  cts_serv_catalog WHERE csc_service_id = 'Sales.Cloud.ConsultingReportSales.ReportSafeDeclaration'
END

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Sales.Cloud.ConsultingReportSales.ReportSafeInformation')
BEGIN
  DELETE FROM cts_serv_catalog WHERE csc_service_id = 'Sales.Cloud.ConsultingReportSales.ReportSafeInformation'
END
  
---FIN
-------------------------------
--ad_servicio_autorizado-------
-------------------------------
IF EXISTS(SELECT 1 FROM cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportSales.ReportSafeBenefits')
BEGIN
	DELETE  cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportSales.ReportSafeBenefits'
END

--
 IF EXISTS(SELECT 1 FROM cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportSales.ReportSafeDeclaration')
BEGIN
	DELETE  cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportSales.ReportSafeDeclaration'
END

--
 IF EXISTS(SELECT 1 FROM cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportSales.ReportSafeInformation')
BEGIN
	DELETE  cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportSales.ReportSafeInformation'
END
--FIN

------------------------------------
----Servicio de seguros +medicos----
------------------------------------
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalBenefits')
BEGIN
	DELETE FROM cts_serv_catalog WHERE csc_service_id = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalBenefits'
END

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalDeclaration')
BEGIN
	DELETE FROM  cts_serv_catalog WHERE csc_service_id = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalDeclaration'
END

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalInformation')
BEGIN
	DELETE FROM  cts_serv_catalog WHERE csc_service_id = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalInformation'
END

-------------------------------
--ad_servicio_autorizado-------
-------------------------------

IF EXISTS(SELECT 1 FROM cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalBenefits')
BEGIN
	DELETE  cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalBenefits'
END
--
 IF EXISTS(SELECT 1 FROM cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalDeclaration')
BEGIN
	DELETE  cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalDeclaration'
END
--
 IF EXISTS(SELECT 1 FROM cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalInformation')
BEGIN
	DELETE  cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingReportMedical.ReportMedicalInformation'
END

--FIN
------------------------------------
----Servicio de seguros +medicos----
------------------------------------
 IF EXISTS(SELECT 1 FROM cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingClientsTeams.ConsultingClients')
BEGIN
	DELETE  cobis..ad_servicio_autorizado where ts_servicio = 'Sales.Cloud.ConsultingClientsTeams.ConsultingClients'
END

--FIN
-----------------------------------------
----Servicio de consulta tipo seguro ----
-----------------------------------------
 IF EXISTS(SELECT 1 FROM cobis..ad_servicio_autorizado where ts_servicio = 'LoansBusiness.Insurance.QueryInsurance')
BEGIN
	DELETE  cobis..ad_servicio_autorizado where ts_servicio = 'LoansBusiness.Insurance.QueryInsurance'
END
GO

