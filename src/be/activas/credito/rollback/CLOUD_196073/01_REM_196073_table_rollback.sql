--Caso196073 - Envio de documentos digitales rollback
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Tabla de Canales
use cobis
go

if object_id ('dbo.cl_canal') is not null
  drop table dbo.cl_canal
go
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--ANTES
select * from cob_credito..cr_reporte_on_boarding

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Agregado de Campos
use cob_credito
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_est_des_alfresco')
begin
  alter table cob_credito..cr_reporte_on_boarding drop column ra_est_des_alfresco 
end
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_canal')
begin
  alter table cob_credito..cr_reporte_on_boarding drop column ra_canal 
end
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_carpeta')
begin
  alter table cob_credito..cr_reporte_on_boarding drop column ra_carpeta 
end
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_codigo_tipo_doc')
begin
  alter table cob_credito..cr_reporte_on_boarding drop column ra_codigo_tipo_doc 
end
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Nuevos Registros de Documentos
use cob_credito
go

delete from cr_reporte_on_boarding where ra_cod_documento 
in ('109', '110', '111', '112', '113', '114', '115', '116', '117', '118', '119', '120', '121')
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

--DESPUES
select * from cr_reporte_on_boarding
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Agregado de Campos Tabla Detalle
use cob_credito
go

--ANTES
select * from cob_credito..cr_cli_reporte_on_boarding_det

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_est_des_alfresco')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det drop column cod_est_des_alfresco 
end
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_canal')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det drop column cod_canal 
end
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_id_inst_proc')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det drop column cod_id_inst_proc 
end
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_grupo')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det drop column cod_grupo 
end
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_carpeta')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det drop column cod_carpeta 
end
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_nombre_doc')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det drop column cod_nombre_doc 
end
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_codigo_tipo_doc')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det drop column cod_codigo_tipo_doc 
end

--DESPUES
select * from cr_cli_reporte_on_boarding_det
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

go
