
---------------------------------------------------------------------------------------
--------------------------AGREGAR CAMPO PARA REPORTES        --------------------------
---------------------------------------------------------------------------------------
use cobis
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'gr_dias_atraso' and TABLE_NAME = 'cl_grupo')
begin
    alter table cobis..cl_grupo add gr_dias_atraso int null 
end
else
begin
	alter table cobis..cl_grupo alter column gr_dias_atraso int null 
end
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ea_experiencia' and TABLE_NAME = 'cl_ente_aux')
begin
    alter table cobis..cl_ente_aux ADD ea_experiencia char(1) null
end
else
begin
	alter table cobis..cl_ente_aux alter column ea_experiencia char(1) null
end
go



/****** Object:  Table [dbo].[cl_producto_santander]    Script Date: 09/05/2018 17:53:07 ******/
PRINT 'Create table cl_producto_santander'
IF OBJECT_ID ('dbo.cl_producto_santander') IS NULL
begin
      CREATE TABLE [dbo].[cl_producto_santander](
	[pr_ente] [int] NOT NULL,
	[pr_buc] [varchar](8) NOT NULL,
	[pr_numero_contrato] [varchar](12) NOT NULL,
	[pr_codigo_producto] [char](2) NOT NULL,
	[pr_codigo_subproducto] [char](4) NOT NULL,
	[pr_estado] [char](1) NOT NULL,
	[pr_codigo_moneda] [char](3) NOT NULL,
	[pr_fecha_consulta] [datetime] NOT NULL,
     CONSTRAINT [PK_cl_producto_santander] PRIMARY KEY CLUSTERED 
     (
	[pr_ente] ASC
     )
     )

end	
GO



GO


use cob_externos
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_cap' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion add do_cuota_cap money null 
end
else
begin
	alter table cob_externos..ex_dato_operacion alter column do_cuota_cap money null 
end
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_int' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion add do_cuota_int money null 
end
else
begin
	alter table cob_externos..ex_dato_operacion alter column do_cuota_int money null 
end
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_iva' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion add do_cuota_iva money null 
end
else
begin
	alter table cob_externos..ex_dato_operacion alter column do_cuota_iva money null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_suspenso' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion add do_fecha_suspenso datetime null 
end
else
begin
	alter table cob_externos..ex_dato_operacion alter column do_fecha_suspenso datetime null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuenta' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion add do_cuenta cuenta null 
end
else
begin
	alter table cob_externos..ex_dato_operacion alter column do_cuenta cuenta null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_venc_dividendo' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion add do_venc_dividendo int null 
end
else
begin
	alter table cob_externos..ex_dato_operacion alter column do_venc_dividendo int null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_plazo' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion add do_plazo varchar(64) null 
    
end
else
begin
	alter table cob_externos..ex_dato_operacion alter column do_plazo varchar(64) null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_aprob_tramite' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion add do_fecha_aprob_tramite datetime null 
    
end
else
begin
	alter table cob_externos..ex_dato_operacion alter column do_fecha_aprob_tramite datetime null 
end
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_subtipo_producto' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion add do_subtipo_producto varchar(64) null 
    
end
else
begin
	alter table cob_externos..ex_dato_operacion alter column do_subtipo_producto varchar(64) null 
end
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_atraso_grupal' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion add do_atraso_grupal int null 
    
end
else
begin
	alter table cob_externos..ex_dato_operacion alter column do_atraso_grupal int null 
end
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_dividendo_ven' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion add do_fecha_dividendo_ven datetime null 
    
end
else
begin
	alter table cob_externos..ex_dato_operacion alter column do_fecha_dividendo_ven datetime null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_min_vencida' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion add do_cuota_min_vencida money null 
    
end
else
begin
	alter table cob_externos..ex_dato_operacion alter column do_cuota_min_vencida money null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_tplazo' and TABLE_NAME = 'ex_dato_operacion')
begin
    alter table cob_externos..ex_dato_operacion add do_tplazo varchar(10) null 
    
end
else
begin
	alter table cob_externos..ex_dato_operacion alter column do_tplazo varchar(10) null
end
go

use cob_conta_super
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_cap' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion add do_cuota_cap money null 
end
else
begin
	alter table cob_conta_super..sb_dato_operacion alter column do_cuota_cap money null 
