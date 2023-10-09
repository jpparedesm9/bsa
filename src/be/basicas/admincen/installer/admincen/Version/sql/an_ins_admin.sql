/*************************************************************************/
/*  Archivo:        an_ins_admin.sql                                     */
/*  Base de datos:  cobis                                                */
/*  Producto:       COBIS Explorer . Net                                 */
/*************************************************************************/
/*                              IMPORTANTE                               */
/*  Este programa es parte de los paquetes bancarios propiedad de        */
/*  Cobiscorp.                                                           */
/*  Su uso no autorizado queda expresamente prohibido asi como cualquier */
/*  alteracion o agregado hecho por alguno de sus usuarios sin el debido */
/*  consentimiento por escrito de la Presidencia Ejecutiva de Cobiscorpo */
/*  su representante.                                                    */
/*************************************************************************/
/*                              PROPOSITO                                */
/*  Insercion de datos iniciales en las estructuras de CEN requeridos    */
/*  para las opcines de Admin                                            */
/*************************************************************************/
/*                            MODIFICACIONES                             */
/*  FECHA       AUTOR       RAZON                                        */
/* 26/mar/2010  S. Soto     Emision Inicial                              */
/* 26/Ene/2011  S. Soto     Correccciones ortográficas - Vesrion de DLL  */
/*************************************************************************/
use cobis
go

--Variables de uso general
declare @w_mg_id     int,
        @w_mg_name   varchar(64),  
        @w_rol       int,
        @w_prod_name varchar(10),
        @w_ruta      varchar(255)
          
select @w_rol = pa_tinyint
from cobis..cl_parametro
where pa_nemonico='RACEN'

select @w_prod_name = 'ADMIN',
       @w_mg_name = 'COBISCorp.eCOBIS.Admin.Security.AdminCen'
       
select @w_ruta = pa_char + '/AdminCEN.Installer/AdminCEN.Installer.application' from cl_parametro where pa_nemonico = 'PICEN' and pa_producto = 'ADM'

--ELIMINACION DE DATOS PREVIOS
delete an_label where la_prod_name = @w_prod_name

delete an_page_zone where pz_pa_id in (select pa_id from an_page where pa_prod_name  = @w_prod_name) 
delete an_page where pa_prod_name  = @w_prod_name
delete an_component where co_prod_name  = @w_prod_name
delete an_module where mo_mg_id = (select mg_id from an_module_group where mg_name = @w_mg_name)
delete an_module_group where mg_name = @w_mg_name

if @w_rol is null
    print 'No se encontro id de Rol Administrador'
else
begin
	delete an_role_component where rc_rol = @w_rol and rc_co_id not in (1, 2, 3)
	delete an_role_module where rm_rol = @w_rol and rm_mo_id not in (1, 2)
	delete an_role_page where rp_rol = @w_rol
end


-- DEFINICION DE LOS GRUPOS DE MODULOS PARA ADMIN CEN
print 'DEFINICION DE GRUPO DE MODULOS PARA ADMIN CEN'

select @w_mg_id = isnull(max(mg_id),0) + 1
  from an_module_group

insert into an_module_group values (@w_mg_id, @w_mg_name, '4.0.0.0', @w_ruta, null)

-- DEFINICION DE MODULOS PARA ADMIN CEN
print 'DEFINICION DE MODULOS PARA ADMIN CEN'

declare @w_mo_id_adm integer,
        @w_mo_id_aut integer,         
        @w_la_id_m1 integer,
        @w_la_id_m2 integer

select @w_la_id_m1 = isnull(max(la_id),0) + 1 from an_label
select @w_la_id_m2 = @w_la_id_m1 + 1

--Label para Modulo de Administracion y  Autorización
insert into an_label values (@w_la_id_m1,'ES_EC','MODULO ADMINISTRACION ADMIN CEN', @w_prod_name) 
insert into an_label values (@w_la_id_m2,'ES_EC','MODULO AUTORIZACION ADMIN CEN', @w_prod_name) 

