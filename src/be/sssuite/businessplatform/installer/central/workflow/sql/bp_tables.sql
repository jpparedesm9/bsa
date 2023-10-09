USE cob_pac
go

/*
**Eliminar tablas si existen
*/

if exists (select 1
            from  sysobjects
            where  id = object_id('bpl_variable_process')
            and    type = 'U')
   drop table bpl_variable_process
go

if exists (select 1
            from  sysobjects
            where  id = object_id('bpl_variable_definition')
            and    type = 'U')
   drop table bpl_variable_definition
go

if exists (select 1
            from  sysobjects
            where  id = object_id('bpl_rule_process_his')
            and    type = 'U')
   drop table bpl_rule_process_his
go


if exists (select 1
            from  sysobjects
            where  id = object_id('bpl_rule_process')
            and    type = 'U')
   drop table bpl_rule_process
go

if exists (select 1
            from  sysobjects
            where  id = object_id('bpl_result_policies')
            and    type = 'U')
   drop table bpl_result_policies
go

if exists (select 1
            from  sysobjects
            where  id = object_id('bpl_rule_exceptions')
            and    type = 'U')
   drop table bpl_rule_exceptions
go

if exists (select 1
            from  sysobjects
            where  id = object_id('bpl_condition_rule')
            and    type = 'U')
   drop table bpl_condition_rule
go

if exists (select 1
            from  sysobjects
            where  id = object_id('bpl_rule_rol_det')
            and    type = 'U')
   drop table bpl_rule_rol_det
go

if exists (select 1
            from  sysobjects
            where  id = object_id('bpl_rule_rol')
            and    type = 'U')
   drop table bpl_rule_rol
go

if exists (select 1
            from  sysobjects
            where  id = object_id('bpl_rule_version')
            and    type = 'U')
   drop table bpl_rule_version
go

if exists (select 1
            from  sysobjects
            where  id = object_id('bpl_rule')
            and    type = 'U')
   drop table bpl_rule
go

if exists (select 1
            from  sysobjects
            where  id = object_id('bpl_subtype_rule')
            and    type = 'U')
   drop table bpl_subtype_rule
go

if exists (select 1
            from  sysobjects
            where  id = object_id('bpl_system_rule')
            and    type = 'U')
   drop table bpl_system_rule
go


if exists (select 1
            from  sysobjects
            where  id = object_id('bpl_rule_dependence')
            and    type = 'U')
   drop table bpl_rule_dependence
go
/*
**Creación de tablas
*/

CREATE TABLE dbo.bpl_rule
(
    rl_id      int         NOT NULL,
    rl_name    varchar(45) NOT NULL,
	rl_acronym char(10)    NOT NULL,
    rl_system  varchar(15) NULL,
    rl_type    varchar(20) NULL,
    rl_subtype varchar(20) NULL,
	rl_description varchar(255) NULL,
    CONSTRAINT pk_bpl_rule
    PRIMARY KEY CLUSTERED (rl_id)
)
-- LOCK ALLPAGES
go
IF OBJECT_ID('dbo.bpl_rule') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.bpl_rule >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.bpl_rule >>>'
go

/* Unique index para el nombre del programa */
create unique index rule_name_index
     on bpl_rule (rl_name) 
go

/* Unique index para el abreviatura del programa */
create unique index rule_acronym_index
     on bpl_rule (rl_acronym) 
go

CREATE TABLE dbo.bpl_rule_version
(
    rv_id          int      NOT NULL,
    rl_id          int      NULL,
    rv_version     int      NOT NULL,
    rv_date_start  datetime NULL,
    rv_date_finish datetime NULL,
    rv_status      char(10) NULL,
    CONSTRAINT pk_bpl_rules_version
    PRIMARY KEY CLUSTERED (rv_id)
)
-- LOCK DATAROWS   
go
IF OBJECT_ID('dbo.bpl_rule_version') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.bpl_rule_version >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.bpl_rule_version >>>'
go

CREATE TABLE dbo.bpl_condition_rule
(
    cr_id          				 int           IDENTITY NOT NULL,
    rv_id          				 int           NULL,
    cr_parent      				 int           NULL,
    vd_id          				 int           NULL,
    cr_operator    				 varchar(20)   NOT NULL,
    cr_min_value   				 varchar(255)  NULL,
    cr_max_value   				 varchar(255)  NULL,
    cr_is_last_son 				 bit           NOT NULL,
	cr_last_parent_condition     int 		   NULL,
	cr_id_result            	 int 	       NULL,
    CONSTRAINT pk_bpl_condition_rule
    PRIMARY KEY CLUSTERED (cr_id)
)
-- LOCK DATAROWS
go
IF OBJECT_ID('dbo.bpl_condition_rule') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.bpl_condition_rule >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.bpl_condition_rule >>>'
go

