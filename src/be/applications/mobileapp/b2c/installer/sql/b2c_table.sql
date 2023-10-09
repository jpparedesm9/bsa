/* ************************************************************************** */
/*  Archivo:            b2c_table.sql                                          */
/*  Base de datos:      cob_bvirtual                                          */
/* ************************************************************************** */
/*              IMPORTANTE                                                    */
/*  Este programa es parte de los paquetes bancarios propiedad de             */
/*  "Cobiscorp".                                                              */
/*  Su uso no autorizado queda expresamente prohibido asi como                */
/*  cualquier alteracion o agregado hecho por alguno de sus                   */
/*  usuarios sin el debido consentimiento por escrito de la                   */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.                    */
/* ************************************************************************** */
/*              PROPOSITO                                                     */
/*  Creacion Tablas Bussiness to custumer                                     */
/* ************************************************************************** */
/*              MODIFICACIONES                                                */
/* ************************************************************************** */
/* FECHA        VERSION       AUTOR              RAZON                        */
/* ************************************************************************** */
/* 29-Nov-2019                ERA            Emision Inicial B2C              */
/* ************************************************************************** */

use cob_bvirtual
go


print 'bv_ente'
if object_id('bv_ente') is null
	create table bv_ente (
	  en_ente           int           not null,
	  en_ente_mis       int           not null,
	  en_nombre         varchar(64)   null,
	  en_pnombre       varchar(32)   null,
	  en_papellido      varchar(32)   null,
	  en_sapellido      varchar(32)   null,
	  en_fecha_reg      datetime      not null,
	  en_fecha_mod      datetime      not null,
	  en_fecha_nac      datetime      null,
	  en_ced_ruc        varchar(64)   null,
	  en_categoria      varchar(10)   null,
	  en_tipo           varchar(10)   null,
	  en_email          varchar(64)   null,
	  en_fax            varchar(32)   null,
	  en_sector         varchar(10)   null,
	  en_lenguaje       varchar(10)   not null,
	  en_oficina        smallint      not null,
	  en_notificaciones char(1)       null,
	  en_oficial        smallint      null,
	  en_usuario        varchar(30)   not null,
	  en_origen_ente    char(1)     null,
	  en_uso_convenio   varchar(10)   null,
	  en_autorizado     char(1)       not null,
	  en_grupo          int           null,
	  en_segmento       varchar(10)   null,
	  en_linea_negocio  varchar(10)   null,
	  en_apoderado_legal int          null,
	  en_tipo_autoriza    char(1)     null
	)
go

print 'bv_ente.bv_ente_Key'
if not exists (select name from sysindexes where name = 'bv_ente_Key')
	create unique clustered index bv_ente_Key
	on bv_ente
	(en_ente)
go

print 'bv_log'
if object_id('bv_log') is null
	create table bv_log (
	  lo_secuencial      int         not null,
	  lo_ente            int         not null,
	  lo_servicio        tinyint     not null,
	  lo_transaccion     int         not null,
	  lo_status          char(2)     not null,
	  lo_tipo_ejec       char(1)     not null,
	  lo_fecha           datetime    not null,
	  lo_hora            datetime    not null,
	  lo_login           char(64) not null,
	  lo_accion          char(1)     not null,
	  lo_producto        tinyint     null,
	  lo_moneda          smallint    null,
	  lo_cuenta          varchar(32) null,
	  lo_comision        money       null,
	  lo_costo           money     null,
	  lo_error           int       null,
	  lo_msg             varchar(64) null,
	  lo_ssn_branch      int         null,
	  lo_valor_trn       money    null,
	  lo_cuenta_dst      varchar(30) null,
	  lo_fondos_origen   varchar(64) null, 
	  lo_fondos_destino  varchar(64) null 
	)
go

print 'bv_log.bv_log_Key'
if not exists (select name from sysindexes where name = 'bv_log_Key')
	create unique clustered index bv_log_Key
	on bv_log
	(lo_fecha,
	 lo_secuencial)
go


print 'bv_servicio'
if object_id('bv_servicio') is null   
	create table bv_servicio (
	  se_servicio     tinyint     not null,
	  se_nombre       varchar(32) null,
	  se_descripcion  varchar(64) null,
	  se_habilitado   char(1)     not null,
	  se_fecha_reg    datetime    not null,
	  se_fecha_mod    datetime    not null,
	  se_estado       char(1)     null
	)
go

print 'bv_servicio.bv_servicio_Key'
if not exists (select name from sysindexes where name = 'bv_servicio_Key')
	create unique clustered index bv_servicio_Key
	on bv_servicio
	(se_servicio)
go

