use cobis
go

delete an_zone
where zo_id in (86001,  86002)
go

delete an_label
where la_id in (86000, 86001,  86002)
go

delete an_module_group
where mg_id in (86001,  86002)
go

delete an_module
where mo_id in (86001,  86002)
go

delete an_component
where co_id in (86001,  86002)
go

delete an_page
where pa_id in (86000, 86001,  86002)
go

delete an_page_zone
where pz_id in (86001,  86002)
go

--Tabla an_label
INSERT INTO dbo.an_label ( la_id, la_cod, la_label, la_prod_name ) 
		 VALUES ( 86000, 'ES_EC', 'Administrador de Políticas', 'M-POL' ) 
go
INSERT INTO dbo.an_label ( la_id, la_cod, la_label, la_prod_name ) 
		 VALUES ( 86001, 'ES_EC', 'Editor de Políticas', 'M-POL' ) 
go
INSERT INTO dbo.an_label ( la_id, la_cod, la_label, la_prod_name ) 
		 VALUES ( 86002, 'ES_EC', 'Variables/Programas', 'M-POL' ) 
go


--Tabla an_page
declare @w_parent_id int
select @w_parent_id = 0
select @w_parent_id = pa_id from cobis..an_page where pa_la_id  = ( select la_id from cobis..an_label where la_label = 'Procesos Back Office')

INSERT INTO dbo.an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id ) 
		 VALUES ( 86000, 86000, 'Administration Rules', 'icono pagina', @w_parent_id, 1, 'horizontal', NULL, 'M-POL', NULL, NULL ) 
go
INSERT INTO dbo.an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id ) 
		 VALUES ( 86001, 86001, 'Administrador politicas', 'icono pagina', 86000, 1, 'horizontal', NULL, 'M-POL', NULL, NULL ) 
go
INSERT INTO dbo.an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id ) 
		 VALUES ( 86002, 86002, 'Variables/Programas', 'icono pagina', 86000, 2, 'horizontal', NULL, 'M-POL', NULL, NULL ) 
go


--Tabla an_zone
INSERT INTO dbo.an_zone ( zo_id, zo_name, zo_pin_visible, zo_close_visible, zo_title_visible, zo_pin_value ) 
		 VALUES ( 86001, 'Business Rules', 1, 0, 0, 1 ) 
go
INSERT INTO dbo.an_zone ( zo_id, zo_name, zo_pin_visible, zo_close_visible, zo_title_visible, zo_pin_value ) 
		 VALUES ( 86002, 'Variable/Programas', 1, 0, 0, 1 ) 
go


--Tabla an_module_group
INSERT INTO dbo.an_module_group ( mg_id, mg_name, mg_version, mg_location, mg_store_name ) 
		 VALUES ( 86001, 'Business Rules', '1.0.0', 'Ninguno', 'M-POL' ) 
go
INSERT INTO dbo.an_module_group ( mg_id, mg_name, mg_version, mg_location, mg_store_name ) 
		 VALUES ( 86002, 'Variables/Programas', '1.0.0', 'Ninguno', 'M-POL' ) 
go


--Tabla an_module
INSERT INTO dbo.an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
		 VALUES ( 86001, 86001, 86001, 'Business Rules', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
go
INSERT INTO dbo.an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
		 VALUES ( 86002, 86002, 86002, 'Variables/Programas', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
go


--Tabla an_component
declare @w_ip_ws varchar(255)
select @w_ip_ws = inst_ip_ws from platform_installer

INSERT INTO dbo.an_component ( co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
		 VALUES ( 86001, 86001, 'Business Rules', 'Login.aspx?token&view=principalRulesView', 'http://' + @w_ip_ws + '/view/common/', 'I', 'alternateURL=Common/PassContext.aspx?opt=principalRulesView;postParameters=%Preferences%User%ClientProductInfo', 'M-POL' ) 
INSERT INTO dbo.an_component ( co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
		 VALUES ( 86002, 86002, 'Variables/Programas', 'Login.aspx?token&view=variablesView', 'http://' + @w_ip_ws + '/view/common/', 'I', 'alternateURL=Common/PassContext.aspx?opt=variablesView;postParameters=%Preferences%User%ClientProductInfo', 'M-POL' ) 
go


--Tabla an_page_zone
INSERT INTO dbo.an_page_zone ( pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
		 VALUES ( 86001, 86001, 86001, 86001, 86001, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
go
INSERT INTO dbo.an_page_zone ( pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
		 VALUES ( 86002, 86002, 86002, 86002, 86002, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
go
