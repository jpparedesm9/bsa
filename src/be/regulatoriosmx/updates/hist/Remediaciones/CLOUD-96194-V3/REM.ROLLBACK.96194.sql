
use cobis
go

--CREACION DE PARAMETRO 
print'BORRADO DE PARAMETRO'
if exists (select 1 from cobis..cl_parametro  where pa_nemonico = 'CAAPCU' and pa_producto = 'CCA')begin
   delete from cobis..cl_parametro  where pa_nemonico = 'CAAPCU' and pa_producto = 'CCA'  
end 



print'BORRADO DE PARAMETRO'
if exists (select 1 from cobis..cl_parametro  where pa_nemonico = 'CFINSO' and pa_producto = 'CCA')begin
   delete from cobis..cl_parametro  where pa_nemonico = 'CFINSO' and pa_producto = 'CCA'  
end