print 'bv_login'
if object_id('bv_login') is null
	create table bv_login (
	  lo_ente           int          not null,
	  lo_servicio       tinyint      not null,
	  lo_login          varchar(64)  null,
	  lo_login_personal varchar(64)  null,
	  lo_clave_temp     varchar(64)     null,
	  lo_clave_def      varchar(64)  null,
	  lo_fecha_reg      datetime     not null,
	  lo_fecha_mod      datetime     not null,
	  lo_dias_vigencia  smallint     null,
	  lo_parametro      varchar(10)  null,
	  lo_tipo_vigencia  varchar(10)     not null,
	  lo_renovable      char(1)      not null,
	  lo_fecha_ult_pwd  datetime     null,
	  lo_hora           datetime     null,
	  lo_descripcion    varchar(64)  null,
	  lo_tipo_autorizacion varchar(10)      not null,
	  lo_autorizado       char(1)       not null,
	  lo_cambiar_login  char(1)      default 'S',
	  lo_estado         char(1)      null,
	  lo_usar_mimenu    char(1)      null,
	  lo_estilo     varchar(10)      null,
	  lo_lenguaje      varchar(10)      null,
	  lo_intento_1     tinyint       null,
	  lo_intento_2     tinyint       null,
	  lo_intento_5     tinyint       null,
	  lo_intento_6     tinyint       null,
	  lo_motivo_reimp   char(2)      not null,
	  lo_clave_gen     smallint      not null,
	  lo_clave_imp     smallint      not null,
	  lo_carga_pagina   char(1)      not null,
	  lo_fecha_ult_int   datetime    null,
	  lo_fecha_ult_ing   datetime    null,
	  lo_fecha_ult_ing2  datetime    null,
	  lo_empresa         int            null,
	  lo_autoriz_imp     char(1)     null,
	  lo_afiliador      varchar(30)  null,
	  lo_oficina        smallint     null,
	  lo_impresor       varchar(30)  null,
	  lo_fecha_ult_imp   datetime    null,
	  lo_clave_imp_cobro int      null,
	  lo_idx                  int    IDENTITY(1,1),
	  lo_cultura         varchar(10)        null,
	  lo_tema            varchar(40)        null,
	  lo_numero_autorizacion int            null,
	  lo_clave_mail          int null,
	  lo_tip_envio           varchar(10) null,
	  lo_origen           varchar(7) null,
	  lo_biometric_id     int null,
	  lo_biometric_state  char(1) null,
	  lo_otp              char(1) null,
	  lo_otp_estado       char(1) null,
	  lo_otp_intento      int null,
	  lo_otp_motivo       varchar(64) null)
go

print 'bv_login.bv_login_Key'
if not exists (select name from sysindexes where name = 'bv_login_Key')
	create unique clustered index bv_login_Key
	on bv_login
	(lo_ente,
	 lo_servicio,
	 lo_login)
go

print 'bv_login.PK_bv_login'
if not exists (select name from sysindexes where name = 'PK_bv_login')
	CREATE UNIQUE INDEX PK_bv_login
	ON bv_login
	(lo_idx)
go

print 'bv_in_login'
if object_id('bv_in_login') is null
	create table bv_in_login
	(
	  il_login                       varchar(64) not null,
	  il_terminal_ip                 varchar(30) not null,
	  il_server_name                 varchar(30) not null,
	  il_sesiones                    int not null,
	  il_fecha_in                    datetime not null
	)
go

print 'bv_in_login_his'
if object_id('bv_in_login_his') is null
	create table bv_in_login_his
	(
	  il_cliente                     int not null,
	  il_login                       varchar(64) not null,
	  il_terminal_ip                 varchar(30) not null,
	  il_server_name                 varchar(30) not null,
	  il_fecha_in                    datetime not null
	)
go

print 'bv_login_imagen'
if object_id('bv_login_imagen') is null
	create table bv_login_imagen (
	  li_login           varchar(64)       not null,
	  li_imagen          varchar(max)      null,
	  li_imagen_personal varchar(max)      null,
	  li_imagen_logo     varchar(max)      null,
	  li_alias           varchar(64)       null,
	  li_estado          varchar(255)      not null
	)
go

PRINT 'TABLE bv_login_authentication'
IF not EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'bv_login_authentication')
	CREATE TABLE bv_login_authentication
	(
		la_login                    VARCHAR(64) NOT NULL,
		la_channel_id               TINYINT NOT NULL,
		la_provider                 VARCHAR(10) NOT NULL,
		la_access_auth_type         VARCHAR(10) NULL,
		la_access_serial_number     VARCHAR(20) NULL,
		la_access_activation_code   VARCHAR(10) NULL,
		la_access_retry             TINYINT NULL,
		la_access_state             CHAR(1) NULL,
		la_access_blocking_reason   VARCHAR(10) NULL,
		la_trx_auth_type            VARCHAR(10) NOT NULL,
		la_trx_serial_number        VARCHAR(20) NULL,
		la_trx_activation_code      VARCHAR(10) NULL,
		la_trx_retry                TINYINT NOT NULL,
		la_trx_state                CHAR(1) NOT NULL,
		la_trx_blocking_reason      VARCHAR(10) NULL,
		la_reg_date                 DATETIME NOT NULL,
		la_mod_date                 DATETIME NOT NULL,
		la_officer                  VARCHAR(14) NOT NULL,
		la_terminal                 VARCHAR(50) NOT NULL,
		la_authorized               CHAR(1) NOT NULL,
		CONSTRAINT PK_bv_login_authentication PRIMARY KEY CLUSTERED
		(
			la_login ASC,
			la_channel_id ASC
		)
	)
