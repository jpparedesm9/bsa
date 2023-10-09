use cob_conta_super
go

if exists(select 1 from sysobjects
           where name = 'sb_cuentas_N4')
   drop table sb_cuentas_N4
go

create table sb_cuentas_N4 (
	cn_ente		 		varchar(20),
	cn_p_apellido			varchar(50),
	cn_s_apellido 			varchar(50),
	cn_nombres				varchar(50),
	cn_num_sucursal		varchar(10),
	cn_rfc					varchar(20),
	cn_sexo				varchar(10),
	cn_nacionalidad		varchar(100),
	cn_edo_civil			varchar(20),
	cn_celular				varchar(20),
	cn_correo_electronico	varchar(100),
	cn_fecha_ingreso		varchar(20),
	cn_oficina				varchar(100),
	cn_colonia				varchar(100),
	cn_cod_postal			varchar(10),
	cn_ingreso_men_neto	varchar(50),
	cn_procesado			varchar(1) default 'N',
	cn_fecha_pro          datetime,
	cn_fecha_real         datetime
)
go

create index idx_1 on sb_cuentas_N4(cn_ente)
go

use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_cuentas_N4_tmp') IS NOT NULL
	DROP table dbo.sb_cuentas_N4_tmp
go

create table dbo.sb_cuentas_N4_tmp
	(
	cn_ente_tmp               varchar (120),
	cn_p_apellido_tmp         varchar (120),
	cn_s_apellido_tmp         varchar (120),
	cn_nombres_tmp            varchar (120),
	cn_num_sucursal_tmp       varchar (120),
	cn_rfc_tmp                varchar (120),
	cn_sexo_tmp               varchar (120),
	cn_nacionalidad_tmp       varchar (100),
	cn_edo_civil_tmp          varchar (120),
	cn_celular_tmp            varchar (120),
	cn_correo_electronico_tmp varchar (100),
	cn_fecha_ingreso_tmp      varchar (120),
	cn_oficina_tmp            varchar (100),
	cn_colonia_tmp            varchar (100),
	cn_cod_postal_tmp         varchar (120),
	cn_ingreso_men_neto_tmp   varchar (120)
	)
go

create index idx_1
	on dbo.sb_cuentas_N4_tmp (cn_ente_tmp)
go
