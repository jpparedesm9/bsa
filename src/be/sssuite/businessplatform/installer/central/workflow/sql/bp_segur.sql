/**********************************************************************/
/*   Archivo:         bp_segur.sql  	              */
/*   Producto:        BUSINESSRULES								          */	
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
/*  Autorizacion de los procedimientos almacenados de BusinessRules	  */
/**********************************************************************/
/*                     MODIFICACIONES                       		  */
/*   FECHA               AUTOR                  RAZON         		  */
/*   26-May-2015       Gabriel Villamagua       Emision Inicial    	  */
/**********************************************************************/


--------------------------------------------------------------------------------------------------------------------------------------------------
/*===============================================================================================================================================*/
/* 					SCRIPT PARA INSERTAR DATOS EN LA TABLA ad_procedure  PARA LOS PROCEDURE DE BUSINESSRULES                                    */
/*===============================================================================================================================================*/
--------------------------------------------------------------------------------------------------------------------------------------------------

use cobis
go

-- Stored Procedures de Cobis BusinessRules.

delete ad_procedure where pd_procedure = 73518
go

if not exists (select 1 from ad_procedure where pd_procedure = 73518) 
insert into ad_procedure(pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73518, 'sp_m_rule_dependence', 'cob_pac', 'V', getdate (), 'sp_m_rule_dependence.sp')
go

--------------------------------------------------------------------------------------------------------------------------------------------------
/*===============================================================================================================================================*/
/* 					SCRIPT PARA INSERTAR DATOS EN LA TABLA cl_ttransaccion  PARA LOS PROCEDURE DE BUSINESSRULES                                       */
/*===============================================================================================================================================*/
--------------------------------------------------------------------------------------------------------------------------------------------------

delete cl_ttransaccion where tn_trn_code between 73542 and 73544
go

if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73542) 
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73542, 'InsertDependence', 'ID', '')
go

if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73543) 
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73543, 'DeleteDependence', 'DD', '')
go

if not exists (select 1 from cl_ttransaccion where tn_trn_code = 73544) 
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73544, 'SearchDependence', 'SD', '')
go

   
 --------------------------------------------------------------------------------------------------------------------------------------------------
/*===============================================================================================================================================*/
/* 					SCRIPT PARA INSERTAR DATOS EN LA TABLA ad_pro_transaccion  PARA LOS PROCEDURE DE BUSINESSRULES                                       */
/*===============================================================================================================================================*/
---------------------------------------------------------------------------------------------------------------------------------------------------  

delete ad_pro_transaccion where pt_transaccion between 73542 and 73544
go

if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73542) 
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda, pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73542, 'V', getdate(), 73518)
go

if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73543) 
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73543, 'V', getdate(), 73518)
go

if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 73544) 
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73544, 'V', getdate(), 73518)
go


 --------------------------------------------------------------------------------------------------------------------------------------------------
/*===============================================================================================================================================*/
/* 					SCRIPT PARA INSERTAR DATOS EN LA TABLA ad_tr_autorizada  PARA LOS PROCEDURE DE BUSINESSRULES                                       */
/*===============================================================================================================================================*/
---------------------------------------------------------------------------------------------------------------------------------------------------
declare @w_rol int

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
	select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
	insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
	values (@w_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

delete cobis..ad_tr_autorizada where ta_rol = @w_rol and ta_transaccion between  73542 and 73544

insert into cobis..ad_tr_autorizada(ta_producto ,ta_tipo,ta_moneda ,ta_transaccion, ta_rol ,ta_fecha_aut ,ta_autorizante, ta_estado, ta_fecha_ult_mod)
select 73,   'R',   0,   tn_trn_code,    @w_rol,   getdate(),    1,    'V',     getdate() 
from cobis..cl_ttransaccion
where tn_trn_code between 73542 and 73544
