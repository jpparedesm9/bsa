use cob_cartera
GO

if object_id ('dbo.ca_ns_sms_cobranzas') is not null
	drop table dbo.ca_ns_sms_cobranzas
go
CREATE TABLE [dbo].[ca_ns_sms_cobranzas]  ( 
	[nsc_dia]      	    tinyint NOT NULL,
	[nsc_operacion]	    int NOT NULL,
	[nsc_cliente]  	    int NULL,
	[nsc_num_telf] 	    varchar(12) NULL,
	[nsc_bloque]   	    int NULL,
	[nsc_plantilla]	    varchar(25) NULL,
    [nsc_grupo]	        int NULL,
    [nsc_fecha_ven]     date NULL,
    [nsc_rol_cliente]   char(1) NULL,
	[nsc_fecha_ing]     date null,
    [nsc_estado]        char(1) NULL,
    [nsc_fecha_env]     date NULL,

)

create index idx1_sms_cobranzas on ca_ns_sms_cobranzas(nsc_dia,nsc_operacion,nsc_fecha_env)
create index idx2_idx1_sms_cobranzas on ca_ns_sms_cobranzas(nsc_estado)
create index idx3_idx1_sms_cobranzas on ca_ns_sms_cobranzas(nsc_fecha_ing)

GO


if object_id ('dbo.ca_ns_sms_recordatorios') is not null
	drop table dbo.ca_ns_sms_recordatorios
go
CREATE TABLE [dbo].[ca_ns_sms_recordatorios]  ( 
	[nsr_operacion]    	int NULL,
	[nsr_cliente]      	int NULL,
	[nsr_num_telf]     	varchar(12) NULL,
	[nsr_bloque]       	int NULL,
	[nsr_plantilla]    	varchar(25) NULL,
	[nsr_grupo]        	int NULL,
    [nsr_num_dia]     	int NULL,
	[nsr_fecha_ejec]   	date NULL,
    [nsr_nom_dia]       varchar(25),
	[nsr_fecha_ven_hab]	date NULL,
	[nsr_rol_cliente]  	char(1) NULL,
	[nsc_fecha_ing]     date null,
	[nsr_estado]       	char(1) NULL,
	[nsr_fecha_env]    	date NULL 
	)

create index idx1_sms_recordatorio on ca_ns_sms_recordatorios(nsr_estado,nsc_fecha_ing,nsr_fecha_env,nsr_operacion,nsr_cliente)
GO
--------------------------------------------------------------- Historicas ---------------------------------------------------------------------
use cob_cartera_his
GO

if object_id ('dbo.ca_ns_sms_cobranzas_his') is not null
	drop table dbo.ca_ns_sms_cobranzas_his
go
CREATE TABLE [dbo].[ca_ns_sms_cobranzas_his]  ( 
	[nsc_dia]      	    tinyint NOT NULL,
	[nsc_operacion]	    int NOT NULL,
	[nsc_cliente]  	    int NULL,
	[nsc_num_telf] 	    varchar(12) NULL,
	[nsc_bloque]   	    int NULL,
	[nsc_plantilla]	    varchar(25) NULL,
    [nsc_grupo]	        int NULL,
    [nsc_fecha_ven]     date NULL,
    [nsc_rol_cliente]   char(1) NULL,
	[nsc_fecha_ing]     date null,
    [nsc_estado]        char(1) NULL,
    [nsc_fecha_env]     date NULL,

)

create index idx1_sms_cobranzas_his on ca_ns_sms_cobranzas_his(nsc_dia,nsc_operacion,nsc_fecha_env)
create index idx2_idx1_sms_cobranzas_his on ca_ns_sms_cobranzas_his(nsc_estado)
create index idx3_idx1_sms_cobranzas_his on ca_ns_sms_cobranzas_his(nsc_fecha_ing)


GO

if object_id ('dbo.ca_ns_sms_recordatorios_his') is not null
	drop table dbo.ca_ns_sms_recordatorios_his
go
CREATE TABLE [dbo].[ca_ns_sms_recordatorios_his]  ( 
	[nsr_operacion]    	int NULL,
	[nsr_cliente]      	int NULL,
	[nsr_num_telf]     	varchar(12) NULL,
	[nsr_bloque]       	int NULL,
	[nsr_plantilla]    	varchar(25) NULL,
	[nsr_grupo]        	int NULL,
    [nsr_num_dia]     	int NULL,
	[nsr_fecha_ejec]   	date NULL,
    [nsr_nom_dia]       varchar(25),
	[nsr_fecha_ven_hab]	date NULL,
	[nsr_rol_cliente]  	char(1) NULL,
	[nsc_fecha_ing]     date null,
	[nsr_estado]       	char(1) NULL,
	[nsr_fecha_env]    	date NULL 
	)

create index idx1_sms_recordatorio_his on ca_ns_sms_recordatorios_his(nsr_estado,nsc_fecha_ing,nsr_fecha_env,nsr_operacion,nsr_cliente)
GO