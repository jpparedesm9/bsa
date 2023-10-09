--Caso197007 - Flujo B2B Grupal Paperless Fase 1
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
use cob_credito
go

--ROLLBACK AGREGADO DE CAMPOS TABLA PRINCIPAL
--Antes
select * from cob_credito..cr_reporte_on_boarding

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_orden_unif')
begin
  alter table cob_credito..cr_reporte_on_boarding drop column ra_orden_unif 
end

--Despues
select * from cob_credito..cr_reporte_on_boarding


-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
use cob_credito
go

--ROLLBACK AGREGADO DE CAMPOS TABLA DETALLE
--Antes
select * from cob_credito..cr_cli_reporte_on_boarding_det

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_orden_unif')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det drop column cod_orden_unif 
end

--Despues
select * from cr_cli_reporte_on_boarding_det
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
go