GO


PRINT 'bv_session'
if not exists(select 1 from sysobjects where name = 'bv_session')
	create table bv_session(
				bv_id_session  varchar(100) not null,
				bv_servicio   int not null,
				bv_cliente    int not null,
				bv_cliente_mis    int null,
				bv_perfil    int null,
				bv_cultura       varchar(10) null,
				bv_terminal_ip  varchar(20) null,
				bv_token_value  varchar(250) null,
				bv_kpe varchar(250) null,
				bv_msisdn       varchar(15) null,
				bv_timestamp    datetime null,
				bv_page                      int null,
				--DSANDOVALIN - 2012/11/15 - Correccion Instaladores IB
				bv_usuario      varchar(64) null
	   )

GO



--/*********************************************************************/
-- TABLA bv_login_devices
--/*********************************************************************/

print 'Tabla bv_login_devices'
go

if not exists (select 1
            from  sysobjects
           where  id = object_id('bv_login_devices')
            and   type = 'U')
	create table bv_login_devices (
		ls_login                    varchar(64)				not null,		
		ls_channel_id               tinyint					not null,
		ls_phone_number             varchar(20)				null,
		ls_phone_udid               varchar(60)				not null,
		ls_reg_date                 datetime				not null,
		ls_mod_date                 datetime				null,
		ls_officer                  varchar(14)				null,
		ls_terminal                 varchar(50)				null,
		ls_authorized               char					null,
		ls_alias_device             varchar(64)             null,
		ls_biometric_state          char(1)                 null, -- Biometrico
		ls_fingerprint_state        char(1)					null, 
		ls_fingerprint_key          varchar(255)            null, 
		ls_fingerprint_key_name     varchar(30)             null,
		constraint PK_bv_login_devices primary key (ls_login, ls_channel_id,ls_phone_udid)
	)
go
--/*********************************************************************/
-- Index: IX_bv_login_devices 
--/*********************************************************************/
if not exists (select 1
           from  sysindexes
           where  id    = object_id('bv_login_devices')
            and   name  = 'IX_bv_login_devices'
            and   indid > 0
            and   indid < 255)

	create index IX_bv_login_devices on bv_login_devices (ls_mod_date)
go

print 'bv_medio_envio'
if object_id('bv_medio_envio') is  null
	create table bv_medio_envio(
	  me_ente       int         not null,
	  me_login  varchar(64) not null,   --BBO 10-02-2000
	  me_envio      int         not null,
	  me_tipo       varchar(10) not null,
	  me_num_dir    varchar(500) null,
	  me_default    char(1)     not null,
	  me_fecha_crea datetime    not null,
	  me_fecha_mod  datetime    not null,
	  me_servicio   int         null,
	  me_register_id varchar(200)   null
	)
go


PRINT 'bv_notificacion'
if not exists(select * from sysobjects
             where  name = 'bv_notificacion')
	create table bv_notificacion(
	   no_id                  varchar(6),
	   no_descripcion         varchar(64),
	   no_canal               smallint,
	   no_filial              smallint,
	   no_tipo_notif          char(10),
	   no_producto            tinyint,
	   no_variable            varchar(10)  null,
	   no_tipo                varchar(10)  null,
	   no_condicion           varchar(10)  null,
	   no_v_varchar           varchar(255) null,
	   no_v_money             money        null,
	   no_v_datetime          datetime     null,
	   no_parametro           varchar(6)   null,
	   no_editable            char(1),
	   no_visible             char(1),
	   no_mandatorio          char(1),
	   no_transaccion_id      int          null,
	   no_estado              char(1),
	   no_fecha_crea          datetime,
	   no_fecha_mod           datetime,
	   no_fecha_vig_desde     datetime null,
	   no_fecha_vig_hasta     datetime null,
	   no_secuencial          int)
go

--Validacion de preguntas
if not exists (select 1 from sysobjects where type = 'U' and name = 'bv_b2c_banco_preguntas')
	create table bv_b2c_banco_preguntas(
	bp_pregunta_id     int,
	bp_texto           varchar(500),
	bp_tipo_respuesta  varchar(10),--numerico, alfanumerico, fecha --revisar si se puede reutilizar catalogo
	bp_no_tengo        char(1),
	bp_sp_validador    varchar(50),
	bp_estado          char(1)
	)
