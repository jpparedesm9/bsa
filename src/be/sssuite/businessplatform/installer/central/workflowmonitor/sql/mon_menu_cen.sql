/* Script para insertar en el menú de CEN la opción de Estadisticas */

use cobis
go

delete an_zone
where zo_id = 73800
go

delete an_label
where la_id = 73800
go

delete an_module_group
where mg_id = 73800
go

delete an_module
where mo_id = 73800
go

delete an_component
where co_id = 73800
go

delete an_page
where pa_id = 73800
go

delete an_page_zone
where pz_id = 73800
go


--Tabla an_zone
INSERT INTO dbo.an_zone ( zo_id, zo_name, zo_pin_visible, zo_close_visible, zo_title_visible, zo_pin_value ) 
		 VALUES ( 73800, 'Workflow Monitor', 1, 0, 0, 1 ) 
go

--Tabla an_label
INSERT INTO dbo.an_label ( la_id, la_cod, la_label, la_prod_name ) 
		VALUES ( 73800, 'ES_EC', 'Estadisticas', 'M-WKFM' ) 
go
--Tabla an_module_group
INSERT INTO dbo.an_module_group ( mg_id, mg_name, mg_version, mg_location, mg_store_name ) 
		VALUES ( 73800, 'Workflow Monitor', '1.0.0', 'Ninguno', 'M-WKFM') 
go

--Tabla an_module
INSERT INTO dbo.an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
		VALUES ( 73800, 73800, 73800, 'Workflow Monitor', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
go
--Tabla an_component
INSERT INTO dbo.an_component ( co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
		VALUES (73800, 73800, 'Workflow Monitor', 'Login.aspx?token&view=monitorMainPage', 'http://ucsp-server:8080/view/wfmonitor/common/', 'I', 'alternateURL=Common/PassContext.aspx?opt=monitorMainPage;postParameters=%Preferences%User%ClientProductInfo', 'M-WKFM') 
go

declare @w_id_pagina int

select @w_id_pagina = pa_id
  from an_page
 where pa_la_id = (select la_id 
		             from an_label
		            where la_label = 'Workflow'
		              and la_prod_name = 'M-WKF'
                      and la_cod= 'ES_EC' )    
--Tabla an_page
INSERT INTO dbo.an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
		 VALUES ( 73800, 73800, 'Workflow Monitor', 'icono pagina', @w_id_pagina, 2, 'horizontal', 'Nemonic', 'M-WKFM', NULL, NULL, 1 )  
go
--Tabla an_page_zone
INSERT INTO dbo.an_page_zone ( pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id )
		 VALUES ( 73800, 73800, 73800, 73800, 73800, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
go

declare @w_rol int
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

delete an_role_component 
where rc_co_id = 73800
  and rc_rol = @w_rol	

delete an_role_module 
where rm_mo_id = 73800
  and rm_rol = @w_rol
  
delete an_role_page 
where rp_pa_id = 73800
  and rp_rol = @w_rol  
    
-- Cobis Workflow Monitor
insert into an_role_component values(73800,@w_rol)
insert into an_role_module values(73800,@w_rol)
insert into an_role_page values(73800,@w_rol)   

go
