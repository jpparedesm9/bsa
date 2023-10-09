--Caso197007 - Flujo B2B Grupal Paperless Fase 1 rollback
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--ANTES
select * from cob_credito..cr_reporte_on_boarding

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Rollback Agregado de Campos Tabla Principal
use cob_credito
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_est_carga_alfresco')
begin
  alter table cob_credito..cr_reporte_on_boarding drop column ra_est_carga_alfresco 
end
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_est_eliminar_doc')
begin
  alter table cob_credito..cr_reporte_on_boarding drop column ra_est_eliminar_doc 
end
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_tiempo_vig_doc')
begin
  alter table cob_credito..cr_reporte_on_boarding drop column ra_tiempo_vig_doc 
end
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_cod_tipo_doc_cstmr')
begin
  alter table cob_credito..cr_reporte_on_boarding drop column ra_cod_tipo_doc_cstmr 
end
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_estado')
begin
  alter table cob_credito..cr_reporte_on_boarding drop column ra_estado 
end
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_grp_unif')
begin
  alter table cob_credito..cr_reporte_on_boarding drop column ra_grp_unif 
end
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Nuevos Registros de Documentos
use cob_credito
go

delete from cr_reporte_on_boarding where ra_cod_documento 
in ('122', '123', '124', '125', '126', '127', '128')
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

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_est_carga_alfresco')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det drop column cod_est_carga_alfresco 
end
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_est_eliminar_doc')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det drop column cod_est_eliminar_doc 
end
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_id_inst_act')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det drop column cod_id_inst_act 
end
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_cod_tipo_doc_cstmr')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det drop column cod_cod_tipo_doc_cstmr 
end
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_grp_unif')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det drop column cod_grp_unif 
end

--DESPUES
select * from cr_cli_reporte_on_boarding_det
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
use cob_cartera
go

if object_id ('dbo.ca_rep_info_des') is not null
	drop table dbo.ca_rep_info_des
go
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

go
