/**********************************************************************/
/*   Archivo:         wf_authorization_procedure.sql  	              */
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
/*  Autorizacion de los procedimientos almacenados de Workflow     	  */
/**********************************************************************/
/*                     MODIFICACIONES                       		  */
/*   FECHA               AUTOR                  RAZON         		  */
/*   15-Abr-2015        Diego Castro         Emision Inicial    	  */
/**********************************************************************/


--------------------------------------------------------------------------------------------------------------------------------------------------
/*===============================================================================================================================================*/
/* 					SCRIPT PARA INSERTAR DATOS EN LA TABLA ad_procedure  PARA LOS PROCEDURE DE WORKFLOW                                          */
/*===============================================================================================================================================*/
--------------------------------------------------------------------------------------------------------------------------------------------------

use cobis
go

-- Stored Procedures de Cobis WorkFlow.
delete ad_procedure 
 where pd_procedure between 31750 and 31903
go

delete ad_procedure 
 where pd_procedure between 32001 and 32018
go

delete ad_procedure 
 where pd_procedure between 32251 and 32259
go

delete ad_procedure 
 where pd_procedure between 32279 and 32290
go

if not exists (select 1 from ad_procedure where pd_procedure = 31750) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31750,'sp_cons_proceso_wf','cob_workflow','V',getdate(),'wf_cons_proces')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31751) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31751,'sp_cons_empresa_wf','cob_workflow','V',getdate(),'wf_cons_empres')
go
  
if not exists (select 1 from ad_procedure where pd_procedure = 31752) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31752,'sp_proceso_wf','cob_workflow','V',getdate(),'wf_proceso.sp')
go
   
if not exists (select 1 from ad_procedure where pd_procedure = 31753) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31753,'sp_cons_ver_proc_wf','cob_workflow','V',getdate(),'wf_cons_ver_pr')
go
	
if not exists (select 1 from ad_procedure where pd_procedure = 31754) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31754,'sp_cons_act_proceso_wf','cob_workflow','V',getdate(),'wf_cons_act_pr')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31755) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31755,'sp_paso_wf','cob_workflow','V',getdate(),'wf_paso.sp')
go
 
if not exists (select 1 from ad_procedure where pd_procedure = 31756) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31756,'sp_enlace_wf','cob_workflow','V',getdate(),'wf_enlace.sp')
go
  
if not exists (select 1 from ad_procedure where pd_procedure = 31757) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31757,'sp_info_actividad_wf','cob_workflow','V',getdate(),'wf_info_activi')
go
   
if not exists (select 1 from ad_procedure where pd_procedure = 31758) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31758,'sp_cons_jerarquia_wf','cob_workflow','V',getdate(),'wf_cons_jerarq')
go
	
if not exists (select 1 from ad_procedure where pd_procedure = 31759) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31759,'sp_cond_enlace_proc_wf','cob_workflow','V',getdate(),'wf_cond_enlace')
go
	 
if not exists (select 1 from ad_procedure where pd_procedure = 31760) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31760,'sp_par_programa_wf','cob_workflow','V',getdate(),'wf_par_program')
go
	  
if not exists (select 1 from ad_procedure where pd_procedure = 31761) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31761,'sp_version_proc_wf','cob_workflow','V',getdate(),'wf_version_pro')
go
	   
if not exists (select 1 from ad_procedure where pd_procedure = 31762) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31762,'sp_act_paso_enlace_wf','cob_workflow','V',getdate(),'wf_act_paso_en')
go
		
if not exists (select 1 from ad_procedure where pd_procedure = 31763) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31763,'sp_cons_var_wf','cob_workflow','V',getdate(),'wf_cons_var.sp')
go
		 
if not exists (select 1 from ad_procedure where pd_procedure = 31764) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31764,'sp_cons_inst_wf','cob_workflow','V',getdate(),'wf_cons_inst.s')
go
		  
if not exists (select 1 from ad_procedure where pd_procedure = 31765) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31765,'sp_cons_excep_wf','cob_workflow','V',getdate(),'wf_cons_excep.')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31766) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31766,'sp_cons_doc_wf','cob_workflow','V',getdate(),'wf_cons_doc.sp')
go
 
if not exists (select 1 from ad_procedure where pd_procedure = 31767) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31767,'sp_aso_var_proc_wf','cob_workflow','V',getdate(),'wf_aso_var_pro')
go
  
if not exists (select 1 from ad_procedure where pd_procedure = 31768) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31768,'sp_aso_ins_proc_wf','cob_workflow','V',getdate(),'wf_aso_ins_pro')
go
   
if not exists (select 1 from ad_procedure where pd_procedure = 31769) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31769,'sp_aso_exc_proc_wf','cob_workflow','V',getdate(),'wf_aso_exc_pro')
go
	
if not exists (select 1 from ad_procedure where pd_procedure = 31770) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31770,'sp_aso_requisito_wf','cob_workflow','V',getdate(),'wf_aso_requisi')
go
	 
if not exists (select 1 from ad_procedure where pd_procedure = 31771) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31771,'sp_cola_wf','cob_workflow','V',getdate(),'wf_cola.sp')
go
	  
if not exists (select 1 from ad_procedure where pd_procedure = 31772) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31772,'sp_cons_usuario_wf','cob_workflow','V',getdate(),'wf_cons_usuari')
go
	   
if not exists (select 1 from ad_procedure where pd_procedure = 31773) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31773,'sp_cons_rol_wf','cob_workflow','V',getdate(),'wf_cons_rol.sp')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31774) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31774,'sp_cons_programa_wf','cob_workflow','V',getdate(),'wf_cons_progra')
go
		 
if not exists (select 1 from ad_procedure where pd_procedure = 31775) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31775,'sp_cons_cola_wf','cob_workflow','V',getdate(),'wf_cons_cola.s')
go
		  
if not exists (select 1 from ad_procedure where pd_procedure = 31776) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31776,'sp_cons_d_carga_wf','cob_workflow','V',getdate(),'wf_cons_d_carg')
go
		   
if not exists (select 1 from ad_procedure where pd_procedure = 31777) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31777,'sp_cons_actividad_wf','cob_workflow','V',getdate(),'wf_cons_activi')
go
			
if not exists (select 1 from ad_procedure where pd_procedure = 31778) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31778,'sp_cons_enlace_wf','cob_workflow','V',getdate(),'wf_cons_enlace')
go
			 
if not exists (select 1 from ad_procedure where pd_procedure = 31779) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31779,'sp_cons_gen_expr_wf','cob_workflow','V',getdate(),'wf_cons_gen_ex')
go
			  
if not exists (select 1 from ad_procedure where pd_procedure = 31780) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31780,'sp_aso_par_var_proc_wf','cob_workflow','V',getdate(),'wf_aso_par_var')
go
			   
if not exists (select 1 from ad_procedure where pd_procedure = 31781) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31781,'sp_cons_par_prog_wf','cob_workflow','V',getdate(),'wf_cons_par_pr')
go
				
if not exists (select 1 from ad_procedure where pd_procedure = 31782) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31782,'sp_aso_resultado_wf','cob_workflow','V',getdate(),'wf_aso_resulta')
go
				 
if not exists (select 1 from ad_procedure where pd_procedure = 31783) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31783,'sp_actividad_wf','cob_workflow','V',getdate(),'wf_actividad.s')
go
				  
if not exists (select 1 from ad_procedure where pd_procedure = 31784) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31784,'sp_mapeo_var_proc_wf','cob_workflow','V',getdate(),'wf_mapeo_var_p')
go
				   
if not exists (select 1 from ad_procedure where pd_procedure = 31785) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31785,'sp_paso_lan_inf_wf','cob_workflow','V',getdate(),'wf_paso_lan_in')
go
					
