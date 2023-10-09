--Caso197007 - Flujo B2B Grupal Paperless Fase 1
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
use cobis
go

--Antes
select * from cobis..cl_parametro
where pa_nemonico in ('RDRECA', 'RECASG', 'PPREPA', 'RSCGPI', 'RSCGRE', 'LPGCC4')


update cobis..cl_parametro 
set pa_char = '14795-439-028351/03-00011-0123'
where pa_nemonico in ('RDRECA', 'RECASG', 'RSCGRE')

update cobis..cl_parametro 
set pa_char = '(012023)'
where pa_nemonico in ('PPREPA')

update cobis..cl_parametro 
set pa_char = 'IF-001 (012023)'
where pa_nemonico in ('RSCGPI')

update cobis..cl_parametro 
set pa_char = 'Alcaldía Álvaro Obregón,'
where pa_nemonico in ('LPGCC4')


--Despues
select * from cobis..cl_parametro
where pa_nemonico in ('RDRECA', 'RECASG', 'PPREPA', 'RSCGPI', 'RSCGRE', 'LPGCC4')

go
