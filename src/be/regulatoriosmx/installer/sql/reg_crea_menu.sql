/************************************************************************/
/*    ARCHIVO:         reg_crea_menu.sql                                */
/*    NOMBRE LOGICO:   reg_crea_menu.sql                                */
/*    PRODUCTO:        REGULATORIOS                                     */
/************************************************************************/
/*                     IMPORTANTE                                       */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                     PROPOSITO                                        */
/*   Script de creacion de menu de regulatorios                         */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      25/08/2016      Ignacio Yupa            Emision Inicial         */  
/************************************************************************/

use cobis
go

set nocount ON

--------------------------------------------------------------------------
--CREACION Resources
---------------------------------------------------------------------------
print 'Registros para: REC.Resources' 
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'

if not exists(select 1 from an_label where la_label = 'REC.Resources') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, 'ES_EC', 'REC.Resources', 'M-REC') 
end else select @w_la_id = la_id from an_label where la_label = 'REC.Resources'

if not exists (select 1 from cobis..an_module_group where mg_name = 'REC.Resources.Installer') begin                                                                                                                                                                                                                                                                                                                                                                                                                           
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) 
values (@w_mg_id, 'REC.Resources.Installer', '0.0.0.0', 'http://[servername]/REC.Resources.Installer/REC.Resources.Installer.application', 'COBISExplorer')                                                                                                                                                                                                                                                                                                  
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'REC.Resources.Installer'
																																																																																																		 
if not exists (select 1 from cobis..an_module where mo_name = 'REC.Resources') begin                                                                                                                                                                                                                                                                                                                                                                                                                                 
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'REC.Resources', 'COBISCorp.tCOBIS.REC.Resources.dll', 0, null)                                                                                                                                                                                                                                                                                                                                                                    
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'REC.Resources' 
																																																																																																			  
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                    
go

--------------------------------------------------------------------------
--CREACION SharedLibrary
--------------------------------------------------------------------------
print 'Registros para: REC.SharedLibrary' 
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'

if not exists(select 1 from an_label where la_label = 'REC.SharedLibrary')begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, 'ES_EC', 'REC.SharedLibrary', 'M-REC') 
end else select @w_la_id = la_id from an_label where la_label = 'REC.SharedLibrary'

if not exists (select 1 from cobis..an_module_group where mg_name = 'REC.SharedLibrary.Installer') begin                                                                                                                                                                                                                                                                                                                                                                                                                           
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) 
values (@w_mg_id, 'REC.SharedLibrary.Installer', '4.0.0.0', 'http://[servername]/REC.SharedLibrary.Installer/REC.SharedLibrary.Installer.application', 'COBISExplorer')                                                                                                                                                                                                                                                                                                  
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'REC.SharedLibrary.Installer'
                                                                                                                                                                                                                                                                                                                                                                                                                         
if not exists (select 1 from cobis..an_module where mo_name = 'REC.SharedLibrary') begin                                                                                                                                                                                                                                                                                                                                                                                                                                 
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'REC.SharedLibrary', 'COBISCorp.tCOBIS.REC.SharedLibrary.dll', 0, null)                                                                                                                                                                                                                                                                                                                                                                    
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'REC.SharedLibrary' 
                                                                                                                                                                                                                                                                                                                                                                                                                              
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                    
go

--------------------------------------------------------------------------
--CREACION REC.Query 
--------------------------------------------------------------------------
print 'Registros para: REC.Query'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'

if not exists(select 1 from an_label where la_label = 'REC.Query')begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, 'ES_EC', 'REC.Query', 'M-REC') 
end else select @w_la_id = la_id from an_label where la_label = 'REC.Query'

if not exists (select 1 from cobis..an_module_group where mg_name = 'REC.Query.Installer') begin                                                                                                                                                                                                                                                                                                                                                                                                                           
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) 
values (@w_mg_id, 'REC.Query.Installer', '4.0.0.0', 'http://[servername]/REC.Query.Installer/REC.Query.Installer.application', 'COBISExplorer')                                                                                                                                                                                                                                                                                                  
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'REC.Query.Installer'
                                                                                                                                                                                                                                                                                                                                                                                                                         
if not exists (select 1 from cobis..an_module where mo_name = 'REC.Query') begin                                                                                                                                                                                                                                                                                                                                                                                                                                 
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'REC.Query', 'COBISCorp.tCOBIS.REC.Query.dll', 0, null)                                                                                                                                                                                                                                                                                                                                                                    
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'REC.Query' 
                                                                                                                                                                                                                                                                                                                                                                                                                              
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                    
go


