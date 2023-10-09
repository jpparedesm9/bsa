--Caso197007 - Flujo B2B Grupal Paperless Fase 1
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
use cobis
go 

declare @w_tabla smallint

select @w_tabla = codigo from cobis..cl_tabla where tabla like 'cr_doc_digitalizado_ind'

--Antes
select *from cobis..cl_catalogo
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_doc_digitalizado_ind')


--Actualizando SOLICITUD CONTRATO
UPDATE cobis..cl_catalogo set valor='SOLICITUD CONTRATO' where codigo='008' and tabla=@w_tabla


--Despues
select *from cobis..cl_catalogo
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_doc_digitalizado_ind')
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

go
