--------------------------------------------------------------------------------------------
-- BORRAR TABLA
--------------------------------------------------------------------------------------------

use cob_conta_super
go
IF OBJECT_ID ('dbo.sb_riesgo_hrc_lcr') IS NOT NULL
    DROP TABLE dbo.sb_riesgo_hrc_lcr
GO

--------------------------------------------------------------------------------------------
-- BORRAR SECTOR
--------------------------------------------------------------------------------------------
use cobis
go

declare @w_cod_sector  int
select @w_cod_sector = codigo from cobis..cl_tabla where tabla = 'cl_sector_economico'

if exists(select * from cobis..cl_catalogo where valor = 'INDUSTRIA' and tabla = @w_cod_sector)
   delete cobis..cl_catalogo where valor = 'INDUSTRIA' and tabla = @w_cod_sector


--------------------------------------------------------------------------------------------
-- QUITAR CAMPOS
--------------------------------------------------------------------------------------------
use cobis
go

--CAMBIAR TIPO DE DATO DE PUNTAJE
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'acg_codigo_generica ' and TABLE_NAME = 'cl_actividad_generica')
    alter table cobis..cl_actividad_generica drop column acg_codigo_generica

--------------------------------------------------------------------------------------------
-- QUITAR CAMPOS CONSOLIDADOR
--------------------------------------------------------------------------------------------

use cob_externos
go
 
if exists (select 1  from   INFORMATION_SCHEMA.COLUMNS where  table_name = 'ex_dato_operacion' and column_name = 'do_fecha_ult_vto')
	alter table ex_dato_operacion drop column do_fecha_ult_vto

if exists (select 1  from   INFORMATION_SCHEMA.COLUMNS where  table_name = 'ex_dato_operacion' and column_name = 'do_cuota_ult_vto')
	alter table ex_dato_operacion drop column do_cuota_ult_vto

if exists (select 1  from   INFORMATION_SCHEMA.COLUMNS where  table_name = 'ex_dato_operacion' and column_name = 'do_tipo_amortizacion')
	alter table ex_dato_operacion drop column do_tipo_amortizacion
 

use cob_conta_super
go

if exists (select 1  from   INFORMATION_SCHEMA.COLUMNS where  table_name = 'sb_dato_operacion' and column_name = 'do_fecha_ult_vto')
	alter table sb_dato_operacion drop column do_fecha_ult_vto

if exists (select 1  from   INFORMATION_SCHEMA.COLUMNS where  table_name = 'sb_dato_operacion' and column_name = 'do_cuota_ult_vto')
	alter table sb_dato_operacion drop column do_cuota_ult_vto

if exists (select 1  from   INFORMATION_SCHEMA.COLUMNS where  table_name = 'sb_dato_operacion' and column_name = 'do_tipo_amortizacion')
	alter table sb_dato_operacion drop column do_tipo_amortizacion

if exists (select 1  from   INFORMATION_SCHEMA.COLUMNS where  table_name = 'sb_dato_operacion_tmp' and column_name = 'do_fecha_ult_vto')
	alter table sb_dato_operacion_tmp drop column do_fecha_ult_vto

if exists (select 1  from   INFORMATION_SCHEMA.COLUMNS where  table_name = 'sb_dato_operacion_tmp' and column_name = 'do_cuota_ult_vto')
	alter table sb_dato_operacion_tmp drop column do_cuota_ult_vto

if exists (select 1  from   INFORMATION_SCHEMA.COLUMNS where  table_name = 'sb_dato_operacion_tmp' and column_name = 'do_tipo_amortizacion')
	alter table sb_dato_operacion_tmp drop column do_tipo_amortizacion

go
--Elimar batch
use cobis
go
delete from cobis..ba_batch where ba_batch=36431
go