use cobis
go

set nocount ON

-- Registros para: AC.Atención al Cliente
if exists (select 1 from cobis..an_page where pa_name = 'PP.Parametrizacion de Productos') 
begin
	print 'Eliminación PA_NAME: PP.Parametrizacion de Productos'
	delete from cobis..an_page where pa_name = 'PP.Parametrizacion de Productos'
end
go
		
-- Registros para: PP.Creación / Mantenimiento de Productos---
if not exists (select 1 from cobis..an_page where pa_name = 'PP.Parametrización de Productos' and pa_prod_name = 'M-MENUPRIN') begin
print 'Registros para: PP.Creación / Mantenimiento de Productos'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Creación / Mantenimiento de Productos', 'M-MENUPRIN')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = 0
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'PP.Parametrización de Productos', 'icono pagina', @w_pa_id_parent, 0, 'horizontal', 'Nemonic', 'M-MENUPRIN', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
end
go

		-- Registros para: PP.Administración
		if not exists (select 1 from cobis..an_page where pa_name = 'PP.Administración' and pa_prod_name = 'M-CTA') begin
		print 'Registros para: PP.Administración'
		declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
		select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
		select @w_la_cod = 'ES_EC'
		select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
		insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Administración', 'M-CTA')
		select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
		select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Parametrización de Productos' and pa_prod_name = 'M-MENUPRIN'
		insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
		values (@w_pa_id, @w_la_id, 'PP.Administración', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
		insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
		end
		go
		
-- Se jca ocultan las opciones Transacciones a Contabilizar porq son exclusivas para ctacte --

-- Registros para: PP.CTA.FTran493
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FTran493') begin
print 'Registros para: PP.CTA.FTran493'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Transacciones a Contabilizar', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.CTA.FTran493', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
-- jca Se ocultan las opciones Transacciones a Contabilizar porq son exclusivas para ctacte --
--insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.AccAdmAcc') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.AccAdmAcc.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.AccAdmAcc.Installer/CTA.Ahos.AccAdmAcc.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.AccAdmAcc.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.AccountingAdmAccounts') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.AccountingAdmAccounts', 'COBISCorp.tCOBIS.CTA.Ahos.AccountingAdmAccounts.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.AccountingAdmAccounts'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran493', 'FTran493Class', 'COBISCorp.tCOBIS.CTA.Ahos.AccountingAdmAccounts', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Transacciones a Contabilizar') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Transacciones a Contabilizar', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Transacciones a Contabilizar'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go
-- jca Se ocultan las opciones Conceptos Contables por Transacción  porq son exclusivas para ctacte --

-- Registros para: PP.CTA.FConcTrn
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FConcTrn') begin
print 'Registros para: PP.CTA.FConcTrn'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Conceptos Contables por Transacción', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.CTA.FConcTrn', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
-- jca Se ocultan las opciones Conceptos Contables por Transacción
-- insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.AccAdmAcc') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.AccAdmAcc.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.AccAdmAcc.Installer/CTA.Ahos.AccAdmAcc.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.AccAdmAcc.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.AccountingAdmAccounts') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.AccountingAdmAccounts', 'COBISCorp.tCOBIS.CTA.Ahos.AccountingAdmAccounts.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.AccountingAdmAccounts'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FConcTrn', 'FConcTrnClass', 'COBISCorp.tCOBIS.CTA.Ahos.AccountingAdmAccounts', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Conceptos Contables por Transacción') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Conceptos Contables por Transacción', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Conceptos Contables por Transacción'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go


