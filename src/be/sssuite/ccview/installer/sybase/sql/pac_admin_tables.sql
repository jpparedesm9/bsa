/********************************************************************/
/*  Archivo:            UCSP_Admin_tables.sql                       */
/*  Base de datos:      cob_pac                                     */
/*  Producto: UCSP                                                  */
/********************************************************************/
/*              IMPORTANTE                                          */
/*  Este programa es parte de los paquetes bancarios propiedad de   */
/*  'COBISCORPSA'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como      */
/*  cualquier alteracion o agregado hecho por alguno de sus         */
/*  usuarios sin el debido consentimiento por escrito de la         */
/*  Presidencia Ejecutiva de COBISCORPSA                            */
/********************************************************************/
/*              PROPOSITO                                           */
/*  Generar tablas para el administrador de la VCC                  */
/********************************************************************/
/*              MODIFICACIONES                                      */
/*   FECHA                 AUTOR                    RAZON           */
/*   21/Ene/2014      Aldo Benavides           Emision Inicial      */
/*   27/Mar/2014      Sergio Hidalgo	       Añadido a los Install*/ 
/*                                             de la VCC            */
/*   08/Ago/2015      Mariela Cabay           Generación Dinámica FE*/
/*********************************************************************/
use cob_pac
go

if not exists(select 1 from systypes where name = 'descripcion')
begin
    exec sp_addtype descripcion, 'varchar(64)', 'null'
end
go

if exists (select 1 
            from  sysobjects c 
            join  sysconstraints s on (s.constrid = c.id and s.tableid = object_id('vcc_product_admin'))
            where name = 'fk_vcc_prod_reference_vcc_pro_' and type = 'RI')
begin
	alter table vcc_product_admin
		drop constraint fk_vcc_prod_reference_vcc_pro_
end
go

if exists (select 1 
            from  sysobjects c 
            join  sysconstraints s on (s.constrid = c.id and s.tableid = object_id('vcc_product_admin'))
            where name = 'fk_section_management' and type = 'RI')
begin
	alter table vcc_product_admin
		drop constraint fk_section_management
end
go

if exists (select 1 
            from  sysobjects c 
            join  sysconstraints s on (s.constrid = c.id and s.tableid = object_id('vcc_dtos'))
            where name = 'fk_vcc_dtos_ref_servi_vcc_serv' and type = 'RI')
   alter table vcc_dtos
      drop constraint fk_vcc_dtos_ref_servi_vcc_serv
go

if exists (select 1 
            from  sysobjects c 
            join  sysconstraints s on (s.constrid = c.id and s.tableid = object_id('vcc_properties'))
            where name = 'fk_vcc_prop_ref_dtos__vcc_dtos' and type = 'RI')
   alter table vcc_properties
      drop constraint fk_vcc_prop_ref_dtos__vcc_dtos
go

if exists (select 1 
            from  sysobjects c 
            join  sysconstraints s on (s.constrid = c.id and s.tableid = object_id('vcc_pro_admin_default'))
            where name = 'fk_vcc_pro__ref_dtos__vcc_dtos' and type = 'RI')
   alter table vcc_pro_admin_default
      drop constraint fk_vcc_pro__ref_dtos__vcc_dtos
go

if exists (select 1
            from  sysobjects c 
            join  sysconstraints s on (s.constrid = c.id and s.tableid = object_id('vcc_rol_content_management'))
            where name = 'fk_section_management' and type = 'RI')
   alter table vcc_rol_content_management
      drop constraint fk_section_management
go

if exists (select 1
            from  sysobjects
            where id = object_id('vcc_dtos')
            and   type = 'U')
   drop table vcc_dtos
go

if exists (select 1
            from  sysobjects
            where id = object_id('vcc_properties')
            and   type = 'U')
   drop table vcc_properties
go

if exists (select 1
            from  sysobjects
            where id = object_id('vcc_services')
            and   type = 'U')
   drop table vcc_services
go

if exists (select 1
            from  sysobjects
            where id = object_id('vcc_pro_admin_default')
            and   type = 'U')
begin
   print '====> Eliminando vcc_pro_admin_default'
   drop table vcc_pro_admin_default
end
go

if exists (select 1
            from  sysobjects
            where id = object_id('vcc_product_admin')
            and   type = 'U')
begin
   print '====> Eliminando vcc_product_admin'
   drop table vcc_product_admin
end
go

if exists (select 1
            from  sysobjects
            where id = object_id('vcc_rol_content_management')
            and   type = 'U')
begin
   print '====> Eliminando vcc_rol_content_management'
   drop table vcc_rol_content_management
end
go

if exists (select 1
            from  sysobjects
            where id = object_id('vcc_section_management_content')
            and   type = 'U')
begin
   print '====> Eliminando vcc_section_management_content'
   drop table vcc_section_management_content
end
go

/*==============================================================*/
/* Table: vcc_dtos                                              */
/*==============================================================*/
create table vcc_dtos (
   dto_id               int                            not null,
   ser_id_fk            varchar(255)                   null,
   dto_name             varchar(255)                   null,
   dto_text             varchar(255)                   null,
   dto_description      varchar(255)                   null,
   dto_parent           int                            null,
   dto_is_list 			tinyint      				   null,
   dto_mnemonic 	  	varchar(50) 				   null,
   dto_order            int                            null,
   constraint pk_vcc_dtos primary key nonclustered (dto_id)
)
go