if not exists (select 1 from  sysindexes
           where  id    = object_id('bv_b2c_banco_preguntas')
            and   name  = 'idx1'
            and   indid > 0
            and   indid < 255)
	create unique index idx1 on bv_b2c_banco_preguntas (bp_pregunta_id)

go


--Intento desafio
if not exists (select 1 from sysobjects where type = 'U' and name = 'bv_b2c_intento_desafio')
	create table bv_b2c_intento_desafio(
	id_cliente       int,
	id_fecha_proceso datetime,
	id_hora          datetime,
	id_resultado     char(1)
	)
if not exists (select 1 from  sysindexes
           where  id    = object_id('bv_b2c_intento_desafio')
            and   name  = 'idx1'
            and   indid > 0
            and   indid < 255)
create index idx1 on bv_b2c_intento_desafio (id_cliente)
go

if not exists (select 1 from  sysindexes
           where  id    = object_id('bv_b2c_intento_desafio')
            and   name  = 'idx2'
            and   indid > 0
            and   indid < 255)
create index idx2 on bv_b2c_intento_desafio (id_fecha_proceso)
go

PRINT 'bv_template'
if not exists(select 1 from sysobjects where name = 'bv_template')
	create table bv_template (
	   te_id                smallint             not null,
	   te_tipo              varchar(10)          not null,
	   te_cultura           varchar(10)          not null,
	   te_nombre            varchar(255)         not null,
	   te_estado            varchar(10)          not null,
	   te_version           varchar(10)          not null
	)
go


if (OBJECT_ID('bv_onboard_ocr_sco')) IS NOT NULL
    drop table bv_onboard_ocr_sco
create table bv_onboard_ocr_sco(
    id_expediente  varchar(100),
    id_validas     varchar(100),
    document_type  varchar(100) null,
    field_name     varchar(200) null,
    name           varchar(100) null,
    text           varchar(100) null,
    value          decimal(25,24) null,
    type           varchar(3) null, -- OCR, BIO, DOC
    fecha_registro datetime default getdate()
)
create index bv_onboard_ocr_sco_idx1 on bv_onboard_ocr_sco (id_expediente)
create nonclustered index bv_onboard_ocr_sco_idx2 on bv_onboard_ocr_sco (id_expediente,type)
go

-- FingerID - Guardar la respuesta en el servicio Validate Toke Opaco
if (OBJECT_ID('bv_respuesta_fingerid')) IS NOT NULL
    drop table bv_respuesta_fingerid
create table bv_respuesta_fingerid(
rf_id_cliente     varchar(20) null,
rf_tipo_trx       varchar(50) null,
rf_id_trx         varchar(50) null,
rf_resultado	  varchar(50) null,

rf_codigo_respuesta_minucia int null,
rf_similitud2	  varchar(10) null,
rf_similitud7	  varchar(10) null,
rf_fecha_ini	  varchar(10) null,
rf_fecha_fin	  varchar(10) null,
rf_codigo_err	  varchar(20) null,
-- ---
rf_codigo_respuesta 			int null ,
rf_fecha_hora_peticion 			varchar(30) null ,
rf_indice_solicitud 			varchar(100) null ,
rf_tiempo_procesamiento 		int null ,
rf_codigo_respuesta_datos 		int null ,
rf_is_ocr 						bit null ,
rf_is_numero_emision_credencial bit null ,
rf_is_nombre 					bit null ,
rf_is_curp 						bit null ,
rf_is_clave_elector 			bit null ,
rf_is_apellido_paterno 			bit null ,
rf_is_apellido_materno 			bit null ,
rf_is_anio_emision 				bit null ,
rf_is_anio_registro 			bit null ,
rf_tipo_reporte_robo_extravio 	varchar(100) null ,
rf_tipo_situacion_registral 	varchar(30) null ,
rf_signature_value 				varchar(100) null ,
rf_momento 						varchar(100) null ,
rf_indice 						varchar(100) null ,
rf_numero_serie 				varchar(100) null ,
rf_hash 						varchar(200) null ,
rf_desc_tipo_trx 				varchar(10) null ,
-- ---
-- rf_key_info 					varchar(100) null ,
rf_x_serial_number 			    varchar(100) null ,
-- rf_signed_info 					varchar(100) null ,
rf_metodo_canonicalizacion	    varchar(100) null ,
rf_metodo_firma	                varchar(100) null ,
rf_alg_metodo_digestion         varchar(100) null ,
rf_valor_metodo_digestion       varchar(100) null ,
rf_uri_metodo_digestion         varchar(100) null ,
-- ---
rf_fecha_registro datetime default getdate()
)


create nonclustered index bv_respuesta_fingerid_idx1 on bv_respuesta_fingerid(rf_id_trx,rf_id_cliente)
go

