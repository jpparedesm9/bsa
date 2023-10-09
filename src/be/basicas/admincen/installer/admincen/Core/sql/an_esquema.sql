/************************************************************************/
/*  Archivo:        an_esquema.sql                                      */
/*  Base de datos:  cobis                                               */
/*  Producto:       COBIS Explorer . Net                                */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  Cobiscorp.                                                          */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.              */
/************************************************************************/
/*                          PROPOSITO                                   */
/*  Creacion de objetos de la base. Comprende: tablas, claves primarias */
/*  e indices                                                           */
/************************************************************************/
/*                       MODIFICACIONES                                 */
/*    FECHA        AUTOR                     RAZON                      */
/* 27/jul/2009  S. Paredes      Emision Inicial                         */
/* 01/sep/2009  S. Paredes      Modif. indice an_page_zone_pk           */
/* 03/sep/2009  S. Paredes      Agregar tabla compatibilidad COM        */
/* 19/nov/2009  S. Paredes      Agregar tabla asocia user, rol y        */
/*                              ejecutable                              */
/* 17/feb/2010  S. Paredes      Anadir indices nuevos                   */
/* 25/Feb/2010  S. Soto         Ajustes en estrucutras:                 */
/*                              Modifica indice unico an_page_zone_pk   */ 
/*                              Se crea indice an_page_zone_i1          */
/*                              Aumenta mo_name y mg_name a varchar(64) */
/*                              Disminuye *_prod_name a varchar(10)     */
/*                              Nuevo campo an_page_zone.pz_id          */
/*                              Elimina campo pp_page y se crea pp_pa_id*/
/*                              Modifica indice an_prereq_page_pk       */
/*                              Elimina campo zo_close_value            */ 
/* 05/mar/2010  S. Paredes      Agregar tablas para pseudocatalogo      */                
/* 16/mar/2010  S. Paredes      Agregar tablas para agentes             */
/* 09/abr/2010  S. Paredes      Homologacion con version de Soporte     */
/* 07/Jun/2010  S. Soto         Inclusion de nuevas tablas              */
/* 07/jun/2010  S. Calderón     Se añade campo mg_store_name a la       */
/*                              tabla an_module_group para manejar      */
/*                              un repositorio de aplicaciones a        */
/*                              través de clickonce                     */
/* 20/jul/2010  S. Paredes      Agr tablas para configura de serv       */
/*                              por oficina y dependencias              */
/*                              Agr indices y campos not null           */
/*                              Agr campo para query catalog            */
/* 04/Ago/2010  S. Paredes      Liberacion de CEN 4.0.0.5               */ 
/* 13/Ene/2014  M. Cabay        Se Agr tablas: an_cobisserver_webserver */
/*                              an_operation_component, an_transaction_ */
/*                              component, an_referenced_components,    */
/*                              an_cust_referenced_components, ts_adm_  */
/*                              seguridades(vista), ts_label (Vista).   */ 
/************************************************************************/

use cobis
go

print 'borra indice an_agent_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_agent')
            and   name  = 'an_agent_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_agent.an_agent_pk
go

print 'borra indice an_agent_i2'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_agent')
            and   name  = 'an_agent_i2'
            and   indid > 0
            and   indid < 255)
   drop index an_agent.an_agent_i2
go

print 'borra indice an_component_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_component')
            and   name  = 'an_component_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_component.an_component_pk
go

print 'borra indice an_component_i2'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_component')
            and   name  = 'an_component_i2'
            and   indid > 0
            and   indid < 255)
   drop index an_component.an_component_i2
go

print 'borra indice an_component_i3'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_component')
            and   name  = 'an_component_i3'
            and   indid > 0
            and   indid < 255)
   drop index an_component.an_component_i3
go

print 'borra indice an_component_i4'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_component')
            and   name  = 'an_component_i4'
            and   indid > 0
            and   indid < 255)
   drop index an_component.an_component_i4
go

print 'borra indice an_component_i5'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_component')
            and   name  = 'an_component_i5'
            and   indid > 0
            and   indid < 255)
   drop index an_component.an_component_i5
go

