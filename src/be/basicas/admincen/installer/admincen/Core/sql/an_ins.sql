/************************************************************************/
/*  Archivo:        an_ins.sql                                          */
/*  Base de datos:  cobis                                               */
/*  Producto:       COBIS Explorer . Net                                */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  Cobiscorp.                                                          */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de Cobiscorpo su representante.               */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Insercion de datos iniciales en las estructuras admin               */
/*      Para cobis explorer .net                                        */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/* 27/jul/2009         S. Paredes       Emision Inicial                 */
/* 11/Feb/2010         S. Soto          Ajustes al script               */
/* 31/mar/2010         S. Soto          Uso de prod_name CEN            */
/* 13/Ene/2014         M. Cabay         Se agrega Zona Vista Unica      */
/************************************************************************/

use cobis 
go
/***********************************/
/* REGISTRO DE CATALOGO an_culture */
/***********************************/
declare @w_tabla integer

print 'Borra registros de catalogo an_culture'  
select @w_tabla = isnull(codigo, 0) from cl_tabla where tabla = 'an_culture'

if @w_tabla > 0
begin
    delete cl_catalogo where tabla = @w_tabla 
    delete cl_catalogo_pro where cp_tabla = @w_tabla 
    delete cl_tabla where codigo = @w_tabla 
end
go

print 'Creacion de datos de catalogo an_culture'
declare @w_sig_tabla int

exec sp_cseqnos
     @i_tabla = 'cl_tabla',
     @o_siguiente = @w_sig_tabla out

--Registro de tabla en cl_tabla
insert into cl_tabla    (codigo, tabla, descripcion)
        values  (@w_sig_tabla, 'an_culture', 'CULTURAS - ADMIN .NET')

