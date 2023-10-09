
USE cob_externos
GO
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'ex_dato_operacion_abono')
	DROP TABLE ex_dato_operacion_abono
GO

USE cob_conta_super
GO
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'sb_dato_operacion_abono')
	DROP TABLE sb_dato_operacion_abono
GO

use cob_conta_super
go
if exists(select 1 from sysobjects where name = 'sb_dato_operacion_abono_temp ')
    drop table sb_dato_operacion_abono_temp
go


use cob_conta_super
go


alter table sb_rpt_buro_frmt_act_parc
alter column rf_limit_cred varchar(2) null
go

if exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'do_monto_aprobado'
              and  c1.table_name = 'sb_dato_operacion_tmp')
begin 
    alter table sb_dato_operacion_tmp
    drop column do_monto_aprobado 
end
go


if exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'do_monto_aprobado'
              and  c1.table_name = 'sb_dato_operacion')
begin
    alter table sb_dato_operacion
    drop  column do_monto_aprobado
end
go

alter table sb_reporte_buro_cuentas
alter column [23] varchar(3) null
go


use cob_externos
go


if  exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'do_monto_aprobado'
              and  c1.table_name = 'ex_dato_operacion')
begin
    alter table ex_dato_operacion
    drop column  do_monto_aprobado 
end
go