print 'Tabla para OTP'
use cobis
go

print 'se_token'
if object_id('se_token') is not null
    drop table se_token
go
create table se_token (
  to_servicio        int           not null,
  to_usuario         varchar(128)  not null,
  to_token_value     varchar(256)  not null,
  to_fecha_cre       datetime not null
)
go
if object_id('se_token_his') is not null
    drop table se_token_his
go
	
create table se_token_his (
  hto_servicio        int           not null,
  hto_usuario         varchar(128)  not null,
  hto_token_value     varchar(256)  not null,
  hto_fecha_cre       datetime not null
)
go

use cobis
go

print 'Crea indices'

if exists (select 1 from sysindexes where name = 'i_se_token')
   drop index se_token.i_se_token
go
create nonclustered index i_se_token on se_token (to_servicio,to_usuario,to_token_value,to_fecha_cre)
go

if exists (select 1 from sysindexes where name = 'i_se_token_his')
   drop index se_token_his.i_se_token_his
go
create nonclustered index i_se_token_his on se_token_his (hto_servicio,hto_usuario,hto_token_value,hto_fecha_cre)
go


if exists (select 1 from sysobjects where type = 'U' and name = 'bv_b2c_tipo_msg')
    drop table bv_b2c_tipo_msg
go

if not exists (select 1 from sysobjects where type = 'U' and name = 'bv_b2c_tipo_msg')
	create table bv_b2c_tipo_msg (
tm_tipo_msg            varchar(24)  not null,
tm_dias_vigencia       int          not null,
tm_base_asociada       varchar(30)  null,
tm_sp_asociado         varchar(30)  null,
tm_texto_base          varchar(500) not null,
tm_trespuesta          catalogo     not null, --NR=No Requiere Respespuesta, OK=Requiere un OK,SN=Respuesta de SI o NO
tm_otp                 char(1)      not null, --S=Requiere OTP, N=No requiere OTP
	tm_estado          char(1)      not null,  --V=Vigente, B=Bloqueado
tm_sp_asociado_al_no   varchar(30)  null,      --V=Vigente, B=Bloqueado
tm_pos_boton 		   varchar(20)  null,
tm_neg_boton           varchar(20)  null,
tm_mostrar_resp        varchar(1)   null

	)
if not exists (select 1 from  sysindexes
           where  id    = object_id('bv_b2c_tipo_msg')
            and   name  = 'idx1'
            and   indid > 0
            and   indid < 255)
	create index idx1 on bv_b2c_tipo_msg (tm_tipo_msg)
go

if not exists (select 1 from sysobjects where type = 'U' and name = 'bv_b2c_msg')
	create table bv_b2c_msg (
	ms_cliente     int           not null,
	ms_banco       cuenta        not null,
	ms_msg_id      int           not null identity(1,1),
	ms_tipo_msg    varchar(24)   not null,
	ms_texto       varchar(1000) not null,
	ms_fecha_ing   datetime      not null,
	ms_fecha_envio datetime      null,
	ms_fecha_ven   datetime      null,
	ms_trespuesta  catalogo      not null,
	ms_otp         char(1)       not null,
	ms_var1        varchar(64)   null,
	ms_var2        varchar(64)   null,
	ms_var3        varchar(64)   null,
	ms_var4        varchar(64)   null,
	ms_var5        varchar(64)   null,
	ms_fecha_resp  datetime      null,
	ms_respuesta   catalogo      null --NULL=No ha respondido, S=OK o SI, N=No
	)
go
if not exists (select 1 from  sysindexes
           where  id    = object_id('bv_b2c_msg')
            and   name  = 'idx1'
            and   indid > 0
            and   indid < 255)
create unique index idx1 on bv_b2c_msg (ms_cliente, ms_msg_id)
go

print 'Tabla para OTP'
use cobis
go

print 'se_token'
if object_id('se_token') is null
	create table se_token (
	  to_servicio        int           not null,
	  to_usuario         varchar(128)  not null,
	  to_token_value     varchar(256)  not null,
	  to_fecha_cre       datetime not null
	)
go
if object_id('se_token_his') is null
	create table se_token_his (
	  hto_servicio        int           not null,
	  hto_usuario         varchar(128)  not null,
	  hto_token_value     varchar(256)  not null,
	  hto_fecha_cre       datetime not null
	)
go

use cobis
go

print 'Crea indices'

if not exists (select 1 from sysindexes where name = 'i_se_token')
	create nonclustered index i_se_token on se_token (to_servicio,to_usuario,to_token_value,to_fecha_cre)
go

if not exists (select 1 from sysindexes where name = 'i_se_token_his')
	create nonclustered index i_se_token_his on se_token_his (hto_servicio,hto_usuario,hto_token_value,hto_fecha_cre)
go

