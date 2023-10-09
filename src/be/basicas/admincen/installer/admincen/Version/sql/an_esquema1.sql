/************************************************************************/
/*  Archivo:        an_esquema1.sql                                     */
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
/* 01/10/2014           JTA     Se agrega tabla an_service_component    */
/* 24/03/2014      FOR          Ajustes                                 */
/************************************************************************/

use cobis
go

print 'borra indice an_menu_role_page_tmp_key1'

if exists (select 1 from sysindexes where name = 'an_menu_role_page_tmp_key1')
   drop index an_menu_role_page_tmp.an_menu_role_page_tmp_key1
go

print 'borra indice PK_an_operation_component'

if exists (select 1 from sysindexes where name = 'PK_an_operation_component')
   drop index an_operation_component.PK_an_operation_component
go

print 'borra indice PK_an_transaction_component'

if exists (select 1 from sysindexes where name = 'PK_an_transaction_component')
   drop index an_transaction_component.PK_an_transaction_component
go

print 'borra indice PK_an_service_component'

if exists (select 1 from sysindexes where name = 'PK_an_service_component')
   drop index an_service_component.PK_an_service_component
go

print 'borra indice PK_an_referenced_components'

if exists (select 1 from sysindexes where name = 'PK_an_referenced_components')
   drop index an_referenced_components.PK_an_referenced_components
go

print 'borra indice PK_an_cust_ref_components'

if exists (select 1 from sysindexes where name = 'PK_an_cust_ref_components')
   drop index an_cust_referenced_components.PK_an_cust_ref_components
go
------------------------------------------------------------

print 'borra tabla an_menu_role_page_tmp'

if not object_id('an_menu_role_page_tmp') is null
   drop table an_menu_role_page_tmp
go

print 'borra tabla an_operation_component'

if not object_id('an_operation_component') is null
   drop table an_operation_component 
go

print 'borra tabla an_transaction_component'

if not object_id('an_transaction_component') is null
   drop table an_transaction_component 
go

print 'borra tabla an_service_component'

if not object_id('an_service_component') is null
   drop table an_service_component 
go

print 'borra tabla an_referenced_components'

if not object_id('an_referenced_components') is null
   drop table an_referenced_components 
go

print 'borra tabla an_cust_referenced_components'
go

if exists(select 1 from sysobjects where name = 'an_cust_referenced_components')
   drop table an_cust_referenced_components
go

/*==========================================================*/
/* Table: an_menu_role_page_tmp                             */
/*==========================================================*/
print 'crea tabla an_menu_role_page_tmp'

create table an_menu_role_page_tmp(
   usuario      login,
   indice       int,
   id           varchar(255),
   id_etiqueta  int, 
   etiqueta     varchar(100),
   id_sup       varchar(255),
   prod_name    varchar(10),      
   tipo         char(1),       
   id_own       varchar(20),
   id_sup_own   int            null,
   rol1         tinyint        default 1, 
   rol2         tinyint        default 1,
   rol3         tinyint        default 1, 
   rol4         tinyint        default 1,
   rol5         tinyint        default 1, 
   rol6         tinyint        default 1,
   rol7         tinyint        default 1, 
   rol8         tinyint        default 1,
   rol9         tinyint        default 1, 
   rol10        tinyint        default 1,
   rol11        tinyint        default 1, 
   rol12        tinyint        default 1,
   rol13        tinyint        default 1, 
   rol14        tinyint        default 1,
   rol15        tinyint        default 1, 
   rol16        tinyint        default 1,
   rol17        tinyint        default 1, 
   rol18        tinyint        default 1,
   rol19        tinyint        default 1, 
   rol20        tinyint        default 1,
   visible      char(1)        null
)
go

/*====================================================*/
/* Index: an_menu_role_page_tmp_key1                  */
/*====================================================*/
print 'crea indice an_menu_role_page_tmp_key1'

create  nonclustered index an_menu_role_page_tmp_key1 on an_menu_role_page_tmp 
	(usuario,indice)
go

/*==========================================================*/
/* Table: an_operation_component                            */
/*==========================================================*/
print 'crea tabla an_operation_component'

create table an_operation_component (
   oc_co_id         int           NOT NULL,
   oc_nemonic       varchar(20)   NOT NULL,
   oc_la_id         int           NOT NULL,
   oc_description   varchar(255)  NULL,
   oc_control_type  varchar(10)   NOT NULL
)
go

/*====================================================*/
/* Index: an_menu_role_page_tmp_key1                  */
/*====================================================*/
print 'crea indice PK_an_operation_component'

