USE cob_sincroniza
go

IF EXISTS(SELECT 1 FROM  sysobjects WHERE name = 'si_sincroniza')
 DROP TABLE si_sincroniza
GO

CREATE TABLE si_sincroniza (
si_secuencial   INT NOT NULL unique,           -- SECUENCIAL DEL REGISTRO 
si_cod_entidad  VARCHAR(10) NOT NULL, -- CODIGO DEL CATALOGO DE LA ENTIDAD
si_des_entidad  VARCHAR(64) NOT NULL, -- DESCRIPCION DE LA ENTIDAD - DEL CATALOGO
si_usuario      VARCHAR(20) NOT NULL, -- DUEÑO DE LA INFOMACION
si_estado       VARCHAR(10)  NOT NULL, -- ESTADO DE LA SINCRONIZACION
si_fecha_ing    DATETIME NOT NULL,  -- FECHA DE GENERACION DE LA INFORMACION
si_fecha_sin    DATETIME  NULL,   -- FECHA DE LA SINCRONIZACION
si_num_reg      INT NOT NULL   -- TOTAL DE REGISTROS ENVIADOS A SINCRONIZAR
)
GO

CREATE CLUSTERED INDEX idx_1 ON si_sincroniza(si_secuencial)
GO

CREATE INDEX idx_2 ON si_sincroniza(si_secuencial, si_cod_entidad, si_fecha_ing )
GO

IF EXISTS(SELECT 1 FROM  sysobjects WHERE name = 'si_sincroniza_det')
 DROP TABLE si_sincroniza_det
GO

CREATE TABLE si_sincroniza_det (
sid_id           INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
sid_secuencial   INT NOT NULL,  -- SECUENCIAL DEL REGISTRO
sid_id_entidad   INT NOT NULL,  -- id de la entidad // 
sid_id_1         INT NOT NULL,  -- id alterno 1 // 
sid_id_2         INT NOT NULL,  -- id alterno 2 // 
sid_xml          xml NOT NULL,  -- XML CON LA INFORMACION
sid_accion       VARCHAR(255) NOT NULL,  -- ACCION A REALIZAR
sid_observacion  VARCHAR(5000) NULL,  -- DETALLE DE LA 
sid_descargado   BIT NULL DEFAULT 0  -- ESTADO DE DESCARGA
)

GO
CREATE INDEX idx_1 ON si_sincroniza_det(sid_secuencial)
GO





PRINT '<<<<< DROPPING TABLES >>>>>'

IF EXISTS (SELECT 1 FROM sysobjects o, sysusers u WHERE o.uid=u.uid AND o.name = 'mo_device' AND u.name = 'dbo' AND o.type = 'U')
    DROP TABLE mo_device
go

PRINT '<<<<< CREATING TABLE "cob_sincroniza..mo_device" >>>>>'
go

create table mo_device(
  de_alias varchar(45) null, -- alias del device
  de_device_id varchar(45)  not null, --  imei del dispositivo
  de_login varchar(25) not null, -- correspondiente al cl_funcionario
  de_status char not null, --catalogo device status del device
  PRIMARY KEY CLUSTERED (de_device_id)
)
go

---------------------------------------
--Crear tabla de dispositivos móviles--
---------------------------------------

IF OBJECT_ID ('dbo.si_dispositivo') IS NOT NULL
	DROP TABLE dbo.si_dispositivo
go

CREATE TABLE dbo.si_dispositivo
	(
	di_codigo             int NOT NULL,
	di_tipo               varchar(10) NOT null,
	di_imei               varchar(45) NULL,
	di_macaddress         varchar(60) NOT NULL,
	di_oficial            varchar(10) NOT NULL,
	di_login              login NOT NULL,
	di_estado             char(1) NOT NULL,
	di_alias              varchar(45),
	di_fecha_reg          datetime NOT NULL,
	di_usuario_reg        login,
	di_permitir_matricula char(1) null
	)
go

CREATE UNIQUE CLUSTERED INDEX si_dispositivo_Key
	ON dbo.si_dispositivo (di_codigo)
go

use cob_sincroniza
go

--print 'tabla -----> '

if exists (select 1
           from   sysobjects 
           where  id   = object_id('si_terminal')
           and    type = 'U')
   drop table si_terminal
go

--print 'CREATING... table -----> si_terminal '

create table si_terminal 
(

te_mac varchar(30) not null,
te_mac1 varchar(30) null,
te_mac2 varchar(30) null,
te_reference1 varchar(50) null,
te_reference2 varchar(50) null
)
go

CREATE UNIQUE CLUSTERED INDEX si_terminal_Key
	ON dbo.si_terminal (te_mac)
go


IF EXISTS (select * from sys.objects where name = 'si_sincroniza_batch' and [type] = 'u')
	DROP TABLE si_sincroniza_batch
go

CREATE TABLE si_sincroniza_batch (
	sb_secuencial		int NOT NULL,
	sb_estado			varchar(10) NOT NULL,
	sb_usuario_registro	varchar(20) NOT NULL,
	sb_fecha_registro	datetime NOT NULL,
	sb_oficial			int NOT NULL,
	sb_fecha_ultima_sincronizacion	datetime NULL,
	CONSTRAINT pk_si_sincroniza_batch PRIMARY KEY (sb_secuencial)
)
go

CREATE TABLE si_catalog_synchronization (
	sc_catalog_name varchar(30) NOT NULL,
	sc_synchronization_date datetime NOT NULL
)
GO