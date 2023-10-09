/*
** SCRIPT : REGISTRA LA OPCION DE LA VISTA 360 EN EL MENU DE CEN
**
**
*/
use cobis
go

declare @w_rol int,
        @w_int_ip_ws varchar(255),
		@w_label int,
		@w_page int
--select @w_rol = inst_rol from platform_installer 
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_int_ip_ws = inst_ip_ws from platform_installer

delete from cobis..an_zone where zo_id  = 73000
insert into cobis..an_zone values (73000,'Vista Consolidada',1,0,0,1)

delete from cobis..an_zone where zo_id = 73200
insert into cobis..an_zone values (73200,'Administrador de VCC',1,0,0,1)

delete from cobis..an_label where la_id = 73000
insert into cobis..an_label values (73000,'ES_EC','Vista Consolidada de Clientes','M-VCC')

delete from cobis..an_label where la_id = 73200
insert into cobis..an_label values (73200,'ES_EC','Administración Vista 360','M-VCC')

delete from cobis..an_module_group where mg_id = 73000
insert into cobis..an_module_group values (73000,'Plataforma de Atención al Cliente','1.0.0','Ninguno','M-VCC')

delete from cobis..an_module_group where mg_id = 73200
insert into cobis..an_module_group values (73200,'Administrador de VCC','1.0.0','Ninguno','M-VCC')

delete from cobis..an_module where mo_id  = 73000
insert into cobis..an_module values (73000,73000,73000,'Vista Consolidada de Clientes','COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll',0,null)

delete from cobis..an_module where mo_id = 73200
insert into cobis..an_module values (73200, 73200, 73200, 'Administrador de VCC', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, null)

delete from cobis..an_component where co_id = 73000
insert into cobis..an_component values (73000, 73000, 'Vista Consolidada de Clientes', 'Login.aspx?token%Preferences%User', 'http://' + @w_int_ip_ws + '/UCSP-Web/View/Common/', 'I', null, 'M-VCC')
update cobis..an_component set co_class = 'Login.aspx?token', co_namespace = 'http://' + @w_int_ip_ws + '/UCSP-Web/View/Common/', co_arguments = 'postParameters=%Preferences%User%ClientProductInfo' where co_id = 73000
-- This is for add support to open from a Office Banking Site
update cobis..an_component set co_arguments = 'alternateURL=Common/PassContext.aspx;postParameters=%Preferences%User%ClientProductInfo;urlTo=http://' + @w_int_ip_ws + '/UCSP-Web/View/Common/Login.aspx?token&' where co_id = 73000

delete cobis..an_component where co_id = 73200
insert into cobis..an_component(co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
       values(73200, 73200, 'Administrador de VCC', 'Login.aspx?token&view=Admin', 'http://' + @w_int_ip_ws + '/UCSP-Web/view/common/', 'I', 'postParameters=%Preferences%User%ClientProductInfo', 'M-VCC')

declare @w_parent_id int
--select @w_parent_id = pa_id from cobis..an_page where pa_name = 'AC.Posición Consolidada'
select @w_parent_id = 0 -- Se coloca para que no busque un menu anterior sino se ingrese directamente 

delete from cobis..an_page where pa_id = 73000
insert into cobis..an_page values (73000,73000,'Vista Consolidada de Clientes','icono pagina',@w_parent_id,1,'horizontal','Nemonic','M-VCC',null,null,1)

select @w_parent_id = pa_id from cobis..an_page where pa_name = 'AS.Administración del Sistema'

delete from cobis..an_page where pa_id = 73201
insert into cobis..an_page values (73201, 73000, 'Posición Consolidada', 'icono pagina', @w_parent_id, 1, 'horizontal', 'Nemonic', 'M-VCC', null, null, 1)

select @w_parent_id = pa_id from cobis..an_page where pa_name = 'Posición Consolidada'

delete from cobis..an_page where pa_id = 73200
insert into cobis..an_page values (73200, 73200, 'Administración Vista 360', 'icono pagina', @w_parent_id, 1, 'horizontal', 'Nemonic', 'M-VCC', null, null, 1)

delete from cobis..an_page_zone where pz_id = 73000
insert into cobis..an_page_zone values (73000, 73000, 73000, 73000, 73000, 1, 100, 100, 'Ninguno', 'vertical',0, 1,null)

delete cobis..an_page_zone where pz_id = 73200
insert into cobis..an_page_zone values (73200, 73200, 73200, 73200, 73200, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, null)

delete from cobis..an_role_component where rc_co_id  = 73000
insert into cobis..an_role_component values(73000,@w_rol)

delete cobis..an_role_component where rc_co_id = 73200 and rc_rol = @w_rol
insert into cobis..an_role_component values(73200, @w_rol)

delete from cobis..an_role_module where rm_mo_id = 73000
insert into cobis..an_role_module values(73000,@w_rol)

delete cobis..an_role_module where rm_mo_id = 73200 and rm_rol = @w_rol
insert into cobis..an_role_module values(73200, @w_rol)

delete from cobis..an_role_page where rp_pa_id = 73000
insert into cobis..an_role_page values(73000,@w_rol)

delete cobis..an_role_page where rp_pa_id = 73200 and rp_rol = @w_rol
insert into cobis..an_role_page values(73200, @w_rol)

go

