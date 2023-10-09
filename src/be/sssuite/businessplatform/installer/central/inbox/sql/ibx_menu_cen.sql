use cobis
go

-- dump tran cobis with no_log
go

delete an_zone
where zo_id in (73100)
go

delete an_label
where la_id in (73100)
go

delete an_module_group
where mg_id in ( 73100)
go

delete an_module
where mo_id in (73100)
go

delete an_component
where co_id in (73100)
go

delete an_page
where pa_id in ( 73100)
go

delete an_page_zone
where pz_id in ( 73100)
go


--Tabla an_zone

INSERT INTO dbo.an_zone ( zo_id, zo_name, zo_pin_visible, zo_close_visible, zo_title_visible, zo_pin_value ) 
         VALUES ( 73100, 'Inbox Container', 1, 1, 0, 1 )
go


--Tabla an_label

INSERT INTO dbo.an_label ( la_id, la_cod, la_label, la_prod_name ) 
         VALUES ( 73100, 'ES_EC', 'Inbox Windows', 'M-IBX')	
go


--Tabla an_module_group

declare @w_ip_port varchar(20)

/*MODIFICAR POR EL IP Y PUERTO CORRECTO*/		
select @w_ip_port = '[servername]'



INSERT INTO dbo.an_module_group ( mg_id, mg_name, mg_version, mg_location, mg_store_name ) 
         VALUES ( 73100, 'Inbox Container',  '4.2.0.0', 'http://' + @w_ip_port + '/Windows.Inbox.Setup/Windows.Inbox.Setup.application', 'M-IBX' ) 
go


--Tabla an_module

INSERT INTO dbo.an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
         VALUES ( 73100, 73100, 73100, 'Inbox Container', 'COBISCorp.eCOBIS.Windows.Inbox.dll', 0, NULL )
go


--Tabla an_component

INSERT INTO dbo.an_component ( co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
         VALUES (73100,	73100, 'Inbox Container', 'InboxContainerView', 'COBISCorp.eCOBIS.Inbox.View', 'SV', null, 'M-IBX' )
go


--Tabla an_page
declare @w_parent_id int
select @w_parent_id = 0
select @w_parent_id = pa_id from cobis..an_page where pa_name = 'IBX.Inbox' and pa_prod_name = 'M-IBX'

INSERT INTO dbo.an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible) 
         VALUES ( 73100, 73100, 'Inbox Container', 'icono pagina', @w_parent_id, 4, 'horizontal', 'Nemonic', 'M-IBX', NULL, NULL, 0 ) 
go


--Tabla an_page_zone

INSERT INTO dbo.an_page_zone ( pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
         VALUES ( 73100, 73100, 73100, 73100, 73100, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL )
go

--Tabla an_role_module
declare @w_rol int
select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS' 


delete from dbo.an_role_module where rm_rol = @w_rol and rm_mo_id = 73100
insert into dbo.an_role_module values(73100, @w_rol)

--Tabla an_role_component

delete from dbo.an_role_component where rc_rol = @w_rol and rc_co_id = 73100  
insert into dbo.an_role_component values(73100, @w_rol)

--Tabla an_role_page
delete from dbo.an_role_page where rp_rol = @w_rol and rp_pa_id = 73100
insert into dbo.an_role_page values(73100, @w_rol)

go
