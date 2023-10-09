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
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '010', 'CERTIFICADO DE CONSENTIMIENTO (SEGURO)', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '011', 'CERTIFICADO ASISTENCIA FUNERARIA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '012', 'CERTIFICADO ASISTENCIA MÉDICA', 'V')


--Despues
select *from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cr_doc_digitalizado')
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

go

