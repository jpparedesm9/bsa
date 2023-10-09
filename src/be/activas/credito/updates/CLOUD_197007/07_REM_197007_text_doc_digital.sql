--Caso197007 - Flujo B2B Grupal Paperless Fase 1
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
use cobis
go 

declare @w_tabla smallint

select @w_tabla = codigo from cobis..cl_tabla where tabla like 'cr_txt_documento'

--Antes
select *from cobis..cl_catalogo
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_txt_documento')


--Actualizando CREDITO GRUPAL
UPDATE cobis..cl_catalogo set valor='CRÉDITO GRUPAL' where codigo='GPNCT01'and tabla=@w_tabla


--Despues
select *from cobis..cl_catalogo
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_txt_documento')
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

go