if not exists (select 1 from ad_procedure where pd_procedure = 31786) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31786,'sp_rol_wf','cob_workflow','V',getdate(),'wf_rol.sp')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31787) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31787,'sp_actualiza_rol_wf','cob_workflow','V',getdate(),'wf_actualiza_r')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31788) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31788,'sp_aso_usuario_rol_wf','cob_workflow','V',getdate(),'wf_aso_usuario')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31789) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31789,'sp_atrib_usu_rol_wf','cob_workflow','V',getdate(),'wf_atrib_usu_r')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31790) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31790,'sp_aso_atr_usu_rol_wf','cob_workflow','V',getdate(),'wf_aso_atr_usu')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31791) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31791,'sp_usuario_wf','cob_workflow','V',getdate(),'wf_usuario.sp')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31792) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31792,'sp_cons_atributo_wf','cob_workflow','V',getdate(),'wf_cons_atribu')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31793) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31793,'sp_aso_atrbto_usu_wf','cob_workflow','V',getdate(),'wf_aso_atrbto_')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31794) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31794,'sp_instruccion_wf','cob_workflow','V',getdate(),'wf_instruccion')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31795) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31795,'sp_excepcion_wf','cob_workflow','V',getdate(),'wf_excepcion.s')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31796) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31796,'sp_resultado_wf','cob_workflow','V',getdate(),'wf_resultado.s')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31797) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31797,'sp_cons_result_wf','cob_workflow','V',getdate(),'wf_cons_result')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31798) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31798,'sp_atribucion_wf','cob_workflow','V',getdate(),'wf_atribucion.')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31799) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31799,'sp_cons_atrib_wf','cob_workflow','V',getdate(),'wf_cons_atrib.')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31800) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31800,'sp_tipo_doc_wf','cob_workflow','V',getdate(),'wf_tipo_doc.sp')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31801) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31801,'sp_atributo_wf','cob_workflow','V',getdate(),'wf_atributo.sp')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31802) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31802,'sp_variable_wf','cob_workflow','V',getdate(),'wf_variable.sp')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31803) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31803,'sp_programa_wf','cob_workflow','V',getdate(),'wf_programa.sp')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31804) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31804,'sp_dist_carga_wf','cob_workflow','V',getdate(),'wf_dist_carga.')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31805) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31805,'sp_cons_prodcobis_wf','cob_workflow','V',getdate(),'wf_cons_prodco')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31806) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31806,'sp_cons_observacion_wf','cob_workflow','V',getdate(),'wf_cons_observ')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31807) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31807,'sp_observacion_wf','cob_workflow','V',getdate(),'wf_observacion')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31808) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31808,'sp_jerarquia_wf','cob_workflow','V',getdate(),'wf_jerarquia.s')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31809) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31809,'sp_rol_jerarquia_wf','cob_workflow','V',getdate(),'wf_rol_jerarqu')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31810) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31810,'sp_enlace_roles_wf','cob_workflow','V',getdate(),'wf_enlace_role')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31811) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31811,'sp_politica_wf','cob_workflow','V',getdate(),'wf_politica.sp')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31812) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31812,'sp_cons_politica_wf','cob_workflow','V',getdate(),'wf_cons_politi')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31813) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31813,'sp_desc_parametro_wf','cob_workflow','V',getdate(),'wf_desc_parame')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31814) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31814,'sp_cons_inst_act_wf','cob_workflow','V',getdate(),'wf_cons_inst_a')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31815) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31815,'sp_rechaza_actividad_wf','cob_workflow','V',getdate(),'wf_rechaza_act')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31816) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31816,'sp_clon_plantilla_wf','cob_workflow','V',getdate(),'wf_clon_planti')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31817) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31817,'sp_cons_docum_wf','cob_workflow','V',getdate(),'wf_cons_docum.')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31818) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31818,'sp_documento_wf','cob_workflow','V',getdate(),'wf_instruccion')
go

