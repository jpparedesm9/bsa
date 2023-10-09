--Caso197007 - Flujo B2B Grupal Paperless Fase 1
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
use cob_credito 
go 

--Antes
select * from cob_credito..cr_reporte_on_boarding
where ra_cod_documento in ('126', '127', '128')


--Actualizacion Registros de Documentos
--CERTIFICADO CONSENTIMIENTO
update cr_reporte_on_boarding 
set ra_carpeta = 'Customer',
    ra_est_carga_alfresco = 'S',
	ra_cod_tipo_doc_cstmr = '010'
where ra_cod_documento = '126'

--CERTIFICADO ASISTENCIA MEDICA
update cr_reporte_on_boarding 
set ra_carpeta = 'Customer',
    ra_est_carga_alfresco = 'S',
	ra_cod_tipo_doc_cstmr = '012'
where ra_cod_documento = '127'

--CERTIFICADO ASISTENCIA FUNERARIA
update cr_reporte_on_boarding 
set ra_carpeta = 'Customer',
    ra_est_carga_alfresco = 'S',
	ra_cod_tipo_doc_cstmr = '011'
where ra_cod_documento = '128'


--Despues
select * from cob_credito..cr_reporte_on_boarding
where ra_cod_documento in ('126', '127', '128')
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

go
