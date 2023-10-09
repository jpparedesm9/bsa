--Caso197007 - Flujo B2B Grupal Paperless Fase 1
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
use cobis
go

--Antes
select * from cobis..cl_parametro
where pa_nemonico in ('RDRECA', 'RECASG', 'PPREPA', 'RSCGPI', 'RSCGRE', 'LPGCC4')


update cobis..cl_parametro 
set pa_char = '14795-439-034696/01-02147-0621'
where pa_nemonico in ('RDRECA')

update cobis..cl_parametro 
set pa_char = '14795-439-028351/02-00343-0119'
where pa_nemonico in ('RECASG')

update cobis..cl_parametro 
set pa_char = '14795-439-028351/02-00343-0119'
where pa_nemonico in ('RSCGRE')

update cobis..cl_parametro 
set pa_char = '(112021)'
where pa_nemonico in ('PPREPA')

update cobis..cl_parametro 
set pa_char = 'IF-001 (102021)'
where pa_nemonico in ('RSCGPI')

update cobis..cl_parametro 
set pa_char = 'Delegación Álvaro Obregón,'
where pa_nemonico in ('LPGCC4')


--Despues
select * from cobis..cl_parametro
where pa_nemonico in ('RDRECA', 'RECASG', 'PPREPA', 'RSCGPI', 'RSCGRE', 'LPGCC4')

go