/*==============================================================*/
/* Table: vcc_properties                                        */
/*==============================================================*/
create table vcc_properties (
   pr_id                  int 						 NOT NULL,
	dto_id_fk              int							 NULL,
	pr_name                varchar(255) 				 NULL,
	pr_text                varchar(255) 				 NULL,
	pr_primarykey          tinyint 						 NULL,
	pr_grouping            tinyint 						 NULL,
	pr_detailsection       tinyint 						 NULL,
	pr_visiblesumarydetail tinyint 						 NULL,
	pr_visiblesumarygroup  tinyint 						 NULL,
	pr_filterinprocess     tinyint 						 NULL,
	pr_width               varchar(50) 		    		 NULL,
	pr_format              varchar(50) 		    		 NULL,
	pr_style               varchar(50)                   null,
	pr_order               int                           null,
	pr_type                varchar(50) 					 null,
   constraint pk_vcc_properties primary key nonclustered (pr_id)
)
go

/*==============================================================*/
/* Table: vcc_services                                          */
/*==============================================================*/
create table vcc_services (
   ser_id               varchar(255)                   not null,
   ser_description      varchar(255)                   null,
   constraint pk_vcc_services primary key nonclustered (ser_id)
)
go

/*==============================================================*/
/* Table: vcc_pro_admin_default                                 */
/*==============================================================*/
print '====> Creando vcc_pro_admin_default'
create table vcc_pro_admin_default (
   prd_id               numeric                        not null,
   dto_id_fk            int                            null,
   prd_mnemonic         varchar(6)                     null,
   prd_name             varchar(64)                    not null,
   prd_description      varchar(255)                   null,
   prd_parent           numeric                        not null,
   prd_type_client      varchar(5)                     null,
   prd_order            int                            null,
   constraint pk_vcc_pro_admin_default primary key (prd_id)
)
go

/*==============================================================*/
/* Table: vcc_product_admin                                     */
/*==============================================================*/
print '====> Creando vcc_product_admin'
create table vcc_product_admin (
   pr_rol_id            tinyint                        not null,
   prd_id               numeric                        not null,
   pr_isvisible         bit                            not null,
   pr_isencrypted       bit                            not null,
   pr_rol_name          varchar(64)                    null,
   constraint pk_vcc_product_admin primary key (pr_rol_id, prd_id)
)
go

/*==============================================================*/
/* Table: vcc_section_management_content                        */
/*==============================================================*/
create table vcc_section_management_content  ( 
	sm_id          	int NOT NULL,
	sm_name        	varchar(50) ,
	sm_description 	descripcion,
	sm_url_template	varchar(255) NOT NULL,
	sm_type         varchar(5)  NULL,
	constraint pk_section_manager_id primary key NONCLUSTERED(sm_id)
)
go

/*==============================================================*/
/* Table: vcc_rol_content_management                            */
/*==============================================================*/
create table vcc_rol_content_management  ( 
	rc_sm_id 	int NOT NULL,
	rc_rol_id	int NOT NULL,
	constraint pk_rol_section_management primary key NONCLUSTERED(rc_sm_id,rc_rol_id)
)
go

/*==============================================================*/
/* Table: vcc_product_admin                                     */
/*==============================================================*/
alter table vcc_product_admin
   add constraint fk_vcc_prod_reference_vcc_pro_ foreign key (prd_id)
      references vcc_pro_admin_default (prd_id)
go

alter table vcc_rol_content_management
	add constraint fk_section_management foreign key (rc_sm_id)
	references vcc_section_management_content(sm_id)
go


alter table vcc_dtos
   add constraint fk_vcc_dtos_ref_servi_vcc_serv foreign key (ser_id_fk)
      references vcc_services (ser_id)
go

alter table vcc_properties
   add constraint fk_vcc_prop_ref_dtos__vcc_dtos foreign key (dto_id_fk)
      references vcc_dtos (dto_id)
go

alter table vcc_pro_admin_default
   add constraint fk_vcc_pro__ref_dtos__vcc_dtos foreign key (dto_id_fk)
      references vcc_dtos (dto_id)
go

use cob_credito
go

if exists (select 1
            from  sysobjects
            where id = object_id('vcc_resultado_360 ')
            and   type = 'U')
begin
   print '====> Eliminando vcc_resultado_360'
   drop table vcc_resultado_360 
end
go

/*==============================================================*/
/* Table: vcc_resultado_360                                     */
/*==============================================================*/
print '====> Creando vcc_resultado_360'
create table vcc_resultado_360(
   res_user             login                          not null, 
   res_sesn             int                            not null, 
   res_tipo_deuda       varchar(15)                    null, 
   res_producto         char(3)                        null, 
   res_des_producto     varchar(30)                    null, 
   res_monto_riesgo     money                          null,
   res_numero_op        varchar(24)                    not null, 
   res_estado           varchar(30)                    null,
   constraint pk_resultado_360 primary key (res_user, res_sesn, res_numero_op)
)
go