-- Insercion de datos de catalogos en cl_catalago
insert into cl_catalogo (tabla, codigo, valor, estado)
        values  (@w_sig_tabla, 'EN_EC', 'INGLES - ECUADOR', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
        values  (@w_sig_tabla, 'ES_EC', 'ESPANOL - ECUADOR', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
        values  (@w_sig_tabla, 'EN_US', 'INGLES - EEUU', 'V')

--Asociacion de tabla al producto en cl_catalogo_pro
insert into cl_catalogo_pro (cp_producto, cp_tabla) 
       values ('ADM',@w_sig_tabla)
go


/******************************************/
/* REGISTRO DE CATALOGO an_product        */
/******************************************/
declare @w_tabla integer

print 'Borra registros de catalogo an_product'  
select @w_tabla = isnull(codigo, 0) from cl_tabla where tabla = 'an_product'

if @w_tabla > 0
begin
    delete cl_catalogo where tabla = @w_tabla 
    delete cl_catalogo_pro where cp_tabla = @w_tabla 
    delete cl_tabla where codigo = @w_tabla 
end
go

print 'Creacion de datos de catalogo an_product'
declare @w_sig_tabla int

exec sp_cseqnos
     @i_tabla = 'cl_tabla',
     @o_siguiente = @w_sig_tabla out

--Registro de tabla en cl_tabla
insert into cl_tabla    (codigo, tabla, descripcion)
        values  (@w_sig_tabla, 'an_product', 'PRODUCTOS REGISTRADOS EN CEN')

-- OJO: Faltan definir los registros de este catalogo (FLO)
-- Insercion de datos de catalogos en cl_catalago
insert into cl_catalogo (tabla, codigo, valor, estado)
        values  (@w_sig_tabla, 'ADMIN', 'ADMINISTRACION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
        values  (@w_sig_tabla, 'CEN', 'COBIS EXPLORER .NET', 'V')

--Asociacion de tabla al producto en cl_catalogo_pro
insert into cl_catalogo_pro (cp_producto, cp_tabla) 
       values ('ADM',@w_sig_tabla)
go

/******************************************/
/* REGISTRO DE CATALOGO an_component_type */
/******************************************/
declare @w_tabla integer

print 'Borra registros de catalogo an_component_type'
select @w_tabla = isnull(codigo, 0) from cl_tabla where tabla = 'an_component_type'
if @w_tabla > 0
begin
    delete cl_catalogo where tabla = @w_tabla 
    delete cl_catalogo_pro where cp_tabla = @w_tabla 
    delete cl_tabla where codigo = @w_tabla 
end
go

print 'Creacion de datos de catalogo an_component_type'
declare @w_sig_tabla int

exec sp_cseqnos
     @i_tabla = 'cl_tabla',
     @o_siguiente = @w_sig_tabla out

--Registro de tabla en cl_tabla
insert into cl_tabla    (codigo, tabla, descripcion)
        values  (@w_sig_tabla, 'an_component_type', 'TIPOS DE COMPONENTES - ADMIN .NET')

-- Insercion de datos de catalogos en cl_catalago
insert into cl_catalogo (tabla, codigo, valor, estado)
        values  (@w_sig_tabla, 'OW', 'Office Word', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
        values  (@w_sig_tabla, 'OE', 'Office Excel', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
        values  (@w_sig_tabla, 'V', 'Vista Normal', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
        values  (@w_sig_tabla, 'I', 'Pagina Web', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
        values  (@w_sig_tabla, 'W', 'Flujo', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
        values  (@w_sig_tabla, 'SV', 'Vista Apilada', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado)
        values  (@w_sig_tabla, 'E', 'Ejecutable', 'V')

--Asociacion de tabla al producto en cl_catalogo_pro
insert into cl_catalogo_pro (cp_producto, cp_tabla) 
       values ('ADM',@w_sig_tabla)

go

/**********************************/
/* PARAMETROS GENERALES PARA CEN  */
/**********************************/
--OJO: Hasta que se defina el parametro @s_ para cultura
if exists (select 1 from cl_parametro where pa_nemonico = 'CEAN' and pa_producto = 'ADM')
    delete from cl_parametro where pa_nemonico = 'CEAN' and pa_producto = 'ADM'

insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_char, pa_producto)
values ('CEAN', 'CULTURA DEFAULT PARA ETIQUETAS EN ADMIN .NET', 'C', 'ES_EC' , 'ADM')

go


/**************************************/
/* REGISTRO DE DATOS DE CARGA INICIAL */
/**************************************/

print 'Eliminacion de datos iniciales en an_label'
delete from an_label where la_prod_name = 'CEN'
go

print 'Insercion de datos iniciales an_label'
insert into an_label (la_id, la_cod, la_label, la_prod_name) values (1, 'ES_EC', 'Menú de Funcionalidades', 'CEN')  
go
insert into an_label (la_id, la_cod, la_label, la_prod_name) values (2, 'ES_EC', 'Favoritos', 'CEN')  
go
insert into an_label (la_id, la_cod, la_label, la_prod_name) values (3, 'ES_EC', 'Ayuda', 'CEN')  
go
insert into an_label (la_id, la_cod, la_label, la_prod_name) values (1, 'EN_EC', 'Functionality Options', 'CEN')  
go
insert into an_label (la_id, la_cod, la_label, la_prod_name) values (2, 'EN_EC', 'Favorites', 'CEN')  
go
insert into an_label (la_id, la_cod, la_label, la_prod_name) values (3, 'EN_EC', 'Help', 'CEN')  
go
insert into an_label (la_id, la_cod, la_label, la_prod_name) values (1, 'EN_US', 'Functionality Options', 'CEN')  
go
insert into an_label (la_id, la_cod, la_label, la_prod_name) values (2, 'EN_US', 'Favorites', 'CEN')  
go
insert into an_label (la_id, la_cod, la_label, la_prod_name) values (3, 'EN_US', 'Help', 'CEN')  
go

print 'Eliminacion de datos iniciales en an_module_group'
delete from an_module_group where mg_id in (1, 2)
go

print 'Insercion de datos iniciales an_module_group '
insert into an_module_group (mg_id, mg_name, mg_version, mg_location) 
values (1,'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage','4.0.0','Ninguno')
go
insert into an_module_group (mg_id, mg_name, mg_version, mg_location) 
values (2,'COBISCorp.eCOBIS.COBISExplorer.Help','4.0.0','Ninguno')
go

print 'Eliminacion de datos iniciales en an_module'
delete from an_module where mo_id in (1, 2)
go

print 'Insercion de datos iniciales an_module '    
insert into an_module (mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token) 
values (1, 1, 1, 'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage', 'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage.dll', 0, '9b8bba00b1313138')
go
insert into an_module (mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token) 
values (2, 2, 3, 'COBISCorp.eCOBIS.COBISExplorer.Help', 'COBISCorp.eCOBIS.COBISExplorer.Help.dll', 0, '9b8bba00b1313138')
go

print 'Eliminacion de datos iniciales en an_component'
delete from an_component where co_prod_name = 'CEN'
go

print 'Insercion de datos iniciales an_component '
insert into an_component(co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments, co_prod_name)
values (1,1,'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage.COBISNavigationPageView','COBISNavigationPageView','COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage','V','', 'CEN')            
go
insert into an_component(co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments, co_prod_name)
values (2,1,'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage.COBISFavoritesView','COBISFavoritesView','COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage','V','', 'CEN')            
go
insert into an_component(co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments, co_prod_name)
values (3,2,'COBISCorp.eCOBIS.COBISExplorer.Help.View.COBISHelpView','COBISHelpView','COBISCorp.eCOBIS.COBISExplorer.Help.View','V','', 'CEN')            
go

print 'Eliminacion de datos iniciales en an_navigation_zone'
delete from an_navigation_zone where nz_id in (1, 2, 3)
go

print 'Insercion de datos para Zonas de navegacion generales '
insert into an_navigation_zone (nz_id, nz_la_id, nz_co_id, nz_name, nz_icon, nz_order) 
values (1, 1, 1, 'NavigationPageZone', '', 1)
go
insert into an_navigation_zone (nz_id, nz_la_id, nz_co_id, nz_name, nz_icon, nz_order) 
values (2, 2, 2, 'FavoritesZone', '', 2)
go
insert into an_navigation_zone (nz_id, nz_la_id, nz_co_id, nz_name, nz_icon, nz_order) 
values (3, 3, 3, 'HelpZone', '', 3)
go

print 'Insercion asociaciones del Rol'
declare @w_rol int

select @w_rol = 3
--from cl_parametro
--where pa_nemonico='RACEN'

if @w_rol is null
    print 'No se encontro id de Rol Administrador'
else
    begin
      print 'Eliminacion de asociaciones anteriores'
      delete from an_role_navigation_zone where rn_rol = @w_rol and rn_nz_id in (1, 2, 3)
      delete from an_role_component where rc_rol = @w_rol and rc_co_id in (1, 2, 3)
      delete from an_role_module where rm_rol = @w_rol and rm_mo_id in (1, 2)

      print 'Registro de asociaciones con el Rol ADMINISTRADOR con Navigation Zone'
      insert into an_role_navigation_zone (rn_rol, rn_nz_id) values (@w_rol,1)
      insert into an_role_navigation_zone (rn_rol, rn_nz_id) values (@w_rol,2)
      insert into an_role_navigation_zone (rn_rol, rn_nz_id) values (@w_rol,3)

      print 'Registro de asociaciones con el Rol ADMINISTRADOR con Component'
      insert into an_role_component (rc_co_id, rc_rol) values (1, @w_rol)
      insert into an_role_component (rc_co_id, rc_rol) values (2, @w_rol)
      insert into an_role_component (rc_co_id, rc_rol) values (3, @w_rol)

      print 'Registro de asociaciones con el Rol ADMINISTRADOR con Module'
      insert into an_role_module (rm_mo_id, rm_rol) values (1, @w_rol)
      insert into an_role_module (rm_mo_id, rm_rol) values (2, @w_rol)
    end
go

/*************************/
/* INSERCION EN AN_ZONE  */
/*************************/

print 'Insercion de registros en an_zone'

truncate table an_zone
go

insert into an_zone values (1, 'Zona 1', 1,1,1,1)
insert into an_zone values (2, 'Zona 2', 1,1,1,0)
insert into an_zone values (3, 'Zona 3', 0,1,1,0)
insert into an_zone values (4, 'Zona 4', 1,0,1,1)
insert into an_zone values (5, 'Zona 5', 1,0,1,0)
insert into an_zone values (6, 'Zona 6', 0,0,1,0)
insert into an_zone values (7, 'Zona 7', 0,0,0,0)
insert into an_zone values (9, 'Zona Vista Unica', 1,0,0,1)

print 'Fin de script'
go


