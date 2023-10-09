---------------------------------------------------------------------------------------------------------
--------------*****************
---------------------------------------------------------------------------------------------------------
--RECA
select * from cobis..cl_parametro where pa_nemonico = 'RDADHR' and pa_producto = 'CRE'

update cobis..cl_parametro set pa_char = '14795-440-030864/03-04067-0919'
where pa_nemonico = 'RDADHR' and pa_producto = 'CRE'

--------------*****************
---------------------------------------------------------------------------------------------------------
select * from cobis..cl_parametro where pa_nemonico = 'PPREPA' and pa_producto = 'CRE'

update cobis..cl_parametro set pa_char = '(032019)'
where pa_nemonico = 'PPREPA' and pa_producto = 'CRE'

--------------*****************
---------------------------------------------------------------------------------------------------------