select @w_mo_id_adm = isnull(max(mo_id),0) + 1 from an_module
select @w_mo_id_aut = @w_mo_id_adm + 1

--Modulo de Administracion y Autorización
insert into an_module values (@w_mo_id_adm, @w_mg_id, @w_la_id_m1, 'AdminModuleAdministration', 'COBISCorp.eCOBIS.Admin.Security.AdminCen.dll', 0, '9b8bba00b1313138' )
insert into an_module values (@w_mo_id_aut, @w_mg_id, @w_la_id_m2, 'AdminModuleAdminAuthorization', 'COBISCorp.eCOBIS.Admin.Security.AdminCen.dll', 0, '9b8bba00b1313138' )

--Registro de asociaciones con el Rol ADMINISTRADOR con Modulos
if @w_rol is null
    print 'No se encontro id de Rol Administrador'
else
begin
	insert into an_role_module (rm_mo_id, rm_rol) values (@w_mo_id_adm, @w_rol)
	insert into an_role_module (rm_mo_id, rm_rol) values (@w_mo_id_aut, @w_rol)
end


-- DEFINICION DE PAGINAS PARA ADMIN CEN
print 'DEFINICION DE PAGINAS PARA ADMIN CEN'

declare @w_pa_id integer,   
        @w_pa_id_padm integer,
        @w_pa_id_paut integer,

        @w_la_id integer, 
        @w_la_id_padm integer,
        @w_la_id_paut integer,

        @id_pz_id integer,
        @w_co_id integer, 
        @w_pa_id_root integer 

---------------------------------
print 'Pagina Padre de Admin CEN'
select @w_la_id = isnull(max(la_id),0) + 1 from an_label
select @w_pa_id_root = isnull(max(pa_id),0) + 1 from an_page
insert into an_label values (@w_la_id, 'ES_EC', 'Admin CEN', @w_prod_name) 
insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id) values (@w_pa_id_root, @w_la_id, 'PagAdmin', null, 0, 1, 'horizontal', 'PADM', @w_prod_name, null, null)
if @w_rol is null
    print 'No se encontro id de Rol Administrador'
else
begin
	insert into an_role_page values (@w_pa_id_root, @w_rol)
end

--------------------------------------
print 'Pagina Padre de Administracion'
select @w_la_id_padm = isnull(max(la_id),0) + 1 from an_label
select @w_pa_id_padm = isnull(max(pa_id),0) + 1 from an_page
insert into an_label values (@w_la_id_padm, 'ES_EC', 'Opciones de Administración', @w_prod_name) 
insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id) values (@w_pa_id_padm, @w_la_id_padm, 'PagAdminAdm', null, @w_pa_id_root, 1, 'horizontal', 'PADM-1', @w_prod_name, null, null)
if @w_rol is null
    print 'No se encontro id de Rol Administrador'
else
begin
	insert into an_role_page values (@w_pa_id_padm, @w_rol)
end

----------------------------------------------------
print 'Pagina de Mantenimiento de Grupos de Modulos'
select @w_co_id = isnull(max(co_id),0) + 1 from an_component
select @w_la_id = isnull(max(la_id),0) + 1 from an_label
select @w_pa_id = isnull(max(pa_id),0) + 1 from an_page

insert into an_component values (@w_co_id, @w_mo_id_adm, 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View.ModuleGroupView', 'ModuleGroupView', 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View', 'SV', null, @w_prod_name)
insert into an_label values (@w_la_id, 'ES_EC', 'Grupos de Módulos', @w_prod_name) 
insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id) values (@w_pa_id, @w_la_id, 'PagAdminGrpMod', null, @w_pa_id_padm, 1, 'horizontal', 'PADM-1.1', @w_prod_name, null, null)