CREATE TABLE dbo.bpl_rule_process
(
    pr_id     int      NOT NULL,
    rv_id     int      NULL,
    pr_date   datetime NOT NULL,
    pr_system char(10) NULL,
    CONSTRAINT pk_bpl_rule_process
    PRIMARY KEY CLUSTERED (pr_id)
)
-- LOCK ALLPAGES
go
IF OBJECT_ID('dbo.bpl_rule_process') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.bpl_rule_process >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.bpl_rule_process >>>'
go
ALTER TABLE dbo.bpl_rule_process
    ADD CONSTRAINT fk_rule_process
    FOREIGN KEY (rv_id)
    REFERENCES dbo.bpl_rule_version (rv_id)
go

CREATE TABLE dbo.bpl_variable_process
(
    vp_id    int          NOT NULL,
    pr_id    int          NULL,
    vd_id    int          NULL,
    vp_value varchar(255) NOT NULL,
    CONSTRAINT pk_bpl_variable_process
    PRIMARY KEY CLUSTERED (vp_id)
)
-- LOCK ALLPAGES
go
IF OBJECT_ID('dbo.bpl_variable_process') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.bpl_variable_process >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.bpl_variable_process >>>'
go
CREATE TABLE dbo.bpl_rule_process_his
(
    rph_rule_id      int          NULL,
    rph_rule_version int          NULL,
    rph_id_inst_proc int          NULL,
    rph_id_asig_act  int          NULL,
    rph_cod_variable int          NULL,
    rph_valor        varchar(255) NULL,
    rph_is_result    int          NULL,
    rph_error        varchar(255) NULL,
	rph_tipo         varchar(10)  NULL,
	rph_descripcion  varchar(255) NULL
)
-- LOCK ALLPAGES
go
IF OBJECT_ID('dbo.bpl_rule_process_his') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.bpl_rule_process_his >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.bpl_rule_process_his >>>'
go

USE cob_pac
go
CREATE TABLE dbo.bpl_variable_definition
(
    vd_id   int         NOT NULL,
    vd_name varchar(50) NOT NULL,
    vd_type varchar(10) NULL,
    CONSTRAINT pk_bpl_variable_definition
    PRIMARY KEY CLUSTERED (vd_id)
)
-- LOCK ALLPAGES
go
IF OBJECT_ID('dbo.bpl_variable_definition') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.bpl_variable_definition >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.bpl_variable_definition >>>'
go

create table dbo.bpl_rule_rol 
(
	rr_id_rol		tinyint		  NOT NULL,
	rr_descripcion	varchar(255)  NOT NULL,
	rr_fecha_crea   datetime      NOT NULL,
	CONSTRAINT pk_rule_role 
	PRIMARY KEY NONCLUSTERED(rr_id_rol)
)
-- LOCK ALLPAGES
go
IF OBJECT_ID('dbo.bpl_rule_rol') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.bpl_rule_rol >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.bpl_rule_rol >>>'
go


create table dbo.bpl_rule_rol_det (
	rr_id_rol       	tinyint 	NOT NULL,
	rl_id               int         NOT NULL,
	rd_es_lectura   	bit   		NOT NULL,
	rd_es_escritura     bit 		NOT NULL,
	rd_es_ejecucion   	bit 		NOT NULL,
	PRIMARY KEY(rr_id_rol, rl_id),
	CONSTRAINT fk_rules  FOREIGN KEY(rl_id)
	REFERENCES dbo.bpl_rule(rl_id),
	CONSTRAINT fk_rule_role  FOREIGN KEY(rr_id_rol)
	REFERENCES dbo.bpl_rule_rol(rr_id_rol)
)
-- LOCK ALLPAGES
go
IF OBJECT_ID('dbo.bpl_rule_rol_det') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.bpl_rule_rol_det  >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.bpl_rule_rol_det >>>'
go