if not exists (select 1 from ad_procedure where pd_procedure = 31819) 
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
values(31819,'sp_aso_doc_proc_wf','cob_workflow','V',getdate(),'wf_aso_doc_pro')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 31820) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(31820,'sp_type_rule_wf','cob_workflow','V',getdate(),'wf_type_rule.s')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 31821) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(31821,'sp_receptor_cliente_wf','cob_workflow','V',getdate(),'wf_receptor_cl')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 31822) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(31822,'sp_tipo_jerarquia_tpl_wf','cob_workflow','V',getdate(),'wf_tipo_jerarq')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 31823) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(31823,'sp_nivel_jerarquia_tpl_wf','cob_workflow','V',getdate(),'wf_nivel_jerar')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 31824) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(31824,'sp_item_jerarquia_tpl_wf','cob_workflow','V',getdate(),'wf_item_jerarq')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 31825) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(31825,'sp_usuario_jerarquia_tpl_wf','cob_workflow','V',getdate(),'wf_usuario_jer')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 31826) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(31826,'sp_item_jerarquia_wf','cob_workflow','V',getdate(),'wf_item_jerarq')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 31827) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(31827,'sp_paso_pol_wf','cob_workflow','V',getdate(),'wf_paso_pol.sp')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 31831) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values (31831, 'sp_cons_usr_escalar_wf', 'cob_workflow', 'V', getDate(), 'wf_cons_usr_escalar')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 31832) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values (31832, 'sp_cons_usr_tomar_wf', 'cob_workflow', 'V', getDate(), 'wf_cons_usr_tomar')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 31902) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(31902,'sp_jerarquias_wf','cob_workflow','V',getdate(),'sp_jerarquias.')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 31903) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(31903,'sp_errores_proceso_wf','cob_workflow','V',getdate(),'errores_proces')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32001) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32001,'sp_cons_act_usr_wf','cob_workflow','V',getdate(),'wf_cons_act_us')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32002) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32002,'sp_reasigna_actividad_wf','cob_workflow','V',getdate(),'wf_reasigna_ac')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32003) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32003,'sp_resp_actividad_wf','cob_workflow','V',getdate(),'wf_resp_activi')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32004) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32004,'sp_m_inst_proceso_wf','cob_workflow','V',getdate(),'wf_m_inst_proc')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32005) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32005,'sp_exc_inst_proc_wf','cob_workflow','V',getdate(),'wf_exc_inst_pr')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32006)
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32006,'sp_ins_inst_proc_wf','cob_workflow','V',getdate(),'wf_ins_inst_pr')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32007) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32007,'sp_requisito_actividad_wf','cob_workflow','V',getdate(),'wf_requisito_a')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32008) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32008,'sp_observacion_asig_wf','cob_workflow','V',getdate(),'wf_observacion')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32009) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32009,'sp_valor_variable_wf','cob_workflow','V',getdate(),'wf_valor_varia')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32010) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32010,'sp_m_aprobacion_wf','cob_workflow','V',getdate(),'wf_m_aprobacio')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32011) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32011,'sp_m_asig_act_wf','cob_workflow','V',getdate(),'wf_m_asig_act.')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32012) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32012,'sp_ins_exc_aprob_wf','cob_workflow','V',getdate(),'wf_ins_exc_apr')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32013) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32013,'sp_info_proceso_wf','cob_workflow','V',getdate(),'wf_info_proces')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32014) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32014,'sp_inicia_proceso_wf','cob_workflow','V',getdate(),'wf_inicia_proc')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32015) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32015,'sp_funcionalidad_wf','cob_workflow','V',getdate(),'wf_funcionalid')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32016) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32016,'sp_asig_mult_man_wf','cob_workflow','V',getdate(),'wf_asig_mult_m')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32017) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32017,'sp_m_asigna_multiple_wf','cob_workflow','V',getdate(),'wf_m_asigna_mu')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32018) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32018,'sp_m_interfaz_wf','cob_workflow','V',getdate(),'wf_m_interfaz.')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32251) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32251,'sp_resumen_req_wf','cob_workflow','V',getdate(),'wf_resumen_req')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32252) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32252,'sp_res_act_req_wf','cob_workflow','V',getdate(),'wf_res_act_req')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32253) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32253,'sp_res_usu_req_wf','cob_workflow','V',getdate(),'wf_res_usu_req')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32254) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32254,'sp_alertas_wf','cob_workflow','V',getdate(),'wf_alertas.sp')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32255) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32255,'sp_resumen_rol_wf','cob_workflow','V',getdate(),'wf_resumen_rol')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32256) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32256,'sp_mon_requerimientos_wf','cob_workflow','V',getdate(),'wf_mon_requeri')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32257) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32257,'sp_voto_comite_wf','cob_workflow','V',getdate(),'wf_voto_comite')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32258) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32258,'sp_resumen_col_wf','cob_workflow','V',getdate(),'wf_resumen_col')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32259) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32259,'sp_documento_proceso_wf','cob_workflow','V',getdate(),'wf_documento_p')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32280) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32280,'sp_reversos','cob_workflow','V',getdate(),'sp_reversos')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32281) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32281,'sp_instruc_ins_proc_wf','cob_workflow','V',getdate(),'wf_instruc_ins')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32282) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32282,'sp_cons_proc_prog_wf','cob_workflow','V',getdate(),'wf_cons_proc_p')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 32283) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32283,'sp_errores_proceso_wf','cob_workflow','V',getdate(),'wf_errores_pro')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73501) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73501,'sp_actualiza_var_wf','cob_workflow','V',getdate(),'wf_actualiza_v')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73502) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73502,'sp_claim_task_wf','cob_workflow','V',getdate(),'wf_claim_task.')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73503) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73503,'sp_cons_act_proceso_wf','cob_workflow','V',getdate(),'wf_cons_act_pr')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73504) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73504,'sp_cons_act_sup_wf','cob_workflow','V',getdate(),'wf_cons_act_su')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73505) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73505,'sp_cons_act_usr_wf','cob_workflow','V',getdate(),'wf_cons_act_us')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73506) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73506,'sp_cons_proceso_wf','cob_workflow','V',getdate(),'wf_cons_proces')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73507) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73507,'sp_cons_usr_reasig_wf','cob_workflow','V',getdate(),'wf_cons_usr_re')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73508) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73508,'sp_cons_usuario_wf','cob_workflow','V',getdate(),'wf_cons_usuari')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73509) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73509,'sp_cons_var_wf','cob_workflow','V',getdate(),'wf_cons_var.sp')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73510) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73510,'sp_grafico_wf','cob_workflow','V',getdate(),'wf_grafico.sp')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73511) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73511,'sp_info_proceso_wf','cob_workflow','V',getdate(),'wf_info_proces')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73512) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73512,'sp_inicia_proceso_wf','cob_workflow','V',getdate(),'wf_inicia_proc')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73513) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73513,'sp_m_inst_proceso_masivo_wf','cob_workflow','V',getdate(),'wf_m_inst_proc')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73514) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73514,'sp_observacion_asig_wf','cob_workflow','V',getdate(),'wf_observacion')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73515) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73515,'sp_reasigna_actividad_wf','cob_workflow','V',getdate(),'wf_reasigna_ac')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73516) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73516,'sp_res_usu_req_wf','cob_workflow','V',getdate(),'wf_res_usu_req')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73517) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73517,'sp_resp_actividad_wf','cob_workflow','V',getdate(),'wf_resp_activi')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73522) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73522,'sp_requisito_actividad_wf','cob_workflow','V',getdate(),'requisito_acti')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73523) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73523,'sp_consulta_usuarios_workflow','cob_workflow','V',getdate(),'sp_consulta_us')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73524) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73524,'sp_m_observacion_actividad_wf','cob_workflow','V',getdate(),'wf_m_observaci')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73800) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73800,'sp_activity_detail','cob_workflow','V',getdate(),'wfm_activity_d')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73801) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73801,'sp_process_detail','cob_workflow','V',getdate(),'wfm_process_de')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73802) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73802,'sp_resumen_wf','cob_workflow','V',getdate(),'wf_resumen.sp')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73803) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73803,'sp_activity_detail','cob_workflow','V',getdate(),'wfm_activity_d')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73804) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73804,'sp_process_detail','cob_workflow','V',getdate(),'wfm_process_de')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73805) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73805,'sp_user_office','cob_workflow','V',getdate(),'wf_user_office.sp')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73914) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73914,'sp_consulta_operacion','cob_workflow','V',getdate(),'sp_consulta_op')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73915) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73915,'sp_tramite_paso_cartera','cob_workflow','V',getdate(),'sp_tramite_pas')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73920) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73920,'sp_reestructuracion_wf','cob_workflow','V',getdate(),'sp_reestructur')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 73921) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(73921,'sp_ruteo_linea_wf','cob_workflow','V',getdate(),'sp_ruteo_linea')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 80000) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(80000,'sp_seudo_catalogo_procesos','cob_workflow','V',getdate(),'seudo_catalogo')
go

 if not exists (select 1 from ad_procedure where pd_procedure = 2104607) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(2104607,'sp_tarea_calendarizada','cob_workflow','V',getdate(),'wf_tarcalen.sp')
go

if not exists (select 1 from ad_procedure where pd_procedure = 32284) 
 insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo) 
 values(32284,'sp_seudo_catalogo_producto','cob_workflow','V',getdate(),'seudo_catalogo_producto.sp')
go

if not exists (select 1 from ad_procedure where pd_procedure = 32285) 
insert into cobis..ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (32285, 'sp_scheduler_alert_wf', 'cob_workflow', 'V', getdate (), 'wf_scheduler_alerts.sp')
go


 
--------------------------------------------------------------------------------------------------------------------------------------------------
/*===============================================================================================================================================*/
/* 					SCRIPT PARA INSERTAR DATOS EN LA TABLA cl_ttransaccion  PARA LOS PROCEDURE DE WORKFLOW                                       */
/*===============================================================================================================================================*/
--------------------------------------------------------------------------------------------------------------------------------------------------

delete cl_ttransaccion
  where tn_trn_code between 31750 and 31903
go

delete cl_ttransaccion
  where tn_trn_code between 32001 and 32018
go

delete cl_ttransaccion
  where tn_trn_code between 32251 and 32259
go

delete cl_ttransaccion 
 where tn_trn_code between 32279 and 32290
go
	 
if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31750) 
insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values(31750,'LISTA DE PROCESOS','LPROC','LPROC')
go
 
if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31751) 
insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values(31751,'CONSULTA EMPRESAS','CEMP','CEMP')
go
  
if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31752) 
insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values(31752,'MANTENIMIENTO PROCESOS','MPROC','MPROC')
go
   
if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31753) 
insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values(31753,'CONS VERSION PROC','COVP','COVP')
go
	
if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31754) 
insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values(31754,'LISTA DE ACTIVIDADES','LACT','LACT')
go
	 
if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31755) 
insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values(31755,'MANTENIMIENTO PASO','MPAS','MPAS')
go
	  
if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31756) 
insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values(31756,'MANTENIMIENTO ENLACE','MENL','MENL')
go
	   
if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31757) 
insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values(31757,'MANT INFO ACTPROC','MAPR','MAPR')
go
		
if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31758) 
insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values(31758,'CONS JERARQUIAS','COJE','COJE')
go
		 
if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31759) 
insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values(31759,'MANTENIMIENTO CONDICION','MCON','MCON')
go
  
if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31760) 
insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values(31760,'MANT. PAR. PROG.','MAPP','MAPP')
go
		   
if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31761) 
insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values(31761,'VERSION PROCESO','VPRO','VPRO')
go
			
if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31762) 
insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values(31762,'ACTUALIZACION PASO ENLACE','ACPE','ACPE')
go
			 
if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31763) 
insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values(31763,'CONSULTA VARIABLES','CVAR','CVAR')
go
			  
if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31764) 
insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values(31764,'CONSULTA INSTRUCCIONES','CINS','CINS')
go
			   
