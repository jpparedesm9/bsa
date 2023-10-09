use cobis
go

update cobis..cl_parametro
set pa_int = 5
where  pa_nemonico = 'DGRFNB'
and    pa_producto = 'CCA'

go
