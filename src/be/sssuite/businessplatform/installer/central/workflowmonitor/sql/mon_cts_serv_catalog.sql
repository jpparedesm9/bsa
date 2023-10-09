/**********************************************************************/
/*   Archivo:         wf_authorization_services.sql  	              */
/*   Producto:        WORKFLOW								          */	
/*   Data base:       cobis             		        	     	  */
/**********************************************************************/
/*                     IMPORTANTE                                  	  */
/*   Esta aplicacion es parte de los  paquetes bancarios      	      */
/*   propiedad de COBISCORP.                               		      */
/*   Su uso no autorizado queda  expresamente  prohibido    	      */
/*   asi como cualquier alteracion o agregado hecho  por    	      */
/*   alguno de sus usuarios sin el debido consentimiento    	      */
/*   por escrito de COBISCORP.                                 		  */
/*   Este programa esta protegido por la ley de derechos    	      */
/*   de autor y por las convenciones  internacionales de    		  */
/*   propiedad intelectual.  Su uso  no  autorizado dara    		  */
/*   derecho a COBISCORP para obtener ordenes  de secuestro           */
/*   o  retencion  y  para  perseguir  penalmente a  los    		  */
/*   autores de cualquier infraccion.                       		  */
/**********************************************************************/
/*                     PROPOSITO                            		  */
/*            Autorizacion de los servicios de workflow           	  */
/**********************************************************************/
/*                     MODIFICACIONES                       		  */
/*   FECHA               AUTOR                  RAZON         		  */
/*   15-Abr-2015        Alex Carrillo           Emision Inicial    	  */
/**********************************************************************/


--------------------------------------------------------------------------------------------------------------------
/*================================================================================================================*/
/* 					SCRIPT PARA INSERTAR DATOS EN LA TABLA cts_serv_catalog  PARA LOS SERVICIOS DE WORKFLOW MONITOR*/
/*================================================================================================================*/
--------------------------------------------------------------------------------------------------------------------
use cobis
go

delete from ad_servicio_autorizado where ts_servicio like 'WFMonitor.Proceso%'
delete from cts_serv_catalog where csc_service_id like 'WFMonitor.Proceso%'

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'WFMonitor.Proceso.GetActivitySummary')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('WFMonitor.Proceso.GetActivitySummary','cobiscorp.ecobis.wfmonitor.service.IProceso','getActivitySummary',' ',73800,'Y')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'WFMonitor.Proceso.GetOfficeByUser')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('WFMonitor.Proceso.GetOfficeByUser','cobiscorp.ecobis.wfmonitor.service.IProceso','getOfficeByUser',' ',73805,'Y')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'WFMonitor.Proceso.GetProcessVersions')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('WFMonitor.Proceso.GetProcessVersions','cobiscorp.ecobis.wfmonitor.service.IProceso','queryProcessVersions',' ',73804,'Y')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'WFMonitor.Proceso.GetSummaryByProcessId')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('WFMonitor.Proceso.GetSummaryByProcessId','cobiscorp.ecobis.wfmonitor.service.IProceso','getSummaryByProcessId',' ',73801,'Y')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'WFMonitor.Proceso.ObtenerResumen')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('WFMonitor.Proceso.ObtenerResumen','cobiscorp.ecobis.wfmonitor.service.IProceso','obtenerResumen',' ',73802,'Y')

if not exists (select 1 from cts_serv_catalog where csc_service_id = 'WFMonitor.Proceso.QueryActivities')
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation)
values('WFMonitor.Proceso.QueryActivities','cobiscorp.ecobis.wfmonitor.service.IProceso','queryActivities',' ',73803,'Y')

------------------------------------------------------------------------------------------------------------------------------------
/*================================================================================================================================*/
/* 					SCRIPT PARA INSERTAR DATOS EN LA TABLA ad_servicio_autorizado  PARA AUTORIZAR LOS SERVICIOS DE WORKFLOW MONITOR*/
/*================================================================================================================================*/
------------------------------------------------------------------------------------------------------------------------------------
if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'WFMonitor.Proceso.GetActivitySummary')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('WFMonitor.Proceso.GetActivitySummary',3,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'WFMonitor.Proceso.GetOfficeByUser')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('WFMonitor.Proceso.GetOfficeByUser',3,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'WFMonitor.Proceso.GetProcessVersions')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('WFMonitor.Proceso.GetProcessVersions',3,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'WFMonitor.Proceso.GetSummaryByProcessId')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('WFMonitor.Proceso.GetSummaryByProcessId',3,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'WFMonitor.Proceso.ObtenerResumen')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('WFMonitor.Proceso.ObtenerResumen',3,1,'R',0,getdate(),'V',getdate())

if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'WFMonitor.Proceso.QueryActivities')
insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('WFMonitor.Proceso.QueryActivities',3,1,'R',0,getdate(),'V',getdate())

go