-- Registros para: PP.CTA.FParamConta
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FParamConta') begin
print 'Registros para: PP.CTA.FParamConta'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Parametrización Contable', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.CTA.FParamConta', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.AccAdmAcc') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.AccAdmAcc.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.AccAdmAcc.Installer/CTA.Ahos.AccAdmAcc.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.AccAdmAcc.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.AccountingAdmAccounts') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.AccountingAdmAccounts', 'COBISCorp.tCOBIS.CTA.Ahos.AccountingAdmAccounts.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.AccountingAdmAccounts'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FParamConta', 'FParamContaClass', 'COBISCorp.tCOBIS.CTA.Ahos.AccountingAdmAccounts', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Parametrización Contable') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Parametrización Contable', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Parametrización Contable'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PP.CTA.FPerfil
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FPerfil') begin
print 'Registros para: PP.CTA.FPerfil'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Relación de Perfiles Contables', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.CTA.FPerfil', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.AccAdmAcc') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.AccAdmAcc.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.AccAdmAcc.Installer/CTA.Ahos.AccAdmAcc.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.AccAdmAcc.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.AccountingAdmAccounts') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.AccountingAdmAccounts', 'COBISCorp.tCOBIS.CTA.Ahos.AccountingAdmAccounts.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.AccountingAdmAccounts'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FPerfil', 'FPerfilClass', 'COBISCorp.tCOBIS.CTA.Ahos.AccountingAdmAccounts', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Relación de Perfiles Contables') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Relación de Perfiles Contables', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Relación de Perfiles Contables'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PP.CTA.FTran2581
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FTran2581') begin
print 'Registros para: PP.CTA.FTran2581'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento de Acciones de Notas de Débito', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.CTA.FTran2581', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CausalAdmAccounts') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CausalAdmAccounts.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CausalAdmAccounts.Installer/CTA.Ahos.CausalAdmAccounts.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CausalAdmAccounts.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CausalAdmAccounts') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CausalAdmAccounts', 'COBISCorp.tCOBIS.CTA.Ahos.CausalAdmAccounts.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CausalAdmAccounts'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran2581', 'FTran2581Class', 'COBISCorp.tCOBIS.CTA.Ahos.CausalAdmAccounts', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Mantenimiento de Acciones de Notas de Débito') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento de Acciones de Notas de Débito', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Mantenimiento de Acciones de Notas de Débito'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PP.CTA.FTRAN707
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FTRAN707') begin
print 'Registros para: PP.CTA.FTRAN707'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Parametrización Impresión y Causales de Notas DB/CR', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.CTA.FTRAN707', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CausalAdmAccounts') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CausalAdmAccounts.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CausalAdmAccounts.Installer/CTA.Ahos.CausalAdmAccounts.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CausalAdmAccounts.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CausalAdmAccounts') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CausalAdmAccounts', 'COBISCorp.tCOBIS.CTA.Ahos.CausalAdmAccounts.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CausalAdmAccounts'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTRAN707', 'FTRAN707Class', 'COBISCorp.tCOBIS.CTA.Ahos.CausalAdmAccounts', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Parametrización Impresión y Causales de Notas DB/CR') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Parametrización Impresión y Causales de Notas DB/CR', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Parametrización Impresión y Causales de Notas DB/CR'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PP.CTA.FTran2696
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FTran2696') begin
print 'Registros para: PP.CTA.FTran2696'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento Causales Otros Ingresos/Egresos Caja', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.CTA.FTran2696', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CausalAdmAccounts') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CausalAdmAccounts.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CausalAdmAccounts.Installer/CTA.Ahos.CausalAdmAccounts.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CausalAdmAccounts.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CausalAdmAccounts') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CausalAdmAccounts', 'COBISCorp.tCOBIS.CTA.Ahos.CausalAdmAccounts.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CausalAdmAccounts'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran2696', 'FTran2696Class', 'COBISCorp.tCOBIS.CTA.Ahos.CausalAdmAccounts', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Mantenimiento Causales Otros Ingresos/Egresos Caja') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento Causales Otros Ingresos/Egresos Caja', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Mantenimiento Causales Otros Ingresos/Egresos Caja'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PP.CTA.FTran2913
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FTran2913') begin
print 'Registros para: PP.CTA.FTran2913'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Parametrización Causales Otros Ingresos/Egresos', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.CTA.FTran2913', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CausalAdmAccounts') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CausalAdmAccounts.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CausalAdmAccounts.Installer/CTA.Ahos.CausalAdmAccounts.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CausalAdmAccounts.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CausalAdmAccounts') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CausalAdmAccounts', 'COBISCorp.tCOBIS.CTA.Ahos.CausalAdmAccounts.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CausalAdmAccounts'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran2913', 'FTran2913Class', 'COBISCorp.tCOBIS.CTA.Ahos.CausalAdmAccounts', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Parametrización Causales Otros Ingresos/Egresos') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Parametrización Causales Otros Ingresos/Egresos', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Parametrización Causales Otros Ingresos/Egresos'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PP.CTA.FCtaBcoOfi
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FCtaBcoOfi') begin
print 'Registros para: PP.CTA.FCtaBcoOfi'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cuentas para consignación por oficina', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.CTA.FCtaBcoOfi', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.Admin') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.Admin.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.Admin.Installer/CTA.Ahos.Admin.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.Admin.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.Admin') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.Admin', 'COBISCorp.tCOBIS.CTA.Ahos.Admin.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.Admin'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FCtaBcoOfi', 'FCtaBcoOfiClass', 'COBISCorp.tCOBIS.CTA.Ahos.Admin', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Cuentas para consignación por oficina') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cuentas para consignación por oficina', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Cuentas para consignación por oficina'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PP.CTA.FMantCausalOfi
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FMantCausalOfi') begin
print 'Registros para: PP.CTA.FMantCausalOfi'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento Causales ND/NC por Oficina', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.CTA.FMantCausalOfi', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.CausalAdmAccounts') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.CausalAdmAccounts.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.CausalAdmAccounts.Installer/CTA.Ahos.CausalAdmAccounts.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.CausalAdmAccounts.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.CausalAdmAccounts') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.CausalAdmAccounts', 'COBISCorp.tCOBIS.CTA.Ahos.CausalAdmAccounts.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.CausalAdmAccounts'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FMantCausalOfi', 'FMantCausalOfiClass', 'COBISCorp.tCOBIS.CTA.Ahos.CausalAdmAccounts', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Mantenimiento Causales ND/NC por Oficina') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento Causales ND/NC por Oficina', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Mantenimiento Causales ND/NC por Oficina'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PP.CTA.FMantenimiento
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FMantenimiento') begin
print 'Registros para: PP.CTA.FMantenimiento'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento Equivalencias', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.CTA.FMantenimiento', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.Admin') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.Admin.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.Admin.Installer/CTA.Ahos.Admin.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.Admin.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.Admin') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.Admin', 'COBISCorp.tCOBIS.CTA.Ahos.Admin.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.Admin'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FMantenimiento', 'FMantenimientoClass', 'COBISCorp.tCOBIS.CTA.Ahos.Admin', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Mantenimiento Equivalencias') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento Equivalencias', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Mantenimiento Equivalencias'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PP.CTA.FTran2585
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FTran2585') begin
print 'Registros para: PP.CTA.FTran2585'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Ruta y Tránsito', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.CTA.FTran2585', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.Admin') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.Admin.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.Admin.Installer/CTA.Ahos.Admin.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.Admin.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.Admin') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.Admin', 'COBISCorp.tCOBIS.CTA.Ahos.Admin.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.Admin'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran2585', 'FTran2585Class', 'COBISCorp.tCOBIS.CTA.Ahos.Admin', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Ruta y Tránsito') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Ruta y Tránsito', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Ruta y Tránsito'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PP.CTA.FTran2589
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FTran2589') begin
print 'Registros para: PP.CTA.FTran2589'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Oficinas del Banco', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.CTA.FTran2589', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.Admin') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.Admin.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.Admin.Installer/CTA.Ahos.Admin.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.Admin.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.Admin') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.Admin', 'COBISCorp.tCOBIS.CTA.Ahos.Admin.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.Admin'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran2589', 'FTran2589Class', 'COBISCorp.tCOBIS.CTA.Ahos.Admin', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Oficinas del Banco') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Oficinas del Banco', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Oficinas del Banco'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PP.CTA.FTran2593
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FTran2593') begin
print 'Registros para: PP.CTA.FTran2593'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Bancos', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.CTA.FTran2593', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.Admin') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.Admin.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.Admin.Installer/CTA.Ahos.Admin.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.Admin.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.Admin') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.Admin', 'COBISCorp.tCOBIS.CTA.Ahos.Admin.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.Admin'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran2593', 'FTran2593Class', 'COBISCorp.tCOBIS.CTA.Ahos.Admin', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Bancos') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Bancos', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Bancos'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PP.CTA.FTran099
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FTran099') begin
print 'Registros para: PP.CTA.FTran099'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mensaje Estados de Cuenta', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.CTA.FTran099', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.Admin') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.Admin.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.Admin.Installer/CTA.Ahos.Admin.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.Admin.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.Admin') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.Admin', 'COBISCorp.tCOBIS.CTA.Ahos.Admin.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.Admin'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran099', 'FTran099Class', 'COBISCorp.tCOBIS.CTA.Ahos.Admin', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Mensaje Estados de Cuenta') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mensaje Estados de Cuenta', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Mensaje Estados de Cuenta'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PP.CTA.FTran2810
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FTran2810') begin
print 'Registros para: PP.CTA.FTran2810'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento Centros de Canje', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.CTA.FTran2810', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.ExchangeAdmCenters') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.ExchangeAdmCenters.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.ExchangeAdmCenters.Installer/CTA.Ahos.ExchangeAdmCenters.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.ExchangeAdmCenters.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.ExchangeAdmCenters') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.ExchangeAdmCenters', 'COBISCorp.tCOBIS.CTA.Ahos.ExchangeAdmCenters.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.ExchangeAdmCenters'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran2810', 'FTran2810Class', 'COBISCorp.tCOBIS.CTA.Ahos.ExchangeAdmCenters', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Mantenimiento Centros de Canje') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento Centros de Canje', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Mantenimiento Centros de Canje'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PP.CTA.FTran2564
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FTran2564') begin
print 'Registros para: PP.CTA.FTran2564'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento Plazas Bco. República', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.CTA.FTran2564', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.ExchangeAdmCenters') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.ExchangeAdmCenters.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.ExchangeAdmCenters.Installer/CTA.Ahos.ExchangeAdmCenters.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.ExchangeAdmCenters.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.ExchangeAdmCenters') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.ExchangeAdmCenters', 'COBISCorp.tCOBIS.CTA.Ahos.ExchangeAdmCenters.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.ExchangeAdmCenters'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTran2564', 'FTran2564Class', 'COBISCorp.tCOBIS.CTA.Ahos.ExchangeAdmCenters', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Mantenimiento Plazas Bco. República') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento Plazas Bco. República', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Mantenimiento Plazas Bco. República'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PP.CTA.FTipoCanje
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FTipoCanje') begin
print 'Registros para: PP.CTA.FTipoCanje'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Parametrización por Tipo de Canje', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.CTA.FTipoCanje', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.ExchangeAdmCenters') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.ExchangeAdmCenters.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.ExchangeAdmCenters.Installer/CTA.Ahos.ExchangeAdmCenters.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.ExchangeAdmCenters.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.ExchangeAdmCenters') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.ExchangeAdmCenters', 'COBISCorp.tCOBIS.CTA.Ahos.ExchangeAdmCenters.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.ExchangeAdmCenters'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTipoCanje', 'FTipoCanjeClass', 'COBISCorp.tCOBIS.CTA.Ahos.ExchangeAdmCenters', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Parametrización por Tipo de Canje') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Parametrización por Tipo de Canje', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Parametrización por Tipo de Canje'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PP.CTA.FPARAMDTN
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FPARAMDTN') begin
print 'Registros para: PP.CTA.FPARAMDTN'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento Códigos DTN', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.CTA.FPARAMDTN', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.Admin') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.Admin.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.Admin.Installer/CTA.Ahos.Admin.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.Admin.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.Admin') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.Admin', 'COBISCorp.tCOBIS.CTA.Ahos.Admin.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.Admin'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FPARAMDTN', 'FPARAMDTNClass', 'COBISCorp.tCOBIS.CTA.Ahos.Admin', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Mantenimiento Códigos DTN') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento Códigos DTN', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Mantenimiento Códigos DTN'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go
 				-- Registros para: PP.Administración de Autorizaciones ND/NC
 				if not exists (select 1 from cobis..an_page where pa_name = 'PP.Adm.AdminAutoNdNc' and pa_prod_name = 'M-CTA') begin
 				print 'Registros para: PP.Administración de Autorizaciones ND/NC'
 				declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
 				select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
 				select @w_la_cod = 'ES_EC'
 				select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
 				insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Administración de Autorizaciones ND/NC', 'M-CTA')
 				select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
 				select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración' and pa_prod_name = 'M-CTA'
 				insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
 				values (@w_pa_id, @w_la_id, 'PP.Adm.AdminAutoNdNc', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
 				insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
 				end
 				go
 
 				
-- Registros para: PP.CTA.Ftra2872
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.Ftra2872') begin
print 'Registros para: PP.CTA.Ftra2872'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento de Funcionarios Autorizantes', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Adm.AdminAutoNdNc'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'PP.CTA.Ftra2872', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 2', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBackOffice') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.QueryBackOffice.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.QueryBackOffice.Installer/CTA.Ahos.QueryBackOffice.Installer.application', '')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBackOffice.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.QueryBackOffice') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.QueryBackOffice', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.QueryBackOffice'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.Ftra2872', 'Ftran2872Class', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Mantenimiento de Funcionarios Autorizantes') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento de Funcionarios Autorizantes', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Mantenimiento de Funcionarios Autorizantes'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PP.CTA.Ftra2875
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.Ftra2875') begin
print 'Registros para: PP.CTA.Ftra2875'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento de Funcionarios Ejecutores', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Adm.AdminAutoNdNc'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'PP.CTA.Ftra2875', 'icono pagina', @w_pa_id_parent, 2, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 3', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBackOffice') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.QueryBackOffice.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.QueryBackOffice.Installer/CTA.Ahos.QueryBackOffice.Installer.application', '')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.QueryBackOffice.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.QueryBackOffice') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.QueryBackOffice', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.QueryBackOffice'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.Ftra2875', 'Ftran2875Class', 'COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Mantenimiento de Funcionarios Ejecutores') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento de Funcionarios Ejecutores', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Mantenimiento de Funcionarios Ejecutores'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go
				
				-- Registros para: PP.Mantenimiento Gravamen Movimiento Financiero
				if not exists (select 1 from cobis..an_page where pa_name = 'PP.Adm.GravamenMovFin' and pa_prod_name = 'M-CTA') begin
				print 'Registros para: PP.Mantenimiento Gravamen Movimiento Financiero'
				declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
				select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
				select @w_la_cod = 'ES_EC'
				select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
				insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento Gravamen Movimiento Financiero', 'M-CTA')
				select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
				select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración' and pa_prod_name = 'M-CTA'
				insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
				values (@w_pa_id, @w_la_id, 'PP.Adm.GravamenMovFin', 'icono pagina', @w_pa_id_parent, 2, 'horizontal', 'Nemonic', 'M-CTA', '', null)
				insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
				end
				go
				
