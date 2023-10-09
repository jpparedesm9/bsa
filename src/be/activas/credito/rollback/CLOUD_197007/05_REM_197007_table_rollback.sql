--Caso197007 - Flujo B2B Grupal Paperless Fase 1
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
use cob_credito 
go 

--Antes
select * from cob_credito..cr_reporte_on_boarding
where ra_cod_documento in ('126', '127', '128')


--Actualizacion Registros de Documentos
--CERTIFICADO CONSENTIMIENTO
--CERTIFICADO ASISTENCIA MEDICA
--CERTIFICADO ASISTENCIA FUNERARIA
update cr_reporte_on_boarding 
set ra_carpeta = null,
    ra_est_carga_alfresco = 'N',
	ra_cod_tipo_doc_cstmr = null
where ra_cod_documento in ('126', '127', '128')


--Despues
select * from cob_credito..cr_reporte_on_boarding
where ra_cod_documento in ('126', '127', '128')
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

go
