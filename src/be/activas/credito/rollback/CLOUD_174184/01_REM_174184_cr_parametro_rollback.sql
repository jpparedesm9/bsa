use cobis
go

--antes de modificacion
select * from cobis..cl_parametro
where pa_nemonico='RDRECA' and pa_producto='CRE'

update cl_parametro
set pa_char = '14795-439-028351/01-01227-0420'
where pa_nemonico = 'RDRECA' and pa_producto = 'CRE'

--despues de modificacion
select * from cobis..cl_parametro
where pa_nemonico='RDRECA' and pa_producto='CRE'


--antes de borrado nuevo parametro
select * from cobis..cl_parametro
where pa_nemonico='RPSCRI' and pa_producto='CRE'

--borrado de nuevo parametro
if exists (select 1 from cobis..cl_parametro WHERE pa_nemonico = 'RPSCRI' and pa_producto = 'CRE')
begin
    delete from cobis..cl_parametro
    where pa_nemonico='RPSCRI' and pa_producto='CRE'
end

--despues de insercion
select * from cobis..cl_parametro
where pa_nemonico='RPSCRI' and pa_producto='CRE'


--antes de borrado nuevo parametro
select * from cobis..cl_parametro
where pa_nemonico='REPCRI' and pa_producto='CRE'

--borrado de nuevo parametro
if exists (select 1 from cobis..cl_parametro WHERE pa_nemonico = 'REPCRI' and pa_producto = 'CRE')
begin
    delete from cobis..cl_parametro
    where pa_nemonico='REPCRI' and pa_producto='CRE'
end

--despues de insercion
select * from cobis..cl_parametro
where pa_nemonico='REPCRI' and pa_producto='CRE'

go