print 'borra indice an_label_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_label')
            and   name  = 'an_label_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_label.an_label_pk
go

print 'borra indice an_label_i2'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_label')
            and   name  = 'an_label_i2'
            and   indid > 0
            and   indid < 255)
   drop index an_label.an_label_i2
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_module')
            and   name  = 'an_module_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_module.an_module_pk
go

print 'borra indice an_module_i2'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_module')
            and   name  = 'an_module_i2'
            and   indid > 0
            and   indid < 255)
   drop index an_module.an_module_i2
go

print 'borra indice an_module_i3'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_module')
            and   name  = 'an_module_i3'
            and   indid > 0
            and   indid < 255)
   drop index an_module.an_module_i3
go

print 'borra indice an_module_group_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_module_group')
            and   name  = 'an_module_group_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_module_group.an_module_group_pk
go

print 'borra indice an_navigation_zone_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_navigation_zone')
            and   name  = 'an_navigation_zone_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_navigation_zone.an_navigation_zone_pk
go

print 'borra indice an_page_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_page')
            and   name  = 'an_page_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_page.an_page_pk
go

print 'borra indice an_page_i2'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_page')
            and   name  = 'an_page_i2'
            and   indid > 0
            and   indid < 255)
   drop index an_page.an_page_i2
go

print 'borra indice an_page_i3'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_page')
            and   name  = 'an_page_i3'
            and   indid > 0
            and   indid < 255)
   drop index an_page.an_page_i3
go

print 'borra indice an_page_i4'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_page')
            and   name  = 'an_page_i4'
            and   indid > 0
            and   indid < 255)
   drop index an_page.an_page_i4
go

print 'borra indice an_page_i5'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_page')
            and   name  = 'an_page_i5'
            and   indid > 0
            and   indid < 255)
   drop index an_page.an_page_i5
go

print 'borra indice an_page_zone_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_page_zone')
            and   name  = 'an_page_zone_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_page_zone.an_page_zone_pk
go

print 'borra indice an_page_zone_i1'
--SSO; 25-02-2010
if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_page_zone')
            and   name  = 'an_page_zone_i1'
            and   indid > 0
            and   indid < 255)
   drop index an_page_zone.an_page_zone_i1
go

print 'borra indice an_page_zone_i2'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_page_zone')
            and   name  = 'an_page_zone_i2'
            and   indid > 0
            and   indid < 255)
   drop index an_page_zone.an_page_zone_i2
go
   
print 'borra indice an_page_zone_i3'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_page_zone')
            and   name  = 'an_page_zone_i3'
            and   indid > 0
            and   indid < 255)
   drop index an_page_zone.an_page_zone_i3
go

print 'borra indice an_page_zone_i4'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_page_zone')
            and   name  = 'an_page_zone_i4'
            and   indid > 0
            and   indid < 255)
   drop index an_page_zone.an_page_zone_i4
go


print 'borra indice an_prereq_page_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_prereq_page')
            and   name  = 'an_prereq_page_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_prereq_page.an_prereq_page_pk
go

print 'borra indice an_query_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_query')
            and   name  = 'an_query_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_query.an_query_pk
go

print 'borra indice an_query_i2'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_query')
            and   name  = 'an_query_i2'
            and   indid > 0
            and   indid < 255)
   drop index an_query.an_query_i2
go

print 'borra indice an_query_action_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_query_action')
            and   name  = 'an_query_action_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_query_action.an_query_action_pk
go

print 'borra indice an_query_column_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_query_column')
            and   name  = 'an_query_column_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_query_column.an_query_column_pk
go

print 'borra indice an_query_component_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_query_component')
            and   name  = 'an_query_component_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_query_component.an_query_component_pk
go

print 'borra indice an_role_agent_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_role_agent')
            and   name  = 'an_role_agent_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_role_agent.an_role_agent_pk
go
print 'borra indice an_role_component_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_role_component')
            and   name  = 'an_role_component_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_role_component.an_role_component_pk
go


print 'borra indice an_role_module_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_role_module')
            and   name  = 'an_role_module_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_role_module.an_role_module_pk
go

