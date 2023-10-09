use cob_externos
go

if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_iva_int' and  c1.table_name = 'ex_dato_operacion_abono')
	alter table ex_dato_operacion_abono add doa_iva_int      MONEY 
go
if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_imo' and  c1.table_name = 'ex_dato_operacion_abono')
	alter table ex_dato_operacion_abono add doa_imo          MONEY 
go
if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_iva_imo' and  c1.table_name = 'ex_dato_operacion_abono')
	alter table ex_dato_operacion_abono add doa_iva_imo      MONEY 
go
if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_disp' and  c1.table_name = 'ex_dato_operacion_abono')
	alter table ex_dato_operacion_abono add doa_disp         MONEY 
go
if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_iva_disp' and  c1.table_name = 'ex_dato_operacion_abono')
	alter table ex_dato_operacion_abono add doa_iva_disp     MONEY 
go
if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_objetado' and  c1.table_name = 'ex_dato_operacion_abono')
	alter table ex_dato_operacion_abono add doa_objetado     VARCHAR(10) 
go
if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_sec_rpa' and  c1.table_name = 'ex_dato_operacion_abono')
	alter table ex_dato_operacion_abono add doa_sec_rpa      INT 
go
if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_tipo_trn' and  c1.table_name = 'ex_dato_operacion_abono')
	alter table ex_dato_operacion_abono add doa_tipo_trn     VARCHAR(10) 
go

use cob_conta_super
go

if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_iva_int' and  c1.table_name = 'sb_dato_operacion_abono')
	alter table sb_dato_operacion_abono add doa_iva_int      MONEY 
go
if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_imo' and  c1.table_name = 'sb_dato_operacion_abono')
	alter table sb_dato_operacion_abono add doa_imo          MONEY 
go
if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_iva_imo' and  c1.table_name = 'sb_dato_operacion_abono')
	alter table sb_dato_operacion_abono add doa_iva_imo      MONEY 
go
if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_disp' and  c1.table_name = 'sb_dato_operacion_abono')
	alter table sb_dato_operacion_abono add doa_disp         MONEY 
go
if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_iva_disp' and  c1.table_name = 'sb_dato_operacion_abono')
	alter table sb_dato_operacion_abono add doa_iva_disp     MONEY 
go
if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_objetado' and  c1.table_name = 'sb_dato_operacion_abono')
	alter table sb_dato_operacion_abono add doa_objetado     VARCHAR(10) 
go

if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_sec_rpa' and  c1.table_name = 'sb_dato_operacion_abono')
	alter table sb_dato_operacion_abono add doa_sec_rpa      INT 
go

if not exists(select 1 FROM INFORMATION_SCHEMA.COLUMNS AS c1 where c1.column_name = 'doa_tipo_trn' and  c1.table_name = 'sb_dato_operacion_abono')
	alter table sb_dato_operacion_abono add doa_tipo_trn     VARCHAR(10) 
go

USE cobis
GO
DELETE FROM cobis..cl_parametro
WHERE pa_producto = 'CCA'
AND pa_nemonico = 'AB_OBJ'


INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('FORMA DE PAGO PARA ABONOS OBJETADOS', 'AB_OBJ', 'C', 'FP_OBJETADO', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
GO

SELECT * FROM cobis..cl_parametro
WHERE pa_producto = 'CCA'
AND pa_nemonico = 'AB_OBJ'

GO




