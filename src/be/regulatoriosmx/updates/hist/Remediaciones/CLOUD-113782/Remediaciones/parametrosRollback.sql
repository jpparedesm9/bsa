
update cobis..cl_parametro set pa_char = '14795-439-028351/01-06036-1117'
where pa_nemonico = 'RDRECA' and pa_producto = 'CRE'

update cobis..cl_parametro 
   set pa_float = 80 
   where pa_nemonico='PMGRU'  
   and pa_producto = 'CRE'