-- -------------------------------------------
-- OPCION: Procesos BackOffice (MENU PRIN)
-- --------------------------------------------
-- Registros para: PI.Procesos Internos
if not exists (select 1 from cobis..an_page where pa_name = 'PI.Procesos Internos') begin
print 'Registros para: PI.Procesos Internos'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Procesos BackOffice', 'M-MENUPRIN')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = 0
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'PI.Procesos Internos', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-MENUPRIN', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
end
go

		-- Registros para: PI.Rec.Regulatorios
		if not exists (select 1 from cobis..an_page where pa_name = 'PI.Rec.Regulatorios' and pa_prod_name = 'M-REC') begin
		print 'Registros para: PI.Rec.Regulatorios'
		declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
		select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
		select @w_la_cod = 'ES_EC'
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Regulatorios', 'M-REC')
		select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
		select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Procesos Internos' and pa_prod_name = 'M-MENUPRIN'
		insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
		values (@w_pa_id, @w_la_id, 'PI.Rec.Regulatorios', 'icono pagina', @w_pa_id_parent, 10, 'horizontal', 'Nemonic', 'M-REC', '', null)
		insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
		end
		go
		

-- Registros para: PI.REC.FCONSTRANClass 
if not exists (select 1 from cobis..an_page where pa_name = 'PI.REC.FCONSTRANClass') begin
print 'Registros para: PI.REC.FCONSTRANClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta Transacciones Lavado de Dinero', 'M-REC')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Rec.Regulatorios'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'PI.REC.FCONSTRANClass', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-REC', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'REC.Query.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'REC.Query.Installer', '4.0.0.1', 'http://[servername]/REC.Query.Installer/REC.Query.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'REC.Query.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'REC.Query') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'REC.Query', 'COBISCorp.tCOBIS.REC.Query.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'REC.Query'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

if not exists (select * from cobis..an_component where co_name = 'REC.FCONSTRANClass' and co_namespace = 'COBISCorp.tCOBIS.REC.Query')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'REC.FCONSTRANClass', 'FCONSTRANClass', 'COBISCorp.tCOBIS.REC.Query', 'SV', '', 'M-REC')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end
else 
select @w_co_id = co_id from cobis..an_component where co_name = 'REC.FCONSTRANClass'

if not exists (select 1 from cobis..an_label where la_label = 'Consulta Transacciones Lavado de Dinero') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta Transacciones Lavado de Dinero', 'M-REC')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta Transacciones Lavado de Dinero'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go
		
		
		

-- Registros para: PI.REC.FRESGISTRANSClass 
if not exists (select 1 from cobis..an_page where pa_name = 'PI.REC.FRESGISTRANSClass') begin
print 'Registros para: PI.REC.FRESGISTRANSClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Registro de Transacciones Preocupantes', 'M-REC')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Rec.Regulatorios'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'PI.REC.FRESGISTRANSClass', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-REC', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'REC.Query.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'REC.Query.Installer', '4.0.0.1', 'http://[servername]/REC.Query.Installer/REC.Query.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'REC.Query.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'REC.Query') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'REC.Query', 'COBISCorp.tCOBIS.REC.Query.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'REC.Query'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

if not exists (select * from cobis..an_component where co_name = 'REC.FRESGISTRANSClass' and co_namespace = 'COBISCorp.tCOBIS.REC.Query')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'REC.FRESGISTRANSClass', 'FRESGISTRANSClass', 'COBISCorp.tCOBIS.REC.Query', 'SV', '', 'M-REC')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end
else 
select @w_co_id = co_id from cobis..an_component where co_name = 'REC.FRESGISTRANSClass'

if not exists (select 1 from cobis..an_label where la_label = 'Registro de Transacciones Preocupantes') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Registro de Transacciones Preocupantes', 'M-REC')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Registro de Transacciones Preocupantes'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go


-- Registros para: PI.REC.FCONSRETPROClass
if not exists (select 1 from cobis..an_page where pa_name = 'PI.REC.FCONSRETPROClass') begin
print 'Registros para: PI.REC.FCONSRETPROClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Retenciones por Producto', 'M-REC')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Rec.Regulatorios'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'PI.REC.FCONSRETPROClass', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-REC', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'REC.Query.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'REC.Query.Installer', '4.0.0.1', 'http://[servername]/REC.Query.Installer/REC.Query.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'REC.Query.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'REC.Query') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'REC.Query', 'COBISCorp.tCOBIS.REC.Query.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'REC.Query'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

if not exists (select * from cobis..an_component where co_name = 'REC.FCONSRETPROClass' and co_namespace = 'COBISCorp.tCOBIS.REC.Query')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'REC.FCONSRETPROClass', 'FCONSRETPROClass', 'COBISCorp.tCOBIS.REC.Query', 'SV', '', 'M-REC')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end
else 
select @w_co_id = co_id from cobis..an_component where co_name = 'REC.FCONSRETPROClass'

if not exists (select 1 from cobis..an_label where la_label = 'Consulta de Retenciones por Producto') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Retenciones por Producto', 'M-REC')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta de Retenciones por Producto'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go
