--Caso197007 - Flujo B2B Grupal Paperless Fase 1
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
use cob_credito
go

--Antes
select * from cob_credito..cr_reporte_on_boarding
where ra_cod_documento = 125


--Actualizacion Registros de Documentos
update cr_reporte_on_boarding 
set ra_carpeta = 'Customer',
    ra_est_carga_alfresco = 'S',
	ra_cod_tipo_doc_cstmr = '013'
where ra_cod_documento = 125


--Antes
select * from cob_credito..cr_reporte_on_boarding
where ra_cod_documento = 125
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

go

