use cob_externos
go


if exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_iva_int' and  c1.table_name = 'ex_dato_operacion_abono')

	alter table ex_dato_operacion_abono drop column doa_iva_int      
go
if exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_imo' and  c1.table_name = 'ex_dato_operacion_abono')
	alter table ex_dato_operacion_abono drop column doa_imo         
go
if exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_iva_imo' and  c1.table_name = 'ex_dato_operacion_abono')
	alter table ex_dato_operacion_abono drop column doa_iva_imo     
go
if exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_disp' and  c1.table_name = 'ex_dato_operacion_abono')
	alter table ex_dato_operacion_abono drop column doa_disp         
go
if exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_iva_disp' and  c1.table_name = 'ex_dato_operacion_abono')
	alter table ex_dato_operacion_abono drop column doa_iva_disp     
go
if exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_objetado' and  c1.table_name = 'ex_dato_operacion_abono')
	alter table ex_dato_operacion_abono drop column doa_objetado     
go
if exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_sec_rpa' and  c1.table_name = 'ex_dato_operacion_abono')
	alter table ex_dato_operacion_abono drop column doa_sec_rpa      
go
if exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_tipo_trn' and  c1.table_name = 'ex_dato_operacion_abono')
	alter table ex_dato_operacion_abono drop column doa_tipo_trn   
go

use cob_conta_super
go

if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_iva_int' and  c1.table_name = 'sb_dato_operacion_abono')
	alter table sb_dato_operacion_abono drop column doa_iva_int     
go
if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_imo' and  c1.table_name = 'sb_dato_operacion_abono')
	alter table sb_dato_operacion_abono drop column doa_imo         
go
if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_iva_imo' and  c1.table_name = 'sb_dato_operacion_abono')
	alter table sb_dato_operacion_abono drop column doa_iva_imo      
go
if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_disp' and  c1.table_name = 'sb_dato_operacion_abono')
	alter table sb_dato_operacion_abono drop column doa_disp         
go
if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_iva_disp' and  c1.table_name = 'sb_dato_operacion_abono')
	alter table sb_dato_operacion_abono drop column doa_iva_disp     
go
if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_objetado' and  c1.table_name = 'sb_dato_operacion_abono')
	alter table sb_dato_operacion_abono drop column doa_objetado     
go

if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_sec_rpa' and  c1.table_name = 'sb_dato_operacion_abono')
	alter table sb_dato_operacion_abono drop column doa_sec_rpa     
go

if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_tipo_trn' and  c1.table_name = 'sb_dato_operacion_abono')
	alter table sb_dato_operacion_abono drop column doa_tipo_trn    
go

USE cobis
GO
DELETE FROM cobis..cl_parametro
WHERE pa_producto = 'CCA'
AND pa_nemonico = 'AB_OBJ'

GO