if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31765) 
insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values(31765,'CONSULTA EXCEPCIONES','CEXC','CEXC')
go
				
if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31766) 
insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values(31766,'CONSULTA REQUISITOS','CREQ','CREQ')
go
				 
if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31767) 
insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values(31767,'ASOCIA VARIABLES','AVAR','AVAR')
go
				  
if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31768) 
insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values(31768,'ASOCIA INSTRUCCIONES','AINS','AINS')
go
				   
if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31769) 
insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values(31769,'ASOCIA EXCEPCIONES','AEXC','AEXC')
go
					
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31770) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31770,'ASOCIA REQUISITOS','ADRA','ADRA')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31771) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31771,'MANTENIMIENTO COLAS','MACO','MACO')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31772) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31772,'CONSULTA USUARIOS','CUSU','CUSU') 
go
 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31773) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31773,'CONSULTA ROLES','CROL','CROL')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31774) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31774,'CONSULTA PROGRAMAS','CPRG','CPRG')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31775) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31775,'CONSULTA COLAS','CCOL','CCOL')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31776) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31776,'CONSULTA CARGA','CDCG','CDCG')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31777) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31777,'DETALLE DE ACTIVIDAD','DACT','DACT')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31778) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31778,'DETALLE DEL ENLACE','DENL','DENL')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31779) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31779,'CONSULTA EXPRESIONES','CEXP','CEXP')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31780) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31780,'ASOCIA VARIABLE PARAMETRO','VAPA','VAPA')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31781) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31781,'CONSULTA PARAMETROS','CPAR','CPAR')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31782) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31782,'ASOCIA RESULTADO ACTIVIDAD','AREA','AREA')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31783) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31783,'MANTENIMIENTO ACTIVIDAD','MACT','MACT')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31784) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31784,'MAPEO VARIABLES','MAVA','MAVA')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31785) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31785,'ADICIONAL PASO','MAVA','MAVA')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31786) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31786,'MANTENIMIENTO ROL','MROL','MROL')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31787) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31787,'ACTUALIZACION ROL','AROL','AROL')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31788) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31788,'ASOCIA ROL USUARIO','ASRU','ASRU')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31789) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31789,'ATRIB ROL USUARIO','CARU','CARU')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31790) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31790,'ASOCIA ATR ROL USU','AARU','AARU')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31791) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31791,'MANTENIMIENTO USUARIOS','MUSU','MUSU')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31792) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31792,'CONSULTA ATRIBUTOS','CATT','CATT')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31793) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31793,'ASOCIA ATRIBUTOS','AATR','AATR')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31794) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31794,'MANT INSTRUCCION','MAIN','MAIN')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31795) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31795,'MANT EXCEPCION','MAEX','MAEX')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31796) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31796,'MANT RESULTADO','MARE','MARE')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31797) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31797,'CONSULTA RESULTADO','CORE','CORE')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31798) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31798,'MANT ATRIBUCION','MAAT','MAAT')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31799) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31799,'CONS ATRIBUCION','COAT','COAT')
go
 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31800) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31800,'MANT. TIPO DOC.','MTDO','MTDO')
go
  
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31801) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31801,'MANT. ATRIBUTO','MTAT','MTAT')
go
   
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31802) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31802,'MANT. VARIABLE','MAVA','MAVA')
go
	
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31803) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31803,'MANT. PROGRAMA','MPRO','MPRO')
go
 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31804) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31804,'MANT. DIST. CARGA','MDCA','MDCA')
go
  
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31805) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31805,'CONS PROD COBIS','CPRC','CPRC')
go
	   
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31806) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31806,'CONS OBSERVACIONES','COBS','COBS')
go
		
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31807) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31807,'MANT OBSERVACIONES','MOBS','MOBS')
go
		 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31808) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31808,'MANT JERARQUIAS','MJER','MJER')
go
		  
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31809) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31809,'MANT ROL JERARQUIAS','MRJE','MRJE')
go
		   
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31810) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31810,'MANT ENLACE ROL','MERO','MERO')
go
			
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31811) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31811,'MANT POLITICAS','MAPO','MAPO')
go
			 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31812) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31812,'CONS POLITICAS','COPO','COPO')
go
			  
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31813) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31813,'CONS PAR COBIS','PACO','PACO')
go
			   
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31814) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31814,'CONS INST ACT','CIDA','CIDA')
go
				
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31815) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31815,'DEV ACT','DEVA','DEVA')
go
				 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31816) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31816,'CLONA PLANTILLAS','CLON','CLON')
go
				  
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31817) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31817,'CONSULTA DOCUMENTOS','CDOC','CDOC')
go
				   
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31818) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31818,'MANTENIMIENTO DOCUMENTOS','MDOC','MDOC')
go
					
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31819) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31819,'ASO DOCUMENTOS A PROC','ADAP','ADAP')
go
 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31820) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31820,'CONS. REGLAS SUBTIPO','CRS','CRS')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31831) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values (31831, 'JERARQUIA DE USUARIOS A ESCALAR', 'JEUS', 'JEUS')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31832) 
 insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
 values (31832, 'USUARIO PARA TOMAR TAREA', 'UPTT', 'UPTT')
go

 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31821) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31821,'MAN. RECEPTOR CLIENTE','MRC','MRC')
go
   
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31822) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31822,'TIPO JERARQUIA TPL','TJT','TJT')
go
	
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31823) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31823,'NIVEL JERARQUIA TPL','NJT','NJT')
go
	 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31824) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31824,'ITEM JERARQUIA TPL','IJT','IJT')
go
	  
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31825) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31825,'USUARIO JERARQUIA TPL','UJT','UJT')
go
	   
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31826) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31826,'ITEM JERARQUIA','ITJ','ITJ')
go
		
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 31827) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(31827,'PASO POLITICA','PPOL','PPOL')
go
		 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32001) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32001,'ACTIVIDADES USUARIO','ACUS','ACUS')
go
		  
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32002) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32002,'REASIGNACION ACTIVIDAD','REAS','REAS')
go
		   
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32003) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32003,'RESPONDE ACTIVIDAD','REAC','REAC')
go
			
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32004) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32004,'INSTANCIA DE PROCESO','IDEP','IDEP')
go
			 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32005) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32005,'MANT EXC INST PROC','MEIP','MEIP')
go
			  
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32006) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32006,'MANT INS INST PROC','MIIP','MIIP')
go
			   
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32007) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32007,'REQUISITO ACTIVIDAD','REIA','REIA')
go
				
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32008) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32008,'MANT OBS INST PROC','MOIP','MOIP')
go
				 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32009) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32009,'MANT VALOR VARIABLE','MVVA','MVVA')
go
				  
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32010) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32010,'APROB INST - EXC','APIE','APIE')
go
				   
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32011) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32011,'ASIGNACION ACTIVIDAD','ASAC','ASAC')
go
					
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32012) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32012,'CONS. APROBACION','COAP','COAP')
go
			
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32013) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32013,'INFO REQUERIMIENTO','INRE','INRE')
go
 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32014) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32014,'INICIA REQ','IREQ','IREQ')
go
  
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32015) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32015,'VALIDA FUNC','VAFU','VAFU')
go
   
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32016) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32016,'ASIG MAN MULT','MAMU','MAMU')
go
	
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32017) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32017,'ASIG MULT','ASMU','ASMU')
go
	 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32018) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32018,'DATOS INTERFAZ','DAIN','DAIN')
go
	  
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32251) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32251,'RESUMENES REQUERIMIENTO','RREQ','RREQ')
go
	   
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32252) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32252,'ACTIVIDADES REQUERIMIENTO','RARQ','RARQ')
go
		
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32253) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32253,'USUARIO-ROL REQ.','URRQ','URRQ')
go
	 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32254) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32254,'MENSAJES DE ALERTA','ALER','ALER')