insert into an_label values (@w_la_id + 1, 'ES_EC', 'Mantenimiento de Grupos de Módulos', @w_prod_name) 
select @id_pz_id = isnull(max(pz_id),0) + 1 from an_page_zone 
insert into an_page_zone values (@id_pz_id, 1, @w_la_id + 1, @w_pa_id, @w_co_id, 1, 100, 100, null,'horizontal', 0, 1, null)

--Registro de asociaciones con el Rol ADMINISTRADOR con Component y Page'
if @w_rol is null
    print 'No se encontro id de Rol Administrador'
else
begin
	insert into an_role_component (rc_co_id, rc_rol) values (@w_co_id, @w_rol)
	insert into an_role_page values (@w_pa_id, @w_rol)
end

------------------------------------------
print 'Pagina de Mantenimiento de Modulos'
select @w_co_id = isnull(max(co_id),0) + 1 from an_component
select @w_la_id = isnull(max(la_id),0) + 1 from an_label
select @w_pa_id = isnull(max(pa_id),0) + 1 from an_page

insert into an_component values (@w_co_id, @w_mo_id_adm, 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View.ModuleModuleView', 'ModuleModuleView', 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View', 'SV', null, @w_prod_name)
insert into an_label values (@w_la_id, 'ES_EC', 'Módulos', @w_prod_name) 
insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id) values (@w_pa_id, @w_la_id, 'PagAdminMod', null, @w_pa_id_padm, 2, 'horizontal', 'PADM-1.2', @w_prod_name, null, null)

insert into an_label values (@w_la_id + 1, 'ES_EC', 'Mantenimiento de Módulos', @w_prod_name) 
select @id_pz_id = isnull(max(pz_id),0) + 1 from an_page_zone 
insert into an_page_zone values (@id_pz_id, 1, @w_la_id + 1, @w_pa_id, @w_co_id, 1, 100, 100, null,'horizontal', 0, 1, null)

--Registro de asociaciones con el Rol ADMINISTRADOR con Component y Page'
if @w_rol is null
    print 'No se encontro id de Rol Administrador'
else
begin
	insert into an_role_component (rc_co_id, rc_rol) values (@w_co_id, @w_rol)
	insert into an_role_page values (@w_pa_id, @w_rol)
end

----------------------------------------------
print 'Pagina de Mantenimiento de Componentes'
select @w_co_id = isnull(max(co_id),0) + 1 from an_component
select @w_la_id = isnull(max(la_id),0) + 1 from an_label
select @w_pa_id = isnull(max(pa_id),0) + 1 from an_page

insert into an_component values (@w_co_id, @w_mo_id_adm, 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View.ModuleComponentView', 'ModuleComponentView', 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View', 'SV', null, @w_prod_name)
insert into an_label values (@w_la_id, 'ES_EC', 'Componentes', @w_prod_name) 
insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id) values (@w_pa_id, @w_la_id, 'PagAdminCmp', null, @w_pa_id_padm, 3, 'horizontal', 'PADM-1.3', @w_prod_name, null, null)

insert into an_label values (@w_la_id + 1, 'ES_EC', 'Mantenimiento de Componentes', @w_prod_name) 
select @id_pz_id = isnull(max(pz_id),0) + 1 from an_page_zone 
insert into an_page_zone values (@id_pz_id, 1, @w_la_id + 1, @w_pa_id, @w_co_id, 1, 100, 100, null,'horizontal', 0, 1, null)

--Registro de asociaciones con el Rol ADMINISTRADOR con Component y Page'
if @w_rol is null
    print 'No se encontro id de Rol Administrador'
else
begin
	insert into an_role_component (rc_co_id, rc_rol) values (@w_co_id, @w_rol)
	insert into an_role_page values (@w_pa_id, @w_rol)
end

