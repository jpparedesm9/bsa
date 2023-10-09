use cobis
go

-- SMS COBRANZAS 
select * from cobis..cl_parametro where pa_nemonico in ('TRESC')

update cobis..cl_parametro
set pa_tinyint = 250
where pa_nemonico in ('TRESC')

select * from cobis..cl_parametro where pa_nemonico in ('TRESC')

--SMS RECORDATORIOS
select * from cobis..cl_parametro where pa_nemonico in ('TRESR')

update cobis..cl_parametro
set pa_tinyint = 250
where pa_nemonico in ('TRESR')

select * from cobis..cl_parametro where pa_nemonico in ('TRESR')