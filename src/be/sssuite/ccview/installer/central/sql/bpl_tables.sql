/*==============================================================*/
/* DBMS name:      Sybase AS Enterprise 12.5.1                  */
/* Created on:     2/11/2011 11:40:39 AM                        */
/*==============================================================*/

use cob_pac
go


if exists (select 1
            from  sysobjects
            where  id = object_id('bpl_parameter_value')
            and    type = 'U')
begin
   print '====> Eliminando bpl_parameter_value'
   drop table bpl_parameter_value
end

if exists (select 1
            from  sysobjects
            where  id = object_id('bpl_product')
            and    type = 'U')
begin
   print '====> Eliminando bpl_product'
   drop table bpl_product
end


if exists (select 1
            from  sysobjects
            where  id = object_id('bpl_view_parameter')
            and    type = 'U')
begin
   print '====> Eliminando bpl_view_parameter'
   drop table bpl_view_parameter
end


if exists (select 1
            from  sysobjects
            where  id = object_id('bpl_an_page_view')
            and    type = 'U')
begin
   print '====> Eliminando bpl_an_page_view'
   drop table bpl_an_page_view
end


if exists (select 1
            from  sysobjects
            where  id = object_id('bpl_view')
            and    type = 'U')
begin
   print '====> Eliminando bpl_view'
   drop table bpl_view
end


if exists (select 1
            from  sysobjects
            where  id = object_id('bpi_product_process')
            and    type = 'U')
begin
   print '====> Eliminando bpi_product_process'
   drop table bpi_product_process
end


if exists (select 1
            from  sysobjects
            where  id = object_id('bpi_verifcation_data')
            and    type = 'U')
begin
   print '====> Eliminando bpi_verifcation_data'
   drop table bpi_verifcation_data
end


if exists (select 1
            from  sysobjects
            where  id = object_id('bpi_task_view')
            and    type = 'U')   
begin
   print '====> Eliminando bpi_task_view'
   drop table bpi_task_view
end


if exists (select 1
            from  sysobjects
            where  id = object_id('bpi_variables_task_view')
            and    type = 'U')   
begin
   print '====> Eliminando bpi_variables_task_view'
   drop table bpi_variables_task_view
end
go

/*==============================================================*/
/* Table: bpi_product_process                                   */
/*==============================================================*/
print '====> Creando bpi_product_process'
create table bpi_product_process (
     pp_financial_product_id varchar(10)                 not null,
     pp_process_id           int                         not null,
	 pp_is_generic           bit            default 0    not null,
	 pp_is_line 			 int 			default 0    not null,
     constraint PK_BPI_PRODUCT_PROCESS primary key (pp_process_id, pp_financial_product_id)
)
go


/*==============================================================*/
/* Table: bpi_task_view                                         */
/*==============================================================*/
print '====> Creando bpi_task_view'
create table bpi_task_view (
    tv_process_id          int NOT NULL,
    tv_version_id          int NOT NULL,
    tv_task_id             int NOT NULL,
    tv_component_id        int NOT NULL,
	tv_component_detail_id int NULL,
    tv_order               int DEFAULT 1 NOT NULL,
	tv_id                  int NOT NULL,
    CONSTRAINT pk_bpi_task_view
    PRIMARY KEY NONCLUSTERED (tv_id)
)
go


/*==============================================================*/
/* Table: bpi_variables_task_view                               */
/*==============================================================*/
print '====> Creando bpi_variables_task_view'
create table bpi_variables_task_view (
     vtv_product_cobis_id varchar(10)                    not null,
     vtv_funcionalidad_id int                            not null,
     vtv_financial_product_id varchar(10)                not null,
     vtv_task_id          int                            not null,
     vtv_variable_id      int                            not null,
     vtv_seccion          int                            null,
     vtv_campo            varchar(10)                    null,
     constraint PK_BPI_VARIABLES_TASK_VIEW primary key (vtv_product_cobis_id, vtv_funcionalidad_id, vtv_financial_product_id, vtv_task_id, vtv_variable_id)
)
go


/*==============================================================*/
/* Table: bpl_an_page_view                                      */
/*==============================================================*/
print '====> Creando bpl_an_page_view'
create table bpl_an_page_view (
     pvi_id               int                            not null,
     pvi_view_id          int                            null,
     pvi_page_id          int                            null
)
go


alter table bpl_an_page_view
   add constraint an_page_view_pk primary key (pvi_id)
go


/*==============================================================*/
/* Table: bpl_parameter_value                                   */
/*==============================================================*/
print '====> Creando bpl_parameter_value'
create table bpl_parameter_value (
     par_page_view_id     int                            not null,
     par_parameter_id     int                            not null,
     par_value            varchar(64)                    null,
     par_default          udt_boolean                    not null
)
go


alter table bpl_parameter_value
   add constraint parameter_value_pk primary key (par_page_view_id, par_parameter_id)
go


/*==============================================================*/
/* Table: bpl_product                                           */
/*==============================================================*/
print '====> Creando bpl_product'
create table bpl_product (
     pr_id                int                            not null,
     pr_code              varchar(10)                    null,
     pr_code_cen          varchar(10)                    null,
     pr_type              varchar(10)                    null
)
go


--alter table bpl_product
   --add constraint PK_BPL_PRODUCT primary key (pr_id)
--go


/*==============================================================*/
/* Table: bpl_view                                              */
/*==============================================================*/
print '====> Creando bpl_view'
create table bpl_view (
     vi_id                int                            not null,
     vi_id_parent         int                            null,
     vi_label_id          int                            null,
     vi_product_id        int                            null,
     vi_name_description  varchar(255)                   null,
     vi_status            udt_catalog                    null,
     vi_order             int                            null,
     vi_is_group          udt_boolean                    not null,
     vi_type_view         udt_catalog                    null
)
go


alter table bpl_view
   add constraint bpl_view_pk primary key (vi_id)
go


/*==============================================================*/
/* Table: bpl_view_parameter                                    */
/*==============================================================*/
print '====> Creando bpl_view_parameter'
create table bpl_view_parameter (
     par_id               int                            not null,
     par_view_id          int                            null,
     par_name             varchar(255)                   null
)
go

/*==============================================================*/
/* Table: bpi_verifcation_data                                    */
/*==============================================================*/
print '====> Creando bpi_verifcation_data'
create table dbo.bpi_verifcation_data  ( 
	vd_ssn              	int 						 not null,
	vd_ente             	int 						 not null,
	vd_date_verification	datetime 					 null,
	vd_user_verificator 	varchar(25) 				 not null,
	vd_verificated      	tinyint 					 not null,
	vd_descripcion      	varchar(25) 				 null 
)
go

alter table bpl_view_parameter
   add constraint view_parameter_pk primary key (par_id)
go


alter table bpl_an_page_view
   add constraint page_view_fk2 foreign key (pvi_view_id)
      references bpl_view (vi_id)
go


alter table bpl_parameter_value
   add constraint parameter_value_fk1 foreign key (par_page_view_id)
      references bpl_an_page_view (pvi_id)
go


alter table bpl_parameter_value
   add constraint parameter_value_fk2 foreign key (par_parameter_id)
      references bpl_view_parameter (par_id)
go


alter table bpl_view
   add constraint bpl_view_fk1 foreign key (vi_id_parent)
      references bpl_view (vi_id)
go


alter table bpl_view_parameter
   add constraint view_parameter_fk1 foreign key (par_view_id)
      references bpl_view (vi_id)
go