--------------------------------------------
print 'Pagina de Mantenimiento de Etiquetas'
select @w_co_id = isnull(max(co_id),0) + 1 from an_component
select @w_la_id = isnull(max(la_id),0) + 1 from an_label
select @w_pa_id = isnull(max(pa_id),0) + 1 from an_page

insert into an_component values (@w_co_id, @w_mo_id_adm, 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View.ModuleLabelView', 'ModuleLabelView', 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View', 'SV', null, @w_prod_name)
insert into an_label values (@w_la_id, 'ES_EC', 'Etiquetas', @w_prod_name) 
insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id) values (@w_pa_id, @w_la_id, 'PagAdminLbl', null, @w_pa_id_padm, 4, 'horizontal', 'PADM-1.4', @w_prod_name, null, null)

insert into an_label values (@w_la_id + 1, 'ES_EC', 'Mantenimiento de Etiquetas', @w_prod_name) 
select @id_pz_id = isnull(max(pz_id),0) + 1 from an_page_zone 
insert into an_page_zone values (@id_pz_id, 1, @w_la_id + 1, @w_pa_id, @w_co_id, 1, 100, 100, null,'horizontal', 0, 1, null)

--Registro de asociaciones con el Rol ADMINISTRADOR con Component y Page'
if @w_rol is null
    print 'No se encontro id de Rol Administrador'
else
begin
	insert into an_role_component (rc_co_id, rc_rol) values (@w_co_id, @w_rol)
	insert into an_role_page values (@w_pa_id, @w_rol)
end

------------------------------------------
print 'Pagina de Mantenimiento de Paginas'
select @w_co_id = isnull(max(co_id),0) + 1 from an_component
select @w_la_id = isnull(max(la_id),0) + 1 from an_label
select @w_pa_id = isnull(max(pa_id),0) + 1 from an_page

insert into an_component values (@w_co_id, @w_mo_id_adm, 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View.ModulePageView', 'ModulePageView', 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View', 'SV', null, @w_prod_name)
insert into an_label values (@w_la_id, 'ES_EC', 'Páginas', @w_prod_name) 
insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id) values (@w_pa_id, @w_la_id, 'PagAdminPag', null, @w_pa_id_padm, 5, 'horizontal', 'PADM-1.5', @w_prod_name, null, null)

insert into an_label values (@w_la_id + 1, 'ES_EC', 'Mantenimiento de Páginas', @w_prod_name) 
select @id_pz_id = isnull(max(pz_id),0) + 1 from an_page_zone 
insert into an_page_zone values (@id_pz_id, 1, @w_la_id + 1, @w_pa_id, @w_co_id, 1, 100, 100, null,'horizontal', 0, 1, null)

--Registro de asociaciones con el Rol ADMINISTRADOR con Component y Page'
if @w_rol is null
    print 'No se encontro id de Rol Administrador'
else
begin
	insert into an_role_component (rc_co_id, rc_rol) values (@w_co_id, @w_rol)
	insert into an_role_page values (@w_pa_id, @w_rol)
end

--------------------------------------------------
print 'Pagina de Mantenimiento de Zonas de Pagina'
select @w_co_id = isnull(max(co_id),0) + 1 from an_component
select @w_la_id = isnull(max(la_id),0) + 1 from an_label
select @w_pa_id = isnull(max(pa_id),0) + 1 from an_page

insert into an_component values (@w_co_id, @w_mo_id_adm, 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View.ModulePageZoneView', 'ModulePageZoneView', 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View', 'SV', null, @w_prod_name)
insert into an_label values (@w_la_id, 'ES_EC', 'Zonas de Página', @w_prod_name) 
insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id) values (@w_pa_id, @w_la_id, 'PagAdminZPg', null, @w_pa_id_padm, 6, 'horizontal', 'PADM-1.6', @w_prod_name, null, null)