go
		  
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32255) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32255,'RESUMENES ROL','RROL','RROL')
go
		   
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32256) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32256,'CONS CRIT MON','CCMO','CCMO')
go
			
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32257) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32257,'VOTOS DEL COMITE','VCOM','VCOM')
go
			 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32258) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32258,'CONS. MON SUP/COL','CMSC','CMSC')
go
			  
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32259) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32259,'DOCUMENTO PROCESO','DCIP','DCIP')
go
			   
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32280) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32280,'REVERSAR ACTIVIDADES DE UN PROCESO','RADP','RADP')
go
				
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32281) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32281,'RELACION INSTRUCCIONES WF CON CREDITO','RIWFCR','RIWFCR')
go
				 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32282) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32282,'BUSQUEDA DE PROGRAMAS ASOCIADOS AL PROCESOS','BPAP','BPAP')
go
  
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32283) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32283,'BUSQUEDA ERRORES PROCESO WF','WFERBU','WFERBU')
go
   
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73501) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73501,'UpdateVariable','UV','UV')
go
	
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73503) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73503,'CancelTask','CT','CT')
go
	 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73504) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73504,'ClaimTask','ClT','ClT')
go
	  
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73505) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73505,'CompleteTask','CoT','CoT')
go
   
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73506) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73506,'CreateProcessInstance','CPI','CPI')
go
	
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73507) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73507,'GetCurrentTask','GCT','GCT')
go
	 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73508) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73508,'GetHumanTasksByProcess','GHT','GHT')
go
	  
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73509) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73509,'GetProcessesList','GPL','GPL')
go
	   
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73510) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73510,'GetReassignUsers','GRU','GRU')
go
		
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73511) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73511,'GetSupervisorActivityList','GSL','GSL')
go
		 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73512) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73512,'GetSupervisorActivityStatusList','GSS','GSS')
go
		  
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73513) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73513,'GetSupervisorProcessList','GSP','GSP')
go
		   
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73514) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73514,'GetSupervisorTaskList','GSP','GSP')
go
			
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73515) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73515,'GetTaskList','GTL','GTL')
go
			 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73516) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73516,'ReassignTask','RT','RT')
go
			  
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73517) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73517,'ResumeTask','ReT','ReT')
go
			   
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73522) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73522,'GetAllProductQueryCatalog','GAP','GAP')
go
				
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73523) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73523,'GetProductQueryCatalogByIndex','GPQ','GPQ')
go
				 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73524) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73524,'GetBPMIdentifier','GBI','GBI')
go
				  
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73800) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73800,'GetActivitySummary','GAS','GAS')
go
				   
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73801) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73801,'GetSummaryByProcessId','GSP','GSP')
go
					
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73802) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73802,'ObtenerResumen','ORS','ORS')
go
				 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73803) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73803,'QueryActivities','QAC','QAC')
go
					  
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73804) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73804,'QueryProcessVersions','QPV','QPV')
go


 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73805) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73805,'GetOfficeByUser','OFUSER','OFUSER')
go
					   
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73914) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73914,'CONSULTA OPERACION','DOPE','DOPE')
go
						
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73915) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73915,'PASO DE DATOS DE TRAMITE A CARTERA','PTCR','PTCR')
go
						 
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73920) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73920,'REALIZA LA RESTRUCTURACION DE UNA OPERACION','REOP','REOP')
go
						  
 if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73921) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(73921,'ACTIVA UNA LINEA DE CREDITO','AMLC','AMLC')
go

if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32284) 
 insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
 values(32284,'SEUDOCATALOGO PRODUCTO','SUCP','SUCP')
go

if not exists (select 1 from cl_ttransaccion where tn_trn_code = 32285) 
insert into cl_ttransaccion(tn_trn_code, tn_descripcion,tn_nemonico, tn_desc_larga)
values (32285, 'SchedulerAlert', 'SAL', 'SCHEDULER ALERT')
go 

						   
 --------------------------------------------------------------------------------------------------------------------------------------------------
/*===============================================================================================================================================*/
/* 					SCRIPT PARA INSERTAR DATOS EN LA TABLA cl_ttransaccion  PARA LOS PROCEDURE DE WORKFLOW                                       */
/*===============================================================================================================================================*/
---------------------------------------------------------------------------------------------------------------------------------------------------  

delete ad_pro_transaccion
 where pt_producto = 43
   and pt_transaccion between 31750 and 31903
go

delete ad_pro_transaccion
 where pt_producto = 43
  and  pt_transaccion between 32001 and 32018
go

delete ad_pro_transaccion
 where pt_producto = 43
   and pt_transaccion between 32251 and 32259
go

delete ad_pro_transaccion
 where pt_producto = 43
   and pt_transaccion between 32279 and 32290
go


 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31750) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31750,'V',getdate(),31750)
go
 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31751) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31751,'V',getdate(),31751)
go
  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31752) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31752,'V',getdate(),31752)
go
   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31753) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31753,'V',getdate(),31753)
go
	
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31754) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31754,'V',getdate(),31754)
go
	 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31755) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31755,'V',getdate(),31755)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31756) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31756,'V',getdate(),31756)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31757) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31757,'V',getdate(),31757)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31758) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31758,'V',getdate(),31758)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31759) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31759,'V',getdate(),31759)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31760) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31760,'V',getdate(),31760)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31761) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31761,'V',getdate(),31761)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31762) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31762,'V',getdate(),31762)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31763) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31763,'V',getdate(),31763)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31764) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31764,'V',getdate(),31764)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31765) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31765,'V',getdate(),31765)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31766) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31766,'V',getdate(),31766)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31767) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31767,'V',getdate(),31767)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31768) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31768,'V',getdate(),31768)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31769) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31769,'V',getdate(),31769)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31770) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31770,'V',getdate(),31770)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31771) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31771,'V',getdate(),31771)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31772) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31772,'V',getdate(),31772)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31773) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31773,'V',getdate(),31773)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31774) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31774,'V',getdate(),31774)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31775) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31775,'V',getdate(),31775)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31776) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31776,'V',getdate(),31776)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31777) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31777,'V',getdate(),31777)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31778) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31778,'V',getdate(),31778)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31779) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31779,'V',getdate(),31779)
go
 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31780) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31780,'V',getdate(),31780)
go
  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31781) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31781,'V',getdate(),31781)
go
   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31782) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31782,'V',getdate(),31782)
go
	
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31783) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31783,'V',getdate(),31783)
go
	 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31784) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31784,'V',getdate(),31784)
go
	  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31785) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31785,'V',getdate(),31785)
go
	   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31786) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31786,'V',getdate(),31786)
go
		
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31787) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31787,'V',getdate(),31787)
go
		 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31788) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31788,'V',getdate(),31788)
go
		  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31789) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31789,'V',getdate(),31789)
go
 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31790) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31790,'V',getdate(),31790)
go
  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31791) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31791,'V',getdate(),31791)
go
   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31792) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31792,'V',getdate(),31792)
go
	
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31793) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31793,'V',getdate(),31793)
go
	 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31794) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31794,'V',getdate(),31794)
go
	  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31795) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31795,'V',getdate(),31795)
go
	   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31796) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31796,'V',getdate(),31796)
go
		
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31797) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31797,'V',getdate(),31797)
go
		 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31798) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31798,'V',getdate(),31798)
go
		  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31799) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31799,'V',getdate(),31799)
go
		   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31800) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31800,'V',getdate(),31800)
go
			
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31801)
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31801,'V',getdate(),31801)
go
			 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31802) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31802,'V',getdate(),31802)
go
			  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31803) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31803,'V',getdate(),31803)
go
			   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31804) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31804,'V',getdate(),31804)
go
				
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31805) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31805,'V',getdate(),31805)
go
				 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31806) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31806,'V',getdate(),31806)
go
				  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31807) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31807,'V',getdate(),31807)
go
				   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31808) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31808,'V',getdate(),31808)
