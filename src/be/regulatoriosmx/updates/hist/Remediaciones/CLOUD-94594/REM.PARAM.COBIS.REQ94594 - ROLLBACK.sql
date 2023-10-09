use cobis
go
--BORRAR DE PARAMETRO 
print'BORRAR DE PARAMETRO'
if exists (select 1 from cobis..cl_parametro  where pa_nemonico = 'SEMBK' and pa_producto = 'CCA')begin
   delete from cobis..cl_parametro  where pa_nemonico = 'SEMBK' and pa_producto = 'CCA'  
end 

