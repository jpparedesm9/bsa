use cobis
go

--parametros antes de ser modificados
select * from cobis..cl_parametro
where pa_nemonico         = 'TTPREN'
and   pa_producto         = 'CRE'

select * from cobis..cl_parametro
where pa_nemonico         = 'PORREN'
and   pa_producto         = 'CRE'

--actualizacion
update cobis..cl_parametro
set pa_int = 12 
where pa_nemonico         = 'TTPREN'
and   pa_producto         = 'CRE'

update cobis..cl_parametro
set pa_float = 20 
where pa_nemonico         = 'PORREN'
and   pa_producto         = 'CRE'

--parametros despues de ser modificados
select * from cobis..cl_parametro
where pa_nemonico         = 'TTPREN'
and   pa_producto         = 'CRE'

select * from cobis..cl_parametro
where pa_nemonico         = 'PORREN'
and   pa_producto         = 'CRE'

go