print 'borra indice an_role_navigation_zone_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_role_navigation_zone')
            and   name  = 'an_role_navigation_zone_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_role_navigation_zone.an_role_navigation_zone_pk
go

print 'borra indice an_role_page_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_role_page')
            and   name  = 'an_role_page_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_role_page.an_role_page_pk
go

print 'borra indice an_user_role_exe_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_user_role_exe')
            and   name  = 'an_user_role_exe_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_user_role_exe.an_user_role_exe_pk
go

print 'borra indice an_zone_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_zone')
            and   name  = 'an_zone_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_zone.an_zone_pk
go

print 'borra indice an_component_trn_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_component_trn')
            and   name  = 'an_component_trn_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_component_trn.an_component_trn_pk
go

print 'borra indice an_office_srv_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_office_srv')
            and   name  = 'an_office_srv_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_office_srv.an_office_srv_pk
go

print 'borra indice an_cobisserver_webserver_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_cobisserver_webserver')
            and   name  = 'an_cobisserver_webserver_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_cobisserver_webserver.an_cobisserver_webserver_pk
go

print 'borra indice an_help_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_help')
            and   name  = 'an_help_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_help.an_help_pk
go

print 'borra indice an_module_dependency_pk'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_module_dependency')
            and   name  = 'an_module_dependency_pk'
            and   indid > 0
            and   indid < 255)
   drop index an_module_dependency.an_module_dependency_pk
go

print 'borra indice an_module_dependency_i2'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_module_dependency')
            and   name  = 'an_module_dependency_i2'
            and   indid > 0
            and   indid < 255)
   drop index an_module_dependency.an_module_dependency_i2
go

print 'borra indice an_module_dependency_i3'

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.an_module_dependency')
            and   name  = 'an_module_dependency_i3'
            and   indid > 0
            and   indid < 255)
   drop index an_module_dependency.an_module_dependency_i3
go

------------------------------------------------------------
------------------------------------------------------------

print 'borra tabla an_agent'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_agent')
            and    type = 'U')
   drop table an_agent
go

print 'borra tabla an_component'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_component')
            and    type = 'U')
   drop table an_component
go

print 'borra tabla an_label'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_label')
            and    type = 'U')
   drop table an_label
go

print 'borra tabla an_module'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_module')
            and    type = 'U')
   drop table an_module
go

print 'borra tabla an_module_group'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_module_group')
            and    type = 'U')
   drop table an_module_group
go

print 'borra tabla an_navigation_zone'


if exists (select 1
            from  sysobjects
            where  id = object_id('an_navigation_zone')
            and    type = 'U')
   drop table an_navigation_zone
go


print 'borra tabla an_page'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_page')
            and    type = 'U')
   drop table an_page
go


print 'borra tabla an_page_zone'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_page_zone')
            and    type = 'U')
   drop table an_page_zone
go


print 'borra tabla an_prereq_page'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_prereq_page')
            and    type = 'U')
   drop table an_prereq_page
go

print 'borra tabla an_query'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_query')
            and    type = 'U')
   drop table an_query
go

print 'borra tabla an_query_action'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_query_action')
            and    type = 'U')
   drop table an_query_action
go

print 'borra tabla an_query_column'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_query_column')
            and    type = 'U')
   drop table an_query_column
go

print 'borra tabla an_query_component'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_query_component')
            and    type = 'U')
   drop table an_query_component
go

print 'borra tabla an_role_agent'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_role_agent')
            and    type = 'U')
   drop table an_role_agent
go
print 'borra tabla an_role_component'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_role_component')
            and    type = 'U')
   drop table an_role_component
go

print 'borra tabla an_role_module'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_role_module')
            and    type = 'U')
   drop table an_role_module
go

print 'borra tabla an_role_navigation_zone'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_role_navigation_zone')
            and    type = 'U')
   drop table an_role_navigation_zone
go

print 'borra tabla an_role_page'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_role_page')
            and    type = 'U')
   drop table an_role_page
go

print 'borra tabla an_user_role_exe'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_user_role_exe')
            and    type = 'U')
   drop table an_user_role_exe
go

