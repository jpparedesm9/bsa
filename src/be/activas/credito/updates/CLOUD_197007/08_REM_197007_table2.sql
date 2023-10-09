--Caso197007 - Flujo B2B Grupal Paperless Fase 1
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
use cob_credito
go

--Antes
select * from cob_credito..cr_reporte_on_boarding


--AGREGADO DE CAMPOS TABLA PRINCIPAL
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_orden_unif')
begin
  alter table cob_credito..cr_reporte_on_boarding add ra_orden_unif int
end

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
use cob_credito
go

--ACTUALIZACION REGISTROS DE DOCUMENTOS
--CONTRATO GRUPAL
update cr_reporte_on_boarding 
set ra_orden_unif = 1
where ra_cod_documento = '122'

--CARATULA DE CREDITO GRUPAL
update cr_reporte_on_boarding 
set ra_orden_unif = 2
where ra_cod_documento = '123'

--TABLA DE AMORTIZACION GRUPAL
update cr_reporte_on_boarding 
set ra_orden_unif = 3
where ra_cod_documento = '124'

--FICHA DE PAGO GRUPAL
update cr_reporte_on_boarding 
set ra_orden_unif = 4
where ra_cod_documento = '113'

--CERTIFICADO CONSENTIMIENTO
update cr_reporte_on_boarding 
set ra_orden_unif = 1
where ra_cod_documento = '126'

--CERTIFICADO ASISTENCIA FUNERARIA
update cr_reporte_on_boarding 
set ra_orden_unif = 2
where ra_cod_documento = '128'

--CERTIFICADO ASISTENCIA MEDICA
update cr_reporte_on_boarding 
set ra_orden_unif = 3
where ra_cod_documento = '127'


--Despues
select * from cob_credito..cr_reporte_on_boarding


-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
use cob_credito
go

--AGREGADO DE CAMPOS TABLA DETALLE
--Antes
select * from cob_credito..cr_cli_reporte_on_boarding_det

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_orden_unif')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det add cod_orden_unif int
end

--Despues
select * from cr_cli_reporte_on_boarding_det
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
go