go
					
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31809) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31809,'V',getdate(),31809)
go
					 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31810) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31810,'V',getdate(),31810)
go
					  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31811) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31811,'V',getdate(),31811)
go
					   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31812) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31812,'V',getdate(),31812)
go
 						
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31813) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31813,'V',getdate(),31813)
go
						 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31814) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31814,'V',getdate(),31814)
go
						  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31815) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31815,'V',getdate(),31815)
go
						   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31816) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31816,'V',getdate(),31816)
go
							
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31817) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31817,'V',getdate(),31817)
go
							 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31818) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31818,'V',getdate(),31818)
go
							  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31819) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31819,'V',getdate(),31819)
go
							   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31820) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31820,'V',getdate(),31820)
go
 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31821) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31821,'V',getdate(),31821)
go
  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31822) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31822,'V',getdate(),31822)
go
   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31823) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31823,'V',getdate(),31823)
go
	
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31824) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31824,'V',getdate(),31824)
go
	 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31825) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31825,'V',getdate(),31825)
go
	  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31826) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31826,'V',getdate(),31826)
go
	   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31827) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31827,'V',getdate(),31827)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31831) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31831,'V',getdate(),31831)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 31832) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,31832,'V',getdate(),31832)
go
		
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32001) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32001,'V',getdate(),32001)
go
		 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32002) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32002,'V',getdate(),32002)
go
		  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32003) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32003,'V',getdate(),32003)
go
		   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32004) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32004,'V',getdate(),32004)
go
			
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32005) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32005,'V',getdate(),32005)
go
			 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32006) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32006,'V',getdate(),32006)
go
			  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32007) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32007,'V',getdate(),32007)
go
			   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32008) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32008,'V',getdate(),32008)
go
				
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32009) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32009,'V',getdate(),32009)
go
				 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32010) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32010,'V',getdate(),32010)
go
				  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32011) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32011,'V',getdate(),32011)
go
				   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32012) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32012,'V',getdate(),32012)
go
					
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32013) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32013,'V',getdate(),32013)
go
					 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32014) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32014,'V',getdate(),32014)
go
					  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32015) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32015,'V',getdate(),32015)
go
					   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32016) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32016,'V',getdate(),32016)
go
						
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32017) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32017,'V',getdate(),32017)
go
						 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32018) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32018,'V',getdate(),32018)
go
						  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32251) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
 values(43,'R',0,32251,'V',getdate(),32251)
go
						   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32252) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32252,'V',getdate(),32252)
go
							
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32253) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32253,'V',getdate(),32253)
go
							 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32254) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32254,'V',getdate(),32254)
go
 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32255) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32255,'V',getdate(),32255)
go
  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32256) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32256,'V',getdate(),32256)
go
   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32257) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32257,'V',getdate(),32257)
go
	
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32258) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32258,'V',getdate(),32258)
go
	 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32259) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32259,'V',getdate(),32259)
go
	  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32280) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32280,'V',getdate(),32280)
go
	   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32281) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32281,'V',getdate(),32281)
go
		
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32282) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32282,'V',getdate(),32282)
go
		 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32283) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(43,'R',0,32283,'V',getdate(),32283)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73501) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73501,'V',getdate(),73501)
go
		   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73502) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73502,'V',getdate(),73502)
go
			
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73503) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73503,'V',getdate(),73503)
go
			 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73504) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73504,'V',getdate(),73504)
go
			  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73505) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73505,'V',getdate(),73505)
go
			   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73506) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73506,'V',getdate(),73506)
go
				
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73507) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73507,'V',getdate(),73507)
go
				 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73508) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73508,'V',getdate(),73508)
go
				  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73509) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73509,'V',getdate(),73509)
go
				   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73510) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73510,'V',getdate(),73510)
go
					
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73511) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73511,'V',getdate(),73511)
go
					 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73512) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73512,'V',getdate(),73512)
go
					  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73513) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73513,'V',getdate(),73513)
go
					   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73514) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73514,'V',getdate(),73514)
go
						
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73515) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73515,'V',getdate(),73515)
go
						 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73516) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73516,'V',getdate(),73516)
go
						  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73517) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73517,'V',getdate(),73517)
go
						   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73522) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73522,'V',getdate(),73522)
go
							
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73523) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73523,'V',getdate(),73523)
go
							 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73524) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73524,'V',getdate(),73524)
go
							  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73800) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73800,'V',getdate(),73800)
go
							   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73801) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73801,'V',getdate(),73801)
go
								
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73802) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73802,'V',getdate(),73802)
go
								 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73803) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73803,'V',getdate(),73803)
go
								  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73804) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73804,'V',getdate(),73804)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73805) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73805,'V',getdate(),73805)
go
								   
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73914) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73914,'V',getdate(),73914)
go
									
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73915) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73915,'V',getdate(),73915)
go
									 
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73920)
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73920,'V',getdate(),73920)
go
									  
 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73921) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,73921,'V',getdate(),73921)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32284) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,32284,'V',getdate(),32284)
go

 if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 32285) 
 insert into ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
 values(73,'R',0,32285,'V',getdate(),32285)
go

 

 --------------------------------------------------------------------------------------------------------------------------------------------------
/*===============================================================================================================================================*/
/* 					SCRIPT PARA INSERTAR DATOS EN LA TABLA ad_tr_autorizada  PARA LOS PROCEDURE DE WORKFLOW                                       */
/*===============================================================================================================================================*/
---------------------------------------------------------------------------------------------------------------------------------------------------
delete ad_tr_autorizada
 where ta_producto = 43
   and ta_transaccion between 31750 and 31903
go

delete ad_tr_autorizada
 where ta_producto = 43
  and ta_transaccion between 32001 and 32018
go

delete ad_tr_autorizada
 where ta_producto = 43
  and ta_transaccion between 32251 and 32259
go

delete ad_tr_autorizada
 where ta_producto = 43
 and ta_transaccion between 32279 and 32290
go

declare @w_rol int

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
	select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
	insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
	values (@w_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31750 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31750,@w_rol,getdate(),1,'V',getdate())
 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31750 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31750,@w_rol,getdate(),3,'V',getdate())

if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31751 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31751,@w_rol,getdate(),1,'V',getdate())

if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31751 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31751,@w_rol,getdate(),3,'V',getdate())
 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31752 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31752,@w_rol,getdate(),1,'V',getdate())
  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31752 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31752,@w_rol,getdate(),3,'V',getdate())
   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31753 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31753,@w_rol,getdate(),1,'V',getdate())

if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31753 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31753,@w_rol,getdate(),3,'V',getdate())

if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31754 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31754,@w_rol,getdate(),1,'V',getdate())

if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31754 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31754,@w_rol,getdate(),3,'V',getdate())

if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31755 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31755,@w_rol,getdate(),1,'V',getdate())

if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31755 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31755,@w_rol,getdate(),3,'V',getdate())

if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31756 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31756,@w_rol,getdate(),1,'V',getdate())

if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31756 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31756,@w_rol,getdate(),3,'V',getdate())

if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31757 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31757,@w_rol,getdate(),1,'V',getdate())

if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31757 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31757,@w_rol,getdate(),3,'V',getdate())

if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31758 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31758,@w_rol,getdate(),1,'V',getdate())