create table dbo.bpl_system_rule (
	sr_id       		int 			NOT NULL,
	sr_acronym      	varchar(10) 	NOT NULL,
	sr_name   		    varchar(64)   	NOT NULL,
	sr_description     	varchar(255) 	NOT NULL,
	sr_modulo_cobis     varchar(10)     NULL,
	CONSTRAINT pk_system PRIMARY KEY NONCLUSTERED(sr_id)
)
-- LOCK ALLPAGES
go
IF OBJECT_ID('dbo.bpl_system_rule') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.bpl_system_rule  >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.bpl_system_rule >>>'
go


create table dbo.bpl_subtype_rule (
	su_id  			    int				NOT NULL,
	sr_id        		int			 	NOT NULL,
	su_name   		    varchar(64)   	NOT NULL,
	su_description     	varchar(255) 	NOT NULL,
	su_acronym          varchar(10) 	NOT NULL,
	CONSTRAINT pk_subtype PRIMARY KEY NONCLUSTERED(su_id)
)
-- LOCK ALLPAGES
go
IF OBJECT_ID('dbo.bpl_subtype_rule') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.bpl_subtype_rule  >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.bpl_subtype_rule >>>'
go


create table dbo.bpl_rule_exceptions (
	re_id_exception			int 			NOT NULL,
	cr_id_result 	        int 			NOT NULL,
	re_id_customer			int 			NULL,
	re_id_card				varchar(16)		NULL,
	re_product				varchar(32)		NULL,
	re_date_before			datetime		NOT NULL,
	re_date_after			datetime		NOT NULL,
	re_status				varchar(256)	    NOT NULL,
	re_result				varchar(30)		NOT NULL,
	re_result_1				varchar(30)		NULL,
	re_result_2				varchar(30)		NULL,
	re_result_3				varchar(30)		NULL,
	re_result_4				varchar(30)		NULL
)
-- LOCK ALLPAGES
go
IF OBJECT_ID('dbo.bpl_rule_exceptions') IS NOT NULL
    PRINT '<<< CREATED TABLE dbo.bpl_rule_exceptions  >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dbo.bpl_rule_exceptions >>>'
go

   
/*==============================================================*/
/* Table: bpl_result_policies                                   */
/*==============================================================*/ 
create table bpl_result_policies(
	rp_id		int           NOT NULL,
	rp_name		varchar(100)  NOT NULL,
	rp_result   char(1)       NOT NULL,
	constraint pk_result_policies primary key (rp_id)	
)
go

/*==============================================================*/
/* Table: bpl_rule_dependence                                   */
/*==============================================================*/ 
create table bpl_rule_dependence
(  
	 rd_id int,                       -- Id Dependencia 
     rl_id int,                       -- Id Regla
     rd_dependence_type varchar(10),  -- Tipo Dependencia
     rd_dependence_id   varchar(10),  -- Id de Proceso, Producto, Programa, Funcionalidad de Dependencia
     rd_dependece_name  varchar(255) -- Nombre de la Orquestación (Clase)
)
go   

/*==============================================================*/
/* Constraints                                                  */
/*==============================================================*/
if not exists(select *
              from   cob_pac..sysobjects obj, cob_pac..sysindexes con
              where  obj.name = 'bpl_system_rule'
              and    obj.id = con.id
              and    con.name = 'u_system')
begin
ALTER TABLE dbo.bpl_system_rule
	ADD CONSTRAINT u_system
	UNIQUE (sr_acronym)

end
go

if not exists(select *
              from   cob_pac..sysobjects obj, cob_pac..sysindexes con
              where  obj.name = 'bpl_subtype_rule'
              and    obj.id = con.id
              and    con.name = 'u_subtype')
begin
ALTER TABLE dbo.bpl_subtype_rule
	ADD CONSTRAINT u_subtype
	UNIQUE (su_acronym)
end
go




/*==============================================================*/
/* indexes                                                                                                                               */
/*==============================================================*/

if not exists(select 1 from sysindexes where name = 'idx_cr_parent')
begin

CREATE NONCLUSTERED INDEX idx_cr_parent
    ON dbo.bpl_condition_rule(cr_parent)
    ON [default]

end

if not exists(select 1 from sysindexes where name = 'idx_last_parent_onversion')
begin

CREATE NONCLUSTERED INDEX idx_last_parent_onversion
    ON dbo.bpl_condition_rule(cr_last_parent_condition)
    ON [default]


end


if not exists(select 1 from sysindexes where name = 'idx_rule_onversion')
begin

CREATE NONCLUSTERED INDEX idx_rule_onversion
    ON dbo.bpl_rule_version(rl_id)
    ON [default]

end

go