insert into an_label values (@w_la_id + 1, 'ES_EC', 'Mantenimiento de Zonas de Página', @w_prod_name)
select @id_pz_id = isnull(max(pz_id),0) + 1 from an_page_zone 
insert into an_page_zone values (@id_pz_id, 1, @w_la_id + 1, @w_pa_id, @w_co_id, 1, 100, 100, null,'horizontal', 0, 1, null)

--Registro de asociaciones con el Rol ADMINISTRADOR con Component y Page'
if @w_rol is null
    print 'No se encontro id de Rol Administrador'
else
begin
	insert into an_role_component (rc_co_id, rc_rol) values (@w_co_id, @w_rol)
	insert into an_role_page values (@w_pa_id, @w_rol)
end

----------------------------------------------
print 'Pagina de Asociacion de Zona de Pagina'
select @w_co_id = isnull(max(co_id),0) + 1 from an_component
select @w_la_id = isnull(max(la_id),0) + 1 from an_label
select @w_pa_id = isnull(max(pa_id),0) + 1 from an_page

insert into an_component values (@w_co_id, @w_mo_id_adm, 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View.ModuleAsoCompZonView', 'ModuleAsoCompZonView', 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View', 'SV', null, @w_prod_name)
insert into an_label values (@w_la_id, 'ES_EC', 'Asociacionde Zonas de Página', @w_prod_name) 
insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id) values (@w_pa_id, @w_la_id, 'PagAdminAZP', null, @w_pa_id_padm, 7, 'horizontal', 'PADM-1.7', @w_prod_name, null, null)

insert into an_label values (@w_la_id + 1, 'ES_EC', 'Asociacion de Zonas de Página', @w_prod_name)
select @id_pz_id = isnull(max(pz_id),0) + 1 from an_page_zone 
insert into an_page_zone values (@id_pz_id, 1, @w_la_id + 1, @w_pa_id, @w_co_id, 1, 100, 100, null,'horizontal', 0, 1, null)

--Registro de asociaciones con el Rol ADMINISTRADOR con Component y Page'
if @w_rol is null
    print 'No se encontro id de Rol Administrador'
else
begin
	insert into an_role_component (rc_co_id, rc_rol) values (@w_co_id, @w_rol)
	insert into an_role_page values (@w_pa_id, @w_rol)
end

-------------------------------------------------------
print 'Pagina de Seleccion de Tipo de Zona para Pagina'
select @w_co_id = isnull(max(co_id),0) + 1 from an_component
select @w_la_id = isnull(max(la_id),0) + 1 from an_label
select @w_pa_id = isnull(max(pa_id),0) + 1 from an_page

insert into an_component values (@w_co_id, @w_mo_id_adm, 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View.ModuleSelectModeView', 'ModuleSelectModeView', 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View', 'SV', null, @w_prod_name)
insert into an_label values (@w_la_id, 'ES_EC', 'Tipos de Zona', @w_prod_name) 
insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id) values (@w_pa_id, @w_la_id, 'PagAdminTpZ', null, @w_pa_id_padm, 8, 'horizontal', 'PADM-1.8', @w_prod_name, null, null)

insert into an_label values (@w_la_id + 1, 'ES_EC', 'Seleccion de Tipos de Zona', @w_prod_name)
select @id_pz_id = isnull(max(pz_id),0) + 1 from an_page_zone 
insert into an_page_zone values (@id_pz_id, 1, @w_la_id + 1, @w_pa_id, @w_co_id, 1, 100, 100, null,'horizontal', 0, 1, null)

--Registro de asociaciones con el Rol ADMINISTRADOR con Component y Page'
if @w_rol is null
    print 'No se encontro id de Rol Administrador'
else
begin
	insert into an_role_component (rc_co_id, rc_rol) values (@w_co_id, @w_rol)
	insert into an_role_page values (@w_pa_id, @w_rol)
end

----------------------------------------------------------
print 'Pagina de Mantenimiento de Prerequisitos de Pagina'
select @w_co_id = isnull(max(co_id),0) + 1 from an_component
select @w_la_id = isnull(max(la_id),0) + 1 from an_label
select @w_pa_id = isnull(max(pa_id),0) + 1 from an_page