print 'borra tabla an_zone'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_zone')
            and    type = 'U')
   drop table an_zone
go

print 'borra tabla an_component_trn'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_component_trn')
            and    type = 'U')
   drop table an_component_trn
go


print 'borra tabla an_office_srv'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_office_srv')
            and    type = 'U')
   drop table an_office_srv
go

print 'borra tabla an_cobisserver_webserver'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_cobisserver_webserver')
            and    type = 'U')
   drop table an_cobisserver_webserver
go

print 'borra tabla an_help'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_help')
            and    type = 'U')
   drop table an_help
go

print 'borra tabla an_module_dependency'

if exists (select 1
            from  sysobjects
            where  id = object_id('an_module_dependency')
            and    type = 'U')
   drop table an_module_dependency
go

print 'borra tabla an_module_dependency'

if exists (select 1 
           from sysobjects 
           where name = 'an_role_install'
           and    type = 'U')
   drop table an_role_install
go


/*==========================================================*/
/* Table: an_agent                                          */
/*==========================================================*/
print 'crea tabla an_agent'

create table an_agent (
   ag_id             int          not null,
   ag_co_id          int          not null,
   ag_name           varchar(50)  not null,
   ag_la_id          int          not null
)
go

/*====================================================*/
/* Index: an_agent_pk                                 */
/*====================================================*/
print 'crea indice an_agent_pk'

create unique clustered index an_agent_pk on dbo.an_agent (
ag_id  ASC
)

/*==============================================================*/
/* Index: an_agent_i2                                       */
/*==============================================================*/
print 'crea indice an_agent_i2'

create unique index an_agent_i2 on dbo.an_agent (
ag_name ASC
)
go


/*==============================================================*/
/* Table: an_component                                          */
/*==============================================================*/
print 'crea tabla an_component'

create table an_component (
   co_id                int                            not null,
   co_mo_id             int                            not null,
   co_name              varchar(255)                   null,
   co_class             varchar(255)                    null,
   co_namespace         varchar(255)                   null,
   co_ct_id             char(10)                       null,
   co_arguments         varchar(255)                   null,
   co_prod_name         varchar(10)                    null
)
go


/*====================================================*/
/* Index: an_component_pk                             */
/*====================================================*/
print 'crea indice an_component_pk'

create unique clustered index an_component_pk on dbo.an_component (
co_id  ASC
)
go


/*==============================================================*/
/* Index: an_component_i2                                       */
/*==============================================================*/
print 'crea indice an_component_i2'

create index an_component_i2 on dbo.an_component (
co_mo_id ASC
)
go

/*==============================================================*/
/* Index: an_component_i3                                      */
/*==============================================================*/
print 'crea indice an_component_i3'

create unique index an_component_i3 on dbo.an_component (
co_name ASC
)
go

/*==============================================================*/
/* Index: an_component_i4                                      */
/*==============================================================*/
print 'crea indice an_component_i4'

create index an_component_i4 on dbo.an_component (
co_prod_name ASC
)
go


/*==============================================================*/
/* Index: an_component_i5                                     */
/*==============================================================*/
print 'crea indice an_component_i5'

create index an_component_i5 on dbo.an_component (
co_class  ASC,
co_namespace ASC
)
go


/*==============================================================*/
/* Table: an_label                                              */
/*==============================================================*/
print 'crea tabla an_label'

create table an_label (
   la_id                int                            not null,
   la_cod               varchar(10)                    null,
   la_label             varchar(100)                   null,
   la_prod_name         varchar(10)                    null
)
go


/*====================================================*/
/* Index: an_label_pk                                 */
/*====================================================*/
print 'crea indice an_label_pk'

create unique clustered index an_label_pk on dbo.an_label (
la_id  ASC,
la_cod ASC
)
go


/*====================================================*/
/* Index: an_label_i2                                 */
/*====================================================*/
print 'crea indice an_label_i2'

create index an_label_i2 on dbo.an_label (
la_prod_name   ASC
)
go



/*==============================================================*/
/* Table: an_module                                             */
/*==============================================================*/
print 'crea tabla an_module'