create unique index PK_an_operation_component
on an_operation_component (oc_co_id,oc_nemonic)
go

/*==========================================================*/
/* Table: an_transaction_component                          */
/*==========================================================*/
print 'crea tabla an_transaction_component'

create table an_transaction_component (
   tc_co_id        int          NOT NULL,
   tc_tn_trn_code  int          NOT NULL,
   tc_oc_nemonic   varchar(20)  NULL   
)
go

/*==========================================================*/
/* Table: an_service_component                            */
/*==========================================================*/
print 'crea tabla an_service_component'

create table an_service_component (
   sc_co_id           int            NOT NULL,
   sc_csc_service_id  varchar(255)   NOT NULL,
   sc_oc_nemonic      varchar(20)    NULL   
)
go

/*====================================================*/
/* Index: an_menu_role_page_tmp_key1                  */
/*====================================================*/
print 'crea indice PK_an_transaction_component'

create unique index PK_an_transaction_component
on an_transaction_component (tc_co_id,tc_tn_trn_code,tc_oc_nemonic)
go

/*====================================================*/
/* Index: an_menu_role_page_tmp_key2                  */
/*====================================================*/
print 'crea indice PK_an_service_component'

create unique index PK_an_service_component
on an_service_component (sc_co_id,sc_csc_service_id,sc_oc_nemonic)
go

/*==========================================================*/
/* Table: an_referenced_components                          */
/*==========================================================*/
print 'crea tabla an_referenced_components'

create table an_referenced_components (
   rc_parent_co_id   int    NOT NULL,
   rc_child_co_id    int    NOT NULL,
   rc_la_id          int    NOT NULL,
)
go

/*====================================================*/
/* Index: an_menu_role_page_tmp_key1                  */
/*====================================================*/
print 'crea indice PK_an_referenced_components'

create unique index PK_an_referenced_components
on an_referenced_components (rc_parent_co_id,rc_child_co_id)
go

print '======> an_cust_referenced_components'
go
create table an_cust_referenced_components (
   cr_pa_id          int    NOT NULL,
   cr_co_id          int    NOT NULL,
   cr_child_co_id    int    NOT NULL
)
go
/*====================================================*/
/* Index: PK_an_cust_ref_components                  */
/*====================================================*/
print '=====> PK_an_cust_ref_components'
go
create unique index PK_an_cust_ref_components
on an_cust_referenced_components (cr_pa_id,cr_co_id,cr_child_co_id)
go

-----------------------------------------------------------------------------
-- View ts_transaccion: Acciones Administracion de Seguridades
-----------------------------------------------------------------------------
if not object_id ('ts_adm_seguridades') is null
   drop view ts_adm_seguridades
go
create view ts_adm_seguridades (
   secuencia, 
   tipo_transaccion, 
   clase, 
   fecha,
   oficina_s, 
   usuario, 
   terminal_s, 
   srv,
   lsrv,
   
   tipo_objeto,    --P-agina, C-omponente O-peracion
   id_objeto,      --Codigo del tipo de objeto
   id_objeto_padre,--Objeto Padre (Nodo Arbol)
   rol_autorizado  --codigo del rol al que se autoriza el objeto
)
as
select ts_secuencia, 
       ts_tipo_transaccion, 
       ts_clase, 
       ts_fecha,
       ts_ofi, 
       ts_user, 
       ts_term, 
       ts_srv, 
       ts_lsrv,
       
       ts_tipo, 
       ts_desc_larga,
       ts_direc,
       ts_int
from ad_tran_servicio
where ts_tipo_transaccion = 15373
   or ts_tipo_transaccion = 15374
go

-----------------------------------------------------------------------------
-- View ts_transaccion: Modificacion Labels
-----------------------------------------------------------------------------
if not object_id ('ts_label') is null
   drop view ts_label
go
create view ts_label (
   secuencia, 
   tipo_transaccion, 
   clase, 
   fecha,
   oficina_s, 
   usuario, 
   terminal_s, 
   srv,
   lsrv,
   
   id_label,       --Codigo del tipo de objeto
   label,          --Objeto Padre (Nodo Arbol)
   cultura
)
as
select ts_secuencia, 
       ts_tipo_transaccion, 
       ts_clase, 
       ts_fecha,
       ts_ofi, 
       ts_user, 
       ts_term, 
       ts_srv, 
       ts_lsrv,
       
       ts_int,
       ts_direc,
       ts_nombre_f_d
from ad_tran_servicio
where ts_tipo_transaccion = 15386
go

print 'Fin de creacion de estructuras'
go

