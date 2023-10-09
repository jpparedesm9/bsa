use cobis
go 

--Antes
select top 1 * from cobis..cl_ente_aux

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cl_ente_aux' and COLUMN_NAME = 'ea_nivel_riesgo_1')
begin
  alter table cobis..cl_ente_aux drop column ea_nivel_riesgo_1 
end

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cl_ente_aux' and COLUMN_NAME = 'ea_nivel_riesgo_2')
begin
  alter table cobis..cl_ente_aux drop column ea_nivel_riesgo_2 
end

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cl_ente_aux' and COLUMN_NAME = 'ea_tipo_calif_eva_cli')
begin
  alter table cobis..cl_ente_aux drop column ea_tipo_calif_eva_cli
end

--Despues
select top 1 * from cobis..cl_ente_aux


--->>>>>>>>>>>>>>>>>>>Requerimiento #203112 OT Modelo Aceptación Grupal, BC
use cob_credito
go

print 'ROLLBACK CREACION TABLA: cr_vigencia_tipo_calif'
if object_id ('dbo.cr_vigencia_tipo_calif') is not null
	drop table dbo.cr_vigencia_tipo_calif
go


--->>>>>>>>>>>>>>>>>>>Requerimiento #203112 OT Modelo Aceptación Grupal, BC
use cob_credito_his
go

print 'ROLLBACK CREACION TABLA: cr_vigencia_tipo_calif_his'
if object_id ('dbo.cr_vigencia_tipo_calif_his') is not null
	drop table dbo.cr_vigencia_tipo_calif_his
go

go