create table an_module (
   mo_id                int                            not null,
   mo_mg_id             int                            not null,
   mo_la_id             int                            not null,
   mo_name              varchar(64)                    null,
   mo_filename          varchar(255)                   null,
   mo_id_parent         int                            null,
   mo_key_token         varchar(255)                   null
)
go

/*====================================================*/
/* Index: an_module_pk                                */
/*====================================================*/
print 'crea indice an_module_pk'

create unique clustered index an_module_pk on dbo.an_module (
mo_id  ASC
)
go


/*==============================================================*/
/* Index: an_module_i2                                          */
/*==============================================================*/
print 'crea indice an_module_i2'

create index an_module_i2 on dbo.an_module (
mo_mg_id ASC
)
go

/*==============================================================*/
/* Index: an_module_i3                                          */
/*==============================================================*/
print 'crea indice an_module_i3'

create index an_module_i3 on dbo.an_module (
mo_la_id ASC
)
go

/*==============================================================*/
/* Table: an_module_group                                       */
/*==============================================================*/
print 'crea tabla an_module_group'

create table an_module_group (
   mg_id                int                            not null,
   mg_name              varchar(64)                    null,
   mg_version           varchar(15)                    null,
   mg_location          varchar(255)                   null,
   mg_store_name        varchar(40)                    null
)
go

/*====================================================*/
/* Index: an_module_group_pk                          */
/*====================================================*/
print 'crea indice an_module_group_pk'

create unique clustered index an_module_group_pk on dbo.an_module_group (
mg_id  ASC
)
go

/*==============================================================*/
/* Table: an_navigation_zone                                    */
/*==============================================================*/
print 'crea tabla an_navigation_zone'

create table an_navigation_zone (
   nz_id                int                            not null,
   nz_la_id             int                            not null,
   nz_co_id             int                            not null,
   nz_name              varchar(40)                    null,
   nz_icon              varchar(40)                    null,
   nz_order             int                            null
)
go

/*====================================================*/
/* Index: an_navigation_zone_pk                       */
/*====================================================*/
print 'crea indice an_navigation_zone_pk'

create unique clustered index an_navigation_zone_pk on dbo.an_navigation_zone (
nz_id  ASC
)
go

/*==============================================================*/
/* Table: an_page                                               */
/*==============================================================*/
print 'crea tabla an_page'

create table an_page (
   pa_id                int                            not null,
   pa_la_id             int                            not null,
   pa_name              varchar(40)                    null,
   pa_icon              varchar(40)                    null,
   pa_id_parent         int                            not null,
   pa_order             int                            null,
   pa_splitter          varchar(20)                    null,
   pa_nemonic           varchar(40)                    null,
   pa_prod_name         varchar(10)                    null,
   pa_arguments         varchar(255)                   null, 
   pa_he_id             int                            null,
   pa_visible           int             default 1      not null
)
go

/*====================================================*/
/* Index: an_page_pk                                  */
/*====================================================*/
print 'crea indice an_page_pk'

create unique clustered index an_page_pk on dbo.an_page (
pa_id  ASC
)
go
/*====================================================*/
/* Index: an_page_i2                                  */
/*====================================================*/
print 'crea indice an_page_i2'

create unique index an_page_i2 on dbo.an_page (
pa_name  ASC
)
go
/*====================================================*/
/* Index: an_page_i3                                  */
/*====================================================*/
print 'crea indice an_page_i3'

create index an_page_i3 on dbo.an_page (
pa_prod_name  ASC
)
go

/*====================================================*/
/* Index: an_page_i4                                  */
/*====================================================*/
print 'crea indice an_page_i4'

create index an_page_i4 on dbo.an_page (
pa_he_id  ASC
)
go

/*====================================================*/
/* Index: an_page_i5                                  */
/*====================================================*/
print 'crea indice an_page_i5'

create index an_page_i5 on dbo.an_page (
pa_id_parent  ASC
)

go
/*==============================================================*/
/* Table: an_page_zone                                          */
/*==============================================================*/
print 'crea tabla an_page_zone'