-- Registros para: PP.CTA.FPExenGMF
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FPExenGMF') begin
print 'Registros para: PP.CTA.FPExenGMF'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Conceptos de Exención Gravamen Movimiento Financiero', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Adm.GravamenMovFin'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.CTA.FPExenGMF', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.Admin') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.Admin.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.Admin.Installer/CTA.Ahos.Admin.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.Admin.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.Admin') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.Admin', 'COBISCorp.tCOBIS.CTA.Ahos.Admin.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.Admin'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FPExenGMF', 'FPExenGMFClass', 'COBISCorp.tCOBIS.CTA.Ahos.Admin', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Conceptos de Exención Gravamen Movimiento Financiero') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Conceptos de Exención Gravamen Movimiento Financiero', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Conceptos de Exención Gravamen Movimiento Financiero'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PP.CTA.FTranUpGMF
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FTranUpGMF') begin
print 'Registros para: PP.CTA.FTranUpGMF'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Actualización GMF Ahorros / Corriente', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Adm.GravamenMovFin'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.CTA.FTranUpGMF', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', '', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.Admin') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.Admin.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.Admin.Installer/CTA.Ahos.Admin.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.Admin.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.Admin') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.Admin', 'COBISCorp.tCOBIS.CTA.Ahos.Admin.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.Admin'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FTranUpGMF', 'FTranUpGMFClass', 'COBISCorp.tCOBIS.CTA.Ahos.Admin', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'Actualización GMF Ahorros / Corriente') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Actualización GMF Ahorros / Corriente', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'Actualización GMF Ahorros / Corriente'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go
				

				-- Registros para: PP.Mantenimiento de Catálogos
				if not exists (select 1 from cobis..an_page where pa_name = 'PP.Adm.Catalogos' and pa_prod_name = 'M-CTA') begin
				print 'Registros para: PP.Mantenimiento de Catálogos'
				declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
				select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
				select @w_la_cod = 'ES_EC'
				select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
				insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento de Catálogos', 'M-CTA')
				select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
				select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Administración' and pa_prod_name = 'M-CTA'
				insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
				values (@w_pa_id, @w_la_id, 'PP.Adm.Catalogos', 'icono pagina', @w_pa_id_parent, 3, 'horizontal', 'Nemonic', 'M-CTA', '', null)
				insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
				end
				go

