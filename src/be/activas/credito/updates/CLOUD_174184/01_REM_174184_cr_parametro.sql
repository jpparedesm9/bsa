use cobis
go

--antes de modificacion
select * from cobis..cl_parametro
where pa_nemonico='RDRECA' and pa_producto='CRE'

update cl_parametro
set pa_char = '14795-439-034696/01-02147-0621'
where pa_nemonico = 'RDRECA' and pa_producto = 'CRE'

--despues de modificacion
select * from cobis..cl_parametro
where pa_nemonico='RDRECA' and pa_producto='CRE'


--antes de insercion nuevo parametro
if not exists (select 1 from cobis..cl_parametro WHERE pa_nemonico = 'REPCRI' and pa_producto = 'CRE')
begin
    insert into cl_parametro values('REPORTE PIE CREDITO INDIVIDUAL', 'REPCRI', 'C', 'JUR-970 (112021)', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
end

--despues de insercion
select * from cobis..cl_parametro
where pa_nemonico='REPCRI' and pa_producto='CRE'


--antes de insercion nuevo parametro
if not exists (select 1 from cobis..cl_parametro WHERE pa_nemonico = 'RPSCRI' and pa_producto = 'CRE')
begin
    insert into cl_parametro values('REPORTE PIE SOLICITUD CREDITO INDIVIDUAL', 'RPSCRI', 'C', 'IF-038 (112021)', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
end

--despues de insercion
select * from cobis..cl_parametro
where pa_nemonico='RPSCRI' and pa_producto='CRE'

go