create table an_page_zone (
   pz_id                int                            not null, --SSO; 25-02-2010
   pz_zo_id             int                            not null,
   pz_la_id             int                            not null,
   pz_pa_id             int                            not null,
   pz_co_id             int                            not null,
   pz_order             int                            null,
   pz_hor_size          int                            null,
   pz_ver_size          int                            null,
   pz_icon              varchar(40)                    null,
   pz_split_style       varchar(20)                    null,
   pz_id_parent         int                            null,
   pz_component_optional tinyint                       null, 
   pz_he_id             int                            null
)
go

/*====================================================*/
/* Index: an_page_zone_pk                             */
/*====================================================*/
print 'crea indice an_page_zone_pk'
--SSO; 25-02-2010; 
create unique clustered index an_page_zone_pk on dbo.an_page_zone (
pz_id ASC
)
go

/*====================================================*/
/* Index: an_page_zone_i1                             */
/*====================================================*/
print 'crea indice an_page_zone_i1'
--SSO; 25-02-2010, cambiar el orden de los campos y eliminar campos pz_la_id y pz_zo_id
create index an_page_zone_i1 on dbo.an_page_zone (
pz_co_id ASC,
pz_pa_id ASC 
)
go

/*==============================================================*/
/* Index: an_page_zone_i2                                       */
/*==============================================================*/
print 'crea indice an_page_zone_i2'

create index an_page_zone_i2 on dbo.an_page_zone (
pz_pa_id ASC
)
go

/*==============================================================*/
/* Index: an_page_zone_i3                                       */
/*==============================================================*/
print 'crea indice an_page_zone_i3'

create index an_page_zone_i3 on dbo.an_page_zone (
pz_co_id ASC
)
go

/*==============================================================*/
/* Index: an_page_zone_i4                                       */
/*==============================================================*/
print 'crea indice an_page_zone_i4'

create index an_page_zone_i4 on dbo.an_page_zone (
   pz_he_id ASC
)
go

/*==============================================================*/
/* Table: an_prereq_page                                        */
/*==============================================================*/
print 'crea tabla an_prereq_page'
--SSO; 25-02-2010
create table an_prereq_page (
   pp_pa_id        integer  not null,
   pp_prereq       varchar(10)  not null
)
go

/*====================================================*/
/* Index: an_prereq_page_pk                        */
/*====================================================*/
print 'crea indice an_prereq_page_pk'

create unique clustered index an_prereq_page_pk on dbo.an_prereq_page (
 pp_pa_id  ASC,
 pp_prereq ASC
)
go

/*==========================================================*/
/* Table: an_query                                          */
/*==========================================================*/
print 'crea tabla an_query'

create table an_query (
   qu_query_id       int            not null,
   qu_query_name     varchar(64)    not null,
   qu_dto_full_name  varchar(255)   not null
)
go

/*====================================================*/
/* Index: an_query_pk                                 */
/*====================================================*/
print 'crea indice an_query_pk'

create unique clustered index an_query_pk on dbo.an_query (
 qu_query_id  ASC
)
go

/*====================================================*/
/* Index: an_query_i2                                 */
/*====================================================*/
print 'crea indice an_query_i2'

create unique index an_query_i2 on dbo.an_query (
 qu_query_name  ASC
)
go

/*==========================================================*/
/* Table: an_query_action                                   */
/*==========================================================*/
print 'crea tabla an_query_action'

create table an_query_action (
    qa_query_id                int          not null,
    qa_type                    tinyint      not null,
    qa_is_input_dto_required   tinyint      not null,
    qa_method_name             varchar(32)  not null,
    qa_qc_id                   int          not null
)
go

/*====================================================*/
/* Index: an_query_action_pk                                 */
/*====================================================*/
print 'crea indice an_query_action_pk'

create unique clustered index an_query_action_pk on dbo.an_query_action (
 qa_query_id     ASC,
 qa_qc_id        ASC, 
 qa_method_name  ASC
)
go


/*==========================================================*/
/* Table: an_query_column                                   */
/*==========================================================*/
print 'crea tabla an_query_column'