insert into an_component values (@w_co_id, @w_mo_id_adm, 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View.ModulePrereqPageView', 'ModulePrereqPageView', 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View', 'SV', null, @w_prod_name)
insert into an_label values (@w_la_id, 'ES_EC', 'Prerequisitos de Página', @w_prod_name) 
insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id) values (@w_pa_id, @w_la_id, 'PagAdminPre', null, @w_pa_id_padm, 9, 'horizontal', 'PADM-1.9', @w_prod_name, null, null)

insert into an_label values (@w_la_id + 1, 'ES_EC', 'Mantenimiento de Prerequisitos de Página', @w_prod_name)
select @id_pz_id = isnull(max(pz_id),0) + 1 from an_page_zone 
insert into an_page_zone values (@id_pz_id, 1, @w_la_id + 1, @w_pa_id, @w_co_id, 1, 100, 100, null,'horizontal', 0, 1, null)

--Registro de asociaciones con el Rol ADMINISTRADOR con Component y Page'
if @w_rol is null
    print 'No se encontro id de Rol Administrador'
else
begin
	insert into an_role_component (rc_co_id, rc_rol) values (@w_co_id, @w_rol)
	insert into an_role_page values (@w_pa_id, @w_rol)
end

------------------------------------------------------
print 'Pagina de Mantenimiento de Zonas de Navegacion'
select @w_co_id = isnull(max(co_id),0) + 1 from an_component
select @w_la_id = isnull(max(la_id),0) + 1 from an_label
select @w_pa_id = isnull(max(pa_id),0) + 1 from an_page

insert into an_component values (@w_co_id, @w_mo_id_adm, 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View.ModuleNavigationZoneView', 'ModuleNavigationZoneView', 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View', 'SV', null, @w_prod_name)
insert into an_label values (@w_la_id, 'ES_EC', 'Zonas de Navegacion', @w_prod_name) 
insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id) values (@w_pa_id, @w_la_id, 'PagAdminZNv', null, @w_pa_id_padm, 10, 'horizontal', 'PADM-1.10', @w_prod_name, null, null)

insert into an_label values (@w_la_id + 1, 'ES_EC', 'Mantenimiento de Zonas de Navegacion', @w_prod_name)
select @id_pz_id = isnull(max(pz_id),0) + 1 from an_page_zone 
insert into an_page_zone values (@id_pz_id, 1, @w_la_id + 1, @w_pa_id, @w_co_id, 1, 100, 100, null,'horizontal', 0, 1, null)

--Registro de asociaciones con el Rol ADMINISTRADOR con Component y Page'
if @w_rol is null
    print 'No se encontro id de Rol Administrador'
else
begin
	insert into an_role_component (rc_co_id, rc_rol) values (@w_co_id, @w_rol)
	insert into an_role_page values (@w_pa_id, @w_rol)
end

------------------------------------
print 'Pagina Padre de Autorización'
select @w_la_id_paut = isnull(max(la_id),0) + 1 from an_label
select @w_pa_id_paut = isnull(max(pa_id),0) + 1 from an_page
insert into an_label values (@w_la_id_paut, 'ES_EC', 'Opciones de Autorización', @w_prod_name) 
insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id) values (@w_pa_id_paut, @w_la_id_paut, 'PagAdminAut', null, @w_pa_id_root, 2, 'horizontal', 'PADM-2', @w_prod_name, null, null)
if @w_rol is null
    print 'No se encontro id de Rol Administrador'
else
begin
	insert into an_role_page values (@w_pa_id_paut, @w_rol)
end

---------------------------------------------------
print 'Pagina de Autorización de Componentes a Rol'
select @w_co_id = isnull(max(co_id),0) + 1 from an_component
select @w_la_id = isnull(max(la_id),0) + 1 from an_label
select @w_pa_id = isnull(max(pa_id),0) + 1 from an_page