end
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_int' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion add do_cuota_int money null 
end
else
begin
	alter table cob_conta_super..sb_dato_operacion alter column do_cuota_int money null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_iva' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion add do_cuota_iva money null 
end
else
begin
	alter table cob_conta_super..sb_dato_operacion alter column do_cuota_iva money null 
end
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_suspenso ' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion add do_fecha_suspenso datetime null 
end
else
begin
	alter table cob_conta_super..sb_dato_operacion alter column do_fecha_suspenso datetime null 
end
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuenta ' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion add do_cuenta cuenta null 
end
else
begin
	alter table cob_conta_super..sb_dato_operacion alter column do_cuenta cuenta null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_venc_dividendo' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion add do_venc_dividendo int null 
end
else
begin
	alter table cob_conta_super..sb_dato_operacion alter column do_venc_dividendo int null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_plazo' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion add do_plazo varchar(64) null 
    
end
else
begin
	alter table cob_conta_super..sb_dato_operacion alter column do_plazo varchar(64) null 
end
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_aprob_tramite' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion add do_fecha_aprob_tramite datetime null 
    
end
else
begin
	alter table cob_conta_super..sb_dato_operacion alter column do_fecha_aprob_tramite datetime null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_subtipo_producto' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion add do_subtipo_producto varchar(64) null 
    
end
else
begin
	alter table cob_conta_super..sb_dato_operacion alter column do_subtipo_producto varchar(64) null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_atraso_grupal' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion add do_atraso_grupal int null 
    
end
else
begin
	alter table cob_conta_super..sb_dato_operacion alter column do_atraso_grupal int null 
end
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_dividendo_ven' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion add do_fecha_dividendo_ven datetime null 
    
end
else
begin
	alter table cob_conta_super..sb_dato_operacion alter column do_fecha_dividendo_ven datetime null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_operacion' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion add do_operacion int null 
    
end
else
begin
	alter table cob_conta_super..sb_dato_operacion alter column do_operacion int null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_min_vencida' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion add do_cuota_min_vencida money null 
    
end
else
begin
	alter table cob_conta_super..sb_dato_operacion alter column do_cuota_min_vencida money null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_tplazo' and TABLE_NAME = 'sb_dato_operacion')
begin
    alter table cob_conta_super..sb_dato_operacion add do_tplazo varchar(10) null 
    
end
else
begin
	alter table cob_conta_super..sb_dato_operacion alter column do_tplazo varchar(10) null
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_cap' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp add do_cuota_cap money null 
end
else
begin
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_cuota_cap money null 
end
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_int' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp add do_cuota_int money null 
end
else
begin
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_cuota_int money null 
end
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_iva' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp add do_cuota_iva money null 
end
else
begin
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_cuota_iva money null 
end
go



if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_suspenso ' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp add do_fecha_suspenso datetime null 
end
else
begin
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_fecha_suspenso datetime null 
end
go



if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuenta ' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp add do_cuenta cuenta null 
end
else
begin
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_cuenta cuenta null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_venc_dividendo' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp add do_venc_dividendo int null 
end
else
begin
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_venc_dividendo int null 
end
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_plazo' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp add do_plazo varchar(64) null     
end
else
begin
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_plazo varchar(64) null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_aprob_tramite' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp add do_fecha_aprob_tramite datetime null 
    
end
else
begin
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_fecha_aprob_tramite datetime null 
end
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_subtipo_producto' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp add do_subtipo_producto varchar(64) null 
    
end
else
begin
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_subtipo_producto varchar(64) null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_atraso_grupal' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp add do_atraso_grupal int null 
    
end
else
begin
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_atraso_grupal int null 
end
go


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_fecha_dividendo_ven' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp add do_fecha_dividendo_ven datetime null 
    
end
else
begin
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_fecha_dividendo_ven datetime null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_operacion' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp add do_operacion int null     
end
else
begin
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_operacion int null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_cuota_min_vencida' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp add do_cuota_min_vencida money null     
end
else
begin
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_cuota_min_vencida money null 
end
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'do_tplazo' and TABLE_NAME = 'sb_dato_operacion_tmp')
begin
    alter table cob_conta_super..sb_dato_operacion_tmp add do_tplazo varchar(10) null 
    
end
else
begin
	alter table cob_conta_super..sb_dato_operacion_tmp alter column do_tplazo varchar(10) null
end
go