create table an_query_column (
    cl_query_id            int         not null,
    cl_order               tinyint     not null,
    cl_la_id               int         not null,
    cl_datatype            char        not null,
    cl_name                varchar(32) not null,
    cl_width               int         not null,
    cl_allow_search        tinyint     not null,
    cl_is_id               tinyint     not null,
    cl_is_description      tinyint     not null, 
    cl_catalog_table       varchar(32) null
)
go

/*====================================================*/
/* Index: an_query_column_pk                          */
/*====================================================*/
print 'crea indice an_query_column_pk'

create unique clustered index an_query_column_pk on dbo.an_query_column (
  cl_query_id ASC, 
  cl_name     ASC
)
go


/*==========================================================*/
/* Table: an_query_component                                */
/*==========================================================*/
print 'crea tabla an_query_component'

create table an_query_component (
    qc_id                        int           not null,
    qc_interface_full_name       varchar(255)  not null,
    qc_implementation_full_name  varchar(255)  not null
)
go

/*====================================================*/
/* Index: an_query_component_pk                       */
/*====================================================*/
print 'crea indice an_query_component_pk'

create unique clustered index an_query_component_pk on dbo.an_query_component (
 qc_id  ASC
)
go

/*==========================================================*/
/* Table: an_role_agent                                     */
/*==========================================================*/
print 'crea tabla an_role_agent '

create table an_role_agent (
   ra_ag_id           int     not null,
   ra_rol             int     not null,
   ra_order           int     not null
)
go

/*================================================*/
/* Index: an_role_agent_pk                        */
/*================================================*/
print 'crea indice an_role_agent_pk'

create unique clustered index an_role_agent_pk on dbo.an_role_agent (
 ra_ag_id  ASC,
 ra_rol ASC,
 ra_order ASC
)
go

/*==============================================================*/
/* Table: an_role_component                                     */
/*==============================================================*/
print 'crea tabla an_role_component'

create table an_role_component (
   rc_co_id             int            not null,
   rc_rol               tinyint        not null
)
go

/*====================================================*/
/* Index: an_role_component_pk                        */
/*====================================================*/
print 'crea indice an_role_component_pk'

create unique clustered index an_role_component_pk on dbo.an_role_component (
 rc_co_id  ASC,
 rc_rol ASC
)
go

/*==============================================================*/
/* Table: an_role_module                                        */
/*==============================================================*/
print 'crea tabla an_role_module'

create table an_role_module (
   rm_mo_id             int                      not null,
   rm_rol               tinyint                  not null
)
go

/*====================================================*/
/* Index: an_role_module_pk                           */
/*====================================================*/
print 'crea indice an_role_module_pk'

create unique clustered index an_role_module_pk on dbo.an_role_module (
rm_mo_id  ASC,
rm_rol ASC
)
go

/*==============================================================*/
/* Table: an_role_navigation_zone                               */
/*==============================================================*/
print 'crea tabla an_role_navigation_zone'

create table an_role_navigation_zone (
   rn_rol               tinyint                 not null,
   rn_nz_id             int                     not null
)
go

/*====================================================*/
/* Index: an_role_navigation_zone_pk                  */
/*====================================================*/
print 'crea indice an_role_navigation_zone_pk'

create unique clustered index an_role_navigation_zone_pk on dbo.an_role_navigation_zone (
rn_rol  ASC,
rn_nz_id ASC
)
go

/*==============================================================*/
/* Table: an_role_page                                          */
/*==============================================================*/
print 'crea tabla an_role_page'

create table an_role_page (
   rp_pa_id             int                   not null,
   rp_rol               tinyint               not null
)
go

/*====================================================*/
/* Index: an_role_page_pk                             */
/*====================================================*/
print 'crea indice an_role_page_pk'

create unique clustered index an_role_page_pk on dbo.an_role_page (
rp_pa_id  ASC,
rp_rol ASC
)
go


/*==============================================================*/
/* Table: an_user_role_exe                                      */
/*==============================================================*/
print 'crea tabla an_user_role_exe'

create table an_user_role_exe (
   ur_user             varchar(30)           not null,
   ur_role             tinyint               not null,
   ur_mo_id            int                   not null
)
go