insert into an_component values (@w_co_id, @w_mo_id_aut, 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View.ModuleRolComponentView', 'ModuleRolComponentView', 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View', 'SV', null, @w_prod_name)
insert into an_label values (@w_la_id, 'ES_EC', 'Componentes por Rol', @w_prod_name) 
insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id) values (@w_pa_id, @w_la_id, 'PagAdminACR', null, @w_pa_id_paut, 1, 'horizontal', 'PADM-2.1', @w_prod_name, null, null)

insert into an_label values (@w_la_id + 1, 'ES_EC', 'Autorización de Componentes a Rol', @w_prod_name) 
select @id_pz_id = isnull(max(pz_id),0) + 1 from an_page_zone 
insert into an_page_zone values (@id_pz_id, 1, @w_la_id + 1, @w_pa_id, @w_co_id, 1, 100, 100, null,'horizontal', 0, 1, null)

--Registro de asociaciones con el Rol ADMINISTRADOR con Component y Page'
if @w_rol is null
    print 'No se encontro id de Rol Administrador'
else
begin
	insert into an_role_component (rc_co_id, rc_rol) values (@w_co_id, @w_rol)
	insert into an_role_page values (@w_pa_id, @w_rol)
end

-----------------------------------------------
print 'Pagina de Autorización de Modulos a Rol'
select @w_co_id = isnull(max(co_id),0) + 1 from an_component
select @w_la_id = isnull(max(la_id),0) + 1 from an_label
select @w_pa_id = isnull(max(pa_id),0) + 1 from an_page

insert into an_component values (@w_co_id, @w_mo_id_aut, 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View.ModuleRolModuleView', 'ModuleRolModuleView', 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View', 'SV', null, @w_prod_name)
insert into an_label values (@w_la_id, 'ES_EC', 'Módulos por Rol', @w_prod_name) 
insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id) values (@w_pa_id, @w_la_id, 'PagAdminAMR', null, @w_pa_id_paut, 2, 'horizontal', 'PADM-2.2', @w_prod_name, null, null)

insert into an_label values (@w_la_id + 1, 'ES_EC', 'Autorización de Módulos a Rol', @w_prod_name) 
select @id_pz_id = isnull(max(pz_id),0) + 1 from an_page_zone 
insert into an_page_zone values (@id_pz_id, 1, @w_la_id + 1, @w_pa_id, @w_co_id, 1, 100, 100, null,'horizontal', 0, 1, null)

--Registro de asociaciones con el Rol ADMINISTRADOR con Component y Page'
if @w_rol is null
    print 'No se encontro id de Rol Administrador'
else
begin
	insert into an_role_component (rc_co_id, rc_rol) values (@w_co_id, @w_rol)
	insert into an_role_page values (@w_pa_id, @w_rol)
end

-----------------------------------------------------------
print 'Pagina de Autorización de Zonas de Navegacion a Rol'
select @w_co_id = isnull(max(co_id),0) + 1 from an_component
select @w_la_id = isnull(max(la_id),0) + 1 from an_label
select @w_pa_id = isnull(max(pa_id),0) + 1 from an_page

insert into an_component values (@w_co_id, @w_mo_id_aut, 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View.ModuleRolNavigationZoneView', 'ModuleRolNavigationZoneView', 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View', 'SV', null, @w_prod_name)
insert into an_label values (@w_la_id, 'ES_EC', 'Zonas de Navegación por Rol', @w_prod_name) 
insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id) values (@w_pa_id, @w_la_id, 'PagAdminZVR', null, @w_pa_id_paut, 3, 'horizontal', 'PADM-2.3', @w_prod_name, null, null)

