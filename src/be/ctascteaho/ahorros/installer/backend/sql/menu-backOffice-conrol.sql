use cobis
go

set nocount on

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

		-- Registros para: PI.Ctas.Ahorros
		if not exists (select 1 from cobis..an_page where pa_name = 'PI.Ctas.Ahorros' and pa_prod_name = 'M-CTA') begin
		print 'Registros para: PI.Ctas.Ahorros'
		declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
		select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
		select @w_la_cod = 'ES_EC'
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cuentas de Ahorro', 'M-CTA')
		select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
		select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Procesos Internos' and pa_prod_name = 'M-MENUPRIN'
		insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
		values (@w_pa_id, @w_la_id, 'PI.Ctas.Ahorros', 'icono pagina', @w_pa_id_parent, 10, 'horizontal', 'Nemonic', 'M-CTA', '', null)
		insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
		end
		go
		
				-- Registros para: Cta.PI.Aho.Cuentas
				if not exists (select 1 from cobis..an_page where pa_name = 'PI.Aho.Cuentas' and pa_prod_name = 'M-CTA') begin
				print 'Registros para: PI.Aho.Cuentas'
				declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
				select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
				select @w_la_cod = 'ES_EC'
				select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
				insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cuentas', 'M-CTA')
				select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
				select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Ctas.Ahorros' and pa_prod_name = 'M-CTA'
				insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
				values (@w_pa_id, @w_la_id, 'PI.Aho.Cuentas', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
				insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
				end
				go			
						
-- Registros para: PI.CTA.FTran202
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran202') begin
print 'Registros para: PI.CTA.FTran202'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Actualización de Cuentas', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Cuentas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'PI.CTA.FTran202', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Actualizacion_de_Cuentas_de_Ahorro', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

if not exists (select * from cobis..an_component where co_name = 'CTA.FTran202' and co_namespace = 'COBISCorp.tCOBIS.CTA.Ahos.CustService')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran202', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end
else 
select @w_co_id = co_id from cobis..an_component where co_name = 'CTA.FTran202'

if not exists (select 1 from cobis..an_label where la_label = 'Actualización de Cuentas') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Actualización de Cuentas', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Actualización de Cuentas'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PI.CTA.FTran437
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran437') begin
print 'Registros para: PI.CTA.FTran437'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Activación de Cuentas con Autorización', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Cuentas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'PI.CTA.FTran437', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Activacion_de_Cuentas_con_Autorizacion', null)
--values (@w_pa_id, @w_la_id, 'PI.CTA.FTran437', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

if not exists (select * from cobis..an_component where co_name = 'CTA.FTran437')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
    --values (@w_co_id, @w_mo_id, 'CTA.FTran437', 'FTran437Class', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses', 'SV', '', 'M-CTA')
    values (@w_co_id, @w_mo_id, 'CTA.FTran437', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end
else 
    select @w_co_id = co_id from cobis..an_component where co_name = 'CTA.FTran437'

if not exists (select 1 from cobis..an_label where la_label = 'Activación de Cuentas con Autorización') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Activación de Cuentas con Autorización', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Activación de Cuentas con Autorización'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go


				-- Registros para: Cta.PI.Aho.Cuentas
				if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.CobroValoresSus' and pa_prod_name = 'M-CTA') begin
				print 'Registros para: PI.CTA.CobroValoresSus'
				declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
				select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
				select @w_la_cod = 'ES_EC'
				select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
				insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cobro de Valores en Suspenso', 'M-CTA')
				select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
				select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Ctas.Ahorros' and pa_prod_name = 'M-CTA'
				insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
				values (@w_pa_id, @w_la_id, 'PI.CTA.CobroValoresSus', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
				insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
				end
				go
				
-- Registros para: PI.CTA.Ftran303
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.Ftran303') begin
print 'Registros para: PI.CTA.Ftran303'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cobro de Valores en Suspenso', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.CTA.CobroValoresSus'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
--values (@w_pa_id, @w_la_id, 'PI.CTA.Ftran303', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
values (@w_pa_id, @w_la_id, 'PI.CTA.Ftran303', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Cobro_de_Valores_en_Suspenso', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

if not exists (select * from cobis..an_component where co_name = 'CTA.Ftran303')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
    --values (@w_co_id, @w_mo_id, 'CTA.Ftran303', 'Ftran303Class', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses', 'SV', '', 'M-CTA')
    values (@w_co_id, @w_mo_id, 'CTA.Ftran303','FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end
else 
    select @w_co_id = co_id from cobis..an_component where co_name = 'CTA.Ftran303'

if not exists (select 1 from cobis..an_label where la_label = 'Cobro de Valores en Suspenso') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cobro de Valores en Suspenso', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Cobro de Valores en Suspenso'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go


				-- Registros para: PI.Aho.Consultas
				if not exists (select 1 from cobis..an_page where pa_name = 'PI.Aho.Consultas' and pa_prod_name = 'M-CTA') begin
				print 'Registros para: PI.Aho.Cuentas'
				declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
				select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
				select @w_la_cod = 'ES_EC'
				select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
				insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consultas', 'M-CTA')
				select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
				select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Ctas.Ahorros' and pa_prod_name = 'M-CTA'
				insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
				values (@w_pa_id, @w_la_id, 'PI.Aho.Consultas', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
				insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
				end
				go

                
-- Registros para: PI.CTA.FTran216
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran216') begin
print 'Registros para: PI.CTA.FTran216'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Bloqueos de Valores a la Cuenta', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'PI.CTA.FTran216', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Consulta_BloqueoValores_En_Las_Cuentas', null)
-- values (@w_pa_id, @w_la_id, 'PI.CTA.FTran216', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
if not exists (select * from cobis..an_component where co_name = 'CTA.FTran216')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
    values (@w_co_id, @w_mo_id, 'CTA.FTran216', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
    -- values (@w_co_id, @w_mo_id, 'CTA.FTran216', 'FTran216Class', 'COBISCorp.tCOBIS.CTA.Ahos.Query', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end
else 
    select @w_co_id = co_id from cobis..an_component where co_name = 'CTA.FTran216'


if not exists (select 1 from cobis..an_label where la_label = 'De Bloqueos de Valores a la Cuenta') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Bloqueos de Valores a la Cuenta', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'De Bloqueos de Valores a la Cuenta'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PI.CTA.FTran245
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran245') begin
print 'Registros para: PI.CTA.FTran245'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Bloqueo de Movimientos', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'PI.CTA.FTran245', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Consulta_de_Bloqueo_de_Movimientos', null)
-- values (@w_pa_id, @w_la_id, 'PI.CTA.FTran245', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
if not exists (select * from cobis..an_component where co_name = 'CTA.FTran245')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
    values (@w_co_id, @w_mo_id, 'CTA.FTran245', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
    -- values (@w_co_id, @w_mo_id, 'CTA.FTran245', 'FTran245Class', 'COBISCorp.tCOBIS.CTA.Ahos.Query', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end
else 
select @w_co_id = co_id from cobis..an_component where co_name = 'CTA.FTran245'
if not exists (select 1 from cobis..an_label where la_label = 'De Bloqueo de Movimientos') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Bloqueo de Movimientos', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'De Bloqueo de Movimientos'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go


-- Registros para: PI.CTA.FTran357
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTRAN357') begin
print 'Registros para: PI.CTA.FTRAN357'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Solicitudes de Apertura', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FTRAN357', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
--COBISCorp.tCOBIS.CTA.Ahos.CustService
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
if not exists (select * from cobis..an_component where co_name = 'CTA.FTRAN357' and co_namespace = 'COBISCorp.tCOBIS.CTA.Ahos.CustService')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTRAN357', 'FTran357Class', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end
else 
    select @w_co_id = co_id from cobis..an_component where co_name = 'CTA.FTRAN357'

if not exists (select 1 from cobis..an_label where la_label = 'Consulta de Solicitudes de Apertura Cuenta de Ahorros') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Solicitudes de Apertura Cuenta de Ahorros', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta de Solicitudes de Apertura Cuenta de Ahorros'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go


-- Registros para: PI.CTA.Ftran220
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.Ftran220') begin
print 'Registros para: PI.CTA.Ftran220'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta De Saldos Y Promedios', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'PI.CTA.Ftran220', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Consulta_de_Saldos_y_Promedios', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBalances.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.QueryBalances.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.QueryBalances.Installer/CTA.Ahos.QueryBalances.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBalances.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.QueryBalances') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.QueryBalances', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBalances.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.QueryBalances'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) 
insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

if not exists (select * from cobis..an_component where co_name = 'CTA.Ftran220')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.Ftran220', 'Ftran220Class', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBalances', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end
else
begin 
    select @w_co_id = co_id from cobis..an_component where co_name = 'CTA.Ftran220'
end
    
if not exists (select 1 from cobis..an_label where la_label = 'Consulta De Saldos Y Promedios') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta De Saldos Y Promedios', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta De Saldos Y Promedios'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PI.CTA.FTran235
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran235') begin
print 'Registros para: PI.CTA.FTran235'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta General', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'PI.CTA.FTran235', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Consulta_General', null)
-- values (@w_pa_id, @w_la_id, 'PI.CTA.FTran235', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

if not exists (select * from cobis..an_component where co_name = 'CTA.FTran235')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
    values (@w_co_id, @w_mo_id, 'CTA.FTran235', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
    -- values (@w_co_id, @w_mo_id, 'CTA.FTran235', 'FTran235Class', 'COBISCorp.tCOBIS.CTA.Ahos.Query', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end
else
    select @w_co_id = co_id from cobis..an_component where co_name = 'CTA.FTran235'
    
if not exists (select 1 from cobis..an_label where la_label = 'Consulta General') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta General', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta General'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go



-- Registros para: PI.CTA.FTran232
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran232') begin
print 'Registros para: PI.CTA.FTran232'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Movimientos', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FTran232', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Consulta_de_Movimientos', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryMovements.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.QueryMovements.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.QueryMovements.Installer/CTA.Ahos.QueryMovements.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryMovements.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.QueryMovements') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.QueryMovements', 'COBISCorp.tCOBIS.CTA.Ahos.QueryMovements.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.QueryMovements'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

if not exists (select * from cobis..an_component where co_name = 'CTA.FTran232')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran232', 'FTran232Class', 'COBISCorp.tCOBIS.CTA.Ahos.QueryMovements', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end
else
    select @w_co_id = co_id from cobis..an_component where co_name = 'CTA.FTran232'

if not exists (select 1 from cobis..an_label where la_label = 'De Movimientos') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Movimientos', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'De Movimientos'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go


-- Registros para: PI.CTA.FTran247
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran247') begin
print 'Registros para: PI.CTA.FTran247'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Valores en Suspenso', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'PI.CTA.FTran247', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Consulta_de_Valores_en_Suspenso', null)
-- values (@w_pa_id, @w_la_id, 'PI.CTA.FTran247', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

if not exists (select * from cobis..an_component where co_name = 'CTA.FTran247')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
    values (@w_co_id, @w_mo_id, 'CTA.FTran247', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
    -- values (@w_co_id, @w_mo_id, 'CTA.FTran247', 'FTran247Class', 'COBISCorp.tCOBIS.CTA.Ahos.Query', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end
    select @w_co_id = co_id from cobis..an_component where co_name = 'CTA.FTran247'

if not exists (select 1 from cobis..an_label where la_label = 'De Valores en Suspenso') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Valores en Suspenso', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'De Valores en Suspenso'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go


-- Registros para: PI.CTA.FTran343
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran343') begin
print 'Registros para: PI.CTA.FTran343'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Detalle de cálculo de intereses', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'PI.CTA.FTran343', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Consulta_de_Detalle_de_Calculo_de_Intereses', null)
-- values (@w_pa_id, @w_la_id, 'PI.CTA.FTran343', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

if not exists (select * from cobis..an_component where co_name = 'CTA.FTran343')
begin
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
    values (@w_co_id, @w_mo_id, 'CTA.FTran343', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
    --values (@w_co_id, @w_mo_id, 'CTA.FTran343', 'FTran343Class', 'COBISCorp.tCOBIS.CTA.Ahos.Query', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end 
else
    select @w_co_id = co_id from cobis..an_component where co_name = 'CTA.FTran343'
    
if not exists (select 1 from cobis..an_label where la_label = 'Detalle de cálculo de intereses') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Detalle de cálculo de intereses', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Detalle de cálculo de intereses'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go


-- Registros para: PI.CTA.FTran234
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran234') begin
print 'Registros para: PI.CTA.FTran234'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Extracto de Cuenta de Ahorros', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'PI.CTA.FTran234', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Consulta_de_Extracto_de_Cuenta_de_Ahorros', null)
-- values (@w_pa_id, @w_la_id, 'PI.CTA.FTran234', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

if not exists (select * from cobis..an_component where co_name = 'CTA.FTran234')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
    values (@w_co_id, @w_mo_id, 'CTA.FTran234', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
    -- values (@w_co_id, @w_mo_id, 'CTA.FTran234', 'FTran234Class', 'COBISCorp.tCOBIS.CTA.Ahos.QueryMovements', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end 
else
    select @w_co_id = co_id from cobis..an_component where co_name = 'CTA.FTran234'

if not exists (select 1 from cobis..an_label where la_label = 'Extracto de Cuenta de Ahorros') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Extracto de Cuenta de Ahorros', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Extracto de Cuenta de Ahorros'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PI.CTA.FTran223
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran223') begin
print 'Registros para: PI.CTA.FTran223'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Extracto de Cuenta de Ahorros sin Costo', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'PI.CTA.FTran223', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Extracto_de_Cuenta_de_Ahorros_sin_Costo', null)
-- values (@w_pa_id, @w_la_id, 'PI.CTA.FTran223', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
if not exists (select * from cobis..an_component where co_name = 'CTA.FTran223')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
    values (@w_co_id, @w_mo_id, 'CTA.FTran223', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
    -- values (@w_co_id, @w_mo_id, 'CTA.FTran223', 'FTran223Class', 'COBISCorp.tCOBIS.CTA.Ahos.QueryMovements', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end
else
    select @w_co_id  = co_id from cobis..an_component where co_name = 'CTA.FTran223'

if not exists (select 1 from cobis..an_label where la_label = 'Extracto de Cuenta de Ahorros sin Costo') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Extracto de Cuenta de Ahorros sin Costo', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Extracto de Cuenta de Ahorros sin Costo'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go


-- Registros para: PI.CTA.Ftran302
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.Ftran302') begin
print 'Registros para: PI.CTA.Ftran302'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Operaciones Superiores a un Monto en Cuentas de Ahorros', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.Ftran302', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBackOffice.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.QueryBackOffice.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.QueryBackOffice.Installer/CTA.Ahos.QueryBackOffice.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBackOffice.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.QueryBackOffice') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.QueryBackOffice', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.QueryBackOffice'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

if not exists (select 1 from cobis..an_component where co_name = 'CTA.Ftran302')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
    values (@w_co_id, @w_mo_id, 'CTA.Ftran302', 'Ftran302Class', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end
else
    select @w_co_id = co_id from cobis..an_component where co_name = 'CTA.Ftran302'

if not exists (select 1 from cobis..an_label where la_label = 'Operaciones Superiores a un Monto en Cuentas de Ahorros') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Operaciones Superiores a un Monto en Cuentas de Ahorros', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Operaciones Superiores a un Monto en Cuentas de Ahorros'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Validacion Param OCUCOL - INI
if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
    -- Registros para: PI.CTA.FTran096
    if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran096') begin
    print 'Registros para: PI.CTA.FTran096'
    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Canje en Cuenta', 'M-CTA')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Consultas'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
    values (@w_pa_id, @w_la_id, 'PI.CTA.FTran096', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Consulta_de_Canje_por_Cuenta', null)
    -- values (@w_pa_id, @w_la_id, 'PI.CTA.FTran096', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
    select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
    insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
    end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
    if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
    select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
    insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
    end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    if not exists (select * from cobis..an_component where co_name = 'CTA.FTran096')
    begin
        select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
        insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
        values (@w_co_id, @w_mo_id, 'CTA.FTran096', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
        -- values (@w_co_id, @w_mo_id, 'CTA.FTran096', 'FTran096Class', 'COBISCorp.tCOBIS.CTA.Ahos.Query', 'SV', '', 'M-CTA')
        insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
    end
    else
        select @w_co_id  = co_id from cobis..an_component where co_name = 'CTA.FTran096'

    if not exists (select 1 from cobis..an_label where la_label = 'Consulta de Canje en Cuenta') begin
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Canje en Cuenta', 'M-CTA')
    end
    else select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta de Canje en Cuenta'
    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
    insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
    end
    go
-- Validacion Param OCUCOL - FIN

-- Registros para: PI.CTA.Ftran434
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.Ftran434') begin
print 'Registros para: PI.CTA.Ftran434'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cuentas con Características Especiales', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
--values (@w_pa_id, @w_la_id, 'PI.CTA.Ftran434', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
values (@w_pa_id, @w_la_id, 'PI.CTA.Ftran434', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic','M-CTA','OP=Cuentas_con_Caracteristicas_Especiales', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
--if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.QueryBackOffice.Installer') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token)
--values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.QueryBackOffice.Installer', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice.dll', 0, null)
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
--end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.QueryBackOffice.Installer'
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
if not exists (select * from cobis..an_component where co_name = 'CTA.Ftran434')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
    --values (@w_co_id, @w_mo_id, 'CTA.Ftran434', 'Ftran434Class', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice', 'SV', '', 'M-CTA')
    values (@w_co_id, @w_mo_id, 'CTA.Ftran434', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end
else
    select @w_co_id  = co_id from cobis..an_component where co_name = 'CTA.Ftran434'

if not exists (select 1 from cobis..an_label where la_label = 'Cuentas con Características Especiales') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cuentas con Características Especiales', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Cuentas con Características Especiales'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PI.CTA.FTran436
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran436') begin
print 'Registros para: PI.CTA.FTran436'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Seguimiento Plan de Ahorro Progresivo', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FTran436', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBackOffice.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.QueryBackOffice.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.QueryBackOffice.Installer/CTA.Ahos.QueryBackOffice.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBackOffice.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.QueryBackOffice') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.QueryBackOffice', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.QueryBackOffice'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

if not exists (select * from cobis..an_component where co_name = 'CTA.FTran436')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
    values (@w_co_id, @w_mo_id, 'CTA.FTran436', 'FTran436Class', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end 
else 
    select @w_co_id = co_id from   cobis..an_component where co_name = 'CTA.FTran436'
    
if not exists (select 1 from cobis..an_label where la_label = 'Seguimiento Plan de Ahorro Progresivo') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Seguimiento Plan de Ahorro Progresivo', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Seguimiento Plan de Ahorro Progresivo'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PI.CTA.FTranCME1
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTranCME1') begin
print 'Registros para: PI.CTA.FTranCME1'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cuentas Menor de Edad', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FTranCME1', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Cuentas_Menor_de_Edad', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBackOffice.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.QueryBackOffice.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.QueryBackOffice.Installer/CTA.Ahos.QueryBackOffice.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBackOffice.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.QueryBackOffice') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.QueryBackOffice', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.QueryBackOffice'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

if not exists (select * from cobis..an_component where co_name = 'CTA.FTranCME1')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
    values (@w_co_id, @w_mo_id, 'CTA.FTranCME1', 'FTranCMEClass', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end 
else 
    select @w_co_id = co_id from   cobis..an_component where co_name = 'CTA.FTranCME1'
    
if not exists (select 1 from cobis..an_label where la_label = 'Cuentas Menor de Edad') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cuentas Menor de Edad', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Cuentas Menor de Edad'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PI.CTA.FTranCME2
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTranCME2') begin
print 'Registros para: PI.CTA.FTranCME2'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cuentas Próximo Mayor de Edad', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Consultas'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FTranCME2', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Cuentas_Proximo_Mayor_de_Edad', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBackOffice.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.QueryBackOffice.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.QueryBackOffice.Installer/CTA.Ahos.QueryBackOffice.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBackOffice.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.QueryBackOffice') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.QueryBackOffice', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.QueryBackOffice'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

if not exists (select * from cobis..an_component where co_name = 'CTA.FTranCME2')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
    values (@w_co_id, @w_mo_id, 'CTA.FTranCME2', 'FTranCMEClass', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice', 'SV', 'OP=Cuentas_Proximo_Mayor_de_Edad', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end 
else 
    select @w_co_id = co_id from   cobis..an_component where co_name = 'CTA.FTranCME2'
    
if not exists (select 1 from cobis..an_label where la_label = 'Cuentas Próximo Mayor de Edad') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cuentas Próximo Mayor de Edad', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Cuentas Próximo Mayor de Edad'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

                        -- Registros para: PI.Históricos
						if not exists (select 1 from cobis..an_page where pa_name = 'PI.Aho.Historicos' and pa_prod_name = 'M-CTA') begin
						print 'Registros para: PI.Históricos'
						declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
						select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
						select @w_la_cod = 'ES_EC'
						select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
						insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Históricos', 'M-CTA')
						select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
						select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Consultas' and pa_prod_name = 'M-CTA'
						insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
						values (@w_pa_id, @w_la_id, 'PI.Aho.Historicos', 'icono pagina', @w_pa_id_parent, 2, 'horizontal', 'Nemonic', 'M-CTA', '', null)
						insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
						end
						go

-- Registros para: PI.CTA.FHistoricoAM
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FHistoricoAM') begin
print 'Registros para: PI.CTA.FHistoricoAM'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta Histórica de Transacciones Monetarias', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Historicos'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FHistoricoAM', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryMovements.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.QueryMovements.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.QueryMovements.Installer/CTA.Ahos.QueryMovements.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryMovements.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.QueryMovements') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.QueryMovements', 'COBISCorp.tCOBIS.CTA.Ahos.QueryMovements.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.QueryMovements'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

if not exists (select * from cobis..an_component where co_name = 'CTA.FHistoricoAM')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FHistoricoAM', 'FHistoricoAMClass', 'COBISCorp.tCOBIS.CTA.Ahos.QueryMovements', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end 
else
    select @w_co_id  = co_id from   cobis..an_component where co_name = 'CTA.FHistoricoAM'

if not exists (select 1 from cobis..an_label where la_label = 'Consulta Histórica de Transacciones Monetarias') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta Histórica de Transacciones Monetarias', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta Histórica de Transacciones Monetarias'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PI.CTA.FHistoricoAS
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FHistoricoAS') begin
print 'Registros para: PI.CTA.FHistoricoAS'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta Histórica de Transacciones de Servicio', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Historicos'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FHistoricoAS', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryMovements.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.QueryMovements.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.QueryMovements.Installer/CTA.Ahos.QueryMovements.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryMovements.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.QueryMovements') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.QueryMovements', 'COBISCorp.tCOBIS.CTA.Ahos.QueryMovements.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.QueryMovements'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
if not exists (select * from cobis..an_component where co_name = 'CTA.FHistoricoAS')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FHistoricoAS', 'FHistoricoASClass', 'COBISCorp.tCOBIS.CTA.Ahos.QueryMovements', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end 
else 
    select @w_co_id  = co_id from cobis..an_component where co_name = 'CTA.FHistoricoAS'
    
if not exists (select 1 from cobis..an_label where la_label = 'Consulta Histórica de Transacciones de Servicio') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta Histórica de Transacciones de Servicio', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta Histórica de Transacciones de Servicio'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

                -- Validacion Param OCUCOL - INI
                if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
                    -- Registros para: PI.CTA.LiberacionAnticipadaCanje
                    if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.LiberacionAnticipadaCanje' and pa_prod_name = 'M-CTA') begin
                    print 'Registros para: PI.CTA.LiberacionAnticipadaCanje'
                    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
                    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
                    select @w_la_cod = 'ES_EC'
                    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Liberación Anticipada de Canje', 'M-CTA')
                    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
                    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Ctas.Ahorros' and pa_prod_name = 'M-CTA'
                    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
                    values (@w_pa_id, @w_la_id, 'PI.CTA.LiberacionAnticipadaCanje', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
                    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
                    end
                    go
                -- Validacion Param OCUCOL - FIN

if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
    -- Registros para: PI.CTA.FTran098
    if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran098') begin
    print 'Registros para: PI.CTA.FTran098'
    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Liberación Anticipada de Canje', 'M-CTA')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.CTA.LiberacionAnticipadaCanje'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
    --values (@w_pa_id, @w_la_id, 'PI.CTA.FTran098', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
    values (@w_pa_id, @w_la_id, 'PI.CTA.FTran098', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic','M-CTA', 'OP=Liberacion_Anticipada_de_Canje', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
    select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
    insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) 
    --values (@w_mg_id, 'CTA.Ahos.BackOfficeProcesses.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.BackOfficeProcesses.Installer/CTA.Ahos.BackOfficeProcesses.Installer.application', 'COBISExplorer')
    values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
    end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
    --if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses.Installer') begin
    if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
    select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
    insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
    --values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.BackOfficeProcesses.Installer', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses.dll', 0, null)
    values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
    --end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses.Installer'
    end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    if not exists (select * from cobis..an_component where co_name = 'CTA.FTran098')
    begin
        select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
        insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
        --values (@w_co_id, @w_mo_id, 'CTA.FTran098', 'FTran098Class', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses', 'SV', '', 'M-CTA')
        values (@w_co_id, @w_mo_id, 'CTA.FTran098', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
        insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
    end
    else
        select @w_co_id  = co_id from   cobis..an_component where co_name = 'CTA.FTran098'
        
    if not exists (select 1 from cobis..an_label where la_label = 'Liberación Anticipada de Canje') begin
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Liberación Anticipada de Canje', 'M-CTA')
    end
    else select @w_la_id = la_id from cobis..an_label where la_label = 'Liberación Anticipada de Canje'
    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
    insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
    end
-- Validacion Param OCUCOL - FIN
go

				-- Registros para: PI.CTA.Excepciones
				if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.Excepciones' and pa_prod_name = 'M-CTA') begin
				print 'Registros para: PI.CTA.Excepciones'
				declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
				select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
				select @w_la_cod = 'ES_EC'
				select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
				insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Excepciones', 'M-CTA')
				select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
				select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Ctas.Ahorros' and pa_prod_name = 'M-CTA'
				insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
				values (@w_pa_id, @w_la_id, 'PI.CTA.Excepciones', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
				insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
				end
				go
				
-- Registros para: PI.CTA.FAUTRETOF
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FAUTRETOF') begin
print 'Registros para: PI.CTA.FAUTRETOF'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Autorización Retiros en Oficina', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.CTA.Excepciones'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FAUTRETOF', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.BackOfficeProcesses.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.BackOfficeProcesses.Installer/CTA.Ahos.BackOfficeProcesses.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.BackOfficeProcesses', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

if not exists (select * from cobis..an_component where co_name = 'CTA.FAUTRETOF')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FAUTRETOF', 'FAUTRETOFClass', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end
else
    select @w_co_id  = co_id from   cobis..an_component where co_name = 'CTA.FAUTRETOF'

if not exists (select 1 from cobis..an_label where la_label = 'Autorización Retiros en Oficina') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Autorización Retiros en Oficina', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Autorización Retiros en Oficina'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

				-- Registros para: Cta.PI.Aho.Cheques
				if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.Cheques' and pa_prod_name = 'M-CTA') begin
				print 'Registros para: PI.CTA.Cheques'
				declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
				select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
				select @w_la_cod = 'ES_EC'
				select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
				insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cheques', 'M-CTA')
				select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
				select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Ctas.Ahorros' and pa_prod_name = 'M-CTA'
				insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
				values (@w_pa_id, @w_la_id, 'PI.CTA.Cheques', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
				insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
				end
				go


-- Registros para: PI.CTA.FCheqAprobRechaz
if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FCheqAprobRechaz') begin
print 'Registros para: PI.CTA.FCheqAprobRechaz'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cheques Devueltos', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.CTA.Cheques'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FCheqAprobRechaz', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ctes.Chamber') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ctes.Chamber', '4.0.0.1', 'http://[servername]/CTA.Ctes.Chamber.Installer/CTA.Ctes.Chamber.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ctes.Chamber'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ctes.Chamber') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ctes.Chamber', 'COBISCorp.tCOBIS.CTA.Ctes.Chamber.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ctes.Chamber'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

if not exists (select * from cobis..an_component where co_name = 'CTA.FCheqAprobRechaz')
begin
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FCheqAprobRechaz', 'FCheqAprobRechazClass', 'COBISCorp.tCOBIS.CTA.Ctes.Chamber', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end
else
    select @w_co_id  = co_id from   cobis..an_component where co_name = 'CTA.FCheqAprobRechaz'

if not exists (select 1 from cobis..an_label where la_label = 'Cheques Devueltos') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cheques Devueltos', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Cheques Devueltos'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go



            -- Registros para: PI.Ctas.Ahorros
            if not exists (select 1 from cobis..an_page where pa_name = 'PI.Aho.Procesos' and pa_prod_name = 'M-CTA') begin
            print 'Registros para: PI.Aho.Procesos'
            declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
            select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
            select @w_la_cod = 'ES_EC'
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Procesos', 'M-CTA')
            select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
            select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Procesos Internos' and pa_prod_name = 'M-MENUPRIN'
            insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
            values (@w_pa_id, @w_la_id, 'PI.Aho.Procesos', 'icono pagina', @w_pa_id_parent, 10, 'horizontal', 'Nemonic', 'M-CTA', '', null)
            insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
            end
            go

        -- Validacion Param OCUCOL - INI
        if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
            -- Registros para: PI.Aho.Remesas
            if not exists (select 1 from cobis..an_page where pa_name = 'PI.Aho.Remesas' and pa_prod_name = 'M-CTA') begin
            print 'Registros para: PI.Aho.Remesas'
            declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
            select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
            select @w_la_cod = 'ES_EC'
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Remesas', 'M-CTA')
            select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
            select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Procesos' and pa_prod_name = 'M-CTA'
            insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
            values (@w_pa_id, @w_la_id, 'PI.Aho.Remesas', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
            insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
            end
            go
        -- Validacion Param OCUCOL - FIN
            
-- Validacion Param OCUCOL - INI
if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N' 
    -- Registros para: PI.CTA.FTran601
    if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran601') begin
    print 'Registros para: PI.CTA.FTran601'
    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod,'Acuse de Remesas', 'M-CTA')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Remesas'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FTran601', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.RemittanceProcess.Installer') begin
    select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
    insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.RemittanceProcess.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.RemittanceProcess.Installer/CTA.Ahos.RemittanceProcess.Installer.application', 'COBISExplorer')
    end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.RemittanceProcess.Installer'
    if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.RemittanceProcess') begin
    select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
    insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.RemittanceProcess', 'COBISCorp.tCOBIS.CTA.Ahos.RemittanceProcess.dll', 0, null)
    end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.RemittanceProcess'
    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    if not exists (select * from cobis..an_component where co_name = 'CTA.FTran601')
    begin
        select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
        insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran601', 'FTran601Class', 'COBISCorp.tCOBIS.CTA.Ahos.RemittanceProcess', 'SV', '', 'M-CTA')
        insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
    end
    else
        select @w_co_id  = co_id from   cobis..an_component where co_name = 'CTA.FTran601'

    if not exists (select 1 from cobis..an_label where la_label = 'Acuse de Remesas') begin
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Acuse de Remesas', 'M-CTA')
    end
    else select @w_la_id = la_id from cobis..an_label where la_label = 'Acuse de Remesas'
    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
    insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
    end
-- Validacion Param OCUCOL - FIN
go

-- Validacion Param OCUCOL - INI
if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
    -- Registros para: PI.CTA.FTran602
    if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran602') begin
    print 'Registros para: PI.CTA.FTran602'
    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Novedades de Remesas', 'M-CTA')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Remesas'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FTran602', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 2', 1, 1, 1, 1)  end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.RemittanceProcess.Installer') begin
    select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
    insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.RemittanceProcess.Installer', '4.0.0.2', 'http://[servername]/CTA.Ahos.RemittanceProcess.Installer/CTA.Ahos.RemittanceProcess.Installer.application', 'COBISExplorer')
    end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.RemittanceProcess.Installer'
    if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.RemittanceProcess') begin
    select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
    insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.RemittanceProcess', 'COBISCorp.tCOBIS.CTA.Ahos.RemittanceProcess.dll', 0, null)
    end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.RemittanceProcess'
    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    if not exists (select * from cobis..an_component where co_name = 'CTA.FTran602')
    begin
        select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
        insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran602', 'FTran602Class', 'COBISCorp.tCOBIS.CTA.Ahos.RemittanceProcess', 'SV', '', 'M-CTA')
        insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
    end
    else
        select @w_co_id  = co_id from cobis..an_component where co_name = 'CTA.FTran602'

    if not exists (select 1 from cobis..an_label where la_label = 'Novedades de Remesas') begin
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Novedades de Remesas', 'M-CTA')
    end
    else select @w_la_id = la_id from cobis..an_label where la_label = 'Novedades de Remesas'
    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
    insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
    end
-- Validacion Param OCUCOL - FIN
go


-- Validacion Param OCUCOL - INI
if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
    -- Registros para: PI.CTA.FTran407
    if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran407') begin
    print 'Registros para: PI.CTA.FTran407'
    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Confirmación de Remesas', 'M-CTA')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Remesas'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FTran407', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.RemittanceProcess.Installer') begin
    select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
    insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.RemittanceProcess.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.RemittanceProcess.Installer/CTA.Ahos.RemittanceProcess.Installer.application', 'COBISExplorer')
    end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.RemittanceProcess.Installer'
    if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.RemittanceProcess') begin
    select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
    insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.RemittanceProcess', 'COBISCorp.tCOBIS.CTA.Ahos.RemittanceProcess.dll', 0, null)
    end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.RemittanceProcess'
    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    if not exists (select * from cobis..an_component where co_name = 'CTA.FTran407')
    begin
        select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
        insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran407', 'FTran407Class', 'COBISCorp.tCOBIS.CTA.Ahos.RemittanceProcess', 'SV', '', 'M-CTA')
        insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
    end
    else
        select @w_co_id co_id from cobis..an_component where co_name = 'CTA.FTran407'

    if not exists (select 1 from cobis..an_label where la_label = 'Confirmación de Remesas') begin
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Confirmación de Remesas', 'M-CTA')
    end
    else select @w_la_id = la_id from cobis..an_label where la_label = 'Confirmación de Remesas'
    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
    insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
    end
-- Validacion Param OCUCOL - FIN
go


-- Validacion Param OCUCOL - INI
if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
    -- Registros para: PI.CTA.FTran410
    if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran410') begin
    print 'Registros para: PI.CTA.FTran410'
    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cartas por Banco Corresponsal', 'M-CTA')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Remesas'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FTran410', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.RemittanceProcess.Installer') begin
    select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
    insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.RemittanceProcess.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.RemittanceProcess.Installer/CTA.Ahos.RemittanceProcess.Installer.application', 'COBISExplorer')
    end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.RemittanceProcess.Installer'
    if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.RemittanceProcess') begin
    select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
    insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.RemittanceProcess', 'COBISCorp.tCOBIS.CTA.Ahos.RemittanceProcess.dll', 0, null)
    end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.RemittanceProcess'
    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    if not exists (select * from cobis..an_component where co_name = 'CTA.FTran410')
    begin
        select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
        insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran410', 'FTran410Class', 'COBISCorp.tCOBIS.CTA.Ahos.RemittanceProcess', 'SV', '', 'M-CTA')
        insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
    end
    else
        select @w_co_id = co_id from cobis..an_component where co_name = 'CTA.FTran410'

    if not exists (select 1 from cobis..an_label where la_label = 'Cartas por Banco Corresponsal') begin
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cartas por Banco Corresponsal', 'M-CTA')
    end
    else select @w_la_id = la_id from cobis..an_label where la_label = 'Cartas por Banco Corresponsal'
    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
    insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
    end
-- Validacion Param OCUCOL - FIN
go

-- Validacion Param OCUCOL - INI
if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
    -- Registros para: PI.CTA.FTran408
    if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran408') begin
    print 'Registros para: PI.CTA.FTran408'
    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Cheques por Cuenta', 'M-CTA')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Remesas'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FTran408', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.RemittanceProcess.Installer') begin
    select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
    insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.RemittanceProcess.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.RemittanceProcess.Installer/CTA.Ahos.RemittanceProcess.Installer.application', 'COBISExplorer')
    end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.RemittanceProcess.Installer'
    if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.RemittanceProcess') begin
    select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
    insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.RemittanceProcess', 'COBISCorp.tCOBIS.CTA.Ahos.RemittanceProcess.dll', 0, null)
    end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.RemittanceProcess'
    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    if not exists (select * from cobis..an_component where co_name = 'CTA.FTran408')
    begin
        select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
        insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran408', 'FTran408Class', 'COBISCorp.tCOBIS.CTA.Ahos.RemittanceProcess', 'SV', '', 'M-CTA')
        insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
    end else select @w_co_id  = co_id from   cobis..an_component  where co_name = 'CTA.FTran408'

    if not exists (select 1 from cobis..an_label where la_label = 'Consulta de Cheques por Cuenta') begin
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Cheques por Cuenta', 'M-CTA')
    end
    else select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta de Cheques por Cuenta'
    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
    insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
    end
-- Validacion Param OCUCOL - FIN
go

-- Validacion Param OCUCOL - INI
if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
    -- Registros para: PI.CTA.FTran429
    if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran429') begin
    print 'Registros para: PI.CTA.FTran429'
    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Cheques por Oficina', 'M-CTA')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Remesas'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FTran429', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.RemittanceProcess.Installer') begin
    select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
    insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.RemittanceProcess.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.RemittanceProcess.Installer/CTA.Ahos.RemittanceProcess.Installer.application', 'COBISExplorer')
    end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.RemittanceProcess.Installer'
    if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.RemittanceProcess') begin
    select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
    insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.RemittanceProcess', 'COBISCorp.tCOBIS.CTA.Ahos.RemittanceProcess.dll', 0, null)
    end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.RemittanceProcess'
    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    if not exists (select * from cobis..an_component where co_name = 'CTA.FTran429')
    begin
        select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
        insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran429', 'FTran429Class', 'COBISCorp.tCOBIS.CTA.Ahos.RemittanceProcess', 'SV', '', 'M-CTA')
        insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
        end else select @w_co_id  = co_id from   cobis..an_component where co_name = 'CTA.FTran429'
        
    if not exists (select 1 from cobis..an_label where la_label = 'Consulta de Cheques por Oficina') begin
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Cheques por Oficina', 'M-CTA')
    end
    else select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta de Cheques por Oficina'
    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
    insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
    end
-- Validacion Param OCUCOL - FIN
go

-- Validacion Param OCUCOL - INI
if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
    -- Registros para: PI.CTA.FTran417
    if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran417') begin
    print 'Registros para: PI.CTA.FTran417'
    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consultas de Cartas de Remesas por Oficina', 'M-CTA')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Remesas'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FTran417', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.RemittanceProcess.Installer') begin
    select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
    insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.RemittanceProcess.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.RemittanceProcess.Installer/CTA.Ahos.RemittanceProcess.Installer.application', 'COBISExplorer')
    end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.RemittanceProcess.Installer'
    if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.RemittanceProcess') begin
    select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
    insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.RemittanceProcess', 'COBISCorp.tCOBIS.CTA.Ahos.RemittanceProcess.dll', 0, null)
    end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.RemittanceProcess'
    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    if not exists (select * from cobis..an_component where co_name = 'CTA.FTran417')
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran417', 'FTran417Class', 'COBISCorp.tCOBIS.CTA.Ahos.RemittanceProcess', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
    if not exists (select 1 from cobis..an_label where la_label = 'Consultas de Cartas de Remesas por Oficina') begin
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consultas de Cartas de Remesas por Oficina', 'M-CTA')
    end
    else select @w_la_id = la_id from cobis..an_label where la_label = 'Consultas de Cartas de Remesas por Oficina'
    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
    insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
    end
-- Validacion Param OCUCOL - FIN
go

-- Validacion Param OCUCOL - INI
if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
    -- Registros para: PI.CTA.FTran604
    if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran604') begin
    print 'Registros para: PI.CTA.FTran604'
    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Relación de Cheques via Bancos', 'M-CTA')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Remesas'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FTran604', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.RemittanceProcess.Installer') begin
    select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
    insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.RemittanceProcess.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.RemittanceProcess.Installer/CTA.Ahos.RemittanceProcess.Installer.application', 'COBISExplorer')
    end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.RemittanceProcess.Installer'
    if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.RemittanceProcess') begin
    select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
    insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.RemittanceProcess', 'COBISCorp.tCOBIS.CTA.Ahos.RemittanceProcess.dll', 0, null)
    end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.RemittanceProcess'
    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    if not exists (select * from cobis..an_component where co_name = 'CTA.FTran604')
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran604', 'FTran604Class', 'COBISCorp.tCOBIS.CTA.Ahos.RemittanceProcess', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
    if not exists (select 1 from cobis..an_label where la_label = 'Relación de Cheques via Bancos') begin
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Relación de Cheques via Bancos', 'M-CTA')
    end
    else select @w_la_id = la_id from cobis..an_label where la_label = 'Relación de Cheques via Bancos'
    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
    insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
    end
-- Validacion Param OCUCOL - INI
go

-- Validacion Param OCUCOL - INI
if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
    -- Registros para: PI.CTA.FTran605
    if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran605') begin
    print 'Registros para: PI.CTA.FTran605'
    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Total Cheques via Bancos por Oficina', 'M-CTA')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Remesas'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FTran605', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.RemittanceProcess.Installer') begin
    select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
    insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.RemittanceProcess.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.RemittanceProcess.Installer/CTA.Ahos.RemittanceProcess.Installer.application', 'COBISExplorer')
    end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.RemittanceProcess.Installer'
    if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.RemittanceProcess') begin
    select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
    insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.RemittanceProcess', 'COBISCorp.tCOBIS.CTA.Ahos.RemittanceProcess.dll', 0, null)
    end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.RemittanceProcess'
    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    if not exists (select * from cobis..an_component where co_name = 'CTA.FTran605')
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran605', 'FTran605Class', 'COBISCorp.tCOBIS.CTA.Ahos.RemittanceProcess', 'SV', '', 'M-CTA')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
    if not exists (select 1 from cobis..an_label where la_label = 'CTotal Cheques via Bancos por Oficina') begin
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Total Cheques via Bancos por Oficina', 'M-CTA')
    end
    else select @w_la_id = la_id from cobis..an_label where la_label = 'Total Cheques via Bancos por Oficina'
    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
    insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
    end
-- Validacion Param OCUCOL - FIN
go

            -- Validacion Param OCUCOL - INI
            if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
                -- Registros para: PI.CTA.FHold
                if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FHold') begin
                print 'Registros para: PI.CTA.FHold'
                declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
                select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
                select @w_la_cod = 'ES_EC'
                select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Aumentar Dias de Retención para Canje', 'M-CTA')
                select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
                select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Procesos'
                insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
                values (@w_pa_id, @w_la_id, 'PI.CTA.FHold', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
                insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
                if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
                if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer') begin
                select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
                insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.BackOfficeProcesses.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.BackOfficeProcesses.Installer/CTA.Ahos.BackOfficeProcesses.Installer.application', 'COBISExplorer')
                end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer'
                if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses') begin
                select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
                insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.BackOfficeProcesses', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses.dll', 0, null)
                end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses'
                if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
                
                if not exists (select * from cobis..an_component where co_name = 'CTA.FHold')
                begin
                    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
                    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FHold', 'FHoldClass', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses', 'SV', '', 'M-CTA')
                    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
                end else select @w_co_id  = co_id from   cobis..an_component  where co_name = 'CTA.FHold'
                if not exists (select 1 from cobis..an_label where la_label = 'Aumentar Dias de Retención para Canje') begin
                select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Aumentar Dias de Retención para Canje', 'M-CTA')
                end
                else select @w_la_id = la_id from cobis..an_label where la_label = 'Aumentar Dias de Retención para Canje'
                select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
                if @w_pz_id is null select @w_pz_id = 1
                if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
                insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
                end
                end
            -- Validacion Param OCUCOL - FIN
            go

            -- Registros para: PI.CTA.FTRAN2850
            if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTRAN2850') begin
            print 'Registros para: PI.CTA.FTRAN2850'
            declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
            select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
            select @w_la_cod = 'ES_EC'
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Autorización de Notas de Crédito/ Débito', 'M-CTA')
            select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
            select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Procesos'
            insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
			values (@w_pa_id, @w_la_id, 'PI.CTA.FTRAN2850', 'icono pagina', @w_pa_id_parent, 2, 'horizontal', 'Nemonic', 'M-CTA', '', null)
            insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
            if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
            if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer') begin
            select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
            insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.BackOfficeProcesses.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.BackOfficeProcesses.Installer/CTA.Ahos.BackOfficeProcesses.Installer.application', 'COBISExplorer')
            end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer'
            if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses') begin
            select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
            insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.BackOfficeProcesses', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses.dll', 0, null)
            end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses'
            if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
            if not exists (select * from cobis..an_component where co_name = 'CTA.FTRAN2850') begin
                select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
                insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTRAN2850', 'FTRAN2850Class', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses', 'SV', '', 'M-CTA')
                insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
            end else select @w_co_id  = co_id from   cobis..an_component  where co_name = 'CTA.FTRAN2850'
            if not exists (select 1 from cobis..an_label where la_label = 'Autorización de Notas de Crédito/ Débito') begin
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Autorización de Notas de Crédito/ Débito', 'M-CTA')
            end
            else select @w_la_id = la_id from cobis..an_label where la_label = 'Autorización de Notas de Crédito/ Débito'
            select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
            if @w_pz_id is null select @w_pz_id = 1
            if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
            insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
            end
            end
            go
			
            -- Registros para: PI.CTA.FTran358
            if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran358') begin
            print 'Registros para: PI.CTA.FTran358'
            declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
            select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
            select @w_la_cod = 'ES_EC'
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Notas de Crédito/Débito', 'M-CTA')
            select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
            select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Procesos'
            insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
			values (@w_pa_id, @w_la_id, 'PI.CTA.FTran358', 'icono pagina', @w_pa_id_parent, 3, 'horizontal', 'Nemonic', 'M-CTA', '', null)
            insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
            if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
            if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer') begin
            select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
            insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.BackOfficeProcesses.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.BackOfficeProcesses.Installer/CTA.Ahos.BackOfficeProcesses.Installer.application', 'COBISExplorer')
            end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer'
            if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses') begin
            select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
            insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.BackOfficeProcesses', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses.dll', 0, null)
            end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses'
            if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
            if not exists (select * from cobis..an_component where co_name = 'CTA.FTran358') begin
                select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
                insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran358', 'FTran358Class', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses', 'SV', '', 'M-CTA')
                insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
            end else select @w_co_id  = co_id from   cobis..an_component  where co_name = 'CTA.FTran358'
            if not exists (select 1 from cobis..an_label where la_label = 'Notas de Crédito/Débito') begin
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Notas de Crédito/Débito', 'M-CTA')
            end
            else select @w_la_id = la_id from cobis..an_label where la_label = 'Notas de Crédito/Débito'
            select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
            if @w_pz_id is null select @w_pz_id = 1
            if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
            insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
            end
            end
            go			

            -- Registros para: PI.CTA.FTran2576
            if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran2576') begin
            print 'Registros para: PI.CTA.FTran2576'
            declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
            select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
            select @w_la_cod = 'ES_EC'
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Transferencias Automáticas entre Cuentas', 'M-CTA')
            select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
            select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Procesos'
            insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
			values (@w_pa_id, @w_la_id, 'PI.CTA.FTran2576', 'icono pagina', @w_pa_id_parent, 4, 'horizontal', 'Nemonic', 'M-CTA', '', null)
            insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
            if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
            if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer') begin
            select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
            insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.BackOfficeProcesses.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.BackOfficeProcesses.Installer/CTA.Ahos.BackOfficeProcesses.Installer.application', 'COBISExplorer')
            end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer'
            if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses') begin
            select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
            insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.BackOfficeProcesses', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses.dll', 0, null)
            end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses'
            if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
            select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
            if not exists (select * from cobis..an_component where co_name = 'CTA.FTran2576')
            insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran2576', 'FTran2576Class', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses', 'SV', '', 'M-CTA')
            insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
            if not exists (select 1 from cobis..an_label where la_label = 'Transferencias Automáticas entre Cuentas') begin
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Transferencias Automáticas entre Cuentas', 'M-CTA')
            end
            else select @w_la_id = la_id from cobis..an_label where la_label = 'Transferencias Automáticas entre Cuentas'
            select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
            if @w_pz_id is null select @w_pz_id = 1
            if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
            insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
            end
            end
            go


           ---- Registros para: PI.CTA.FTran2938
           --if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran2938') begin
           --print 'Registros para: PI.CTA.FTran2938'
           --declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
           --select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
           --select @w_la_cod = 'ES_EC'
           --select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
           --insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Monitoreo de Clientes con volumen de efectivo', 'M-CTA')
           --select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
           --select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Procesos'
           --insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FTran2938', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
           --insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
           --if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
           --if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer') begin
           --select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
           --insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.BackOfficeProcesses.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.BackOfficeProcesses.Installer/CTA.Ahos.BackOfficeProcesses.Installer.application', 'COBISExplorer')
           --end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer'
           --if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses') begin
           --select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
           --insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.BackOfficeProcesses', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses.dll', 0, null)
           --end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses'
           --if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
           --select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
           --if not exists (select * from cobis..an_component where co_name = 'CTA.FTran2938')
           --insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran2938', 'FTran2938Class', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses', 'SV', '', 'M-CTA')
           --insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
           --if not exists (select 1 from cobis..an_label where la_label = 'Monitoreo de Clientes con volumen de efectivo') begin
           --select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
           --insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Monitoreo de Clientes con volumen de efectivo', 'M-CTA')
           --end
           --else select @w_la_id = la_id from cobis..an_label where la_label = 'Monitoreo de Clientes con volumen de efectivo'
           --select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
           --if @w_pz_id is null select @w_pz_id = 1
           --if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
           --insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
           --end
           --end
           --go


            -- Registros para: PI.CTA.FTran080
            if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran080') begin
            print 'Registros para: PI.CTA.FTran080'
            declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
            select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
            select @w_la_cod = 'ES_EC'
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Totales por Oficina', 'M-CTA')
            select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
            select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Procesos'
            insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
			values (@w_pa_id, @w_la_id, 'PI.CTA.FTran080', 'icono pagina', @w_pa_id_parent, 5, 'horizontal', 'Nemonic', 'M-CTA', '', null)
            insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
            if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
            if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer') begin
            select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
            insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.BackOfficeProcesses.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.BackOfficeProcesses.Installer/CTA.Ahos.BackOfficeProcesses.Installer.application', 'COBISExplorer')
            end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer'
            if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses') begin
            select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
            insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.BackOfficeProcesses', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses.dll', 0, null)
            end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses'
            if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
            select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
            if not exists (select * from cobis..an_component where co_name = 'CTA.FTran080')
            insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran080', 'FTran080Class', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses', 'SV', '', 'M-CTA')
            insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
            if not exists (select 1 from cobis..an_label where la_label = 'De Totales por Oficina') begin
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Totales por Oficina', 'M-CTA')
            end
            else select @w_la_id = la_id from cobis..an_label where la_label = 'De Totales por Oficina'
            select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
            if @w_pz_id is null select @w_pz_id = 1
            if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
            insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
            end
            end
            go


            -- Registros para: PI.CTA.FTran090
            if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran090') begin
            print 'Registros para: PI.CTA.FTran090'
            declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
            select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
            select @w_la_cod = 'ES_EC'
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Totales por Operador', 'M-CTA')
            select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
            select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Procesos'
            insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
			values (@w_pa_id, @w_la_id, 'PI.CTA.FTran090', 'icono pagina', @w_pa_id_parent, 6, 'horizontal', 'Nemonic', 'M-CTA', '', null)
            insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
            if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
            if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer') begin
            select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
            insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.BackOfficeProcesses.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.BackOfficeProcesses.Installer/CTA.Ahos.BackOfficeProcesses.Installer.application', 'COBISExplorer')
            end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer'
            if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses') begin
            select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
            insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.BackOfficeProcesses', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses.dll', 0, null)
            end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses'
            if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
            select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
            if not exists (select * from cobis..an_component where co_name = 'CTA.FTran090')
            insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran090', 'FTran090Class', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses', 'SV', '', 'M-CTA')
            insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
            if not exists (select 1 from cobis..an_label where la_label = 'De Totales por Operador') begin
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Totales por Operador', 'M-CTA')
            end
            else select @w_la_id = la_id from cobis..an_label where la_label = 'De Totales por Operador'
            select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
            if @w_pz_id is null select @w_pz_id = 1
            if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
            insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
            end
            end
            go


            -- Registros para: PI.CTA.FTra2700
            if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTra2700') begin
            print 'Registros para: PI.CTA.FTra2700'
            declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
            select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
            select @w_la_cod = 'ES_EC'
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Totales Nacionales de Caja', 'M-CTA')
            select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
            select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Procesos'
            insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
			values (@w_pa_id, @w_la_id, 'PI.CTA.FTra2700', 'icono pagina', @w_pa_id_parent, 7, 'horizontal', 'Nemonic', 'M-CTA', '', null)
            insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
            if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
            if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer') begin
            select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
            insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.BackOfficeProcesses.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.BackOfficeProcesses.Installer/CTA.Ahos.BackOfficeProcesses.Installer.application', 'COBISExplorer')
            end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer'
            if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses') begin
            select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
            insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.BackOfficeProcesses', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses.dll', 0, null)
            end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses'
            if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
            select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
            if not exists (select * from cobis..an_component where co_name = 'CTA.FTra2700')
            insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTra2700', 'FTra2700Class', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses', 'SV', '', 'M-CTA')
            insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
            if not exists (select 1 from cobis..an_label where la_label = 'Consulta de Totales Nacionales') begin
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Totales Nacionales', 'M-CTA')
            end
            else select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta de Totales Nacionales'
            select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
            if @w_pz_id is null select @w_pz_id = 1
            if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
            insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
            end
            end
            go


            -- Registros para: PI.CTA.Ftran2797
            if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.Ftran2797') begin
            print 'Registros para: PI.CTA.Ftran2797'
            declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
            select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
            select @w_la_cod = 'ES_EC'
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta Transacciones en Efectivo', 'M-CTA')
            select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
            select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Procesos'
            insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
			values (@w_pa_id, @w_la_id, 'PI.CTA.Ftran2797', 'icono pagina', @w_pa_id_parent, 8, 'horizontal', 'Nemonic', 'M-CTA', '', null)
            insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
            if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
            if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer') begin
            select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
            insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.BackOfficeProcesses.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.BackOfficeProcesses.Installer/CTA.Ahos.BackOfficeProcesses.Installer.application', 'COBISExplorer')
            end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer'
            if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses') begin
            select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
            insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.BackOfficeProcesses', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses.dll', 0, null)
            end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses'
            if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
            select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
            if not exists (select * from cobis..an_component where co_name = 'CTA.Ftran2797')
            insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.Ftran2797', 'Ftran2797Class', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses', 'SV', '', 'M-CTA')
            insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
            if not exists (select 1 from cobis..an_label where la_label = 'Consulta Transacciones en Efectivo') begin
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta Transacciones en Efectivo', 'M-CTA')
            end
            else select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta Transacciones en Efectivo'
            select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
            if @w_pz_id is null select @w_pz_id = 1
            if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
            insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
            end
            end
            go


            -- Registros para: PI.CTA.FTran433
            if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran433') begin
            print 'Registros para: PI.CTA.FTran433'
            declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
            select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
            select @w_la_cod = 'ES_EC'
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Marcación Servicios', 'M-CTA')
            select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
            select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Procesos'
            insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
            values (@w_pa_id, @w_la_id, 'PI.CTA.FTran433', 'icono pagina', @w_pa_id_parent, 9, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Marcacion_Servicios', null)
            insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
            if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
            --if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer') begin
            if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
            select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
            --insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.BackOfficeProcesses.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.BackOfficeProcesses.Installer/CTA.Ahos.BackOfficeProcesses.Installer.application', 'COBISExplorer')
            insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
            --end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer'
            end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
            --if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses.Installer') begin
            if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
            select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
            --insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.BackOfficeProcesses.Installer', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses.dll', 0, null)
            insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
            --end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses.Installer'
            end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
            if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
            select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
            if not exists (select * from cobis..an_component where co_name = 'CTA.FTran433')
            insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name)
            --values (@w_co_id, @w_mo_id, 'CTA.FTran433', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses', 'SV', '', 'M-CTA')
            values (@w_co_id, @w_mo_id, 'CTA.FTran433', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
            insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
            if not exists (select 1 from cobis..an_label where la_label = 'Marcación Servicios') begin
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Marcación Servicios', 'M-CTA')
            end
            else select @w_la_id = la_id from cobis..an_label where la_label = 'Marcación Servicios'
            select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
            if @w_pz_id is null select @w_pz_id = 1
            if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
            insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
            end
            end
            go

            -- Registros para: PI.CTA.FArchTransf.frm
            if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FArchTransf.frm') begin
            print 'Registros para: PI.CTA.FArchTransf.frm'
            declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
            select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
            select @w_la_cod = 'ES_EC'
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta Archivo Transferencias Masivas', 'M-CTA')
            select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
            select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Procesos'
            insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
			values (@w_pa_id, @w_la_id, 'PI.CTA.FArchTransf.frm', 'icono pagina', @w_pa_id_parent, 10, 'horizontal', 'Nemonic', 'M-CTA', '', null)
            insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
            if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
            if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer') begin
            select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
            insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.BackOfficeProcesses.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.BackOfficeProcesses.Installer/CTA.Ahos.BackOfficeProcesses.Installer.application', 'COBISExplorer')
            end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer'
            if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses') begin
            select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
            insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.BackOfficeProcesses', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses.dll', 0, null)
            end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses'
            if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
            select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
            if not exists (select * from cobis..an_component where co_name = 'CTA.FArchTransf')
            insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FArchTransf.frm', 'FArchTransfClass', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses', 'SV', '', 'M-CTA')
            insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
            if not exists (select 1 from cobis..an_label where la_label = 'Consulta Archivo Transferencias Masivas') begin
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta Archivo Transferencias Masivas', 'M-CTA')
            end
            else select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta Archivo Transferencias Masivas'
            select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
            if @w_pz_id is null select @w_pz_id = 1
            if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
            insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
            end
            end
            go

/*
            -- Registros para: PI.CTA.FRelCtaCanal
            if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FRelCtaCanal') begin
            print 'Registros para: PI.CTA.FRelCtaCanal'
            declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
            select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
            select @w_la_cod = 'ES_EC'
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Relación Cuentas a Canales', 'M-CTA')
            select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
            select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Procesos'
            insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
            values (@w_pa_id, @w_la_id, 'PI.CTA.FRelCtaCanal', 'icono pagina', @w_pa_id_parent, 11, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Relacion_Cuentas_a_Canales', null)
            insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
            if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
            --if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer') begin
            if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
            select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
            --insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.BackOfficeProcesses.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.BackOfficeProcesses.Installer/CTA.Ahos.BackOfficeProcesses.Installer.application', 'COBISExplorer')
            insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.BackOfficeProcesses.Installer.application', 'COBISExplorer')
            --end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.BackOfficeProcesses.Installer'
            end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
            --if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses.Installer') begin
            if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
            select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
            insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
            --values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.BackOfficeProcesses.Installer', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses.dll', 0, null)
            values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
            ---end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.BackOfficeProcesses.Installer'
            end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
            if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
            select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
            if not exists (select * from cobis..an_component where co_name = 'CTA.FRelCtaCanal')
            insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
            --values (@w_co_id, @w_mo_id, 'CTA.FMotorBusq', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses', 'SV', '', 'M-CTA')
            values (@w_co_id, @w_mo_id, 'CTA.FRelCtaCanal', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
            insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
            if not exists (select 1 from cobis..an_label where la_label = 'Relación Cuentas  a Canales') begin
            select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
            insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Relación Cuentas  a Canales', 'M-CTA')
            end
            else select @w_la_id = la_id from cobis..an_label where la_label = 'Relación Cuentas  a Canales'
            select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
            if @w_pz_id is null select @w_pz_id = 1
            if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
            insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
            end
            end
            go
*/
            -- Validacion Param OCUCOL - INI
            if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
                -- Registros para: PI.Aho.Corresponsal Bancario Red Posicionada
                if not exists (select 1 from cobis..an_page where pa_name = 'PI.Aho.CorresponsalBancarioRedPos' and pa_prod_name = 'M-CTA') begin
                print 'Registros para: PI.Aho.CorresponsalBancarioRedPos'
                declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
                select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
                select @w_la_cod = 'ES_EC'
                select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Corresponsal Bancario Red Posicionada', 'M-CTA')
                select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
                select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.Procesos' and pa_prod_name = 'M-CTA'
                insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
                values (@w_pa_id, @w_la_id, 'PI.Aho.CorresponsalBancarioRedPos', 'icono pagina', @w_pa_id_parent, 10, 'horizontal', 'Nemonic', 'M-CTA', '', null)
                insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
                end
            -- Validacion Param OCUCOL - INI
            go

                -- Validacion Param OCUCOL - INI
                if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
                    -- Registros para: PI.CTA.FMantenimientoCB
                    if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FMantenimientoCB') begin
                    print 'Registros para: PI.CTA.FMantenimientoCB'
                    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
                    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
                    select @w_la_cod = 'ES_EC'
                    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento de Corresponsal', 'M-CTA')
                    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
                    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.CorresponsalBancarioRedPos'
                    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FMantenimientoCB', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
                    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
                    if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
                    if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.Correspondents.Installer') begin
                    select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
                    insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.Correspondents.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.Correspondents.Installer/CTA.Ahos.Correspondents.Installer.application', 'COBISExplorer')
                    end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.Correspondents.Installer'
                    if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.Correspondents') begin
                    select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
                    insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.Correspondents', 'COBISCorp.tCOBIS.CTA.Ahos.Correspondents.dll', 0, null)
                    end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.Correspondents'
                    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
                    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
                    if not exists (select * from cobis..an_component where co_name = 'CTA.FMantenimientoCB')
                    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FMantenimientoCB', 'FMantenimientoCBClass', 'COBISCorp.tCOBIS.CTA.Ahos.Correspondents', 'SV', '', 'M-CTA')
                    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
                    if not exists (select 1 from cobis..an_label where la_label = 'Mantenimiento de Corresponsal') begin
                    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento de Corresponsal', 'M-CTA')
                    end
                    else select @w_la_id = la_id from cobis..an_label where la_label = 'Mantenimiento de Corresponsal'
                    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
                    if @w_pz_id is null select @w_pz_id = 1
                    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
                    insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
                    end
                    end
                -- Validacion Param OCUCOL - INI
                go

                -- Validacion Param OCUCOL - INI
                if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
                    -- Registros para: PI.CTA.FMantenimientoCupoCB
                    if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FMantenimientoCupoCB') begin
                    print 'Registros para: PI.CTA.FMantenimientoCupoCB'
                    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
                    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
                    select @w_la_cod = 'ES_EC'
                    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento de Cupo Corresponsal', 'M-CTA')
                    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
                    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.CorresponsalBancarioRedPos'
                    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FMantenimientoCupoCB', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
                    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
                    if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
                    if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.Correspondents.Installer') begin
                    select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
                    insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.Correspondents.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.Correspondents.Installer/CTA.Ahos.Correspondents.Installer.application', 'COBISExplorer')
                    end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.Correspondents.Installer'
                    if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.Correspondents') begin
                    select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
                    insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.Correspondents', 'COBISCorp.tCOBIS.CTA.Ahos.Correspondents.dll', 0, null)
                    end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.Correspondents'
                    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
                    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
                    if not exists (select * from cobis..an_component where co_name = 'CTA.FMantenimientoCupoCB')
                    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FMantenimientoCupoCB', 'FMantenimientoCupoCBClass', 'COBISCorp.tCOBIS.CTA.Ahos.Correspondents', 'SV', '', 'M-CTA')
                    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
                    if not exists (select 1 from cobis..an_label where la_label = 'Mantenimiento de Cupo Corresponsal') begin
                    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento de Cupo Corresponsal', 'M-CTA')
                    end
                    else select @w_la_id = la_id from cobis..an_label where la_label = 'Mantenimiento de Cupo Corresponsal'
                    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
                    if @w_pz_id is null select @w_pz_id = 1
                    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
                    insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
                    end
                    end
                -- Validacion Param OCUCOL - INI
                go

                -- Validacion Param OCUCOL - INI
                if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
                    -- Registros para: PI.CTA.FConsultaCupoCB
                    if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FConsultaCupoCB') begin
                    print 'Registros para: PI.CTA.FConsultaCupoCB'
                    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
                    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
                    select @w_la_cod = 'ES_EC'
                    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Cupo Corresponsal', 'M-CTA')
                    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
                    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.CorresponsalBancarioRedPos'
                    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FConsultaCupoCB', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
                    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
                    if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
                    if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.Correspondents.Installer') begin
                    select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
                    insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.Correspondents.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.Correspondents.Installer/CTA.Ahos.Correspondents.Installer.application', 'COBISExplorer')
                    end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.Correspondents.Installer'
                    if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.Correspondents') begin
                    select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
                    insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.Correspondents', 'COBISCorp.tCOBIS.CTA.Ahos.Correspondents.dll', 0, null)
                    end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.Correspondents'
                    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
                    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
                    if not exists (select * from cobis..an_component where co_name = 'CTA.FConsultaCupoCB')
                    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FConsultaCupoCB', 'FConsultaCupoCBClass', 'COBISCorp.tCOBIS.CTA.Ahos.Correspondents', 'SV', '', 'M-CTA')
                    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
                    if not exists (select 1 from cobis..an_label where la_label = 'Consulta de Cupo Corresponsal') begin
                    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Cupo Corresponsal', 'M-CTA')
                    end
                    else select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta de Cupo Corresponsal'
                    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
                    if @w_pz_id is null select @w_pz_id = 1
                    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
                    insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
                    end
                    end
                -- Validacion Param OCUCOL - INI
                go

                -- Validacion Param OCUCOL - INI
                if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'                
                    -- Registros para: PI.CTA.FConsMovCB
                    if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FConsMovCB') begin
                    print 'Registros para: PI.CTA.FConsMovCB'
                    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
                    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
                    select @w_la_cod = 'ES_EC'
                    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Movimientos de C.B.', 'M-CTA')
                    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
                    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.CorresponsalBancarioRedPos'
                    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FConsMovCB', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
                    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
                    if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
                    if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.Correspondents.Installer') begin
                    select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
                    insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.Correspondents.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.Correspondents.Installer/CTA.Ahos.Correspondents.Installer.application', 'COBISExplorer')
                    end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.Correspondents.Installer'
                    if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.Correspondents') begin
                    select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
                    insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.Correspondents', 'COBISCorp.tCOBIS.CTA.Ahos.Correspondents.dll', 0, null)
                    end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.Correspondents'
                    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
                    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
                    if not exists (select * from cobis..an_component where co_name = 'CTA.FConsMovCB')
                    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FConsMovCB', 'FConsMovCBClass', 'COBISCorp.tCOBIS.CTA.Ahos.Correspondents', 'SV', '', 'M-CTA')
                    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
                    if not exists (select 1 from cobis..an_label where la_label = 'Consulta de Movimientos de C.B.') begin
                    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Movimientos de C.B.', 'M-CTA')
                    end
                    else select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta de Movimientos de C.B.'
                    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
                    if @w_pz_id is null select @w_pz_id = 1
                    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
                    insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
                    end
                    end
                -- Validacion Param OCUCOL - INI
                go

                -- Validacion Param OCUCOL - INI
                if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
                    -- Registros para: PI.CTA.FDevRecCB
                    if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FDevRecCB') begin
                    print 'Registros para: PI.CTA.FDevRecCB'
                    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
                    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
                    select @w_la_cod = 'ES_EC'
                    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Devolución Valores Recaudados C.B.', 'M-CTA')
                    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
                    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.CorresponsalBancarioRedPos'
                    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FDevRecCB', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
                    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
                    if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
                    if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.Correspondents.Installer') begin
                    select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
                    insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.Correspondents.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.Correspondents.Installer/CTA.Ahos.Correspondents.Installer.application', 'COBISExplorer')
                    end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.Correspondents.Installer'
                    if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.Correspondents') begin
                    select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
                    insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.Correspondents', 'COBISCorp.tCOBIS.CTA.Ahos.Correspondents.dll', 0, null)
                    end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.Correspondents'
                    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
                    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
                    if not exists (select * from cobis..an_component where co_name = 'CTA.FDevRecCB')
                    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FDevRecCB', 'FDevRecCBClass', 'COBISCorp.tCOBIS.CTA.Ahos.Correspondents', 'SV', '', 'M-CTA')
                    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
                    if not exists (select 1 from cobis..an_label where la_label = 'Devolución Valores Recaudados C.B.') begin
                    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Devolución Valores Recaudados C.B.', 'M-CTA')
                    end
                    else select @w_la_id = la_id from cobis..an_label where la_label = 'Devolución Valores Recaudados C.B.'
                    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
                    if @w_pz_id is null select @w_pz_id = 1
                    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
                    insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
                    end
                    end
                -- Validacion Param OCUCOL - INI
                go

                -- Validacion Param OCUCOL - INI
                if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
                    -- Registros para: PI.CTA.FGesCtaCB
                    if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FGesCtaCB') begin
                    print 'Registros para: PI.CTA.FGesCtaCB'
                    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
                    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
                    select @w_la_cod = 'ES_EC'
                    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Gestión Cuentas de corresponsalía', 'M-CTA')
                    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
                    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.CorresponsalBancarioRedPos'
                    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FGesCtaCB', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
                    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
                    if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
                    if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.Correspondents.Installer') begin
                    select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
                    insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.Correspondents.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.Correspondents.Installer/CTA.Ahos.Correspondents.Installer.application', 'COBISExplorer')
                    end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.Correspondents.Installer'
                    if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.Correspondents') begin
                    select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
                    insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.Correspondents', 'COBISCorp.tCOBIS.CTA.Ahos.Correspondents.dll', 0, null)
                    end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.Correspondents'
                    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
                    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
                    if not exists (select * from cobis..an_component where co_name = 'CTA.FGesCtaCB')
                    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FGesCtaCB', 'FGesCtaCBClass', 'COBISCorp.tCOBIS.CTA.Ahos.Correspondents', 'SV', '', 'M-CTA')
                    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
                    if not exists (select 1 from cobis..an_label where la_label = 'GGestión Cuentas de corresponsalía') begin
                    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Gestión Cuentas de corresponsalía', 'M-CTA')
                    end
                    else select @w_la_id = la_id from cobis..an_label where la_label = 'Gestión Cuentas de corresponsalía'
                    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
                    if @w_pz_id is null select @w_pz_id = 1
                    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
                    insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
                    end
                    end
                -- Validacion Param OCUCOL - INI
                go

                -- Validacion Param OCUCOL - INI
                if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
                    -- Registros para: PI.CTA.FConRedCB
                    if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FConRedCB') begin
                    print 'Registros para: PI.CTA.FConRedCB'
                    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
                    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
                    select @w_la_cod = 'ES_EC'
                    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consolidado Redes Posicionadas', 'M-CTA')
                    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
                    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.CorresponsalBancarioRedPos'
                    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.CTA.FConRedCB', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
                    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
                    if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
                    if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.Correspondents.Installer') begin
                    select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
                    insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.Correspondents.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.Correspondents.Installer/CTA.Ahos.Correspondents.Installer.application', 'COBISExplorer')
                    end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.Correspondents.Installer'
                    if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.Correspondents') begin
                    select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
                    insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.Correspondents', 'COBISCorp.tCOBIS.CTA.Ahos.Correspondents.dll', 0, null)
                    end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.Correspondents'
                    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
                    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
                    if not exists (select * from cobis..an_component where co_name = 'CTA.FConRedCB')
                    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FConRedCB', 'FConRedCBClass', 'COBISCorp.tCOBIS.CTA.Ahos.Correspondents', 'SV', '', 'M-CTA')
                    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
                    if not exists (select 1 from cobis..an_label where la_label = 'Consolidado Redes Posicionadas') begin
                    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consolidado Redes Posicionadas', 'M-CTA')
                    end
                    else select @w_la_id = la_id from cobis..an_label where la_label = 'Consolidado Redes Posicionadas'
                    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
                    if @w_pz_id is null select @w_pz_id = 1
                    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
                    insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
                    end
                    end
                -- Validacion Param OCUCOL - FIN
                go

                -- Validacion Param OCUCOL - INI
                if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
                    -- Registros para: PI.CTA.FTran303
                    if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran303') begin
                    print 'Registros para: PI.CTA.FTran303'
                    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
                    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
                    select @w_la_cod = 'ES_EC'
                    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Liberación de Cupo Corresponsal', 'M-CTA')
                    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
                    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.CorresponsalBancarioRedPos'
                    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
                    values (@w_pa_id, @w_la_id, 'PI.CTA.FTran303', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Liberacion_de_Cupo_Corresponsal', null)
                    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
                    if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
                    --if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.Correspondents.Installer') begin
                    if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
                    select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
                    insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) 
                    --values (@w_mg_id, 'CTA.Ahos.Correspondents.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.Correspondents.Installer/CTA.Ahos.Correspondents.Installer.application', 'COBISExplorer')
                    values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CustService.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
                    --end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.Correspondents.Installer'
                    end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
                    --if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.Correspondents.Installer') begin
                    if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
                    select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
                    insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
                    --values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.Correspondents.Installer', 'COBISCorp.tCOBIS.CTA.Ahos.Correspondents.dll', 0, null)
                    values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
                    --end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.Correspondents.Installer'
                    end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
                    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
                    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
                    if not exists (select * from cobis..an_component where co_name = 'CTA.FTran303')
                    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
                    --values (@w_co_id, @w_mo_id, 'CTA.FMotorBusq', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.Correspondents', 'SV', '', 'M-CTA')
                    values (@w_co_id, @w_mo_id, 'CTA.FTran303', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
                    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
                    if not exists (select 1 from cobis..an_label where la_label = 'Liberación de Cupo Corresponsal') begin
                    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Liberación de Cupo Corresponsal', 'M-CTA')
                    end
                    else select @w_la_id = la_id from cobis..an_label where la_label = 'Liberación de Cupo Corresponsal'
                    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
                    if @w_pz_id is null select @w_pz_id = 1
                    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
                    insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
                    end
                    end
                -- Validacion Param OCUCOL - FIN
                go
                    
                -- Validacion Param OCUCOL - INI
                if (select pa_char from cobis..cl_parametro where pa_nemonico='OCUCOL' and pa_producto = 'AHO') = 'N'
                    -- Registros para: PI.CTA.FTran214
                    if not exists (select 1 from cobis..an_page where pa_name = 'PI.CTA.FTran214') begin
                    print 'Registros para: PI.CTA.FTran214'
                    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
                    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
                    select @w_la_cod = 'ES_EC'
                    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cancelación Cuenta C.B', 'M-CTA')
                    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
                    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PI.Aho.CorresponsalBancarioRedPos'
                    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
                    values (@w_pa_id, @w_la_id, 'PI.CTA.FTran214', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=Cancelacion_CuentaCB', null)
                    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
                    if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
                    --if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.Correspondents.Installer') begin
                    if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer') begin
                    select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
                    insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) 
                    --values (@w_mg_id, 'CTA.Ahos.Correspondents.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.Correspondents.Installer/CTA.Ahos.Correspondents.Installer.application', 'COBISExplorer')
                    values (@w_mg_id, 'CTA.Ahos.CustService.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.Correspondents.Installer/CTA.Ahos.CustService.Installer.application', 'COBISExplorer')
                    --end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.Correspondents.Installer'
                    end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CustService.Installer'
                    --if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.Correspondents.Installer') begin
                    if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CustService') begin
                    select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
                    insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) 
                    --values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.Correspondents.Installer', 'COBISCorp.tCOBIS.CTA.Ahos.Correspondents.dll', 0, null)
                    values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CustService', 'COBISCorp.tCOBIS.CTA.Ahos.CustService.dll', 0, null)
                    --end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.Correspondents.Installer'
                    end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CustService'
                    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
                    
                    if not exists (select * from cobis..an_component where co_name = 'CTA.FTran214')
                    begin
                        insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
                        --values (@w_co_id, @w_mo_id, 'CTA.FMotorBusq', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.Correspondents', 'SV', '', 'M-CTA')
                        values (@w_co_id, @w_mo_id, 'CTA.FTran214', 'FMotorBusqClass', 'COBISCorp.tCOBIS.CTA.Ahos.CustService', 'SV', '', 'M-CTA')
                        insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
                    end else 
                    select @w_co_id  = co_id from   cobis..an_component  where co_name = 'CTA.FTran214'
                    if not exists (select 1 from cobis..an_label where la_label = 'Cancelación Cuenta C.B') begin
                    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
                    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cancelación Cuenta C.B', 'M-CTA')
                    end
                    else select @w_la_id = la_id from cobis..an_label where la_label = 'Cancelación Cuenta C.B'
                    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
                    if @w_pz_id is null select @w_pz_id = 1
                    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
                    insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
                    end
                    end
                    go
                -- Validacion Param OCUCOL - FIN
go
