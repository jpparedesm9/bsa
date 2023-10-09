use cob_credito 
go 
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Agregado de Campos Tabla Cabecera

--Antes
select top 1 * from cob_credito..cr_cli_reporte_on_boarding

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cr_cli_reporte_on_boarding' and COLUMN_NAME = 'co_fecha_reg')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding add co_fecha_reg datetime
end

--Despues
select top 1 * from cob_credito..cr_cli_reporte_on_boarding
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>


-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Agregado de Campos Tabla Detalle

--Antes
select top 1 * from cob_credito..cr_cli_reporte_on_boarding_det

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_fecha_reg')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det add cod_fecha_reg datetime
end

--Despues
select top 1 * from cob_credito..cr_cli_reporte_on_boarding_det
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>


go