------------------------------------------------------------------------------------------
-- CLOUD DESARROLLO 117291
-- Creacion de tabla bv_info_device para informacion de dispositivos
------------------------------------------------------------------------------------------
if exists (select 1 from sysobjects where name = 'bv_info_device')
begin
	drop table  cob_bvirtual..bv_info_device
end
print 'Creando tabla bv_info_device'
create table cob_bvirtual..bv_info_device (
    in_sequential		int,
	in_ente_cli			int,
	in_login			varchar(64) not null,
	in_brand_device     varchar(255),
	in_model_device     varchar(255),
	in_version_os       varchar(255),
	in_carrier          varchar(255),
	in_date_register    datetime
)
print 'Creando indice-->bv_info_device.bv_info_device_Key'
if exists (select 1 from sysindexes where name = 'bv_info_device_Key')
begin
	drop index bv_info_device_Key on cob_bvirtual..bv_info_device
end
create index bv_info_device_Key
on bv_info_device(
    in_login,
	in_sequential,
	in_ente_cli	
)
go
print 'bv_catg_img'

if object_id ('bv_catg_img') is not null
    drop table bv_catg_img
go

create table bv_catg_img
(
	ci_id          int not null,
	ci_imagen      varchar (max) not null,
	ci_nombre_arch varchar (64) not null,
	ci_estado	   char(1) not null
)
go

-- Crear tabla temporal bv_temp_tran_servicio
if object_id('cob_bvirtual..bv_temp_tran_servicio') is not null
    drop table cob_bvirtual..bv_temp_tran_servicio
GO

CREATE TABLE bv_temp_tran_servicio(
tts_secuencial       varchar(75) null,
tts_cliente          varchar(75) null,
tts_buc              varchar(75) null,
tts_fecha            varchar(75) null,
tts_hora             varchar(75) null,
tts_tipo_transaccion varchar(240) null,
tts_monto            varchar(75) null,
tts_ref_interna      varchar(240) null,
tts_ref_externa      varchar(240) null,
tts_ip_origen        varchar(240) null)
GO

if exists(select 1 from sys.indexes where name = 'bv_tran_servicio_idx1' and object_id = OBJECT_ID('bv_temp_tran_servicio'))
    DROP INDEX bv_tran_servicio_idx1 on [dbo].[bv_temp_tran_servicio]
else
    CREATE NONCLUSTERED INDEX [bv_tran_servicio_idx1] on [dbo].[bv_temp_tran_servicio] (
        [ts_int01] ASC, 
        [ts_fecha] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


--Requerimiento #158566

if object_id('cob_bvirtual..bv_b2c_token_tmp') is not null
   drop table cob_bvirtual..bv_b2c_token_tmp

create table bv_b2c_token_tmp (
   tt_token      varchar(10)  not null,
   tt_ente       int          not null
)


if object_id('cob_bvirtual..bv_b2c_registro_tmp') is not null
   drop table cob_bvirtual..bv_b2c_registro_tmp


create table bv_b2c_registro_tmp (
   rt_registro   varchar(10)  not null,
   rt_ente       int          not null
)

go


if object_id('cob_bvirtual..bv_geolocaliza_operacion') is not null
   drop table cob_bvirtual..bv_geolocaliza_operacion

CREATE TABLE bv_geolocaliza_operacion (
	go_ssn int NOT NULL,
	go_login varchar(14) NOT NULL,
	go_tipo_tran varchar(10) NOT NULL,
	go_tipo_serv varchar(10) NOT NULL,
	go_aplicativo varchar(11) NOT NULL,
	go_longitud varchar(20) NOT NULL,
	go_latitud varchar(20) NOT NULL,
	go_ente int NULL,
	go_fecha datetime NULL, 
	go_fecha_proceso datetime NULL,
	go_estado varchar(20) NULL)
);

CREATE NONCLUSTERED INDEX idx_geoloc_oper_main ON bv_geolocaliza_operacion (go_login);
CREATE NONCLUSTERED INDEX idx_geoloc_oper_ssn ON bv_geolocaliza_operacion (go_ssn);



if object_id('cob_bvirtual..bv_trans_api_detalles') is not null
   drop table cob_bvirtual..bv_trans_api_detalles

CREATE TABLE bv_trans_api_detalles (
	ad_codigo varchar(20) NULL,
	ad_valor varchar(50) NULL,
	ad_ruta varchar(100) NULL,
	ad_tipo varchar(20) NULL
);


INSERT INTO bv_trans_api_detalles
(ad_codigo, ad_valor, ad_ruta, ad_tipo)
VALUES('GENIP', 'GENERACION DE NIP', 'orchestation/onboarding', 'POST');

INSERT INTO bv_trans_api_detalles
(ad_codigo, ad_valor, ad_ruta, ad_tipo)
VALUES('AUTSE', 'AUTORIZACION DE SEGURO', '/customer/saveLifeInsurance', 'POST');

