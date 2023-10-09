
update cobis..cl_parametro set pa_char = '14795-439-028351/02-00343-0119'
where pa_nemonico = 'RDRECA' and pa_producto = 'CRE'

update cobis..cl_parametro set pa_char = '14795-439-028351/02-00343-0119'
where pa_nemonico = 'NRGCCI' and pa_producto = 'CRE'

update cobis..cl_parametro set pa_int = 6 
where pa_nemonico = 'MINIGR'

update cobis..cl_parametro set pa_float = 60 
where pa_nemonico='PMGRU' and pa_producto = 'CRE'