/*====================================================*/
/* Index: an_user_role_exe_pk                         */
/*====================================================*/
print 'crea indice an_user_role_exe_pk'

create unique clustered index an_user_role_exe_pk on dbo.an_user_role_exe (
ur_user  ASC,
ur_role  ASC,
ur_mo_id ASC
)
go

/*==============================================================*/
/* Table: an_zone                                               */
/*==============================================================*/
print 'crea tabla an_zone'

create table an_zone (
   zo_id                int                      not null,
   zo_name              varchar(40)              not null,
   zo_pin_visible       tinyint                  not null,
   zo_close_visible     tinyint                  not null,
   zo_title_visible     tinyint                  not null,
   zo_pin_value         tinyint                  not null
)
go

/*====================================================*/
/* Index: an_zone_pk                                  */
/*====================================================*/
print 'crea indice an_zone_pk'

create unique clustered index an_zone_pk on dbo.an_zone (
zo_id  ASC
)
go

/*====================================================*/
/* Table: an_component_trn                            */
/*====================================================*/
print 'crea tabla an_component_trn'

create table an_component_trn
(
ct_co_id    int not null,
ct_trn      int not null
)
go

/*====================================================*/
/* Index: an_component_trn_pk                         */
/*====================================================*/
print 'crea indice an_component_trn_pk'

create unique clustered index an_component_trn_pk on dbo.an_component_trn (
ct_co_id ASC,
ct_trn  ASC
)
go


/*====================================================*/
/* Table: an_office_srv                               */
/*====================================================*/
print 'crea tabla an_office_srv'

create table an_office_srv
(
os_office_id    int,
os_srv_name     varchar(64)
)
go

/*====================================================*/
/* Index: an_office_srv_pk                            */
/*====================================================*/
print 'crea indice an_office_srv_pk'

create unique clustered index an_office_srv_pk on dbo.an_office_srv (
os_office_id  ASC
)
go

/*====================================================*/
/* Table: an_cobisserver_webserver                               */
/*====================================================*/
print 'crea tabla an_cobisserver_webserver'

create table an_cobisserver_webserver
(
cw_cobisserver   varchar(30),
cw_webserver     varchar(30)
)
go

/*====================================================*/
/* Index: an_cobisserver_webserver_pk                            */
/*====================================================*/
print 'crea indice an_cobisserver_webserver_pk'

create unique clustered index an_cobisserver_webserver_pk on dbo.an_cobisserver_webserver (
cw_cobisserver  ASC
)
go


/*==============================================================*/
/* Table: an_help                                               */
/*==============================================================*/
print 'crea tabla an_help'

create table an_help  (
   he_id    int           not null,
   he_url   varchar(255)  not null
  )
go

/*====================================================*/
/* Index: an_help_pk                                  */
/*====================================================*/
print 'crea indice an_help_pk'

create unique clustered index an_help_pk on dbo.an_help (
he_id ASC
)
go


/*==============================================================*/
/* Table: an_module_dependency                                  */
/*==============================================================*/
print 'crea tabla an_module_dependency'

create table an_module_dependency (
   md_mo_id             int      not null,
   md_dependency_id     int      not null
)
go

/*====================================================*/
/* Index: an_module_dependency_pk                     */
/*====================================================*/
print 'crea indice an_module_dependency_pk'

create unique clustered index an_module_dependency_pk on dbo.an_module_dependency (
md_mo_id  ASC,
md_dependency_id ASC
)
go

/*====================================================*/
/* Index: an_module_dependency_i2                     */
/*====================================================*/
print 'crea indice an_module_dependency_i2'

create index an_module_dependency_i2 on dbo.an_module_dependency (
md_mo_id  ASC
)
go

/*====================================================*/
/* Index: an_module_dependency_i3                     */
/*====================================================*/
print 'crea indice an_module_dependency_i3'

create index an_module_dependency_i3 on dbo.an_module_dependency (
md_dependency_id  ASC
)
go

print 'crea tabla an_role_install'

create table an_role_install(
   ri_prod_name     varchar(20),
   ri_role          int
)
go

print 'Fin de creacion de estructuras'
go

