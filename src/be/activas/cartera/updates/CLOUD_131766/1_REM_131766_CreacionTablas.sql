use cob_conta_super
go
--sb_dato_operacion
--alter table sb_dato_operacion  drop column do_fecha_ven_orig
--alter table sb_dato_operacion  drop column do_fecha_can_ant
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name IN( N'do_fecha_ven_orig', N'do_fecha_can_ant')
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_dato_operacion'))
begin
   alter table sb_dato_operacion  add do_fecha_ven_orig    datetime  
   alter table sb_dato_operacion  add do_fecha_can_ant    datetime  
end
go

--sb_dato_operacion_tmp
--alter table sb_dato_operacion_tmp  drop column do_fecha_ven_orig
--alter table sb_dato_operacion_tmp  drop column do_fecha_can_ant
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name IN( N'do_fecha_ven_orig', N'do_fecha_can_ant')
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_dato_operacion_tmp'))
begin
   alter table sb_dato_operacion_tmp  add do_fecha_ven_orig    datetime  
   alter table sb_dato_operacion_tmp  add do_fecha_can_ant    datetime  
end
go

--sb_ods01

IF OBJECT_ID ('dbo.sb_ods01_tmp') IS NOT NULL
	DROP TABLE dbo.sb_ods01_tmp
GO
CREATE TABLE dbo.sb_ods01_tmp
	(
	campo01 VARCHAR (50) NULL,
	campo02 VARCHAR (50) NULL,
	campo03 VARCHAR (50) NULL,
	campo04 VARCHAR (50) NULL,
	campo05 VARCHAR (50) NULL,
	campo06 VARCHAR (50) NULL,
	campo07 VARCHAR (50) NULL,
	campo08 VARCHAR (50) NULL,
	campo09 VARCHAR (50) NULL,
	campo10 VARCHAR (50) NULL,
	campo11 VARCHAR (50) NULL,
	campo12 VARCHAR (50) NULL,
	campo13 VARCHAR (50) NULL,
	campo14 VARCHAR (50) NULL,
	campo15 VARCHAR (50) NULL,
	campo16 VARCHAR (50) NULL,
	campo17 VARCHAR (50) NULL,
	campo18 VARCHAR (50) NULL,
	campo19 VARCHAR (50) NULL,
	campo20 VARCHAR (50) NULL,
	campo21 VARCHAR (50) NULL,
	campo22 VARCHAR (50) NULL,
	campo23 VARCHAR (50) NULL,
	campo24 VARCHAR (50) NULL,
	campo25 VARCHAR (50) NULL,
	campo26 VARCHAR (50) NULL,
	campo27 VARCHAR (50) NULL,
	campo28 VARCHAR (50) NULL,
	campo29 VARCHAR (50) NULL,
    campo30 VARCHAR (50) NULL,
	campo31 VARCHAR (50) NULL,
	campo32 VARCHAR (50) NULL,
	campo33 VARCHAR (50) NULL,
	campo34 VARCHAR (50) NULL,
	campo35 VARCHAR (50) NULL,
	campo36 VARCHAR (50) NULL,
	campo37 VARCHAR (50) NULL,
	campo38 VARCHAR (50) NULL,
	campo39 VARCHAR (50) NULL,
	campo40 VARCHAR (50) NULL
	)
GO


use cob_externos
go
--ex_dato_operacion
--alter table ex_dato_operacion  drop column do_fecha_ven_orig
--alter table ex_dato_operacion  drop column do_fecha_can_ant
if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name IN( N'do_fecha_ven_orig', N'do_fecha_can_ant')
                  AND Object_ID = Object_ID(N'cob_externos..ex_dato_operacion'))
begin
   alter table ex_dato_operacion    add do_fecha_ven_orig    datetime  
   alter table ex_dato_operacion    add do_fecha_can_ant    datetime 
end
go



