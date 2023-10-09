/**********************************************************************/
/*   Archivo:         bpl_authorization_resources.sql  	              */
/*   Producto:        BUSINESS RULE								      */	
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
/*          Autorizacion de los servicios de business rules       	  */
/**********************************************************************/
/*                     MODIFICACIONES                       		  */
/*   FECHA               AUTOR                  RAZON         		  */
/*   05-May-2015       Gabriel Ignacio         Emision Inicial    	  */
/**********************************************************************/
use cobis
go

---------------------------------------------------------------------------------------------------------------------------------------------------------------
/*===========================================================================================================================================================*/
/* 					AUTORIZACION DE RECURSOS DE businessrules                                                                                                */
/*===========================================================================================================================================================*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------

declare @re_id int,
		@role  int

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
	select @role =  max(ro_rol)+1 from cobis..ad_rol
	insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
	values (@role, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @role = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

if not exists(select 1 from cobis..cew_resource where re_pattern = '/cobis/web/views/businessrules/.*')
begin
	set @re_id = (select isnull(max(re_id), 0) + 1 from cobis..cew_resource)

	INSERT INTO cobis..cew_resource VALUES (@re_id,'/cobis/web/views/businessrules/.*')
	INSERT INTO cobis..cew_resource_rol VALUES (@re_id,@role)
end

insert into cew_resource_rol
select distinct rro_id_resource,@role from cew_resource_rol
where rro_id_resource not in (select rro_id_resource from cew_resource_rol where rro_id_rol = @role)

go
