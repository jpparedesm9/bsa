use cobis
go

select 'antes', * from cobis..cl_parametro where pa_nemonico = 'RNRECA' and pa_producto = 'CRE'
select 'antes', * from cobis..cl_parametro where pa_nemonico = 'PPREPR' and pa_producto = 'CRE'
--     'antes', 
select 'antes', * from cobis..cl_parametro where pa_nemonico = 'PPREPL' and pa_producto = 'CRE'
-------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>--------------------------------------
if exists (select 1 from cobis..cl_parametro where pa_nemonico = 'RNRECA' and pa_producto = 'CRE')
    update cobis..cl_parametro set pa_char = '14795-439-034275/01-00897-0321' where pa_nemonico = 'RNRECA' and pa_producto = 'CRE'
else
    insert into cl_parametro values ('REPORTE DATO RECA RENOVACION', 'RNRECA', 'C', '14795-439-034275/01-00897-0321', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')


if exists (select 1 from cobis..cl_parametro where pa_nemonico = 'PPREPR' and pa_producto = 'CRE')
    update cobis..cl_parametro set pa_char = '(JUR-963)' where pa_nemonico = 'PPREPR' and pa_producto = 'CRE'
else
    insert into cl_parametro values ('PIE PERIODO RENOVACIONES', 'PPREPR', 'C', '(JUR-963)', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
	
-------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>--------------------------------------
if exists (select 1 from cobis..cl_parametro where pa_nemonico = 'PPREPL' and pa_producto = 'CRE')
    update cobis..cl_parametro set pa_char = '-(042021)' where pa_nemonico = 'PPREPL' and pa_producto = 'CRE'
else
    insert into cl_parametro values ('PIE PERIODO RENOVACIONES PIE LEGAL', 'PPREPL', 'C', '-(042021)', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

-------------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>--------------------------------------
select 'despues', * from cobis..cl_parametro where pa_nemonico = 'RNRECA'
select 'despues', * from cobis..cl_parametro where pa_nemonico = 'PPREPR'
--     'despues',
select 'despues', * from cobis..cl_parametro where pa_nemonico = 'PPREPL'
go