INSERT INTO bv_trans_api_detalles
(ad_codigo, ad_valor, ad_ruta, ad_tipo)
VALUES('SOLCO', 'AUTORIZACION DE CONTRATO ', '/capture/fingerprint', 'POST');

INSERT INTO bv_trans_api_detalles
(ad_codigo, ad_valor, ad_ruta, ad_tipo)
VALUES('AUTBU', 'AUTORIZACION DE BURO DE CREDITO', '/customer/evaluation', 'POST');

-- -------------------------------------------------------------------------------------------------
-- Req 193221
-- CLOUD_191122_707383_vulnerabilidades\src\be\applications\mobileapp\b2c\updates\CLOUD_191122_688882\01_REM_bv_table.sql


use cob_bvirtual
go

if (OBJECT_ID('bv_otp_seguridad')) IS NOT NULL
    drop table bv_otp_seguridad
go
create table bv_otp_seguridad(
   se_tipo               varchar   (10) not null,
   se_codigo             int            not null,
   se_canal              varchar   (10) not null,
   se_num_mail           varchar   (70) not null,
   se_fecha_ingreso      datetime       not null,
   se_fecha_vencimiento  datetime       null
)
go

-- CLOUD_191122_707383_vulnerabilidades\src\be\clientes\updates\CLOUD_191122_707383\1. REM_cl_table.sql
use cob_bvirtual
go

--TABLA DETALLE PROCESO
IF OBJECT_ID('bv_trans_detalle_proceso') IS NOT NULL
    DROP TABLE bv_trans_detalle_proceso
CREATE TABLE bv_trans_detalle_proceso (
    tdp_id int null, -- ente
    tdp_id_proceso int NULL,
    tdp_id_actividad int NULL,
    tdp_id_pantalla int NULL, -- revisar tipo de dato
    tdp_estado char(1) NULL,
    tdp_fecha_ingreso datetime NULL,
    tdp_fecha_terminado datetime NULL,
	tdp_fecha_proceso datetime NULL,
)

--TABLA DETALLE CONSULTA
IF OBJECT_ID('bv_trans_detalle_consulta') IS NOT NULL
    DROP TABLE bv_trans_detalle_consulta
CREATE TABLE bv_trans_detalle_consulta (
    tdc_id int IDENTITY(1,1) PRIMARY KEY,
    tdc_id_actividad int NULL,
	tdc_id_sp  int,
	tdc_fecha_ingreso datetime NULL,
	)
	
insert into bv_trans_detalle_consulta(tdc_id_actividad, tdc_id_sp, tdc_fecha_ingreso) values (1, 1, getdate()) -- Captura domicilio
insert into bv_trans_detalle_consulta(tdc_id_actividad, tdc_id_sp, tdc_fecha_ingreso) values (2, 2, getdate()) -- Captura domicilio
insert into bv_trans_detalle_consulta(tdc_id_actividad, tdc_id_sp, tdc_fecha_ingreso) values (3, 0, getdate()) -- Captura domicilio
insert into bv_trans_detalle_consulta(tdc_id_actividad, tdc_id_sp, tdc_fecha_ingreso) values (4, 0, getdate()) -- Captura domicilio
insert into bv_trans_detalle_consulta(tdc_id_actividad, tdc_id_sp, tdc_fecha_ingreso) values (5, 0, getdate()) -- Captura domicilio

--TABLA ACTIVIDADES
IF OBJECT_ID('bv_trans_actividades') IS NOT NULL
    DROP TABLE bv_trans_actividades
CREATE TABLE bv_trans_actividades(
    ta_id int IDENTITY(1,1) PRIMARY KEY, -- Secuencial
    ta_actividad varchar(250) NULL
)

--INSERT ACTIVIDADES - inserta la actividades principales del documento 
INSERT INTO cob_bvirtual.dbo.bv_trans_actividades(ta_actividad) VALUES('Captura domicilio')
INSERT INTO cob_bvirtual.dbo.bv_trans_actividades(ta_actividad) VALUES('Formulario KYC')
INSERT INTO cob_bvirtual.dbo.bv_trans_actividades(ta_actividad) VALUES('Oferta Producto + Simulación')
INSERT INTO cob_bvirtual.dbo.bv_trans_actividades(ta_actividad) VALUES('Autorización Buro + Toma de Huellas')
INSERT INTO cob_bvirtual.dbo.bv_trans_actividades(ta_actividad) VALUES('Datos Generales + Selección cuenta Altair')


-- TABLA PANTALLAS
IF OBJECT_ID('bv_trans_pantallas') IS NOT NULL
    DROP TABLE bv_trans_pantallas
CREATE TABLE bv_trans_pantallas(
    tpa_id int IDENTITY(1,1) PRIMARY KEY,
    tpa_pantalla varchar(250) NULL
)

