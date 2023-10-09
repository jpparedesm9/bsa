use cobis
go

--CREACION DE PARAMETRO 
print'CREACION DE PARAMETRO'
if exists (select 1 from cobis..cl_parametro  where pa_nemonico = 'SENSI' and pa_producto = 'CCA')begin
   delete from cobis..cl_parametro  where pa_nemonico = 'SENSI' and pa_producto = 'CCA'  
end 

