use cob_cartera
go

if not exists (select 1 from sys.columns 
           where Name = N'se_usuario'
           and Object_ID = Object_ID(N'ca_seguro_externo')) begin
   alter table ca_seguro_externo
   add se_usuario     varchar(14) null
end   


if not exists (select 1 from sys.columns 
           where Name = N'se_terminal'
           and Object_ID = Object_ID(N'ca_seguro_externo')) begin
   alter table ca_seguro_externo
   add se_terminal     varchar(64) null
end
  
go

use cob_cartera
go

IF OBJECT_ID ('dbo.ca_infosegurogrupo_det') IS NOT NULL
	DROP TABLE dbo.ca_infosegurogrupo_det
GO

CREATE TABLE dbo.ca_infosegurogrupo_det
	(
	isd_cliente            INT NULL,
	isd_nombre_cliente     VARCHAR (500) NULL,
	isd_monto_seguro       MONEY NULL,
	isd_monto_asist_medica MONEY NULL,
	isd_monto_garantia     MONEY NULL,
	isd_grupo              INT NULL,
	isd_tramite            INT NULL
	)
GO

CREATE INDEX idx_isd_grupo ON dbo.ca_infosegurogrupo_det (isd_grupo)
CREATE INDEX idx_isd_tramite ON dbo.ca_infosegurogrupo_det (isd_tramite)

GO


use cob_cartera_his
go

if exists (select 1 from sysobjects where name = 'ca_seguro_externo_his')
   drop table ca_seguro_externo_his
go

create table ca_seguro_externo_his (
   seh_secuencial          INT identity (1,1),
   seh_operacion           char(1),
   seh_fecha               datetime,
   seh_usuario             varchar(14),
   seh_terminal            varchar(64),
   seh_banco               varchar(24)  NULL,
   seh_cliente             INT          NULL,
   seh_fecha_ini           DATETIME     NULL,
   seh_fecha_ult_intento   DATETIME     NULL,
   seh_monto               MONEY        NULL,
   seh_estado              CHAR (1)     NULL,
   seh_fecha_reporte       DATETIME     NULL,
   seh_tramite             INT          NULL,
   seh_grupo               INT          NULL,
   seh_monto_pagado        MONEY        NULL,
   seh_monto_devuelto      MONEY        NULL,
   seh_forma_pago          varchar (16) NULL,
   seh_tipo_seguro         varchar (16) NULL,
   seh_monto_basico        MONEY        NULL
   
)


create index idx_1 on ca_seguro_externo_his (seh_tramite, seh_cliente, seh_secuencial)
create index idx_2 on ca_seguro_externo_his (seh_tramite)
go

 