insert into an_label values (@w_la_id + 1, 'ES_EC', 'Autorización de Zonas de Navegación a Rol', @w_prod_name) 
select @id_pz_id = isnull(max(pz_id),0) + 1 from an_page_zone 
insert into an_page_zone values (@id_pz_id, 1, @w_la_id + 1, @w_pa_id, @w_co_id, 1, 100, 100, null,'horizontal', 0, 1, null)

--Registro de asociaciones con el Rol ADMINISTRADOR con Component y Page'
if @w_rol is null
    print 'No se encontro id de Rol Administrador'
else
begin
	insert into an_role_component (rc_co_id, rc_rol) values (@w_co_id, @w_rol)
	insert into an_role_page values (@w_pa_id, @w_rol)
end

-----------------------------------------------
print 'Pagina de Autorización de Paginas a Rol'
select @w_co_id = isnull(max(co_id),0) + 1 from an_component
select @w_la_id = isnull(max(la_id),0) + 1 from an_label
select @w_pa_id = isnull(max(pa_id),0) + 1 from an_page

insert into an_component values (@w_co_id, @w_mo_id_aut, 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View.ModuleRolPageView', 'ModuleRolPageView', 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View', 'SV', null, @w_prod_name)
insert into an_label values (@w_la_id, 'ES_EC', 'Páginas por Rol', @w_prod_name) 
insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id) values (@w_pa_id, @w_la_id, 'PagAdminAPR', null, @w_pa_id_paut, 4, 'horizontal', 'PADM-2.4', @w_prod_name, null, null)

insert into an_label values (@w_la_id + 1, 'ES_EC', 'Autorización de Páginas Rol', @w_prod_name) 
select @id_pz_id = isnull(max(pz_id),0) + 1 from an_page_zone 
insert into an_page_zone values (@id_pz_id, 1, @w_la_id + 1, @w_pa_id, @w_co_id, 1, 100, 100, null,'horizontal', 0, 1, null)

--Registro de asociaciones con el Rol ADMINISTRADOR con Component y Page'
if @w_rol is null
    print 'No se encontro id de Rol Administrador'
else
begin
	insert into an_role_component (rc_co_id, rc_rol) values (@w_co_id, @w_rol)
	insert into an_role_page values (@w_pa_id, @w_rol)
end

------------------------------------------------------------
print 'Pagina de Autorización de Ejecutable a Usuario - Rol'
select @w_co_id = isnull(max(co_id),0) + 1 from an_component
select @w_la_id = isnull(max(la_id),0) + 1 from an_label
select @w_pa_id = isnull(max(pa_id),0) + 1 from an_page

insert into an_component values (@w_co_id, @w_mo_id_aut, 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View.ModuleUserRolExeView', 'ModuleUserRolExeView', 'COBISCorp.eCOBIS.Admin.Security.AdminCen.View', 'SV', null, @w_prod_name)
insert into an_label values (@w_la_id, 'ES_EC', 'Ejecutables por Usuario - Rol', @w_prod_name) 
insert into an_page (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id) values (@w_pa_id, @w_la_id, 'PagAdminEUR', null, @w_pa_id_paut, 5, 'horizontal', 'PADM-2.5', @w_prod_name, null, null)

insert into an_label values (@w_la_id + 1, 'ES_EC', 'Autorización de Ejecutables a Usuario - Rol', @w_prod_name) 
select @id_pz_id = isnull(max(pz_id),0) + 1 from an_page_zone 
insert into an_page_zone values (@id_pz_id, 1, @w_la_id + 1, @w_pa_id, @w_co_id, 1, 100, 100, null,'horizontal', 0, 1, null)

--Registro de asociaciones con el Rol ADMINISTRADOR con Component y Page'
if @w_rol is null
    print 'No se encontro id de Rol Administrador'
else
begin
	insert into an_role_component (rc_co_id, rc_rol) values (@w_co_id, @w_rol)
	insert into an_role_page values (@w_pa_id, @w_rol)
end
go

-----------
print 'FIN'



go
