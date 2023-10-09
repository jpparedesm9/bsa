--Caso197007 - Flujo B2B Grupal Paperless Fase 1
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
use cobis
go 

declare @w_tabla smallint

select @w_tabla = codigo from cobis..cl_tabla where tabla like 'cr_doc_digitalizado'

--Antes
select *from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_doc_digitalizado')


--Agregado Nuevos Registros
delete from cobis..cl_catalogo 
where tabla = @w_tabla
and codigo in ('010','011', '012')


--Despues
select *from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_doc_digitalizado')
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

go