-- Registros para: PP.CTA.FMantCatalogoAho
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FMantCatalogoAho') begin
print 'Registros para: PP.CTA.FMantCatalogoAho'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Cuentas de Ahorros', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Adm.Catalogos'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'PP.CTA.FMantCatalogoAho', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-CTA', 'OP=AHO', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.AccountsAdmCatalogs') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.AccountsAdmCatalogs.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.AccountsAdmCatalogs.Installer/CTA.Ahos.AccountsAdmCatalogs.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.AccountsAdmCatalogs.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.AccountsAdmCatalogs') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.AccountsAdmCatalogs', 'COBISCorp.tCOBIS.CTA.Ahos.AccountsAdmCatalogs.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.AccountsAdmCatalogs'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FMantCatalogoAho', 'FMantCatalogoClass', 'COBISCorp.tCOBIS.CTA.Ahos.AccountsAdmCatalogs', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'De Cuentas de Ahorros') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Cuentas de Ahorros', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'De Cuentas de Ahorros'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

-- Registros para: PP.CTA.FMantCatalogoRem
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FMantCatalogoRem') begin
print 'Registros para: PP.CTA.FMantCatalogoRem'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Cámara-Remesas', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Adm.Catalogos'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'PP.CTA.FMantCatalogoRem', 'icono pagina', @w_pa_id_parent, 2, 'horizontal', 'Nemonic', 'M-CTA', 'OP=REM', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.AccountsAdmCatalogs') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.AccountsAdmCatalogs.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.AccountsAdmCatalogs.Installer/CTA.Ahos.AccountsAdmCatalogs.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.AccountsAdmCatalogs.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.AccountsAdmCatalogs') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.AccountsAdmCatalogs', 'COBISCorp.tCOBIS.CTA.Ahos.AccountsAdmCatalogs.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.AccountsAdmCatalogs'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FMantCatalogoRem', 'FMantCatalogoClass', 'COBISCorp.tCOBIS.CTA.Ahos.AccountsAdmCatalogs', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'De Cámara-Remesas') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Cámara-Remesas', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'De Cámara-Remesas'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go