if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31758 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31758,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31759 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31759,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31759 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31759,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31760 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31760,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31760 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31760,@w_rol,getdate(),3,'V',getdate())

 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31761 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31761,@w_rol,getdate(),1,'V',getdate())

 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31761 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31761,@w_rol,getdate(),3,'V',getdate())

 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31762 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31762,@w_rol,getdate(),1,'V',getdate())

  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31762 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31762,@w_rol,getdate(),3,'V',getdate())

   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31763 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31763,@w_rol,getdate(),1,'V',getdate())

	
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31763 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31763,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31764 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31764,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31764 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31764,@w_rol,getdate(),3,'V',getdate())

	   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31765 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31765,@w_rol,getdate(),1,'V',getdate())

		
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31765 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31765,@w_rol,getdate(),3,'V',getdate())

		 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31766 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31766,@w_rol,getdate(),1,'V',getdate())

		  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31766 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31766,@w_rol,getdate(),3,'V',getdate())

		   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31767 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31767,@w_rol,getdate(),1,'V',getdate())

			
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31767 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31767,@w_rol,getdate(),3,'V',getdate())

			 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31768 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31768,@w_rol,getdate(),1,'V',getdate())

			  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31768 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31768,@w_rol,getdate(),3,'V',getdate())

			   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31769 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31769,@w_rol,getdate(),1,'V',getdate())

				
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31769 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31769,@w_rol,getdate(),3,'V',getdate())

				 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31770 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31770,@w_rol,getdate(),1,'V',getdate())

				  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31770 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31770,@w_rol,getdate(),3,'V',getdate())

				   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31771 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31771,@w_rol,getdate(),1,'V',getdate())

					
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31771 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31771,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31772 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31772,@w_rol,getdate(),1,'V',getdate())

					  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31772 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31772,@w_rol,getdate(),3,'V',getdate())

					   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31773 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31773,@w_rol,getdate(),1,'V',getdate())

						
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31773 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31773,@w_rol,getdate(),3,'V',getdate())

						 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31774 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31774,@w_rol,getdate(),1,'V',getdate())

						  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31774 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31774,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31775 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31775,@w_rol,getdate(),1,'V',getdate())

 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31775 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31775,@w_rol,getdate(),3,'V',getdate())

  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31776 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31776,@w_rol,getdate(),1,'V',getdate())

   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31776 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31776,@w_rol,getdate(),3,'V',getdate())

	
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31777 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31777,@w_rol,getdate(),1,'V',getdate())

	 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31777 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31777,@w_rol,getdate(),3,'V',getdate())

	  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31778 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31778,@w_rol,getdate(),1,'V',getdate())

	   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31778 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31778,@w_rol,getdate(),3,'V',getdate())

	
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31779 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31779,@w_rol,getdate(),1,'V',getdate())

		 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31779 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31779,@w_rol,getdate(),3,'V',getdate())

		  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31780 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31780,@w_rol,getdate(),1,'V',getdate())

		   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31780 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31780,@w_rol,getdate(),3,'V',getdate())

			
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31781 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31781,@w_rol,getdate(),1,'V',getdate())

			 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31781 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31781,@w_rol,getdate(),3,'V',getdate())

			  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31782 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31782,@w_rol,getdate(),1,'V',getdate())

			   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31782 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31782,@w_rol,getdate(),3,'V',getdate())

				
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31783 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31783,@w_rol,getdate(),1,'V',getdate())

				 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31783 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31783,@w_rol,getdate(),3,'V',getdate())

				  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31784 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31784,@w_rol,getdate(),1,'V',getdate())

				   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31784 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31784,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31785 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31785,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31785 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31785,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31786 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31786,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31786 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31786,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31787 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31787,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31787 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31787,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31788 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31788,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31788 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31788,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31789 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31789,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31789 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31789,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31790 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31790,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31790 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31790,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31791 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31791,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31791 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31791,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31792 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31792,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31792 and ta_rol = @w_rol)
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31792,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31793 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31793,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31793 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31793,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31794 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31794,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31794 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31794,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31795 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31795,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31795 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31795,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31796 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31796,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31796 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31796,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31797 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31797,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31797 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31797,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31798 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31798,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31798 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31798,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31799 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31799,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31799 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31799,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31800 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31800,@w_rol,getdate(),1,'V',getdate())

 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31800 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31800,@w_rol,getdate(),3,'V',getdate())

  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31801 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31801,@w_rol,getdate(),1,'V',getdate())

   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31801 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31801,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31802 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31802,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31802 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31802,@w_rol,getdate(),3,'V',getdate())

	  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31803 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31803,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31803 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31803,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31804 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31804,@w_rol,getdate(),1,'V',getdate())

		 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31804 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31804,@w_rol,getdate(),3,'V',getdate())

		  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31805 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31805,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31805 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31805,@w_rol,getdate(),3,'V',getdate())

			
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31806 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31806,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31806 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31806,@w_rol,getdate(),3,'V',getdate())

			  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31807 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31807,@w_rol,getdate(),1,'V',getdate())

			   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31807 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31807,@w_rol,getdate(),3,'V',getdate())

				
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31808 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31808,@w_rol,getdate(),1,'V',getdate())

				 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31808 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31808,@w_rol,getdate(),3,'V',getdate())

				  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31809 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31809,@w_rol,getdate(),1,'V',getdate())

				   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31809 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31809,@w_rol,getdate(),3,'V',getdate())

					
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31810 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31810,@w_rol,getdate(),1,'V',getdate())

					 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31810 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31810,@w_rol,getdate(),3,'V',getdate())

					  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31811 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31811,@w_rol,getdate(),1,'V',getdate())

					   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31811 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31811,@w_rol,getdate(),3,'V',getdate())

						
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31812 and ta_rol = @w_rol)
 insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
 values(43,'R',0,31812,@w_rol,getdate(),1,'V',getdate())

						 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31812 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31812,@w_rol,getdate(),3,'V',getdate())

						  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31813 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31813,@w_rol,getdate(),1,'V',getdate())

						   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31813 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31813,@w_rol,getdate(),3,'V',getdate())

							
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31814 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31814,@w_rol,getdate(),1,'V',getdate())

							 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31814 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31814,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31815 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31815,@w_rol,getdate(),1,'V',getdate())

 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31815 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31815,@w_rol,getdate(),3,'V',getdate())

  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31816 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31816,@w_rol,getdate(),1,'V',getdate())

   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31816 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31816,@w_rol,getdate(),3,'V',getdate())

	
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31817 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31817,@w_rol,getdate(),1,'V',getdate())

	 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31817 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31817,@w_rol,getdate(),3,'V',getdate())

	  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31818 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31818,@w_rol,getdate(),1,'V',getdate())

	   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31818 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31818,@w_rol,getdate(),3,'V',getdate())

		
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31819 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31819,@w_rol,getdate(),1,'V',getdate())

		 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31819 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31819,@w_rol,getdate(),3,'V',getdate())

		  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31820 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31820,@w_rol,getdate(),1,'V',getdate())

		   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31820 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31820,@w_rol,getdate(),3,'V',getdate())

			
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31822 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31822,@w_rol,getdate(),1,'V',getdate())

			 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31823 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31823,@w_rol,getdate(),1,'V',getdate())

			  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31824 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31824,@w_rol,getdate(),1,'V',getdate())

		   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31825 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,31825,@w_rol,getdate(),1,'V',getdate())

				
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31826 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)
 values(43,'R',0,31826,@w_rol,getdate(),1,'V',getdate())

				 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31827 and ta_rol = @w_rol)
 insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)
 values(43,'R',0,31827,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31831 and ta_rol = @w_rol) 
 insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)
 values (43,'R',0,31831,3,getDate(),1,'V', getDate()) 


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 31832 and ta_rol = @w_rol) 
 insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)
 values (43,'R',0,31832,3,getDate(),1,'V', getDate()) 

				  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32001 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32001,@w_rol,getdate(),1,'V',getdate())

				   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32001 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32001,@w_rol,getdate(),3,'V',getdate())

					
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32002 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32002,@w_rol,getdate(),1,'V',getdate())

					 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32002 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32002,@w_rol,getdate(),3,'V',getdate())

					  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32003 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32003,@w_rol,getdate(),1,'V',getdate())

					   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32003 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32003,@w_rol,getdate(),3,'V',getdate())

					
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32004 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32004,@w_rol,getdate(),1,'V',getdate())

						 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32004 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32004,@w_rol,getdate(),3,'V',getdate())

						  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32005 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32005,@w_rol,getdate(),1,'V',getdate())

						   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32005 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32005,@w_rol,getdate(),3,'V',getdate())

							
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32006 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32006,@w_rol,getdate(),1,'V',getdate())

							 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32006 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32006,@w_rol,getdate(),3,'V',getdate())

							  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32007 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32007,@w_rol,getdate(),1,'V',getdate())

							   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32007 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32007,@w_rol,getdate(),3,'V',getdate())

								
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32008 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32008,@w_rol,getdate(),1,'V',getdate())

								 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32008 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32008,@w_rol,getdate(),3,'V',getdate())

								  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32009 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32009,@w_rol,getdate(),1,'V',getdate())

								   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32009 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32009,@w_rol,getdate(),3,'V',getdate())

									
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32010 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32010,@w_rol,getdate(),1,'V',getdate())

									 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32010 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32010,@w_rol,getdate(),3,'V',getdate())

									  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32011 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32011,@w_rol,getdate(),1,'V',getdate())

									   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32011 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32011,@w_rol,getdate(),3,'V',getdate())

										
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32012 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32012,@w_rol,getdate(),1,'V',getdate())

										 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32012 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32012,@w_rol,getdate(),3,'V',getdate())

										  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32013 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32013,@w_rol,getdate(),1,'V',getdate())

										   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32013 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32013,@w_rol,getdate(),3,'V',getdate())

											
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32014 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32014,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32014 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32014,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32015 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32015,@w_rol,getdate(),1,'V',getdate())

											   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32015 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32015,@w_rol,getdate(),3,'V',getdate())

												
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32016 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32016,@w_rol,getdate(),1,'V',getdate())

												 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32016 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32016,@w_rol,getdate(),3,'V',getdate())

												  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32017 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32017,@w_rol,getdate(),1,'V',getdate())

												   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32017 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32017,@w_rol,getdate(),3,'V',getdate())

													
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32018 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32018,@w_rol,getdate(),1,'V',getdate())

													 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32018 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32018,@w_rol,getdate(),3,'V',getdate())

													  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32251 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32251,@w_rol,getdate(),1,'V',getdate())

													   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32251 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32251,@w_rol,getdate(),3,'V',getdate())

														
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32252 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32252,@w_rol,getdate(),1,'V',getdate())

														 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32252 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32252,@w_rol,getdate(),3,'V',getdate())

														  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32253 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32253,@w_rol,getdate(),1,'V',getdate())

														   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32253 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32253,@w_rol,getdate(),3,'V',getdate())

															
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32254 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32254,@w_rol,getdate(),1,'V',getdate())

															 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32254 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32254,@w_rol,getdate(),3,'V',getdate())

															  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32255 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32255,@w_rol,getdate(),1,'V',getdate())

															   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32255 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32255,@w_rol,getdate(),3,'V',getdate())

																
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32256 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32256,@w_rol,getdate(),1,'V',getdate())

																 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32256 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32256,@w_rol,getdate(),3,'V',getdate())

																  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32257 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32257,@w_rol,getdate(),1,'V',getdate())

																   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32257 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32257,@w_rol,getdate(),3,'V',getdate())

																	
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32258 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32258,@w_rol,getdate(),1,'V',getdate())

																	 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32258 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32258,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32259 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32259,@w_rol,getdate(),1,'V',getdate())

 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32259 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32259,@w_rol,getdate(),3,'V',getdate())

  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32280 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32280,@w_rol,getdate(),1,'V',getdate())

   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32281 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32281,@w_rol,getdate(),1,'V',getdate())

	
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32281 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32281,@w_rol,getdate(),3,'V',getdate())

	 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32282 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32282,@w_rol,getdate(),1,'V',getdate())

	  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32283 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(43,'R',0,32283,@w_rol,getdate(),1,'V',getdate())

	   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73501 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73501,@w_rol,getdate(),1,'V',getdate())

		
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73501 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73501,@w_rol,getdate(),3,'V',getdate())

		 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73503 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73503,@w_rol,getdate(),1,'V',getdate())

		  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73503 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73503,@w_rol,getdate(),3,'V',getdate())

		   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73504 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73504,@w_rol,getdate(),1,'V',getdate())

			
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73504 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73504,@w_rol,getdate(),3,'V',getdate())

			 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73505 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73505,@w_rol,getdate(),1,'V',getdate())

			  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73505 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73505,@w_rol,getdate(),3,'V',getdate())

			   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73506 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73506,@w_rol,getdate(),1,'V',getdate())

				
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73506 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73506,@w_rol,getdate(),3,'V',getdate())

				 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73507 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73507,@w_rol,getdate(),1,'V',getdate())

				  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73507 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73507,@w_rol,getdate(),3,'V',getdate())

				   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73508 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73508,@w_rol,getdate(),1,'V',getdate())

					
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73508 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73508,@w_rol,getdate(),3,'V',getdate())

					 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73509 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73509,@w_rol,getdate(),1,'V',getdate())

					  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73509 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73509,@w_rol,getdate(),3,'V',getdate())

					   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73510 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73510,@w_rol,getdate(),1,'V',getdate())

						
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73510 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73510,@w_rol,getdate(),3,'V',getdate())

						 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73511 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73511,@w_rol,getdate(),1,'V',getdate())

						  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73511 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73511,@w_rol,getdate(),3,'V',getdate())

						   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73512 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73512,@w_rol,getdate(),1,'V',getdate())

							
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73512 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73512,@w_rol,getdate(),3,'V',getdate())

							 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73513 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73513,@w_rol,getdate(),1,'V',getdate())

							  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73513 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73513,@w_rol,getdate(),3,'V',getdate())

							   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73514 and ta_rol = @w_rol)
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73514,@w_rol,getdate(),1,'V',getdate())

								
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73514 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73514,@w_rol,getdate(),3,'V',getdate())

								 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73515 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73515,@w_rol,getdate(),1,'V',getdate())

								  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73515 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73515,@w_rol,getdate(),3,'V',getdate())

								   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73516 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73516,@w_rol,getdate(),1,'V',getdate())

									
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73516 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73516,@w_rol,getdate(),3,'V',getdate())

									 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73517 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73517,@w_rol,getdate(),1,'V',getdate())

									  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73517 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73517,@w_rol,getdate(),3,'V',getdate())

									   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73522 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73522,@w_rol,getdate(),1,'V',getdate())

										
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73522 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73522,@w_rol,getdate(),3,'V',getdate())

										 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73523 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73523,@w_rol,getdate(),1,'V',getdate())

										  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73523 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73523,@w_rol,getdate(),3,'V',getdate())

										   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73524 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73524,@w_rol,getdate(),1,'V',getdate())

											
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73524 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73524,@w_rol,getdate(),3,'V',getdate())

											 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73800 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73800,@w_rol,getdate(),1,'V',getdate())

											  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73801 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73801,@w_rol,getdate(),1,'V',getdate())

											   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73802 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73802,@w_rol,getdate(),1,'V',getdate())

												
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73803 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73803,@w_rol,getdate(),1,'V',getdate())

												 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73804 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73804,@w_rol,getdate(),1,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73805 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73805,@w_rol,getdate(),1,'V',getdate())

												  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73914 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73914,@w_rol,getdate(),1,'V',getdate())

												   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73914 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73914,@w_rol,getdate(),3,'V',getdate())

													
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73915 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73915,@w_rol,getdate(),1,'V',getdate())

													 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73915 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73915,@w_rol,getdate(),3,'V',getdate())

													  
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73920 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73920,@w_rol,getdate(),1,'V',getdate())

													   
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73920 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73920,@w_rol,getdate(),3,'V',getdate())

														
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73921 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73921,@w_rol,getdate(),1,'V',getdate())

														 
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 73921 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,73921,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32284 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,32284,@w_rol,getdate(),3,'V',getdate())


if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 32285 and ta_rol = @w_rol) 
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod) 
values(73,'R',0,32285,@w_rol,getdate(),3,'V',getdate())

go
