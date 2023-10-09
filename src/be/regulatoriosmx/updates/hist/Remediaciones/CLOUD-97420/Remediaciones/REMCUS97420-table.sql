use cobis
go

IF OBJECT_ID ('dbo.cl_solicitud_traspaso_tmp') IS NOT NULL
	DROP TABLE dbo.cl_solicitud_traspaso_tmp
GO

create table cl_solicitud_traspaso_tmp (
st_es_grupo		char,
st_fun_origen   login,
st_fun_destino	login,
st_ofi_origen	int,
st_ofi_destino	int,
st_usuario		login,
st_usuario_rol	int,
cs_ente			int
)
go

IF OBJECT_ID ('dbo.cl_solicitud_traspaso') IS NOT NULL
	DROP TABLE dbo.cl_solicitud_traspaso
GO

create table cl_solicitud_traspaso (
st_solicitud	int,
st_es_grupo		char,
st_fun_origen   login,
st_fun_destino	login,
st_ofi_origen	int,
st_ofi_destino	int,
st_usuario		login,
st_usuario_rol	int,
st_motivo_tras	catalogo null,
st_otro_motivo	varchar(50) null,
st_fecha		datetime null,
st_hora			datetime null,
st_razon_rechazo varchar(255) null,
st_estado		char(1) null
)
go

IF OBJECT_ID ('dbo.cl_cli_sol_traspaso') IS NOT NULL
	DROP TABLE dbo.cl_cli_sol_traspaso
GO

create table cl_cli_sol_traspaso (
cs_solicitud	int not null,
cs_ente			int not null
)
go


--------------------------------------------------------------------------------------------
-- CREAR TABLAS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 

use cob_cartera
go
if object_id ('dbo.ca_traslados_cartera') is not null
	drop table dbo.ca_traslados_cartera
go
create table dbo.ca_traslados_cartera
	(
	trc_fecha_proceso   datetime not null,
	trc_cliente         int not null,
	trc_operacion       int not null,
	trc_user            login not null,
	trc_oficina_origen  int not null,
	trc_oficina_destino int not null,
	trc_estado          varchar (2) not null,
	trc_garantias       char (1) not null,
	trc_credito         char (1) not null,
	trc_sidac           char (1) not null,
	trc_fecha_ingreso   datetime not null,
	trc_secuencial_trn  int null,
	trc_oficial_destino smallint not null,
	trc_oficial_origen  smallint not null,
	trc_saldo_capital   money not null
	)
go
create unique nonclustered index ca_traslados_cartera_1
	on dbo.ca_traslados_cartera (trc_operacion,trc_cliente,trc_fecha_proceso)
go
create nonclustered index ca_traslados_cartera_2
	on dbo.ca_traslados_cartera (trc_cliente,trc_fecha_proceso)
go
create nonclustered index ca_traslados_cartera_3
	on dbo.ca_traslados_cartera (trc_fecha_proceso)
go
grant select on dbo.ca_traslados_cartera to consulta
go

--------------------------------------------------------------------------------------------
-- CREAR TABLA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 
use cobis
go

IF OBJECT_ID ('dbo.cl_ns_traspaso') IS NOT NULL
	DROP TABLE dbo.cl_ns_traspaso
go

create table cl_ns_traspaso
	(
	nt_traspaso_id         int not null,
	nt_codigo              int not null,
	nt_oficial             int not null,
	nt_oficial_niega       int not null,
	nt_correo              varchar(64) null,
	nt_estado              char(1) null
	)
go

CREATE UNIQUE CLUSTERED INDEX cl_ns_traspaso_Key
	ON dbo.cl_ns_traspaso (nt_codigo, nt_traspaso_id)
go

--------------------------------------------------------------------------------------------
-- Insertar en tabla de secuenciales
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/ASP/CLOUD/Iss/CLOUD-93703/RegulatoriosMX/sql
--Nombre Archivo             : reg_tabla.sql


use cobis
go


DELETE cobis..cl_seqnos where bdatos = 'cobis' and tabla = 'cl_ns_traspaso'

INSERT INTO dbo.cl_seqnos (bdatos, tabla, siguiente, pkey)
VALUES ('cobis', 'cl_ns_traspaso', 0, 'nt_codigo')
go



