use cob_conta_super
go
--sb_dato_operacion
--alter table sb_dato_operacion  drop column do_fecha_ven_orig
--alter table sb_dato_operacion  drop column do_fecha_can_ant
if  exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name IN( N'do_fecha_ven_orig', N'do_fecha_can_ant')
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_dato_operacion'))
begin
   alter table sb_dato_operacion  drop column do_fecha_ven_orig
   alter table sb_dato_operacion  drop column do_fecha_can_ant
end
go

--sb_dato_operacion_tmp
--alter table sb_dato_operacion_tmp  drop column do_fecha_ven_orig
--alter table sb_dato_operacion_tmp  drop column do_fecha_can_ant
if  exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name IN( N'do_fecha_ven_orig', N'do_fecha_can_ant')
                  AND Object_ID = Object_ID(N'cob_conta_super..sb_dato_operacion_tmp'))
begin
   alter table sb_dato_operacion_tmp  drop column do_fecha_ven_orig
   alter table sb_dato_operacion_tmp  drop column do_fecha_can_ant
end
go

--sb_ods01

IF OBJECT_ID ('dbo.sb_ods01_tmp') IS NOT NULL
	DROP TABLE dbo.sb_ods01_tmp
GO

use cob_externos
go
--ex_dato_operacion
--alter table ex_dato_operacion  drop column do_fecha_ven_orig
--alter table ex_dato_operacion  drop column do_fecha_can_ant
if  exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name IN( N'do_fecha_ven_orig', N'do_fecha_can_ant')
                  AND Object_ID = Object_ID(N'cob_externos..ex_dato_operacion'))
begin
  alter table ex_dato_operacion  drop column do_fecha_ven_orig
  alter table ex_dato_operacion  drop column do_fecha_can_ant
end
go



