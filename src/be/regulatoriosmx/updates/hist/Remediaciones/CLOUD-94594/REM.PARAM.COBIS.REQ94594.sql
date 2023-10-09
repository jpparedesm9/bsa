use cobis
go

--CREACION DE PARAMETRO 
print'CREACION DE PARAMETRO'
if exists (select 1 from cobis..cl_parametro  where pa_nemonico = 'SEMBK' and pa_producto = 'CCA')begin
   delete from cobis..cl_parametro  where pa_nemonico = 'SEMBK' and pa_producto = 'CCA'  
end 

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE SEMANAS PARA BACKUP (SEMBK)', 'SEMBK', 'T', NULL, 2, NULL, NULL, NULL, NULL, NULL, 'CCA')