--INSERT PANTALLAS
INSERT INTO bv_trans_pantallas(tpa_pantalla)VALUES('Captura domicilio')
INSERT INTO bv_trans_pantallas(tpa_pantalla)VALUES('Formulario KYC')
INSERT INTO bv_trans_pantallas(tpa_pantalla)VALUES('Oferta producto')
INSERT INTO bv_trans_pantallas(tpa_pantalla)VALUES('Simulacion')
INSERT INTO bv_trans_pantallas(tpa_pantalla)VALUES('Autorizacion Buro')
INSERT INTO bv_trans_pantallas(tpa_pantalla)VALUES('Toma Huellas - Buro')
INSERT INTO bv_trans_pantallas(tpa_pantalla)VALUES('Resultado de evaluacion')
INSERT INTO bv_trans_pantallas(tpa_pantalla)VALUES('Datos Generales')
INSERT INTO bv_trans_pantallas(tpa_pantalla)VALUES('Captura cuenta Altair')

-- TABLA PROCESOS
IF OBJECT_ID('bv_trans_procesos') IS NOT NULL
    DROP TABLE bv_trans_procesos
CREATE TABLE bv_trans_procesos(
    tp_id int , -- Secuencial
    tp_id_cliente int NULL,
	tp_fecha_ini datetime NULL,
	tp_fecha_fin datetime NULL
)

IF OBJECT_ID('bv_trans_sp') IS NOT NULL
    DROP TABLE bv_trans_sp
CREATE TABLE bv_trans_sp(
    ts_id int IDENTITY(1,1) PRIMARY KEY,
    ts_nombre_sp varchar(250) NULL,
    ts_base_datos varchar(128) NULL
)

INSERT INTO bv_trans_sp(ts_nombre_sp,ts_base_datos)VALUES('sp_consulta_datos_cliente','cobis')
INSERT INTO bv_trans_sp(ts_nombre_sp,ts_base_datos)VALUES('sp_consulta_kyc','cobis')

--TABLA pantalla - actividad --  relacionar las pantallas con las actividades
IF OBJECT_ID('bv_trans_detalle_pantalla_actividad') IS NOT NULL
    DROP TABLE bv_trans_detalle_pantalla_actividad
CREATE TABLE bv_trans_detalle_pantalla_actividad (
    tdpa_id int IDENTITY(1,1) PRIMARY KEY,
    tdpa_id_actividad int NULL,
	tdpa_act_anterior int null,
    tdpa_id_pantalla varchar(20) NULL,
	tdpa_orden  smallint null
	
)

-- Actividad 1    Captura domicilio
insert into bv_trans_detalle_pantalla_actividad(tdpa_id_actividad, tdpa_act_anterior, tdpa_id_pantalla,  tdpa_orden) values (1, 0, 1,  1) -- Captura domicilio
-- Actividad 2    Formulario KYC
insert into bv_trans_detalle_pantalla_actividad(tdpa_id_actividad, tdpa_act_anterior, tdpa_id_pantalla,  tdpa_orden) values (2, 1, 2,  1) -- Formulario KYC
-- Actividad 3    Oferta Producto + Simulación
insert into bv_trans_detalle_pantalla_actividad(tdpa_id_actividad, tdpa_act_anterior, tdpa_id_pantalla,  tdpa_orden) values (3, 2, 3,  1) -- Oferta producto
insert into bv_trans_detalle_pantalla_actividad(tdpa_id_actividad, tdpa_act_anterior, tdpa_id_pantalla,  tdpa_orden) values (3, 2, 4,  2) -- Simulacion
-- Actividad 4    Autorización Buro + Toma de Huellas
insert into bv_trans_detalle_pantalla_actividad(tdpa_id_actividad, tdpa_act_anterior, tdpa_id_pantalla,  tdpa_orden) values (4, 3, 5,  1) -- Autorizacion Buro
insert into bv_trans_detalle_pantalla_actividad(tdpa_id_actividad, tdpa_act_anterior, tdpa_id_pantalla,  tdpa_orden) values (4, 3, 6,  2) -- Toma Huellas - Buro
insert into bv_trans_detalle_pantalla_actividad(tdpa_id_actividad, tdpa_act_anterior, tdpa_id_pantalla,  tdpa_orden) values (4, 3, 7,  3) -- Resultado de evaluacion
-- Actividad 5    Datos Generales + Selección cuenta Altair
insert into bv_trans_detalle_pantalla_actividad(tdpa_id_actividad, tdpa_act_anterior, tdpa_id_pantalla,  tdpa_orden) values (5, 4, 8,  1) -- Datos Generales
insert into bv_trans_detalle_pantalla_actividad(tdpa_id_actividad, tdpa_act_anterior, tdpa_id_pantalla,  tdpa_orden) values (5, 4, 9,  2) -- Captura cuenta Altair

go