-- Registros para: PP.CTA.FMantCatalogoPer
if not exists (select 1 from cobis..an_page where pa_name = 'PP.CTA.FMantCatalogoPer') begin
print 'Registros para: PP.CTA.FMantCatalogoPer'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
select @w_la_cod = 'ES_EC'
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Personalización', 'M-CTA')
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Adm.Catalogos'
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) 
values (@w_pa_id, @w_la_id, 'PP.CTA.FMantCatalogoPer', 'icono pagina', @w_pa_id_parent, 3, 'horizontal', 'Nemonic', 'M-CTA', 'OP=PER', null)
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
if not exists (select 1 from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end
if not exists (select 1 from cobis..an_module_group where mg_name = 'CTA.Ahos.AccountsAdmCatalogs') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'CTA.Ahos.AccountsAdmCatalogs.Installer', '4.0.0.1', 'http://[servername]/CTA.Ahos.AccountsAdmCatalogs.Installer/CTA.Ahos.AccountsAdmCatalogs.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'CTA.Ahos.AccountsAdmCatalogs.Installer'
if not exists (select 1 from cobis..an_module where mo_name = 'CTA.Ahos.AccountsAdmCatalogs') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'CTA.Ahos.AccountsAdmCatalogs', 'COBISCorp.tCOBIS.CTA.Ahos.AccountsAdmCatalogs.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'CTA.Ahos.AccountsAdmCatalogs'
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'CTA.FMantCatalogoPer', 'FMantCatalogoClass', 'COBISCorp.tCOBIS.CTA.Ahos.AccountsAdmCatalogs', 'SV', '', 'M-CTA')
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
if not exists (select 1 from cobis..an_label where la_label = 'De Personalización') begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'De Personalización', 'M-CTA')
end
else select @w_la_id = la_id from cobis..an_label where la_label = 'De Personalización'
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
if @w_pz_id is null select @w_pz_id = 1
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
end
end
go

