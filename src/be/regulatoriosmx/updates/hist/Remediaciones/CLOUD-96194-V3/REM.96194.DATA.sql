
use cobis
go

--CREACION DE PARAMETRO 
print'CREACION DE PARAMETRO'
if exists (select 1 from cobis..cl_parametro  where pa_nemonico = 'CAAPCU' and pa_producto = 'CCA')begin
   delete from cobis..cl_parametro  where pa_nemonico = 'CAAPCU' and pa_producto = 'CCA'  
end 

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO ACTIVIDAD APROBACION CUESTIONARIO', 'CAAPCU', 'I', NULL, NULL, NULL, 50, NULL, NULL, NULL, 'CCA')
GO


print'CREACION DE PARAMETRO'
if exists (select 1 from cobis..cl_parametro  where pa_nemonico = 'CFINSO' and pa_producto = 'CCA')begin
   delete from cobis..cl_parametro  where pa_nemonico = 'CFINSO' and pa_producto = 'CCA'  
end


INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('INGRESO DE SOLICITUD', 'CFINSO', 'I', NULL, NULL, NULL, 5, NULL, NULL, NULL, 'CCA')
GO
