use cob_conta_super
go
 
--instalador referencia src/be/regulatoriosmx/installer/sql/reg_tabla.sql
 
IF OBJECT_ID ('dbo.sb_ods01_tti') IS NOT NULL
	DROP TABLE dbo.sb_ods01_tti
GO

CREATE TABLE dbo.sb_ods01_tti
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
	campo38 VARCHAR (50) NULL
	)
GO

 
--Instalador en  \bsa\src\be\regulatoriosmx\installer\sql\cbsup_table.sql
 
if not exists (select 1  from   INFORMATION_SCHEMA.COLUMNS  where  table_name = 'sb_dato_operacion' and column_name = 'do_cupo_original'   )   alter table sb_dato_operacion    add do_cupo_original    money     go
if not exists (select 1  from   INFORMATION_SCHEMA.COLUMNS  where  table_name = 'sb_dato_operacion' and column_name = 'do_importe_ult_vto' )   alter table sb_dato_operacion    add do_importe_ult_vto  money     go
if not exists (select 1  from   INFORMATION_SCHEMA.COLUMNS  where  table_name = 'sb_dato_operacion' and column_name = 'do_importe_pri_vto' )   alter table sb_dato_operacion    add do_importe_pri_vto  money     go
if not exists (select 1  from   INFORMATION_SCHEMA.COLUMNS  where  table_name = 'sb_dato_operacion' and column_name = 'do_fecha_pri_vto'   )   alter table sb_dato_operacion    add do_fecha_pri_vto    datetime  go
go


if not exists (select 1  from   INFORMATION_SCHEMA.COLUMNS  where  table_name = 'sb_dato_operacion_tmp' and column_name = 'do_cupo_original')   alter table  sb_dato_operacion_tmp   add do_cupo_original    money     go
if not exists (select 1  from   INFORMATION_SCHEMA.COLUMNS  where  table_name = 'sb_dato_operacion_tmp' and column_name = 'do_importe_ult_vto') alter table  sb_dato_operacion_tmp   add do_importe_ult_vto  money     go
if not exists (select 1  from   INFORMATION_SCHEMA.COLUMNS  where  table_name = 'sb_dato_operacion_tmp' and column_name = 'do_importe_pri_vto') alter table  sb_dato_operacion_tmp   add do_importe_pri_vto  money     go
if not exists (select 1  from   INFORMATION_SCHEMA.COLUMNS  where  table_name = 'sb_dato_operacion_tmp' and column_name = 'do_fecha_pri_vto')   alter table  sb_dato_operacion_tmp   add do_fecha_pri_vto    datetime  go
go


--src\be\activas\dependencias\installer\sql\cobex_table.sql

use cob_externos
go

if not exists (select 1  from   INFORMATION_SCHEMA.COLUMNS  where  table_name = 'ex_dato_operacion' and column_name = 'do_cupo_original')   alter table ex_dato_operacion    add do_cupo_original    money     go
if not exists (select 1  from   INFORMATION_SCHEMA.COLUMNS  where  table_name = 'ex_dato_operacion' and column_name = 'do_importe_ult_vto') alter table ex_dato_operacion    add do_importe_ult_vto  money      go
if not exists (select 1  from   INFORMATION_SCHEMA.COLUMNS  where  table_name = 'ex_dato_operacion' and column_name = 'do_importe_pri_vto') alter table ex_dato_operacion    add do_importe_pri_vto  money      go
if not exists (select 1  from   INFORMATION_SCHEMA.COLUMNS  where  table_name = 'ex_dato_operacion' and column_name = 'do_fecha_pri_vto')   alter table ex_dato_operacion    add do_fecha_pri_vto    datetime   go

go